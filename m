Return-Path: <o.v.kravchenko@globallogic.com>
MIME-Version: 1.0
Date: Wed, 31 Jul 2013 18:56:32 +0300
Message-ID: <CAGH3drpJbnTnMwS-U3QDEFWSk2d-Oi2d9_b6+Lyq2sD78HOUVg@mail.gmail.com>
Subject: IIO and input in BMA180 acceleration sensor driver
From: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, jic23@cam.ac.uk,
	Grygorii Strashko <grygorii.strashko@globallogic.com>
Content-Type: multipart/alternative; boundary=089e013a100afc548f04e2d0c473
List-ID: <linux-iio@vger.kernel.org>

--089e013a100afc548f04e2d0c473
Content-Type: text/plain; charset=ISO-8859-1

Hi All,

I'm writing driver for BMA180 acceleration sensor. It is a part of our
OMAP4 development platforms
Blaze/Tablet 2 and it's used to provide its measurement results to the
User space (in or case Android)
through standard Linux input subsystem (In our Product kernels it is
simple a misc input device).
Now there is an indetermination:
- from one side, Accelerometer drivers should be part of IIO now;
- from other side, We have to use input subsystem to provide backward
compatibility
  with the User space (Android)

So, the question is how to achieve that?
I'd be appreciated for any advice.

-- 
Oleksandr Kravchenko
GlobalLogic
P +380633213187
P +380994930248
www.globallogic.com
<http://www.globallogic.com/>
http://www.globallogic.com/email_disclaimer.txt

--089e013a100afc548f04e2d0c473
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi All,<br><br>I&#39;m writing driver for BMA180 accelerat=
ion sensor. It is a part of our OMAP4 development platforms<br>
Blaze/Tablet 2 and it&#39;s used to provide its measurement results to the<=
br>
User space (in or case Android)<br>
through standard Linux input subsystem (In our Product kernels it is<br>
simple a misc input device).<br>
Now there is an indetermination:<br>
- from one side, Accelerometer drivers should be part of IIO now;<br>
- from other side, We have to use input subsystem to provide backward<br>
compatibility<br>
=A0 with the User space (Android)<br>
<br>
So, the question is how to achieve that?<br>
I&#39;d be appreciated for any advice.<br clear=3D"all"><div><br>-- <br><di=
v dir=3D"ltr"><font size=3D"-1"><font size=3D"-1">Oleksandr Kravchenko</fon=
t><br><span style=3D"vertical-align:baseline;font-variant:normal;font-style=
:normal;font-size:12px;background-color:transparent;text-decoration:none;fo=
nt-family:Arial;font-weight:normal">GlobalLogic</span><br>
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

</div></div>

--089e013a100afc548f04e2d0c473--
