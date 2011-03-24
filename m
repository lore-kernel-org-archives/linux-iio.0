Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Thu, 24 Mar 2011 15:12:42 +0000
Subject: RE: [PATCH] IIO: ADC: New driver for the AD7880 / AD7781 24-bit
 Sigma-Delta ADC
Message-ID: <544AC56F16B56944AEC3BD4E3D59177137545394A3@LIMKCMBX1.ad.analog.com>
References: <1300975814-14423-1-git-send-email-michael.hennerich@analog.com>
 <4D8B5D86.8010503@cam.ac.uk>
In-Reply-To: <4D8B5D86.8010503@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-03-24:
> On 03/24/11 14:10, michael.hennerich@analog.com wrote:
>> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Hi Michael,
>
> Some slightly inconsistent handling of the absence of pdata.
> Is it possible to use this device without pdrst being connected?

Yes and no.
You could but then the AD7780 asserts SDO/RDY whenever a new sample is avai=
lable.
No way to stop it, without utilizing PDRST.
I therefore use spi bus locking and keep the part in reset/power down whene=
ver is should be quiet.
The part also lacks a dedicated spi chip select. So we definitely want to u=
se PDRST.

> If not, then check for pdata early in probe and fail if not present.

Yes - I typically do this, however it slipped this time.

> The datardy on the data out line is a delightful big of hardware
> design and I guess what you have here is the only way to handle it.

Unfortunately that's the case.

> Having said that, perhaps some explanatory comments, maybe in the
> header, would be useful.  Do you have that irq pin dual wired to the
> spi data out?

Yes

Thanks for the review.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
