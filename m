Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:47351 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbcHHNwq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Aug 2016 09:52:46 -0400
Date: Mon, 8 Aug 2016 15:52:43 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Anders Darander <anders@chargestorm.se>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
	lars@metafoo.de, pmeerw@pmeerw.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91: unbreak channel adc channel 3
Message-ID: <20160808135243.GA19793@piout.net>
References: <1470660136-12524-1-git-send-email-anders@chargestorm.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1470660136-12524-1-git-send-email-anders@chargestorm.se>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/08/2016 at 14:42:16 +0200, Anders Darander wrote :
> The driver always assumes that an input device has been created when
> reading channel 3. This causes a kernel panic when dereferencing
> st->ts_input.
> 
> The change was introduced in
> commit 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens
> without TSMR"). Earlier versions only entered that part of the if-else
> statement if only the following flags are set:
> 
> AT91_ADC_IER_XRDY | AT91_ADC_IER_YRDY | AT91_ADC_IER_PRDY
> 
> Signed-off-by: Anders Darander <anders@chargestorm.se>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/iio/adc/at91_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 52430ba..0438c68 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -381,8 +381,8 @@ static irqreturn_t at91_adc_rl_interrupt(int irq, void *private)
>  		st->ts_bufferedmeasure = false;
>  		input_report_key(st->ts_input, BTN_TOUCH, 0);
>  		input_sync(st->ts_input);
> -	} else if (status & AT91_ADC_EOC(3)) {
> -		/* Conversion finished */
> +	} else if (status & AT91_ADC_EOC(3) && st->ts_input) {
> +		/* Conversion finished and we've a touchscreen */
>  		if (st->ts_bufferedmeasure) {
>  			/*
>  			 * Last measurement is always discarded, since it can
> -- 
> 2.8.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
