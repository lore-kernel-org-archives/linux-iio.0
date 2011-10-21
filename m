Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:37103 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754323Ab1JURrm (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 21 Oct 2011 13:47:42 -0400
Message-ID: <4EA1B035.2030503@free-electrons.com>
Date: Fri, 21 Oct 2011 19:47:33 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Alexander Stein <alexander.stein@systec-electronic.com>
CC: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com> <201110200828.59278.alexander.stein@systec-electronic.com>
In-Reply-To: <201110200828.59278.alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

On 20/10/2011 08:28, Alexander Stein wrote:
> On Wednesday 19 October 2011 18:18:54 Maxime Ripard wrote:
>> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c
>> b/arch/arm/mach-at91/at91sam9260_devices.c index 39f81f4..4f5e0f9 100644
>> --- a/arch/arm/mach-at91/at91sam9260_devices.c
>> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
>> [...]
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
>> +	at91_set_A_periph(AT91_PIN_PC0, 0);
>> +	at91_set_A_periph(AT91_PIN_PC1, 0);
>> +	at91_set_A_periph(AT91_PIN_PC2, 0);
>> +	at91_set_A_periph(AT91_PIN_PC3, 0);
>> +
>> +	adc_data = *data;
>> +	platform_device_register(&at91_adc_device);
>> +}
>> +
>> +
> 
> This assumes that all 4 channels are used every time.  How about only using an 
> AD channel on PC2 or all but the one on PC1?

You're right. I've implemented Thomas suggestion to define the channels
in use in a board specific manner. I need to test my changes and will
submit a new version by monday.

Thanks,

-- 
Maxime Ripard, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
