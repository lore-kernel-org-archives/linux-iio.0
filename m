Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787F01A6817;
	Sat, 13 Jun 2026 18:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377183; cv=none; b=uIN/mMcrxYtMu16OL+KElNMVfGYtdzCIi1oTjN+sHtWG/W/9R6LuUbBX4nvnJ9MYWobZexHLfFSrBSq7PiW9V1fuTrqW4oHO7xzsoNaH778272z59poO99zbLPvdzRz8pZJNNqIQmVVisgmb9jYn7x3e4mChxigL/TSL9J4jjjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377183; c=relaxed/simple;
	bh=CmzhQib4fvHKdIxjOsJLEXVLLDCn7oEgJ/0AWrT4BFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QQa5DFA1DQoQWIAG/2kG0dpGLqfr3PPYdwn/gY8sQb+/VGBdWenL93LQIol0LVvU5F7lONBtblKoKcGSpO11kXBgpCQEkwwp+L7ID2dx+r2D/HFSQOYNDQQBpXMh0s11Ev/Ie4doZOTTRPS7LvyynOoCICiFCw03Rsy+inRdwBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dli7VO1i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dli7VO1i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6937F1F000E9;
	Sat, 13 Jun 2026 18:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781377182;
	bh=eRoI+4eIP0KMU8IMBuQepEAJ6uz5U/Oa0zjpt3Woq5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dli7VO1ioqFM57aM/olMUdHMmeicJyK3DKilzhq/lJXvVewx+4isK91XqJG2QH6K1
	 kYIcKD/7h2QJ2/SR6u+Oqt6JiS1lWtAwFUdzVg6w2zabeUtupJyvjsc/xr/PSq6Unc
	 M8ToI1PIc5CSjnOefkEB4aZlutA6R9Yy9zIupLilYEqqL+VE4JsPi+z5GevZVWK1Cp
	 kFNcqYItF/DIpn/C+lI4neZlQGbQmg7Ly6eicN36IcBZeNmSMkGTsegSrQKc8s4tSe
	 n2R6O3IaZ9TPVQDfbU/P1sWnaQHw2Pyfk3y31oycXU3nWf3IkxCxDNSLQSI2eqjt1r
	 airTh8GLFMfFg==
Date: Sat, 13 Jun 2026 20:59:39 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: adc: Add ti-ads1262 driver
Message-ID: <20260613-sparkling-naughty-tuna-3e9bf1@quoll>
References: <20260612-ads126x-v1-0-894c788d03ed@gmail.com>
 <20260612-ads126x-v1-2-894c788d03ed@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260612-ads126x-v1-2-894c788d03ed@gmail.com>

On Fri, Jun 12, 2026 at 05:46:20PM -0500, Kurt Borja wrote:
> +
> +	val = FIELD_PREP(ADS1262_IDACMAG_MAG1_MASK, idac_mags[0]);
> +	val |= FIELD_PREP(ADS1262_IDACMAG_MAG2_MASK, idac_mags[1]);
> +
> +	return regmap_update_bits(st->regmap, ADS1262_IDACMAG_REG,
> +				  ADS1262_IDACMAG_MAG1_MASK |
> +				  ADS1262_IDACMAG_MAG2_MASK, val);
> +}
> +
> +static int ads1262_gpio_setup(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct gpio_desc *gpiod;
> +	const char *con_id;
> +
> +	con_id = "start";

Nope, see further

> +	gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_OUT_LOW);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gpiod),
> +				     "Failed to get %s GPIO\n", con_id);
> +	st->start_gpiod = gpiod;
> +
> +	con_id = "reset";

Nope

