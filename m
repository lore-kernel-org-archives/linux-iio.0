Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 29 Jun 2015 14:19:06 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Crt Mori <cmo@melexis.com>
cc: linux-iio@vger.kernel.org,
    =?ISO-8859-15?Q?Vianney_le_Cl=E9ment_de_Saint-Marcq?= <vianney.leclement@essensium.com>,
    Johnathan Iain Cameron <jic23@kernel.org>
Subject: Re: [PATCH] iio: mlx90614: Replace offset sign and define magic
 numbers
In-Reply-To: <CAKv63uv5RZxmtVpMMAZ=xtTwMQZ8D=LxPHQ+ZHezj=814_m6eg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1506291413340.16737@pmeerw.net>
References: <CAKv63uv5RZxmtVpMMAZ=xtTwMQZ8D=LxPHQ+ZHezj=814_m6eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Translates the magic constant numbers to named macros and add some
> additional comments about their meaning. Also changed the offset to
> negative as usual equation is: (raw + offset)*scale and in this
> case offset should be negative (as we deduct 273.15 Kelvin to get
> temperature in Celsius).

looks good; strictly, this patch is
(a) a bugfix (the offset should be negative),
(b) cleanup to replace constants by macros

> The diff is made towards togreg branch as that branch seems to have the
> most recent updates of mlx90614 driver (many are yet to be merged).
> 
> Signed-off-by: Crt Mori <cmo@melexis.com>
> ---
>  drivers/iio/temperature/mlx90614.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/temperature/mlx90614.c
> b/drivers/iio/temperature/mlx90614.c
> index cb2e8ad..909278a 100644
> --- a/drivers/iio/temperature/mlx90614.c
> +++ b/drivers/iio/temperature/mlx90614.c
> @@ -65,6 +65,13 @@
> 
>  #define MLX90614_AUTOSLEEP_DELAY 5000 /* default autosleep delay */
> 
> +/* Magic constants */
> +#define MLX90614_CONST_OFFSET_DEC -13657 /* decimal part of the Kelvin
> offset */
> +#define MLX90614_CONST_OFFSET_REM 500000 /* remainder of offset
> (273.15*50) */
> +#define MLX90614_CONST_SCALE 20 /* Scale in milliKelvin (0.02 * 1000) */
> +#define MLX90614_CONST_RAW_EMISSIVITY_MAX 65535 /* max value for
> emissivity */
> +#define MLX90614_CONST_EMISSIVITY_RESOLUTION 15259 /* 1/65535 ~
> 0.000015259 */
> +
>  struct mlx90614_data {
>         struct i2c_client *client;
>         struct mutex lock; /* for EEPROM access only */
> @@ -204,11 +211,11 @@ static int mlx90614_read_raw(struct iio_dev
> *indio_dev,
>                 *val = ret;
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_OFFSET:
> -               *val = 13657;
> -               *val2 = 500000;
> +               *val = MLX90614_CONST_OFFSET_DEC;
> +               *val2 = MLX90614_CONST_OFFSET_REM;
>                 return IIO_VAL_INT_PLUS_MICRO;
>         case IIO_CHAN_INFO_SCALE:
> -               *val = 20;
> +               *val = MLX90614_CONST_SCALE;
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>                 mlx90614_power_get(data, false);
> @@ -221,12 +228,12 @@ static int mlx90614_read_raw(struct iio_dev
> *indio_dev,
>                 if (ret < 0)
>                         return ret;
> 
> -               if (ret == 65535) {
> +               if (ret == MLX90614_CONST_RAW_EMISSIVITY_MAX) {
>                         *val = 1;
>                         *val2 = 0;
>                 } else {
>                         *val = 0;
> -                       *val2 = ret * 15259; /* 1/65535 ~ 0.000015259 */
> +                       *val2 = ret * MLX90614_CONST_EMISSIVITY_RESOLUTION;
>                 }
>                 return IIO_VAL_INT_PLUS_NANO;
>         default:
> @@ -245,7 +252,8 @@ static int mlx90614_write_raw(struct iio_dev *indio_dev,
>         case IIO_CHAN_INFO_CALIBEMISSIVITY: /* 1/65535 / LSB */
>                 if (val < 0 || val2 < 0 || val > 1 || (val == 1 && val2 !=
> 0))
>                         return -EINVAL;
> -               val = val * 65535 + val2 / 15259; /* 1/65535 ~ 0.000015259
> */
> +               val = val * MLX90614_CONST_RAW_EMISSIVITY_MAX +
> +                       val2 / MLX90614_CONST_EMISSIVITY_RESOLUTION;
> 
>                 mlx90614_power_get(data, false);
>                 mutex_lock(&data->lock);
> 

-- 

Peter Meerwald
+43-664-2444418 (mobile)
