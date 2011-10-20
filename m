Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:56146 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751579Ab1JTG3G (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 02:29:06 -0400
From: Alexander Stein <alexander.stein@systec-electronic.com>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
Date: Thu, 20 Oct 2011 08:28:58 +0200
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
	linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com> <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
In-Reply-To: <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201110200828.59278.alexander.stein@systec-electronic.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wednesday 19 October 2011 18:18:54 Maxime Ripard wrote:
> diff --git a/arch/arm/mach-at91/at91sam9260_devices.c
> b/arch/arm/mach-at91/at91sam9260_devices.c index 39f81f4..4f5e0f9 100644
> --- a/arch/arm/mach-at91/at91sam9260_devices.c
> +++ b/arch/arm/mach-at91/at91sam9260_devices.c
> [...]
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
> +	at91_set_A_periph(AT91_PIN_PC0, 0);
> +	at91_set_A_periph(AT91_PIN_PC1, 0);
> +	at91_set_A_periph(AT91_PIN_PC2, 0);
> +	at91_set_A_periph(AT91_PIN_PC3, 0);
> +
> +	adc_data = *data;
> +	platform_device_register(&at91_adc_device);
> +}
> +
> +

This assumes that all 4 channels are used every time.  How about only using an 
AD channel on PC2 or all but the one on PC1?

Regards,
Alexander
