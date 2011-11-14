Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:49620 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab1KNUee (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2011 15:34:34 -0500
Message-ID: <4EC17B5C.8060909@cam.ac.uk>
Date: Mon, 14 Nov 2011 20:34:36 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Maxime Ripard <maxime.ripard@free-electrons.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1321291857-26277-1-git-send-email-maxime.ripard@free-electrons.com> <1321291857-26277-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1321291857-26277-4-git-send-email-maxime.ripard@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/14/2011 05:30 PM, Maxime Ripard wrote:
> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> 
I'm happy with this, but the question comes of how to merge it with
minimal conflicts.  Clearly 2/3 is entirely in IIO so easy enough
but is dependent on 1/3.  3/3 is entirely in the at91 maintainers
domain but is also dependent on 1/3.

What do people what to do?
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  arch/arm/mach-at91/at91sam9260_devices.c |   55 ++++++++++++++++++++++++++++++
>  arch/arm/mach-at91/board-sam9g20ek.c     |   11 ++++++
>  2 files changed, 66 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
> index 39f81f4..3b754ba 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> @@ -1312,6 +1312,61 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
>  void __init at91_add_device_cf(struct at91_cf_data * data) {}
>  #endif
>  
> +/* --------------------------------------------------------------------
> + *  ADCs
> + * -------------------------------------------------------------------- */
> +
> +#if defined(CONFIG_IIO_AT91ADC) || defined(CONFIG_IIO_AT91ADC_MODULE)
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
> +	if (test_bit(0, &data->channels_used))
> +		at91_set_A_periph(AT91_PIN_PC0, 0);
> +	if (test_bit(1, &data->channels_used))
> +		at91_set_A_periph(AT91_PIN_PC1, 0);
> +	if (test_bit(2, &data->channels_used))
> +		at91_set_A_periph(AT91_PIN_PC2, 0);
> +	if (test_bit(3, &data->channels_used))
> +		at91_set_A_periph(AT91_PIN_PC3, 0);
> +
> +	data->adc_clock = 5000000;
> +	data->num_channels = 4;
> +	data->startup_time = 10;
> +
> +	adc_data = *data;
> +	platform_device_register(&at91_adc_device);
> +}
> +#else
> +void __init at91_add_device_adc(struct at91_adc_data *data) {}
> +#endif
> +
>  /* -------------------------------------------------------------------- */
>  /*
>   * These devices are always present and don't need any board-specific
> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
> index 817f59d..e34d41a 100644
> --- a/arch/arm/mach-at91/board-sam9g20ek.c
> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
> @@ -314,6 +314,15 @@ static void __init ek_add_device_buttons(void)
>  static void __init ek_add_device_buttons(void) {}
>  #endif
>  
> +/*
> + * ADCs
> + */
> +
> +static struct at91_adc_data ek_adc_data = {
> +	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
> +	.vref = 3300,
> +};
Feels like this should be marked as __initdata given it gets copied
in the below function?
> +
>  #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
>  static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
>  	REGULATOR_SUPPLY("AVDD", "0-001b"),
> @@ -389,6 +398,8 @@ static void __init ek_board_init(void)
>  	ek_add_device_gpio_leds();
>  	/* Push Buttons */
>  	ek_add_device_buttons();
> +	/* ADCs */
> +	at91_add_device_adc(&ek_adc_data);
>  	/* PCK0 provides MCLK to the WM8731 */
>  	at91_set_B_periph(AT91_PIN_PC1, 0);
>  	/* SSC (for WM8731) */

