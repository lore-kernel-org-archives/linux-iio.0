Return-Path: <rklein@nvidia.com>
From: Rhyland Klein <rklein@nvidia.com>
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>
Date: Wed, 1 Sep 2010 15:51:30 -0700
Subject: question about hwo to fit in an ALS driver
Message-ID: <E88A1D35AF5437468E5B14C7C4BA61C702CF4B6279@HQMAIL01.nvidia.com>
Content-Type: multipart/alternative;
	boundary="_000_E88A1D35AF5437468E5B14C7C4BA61C702CF4B6279HQMAIL01nvidi_"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

--_000_E88A1D35AF5437468E5B14C7C4BA61C702CF4B6279HQMAIL01nvidi_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I am looking into submitting a sensor driver for the isl29018 ambient lig=
ht sensor (als). I noticed there is an old isl als driver for a different=
=20part (isl29003) in drivers/misc but I also see the light sensor driver=
=20for tsl2653 in the drivers/staging/iio/light directory which seems muc=
h more like the correct place for this type of sensor driver to reside.

Is this subsystem designed for ALS drivers or a different type of light s=
ensor? If it should support ALS drivers, I don't know how the IIO_DEV* at=
tributes should map for this. I suppose it would just use the IIO_DEV_ATT=
R_LIGHT_VISIBLE for the lux, which could work, except that the isl29018 a=
lso functions as a proximity sensor, and the driver will support both mod=
es.  What is the proper way to fit a driver like this into the iio subsys=
tem?

One thing to note is that there are additional properties other than just=
=20reporting the lux that will need to be supported including changing th=
e mode and setting the range, and I am not sure how these should fit into=
=20the device attribute framework exposed via light.h.

Thanks,
Rhyland


-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------

--_000_E88A1D35AF5437468E5B14C7C4BA61C702CF4B6279HQMAIL01nvidi_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-mi=
crosoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:wo=
rd" xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D=
"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<style>
<!--
=20/* Font Definitions */
=20@font-face
=09{font-family:Calibri;
=09panose-1:2 15 5 2 2 2 4 3 2 4;}
=20/* Style Definitions */
=20p.MsoNormal, li.MsoNormal, div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:11.0pt;
=09font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
=09{mso-style-priority:99;
=09color:blue;
=09text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
=09{mso-style-priority:99;
=09color:purple;
=09text-decoration:underline;}
span.EmailStyle17
=09{mso-style-type:personal-compose;
=09font-family:"Calibri","sans-serif";
=09color:windowtext;}
.MsoChpDefault
=09{mso-style-type:export-only;}
@page WordSection1
=09{size:8.5in 11.0in;
=09margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
=09{page:WordSection1;}
-->
</style>
<!--[if gte mso 9]><xml>
=20<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
=20<o:shapelayout v:ext=3D"edit">
=20 <o:idmap v:ext=3D"edit" data=3D"1" />
=20</o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DWordSection1>

<p class=3DMsoNormal>I am looking into submitting a sensor driver for the=

isl29018 ambient light sensor (als). I noticed there is an old isl als dr=
iver
for a different part (isl29003) in drivers/misc but I also see the light =
sensor
driver for tsl2653 in the drivers/staging/iio/light directory which seems=
=20much
more like the correct place for this type of sensor driver to reside. <o:=
p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Is this subsystem designed for ALS drivers or a diff=
erent
type of light sensor? If it should support ALS drivers, I don&#8217;t kno=
w how
the IIO_DEV* attributes should map for this. I suppose it would just use =
the
IIO_DEV_ATTR_LIGHT_VISIBLE for the lux, which could work, except that the=

isl29018 also functions as a proximity sensor, and the driver will suppor=
t both
modes. &nbsp;What is the proper way to fit a driver like this into the ii=
o
subsystem?<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>One thing to note is that there are additional prope=
rties
other than just reporting the lux that will need to be supported includin=
g changing
the mode and setting the range, and I am not sure how these should fit in=
to the
device attribute framework exposed via light.h.<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Thanks,<o:p></o:p></p>

<p class=3DMsoNormal>Rhyland<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

</div>


<DIV>
<HR>
</DIV>
<DIV>This email message is for the sole use of the intended recipient(s) =
and may=20
contain confidential information.&nbsp; Any unauthorized review, use, dis=
closure=20
or distribution is prohibited.&nbsp; If you are not the intended recipien=
t,=20
please contact the sender by reply email and destroy all copies of the or=
iginal=20
message. </DIV>
<DIV>
<HR>
</DIV>
<P></P>
</body>

</html>

--_000_E88A1D35AF5437468E5B14C7C4BA61C702CF4B6279HQMAIL01nvidi_--
