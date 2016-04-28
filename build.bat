@echo off

echo 删除原来的解析代码
rd /s /q CSharpFile
md CSharpFile

echo 正在生成解析代码
echo.

cd gen
call genbat.bat

echo.
echo 生成解析代码完毕

echo 删除原来的Dll文件
cd ..
rd /s /q DllFile
md DllFile

echo.
echo 复制项目描述文件
copy AssemblyInfo.cs CSharpFile

echo 生成数据结构dll
cd CSharpFile
C:\Windows\Microsoft.NET\Framework\v2.0.50727\Csc.exe /noconfig /warn:0 /optimize /nologo /reference:../protogen/protobuf-net.dll /out:../DllFile/PBMessage.dll /target:library *.cs 

echo 生成数据结构Dll完毕

echo 删除复制的项目描述文件
del ..\CSharpFile\AssemblyInfo.cs

echo.
echo 准备生成序列化dll
echo 复制引用dll
cd ..\protogen
copy protobuf-net.dll ..\DllFile

echo 预编译
cd ..\precompile
precompile ..\DllFile\PBMessage.dll -o:PBMessageSerializer.dll -t:PBMessageSerializer 

echo 生成序列化dll完毕
echo 移动序列化dll到文件夹
move PBMessageSerializer.dll ..\DllFile

echo 删除引用dll
del ..\DllFile\protobuf-net.dll

echo.
echo 生成全部dll成功

echo.
echo 将dll移到客户端项目中
echo f|xcopy ..\DllFile\PBMessage.dll ..\..\MyFrame\Assets\Test\Protobuf\\PBMessage.dll /d /y
echo f|xcopy ..\DllFile\PBMessageSerializer.dll ..\..\MyFrame\Assets\Test\Protobuf\PBMessageSerializer.dll /d /y


echo.

pause
exit