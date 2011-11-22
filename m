Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Dan Carpenter <dan.carpenter@oracle.com>, Jonathan Cameron
	<jic23@cam.ac.uk>
CC: Greg Kroah-Hartman <gregkh@suse.de>, Paul Gortmaker
	<paul.gortmaker@windriver.com>, Lars-Peter Clausen <lars@metafoo.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Date: Tue, 22 Nov 2011 09:27:50 +0000
Subject: RE: [patch] Staging: iio: fix endian conversion in
 ad7298_scan_direct()
Message-ID: <544AC56F16B56944AEC3BD4E3D5917714872FF3686@LIMKCMBX1.ad.analog.com>
References: <20111122073915.GB25051@elgon.mountain>
In-Reply-To: <20111122073915.GB25051@elgon.mountain>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Dan Carpenter wrote on 2011-11-22:
> "tmp" is used to store the output from cpu_to_be16() so it should be
> a __be16 bit type.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Good catch - Thanks!

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
> Static checker patch.  Untested.
>
> diff --git a/drivers/staging/iio/adc/ad7298_core.c
> b/drivers/staging/iio/adc/ad7298_core.c index a799bd1..3e804e2 100644
> --- a/drivers/staging/iio/adc/ad7298_core.c +++
> b/drivers/staging/iio/adc/ad7298_core.c @@ -69,27 +69,28 @@ static int
> ad7298_scan_direct(struct ad7298_state *st, unsigned ch)
>  static int ad7298_scan_temp(struct ad7298_state *st, int *val) {     int
>  tmp, ret;
> +     __be16 buf;
>
> -     tmp =3D cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
> +     buf =3D cpu_to_be16(AD7298_WRITE | AD7298_TSENSE |
>                         AD7298_TAVG | st->ext_ref);
> -     ret =3D spi_write(st->spi, (u8 *)&tmp, 2);
> +     ret =3D spi_write(st->spi, (u8 *)&buf, 2);
>       if (ret)
>               return ret;
> -     tmp =3D 0;
> +     buf =3D cpu_to_be16(0);
>
> -     ret =3D spi_write(st->spi, (u8 *)&tmp, 2);
> +     ret =3D spi_write(st->spi, (u8 *)&buf, 2);
>       if (ret)
>               return ret;
>
>       usleep_range(101, 1000); /* sleep > 100us */
> -     ret =3D spi_read(st->spi, (u8 *)&tmp, 2);
> +     ret =3D spi_read(st->spi, (u8 *)&buf, 2);
>       if (ret)
>               return ret;
> -     tmp =3D be16_to_cpu(tmp) & RES_MASK(AD7298_BITS);
> +     tmp =3D be16_to_cpu(buf) & RES_MASK(AD7298_BITS);
>
>       /*
>        * One LSB of the ADC corresponds to 0.25 deg C.

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
