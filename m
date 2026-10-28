Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793155167;
	b=1Bqv+QQbKYJn3jI/FT1oBLyoKK1yI24Pvt9Z/PM5gaPdJfOW78XxdzDflZUBey1+NniN
	 2VFkcD3n/+XztePjOdi9/lUPQFluXs3WHKcR5GGdJsclrY+rsDXJmEn3xePwuOsK1ckRg
	 VT/xcXQGgdmBsrw7z3L4rWztpBU6Z3oX7+hPUj2hibBs7X5lhgCRp079F9hY13mUB/uuL
	 TfxCd1Nrf0WvQeqcW9U7rNPmOnCUnYsLEOj0P3X6btTzvpePy9wVHz9DD+/d/eCwfx+TG
	 ptE3cdLumYlP/UHBdoYQHaa3XRRFy6s2J5S27MvVSGph35FdzuqT+EtplCEpc6mW9WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793155167;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=q9vP4N6Xq+pWaWFspzkH4JG7fJYn2ADhm9WVHgwfMPs=;
	b=uNX0M24wEIHi/z4goH0tCIN1smYnq2pMMIhfQApuekJDYgYfKW5mJ2I5TL249/BrC765
	 QqGUoyQlVSsBfMUzyeWIfY3lqZp7ygWn4O1x+rM7qnYjsCdQwj3yVxozFlsNMjbad3TCh
	 2ixNOflPuc5U0ABTIxUMXE7n2eeXmGcg6FeHTFRdSbvUZfXmUBjQJcLMtC9uNpmc6Oj85
	 65LaRedDC3Q1IrDtKZ02jjN5niGVFJT0pQdWcSEAy4wanFWdX0CIfvMs9NvyPBGUuuX1c
	 iQATwCRR6CzWbJ/MEVxg8IO20IqUubuIYmEkfjydcDb9Nlse2gKc1e8aIO2tRBNFl8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fArf4kC1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAAB606A31A;
	Wed, 28 Oct 2026 02:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fArf4kC1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651741F01825;
	Wed, 28 Oct 2026 02:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793155166;
	bh=q9vP4N6Xq+pWaWFspzkH4JG7fJYn2ADhm9WVHgwfMPs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fArf4kC1GAoberVAhC6f+ZKxf3oaZErgeLn/WvBmD5xrFs0YLhfxaJ0Ews+EXZmQY
	 6yy1tvQ3jc4fakj26m2+meB29dlERvjTcLzPnE9bfoaegAyaiNts+OW4scjLFBDcXA
	 xTmQuOAFiyGtvAhkANvkBbWdoej6wLWXzmNovhm775HyVDhOIPTvFarLYyi1R0KA9k
	 Hz5e/4QZTc2hPD6w6J8Cupw2JCvucL8XF2oRU1bI5vz2J5c9VGEo1OtWldp2w8ap7V
	 wAuyqLZ6M30f8w/YN+JYvjWdoKI8mF0bsC8nMO/svN78kXqi3JYCdr+hDowW9r6kax
	 zXmlpTrzkZjLw==
Date: Wed, 28 Oct 2026 02:39:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: add ltc2387 driver
Message-ID: <20261028023919.21834986@jic23-hlaptop>
In-Reply-To: <20261027134409.76824-3-Nicolae-daniel.Deaconescu@analog.com>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261027134409.76824-3-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Oct 2026 15:44:09 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Add a driver for the LTC2387-16/18 and the ADAQ23875/23876/23878.
> 
> The driver generates CNV and the gated data clock with two PWM
> channels, timed against the reference clock to meet t_FIRSTCLK, and
> gets sample data through the IIO backend framework from the AXI ADC
> core. It supports one-lane and two-lane output and reports the
> sampling frequency the PWMs produce after rounding to whole reference
> clock cycles. in_voltage_scale is referred to the analog input, so on
> the ADAQ parts it is divided by the front-end gain.
> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Assisted-by: Claude:claude-opus-5-5

Check the docs on this.  We moved away from this form to the LLM
one not naming the model and now convention is to just mention
it in the cover letter or below the ---
Ideally with a bit more info on how you used it.

Various things inline.  Some of the stuff in here
looks like old drivers and the copyright suggests this is
one that is now being upstreamed.  Please take a look
at some more recent ones for preferred style etc.

Jonathan

