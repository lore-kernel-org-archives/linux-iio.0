Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Fri, 1 Jun 2012 10:23:59 +0100
Subject: RE: [PATCH 5/8] staging:iio:accel:adis16204 fix bug in channel
 modifier handling
Message-ID: <544AC56F16B56944AEC3BD4E3D59177150C0FE65C5@LIMKCMBX1.ad.analog.com>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
 <1338406866-3833-6-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-6-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2012-05-30:
> Will result in the correct scale value for the x axis.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/accel/adis16204_core.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> diff --git a/drivers/staging/iio/accel/adis16204_core.c
> b/drivers/staging/iio/accel/adis16204_core.c index 5c02bc6..a36135d
> 100644 --- a/drivers/staging/iio/accel/adis16204_core.c +++
> b/drivers/staging/iio/accel/adis16204_core.c @@ -362,7 +362,7 @@ static
> int adis16204_read_raw(struct iio_dev *indio_dev,
>                       return IIO_VAL_INT_PLUS_MICRO;
>               case IIO_ACCEL:
>                       *val =3D 0;
> -                     if (chan->channel =3D=3D 'x')
> +                     if (chan->channel2 =3D=3D IIO_CHAN_MOD_X)
>                               *val2 =3D 17125;
>                       else
>                               *val2 =3D 8407;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
