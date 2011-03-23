Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "Cai, Cliff" <Cliff.Cai@analog.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Drivers <Drivers@analog.com>, "Cai, Cliff" <Cliff.Cai@analog.com>,
	"jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 23 Mar 2011 10:24:33 +0000
Subject: RE: [Device-drivers-devel] [PATCH 3/3] Add ABI document for gyro
	quadrature correction
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713754316021@LIMKCMBX1.ad.analog.com>
References: <1300871727-32239-1-git-send-email-cliff.cai@analog.com>
 <1300871727-32239-3-git-send-email-cliff.cai@analog.com>
In-Reply-To: <1300871727-32239-3-git-send-email-cliff.cai@analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

cliff.cai@analog.com wrote on 2011-03-23:
> From: Cliff Cai <cliff.cai@analog.com>
>
> Add ABI description for gyro_z_quadrature_correction_raw.
>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> ---
>  drivers/staging/iio/Documentation/sysfs-bus-iio |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio
> b/drivers/staging/iio/Documentation/sysfs-bus-iio index 4915aee..1d42837
> 100644 --- a/drivers/staging/iio/Documentation/sysfs-bus-iio +++
> b/drivers/staging/iio/Documentation/sysfs-bus-iio @@ -698,3 +698,10 @@
> Description:
>               with all _en attributes to establish which channels are pre=
sent,
>               and the relevant _type attributes to establish the data sto=
rage
>               format.
 + +What:       /sys/bus/iio/devices/deviceX/gyro_z_quadrature_correction_r=
aw
 +KernelVersion:        2.6.38 +Contact:        linux-iio@vger.kernel.org +=
Description:
 +              This attribute is used to read the amount of quadrature err=
or
 +              present in the device at a iven time.

Typo - 'given time'.


Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
