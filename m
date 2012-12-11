Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@kernel.org" <jic23@kernel.org>
Date: Tue, 11 Dec 2012 12:22:16 +0000
Subject: iio command server 
Message-ID: <544AC56F16B56944AEC3BD4E3D5917715B9A3057AD@LIMKCMBX1.ad.analog.com>
Content-Type: multipart/alternative;
	boundary="_000_544AC56F16B56944AEC3BD4E3D5917715B9A3057ADLIMKCMBX1adan_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_544AC56F16B56944AEC3BD4E3D5917715B9A3057ADLIMKCMBX1adan_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi All,

A while ago we had the need to control a set of IIO devices via an network =
connection.
Goal was to develop an instrumentation and control application running on  =
a remote machine using a higher level
programming language with GUI capabilities.

To achieve this goal I came up with a simple client server approach.

Design objectives:
Cross platform
Byte oriented
Simple socket programming
Human readable syntax to ease command line usage
Reuse of existing tools
Low overhead

More information about the server and it's client examples can be found her=
e:

http://wiki.analog.com/resources/tools-software/linux-software/iio_cmdsrv

Sources for the server and it's C# and C client interface can be found here=
:

https://github.com/analogdevicesinc/iio-cmdsrv

Comments welcome...

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif


--_000_544AC56F16B56944AEC3BD4E3D5917715B9A3057ADLIMKCMBX1adan_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40"><head><meta http-equiv=3DContent-Type content=
=3D"text/html; charset=3Dus-ascii"><meta name=3DGenerator content=3D"Micros=
oft Word 14 (filtered medium)"><style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:PMingLiU;
	panose-1:2 2 5 0 0 0 0 0 0 0;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 2 5 0 0 0 0 0 0 0;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
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
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]--></head><body lang=3DEN-US link=3Dblue vli=
nk=3Dpurple><div class=3DWordSection1><p class=3DMsoNormal>Hi All,<o:p></o:=
p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>A whil=
e ago we had the need to control a set of IIO devices via an network connec=
tion.<o:p></o:p></p><p class=3DMsoNormal>Goal was to develop an instrumenta=
tion and control application running on&nbsp; a remote machine using a high=
er level <o:p></o:p></p><p class=3DMsoNormal>programming language with GUI =
capabilities.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p cl=
ass=3DMsoNormal>To achieve this goal I came up with a simple client server =
approach.<o:p></o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=
=3DMsoNormal>Design objectives:<o:p></o:p></p><p class=3DMsoNormal style=3D=
'margin-left:36.0pt'>Cross platform<o:p></o:p></p><p class=3DMsoNormal styl=
e=3D'margin-left:36.0pt'>Byte oriented<o:p></o:p></p><p class=3DMsoNormal s=
tyle=3D'margin-left:36.0pt'>Simple socket programming<o:p></o:p></p><p clas=
s=3DMsoNormal style=3D'margin-left:36.0pt'>Human readable syntax to ease co=
mmand line usage<o:p></o:p></p><p class=3DMsoNormal style=3D'margin-left:36=
.0pt'>Reuse of existing tools<o:p></o:p></p><p class=3DMsoNormal style=3D'm=
argin-left:36.0pt'>Low overhead <o:p></o:p></p><p class=3DMsoNormal><o:p>&n=
bsp;</o:p></p><p class=3DMsoNormal>More information about the server and it=
&#8217;s client examples can be found here:<o:p></o:p></p><p class=3DMsoNor=
mal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><a href=3D"http://wiki.analog=
.com/resources/tools-software/linux-software/iio_cmdsrv">http://wiki.analog=
.com/resources/tools-software/linux-software/iio_cmdsrv</a><o:p></o:p></p><=
p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Sources for t=
he server and it&#8217;s C# and C client interface can be found here:<o:p><=
/o:p></p><p class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal><a =
href=3D"https://github.com/analogdevicesinc/iio-cmdsrv">https://github.com/=
analogdevicesinc/iio-cmdsrv</a><o:p></o:p></p><p class=3DMsoNormal><o:p>&nb=
sp;</o:p></p><p class=3DMsoNormal>Comments welcome&#8230;<o:p></o:p></p><p =
class=3DMsoNormal><o:p>&nbsp;</o:p></p><p class=3DMsoNormal>Greetings,<o:p>=
</o:p></p><p class=3DMsoNormal>Michael<o:p></o:p></p><p class=3DMsoNormal><=
o:p>&nbsp;</o:p></p><p class=3DMsoNormal>--<o:p></o:p></p><p class=3DMsoNor=
mal>Analog Devices GmbH&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wilhelm-Wagenfeld-Str=
. <span lang=3DDE>6&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 80807 Muenchen<o:p></o:p>=
</span></p><p class=3DMsoNormal><span lang=3DDE>Sitz der Gesellschaft: Muen=
chen; Registergericht: Muenchen HRB 40368;<o:p></o:p></span></p><p class=3D=
MsoNormal><span lang=3DDE>Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wess=
el, William A. Martin, Margaret Seif<o:p></o:p></span></p><p class=3DMsoNor=
mal><span lang=3DDE><o:p>&nbsp;</o:p></span></p></div></body></html>=

--_000_544AC56F16B56944AEC3BD4E3D5917715B9A3057ADLIMKCMBX1adan_--
