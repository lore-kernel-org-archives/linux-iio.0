Return-Path: <ggao@invensense.com>
From: Ge Gao <ggao@invensense.com>
MIME-Version: 1.0
Date: Thu, 10 May 2012 16:42:19 -0700
Message-ID: <a29bae2d2e7e26ca76d6d3209f0e387b@mail.gmail.com>
Subject: trigger removal problems.
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@cam.ac.uk>
Content-Type: multipart/alternative; boundary=0016e6d784fdb09de504bfb72bee
List-ID: <linux-iio@vger.kernel.org>

--0016e6d784fdb09de504bfb72bee
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Dear all,

                I am building my IIO driver as a module and will constantly
need to use =93insmod=94 and =93rmmod=94 to install it and remove it due to
development. However, I found that if I write anything to the
=93trigger/current_trigger=94, it will not be able to remove it. The error =
code
is (11). Even I write =93null=94 to it, it will not be able to be removed.
However, If I don=92t write anything to it, just insmod and rmmod, it will =
be
remove successfully. Any idea what could cause this problem? I followed
what is in the IIO subsystem driver to write my driver. I can post it if
anyone want to take a look.

                Thanks.



Ge

--0016e6d784fdb09de504bfb72bee
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html; charset=
=3Dus-ascii"><meta name=3D"Generator" content=3D"Microsoft Word 14 (filtere=
d medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri","sans-serif";}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style></head><body lang=3D"EN-US" link=3D"blue" vlink=3D"purple"><div =
class=3D"WordSection1"><p class=3D"MsoNormal">Dear all,</p><p class=3D"MsoN=
ormal">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 I am building my IIO d=
river as a module and will constantly need to use =93insmod=94 and =93rmmod=
=94 to install it and remove it due to development. However, I found that i=
f I write anything to the =93trigger/current_trigger=94, it will not be abl=
e to remove it. The error code is (11). Even I write =93null=94 to it, it w=
ill not be able to be removed. However, If I don=92t write anything to it, =
just insmod and rmmod, it will be remove successfully. Any idea what could =
cause this problem? I followed what is in the IIO subsystem driver to write=
 my driver. I can post it if anyone want to take a look.</p>
<p class=3D"MsoNormal">=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Thanks=
.</p><p class=3D"MsoNormal">=A0</p><p class=3D"MsoNormal">Ge</p><p class=3D=
"MsoNormal">=A0</p></div></body></html>

--0016e6d784fdb09de504bfb72bee--
