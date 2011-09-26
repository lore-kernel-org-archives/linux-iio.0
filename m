Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:32:54 +0100
Subject: RE: [PATCH 04/16] staging:iio:adc:ad799x trivial: use the
 convenient chan struct.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272ACF@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-5-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-5-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> This is much cleaner than bouncing through the various structures
> to get to the same thing.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |    7 +++----
>  1 files changed, 3 insertions(+), 4 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 3b5f8be..517cbd9 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -159,12 +159,11 @@ static int
> ad799x_read_raw(struct iio_dev *dev_info,
>
>               if (ret < 0)
>                       return ret;
> -             *val =3D (ret >> st->chip_info->channel[0].scan_type.shift)=
 &
> -                     RES_MASK(st->chip_info-
>> channel[0].scan_type.realbits);
> +             *val =3D (ret >> chan->scan_type.shift) &
> +                     RES_MASK(chan->scan_type.realbits);
>               return IIO_VAL_INT;
>       case (1 << IIO_CHAN_INFO_SCALE_SHARED):
> -             scale_uv =3D (st->int_vref_mv * 1000)
> -                     >> st->chip_info->channel[0].scan_type.realbits;
> +             scale_uv =3D (st->int_vref_mv * 1000) >> chan-
>> scan_type.realbits;
>>              *val =3D  scale_uv / 1000;
>>              *val2 =3D (scale_uv % 1000) * 1000;
>>              return IIO_VAL_INT_PLUS_MICRO;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
