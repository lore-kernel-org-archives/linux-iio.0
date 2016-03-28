Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45798 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753731AbcC1O7K (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 28 Mar 2016 10:59:10 -0400
Subject: Re: [PATCH 1/2] iio:adc:at91-sama5d2: cleanup mode register use
To: Ludovic Desroches <ludovic.desroches@atmel.com>
References: <1458662926-8791-1-git-send-email-ludovic.desroches@atmel.com>
Cc: lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com,
	alexandre.belloni@free-electrons.com,
	linux-arm-kernel@lists.infradead.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56F946BC.30008@kernel.org>
Date: Mon, 28 Mar 2016 15:59:08 +0100
MIME-Version: 1.0
In-Reply-To: <1458662926-8791-1-git-send-email-ludovic.desroches@atmel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/03/16 16:08, Ludovic Desroches wrote:
> Do not erase previous configuration of the mode register when setting
> the sampling frequency.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Applied.
> ---
>  drivers/iio/adc/at91-sama5d2_adc.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 5bc038f..01ba106 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -66,8 +66,10 @@
>  #define	AT91_SAMA5D2_MR_PRESCAL(v)	((v) << AT91_SAMA5D2_MR_PRESCAL_OFFSET)
>  #define	AT91_SAMA5D2_MR_PRESCAL_OFFSET	8
>  #define	AT91_SAMA5D2_MR_PRESCAL_MAX	0xff
> +#define AT91_SAMA5D2_MR_PRESCAL_MASK	GENMASK(15, 8)
>  /* Startup Time */
>  #define	AT91_SAMA5D2_MR_STARTUP(v)	((v) << 16)
> +#define AT91_SAMA5D2_MR_STARTUP_MASK	GENMASK(19, 16)
>  /* Analog Change */
>  #define	AT91_SAMA5D2_MR_ANACH		BIT(23)
>  /* Tracking Time */
> @@ -226,7 +228,7 @@ static unsigned at91_adc_startup_time(unsigned startup_time_min,
>  static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
>  {
>  	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> -	unsigned f_per, prescal, startup;
> +	unsigned f_per, prescal, startup, mr;
>  
>  	f_per = clk_get_rate(st->per_clk);
>  	prescal = (f_per / (2 * freq)) - 1;
> @@ -234,10 +236,11 @@ static void at91_adc_setup_samp_freq(struct at91_adc_state *st, unsigned freq)
>  	startup = at91_adc_startup_time(st->soc_info.startup_time,
>  					freq / 1000);
>  
> -	at91_adc_writel(st, AT91_SAMA5D2_MR,
> -			AT91_SAMA5D2_MR_TRANSFER(2)
> -			| AT91_SAMA5D2_MR_STARTUP(startup)
> -			| AT91_SAMA5D2_MR_PRESCAL(prescal));
> +	mr = at91_adc_readl(st, AT91_SAMA5D2_MR);
> +	mr &= ~(AT91_SAMA5D2_MR_STARTUP_MASK | AT91_SAMA5D2_MR_PRESCAL_MASK);
> +	mr |= AT91_SAMA5D2_MR_STARTUP(startup);
> +	mr |= AT91_SAMA5D2_MR_PRESCAL(prescal);
> +	at91_adc_writel(st, AT91_SAMA5D2_MR, mr);
>  
>  	dev_dbg(&indio_dev->dev, "freq: %u, startup: %u, prescal: %u\n",
>  		freq, startup, prescal);
> @@ -444,6 +447,8 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	at91_adc_writel(st, AT91_SAMA5D2_CR, AT91_SAMA5D2_CR_SWRST);
>  	at91_adc_writel(st, AT91_SAMA5D2_IDR, 0xffffffff);
> +	/* Transfer field must be set to 2 according to the datasheet. */
> +	at91_adc_writel(st, AT91_SAMA5D2_MR, AT91_SAMA5D2_MR_TRANSFER(2));
>  
>  	at91_adc_setup_samp_freq(st, st->soc_info.min_sample_rate);
>  
> 

