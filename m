Return-Path: <daniel.baluta@gmail.com>
MIME-Version: 1.0
Sender: daniel.baluta@gmail.com
In-Reply-To: <56c6ad5c63292495b1dc3e3e78f626789ff4ea9f.1434492557.git.knaack.h@gmx.de>
References: <cover.1434492557.git.knaack.h@gmx.de>
	<56c6ad5c63292495b1dc3e3e78f626789ff4ea9f.1434492557.git.knaack.h@gmx.de>
Date: Wed, 17 Jun 2015 13:05:57 +0300
Message-ID: <CAEnQRZAwZxRgm6UXK+4eWqVtSt+o6bUbbK3FkKyOWSMj=ihxUQ@mail.gmail.com>
Subject: Re: [PATCH 2/7] iio:light:Kconfig: fix typo in description
From: Daniel Baluta <daniel.baluta@intel.com>
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Kevin Tsai <ktsai@capellamicro.com>,
	Daniel Baluta <daniel.baluta@intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, Jun 17, 2015 at 1:17 AM, Hartmut Knaack <knaack.h@gmx.de> wrote:
> Fix the typo in the module description for the CM3323.
>
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>

Reviewed-by: Daniel Baluta <daniel.baluta@intel.com>

> ---
>  drivers/iio/light/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index e6198b7..554f8ee 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -86,7 +86,7 @@ config CM3323
>         depends on I2C
>         tristate "Capella CM3323 color light sensor"
>         help
> -        Say Y here if you want to build a driver for Capela CM3323
> +        Say Y here if you want to build a driver for Capella CM3323
>          color sensor.
>
>          To compile this driver as a module, choose M here: the module will
> --
> 2.3.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
