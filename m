Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:48904 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938511AbdDYAet (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 Apr 2017 20:34:49 -0400
Subject: Re: [PATCH] iio: pressure: Fix name of BME280 part in Kconfig
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
References: <20170421205836.19144-1-pmeerw@pmeerw.net>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <d2f981d4-a2b1-ee6d-399f-0e83e34730b5@kernel.org>
Date: Sun, 23 Apr 2017 12:39:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170421205836.19144-1-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 21/04/17 21:58, Peter Meerwald-Stadler wrote:
> Bosch BME280 is a combined pressure and humidity sensor
> 
> Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Applied to the togreg branch of iio.git and pushed out as testing when I
next have a network connection.

Jonathan
> ---
>  drivers/iio/pressure/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/Kconfig b/drivers/iio/pressure/Kconfig
> index 5d16b252ab6b..eaa7cfcb4c2a 100644
> --- a/drivers/iio/pressure/Kconfig
> +++ b/drivers/iio/pressure/Kconfig
> @@ -23,7 +23,7 @@ config BMP280
>  	select BMP280_SPI if (SPI_MASTER)
>  	help
>  	  Say yes here to build support for Bosch Sensortec BMP180 and BMP280
> -	  pressure and temperature sensors. Also supports the BE280 with
> +	  pressure and temperature sensors. Also supports the BME280 with
>  	  an additional humidity sensor channel.
>  
>  	  To compile this driver as a module, choose M here: the core module
> 

