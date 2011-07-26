Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Tue, 26 Jul 2011 09:22:54 +0100
Subject: RE: [PATCH 5/7] staging:iio: push the main buffer chrdev down to
 the top level.
Message-ID: <544AC56F16B56944AEC3BD4E3D591771430011964F@LIMKCMBX1.ad.analog.com>
References: <1311599921-15729-1-git-send-email-jic23@cam.ac.uk>
 <1311599921-15729-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1311599921-15729-6-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-07-25:
> Sorry all, this one is very invasive, though the driver changes are
> just trivial interface fixes. Not all done yet.
>
> V2 - bring the sca3000 with us.
> V3 - fix ade7758 bugs in conversion.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
Looks good!
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/Documentation/generic_buffer.c |   12 +-
>  drivers/staging/iio/Documentation/iio_utils.h      |    2 +-
>  drivers/staging/iio/accel/adis16201_core.c         |    6 +-
>  drivers/staging/iio/accel/adis16203_core.c         |    6 +-
>  drivers/staging/iio/accel/adis16204_core.c         |    6 +-
>  drivers/staging/iio/accel/adis16209_core.c         |    6 +-
>  drivers/staging/iio/accel/adis16240_core.c         |    6 +-
>  drivers/staging/iio/accel/lis3l02dq_core.c         |    6 +-
>  drivers/staging/iio/accel/sca3000_core.c           |    6 +-
>  drivers/staging/iio/accel/sca3000_ring.c           |   23 +--
>  drivers/staging/iio/adc/ad7298_core.c              |    4 +-
>  drivers/staging/iio/adc/ad7476_core.c              |    4 +-
>  drivers/staging/iio/adc/ad7606_core.c              |    4 +-
>  drivers/staging/iio/adc/ad7793.c                   |    6 +-
>  drivers/staging/iio/adc/ad7887_core.c              |    4 +-
>  drivers/staging/iio/adc/ad799x_core.c              |    4 +-
>  drivers/staging/iio/adc/max1363_core.c             |    6 +-
>  drivers/staging/iio/gyro/adis16260_core.c          |    6 +-
>  drivers/staging/iio/iio.h                          |    2 +-
>  drivers/staging/iio/iio_core.h                     |   32 +++
>  drivers/staging/iio/imu/adis16400_core.c           |    6 +-
>  drivers/staging/iio/industrialio-core.c            |   65 +++++-
>  drivers/staging/iio/industrialio-ring.c            |  239 ++++++------
>  -------- drivers/staging/iio/kfifo_buf.c                    |   26 +--
>  drivers/staging/iio/meter/ade7758.h                |    5 +-
>  drivers/staging/iio/meter/ade7758_core.c           |    6 +-
>  drivers/staging/iio/meter/ade7758_ring.c           |    4 +-
>  drivers/staging/iio/ring_generic.h                 |   24 +--
>  drivers/staging/iio/ring_sw.c                      |   25 +-- 29 files
>  changed, 244 insertions(+), 307 deletions(-)

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
