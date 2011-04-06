Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: "greg@kroah.com" <greg@kroah.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Drivers
	<Drivers@analog.com>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Date: Wed, 6 Apr 2011 09:51:51 +0100
Subject: RE: [PATCH 1/3] IIO: GYRO: Add MACRO for gyro quadrature correction
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713754673DBE@LIMKCMBX1.ad.analog.com>
References: <1302079160-2881-1-git-send-email-cliff.cai@analog.com>
In-Reply-To: <1302079160-2881-1-git-send-email-cliff.cai@analog.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Greg,

Please ignore this set.

Cliff left ADI last week.
I therefore tried to apply his patches to my tree in order to resubmit the =
complete patch set.
However this set is incomplete, and also shows the wrong From:

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif


> -----Original Message-----
> From: Cliff Cai [mailto:cliff.cai@analog.com]
> Sent: Wednesday, April 06, 2011 10:39 AM
> To: greg@kroah.com
> Cc: linux-iio@vger.kernel.org; Drivers; jic23@cam.ac.uk; device-
> drivers-devel@blackfin.uclinux.org; Hennerich, Michael
> Subject: [PATCH 1/3] IIO: GYRO: Add MACRO for gyro quadrature
> correction
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> Add gyro_z_quadrature_correction_raw define.
>
> Signed-off-by: Cliff Cai <cliff.cai@analog.com>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/gyro/gyro.h |    3 +++
>  1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/staging/iio/gyro/gyro.h
> b/drivers/staging/iio/gyro/gyro.h
> index b4ea5bf..b549561 100644
> --- a/drivers/staging/iio/gyro/gyro.h
> +++ b/drivers/staging/iio/gyro/gyro.h
> @@ -57,6 +57,9 @@
>  #define IIO_DEV_ATTR_GYRO_Z_CALIBSCALE(_mode, _show, _store, _addr)
>               \
>       IIO_DEVICE_ATTR(gyro_z_calibscale, _mode, _show, _store, _addr)
>
> +#define IIO_DEV_ATTR_GYRO_Z_QUADRATURE_CORRECTION(_show, _addr)
>       \
> +     IIO_DEVICE_ATTR(gyro_z_quadrature_correction_raw, S_IRUGO, _show,
> NULL, _addr)
> +
>  #define IIO_DEV_ATTR_GYRO(_show, _addr)                      \
>       IIO_DEVICE_ATTR(gyro_raw, S_IRUGO, _show, NULL, _addr)
>
> --
> 1.6.0.2
