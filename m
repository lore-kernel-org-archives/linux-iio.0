Return-Path: <utkarsh.gupta@freescale.com>
From: "utkarsh.gupta@freescale.com" <utkarsh.gupta@freescale.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "Fabio.Estevam@freescale.com" <Fabio.Estevam@freescale.com>, "Jonathan
 Cameron" <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>, "Lars-Peter
 Clausen" <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Subject: Advice needed on combination sensor driver implementation
Date: Thu, 16 Apr 2015 07:48:32 +0000
Message-ID: <BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40@BN1PR0301MB0612.namprd03.prod.outlook.com>
Content-Type: multipart/alternative;
	boundary="_000_BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40BN1PR0301MB0612_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40BN1PR0301MB0612_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello,

I am looking at implementing FXOS8700 driver, which consists of an accelero=
meter and magnetometer, into the linux kernel 4.0. This device can function=
 independently as accel and magnetometer however it has been recommended to=
 implement it as one driver in order to achieve consistency and synchronize=
d functionality of both modules.

Please advice on whether this driver could be implemented as accel_magnetom=
eter combined driver in a separate folder in iio? Or should this be impleme=
nted as separate accel and magnetometer modules in their corresponding exis=
ting folders in iio?


Thanks & Regards,
Utkarsh Gupta - B45806
Software Apps Engineer
Freescale Semiconductors


--_000_BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40BN1PR0301MB0612_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hello,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am looking at implementing FXOS8700 driver, which =
consists of an accelerometer and magnetometer, into the linux kernel 4.0. T=
his device can function independently as accel and magnetometer however it =
has been recommended to implement
 it as one driver in order to achieve consistency and synchronized function=
ality of both modules.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Please advice on whether this driver could be implem=
ented as accel_magnetometer combined driver in a separate folder in iio? Or=
 should this be implemented as separate accel and magnetometer modules in t=
heir corresponding existing folders
 in iio? <o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Utkarsh Gupta &#8211; B45806<o:p></o:p></p>
<p class=3D"MsoNormal">Software Apps Engineer<o:p></o:p></p>
<p class=3D"MsoNormal">Freescale Semiconductors<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_BN1PR0301MB0612F81FA6EDAADE705E39CEE2E40BN1PR0301MB0612_--
