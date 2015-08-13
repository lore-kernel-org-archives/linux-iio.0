Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.02.1508131044250.30726@pmeerw.net>
References: <1439450079-2703-1-git-send-email-cmo@melexis.com> <alpine.DEB.2.02.1508131044250.30726@pmeerw.net>
From: Crt Mori <cmo@melexis.com>
Date: Thu, 13 Aug 2015 11:12:10 +0200
Message-ID: <CAKv63us8NL7FiBOteGTdGBXG5Lxo3Lw8rSzv=aix-snDsrqpNQ@mail.gmail.com>
Subject: Re: [PATCH] iio: mlx90614: Implement filter configuration
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Vianney le Clement de Saint-Marcq <vianney.leclement@essensium.com>, Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On 13 August 2015 at 10:58, Peter Meerwald <pmeerw@pmeerw.net> wrote:
> On Thu, 13 Aug 2015, Crt Mori wrote:
>
>> Implemented Low pass 3db frequency filter which configures
>> FIR and IIR values within the configuration register of EEPROM.
>> For more standardized interface we have fixed the FIR value
>> to 1024, while changes in IIR value are directly connected to
>> filter responses. The new datasheet version will provide a
>> simplified table (also in reStructured text format below) with
>> this change, to provide quick overview of possible settings.
>
> nitpicking below
>
> the patch add .owner =3D THIS_MODULE, which is unrelated to the rest of t=
he
> patch
>
Ty for noticing - it is already in there, dont know why diff marked it.
>> Below sensor timings (bandwidth) are calculated for 3db frequency
>> low pass filter.
>>
>> +--------------------+-----------------+
>> | Filter setting (%) | Band width (Hz) |
>> |  (rounded to 1.0)  |                 |
>> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>> |         13         |      0.15       |
>> +--------------------+-----------------+
>> |         17         |      0.20       |
>> +--------------------+-----------------+
>> |         25         |      0.31       |
>> +--------------------+-----------------+
>> |         50         |      0.77       |
>> +--------------------+-----------------+
>> |         57         |      0.86       |
>> +--------------------+-----------------+
>> |         67         |      1.10       |
>> +--------------------+-----------------+
>> |         80         |      1.53       |
>> +--------------------+-----------------+
>> |        100         |      7.23       |
>> +--------------------+-----------------+
>>
>> The diff is made towards togreg branch. Added myself to MAINTAINERS and =
authors
>> as per discussion with Jonathan.
>>
>> Signed-off-by: Crt Mori <cmo@melexis.com>
>> ---
>>  MAINTAINERS                        |  7 ++++
>>  drivers/iio/temperature/mlx90614.c | 76 +++++++++++++++++++++++++++++++=
+++++--
>>  2 files changed, 80 insertions(+), 3 deletions(-)
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 8133cef..f658890 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -6739,6 +6739,13 @@ S:     Supported
>>  F:   include/linux/mlx5/
>>  F:   drivers/infiniband/hw/mlx5/
>>
>> +MELEXIS MLX90614 DRIVER
>> +M:   Crt Mori <cmo@melexis.com>
>> +L:   linux-iio@vger.kernel.org
>> +W:   http://www.melexis.com
>> +S:   Supported
>> +F:   drivers/iio/temperature/mlx90614.c
>> +
>>  MN88472 MEDIA DRIVER
>>  M:   Antti Palosaari <crope@iki.fi>
>>  L:   linux-media@vger.kernel.org
>> diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperatur=
e/mlx90614.c
>> index 5d033a5..c03cbb4 100644
>> --- a/drivers/iio/temperature/mlx90614.c
>> +++ b/drivers/iio/temperature/mlx90614.c
>> @@ -3,6 +3,7 @@
>>   *
>>   * Copyright (c) 2014 Peter Meerwald <pmeerw@pmeerw.net>
>>   * Copyright (c) 2015 Essensium NV
>> + * Copyright (c) 2015 Melexis
>>   *
>>   * This file is subject to the terms and conditions of version 2 of
>>   * the GNU General Public License.  See the file COPYING in the main
>> @@ -20,7 +21,6 @@
>>   * always has a pull-up so we do not need an extra GPIO to drive it hig=
h.  If
>>   * the "wakeup" GPIO is not given, power management will be disabled.
>>   *
>> - * TODO: filter configuration
>>   */
>>
>>  #include <linux/err.h>
>> @@ -79,6 +79,26 @@ struct mlx90614_data {
>>       unsigned long ready_timestamp; /* in jiffies */
>>  };
>>
>> +/* Allowed percentage values for IIR filtering */
>> +static const u8 mlx90614_iir_values[] =3D {50, 25, 17, 13, 100, 80, 67,=
 57};