> diff --git a/drivers/iio/adc/ltc2387.c b/drivers/iio/adc/ltc2387.c
> new file mode 100644
> index 000000000000..c236b99baa4a
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2387.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Linear Technology LTC2387 ADC driver
> + *
> + * Copyright 2022 - 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/mod_devicetable.h>
> +
> +#define LTC2387_VREF		4096
> +#define LTC2387_T_CNVH		8
> +
> +/*
> + * Minimal value for t_{FIRSTCLK} according to
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/238718fa.pdf
> + * is 65 ns. Add some slack because there is some rounding involved in the PWM
> + * driver. With the PWM driver rounding to the nearest possible value, targeting
> + * 70 ns works for input clk rates >= 100 MHz.
> + */
> +#define LTC2387_T_FIRSTCLK_NS	70
> +
> +#define KHz 1000
There are units for this already...  See units.h
Probably want HZ_PER_KHZ for this one.

> +#define MHz (1000 * KHz)
HZ_PER_MHZ

> +enum ltc2387_lane_modes {
> +	ONE_LANE = 0,
> +	TWO_LANES = 1

Trailing comma.

> +};
> +
> +enum ltc2387_id {
> +	ID_LTC2387_16,
> +	ID_LTC2387_16_X4,
> +	ID_LTC2387_18,
> +	ID_LTC2387_18_X4,
> +	ID_ADAQ23875,
> +	ID_ADAQ23876,
> +	ID_ADAQ23878,

See below. I'd expect this to go away with changes there.

> +};
> +
> +struct ltc2387_info {
> +	const char *name;
> +	struct iio_chan_spec channels[4];
> +	unsigned int test_pattern[2];
> +	int num_channels;
> +	int resolution;
> +	/* Gain * 1000 when adi,gain-milli is absent; unity for the bare parts. */

Gain / 1000?  If its in units of milli.
For the unity parts why 0?

> +	u32 default_gain_milli;
> +};
>
> +
> +static const struct ltc2387_info ltc2387_infos[] = {
> +	[ID_LTC2387_16] = {
> +		.name = "ltc2387-16",
> +		.default_gain_milli = 1000,
> +		.resolution = 16,
> +		.test_pattern = LTC2387_TEST_PATTERN_16,
> +		.channels = { LTC2378_CHAN(16, 16) },
> +		.num_channels = 1,
> +	},
As mentioned below. Split this up into individual named
structures where the name makes it clear what device they are for.

> +
> +static int ltc2387_setup(struct iio_dev *indio_dev)
> +{
> +	struct ltc2387_dev *ltc = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +
> +	if (device_property_present(dev, "adi,use-two-lanes"))
> +		ltc->lane_mode = TWO_LANES;
> +
> +	return ltc2387_set_sampling_freq(ltc, 15 * MHz);
So this (I think) is the call that actually enables the pwms.
The devm unwinding should pair with setup not the pwm_get()
> +}


> +
> +static const struct of_device_id ltc2387_of_match[] = {
> +	{
> +		.compatible = "lltc,ltc2387-16",
> +		.data = &ltc2387_infos[ID_LTC2387_16]
> +	}, {
> +		.compatible = "lltc,ltc2387-16-x4",
> +		.data = &ltc2387_infos[ID_LTC2387_16_X4]
> +	}, {
> +		.compatible = "lltc,ltc2387-18",
> +		.data = &ltc2387_infos[ID_LTC2387_18]
> +	}, {
> +		.compatible = "lltc,ltc2387-18-x4",
> +		.data = &ltc2387_infos[ID_LTC2387_18_X4]
> +	}, {
> +		.compatible = "adi,adaq23875",
> +		.data = &ltc2387_infos[ID_ADAQ23875]
> +	}, {
> +		.compatible = "adi,adaq23876",
> +		.data = &ltc2387_infos[ID_ADAQ23876]
> +	}, {
> +		.compatible = "adi,adaq23878",
> +		.data = &ltc2387_infos[ID_ADAQ23878]

trailing comma.

Also there doesn't seem to be a reason to have these in an array.
Split them up into individually named structures. That tends
to end up easier to read in the longer term and removes
the need for the enum.  We are slowly removing this array
approach from existing drivers.  

> +	},
> +	{}

	{ }

> +};
> +MODULE_DEVICE_TABLE(of, ltc2387_of_match);
> +
> +static int ltc2387_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev			*indio_dev;
> +	struct ltc2387_dev		*ltc;
> +	int				ret;

Don't force indent. It just creates churn in places like this.
Keep it for aligning numeric tables and that sort of thing only.

> +
> +	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*ltc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ltc = iio_priv(indio_dev);
> +
> +	ltc->vref = devm_regulator_get_optional(&pdev->dev, "vref");
> +	if (!IS_ERR(ltc->vref)) {
> +		ret = regulator_enable(ltc->vref);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't enable vref regulator\n");
> +			return ret;

return dev_err_probe()

> +		}
> +		ret = regulator_get_voltage(ltc->vref);
> +		if (ret < 0)
> +			return ret;
> +
> +		ltc->vref_mv = ret / 1000;
> +		ret = devm_add_action_or_reset(&pdev->dev,
> +					       ltc2387_regulator_disable,
> +					       ltc->vref);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (PTR_ERR(ltc->vref) != -ENODEV)
> +			return PTR_ERR(ltc->vref);
> +
> +		ltc->vref_mv = LTC2387_VREF; /* Internal vref is used */
> +	}
> +
> +	ltc->ref_clk = devm_clk_get(&pdev->dev, NULL);

	ltc->ref_clk = devm_clk_get_enabled() looks like it would
