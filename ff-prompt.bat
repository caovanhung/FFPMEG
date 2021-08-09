@ECHO OFF
REM FF Prompt 1.2
REM Open a command prompt to run ffmpeg/ffplay/ffprobe
REM Copyright (C) 2013-2015  Kyle Schwarz
TITLE FF Prompt

IF NOT EXIST bin\ffmpeg.exe (
  CLS
  ECHO bin\ffmpeg.exe could not be found.
  GOTO:error
)

CD bin || GOTO:error
PROMPT $P$_$G
SET PATH=%CD%;%PATH%
CLS
ffmpeg -version
ECHO.
ECHO For help run: ffmpeg -h
ECHO For formats run: ffmpeg -formats ^| more
ECHO For codecs run: ffmpeg -codecs ^| more
ECHO.
ECHO Current directory is now: "%CD%"
ECHO The bin directory has been added to PATH
ECHO.

ffmpeg -y -ss 00:00:8 -i "input.mp4" -filter_complex "[0:v]scale=468:240,pad=476:260:4:10:color=yellow[v2]; movie=bg.mp4:loop=999,setpts=N/(FRAME_RATE*TB), scale=854:480[v3] ;[v3][v2]overlay=shortest=1:x=20:y=192;[0:a]aformat=sample_fmts=fltp:sample_rates=44100:channel_layouts=stereo,asetrate=9/10*44100,atempo=10/9,lowpass=f=2500,highpass=f=400,volume=6,bass=g=-30,equalizer=f=10.5:width_type=o:width=1:g=-30, equalizer=f=31.5:width_type=o:width=1:g=-30,equalizer=f=63:width_type=o:width=1:g=-10, equalizer=f=125:width_type=o:width=1:g=-20,equalizer=f=250:width_type=o:width=1:g=-1.5,equalizer=f=500:width_type=o:width=1:g=-20,equalizer=f=1000:width_type=o:width=1:g=-20,equalizer=f=8000:width_type=o:width=3:g=1,equalizer=f=16000:width_type=o:width=3:g=1" -vcodec libx264 -pix_fmt yuv420p -r 30 -g 60 -b:v 1400k -shortest -acodec libmp3lame -b:a 128k -ar 44100 -preset superfast "output2381.mp4"


CMD /Q /K 
GOTO:EOF
:error
ECHO.
ECHO Press any key to exit.
PAUSE >nul
GOTO:EOF