Return-Path: <manuel.stahl9ab33xy531iis.fraunhofer.de@bounce.antispameurope.com>
Message-ID: <4CA48125.7020605@iis.fraunhofer.de>
Date: Thu, 30 Sep 2010 14:23:01 +0200
From: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
MIME-Version: 1.0
To: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@cam.ac.uk>
Subject: [IIO] Bug in IIO_DEV_ATTR_TEMP_RAW
Content-Type: multipart/mixed;
 boundary="------------040400000605010807050308"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------040400000605010807050308
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by iis.fhg.de id OAA00874

Hi,

just saw that some devices use IIO_DEV_ATTR_TEMP_RAW with a generic read=20
function but there is no parameter to pass in the register address.

Regards,
--=20
Manuel Stahl
Fraunhofer-Institut IIS
Leistungsoptimierte Systeme

Nordostpark 93
D90411 N=C3=BCrnberg
Telefon  +49 (0)911/58061-6419
Fax      +49 (0)911/58061-6398
E-Mail   manuel.stahl@iis.fraunhofer.de

http://www.iis.fraunhofer.de
http://www.smart-power.fraunhofer.de

--------------040400000605010807050308
Content-Type: text/x-vcard; charset=utf-8;
 name="manuel_stahl.vcf"
Content-Disposition: attachment;
 filename="manuel_stahl.vcf"
Content-Transfer-Encoding: base64

YmVnaW46dmNhcmQNCmZuOk1hbnVlbCBTdGFobA0KbjpTdGFobDtNYW51ZWwNCmVtYWlsO2lu
dGVybmV0Om1hbnVlbC5zdGFobEBpaXMuZnJhdW5ob2Zlci5kZQ0KdGVsO3dvcms6KzQ5IDkx
MSA1ODA2MS02NDE5DQp4LW1vemlsbGEtaHRtbDpGQUxTRQ0KdmVyc2lvbjoyLjENCmVuZDp2
Y2FyZA0KDQo=
--------------040400000605010807050308--
