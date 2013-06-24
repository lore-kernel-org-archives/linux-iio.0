Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-223.synserver.de ([212.40.185.223]:1138 "EHLO
	smtp-out-223.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751155Ab3FXGR4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 24 Jun 2013 02:17:56 -0400
Message-ID: <51C7E4A6.7020107@metafoo.de>
Date: Mon, 24 Jun 2013 08:18:14 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: fix typos in dac Kconfig
References: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1372022900-18670-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/23/2013 11:28 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks

> ---
>  drivers/iio/dac/Kconfig | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index c9c33ce..b9fd4c7 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -15,7 +15,7 @@ config AD5064
>  	  module will be called ad5064.
>  
>  config AD5360
> -	tristate "Analog Devices Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
> +	tristate "Analog Devices AD5360/61/62/63/70/71/73 DAC driver"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices AD5360, AD5361,
> @@ -68,7 +68,7 @@ config AD5446
>  	  module will be called ad5446.
>  
>  config AD5449
> -	tristate "Analog Device AD5449 and similar DACs driver"
> +	tristate "Analog Devices AD5449 and similar DACs driver"
>  	depends on SPI_MASTER
>  	help
>  	  Say yes here to build support for Analog Devices AD5415, AD5426, AD5429,
> @@ -131,7 +131,7 @@ config AD5686
>  	  module will be called ad5686.
>  
>  config AD7303
> -	tristate "Analog Devices Analog Devices AD7303 DAC driver"
> +	tristate "Analog Devices AD7303 DAC driver"
>  	depends on SPI
>  	help
>  	  Say yes here to build support for Analog Devices AD7303 Digital to Analog