work here.

> +	if (IS_ERR(ltc->ref_clk))
> +		return PTR_ERR(ltc->ref_clk);
> +
> +	ret = clk_prepare_enable(ltc->ref_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_clk_disable,
> +				       ltc->ref_clk);
> +	if (ret)
> +		return ret;
> +	ltc->ref_clk_rate = clk_get_rate(ltc->ref_clk);
> +
> +	ltc->clk_gate = devm_pwm_get(&pdev->dev, "clk_gate");
> +	if (IS_ERR(ltc->clk_gate))
> +		return PTR_ERR(ltc->clk_gate);
> +
See above. IIRC pwms aren't turned on by the get.  So
as above I think this should be paired with the
setup call not here.

> +	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
> +				       ltc->clk_gate);
> +	if (ret)
> +		return ret;
> +
> +	ltc->cnv = devm_pwm_get(&pdev->dev, "cnv");
> +	if (IS_ERR(ltc->cnv))
> +		return PTR_ERR(ltc->cnv);
> +
> +	ret = devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
> +				       ltc->cnv);
Same as previous. Also no blank line here.
> +
> +	if (ret)
> +		return ret;
> +
> +	ltc->device_info = device_get_match_data(&pdev->dev);
> +	if (!ltc->device_info)
> +		return -EINVAL;

Do this early given it is a trivial check and saves on unwinding all
the above if it fails.

> +
> +	ltc->gain_milli = ltc->device_info->default_gain_milli;
> +	device_property_read_u32(&pdev->dev, "adi,gain-milli", &ltc->gain_milli);
We now do optional properties with error checking but
	if (device_property_present()) {
		ret = device_property_read_u32();
		if (ret)
			..
		if (!ltc->gain_milli)
				...
		}
// or drop this out of the if else if you prefer.
	} else {
		ltc->gain_milli = ...
	}	
> +	if (!ltc->gain_milli)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "adi,gain-milli must be nonzero\n");
> +
> +	indio_dev->channels = ltc->device_info->channels;
> +	indio_dev->num_channels = ltc->device_info->num_channels;
> +	indio_dev->dev.parent = &pdev->dev;

That is unlikely to be needed... The IIO core has set parent
up for you for quite a while now.

> +	indio_dev->name = ltc->device_info->name;
> +	indio_dev->info = &ltc2387_info;
> +
> +	ltc->back = devm_iio_backend_get(&pdev->dev, NULL);
> +	if (IS_ERR(ltc->back))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ltc->back),
> +				     "failed to get IIO backend\n");
> +
> +	ret = devm_iio_backend_request_buffer(&pdev->dev, ltc->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(&pdev->dev, ltc->back);
> +	if (ret)
> +		return ret;
> +
> +	/* axi_ltc2387 has a single capture channel carrying every scan element. */
> +	ret = iio_backend_chan_enable(ltc->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = ltc2387_setup(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "\nltc2387 setup failed\n");
> +		return ret;

return dev_err_probe() for any error prints in probe or functions
only called from probe.  It improves the message formatting
even when no chance of deferral.

> +	}
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver ltc2387_driver = {
> +	.probe          = ltc2387_probe,
> +	.driver         = {
I'd not bother forcing alignment. It just ends up inconsistent.

> +		.name   = "ltc2387",
> +		.of_match_table = ltc2387_of_match,
> +	},
> +};
> +module_platform_driver(ltc2387_driver);