>> +
>> +/*
>> + * Find the IIR value inside mlx90614_iir_values array and return its p=
osition
>> + * which is equivalent of the bit value in sensor register
>
> equivalent to
>
agreed.
>> + */
>> +static inline s32 mlx90614_iir_search(int value)
>> +{
>> +     u8 i;
>> +     if (value < 0 || value > 100)
>> +             return -EINVAL;
>> +
>> +     for (i=3D0; i < ARRAY_SIZE(mlx90614_iir_values); ++i) {
>
> i =3D 0
>
agreed.
>> +             if (value =3D=3D mlx90614_iir_values[i])
>> +                     return i;
>> +     }
>> +     return -EINVAL;
>> +}
>> +
>>  /*
>>   * Erase an address and write word.
>>   * The mutex must be locked before calling.
>> @@ -236,6 +256,19 @@ static int mlx90614_read_raw(struct iio_dev *indio_=
dev,
>>                       *val2 =3D ret * MLX90614_CONST_EMISSIVITY_RESOLUTI=
ON;
>>               }
>>               return IIO_VAL_INT_PLUS_NANO;
>> +     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR setting w=
ith
>> +                                                          FIR =3D 1024 =
*/
>> +             mlx90614_power_get(data, false);
>> +             mutex_lock(&data->lock);
>> +             ret =3D i2c_smbus_read_word_data(data->client,MLX90614_CON=
FIG);
>
> space after ,
>
thank you for noticing.
>> +             mutex_unlock(&data->lock);
>> +             mlx90614_power_put(data);
>> +
>> +             if (ret < 0)
>> +                     return ret;
>> +
>> +             *val =3D mlx90614_iir_values[ret & MLX90614_CONFIG_IIR_MAS=
K];
>> +             return IIO_VAL_INT;
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -263,6 +296,37 @@ static int mlx90614_write_raw(struct iio_dev *indio=
_dev,
>>               mlx90614_power_put(data);
>>
>>               return ret;
>> +     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY: /* IIR Filter se=
tting */
>> +             mlx90614_power_get(data, false);
>> +             mutex_lock(&data->lock);
>> +
>> +             ret =3D mlx90614_iir_search(val);
>> +             if (ret >=3D 0) {
>> +                     /* If there is no error, then we have a sensor
>> +                      * equivalent value in ret. We need to store it
>> +                      * temporary to val, as we still have more data
>> +                      * to save in ret before we can actually write*/
>
> this is not a proper multi-line comment (here and elsewhere)
> add space before */
>
Will change that - was not really focused on this.
>> +                     val =3D ret;
>> +
>> +                     /* CONFIG register values must not be changed so
>> +                      * we must read them before we actually write
>> +                      * changes*/
>> +                     ret =3D i2c_smbus_read_word_data(data->client,
>> +                                                    MLX90614_CONFIG);
>> +                     if (ret >=3D 0) {
>> +                             /* Write changed values */
>> +                             ret =3D mlx90614_write_word(data->client,
>> +                                     MLX90614_CONFIG,
>> +                                     (val << MLX90614_CONFIG_IIR_SHIFT)=
 |
>> +                                     (((u16) ((0x7 << MLX90614_CONFIG_F=
IR_SHIFT) |
>> +                                     ((u16) ret & (~((u16) MLX90614_CON=
FIG_FIR_MASK))))) &
>> +                                     (~(u16) MLX90614_CONFIG_IIR_MASK))=
);
>
> are these u16 needed?
>
I would assume they are - or at least prefer to have them (I like
things defined). Any objection against them?

>> +                     }
>> +             }
>> +             mutex_unlock(&data->lock);
>> +             mlx90614_power_put(data);
>> +
>> +             return ret;
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -275,6 +339,8 @@ static int mlx90614_write_raw_get_fmt(struct iio_dev=
 *indio_dev,
>>       switch (mask) {
>>       case IIO_CHAN_INFO_CALIBEMISSIVITY:
>>               return IIO_VAL_INT_PLUS_NANO;
>> +     case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>> +             return IIO_VAL_INT_PLUS_MICRO;
>>       default:
>>               return -EINVAL;
>>       }
>> @@ -294,7 +360,8 @@ static const struct iio_chan_spec mlx90614_channels[=
] =3D {
>>               .modified =3D 1,
>>               .channel2 =3D IIO_MOD_TEMP_OBJECT,
>>               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> -                 BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>> +                 BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>> +                     BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>>               .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
>>                   BIT(IIO_CHAN_INFO_SCALE),
>>       },
>> @@ -305,7 +372,8 @@ static const struct iio_chan_spec mlx90614_channels[=
] =3D {
>>               .channel =3D 1,
>>               .channel2 =3D IIO_MOD_TEMP_OBJECT,
>>               .info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>> -                 BIT(IIO_CHAN_INFO_CALIBEMISSIVITY),
>> +                 BIT(IIO_CHAN_INFO_CALIBEMISSIVITY) |
>> +                     BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
>>               .info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_OFFSET) |
>>                   BIT(IIO_CHAN_INFO_SCALE),
>>       },
>> @@ -559,6 +627,7 @@ static const struct dev_pm_ops mlx90614_pm_ops =3D {
>>  static struct i2c_driver mlx90614_driver =3D {
>>       .driver =3D {
>>               .name   =3D "mlx90614",
>> +             .owner  =3D THIS_MODULE,
>>               .pm     =3D &mlx90614_pm_ops,
>>       },
>>       .probe =3D mlx90614_probe,
>> @@ -569,5 +638,6 @@ module_i2c_driver(mlx90614_driver);
>>
>>  MODULE_AUTHOR("Peter Meerwald <pmeerw@pmeerw.net>");
>>  MODULE_AUTHOR("Vianney le Cl=C3=A9ment de Saint-Marcq <vianney.leclemen=
t@essensium.com>");
>> +MODULE_AUTHOR("Crt Mori <cmo@melexis.com>");
>>  MODULE_DESCRIPTION("Melexis MLX90614 contactless IR temperature sensor =
driver");
>>  MODULE_LICENSE("GPL");
>>
>
> --
>
> Peter Meerwald
> +43-664-2444418 (mobile)
