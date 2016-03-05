Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55953 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423AbcCEPCm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 5 Mar 2016 10:02:42 -0500
Subject: Re: [PATCH 1/3] iio:adc:at91-sama5d2: fix typo
To: Ludovic Desroches <ludovic.desroches@atmel.com>
References: <1457021355-23898-1-git-send-email-ludovic.desroches@atmel.com>
 <1457021355-23898-2-git-send-email-ludovic.desroches@atmel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nicolas.ferre@atmel.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56DAF50F.80109@kernel.org>
Date: Sat, 5 Mar 2016 15:02:39 +0000
MIME-Version: 1.0
In-Reply-To: <1457021355-23898-2-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/03/16 16:09, Ludovic Desroches wrote:
> Fix typo in the name of a macro.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Oops ;)

Applied to the togreg branch of iio.git - initially pushed out as testing
for the autobuilders to play with it.  Not sure if I will be doing another pull
request to Greg this cycle though...

Jonathan
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index dbee13a..33bacec 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -140,7 +140,7 @@
>  /* Version Register */
>  #define AT91_SAMA5D2_VERSION	0xfc
>  
> -#define AT91_AT91_SAMA5D2_CHAN(num, addr)				\
> +#define AT91_SAMA5D2_CHAN(num, addr)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
>  		.channel = num,						\
> @@ -185,18 +185,18 @@ struct at91_adc_state {
>  };
>  
>  static const struct iio_chan_spec at91_adc_channels[] = {
> -	AT91_AT91_SAMA5D2_CHAN(0, 0x50),
> -	AT91_AT91_SAMA5D2_CHAN(1, 0x54),
> -	AT91_AT91_SAMA5D2_CHAN(2, 0x58),
> -	AT91_AT91_SAMA5D2_CHAN(3, 0x5c),
> -	AT91_AT91_SAMA5D2_CHAN(4, 0x60),
> -	AT91_AT91_SAMA5D2_CHAN(5, 0x64),
> -	AT91_AT91_SAMA5D2_CHAN(6, 0x68),
> -	AT91_AT91_SAMA5D2_CHAN(7, 0x6c),
> -	AT91_AT91_SAMA5D2_CHAN(8, 0x70),
> -	AT91_AT91_SAMA5D2_CHAN(9, 0x74),
> -	AT91_AT91_SAMA5D2_CHAN(10, 0x78),
> -	AT91_AT91_SAMA5D2_CHAN(11, 0x7c),
> +	AT91_SAMA5D2_CHAN(0, 0x50),
> +	AT91_SAMA5D2_CHAN(1, 0x54),
> +	AT91_SAMA5D2_CHAN(2, 0x58),
> +	AT91_SAMA5D2_CHAN(3, 0x5c),
> +	AT91_SAMA5D2_CHAN(4, 0x60),
> +	AT91_SAMA5D2_CHAN(5, 0x64),
> +	AT91_SAMA5D2_CHAN(6, 0x68),
> +	AT91_SAMA5D2_CHAN(7, 0x6c),
> +	AT91_SAMA5D2_CHAN(8, 0x70),
> +	AT91_SAMA5D2_CHAN(9, 0x74),
> +	AT91_SAMA5D2_CHAN(10, 0x78),
> +	AT91_SAMA5D2_CHAN(11, 0x7c),
>  };
>  
>  static unsigned at91_adc_startup_time(unsigned startup_time_min,
> 