> +	gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_OUT_HIGH);
> +	if (IS_ERR(gpiod))
> +		return dev_err_probe(dev, PTR_ERR(gpiod),
> +				     "Failed to get %s GPIO\n", con_id);
> +	st->reset_gpiod = gpiod;
> +
> +	return 0;
> +}
> +
> +static int ads1262_clk_setup(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct clk *clk;
> +	int ret;
> +
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to get external clock\n");
> +
> +	/*
> +	 * The nominal clock frequency as indicated by the datasheet is
> +	 * 7372800.
> +	 */
> +	ret = clk_set_rate(clk, 7372800);
> +	if (ret)
> +		return dev_err_probe(dev, PTR_ERR(clk),
> +				     "Failed to set the nominal clock frequency.\n");
> +
> +	return 0;
> +}
> +
> +static int ads1262_regulator_setup(struct ads1262 *st)
> +{
> +	struct device *dev = &st->spi->dev;
> +	const char *reg_id, *prop;
> +	u32 mux[2] = {};
> +	int val, ret;
> +
> +	reg_id = "dvdd";
> +	ret = devm_regulator_get_enable(dev, reg_id);
> +	if (ret)
> +		goto err_regulator_get;
> +
> +	reg_id = "avdd";

Nope.

> +	ret = devm_regulator_get_enable(dev, reg_id);
> +	if (ret)
> +		goto err_regulator_get;
> +
> +	prop = "ti,neg-refmux";
> +	device_property_read_u32(dev, prop, &mux[0]);
> +	if (mux[0] >= ADS1262_RMUX_COUNT)
> +		return dev_err_probe(dev, -ENXIO, " %s out of range\n", prop);
> +
> +	prop = "ti,pos-refmux";

Don't do such syntax. You make git grep unnecesssary difficult.

> +	device_property_read_u32(dev, prop, &mux[1]);

And this shows in `git grep` as completely pointless code.

> +	if (mux[1] >= ADS1262_RMUX_COUNT)
> +		return dev_err_probe(dev, -ENXIO, " %s out of range\n", prop);
> +
> +	if (mux[0] == ADS1262_RMUX_INTER && mux[1] == ADS1262_RMUX_INTER) {
> +		/* The internal voltage reference is 2.5 V */
> +		st->vref_uV = 2500000;
> +		return 0;
> +	}
> +
> +	val = FIELD_PREP(ADS1262_REFMUX_RMUXN_MASK, mux[0]);
> +	val |= FIELD_PREP(ADS1262_REFMUX_RMUXP_MASK, mux[1]);
> +	ret = regmap_update_bits(st->regmap, ADS1262_REFMUX_REG,
> +				 ADS1262_REFMUX_RMUXN_MASK |
> +				 ADS1262_REFMUX_RMUXP_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	reg_id = "vref";

Nope.

> +	st->vref_uV = devm_regulator_get_enable_read_voltage(dev, reg_id);
> +	if (st->vref_uV < 0)
> +		goto err_regulator_get;
> +
> +	return 0;
> +
> +err_regulator_get:
> +	return dev_err_probe(dev, ret, "Failed to get regulator %s\n", reg_id);
> +}
> +

Functions used by probe() should be before probe(), not somewhere in the
middle of the code. IOW, entire probe is together.
...

> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ads1262_runtime_suspend(struct device *dev)
> +{
> +	struct ads1262 *st = dev_get_drvdata(dev);
> +
> +	if (!st->reset_gpiod)
> +		return 0;
> +
> +	regcache_cache_only(st->regmap, true);
> +
> +	return ads1262_dev_power_off(st);
> +}
> +
> +static int ads1262_runtime_resume(struct device *dev)
> +{
> +	struct ads1262 *st = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!st->reset_gpiod)
> +		return 0;
> +
> +	ret = ads1262_dev_power_on(st);
> +	if (ret)
> +		return ret;
> +
> +	regcache_cache_only(st->regmap, false);
> +	regcache_mark_dirty(st->regmap);
> +
> +	return regcache_sync(st->regmap);
> +}
> +
> +DEFINE_RUNTIME_DEV_PM_OPS(ads1262_runtime_pm, ads1262_runtime_suspend,
> +			  ads1262_runtime_resume, NULL);
> +
> +static const struct of_device_id ads1262_of_match[] = {
> +	{ .compatible = "ti,ads1262" },
> +	{ .compatible = "ti,ads1263" },

So devices are fully compatible? Then it should be expressed in the
binding and drop one entry here.

Best regards,
Krzysztof

