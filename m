Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41794 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752590AbcHOQL7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 15 Aug 2016 12:11:59 -0400
Subject: Re: [PATCH v2] iio: humidity: hdc100x: add HDC1000 and HDC1008 to
 Kconfig
To: Alison Schofield <amsfield22@gmail.com>
References: <20160725185001.GA5322@d830.WORKGROUP>
Cc: mranostay@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
	pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <e4da12fe-441f-4d11-412a-ec42af66844c@kernel.org>
Date: Mon, 15 Aug 2016 17:11:57 +0100
MIME-Version: 1.0
In-Reply-To: <20160725185001.GA5322@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/07/16 19:50, Alison Schofield wrote:
> hdc100x supports Texas Instruments HDC1000 and HDC1008 relative
> humidity and temperature sensors. Add these product names to
> Kconfig.
> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> Cc: Daniel Baluta <daniel.baluta@gmail.com>

Thanks for sorting this out!

Applied to the togreg branch of iio.git - pushed out as testing
etc etc.

Jonathan
> ---
> Changes in v2:
>  - removed names from i2c_device_id struct. (keep as hdc100x only)
>  - updated commit msg and changelog
> 
> drivers/iio/humidity/Kconfig | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
> index 738a86d..f155386 100644
> --- a/drivers/iio/humidity/Kconfig
> +++ b/drivers/iio/humidity/Kconfig
> @@ -26,11 +26,11 @@ config HDC100X
>  	tristate "TI HDC100x relative humidity and temperature sensor"
>  	depends on I2C
>  	help
> -	 Say yes here to build support for the TI HDC100x series of
> -	 relative humidity and temperature sensors.
> +	  Say yes here to build support for the Texas Instruments
> +	  HDC1000 and HDC1008 relative humidity and temperature sensors.
>  
> -	 To compile this driver as a module, choose M here: the module
> -	 will be called hdc100x.
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called hdc100x.
>  
>  config HTU21
>  	tristate "Measurement Specialties HTU21 humidity & temperature sensor"
> 

