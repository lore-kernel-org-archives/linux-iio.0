Return-Path: <SRS0=IK89=JT=gmail.com=andy.shevchenko@kernel.org>
MIME-Version: 1.0
In-Reply-To: <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530599660.git.nikolaus.voss@loewensteinmedical.de> <82c6f53cfa03f9bc7c0adfc423ae65fc986a1d25.1530599660.git.nikolaus.voss@loewensteinmedical.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 4 Jul 2018 01:54:48 +0300
Message-ID: <CAHp75Vd5f7Xj51ZKoxOWibrx4Bkh-HxkMwjKmEeumZm=WV2ksQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] IIO: st_accel_i2c.c: Use probe_new() instead of probe()
To: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>, Linus Walleij <linus.walleij@linaro.org>,
	Xiongfeng Wang <xiongfeng.wang@linaro.org>, nv@vosn.de, linux-iio@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-iio@vger.kernel.org>

On Tue, Jul 3, 2018 at 9:06 AM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> struct i2c_device_id argument of probe() is not used, so use probe_new()
> instead.
>

This makes...

>  MODULE_DEVICE_TABLE(i2c, st_accel_id_table);

...this table obsolete IIUC. At least that's what I did when switched
to ->probe_new() in some drivers.

If I'm mistaken (again? :-) ) I would hear from someone to point me
how it can be used after a switch.

>
> -static int st_accel_i2c_probe(struct i2c_client *client,
> -                                               const struct i2c_device_id *id)
> +static int st_accel_i2c_probe(struct i2c_client *client)
>  {
>         struct iio_dev *indio_dev;
>         struct st_sensor_data *adata;
> @@ -182,7 +181,7 @@ static struct i2c_driver st_accel_driver = {
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
