Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from newsmtp5.atmel.com ([204.2.163.5]:38646 "EHLO
	sjogate2.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752327Ab1KNL3a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2011 06:29:30 -0500
Message-ID: <4EC0FB93.5050403@atmel.com>
Date: Mon, 14 Nov 2011 12:29:23 +0100
From: Nicolas Ferre <nicolas.ferre@atmel.com>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1321265193-15817-1-git-send-email-maxime.ripard@free-electrons.com> <1321265193-15817-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1321265193-15817-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/14/2011 11:06 AM, Maxime Ripard :
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Acked-by: Jonathan Cameron <jic23@cam.ac.uk>

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/mach-at91/include/mach/board.h |   18 ++++++++++++++++++
>  1 files changed, 18 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index ed544a0..4f27797 100644
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
> +	 * indeed used on the board, see the channels_used bitmask).
> +	 */
> +	u8 num_channels;
> +	/* Channels in use on the board as a bitmask */
> +	unsigned long channels_used;
> +	/* Startup time of the ADC, in microseconds. */
> +	u8 startup_time;
> +	/* Reference voltage for the ADC in millivolts */
> +	unsigned short vref;
> +};
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
>  #endif


-- 
Nicolas Ferre
