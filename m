Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Device-drivers-devel@blackfin.uclinux.org"
	<Device-drivers-devel@blackfin.uclinux.org>
Date: Mon, 26 Sep 2011 08:37:36 +0100
Subject: RE: [PATCH 12/16] staging:iio:adc:ad7606 make gpio request failures
 more consistent
Message-ID: <544AC56F16B56944AEC3BD4E3D59177146E7272AD9@LIMKCMBX1.ad.analog.com>
References: <1316779302-12357-1-git-send-email-jic23@cam.ac.uk>
 <1316779302-12357-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1316779302-12357-13-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-09-23:
> To my mind, if a gpio is specified in the board file, yet fails
> to be successfully requested, that is an error condidtion and
> the driver should not muddle on regardless.
>
> This does mean unwinding the gpios on error. Also the free_gpios
> function is reordered so that it is consistent with the request one
> (reverse order obviously).
>
> This patch is the category of not technically fixing anything, just
> making the driver be more in line with what a reviewer will expect.
>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>  drivers/staging/iio/adc/ad7606.h      |    5 -
>  drivers/staging/iio/adc/ad7606_core.c |  135 +++++++++++++++++++++----
>  -------- drivers/staging/iio/adc/ad7606_ring.c |    2 +- 3 files
>  changed, 86 insertions(+), 56 deletions(-)
> diff --git a/drivers/staging/iio/adc/ad7606.h
> b/drivers/staging/iio/adc/ad7606.h index b8b3d8e..8fc259f 100644 ---
> a/drivers/staging/iio/adc/ad7606.h +++
> b/drivers/staging/iio/adc/ad7606.h @@ -75,11 +75,6 @@ struct
> ad7606_state {
>       unsigned                        range;
>       unsigned                        oversampling;
>       bool                            done;
> -     bool                            have_frstdata;
> -     bool                            have_os;
> -     bool                            have_stby;
> -     bool                            have_reset;
> -     bool                            have_range;
>       void __iomem                    *base_address;
>
>       /*
> diff --git a/drivers/staging/iio/adc/ad7606_core.c
> b/drivers/staging/iio/adc/ad7606_core.c index 02b0a5b..e762acb 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c +++
> b/drivers/staging/iio/adc/ad7606_core.c @@ -26,7 +26,7 @@
>
>  int ad7606_reset(struct ad7606_state *st)
>  {
> -     if (st->have_reset) {
> +     if (gpio_is_valid(st->pdata->gpio_reset)) {
>               gpio_set_value(st->pdata->gpio_reset, 1);
>               ndelay(100); /* t_reset >=3D 100ns */
>               gpio_set_value(st->pdata->gpio_reset, 0);
> @@ -48,7 +48,7 @@ static int ad7606_scan_direct(struct iio_dev
> *indio_dev, unsigned ch)
>       if (ret)
>               goto error_ret;
> -     if (st->have_frstdata) {
> +     if (gpio_is_valid(st->pdata->gpio_frstdata)) {
>               ret =3D st->bops->read_block(st->dev, 1, st->data);
>               if (ret)
>                       goto error_ret;
> @@ -214,12 +214,14 @@ static mode_t ad7606_attr_is_visible(struct
> kobject *kobj,
>
>       mode_t mode =3D attr->mode;
> -     if (!st->have_os &&
> -             (attr =3D=3D &iio_dev_attr_oversampling_ratio.dev_attr.attr=
 ||
> -             attr =3D=3D
> -
>       &iio_const_attr_oversampling_ratio_available.dev_attr.attr))
> +     if (!(gpio_is_valid(st->pdata->gpio_os0) &&
> +           gpio_is_valid(st->pdata->gpio_os1) &&
> +           gpio_is_valid(st->pdata->gpio_os2)) &&
> +         (attr =3D=3D &iio_dev_attr_oversampling_ratio.dev_attr.attr ||
> +          attr =3D=3D
> +          &iio_const_attr_oversampling_ratio_available.dev_attr.attr))
>               mode =3D 0;
> -     else if (!st->have_range &&
> +     else if (!gpio_is_valid(st->pdata->gpio_range) &&
>                (attr =3D=3D &iio_dev_attr_in_voltage_range.dev_attr.attr =
||
>                 attr =3D=3D
> &iio_const_attr_in_voltage_range_available.dev_attr.attr))
> @@ -321,63 +323,96 @@ static int ad7606_request_gpios(struct
> ad7606_state *st)
>       };
>       int ret;
> -     ret =3D gpio_request_one(st->pdata->gpio_convst, GPIOF_OUT_INIT_LOW=
,
> -                            "AD7606_CONVST"); -      if (ret) { -       =
     dev_err(st->dev, "failed to
> request GPIO CONVST\n"); -            return ret; +   if
> (gpio_is_valid(st->pdata->gpio_convst)) { +           ret =3D
> gpio_request_one(st->pdata->gpio_convst, +                               =
    GPIOF_OUT_INIT_LOW,
> +                                    "AD7606_CONVST"); +              if =
(ret) { +                    dev_err(st->dev, "failed
> to request GPIO CONVST\n"); +                 goto error_ret; +          =
     } +     } else { +              ret =3D
> -EIO; +               goto error_ret;
>       }
> -     ret =3D gpio_request_array(gpio_array, ARRAY_SIZE(gpio_array));
> -     if (!ret)
> -             st->have_os =3D true;
> -
> -     ret =3D gpio_request_one(st->pdata->gpio_reset, GPIOF_OUT_INIT_LOW,
> -                            "AD7606_RESET");
> -     if (!ret)
> -             st->have_reset =3D true;
> +     if (gpio_is_valid(st->pdata->gpio_os0) &&
> +         gpio_is_valid(st->pdata->gpio_os1) &&
> +         gpio_is_valid(st->pdata->gpio_os2)) {
> +             ret =3D gpio_request_array(gpio_array,
> ARRAY_SIZE(gpio_array));
> +             if (ret < 0)
> +                     goto error_free_convst;
> +     }
>
> -     ret =3D gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_OUT |
> -                             ((st->range =3D=3D 10000) ? GPIOF_INIT_HIGH=
 :
> -                             GPIOF_INIT_LOW), "AD7606_RANGE");
> -     if (!ret)
> -             st->have_range =3D true;
> +     if (gpio_is_valid(st->pdata->gpio_reset)) {
> +             ret =3D gpio_request_one(st->pdata->gpio_reset,
> +                                    GPIOF_OUT_INIT_LOW,
> +                                    "AD7606_RESET");
> +             if (ret < 0)
> +                     goto error_free_os;
> +     }
>
> -     ret =3D gpio_request_one(st->pdata->gpio_stby, GPIOF_OUT_INIT_HIGH,
> -                            "AD7606_STBY");
> -     if (!ret)
> -             st->have_stby =3D true;
> +     if (gpio_is_valid(st->pdata->gpio_range)) {
> +             ret =3D gpio_request_one(st->pdata->gpio_range, GPIOF_DIR_O=
UT
> |
> +                                    ((st->range =3D=3D 10000) ? GPIOF_IN=
IT_HIGH
> :
> +                                     GPIOF_INIT_LOW), "AD7606_RANGE");
> +             if (ret < 0)
> +                     goto error_free_reset;
> +     }
> +     if (gpio_is_valid(st->pdata->gpio_stby)) {
> +             ret =3D gpio_request_one(st->pdata->gpio_stby,
> +                                    GPIOF_OUT_INIT_HIGH,
> +                                    "AD7606_STBY");
> +             if (ret < 0)
> +                     goto error_free_range;
> +     }
>
>       if (gpio_is_valid(st->pdata->gpio_frstdata)) {
>               ret =3D gpio_request_one(st->pdata->gpio_frstdata, GPIOF_IN=
,
>                                      "AD7606_FRSTDATA");
> -             if (!ret)
> -                     st->have_frstdata =3D true;
> +             if (ret < 0)
> +                     goto error_free_stby;
>       }
>
>       return 0;
> + +error_free_stby: + if (gpio_is_valid(st->pdata->gpio_stby))
> +             gpio_free(st->pdata->gpio_stby); +error_free_range: +   if
> (gpio_is_valid(st->pdata->gpio_range))
> +             gpio_free(st->pdata->gpio_range); +error_free_reset: +  if
> (gpio_is_valid(st->pdata->gpio_reset))
> +             gpio_free(st->pdata->gpio_reset); +error_free_os: +     if
> (gpio_is_valid(st->pdata->gpio_os0) && +
> gpio_is_valid(st->pdata->gpio_os1) && +
> gpio_is_valid(st->pdata->gpio_os2)) +         gpio_free_array(gpio_array,
> ARRAY_SIZE(gpio_array)); +error_free_convst:
> +     gpio_free(st->pdata->gpio_convst); +error_ret: +        return ret;
>  }
>
>  static void ad7606_free_gpios(struct ad7606_state *st)
>  {
> -     if (st->have_range) -           gpio_free(st->pdata->gpio_range); -=
 -   if
> (st->have_stby) +     if (gpio_is_valid(st->pdata->gpio_frstdata))
> +             gpio_free(st->pdata->gpio_frstdata); +  if
> (gpio_is_valid(st->pdata->gpio_stby))
>               gpio_free(st->pdata->gpio_stby);
> - -   if (st->have_os) { -            gpio_free(st->pdata->gpio_os0);
> -             gpio_free(st->pdata->gpio_os1); +       if
> (gpio_is_valid(st->pdata->gpio_range))
> +             gpio_free(st->pdata->gpio_range); +     if
> (gpio_is_valid(st->pdata->gpio_reset))
> +             gpio_free(st->pdata->gpio_reset); +     if
> (gpio_is_valid(st->pdata->gpio_os0) && +
> gpio_is_valid(st->pdata->gpio_os1) && +
> gpio_is_valid(st->pdata->gpio_os2)) {
>               gpio_free(st->pdata->gpio_os2);
> +             gpio_free(st->pdata->gpio_os1);
> +             gpio_free(st->pdata->gpio_os0);
>       }
> -
> -     if (st->have_reset)
> -             gpio_free(st->pdata->gpio_reset);
> -
> -     if (st->have_frstdata)
> -             gpio_free(st->pdata->gpio_frstdata);
> -
>       gpio_free(st->pdata->gpio_convst);
>  }
> @@ -531,8 +566,8 @@ void ad7606_suspend(struct iio_dev *indio_dev)
>  {
>       struct ad7606_state *st =3D iio_priv(indio_dev);
> -     if (st->have_stby) {
> -             if (st->have_range)
> +     if (gpio_is_valid(st->pdata->gpio_stby)) {
> +             if (gpio_is_valid(st->pdata->gpio_range))
>                       gpio_set_value(st->pdata->gpio_range, 1);
>               gpio_set_value(st->pdata->gpio_stby, 0);        } @@ -542,8=
 +577,8 @@ void
>  ad7606_resume(struct iio_dev *indio_dev) {   struct ad7606_state *st =3D
>  iio_priv(indio_dev);
> -     if (st->have_stby) {
> -             if (st->have_range)
> +     if (gpio_is_valid(st->pdata->gpio_stby)) {
> +             if (gpio_is_valid(st->pdata->gpio_range))
>                       gpio_set_value(st->pdata->gpio_range,
>                                       st->range =3D=3D 10000);
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c
> b/drivers/staging/iio/adc/ad7606_ring.c index 0b60a6e..f0742d6 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c +++
> b/drivers/staging/iio/adc/ad7606_ring.c @@ -110,7 +110,7 @@ static void
> ad7606_poll_bh_to_ring(struct work_struct *work_s)
>       if (buf =3D=3D NULL)
>               return;
> -     if (st->have_frstdata) {
> +     if (gpio_is_valid(st->pdata->gpio_frstdata)) {
>               ret =3D st->bops->read_block(st->dev, 1, buf);
>               if (ret)
>                       goto done;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
