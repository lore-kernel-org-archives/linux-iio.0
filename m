Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:25:52 +0100
Subject: RE: [PATCH 05/16] staging:iio:adc:ad799x use a table for frequency
 values rather than big switch.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AC1@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-6-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-6-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad799x_core.c |   74 ++++++++-----------------
>  -------- 1 files changed, 17 insertions(+), 57 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad799x_core.c
> b/drivers/staging/iio/adc/ad799x_core.c index 517cbd9..c615188 100644
> --- a/drivers/staging/iio/adc/ad799x_core.c +++
> b/drivers/staging/iio/adc/ad799x_core.c @@ -170,7 +170,15 @@ static int
> ad799x_read_raw(struct iio_dev *dev_info,
>       }
>       return -EINVAL;
>  }
> -
> +static const unsigned int ad7998_frequencies[] =3D {
> +     [AD7998_CYC_DIS]        =3D 0,
> +     [AD7998_CYC_TCONF_32]   =3D 15625,
> +     [AD7998_CYC_TCONF_64]   =3D 7812,
> +     [AD7998_CYC_TCONF_128]  =3D 3906,
> +     [AD7998_CYC_TCONF_512]  =3D 976,
> +     [AD7998_CYC_TCONF_1024] =3D 488,
> +     [AD7998_CYC_TCONF_2048] =3D 244,
> +};
>  static ssize_t ad799x_read_frequency(struct device *dev,
>                                       struct device_attribute *attr,
>                                       char *buf)
> @@ -178,7 +186,7 @@ static ssize_t ad799x_read_frequency(struct device
> *dev,
>       struct iio_dev *dev_info =3D dev_get_drvdata(dev);
>       struct ad799x_state *st =3D iio_priv(dev_info);
> -     int ret, len =3D 0;
> +     int ret;
>       u8 val;
>       ret =3D ad799x_i2c_read8(st, AD7998_CYCLE_TMR_REG, &val);
>       if (ret)
> @@ -186,33 +194,7 @@ static ssize_t ad799x_read_frequency(struct device
> *dev,
>
>       val &=3D AD7998_CYC_MASK;
> -     switch (val) {
> -     case AD7998_CYC_DIS:
> -             len =3D sprintf(buf, "0\n");
> -             break;
> -     case AD7998_CYC_TCONF_32:
> -             len =3D sprintf(buf, "15625\n");
> -             break;
> -     case AD7998_CYC_TCONF_64:
> -             len =3D sprintf(buf, "7812\n");
> -             break;
> -     case AD7998_CYC_TCONF_128:
> -             len =3D sprintf(buf, "3906\n");
> -             break;
> -     case AD7998_CYC_TCONF_256:
> -             len =3D sprintf(buf, "1953\n");
> -             break;
> -     case AD7998_CYC_TCONF_512:
> -             len =3D sprintf(buf, "976\n");
> -             break;
> -     case AD7998_CYC_TCONF_1024:
> -             len =3D sprintf(buf, "488\n");
> -             break;
> -     case AD7998_CYC_TCONF_2048:
> -             len =3D sprintf(buf, "244\n");
> -             break;
> -     }
> -     return len;
> +     return sprintf(buf, "%u\n", ad7998_frequencies[val]);
>  }
>
>  static ssize_t ad799x_write_frequency(struct device *dev,
> @@ -224,7 +206,7 @@ static ssize_t ad799x_write_frequency(struct device
> *dev,
>       struct ad799x_state *st =3D iio_priv(dev_info);
>
>       long val;
> -     int ret;
> +     int ret, i;
>       u8 t;
>
>       ret =3D strict_strtol(buf, 10, &val);
> @@ -238,36 +220,14 @@ static ssize_t ad799x_write_frequency(struct
> device *dev,
>       /* Wipe the bits clean */
>       t &=3D ~AD7998_CYC_MASK;
> -     switch (val) {
> -     case 15625:
> -             t |=3D AD7998_CYC_TCONF_32;
> -             break;
> -     case 7812:
> -             t |=3D AD7998_CYC_TCONF_64;
> -             break;
> -     case 3906:
> -             t |=3D AD7998_CYC_TCONF_128;
> -             break;
> -     case 1953:
> -             t |=3D AD7998_CYC_TCONF_256;
> -             break;
> -     case 976:
> -             t |=3D AD7998_CYC_TCONF_512;
> -             break;
> -     case 488:
> -             t |=3D AD7998_CYC_TCONF_1024;
> -             break;
> -     case 244:
> -             t |=3D AD7998_CYC_TCONF_2048;
> -             break;
> -     case  0:
> -             t |=3D AD7998_CYC_DIS;
> -             break;
> -     default:
> +     for (i =3D 0; i < ARRAY_SIZE(ad7998_frequencies); i++)
> +             if (val =3D=3D ad7998_frequencies[i])
> +                     break;
> +     if (i =3D=3D ARRAY_SIZE(ad7998_frequencies)) {
>               ret =3D -EINVAL;
>               goto error_ret_mutex;
>       }
> -
> +     t |=3D i;
>       ret =3D ad799x_i2c_write8(st, AD7998_CYCLE_TMR_REG, t);
>
>  error_ret_mutex:

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
