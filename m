Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:40343 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755755Ab1KGQ1Q (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 7 Nov 2011 11:27:16 -0500
Message-ID: <4EB806E4.9070408@kernel.org>
Date: Mon, 07 Nov 2011 16:27:16 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320682113-23655-1-git-send-email-maxime.ripard@free-electrons.com> <1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1320682113-23655-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Looks sensible to me though obviously this is bit is really for the
at91 lot to comment on.

On 11/07/2011 04:08 PM, Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  arch/arm/mach-at91/include/mach/board.h |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index ed544a0..afdcac0 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -207,4 +207,22 @@ extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
>  /* FIXME: this needs a better location, but gets stuff building again */
>  extern int at91_suspend_entering_slow_clock(void);
>  
> +/* ADC */
> +struct at91_adc_data {
> +	/* ADC Clock as specified by the datasheet, in Hz. */
> +	unsigned int adc_clock;
> +	/*
> +	 * Global number of channels available (to specify which channels are
> +	 * indeed used on the board, see the channels_used array).
> +	 */
> +	u8 num_channels;
> +	/* Channels in use on the board */
One nitpick here. You could make it more obvious that this is a mask...
> +	unsigned long channels_used;
> +	/* Startup time of the ADC, in microseconds. */
> +	u8 startup_time;
> +	/* Reference voltage for the ADC in millivolts */
> +	unsigned short vref;
> +};
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
>  #endif

