Return-Path: <maxime.ripard@free-electrons.com>
Message-ID: <5174EE51.4000606@free-electrons.com>
Date: Mon, 22 Apr 2013 10:01:21 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: Shawn Guo <shawn.guo@linaro.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 jimwall@q.com, brian@crystalfontz.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 devicetree-discuss@lists.ozlabs.org, Jonathan Cameron <jic23@cam.ac.uk>,
 Rob Landley <rob@landley.net>,
 Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 1/3] iio: Add Nuvoton NAU7802 ADC driver
References: <1366299536-18353-1-git-send-email-alexandre.belloni@free-electrons.com> <1366299536-18353-2-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1366299536-18353-2-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Hi Alexandre,

Le 18/04/2013 17:38, Alexandre Belloni a écrit :
> +	nau7802_i2c_write(st, NAU7802_REG_PUCTRL, data);
> +	nau7802_i2c_write(st, NAU7802_REG_ADC_CTRL, 0x30);
> +
> +	if (tmp >= 2400) {
> +		data = NAU7802_CTRL1_VLDO((4500 - tmp) / 300);
> +		nau7802_i2c_write(st, NAU7802_REG_CTRL1, data);
> +	}

You should probably make a macro or inline function (with a comment) out
of that computation explaining why you are doing this.

> +
> +	st->min_conversions = 6;

I'd prefer to see this as a define.

> +
> +	/*
> +	 * The ADC fires continuously and we can't do anything about
> +	 * it. So we need to have the IRQ disabled by default, and we
> +	 * will enable them back when we will need them..
> +	 */
> +	if (client->irq) {
> +		irq_set_status_flags(client->irq, IRQ_NOAUTOEN);
> +		ret = request_threaded_irq(client->irq,
> +				NULL,
> +				nau7802_eoc_trigger,
> +				IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
> +				client->dev.driver->name,
> +				idev);
> +		if (ret) {
> +			/*
> +			 * What may happen here is that our IRQ controller is
> +			 * not able to get level interrupt but this is required
> +			 * by this ADC as when going over 40 sample per second,
> +			 * the interrupt line may stay high between conversions.
> +			 * So, we continue no matter what but we switch to
> +			 * polling mode.
> +			 */
> +			dev_info(&client->dev,
> +				"Failed to allocate IRQ, using polling mode\n");
> +			client->irq = 0;
> +			/*
> +			 * We are polling, use the fastest sample rate by
> +			 * default
> +			 */
> +			st->sample_rate = 0x7;

Ditto.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
