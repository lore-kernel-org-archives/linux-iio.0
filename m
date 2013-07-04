Return-Path: <o.v.kravchenko@globallogic.com>
MIME-Version: 1.0
Date: Thu, 4 Jul 2013 16:16:43 +0300
Message-ID: <CAGH3droX_J9JJ60EP6d62Sh6MK6T5WvYTq+uwcmJkwb0c1Yurg@mail.gmail.com>
Subject: Issue with porting i2c driver to k3.10 (iio)
From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, jic23@cam.ac.uk
Content-Type: multipart/alternative; boundary=089e0111d842b0fb4704e0af6365
List-ID: <linux-iio@vger.kernel.org>

--089e0111d842b0fb4704e0af6365
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I wrote i2c driver for APDS-9300 light sensor in drivers/misc, but I have
some questions regarding upstreaming of it.
1. It works properly in kernel-3.4, but it works very slow in kernel-3.10
(on mutex and i2c operations, particulary on mutex_lock() and
i2c_smbus_read_data()). Does anyone know why this issue may be occurred?
2. Can I send this driver without using Industrial I/O framework?

Thanks in advance.

-- 
Oleksandr Kravchenko
GlobalLogic
P +380633213187
P +380994930248
www.globallogic.com
<http://www.globallogic.com/>
http://www.globallogic.com/email_disclaimer.txt

--089e0111d842b0fb4704e0af6365
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>I wrote i2c driver for APDS-9300 light sens=
or in drivers/misc, but I have some questions regarding upstreaming of it.<=
br>1. It works properly in kernel-3.4, but it works very slow in kernel-3.1=
0 (on mutex and i2c operations, particulary on mutex_lock() and i2c_smbus_r=
ead_data()). Does anyone know why this issue may be occurred?<br>
2. Can I send this driver without using Industrial I/O framework?<br><br>Th=
anks in advance.<br clear=3D"all"><br>-- <br><div dir=3D"ltr"><font size=3D=
"-1"><font size=3D"-1">Oleksandr Kravchenko</font><br><span style=3D"vertic=
al-align:baseline;font-variant:normal;font-style:normal;font-size:12px;back=
ground-color:transparent;text-decoration:none;font-family:Arial;font-weight=
:normal">GlobalLogic</span><br>
<span style=3D"vertical-align:baseline;font-variant:normal;font-style:norma=
l;font-size:12px;background-color:transparent;text-decoration:none;font-fam=
ily:Arial;font-weight:normal">P +380633213187</span></font><br><font size=
=3D"-1"><font size=3D"-1"><span style=3D"vertical-align:baseline;font-varia=
nt:normal;font-style:normal;font-size:12px;background-color:transparent;tex=
t-decoration:none;font-family:Arial;font-weight:normal"><font size=3D"-1"><=
span style=3D"vertical-align:baseline;font-variant:normal;font-style:normal=
;font-size:12px;background-color:transparent;text-decoration:none;font-fami=
ly:Arial;font-weight:normal">P +380994930248</span></font><font size=3D"-1"=
><font size=3D"-1"><span style=3D"vertical-align:baseline;font-variant:norm=
al;font-style:normal;font-size:12px;background-color:transparent;text-decor=
ation:none;font-family:Arial;font-weight:normal"><br>
</span></font></font></span></font><a href=3D"http://www.globallogic.com/" =
target=3D"_blank"><span style=3D"font-size:12px;font-family:Arial;color:rgb=
(17,85,204);background-color:transparent;font-weight:normal;font-style:norm=
al;font-variant:normal;text-decoration:underline;vertical-align:baseline">w=
ww.globallogic.com</span></a><span style=3D"vertical-align:baseline;font-va=
riant:normal;font-style:normal;font-size:12px;background-color:transparent;=
text-decoration:none;font-family:Arial;font-weight:normal"></span><br>
<a href=3D"http://www.globallogic.com/" target=3D"_blank"><span style=3D"fo=
nt-size:12px;font-family:Arial;color:rgb(17,85,204);background-color:transp=
arent;font-weight:normal;font-style:normal;font-variant:normal;text-decorat=
ion:underline;vertical-align:baseline"></span></a><br>
<a href=3D"http://www.globallogic.com/email_disclaimer.txt" target=3D"_blan=
k"><span style=3D"font-size:11px;font-family:Arial;color:rgb(17,85,204);bac=
kground-color:transparent;font-weight:normal;font-style:normal;font-variant=
:normal;text-decoration:underline;vertical-align:baseline">http://www.globa=
llogic.com/email_disclaimer.txt</span></a><span style=3D"vertical-align:bas=
eline;font-variant:normal;font-style:normal;font-size:11px;background-color=
:transparent;text-decoration:none;font-family:Arial;font-weight:normal"></s=
pan></font></div>

</div>

--089e0111d842b0fb4704e0af6365--
