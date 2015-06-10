Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1433938228-4272-1-git-send-email-tiberiu.a.breana@intel.com>
References: <1433938228-4272-1-git-send-email-tiberiu.a.breana@intel.com>
Date: Wed, 10 Jun 2015 15:44:56 +0300
Message-ID: <CAEnQRZC6E3qxRefm6deX5uiGsfMEj3y8ncyvW5yJ2mN9xc9-Qg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: STK8BA50: replace scale table with a struct
From: Daniel Baluta <daniel.baluta@gmail.com>
To: Tiberiu Breana <tiberiu.a.breana@intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 10, 2015 at 3:10 PM, Tiberiu Breana
<tiberiu.a.breana@intel.com> wrote:
> Replaced the stk8ba50_scale_table with an identically named
> struct in order to make the code a bit more readable.

If this depends on your previous  "iio: accel: Add sampling rate
support for STK8BA50"
patch, please send them together in a patch series. It will be easier
to Jonathan to know
the exact order to apply this.

>
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
> ---
> Please disregard the previous patch.
> It slipped with a Change-Id and a 1/2 count.
> ---
>  drivers/iio/accel/stk8ba50.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 30950c6..93de7d0 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -29,6 +29,7 @@
>  #define STK8BA50_MODE_POWERBIT                 BIT(7)
>  #define STK8BA50_DATA_SHIFT                    6
>  #define STK8BA50_RESET_CMD                     0xB6
> +#define STK8BA50_2G_RANGE_IDX                  0

This seems unrelated to the current comit. Please send a separate patch for it.

Remember that a patch should address a single logical change.

>
>  #define STK8BA50_DRIVER_NAME                   "stk8ba50"
>
> @@ -50,7 +51,10 @@
>   *
>   * Locally, the range is stored as a table index.
>   */
> -static const int stk8ba50_scale_table[][2] = {
> +static const struct {
> +       u8 reg_val;
> +       u32 scale_val;
> +} stk8ba50_scale_table[] = {
>         {3, 38400}, {5, 76700}, {8, 153400}, {12, 306900}
>  };
>
> @@ -114,7 +118,7 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
>                 return IIO_VAL_INT;
>         case IIO_CHAN_INFO_SCALE:
>                 *val = 0;
> -               *val2 = stk8ba50_scale_table[data->range][1];
> +               *val2 = stk8ba50_scale_table[data->range].scale_val;
>                 return IIO_VAL_INT_PLUS_MICRO;
>         }
>
> @@ -136,7 +140,7 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
>                         return -EINVAL;
>
>                 for (i = 0; i < ARRAY_SIZE(stk8ba50_scale_table); i++)
> -                       if (val2 == stk8ba50_scale_table[i][1]) {
> +                       if (val2 == stk8ba50_scale_table[i].scale_val) {
>                                 index = i;
>                                 break;
>                         }
> @@ -145,7 +149,7 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
>
>                 ret = i2c_smbus_write_byte_data(data->client,
>                                 STK8BA50_REG_RANGE,
> -                               stk8ba50_scale_table[index][0]);
> +                               stk8ba50_scale_table[index].reg_val);
>                 if (ret < 0)
>                         dev_err(&data->client->dev,
>                                         "failed to set measurement range\n");
> @@ -226,7 +230,7 @@ static int stk8ba50_probe(struct i2c_client *client,
>         }
>
>         /* The default range is +/-2g */
> -       data->range = 0;
> +       data->range = STK8BA50_2G_RANGE_IDX;
>
>         ret = iio_device_register(indio_dev);
>         if (ret < 0) {
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
