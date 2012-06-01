Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
Date: Fri, 1 Jun 2012 10:24:32 +0100
Subject: RE: [PATCH 6/8] staging:iio:accel:adis16204 support the rss channel
 via chan spec.
Message-ID: <544AC56F16B56944AEC3BD4E3D59177150C0FE65CA@LIMKCMBX1.ad.analog.com>
References: <1338406866-3833-1-git-send-email-jic23@kernel.org>
 <1338406866-3833-7-git-send-email-jic23@kernel.org>
In-Reply-To: <1338406866-3833-7-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2012-05-30:
> Reduces code and makes this channel available within the kernel.
> Note that it is not added to the buffer, thus maintaining the
> previous functionality of this driver.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Acked-by: Michael Hennerich <michael.hennerich@analog.com>
> ---
>  drivers/staging/iio/accel/adis16204_core.c |   83 ++++++++++----------
>  -------- 1 file changed, 29 insertions(+), 54 deletions(-)
> diff --git a/drivers/staging/iio/accel/adis16204_core.c
> b/drivers/staging/iio/accel/adis16204_core.c index a36135d..cb8701d
> 100644 --- a/drivers/staging/iio/accel/adis16204_core.c +++
> b/drivers/staging/iio/accel/adis16204_core.c @@ -169,32 +169,6 @@
> error_ret:
>       return ret;
>  }
> -static ssize_t adis16204_read_14bit_signed(struct device *dev,
> -             struct device_attribute *attr, -                char *buf) =
-{ - struct iio_dev
> *indio_dev =3D dev_to_iio_dev(dev); -   struct iio_dev_attr *this_attr =
=3D
> to_iio_dev_attr(attr); -      s16 val =3D 0; -  ssize_t ret; -
> -     mutex_lock(&indio_dev->mlock); - -      ret =3D
> adis16204_spi_read_reg_16(indio_dev, -                                   =
     this_attr->address, (u16
> *)&val); -    if (!ret) { -           if (val & ADIS16204_ERROR_ACTIVE)
> -                     adis16204_check_status(indio_dev); - -          val=
 =3D ((s16)(val << 2) >>
> 2); -         ret =3D sprintf(buf, "%d\n", val); -      } -
> -     mutex_unlock(&indio_dev->mlock); - -    return ret; -} -
>  static int adis16204_reset(struct iio_dev *indio_dev) {      int ret; @@
>  -282,16 +256,6 @@ err_ret: }
>
>  /* Unique to this driver currently */
> -#define IIO_DEV_ATTR_ACCEL_XY(_show, _addr)                  \
> -     IIO_DEVICE_ATTR(in_accel_xy, S_IRUGO, _show, NULL, _addr) -#define
> IIO_DEV_ATTR_ACCEL_XYPEAK(_show, _addr)               \
> -     IIO_DEVICE_ATTR(in_accel_xypeak, S_IRUGO, _show, NULL, _addr) -
> -static IIO_DEV_ATTR_ACCEL_XY(adis16204_read_14bit_signed,
> -             ADIS16204_XY_RSS_OUT); -static
> IIO_DEV_ATTR_ACCEL_XYPEAK(adis16204_read_14bit_signed,
> -             ADIS16204_XY_PEAK_OUT); -static IIO_CONST_ATTR(in_accel_xy_=
scale,
> "0.017125");
>
>  enum adis16204_channel {     in_supply, @@ -299,9 +263,10 @@ enum
>  adis16204_channel {  temp,   accel_x,        accel_y, +      accel_xy, }=
;
> -static u8 adis16204_addresses[5][3] =3D {
> +static u8 adis16204_addresses[6][3] =3D {
>       [in_supply] =3D { ADIS16204_SUPPLY_OUT },         [in_aux] =3D {
>  ADIS16204_AUX_ADC },         [temp] =3D { ADIS16204_TEMP_OUT }, @@ -309,=
6 +274,8
>  @@ static u8 adis16204_addresses[5][3] =3D {                 ADIS16204_X=
_PEAK_OUT
>  },   [accel_y] =3D { ADIS16204_XACCL_OUT, ADIS16204_YACCL_NULL,
>  ADIS16204_Y_PEAK_OUT },
> +     [accel_xy] =3D { ADIS16204_XY_RSS_OUT, 0,
> +                    ADIS16204_XY_PEAK_OUT },
>  };
>
>  static int adis16204_read_raw(struct iio_dev *indio_dev,
> @@ -362,10 +329,16 @@ static int adis16204_read_raw(struct iio_dev
> *indio_dev,
>                       return IIO_VAL_INT_PLUS_MICRO;
>               case IIO_ACCEL:
>                       *val =3D 0;
> -                     if (chan->channel2 =3D=3D IIO_CHAN_MOD_X)
> -                             *val2 =3D 17125;
> -                     else
> -                             *val2 =3D 8407;
> +                     switch (chan->channel2) {
> +                     case IIO_MOD_X:
> +                     case IIO_MOD_ROOT_SUM_SQUARED_X_Y:
> +                             *val2 =3D 17125;
> +                             break;
> +                     case IIO_MOD_Y:
> +                     case IIO_MOD_Z:
> +                             *val2 =3D 8407;
> +                             break;
> +                     }
>                       return IIO_VAL_INT_PLUS_MICRO;
>               default:
>                       return -EINVAL;
> @@ -498,21 +471,23 @@ static struct iio_chan_spec adis16204_channels[]
> =3D {
>               },
>       },
>       IIO_CHAN_SOFT_TIMESTAMP(5),
> -}; - -static struct attribute *adis16204_attributes[] =3D {
> -     &iio_dev_attr_in_accel_xy.dev_attr.attr,
> -     &iio_dev_attr_in_accel_xypeak.dev_attr.attr,
> -     &iio_const_attr_in_accel_xy_scale.dev_attr.attr, -      NULL -}; - =
-static
> const struct attribute_group adis16204_attribute_group =3D { -  .attrs =
=3D
> adis16204_attributes, +       { +             .type =3D IIO_ACCEL, +     =
       .modified =3D 1,
> +             .channel2 =3D IIO_MOD_ROOT_SUM_SQUARED_X_Y, +             .=
info_mask =3D
> IIO_CHAN_INFO_RAW_SEPARATE_BIT | +            IIO_CHAN_INFO_SCALE_SEPARAT=
E_BIT |
> +             IIO_CHAN_INFO_PEAK_SEPARATE_BIT, +              .address =
=3D accel_xy,
> +             .scan_type =3D { +                        .sign =3D 'u', + =
                 .realbits =3D 14, +                       .storagebits
> =3D 16, +               }, +    }
>  };
>
>  static const struct iio_info adis16204_info =3D { -    .attrs =3D
>  &adis16204_attribute_group,  .read_raw =3D &adis16204_read_raw,
>       .write_raw =3D &adis16204_write_raw,      .driver_module =3D THIS_M=
ODULE,
> @@ -549,7 +524,7 @@ static int __devinit adis16204_probe(struct
> spi_device *spi)
>
>       ret =3D iio_buffer_register(indio_dev,
>                                 adis16204_channels,
> -                               ARRAY_SIZE(adis16204_channels));
> +                               6);
>       if (ret) {
>               printk(KERN_ERR "failed to initialize the ring\n");
>               goto error_unreg_ring_funcs;

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Mar=
garet Seif
