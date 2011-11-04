Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47342 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751216Ab1KDKdr (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Nov 2011 06:33:47 -0400
Message-ID: <4EB3BF8A.9080809@jic23.retrosnub.co.uk>
Date: Fri, 04 Nov 2011 10:33:46 +0000
From: Jonathan Cameron <archive@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com> <1320315070-1700-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1320315070-1700-4-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Forgot to put some general comments in the previous patch reviews.

Please run checkpatch.pl over all patches as it will clean up quite a few
issues.

Mostly looking good.  At the moment it's simple enough that we can
rapidly move this one out of staging once the core has gone.

Then we can build up more interesting stuff as support goes into
the non staging core.

Thanks,

Jonathan

On 11/03/2011 10:11 AM, Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  arch/arm/mach-at91/at91sam9260_devices.c |   52 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/board-sam9g20ek.c     |   12 +++++++
>  2 files changed, 64 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 39f81f4..bfc50ac 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -1312,6 +1312,58 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
>  void __init at91_add_device_cf(struct at91_cf_data * data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  ADCs
> + * -------------------------------------------------------------------- */
> +
> +static struct at91_adc_data adc_data;
> +
> +static struct resource adc_resources[] = {
> +	[0] = {
> +		.start	= AT91SAM9260_BASE_ADC,
> +		.end	= AT91SAM9260_BASE_ADC + SZ_16K - 1,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	[1] = {
> +		.start	= AT91SAM9260_ID_ADC,
> +		.end	= AT91SAM9260_ID_ADC,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static struct platform_device at91_adc_device = {
> +	.name		= "at91adc",
> +	.id		= -1,
> +	.dev		= {
> +				.platform_data		= &adc_data,
> +	},
> +	.resource	= adc_resources,
> +	.num_resources	= ARRAY_SIZE(adc_resources),
> +};
> +
> +void __init at91_add_device_adc(struct at91_adc_data *data)
> +{
> +	if (!data)
> +		return;
> +
> +	if(data->channels_used[0])
> +		at91_set_A_periph(AT91_PIN_PC0, 0);
> +	if(data->channels_used[1])
> +		at91_set_A_periph(AT91_PIN_PC1, 0);
> +	if(data->channels_used[2])
> +		at91_set_A_periph(AT91_PIN_PC2, 0);
> +	if(data->channels_used[3])
> +		at91_set_A_periph(AT91_PIN_PC3, 0);
formatting issues so another one for checkpatch.

Also define AT91_PIN_PC(n) then make this another
for_each_bit_set call.  That should get you down from
8 lines to about 3.
> +
> +	data->adc_clock = 5000000;
> +	data->num_channels = 4;
> +	data->startup_time = 10;
> +
> +	adc_data = *data;
> +	platform_device_register(&at91_adc_device);
> +}
> +
> +
>  /* -------------------------------------------------------------------- */
>  /*
>   * These devices are always present and don't need any board-specific
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index 817f59d..6f2542fb 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -314,6 +314,16 @@ static void __init ek_add_device_buttons(void)
>  static void __init ek_add_device_buttons(void) {}
>  #endif
>  
> +/*
> + * ADCs
> + */
> +
> +static struct at91_adc_data ek_adc_data = {
> +	.channels_used = { 1, 1, 1, 1} ,
> +	.num_channels_used = 4,
> +	.vref = 3300,
> +};
> +
>  #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
>  static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
>  	REGULATOR_SUPPLY("AVDD", "0-001b"),
> @@ -389,6 +399,8 @@ static void __init ek_board_init(void)
>  	ek_add_device_gpio_leds();
>  	/* Push Buttons */
>  	ek_add_device_buttons();
> +	/* ADCs */
> +	at91_add_device_adc(&ek_adc_data);
>  	/* PCK0 provides MCLK to the WM8731 */
>  	at91_set_B_periph(AT91_PIN_PC1, 0);
>  	/* SSC (for WM8731) */

