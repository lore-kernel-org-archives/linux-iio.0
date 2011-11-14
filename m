Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:43848 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011Ab1KNPRo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 14 Nov 2011 10:17:44 -0500
Message-ID: <4EC1310F.7010901@free-electrons.com>
Date: Mon, 14 Nov 2011 16:17:35 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Nicolas Ferre <nicolas.ferre@atmel.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1321265193-15817-1-git-send-email-maxime.ripard@free-electrons.com> <1321265193-15817-4-git-send-email-maxime.ripard@free-electrons.com> <4EC0FB7C.6000800@atmel.com>
In-Reply-To: <4EC0FB7C.6000800@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Nicolas,

On 14/11/2011 12:29, Nicolas Ferre wrote:
> On 11/14/2011 11:06 AM, Maxime Ripard :
>> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
>> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
>> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> 
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> (even if I have a tiny comment: see below)
> 
>> ---
>>  arch/arm/mach-at91/at91sam9260_devices.c |   52 ++++++++++++++++++++++++++++++
>>  arch/arm/mach-at91/board-sam9g20ek.c     |   11 ++++++
>>  2 files changed, 63 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c b/arch/arm/mach-at91/at91sam9260_devices.c
>> index 39f81f4..0859553 100644
>> --- a/arch/arm/mach-at91/at91sam9260_devices.c
>> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
>> @@ -1312,6 +1312,58 @@ void __init at91_add_device_cf(struct at91_cf_data *data)
>>  void __init at91_add_device_cf(struct at91_cf_data * data) {}
>>  #endif
>>  
>> +/* --------------------------------------------------------------------
>> + *  ADCs
>> + * -------------------------------------------------------------------- */
> 
> What about adding all this only if the IIO_AT91ADC is selected?
> Otherwise, you configure pins without actually using them...

I'm not sure on what I should do here. Should I only wrap the pin
configuration part in the at91_add_device_adc function in an ifdef, or
wrap all there is in this patch (that is structure definitions,
at91_add_device_adc declaration and call, etc) by the ifdef ?

> 
>> +
>> +static struct at91_adc_data adc_data;
>> +
>> +static struct resource adc_resources[] = {
>> +	[0] = {
>> +		.start	= AT91SAM9260_BASE_ADC,
>> +		.end	= AT91SAM9260_BASE_ADC + SZ_16K - 1,
>> +		.flags	= IORESOURCE_MEM,
>> +	},
>> +	[1] = {
>> +		.start	= AT91SAM9260_ID_ADC,
>> +		.end	= AT91SAM9260_ID_ADC,
>> +		.flags	= IORESOURCE_IRQ,
>> +	},
>> +};
>> +
>> +static struct platform_device at91_adc_device = {
>> +	.name		= "at91adc",
>> +	.id		= -1,
>> +	.dev		= {
>> +				.platform_data		= &adc_data,
>> +	},
>> +	.resource	= adc_resources,
>> +	.num_resources	= ARRAY_SIZE(adc_resources),
>> +};
>> +
>> +void __init at91_add_device_adc(struct at91_adc_data *data)
>> +{
>> +	if (!data)
>> +		return;
>> +
>> +	if (test_bit(0, &(data->channels_used)))
>> +		at91_set_A_periph(AT91_PIN_PC0, 0);
>> +	if (test_bit(1, &(data->channels_used)))
>> +		at91_set_A_periph(AT91_PIN_PC1, 0);
>> +	if (test_bit(2, &(data->channels_used)))
>> +		at91_set_A_periph(AT91_PIN_PC2, 0);
>> +	if (test_bit(3, &(data->channels_used)))
>> +		at91_set_A_periph(AT91_PIN_PC3, 0);
>> +
>> +	data->adc_clock = 5000000;
>> +	data->num_channels = 4;
>> +	data->startup_time = 10;
>> +
>> +	adc_data = *data;
>> +	platform_device_register(&at91_adc_device);
>> +}
>> +
>> +
>>  /* -------------------------------------------------------------------- */
>>  /*
>>   * These devices are always present and don't need any board-specific
>> diff --git a/arch/arm/mach-at91/board-sam9g20ek.c b/arch/arm/mach-at91/board-sam9g20ek.c
>> index 817f59d..e34d41a 100644
>> --- a/arch/arm/mach-at91/board-sam9g20ek.c
>> +++ b/arch/arm/mach-at91/board-sam9g20ek.c
>> @@ -314,6 +314,15 @@ static void __init ek_add_device_buttons(void)
>>  static void __init ek_add_device_buttons(void) {}
>>  #endif
>>  
>> +/*
>> + * ADCs
>> + */
>> +
>> +static struct at91_adc_data ek_adc_data = {
>> +	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3),
>> +	.vref = 3300,
>> +};
>> +
>>  #if defined(CONFIG_REGULATOR_FIXED_VOLTAGE) || defined(CONFIG_REGULATOR_FIXED_VOLTAGE_MODULE)
>>  static struct regulator_consumer_supply ek_audio_consumer_supplies[] = {
>>  	REGULATOR_SUPPLY("AVDD", "0-001b"),
>> @@ -389,6 +398,8 @@ static void __init ek_board_init(void)
>>  	ek_add_device_gpio_leds();
>>  	/* Push Buttons */
>>  	ek_add_device_buttons();
>> +	/* ADCs */
>> +	at91_add_device_adc(&ek_adc_data);
>>  	/* PCK0 provides MCLK to the WM8731 */
>>  	at91_set_B_periph(AT91_PIN_PC1, 0);
>>  	/* SSC (for WM8731) */
> 
> 


-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
