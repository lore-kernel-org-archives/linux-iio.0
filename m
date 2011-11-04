Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47349 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753770Ab1KDKe7 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2011 06:34:59 -0400
Message-ID: <4EB3BFD2.5080909@jic23.retrosnub.co.uk>
Date: Fri, 04 Nov 2011 10:34:58 +0000
From: Jonathan Cameron <archive@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/03/2011 10:11 AM, Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-at91/include/mach/board.h |   22 ++++++++++++++++++++++
>  1 files changed, 22 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
> index ed544a0..b837da8 100644
> --- a/arch/arm/mach-at91/include/mach/board.h
> +++ b/arch/arm/mach-at91/include/mach/board.h
> @@ -207,4 +207,26 @@ extern void __init at91_pwm_leds(struct gpio_led *leds, int nr);
>  /* FIXME: this needs a better location, but gets stuff building again */
>  extern int at91_suspend_entering_slow_clock(void);
>  
> +/* ADC */
> +#define AT91_ADC_MAX_CHANNELS   16
> +
> +struct at91_adc_data {
> +	/* ADC Clock as specified by the datasheet, in Hz. */
> +	unsigned int adc_clock;
> +	/*
> +	 * Global number of channels available (to specify which channels are
> +	 * indeed used on the board, see the channels_used array).
> +	 */
> +	u8 num_channels;
> +	/* Channels in use on the board */
put it in a unsigned long and use the bitmap functions.
> +	u8 channels_used[AT91_ADC_MAX_CHANNELS];
> +	/* Number of channels in use */
just use bitmap_weight with the long above and
length set to num_channels.
> +	u8 num_channels_used;
> +	/* Startup time of the ADC, in microseconds. */
> +	u8 startup_time;
> +	/* Reference voltage for the ADC in millivolts */
> +	unsigned short vref;
> +};
> +extern void __init at91_add_device_adc(struct at91_adc_data *data);
> +
>  #endif

