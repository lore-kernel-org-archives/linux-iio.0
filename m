Return-Path: <SRS0=dOAm=JU=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <d6f374da848179583f86bfc965125ebf2e4d8317.1530710826.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530710826.git.nikolaus.voss@loewensteinmedical.de> <d6f374da848179583f86bfc965125ebf2e4d8317.1530710826.git.nikolaus.voss@loewensteinmedical.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jul 2018 19:15:07 +0300
Message-ID: <CAHp75Vd-cak8m_uqJs=L1eX2z_TFbCUHcbLKrRJ20C3GP--uUg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>, Javier Martinez Canillas <javier@dowhile0.org>,
	linux-iio <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> struct i2c_device_id argument of probe() is not used, so use probe_new()
> instead.
>

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

After Javier's explanations it's more clear now why we leave i2c ID table.

> Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
> ---
>  drivers/iio/accel/st_accel_i2c.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/st_accel_i2c.c b/drivers/iio/accel/st_accel_i2c.c
> index c6e08c834f11..0659e9a67f85 100644
> --- a/drivers/iio/accel/st_accel_i2c.c
> +++ b/drivers/iio/accel/st_accel_i2c.c
> @@ -138,8 +138,7 @@ static const struct i2c_device_id st_accel_id_table[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);
>
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -                                               const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev;
>         struct st_sensor_data *adata;
> @@ -179,7 +178,7 @@ static struct i2c_driver st_accel_driver = {
>                 .of_match_table = of_match_ptr(st_accel_of_match),
>                 .acpi_match_table = ACPI_PTR(st_accel_acpi_match),
>         },
> -       .probe = st_accel_i2c_probe,
> +       .probe_new = st_accel_i2c_probe,
>         .remove = st_accel_i2c_remove,
>         .id_table = st_accel_id_table,
>  };
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
