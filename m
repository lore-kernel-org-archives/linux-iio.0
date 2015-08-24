Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:34476 "EHLO
	mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754987AbbHXTc5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Aug 2015 15:32:57 -0400
Received: by qkfh127 with SMTP id h127so84137139qkf.1
        for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2015 12:32:56 -0700 (PDT)
MIME-Version: 1.0
From: Crt Mori <cmo@melexis.com>
Date: Mon, 24 Aug 2015 21:32:17 +0200
Message-ID: <CAKv63utOf0ozQoZp5NvdH_Aw-zTnwfOhs6VF9kBQrPpRwKqu_w@mail.gmail.com>
Subject: Re: [PATCH v5] iio: mlx90614: Implement filter configuration
To: Vianney le Clement de Saint-Marcq
	<vianney.leclement@essensium.com>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Any additional comments on version 5 or can it be applited?

Best regards,
Crt

On 17 August 2015 at 19:34, Crt Mori <cmo@melexis.com> wrote:
> Implemented Low pass 3db frequency filter which configures
> FIR and IIR values within the configuration register of EEPROM.
> For more standardized interface we have fixed the FIR value
> to 1024, while changes in IIR value are directly connected to
> filter responses. The new datasheet version will provide a
> simplified table (also in reStructured text format below) with
> this change, to provide quick overview of possible settings.
>
> Below sensor timings (bandwidth) are calculated for 3db frequency
> low pass filter.
>
> +--------------------+-----------------+
> | Filter setting (%) | Band width (Hz) |
> |  (rounded to 1.0)  |                 |
> +====================+=================+
> |         13         |      0.15       |
> +--------------------+-----------------+
> |         17         |      0.20       |
> +--------------------+-----------------+
> |         25         |      0.31       |
> +--------------------+-----------------+
> |         50         |      0.77       |
> +--------------------+-----------------+
> |         57         |      0.86       |
> +--------------------+-----------------+
> |         67         |      1.10       |
> +--------------------+-----------------+
> |         80         |      1.53       |
> +--------------------+-----------------+
> |        100         |      7.23       |
> +--------------------+-----------------+
>
> The diff is made towards togreg branch. Added myself to MAINTAINERS and
> authors as per discussion with Jonathan.
>
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  MAINTAINERS                        |  7 +++
>  drivers/iio/temperature/mlx90614.c | 90 ++++++++++++++++++++++++++++++++++++--
>  2 files changed, 94 insertions(+), 3 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8133cef..f658890 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6739,6 +6739,13 @@ S:       Supported
>  F:     include/linux/mlx5/
>  F:     drivers/infiniband/hw/mlx5/
>
> +MELEXIS MLX90614 DRIVER
> +M:     Crt Mori <cmo@melexis.com>
> +L:     linux-iio@vger.kernel.org
> +W:     http://www.melexis.com
> +S:     Supported
> +F:     drivers/iio/temperature/mlx90614.c
> +
>  MN88472 MEDIA DRIVER
>  M:     Antti Palosaari <crope@iki.fi>
>  L:     linux-media@vger.kernel.org
> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
> index 5d033a5..3fd3ba4 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -3,6 +3,7 @@
>   *
>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>   * Copyright (c) 2015 Essensium NV
> + * Copyright (c) 2015 Melexis
>   *
>   * This file is subject to the terms and conditions of version 2 of
>   * the GNU General Public License.  See the file COPYING in the main
> @@ -20,7 +21,6 @@
>   * always has a pull-up so we do not need an extra GPIO to drive it high.  If
>   * the "wakeup" GPIO is not given, power management will be disabled.
>   *
> - * TODO: filter configuration
>   */
>
>  #include <linux/err.h>
> @@ -32,6 +32,7 @@
>  #include <linux/pm_runtime.h>
>
>  #include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
>
>  #define MLX90614_OP_RAM                0x00
>  #define MLX90614_OP_EEPROM     0x20
> @@ -79,6 +80,20 @@ struct mlx90614_data {
>         unsigned long ready_timestamp; /* in jiffies */
>  };
>
> +/* Bandwidth values for IIR filtering */
> +static const int mlx90614_iir_values[] = {77, 31, 20, 15, 723, 153, 110, 86};
> +static IIO_CONST_ATTR(in_temp_object_filter_low_pass_3db_frequency_available,
> +                     "0.15 0.20 0.31 0.77 0.86 1.10 1.53 7.23");
> +
> +static struct attribute *mlx90614_attributes[] = {
> +       &iio_const_attr_in_temp_object_filter_low_pass_3db_frequency_available.dev_attr.attr,
> +       NULL,
> +};
> +
> +static const struct attribute_group mlx90614_attr_group = {
> +       .attrs = mlx90614_attributes,
> +};
> +
>  /*
>   * Erase an address and write word.
>   * The mutex must be locked before calling.
> @@ -117,6 +132,42 @@ static s32 mlx90614_write_word(const struct i2c_client *client, u8 command,
>         return ret;
>  }
>
> +/*
> + * Find the IIR value inside mlx90614_iir_values array and return its position
> + * which is equivalent to the bit value in sensor register
> + */
> +static inline s32 mlx90614_iir_search(const struct i2c_client *client,
> +                                     int value)
> +{
> +       int i;
> +       s32 ret;
> +
> +       for (i = 0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
> +               if (value == mlx90614_iir_values[i])
> +                       break;
> +       }
> +
> +       if (i == ARRAY_SIZE(mlx90614_iir_values))
> +               return -EINVAL;
> +
> +       /*
> +        * CONFIG register values must not be changed so
> +        * we must read them before we actually write
> +        * changes
> +        */
> +       ret = i2c_smbus_read_word_data(client, MLX90614_CONFIG);
> +       if (ret > 0)
> +               return ret;
> +
> +       /* Write changed values */
> +       ret = mlx90614_write_word(client, MLX90614_CONFIG,
> +                       (i << MLX90614_CONFIG_IIR_SHIFT) |
> +                       (((u16) ((0x7 << MLX90614_CONFIG_FIR_SHIFT) |
> +                       ((u16) ret & (~((u16) MLX90614_CONFIG_FIR_MASK))))) &
> +                       (~(u16) MLX90614_CONFIG_IIR_MASK)));
> +       return ret;
> +}
> +
>  #ifdef CONFIG_PM
>  /*
>   * If @startup is true, make sure MLX90614_TIMING_STARTUP ms have elapsed since
> @@ -236,6 +287,21 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
>                         *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>                 }
>                 return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting with
> +                                                            FIR = 1024 */
> +               mlx90614_power_get(data, false);
> +               mutex_lock(&data->lock);
> +               ret = i2c_smbus_read_word_data(data->client, MLX90614_CONFIG);
> +               mutex_unlock(&data->lock);
> +               mlx90614_power_put(data);
> +
> +               if (ret < 0)
> +                       return ret;
> +
> +               *val = mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] / 100;
> +               *val2 = (mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MASK] % 100) *
> +                       10000;
> +               return IIO_VAL_INT_PLUS_MICRO;
>         default:
>                 return -EINVAL;
>         }
> @@ -263,6 +329,18 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>                 mlx90614_power_put(data);
>
>                 return ret;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter setting */
> +               if (val < 0 || val2 < 0)
> +                       return -EINVAL;
> +
> +               mlx90614_power_get(data, false);
> +               mutex_lock(&data->lock);
> +               ret = mlx90614_iir_search(data->client,
> +                                         val * 100 + val2 / 10000);
> +               mutex_unlock(&data->lock);
> +               mlx90614_power_put(data);
> +
> +               return ret;
>         default:
>                 return -EINVAL;
>         }
> @@ -275,6 +353,8 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev *indio_dev,
>         switch (mask) {
>         case IIO_CHAN_INFO_CALIBEMISSIVITY:
>                 return IIO_VAL_INT_PLUS_NANO;
> +       case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +               return IIO_VAL_INT_PLUS_MICRO;
>         default:
>                 return -EINVAL;
>         }
> @@ -294,7 +374,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>                 .modified = 1,
>                 .channel2 = IIO_MOD_TEMP_OBJECT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                   BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> +                   BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
> +                       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>                     BIT(IIO_CHAN_INFO_SCALE),
>         },
> @@ -305,7 +386,8 @@ static const struct iio_chan_spec mlx90614_channels[] = {
>                 .channel = 1,
>                 .channel2 = IIO_MOD_TEMP_OBJECT,
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -                   BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
> +                   BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
> +                       BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>                 .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
>                     BIT(IIO_CHAN_INFO_SCALE),
>         },
> @@ -315,6 +397,7 @@ static const struct iio_info mlx90614_info = {
>         .read_raw = mlx90614_read_raw,
>         .write_raw = mlx90614_write_raw,
>         .write_raw_get_fmt = mlx90614_write_raw_get_fmt,
> +       .attrs = &mlx90614_attr_group,
>         .driver_module = THIS_MODULE,
>  };
>
> @@ -569,5 +652,6 @@ module_i2c_driver(mlx90614_driver);
>
>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
>  MODULE_AUTHOR("Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>");
> +MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
>  MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor driver");
>  MODULE_LICENSE("GPL");
> --
> 2.1.4
>
