Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>, "manuel.stahl@iis.fraunhofer.de"
	<manuel.stahl@iis.fraunhofer.de>
Date: Wed, 5 Oct 2011 07:58:08 +0100
Subject: RE: [PATCH 00/11] IIO: resolvers - first round of cleanups.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E73435B7@LIMKCMBX1.ad.analog.com>
References: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1317377694-9001-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-30:
> Hi All,
>
> Mostly straight forward, but that change I suggested yesterday
> IIO_GYRO -> IIO_ANGL_VEL and in_gyro_x_* -> in_anglvel_x_*
> is in here.  I'm interested to hear peoples opinions on that
> in particular.
>
> Note the ad2s1210 is still definitely a work in progress.
> There are numerous weird and wonderful corners of its abi
> a the moment that need sorting out.
>
> Thanks,
>
> Jonathan

Hi Jonathan,

Looks good to me. Thanks!

Acked-by: Michael Hennerich <michael.hennerich@analog.com>


> Jonathan Cameron (11):
>   staging:iio:resolver:ad2s90 fix registration of null pointer
>   staging:iio:resolver:ad2s90 ensure name is passed to iio_core.
>   stagiong:iio:resolver:ad2s90 chan spec conversion
>   staging:iio: rename gyro channels to anglvel
>   staging:iio:Documentation gyro -> anglvel updates in attribute names
>   staging:iio:resolver:ad2s120x chan spec conversion
>   staging:iio:resolver rename ad2s120x ->ad2s1200
>   staging:iio:resolver:ad2s1210 ensure iio_dev->name is set
>   staging:iio:resolver:ad2s1210 minimal chan spec conversion.
>   staging:iio:resolver:ad2s1210 drop raw config register access
>   staging:iio:resolver:ad2s1210 cleanup gpio handling.
>  drivers/staging/iio/Documentation/sysfs-bus-iio |  108 ++++++------
>  drivers/staging/iio/gyro/adis16060_core.c       |    2 +-
>  drivers/staging/iio/gyro/adis16080_core.c       |    2 +-
>  drivers/staging/iio/gyro/adis16130_core.c       |    2 +-
>  drivers/staging/iio/gyro/adis16260_core.c       |    8 +-
>  drivers/staging/iio/gyro/adxrs450_core.c        |    4 +-
>  drivers/staging/iio/iio.h                       |    2 +-
>  drivers/staging/iio/imu/adis16400_core.c        |   22 ++--
>  drivers/staging/iio/industrialio-core.c         |    2 +-
>  drivers/staging/iio/resolver/Kconfig            |    4 +-
>  drivers/staging/iio/resolver/Makefile           |    2 +-
>  drivers/staging/iio/resolver/ad2s1200.c         |  187
>  ++++++++++++++++++++ drivers/staging/iio/resolver/ad2s120x.c         |
>  178 --------------- ---- drivers/staging/iio/resolver/ad2s1210.c
>   |  216 +++++++++------ ------- drivers/staging/iio/resolver/ad2s90.c
>          |   57 +++--- 15 files changed, 382 insertions(+), 414
>  deletions(-) create mode 100644 drivers/staging/iio/resolver/ad2s1200.c
>  delete mode 100644 drivers/staging/iio/resolver/ad2s120x.c

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
