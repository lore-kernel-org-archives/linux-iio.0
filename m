Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <1423774815-26816-2-git-send-email-roberta.dobrescu@gmail.com>
References: <1423774815-26816-1-git-send-email-roberta.dobrescu@gmail.com>
	<1423774815-26816-2-git-send-email-roberta.dobrescu@gmail.com>
Date: Fri, 13 Feb 2015 09:59:14 +0200
Message-ID: <CAEnQRZAr9N1iNxEhqLo8_1tiKW0zhPztP9mhQxoZjdDojhdgpw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: light: jsa1212: Select REGMAP_I2C
From: Daniel Baluta <daniel.baluta@intel.com>
To: Roberta Dobrescu <roberta.dobrescu@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
	"octavian.purdila@intel.com" <octavian.purdila@intel.com>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Thu, Feb 12, 2015 at 11:00 PM, Roberta Dobrescu
<roberta.dobrescu@gmail.com> wrote:
> This patch adds missing 'select' statement for jsa1212 driver.
> Without regmap_i2c, we get the following error when loading the module:
> Unknown symbol devm_regmap_init_i2c.
>
> Signed-off-by: Roberta Dobrescu <roberta.dobrescu@gmail.com>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index ae68c64..e0ed374 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -126,6 +126,7 @@ config HID_SENSOR_PROX
>  config JSA1212
>         tristate "JSA1212 ALS and proximity sensor driver"
>         depends on I2C
> +       select REGMAP_I2C
>         help
>          Say Y here if you want to build a IIO driver for JSA1212
>          proximity & ALS sensor device.
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
