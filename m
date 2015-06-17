Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <85963fe04c08265ef959962e9cbdd2a0969b6330.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
	<85963fe04c08265ef959962e9cbdd2a0969b6330.1434492557.git.knaack.h@gmx.de>
Date: Wed, 17 Jun 2015 13:17:47 +0300
Message-ID: <CAEnQRZBMdAmL=HwXLqT5cRxBLQfkKorskz+JY7b3=temG_Wing@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio:light:cm3323: add empty lines for code structure
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Add some empty lines to visually separate logical structure blocks, as
> after if-blocks or before regular returns.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/cm3323.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iio/light/cm3323.c b/drivers/iio/light/cm3323.c
> index 4f362d5..fbd841e 100644
> --- a/drivers/iio/light/cm3323.c
> +++ b/drivers/iio/light/cm3323.c
> @@ -131,9 +131,11 @@ static int cm3323_set_it_bits(struct cm3323_data *data, int val, int val2)
>                                 return ret;
>
>                         data->reg_conf = reg_conf;
> +
>                         return 0;
>                 }
>         }
> +
>         return -EINVAL;
>  }
>
> @@ -146,6 +148,7 @@ static int cm3323_get_it_bits(struct cm3323_data *data)
>
>         if (bits >= ARRAY_SIZE(cm3323_int_time))
>                 return -EINVAL;
> +
>         return bits;
>  }
>
> @@ -241,11 +244,13 @@ static int cm3323_probe(struct i2c_client *client,
>                 dev_err(&client->dev, "cm3323 chip init failed\n");
>                 return ret;
>         }
> +
>         ret = iio_device_register(indio_dev);
>         if (ret < 0) {
>                 dev_err(&client->dev, "failed to register iio dev\n");
>                 goto err_init;
>         }
> +
>         return 0;
>  err_init:
>         cm3323_disable(indio_dev);
> --
