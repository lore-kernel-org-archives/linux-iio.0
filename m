Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:44350 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768Ab3GTJjT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 20 Jul 2013 05:39:19 -0400
Message-ID: <51EA5AC5.30400@kernel.org>
Date: Sat, 20 Jul 2013 10:39:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Josh Wu <josh.wu@atmel.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	maxime.ripard@free-electrons.com, plagnioj@jcrosoft.com,
	nicolas.ferre@atmel.com
Subject: Re: [PATCH 3/5] iio: at91: ADC start-up time calculation changed
 since at91sam9x5
References: <1373789069-11604-1-git-send-email-josh.wu@atmel.com> <1373789069-11604-4-git-send-email-josh.wu@atmel.com>
In-Reply-To: <1373789069-11604-4-git-send-email-josh.wu@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 07/14/2013 09:04 AM, Josh Wu wrote:
> Since in at91sam9x5, sama5d3x chip. the start up time calucation is changed.
> And these two chips also have TSMR, so we check whether ADC has TSMR, then
> choose different start up time calculation formula.
If this doesn't have anything directly to do with the TSMR and this is just
coincidence, then do this separately with it's own flag as it will be
easier to maintain in the long run.

Jonathan
> 
> Signed-off-by: Josh Wu <josh.wu@atmel.com>
> ---
>  drivers/iio/adc/at91_adc.c |   40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 14e99ba..e93a075 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -733,13 +733,39 @@ static int at91_adc_probe(struct platform_device *pdev)
>  		goto error_disable_adc_clk;
>  	}
>  
> -	/*
> -	 * Number of ticks needed to cover the startup time of the ADC as
> -	 * defined in the electrical characteristics of the board, divided by 8.
> -	 * The formula thus is : Startup Time = (ticks + 1) * 8 / ADC Clock
> -	 */
> -	ticks = round_up((st->startup_time * adc_clk_khz /
> -			  1000) - 1, 8) / 8;
> +	if (!st->caps.has_tsmr) {
> +		/*
> +		 * Number of ticks needed to cover the startup time of the ADC
> +		 * as defined in the electrical characteristics of the board,
> +		 * divided by 8. The formula thus is :
> +		 *   Startup Time = (ticks + 1) * 8 / ADC Clock
> +		 */
> +		ticks = round_up((st->startup_time * adc_clk_khz /
> +				  1000) - 1, 8) / 8;
> +	} else {
> +		/*
> +		 * For sama5d3x and at91sam9x5, the formula changes to:
> +		 * Startup Time = <lookup_table_value> / ADC Clock
> +		 */
> +		const int startup_lookup[] = {
> +			0  , 8  , 16 , 24 ,
> +			64 , 80 , 96 , 112,
> +			512, 576, 640, 704,
> +			768, 832, 896, 960
> +			};
> +
> +		int i, size = ARRAY_SIZE(startup_lookup);
> +		ticks = st->startup_time * adc_clk_khz / 1000;
> +		for (i = 0; i < size; i++)
> +			if (ticks < startup_lookup[i])
> +				break;
> +
> +		ticks = i;
> +		if (ticks == size)
> +			/* Reach the end of lookup table */
> +			ticks = size - 1;
> +	}
> +
>  	/*
>  	 * a minimal Sample and Hold Time is necessary for the ADC to guarantee
>  	 * the best converted final value between two channels selection
> 
