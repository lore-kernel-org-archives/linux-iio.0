Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Fri, 1 Jun 2012 10:25:04 +0100
Subject: RE: [PATCH 8/8] staging:iio: Add some missing peak elements to the
 info_mask
Message-ID: <544AC56F16B56944AEC3BD4E3D59177150C0FE65D2@LIMKCMBX1.ad.analog.com>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
 <1338406866-3833-9-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-9-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2012-05-30:
> These are supported by raw_read but not actually there.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/accel/adis16240_core.c |    9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> diff --git a/drivers/staging/iio/accel/adis16240_core.c
> b/drivers/staging/iio/accel/adis16240_core.c index 2df39d1..3f30a99
> 100644 --- a/drivers/staging/iio/accel/adis16240_core.c +++
> b/drivers/staging/iio/accel/adis16240_core.c @@ -481,7 +481,8 @@ static
> struct iio_chan_spec adis16240_channels[] =3D {
>               .channel2 =3D IIO_MOD_X,
>               .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>               IIO_CHAN_INFO_SCALE_SHARED_BIT |
> -             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
> +             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
> +             IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>               .address =3D accel_x,
>               .scan_index =3D ADIS16240_SCAN_ACC_X,
>               .scan_type =3D {
> @@ -495,7 +496,8 @@ static struct iio_chan_spec adis16240_channels[] =3D
> {
>               .channel2 =3D IIO_MOD_Y,
>               .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>               IIO_CHAN_INFO_SCALE_SHARED_BIT |
> -             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
> +             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
> +             IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>               .address =3D accel_y,
>               .scan_index =3D ADIS16240_SCAN_ACC_Y,
>               .scan_type =3D {
> @@ -509,7 +511,8 @@ static struct iio_chan_spec adis16240_channels[] =3D
> {
>               .channel2 =3D IIO_MOD_Z,
>               .info_mask =3D IIO_CHAN_INFO_RAW_SEPARATE_BIT |
>               IIO_CHAN_INFO_SCALE_SHARED_BIT |
> -             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT,
> +             IIO_CHAN_INFO_CALIBBIAS_SEPARATE_BIT |
> +             IIO_CHAN_INFO_PEAK_SEPARATE_BIT,
>               .address =3D accel_z,
>               .scan_index =3D ADIS16240_SCAN_ACC_Z,
>               .scan_type =3D {

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
