Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([88.190.12.23]:40070 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753807Ab1JTHOZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 20 Oct 2011 03:14:25 -0400
Date: Thu, 20 Oct 2011 09:14:16 +0200
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3] ARM: AT91: Add the ADC to the sam9g20ek board
Message-ID: <20111020091416.1e90828c@skate>
In-Reply-To: <1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-4-git-send-email-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Le Wed, 19 Oct 2011 18:18:54 +0200,
Maxime Ripard <maxime.ripard@free-electrons.com> a =C3=A9crit :

> +void __init at91_add_device_adc(struct at91_adc_data *data)
> +{
> +	if (!data)
> +		return;
> +
> +	at91_set_A_periph(AT91_PIN_PC0, 0);
> +	at91_set_A_periph(AT91_PIN_PC1, 0);
> +	at91_set_A_periph(AT91_PIN_PC2, 0);
> +	at91_set_A_periph(AT91_PIN_PC3, 0);

As suggested, the decision of which ADC channels are used and therefore
which pins should be muxed to function A is a board-specific decision
and should not be enforced by SoC code.

> +static struct at91_adc_data ek_adc_data =3D {
> +	.channels =3D 4,
> +	.adc_clock =3D 5000000,
> +	.startup_time =3D 10,
> +};

And on the opposite, those informations are specific to a SoC, not to a
board. So to avoid duplication in all board files, they should be moved
to the corresponding SoC file.

Maybe something like:

#define AT91_ADC_MAX_CHANNELS 8

struct at91_adc_data {
    unsigned int adc_clock;
    u8 channels_used[AT91_ADC_MAX_CHANNELS];
    u8 startup_time;
    u8 channels;
};

at91_add_device_adc() {
	if (data->channels_used[0])
		at91_set_A_periph(AT91_PIN_PC0, 0);
	if (data->channels_used[1])
		at91_set_A_periph(AT91_PIN_PC1, 0);
	if (data->channels_used[2])
		at91_set_A_periph(AT91_PIN_PC2, 0);
	if (data->channels_used[3])
		at91_set_A_periph(AT91_PIN_PC3, 0);
	data->startup_time =3D ...
	data->channels =3D ...
	data->adc_clock =3D ...
}

and the board file would do:

struct at91_adc_data ek_adc_data =3D {
	.channels_used =3D { 1, 0, 1, 1 },;
};

Or maybe others have different suggestions ?

Regards,

Thomas
--=20
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
