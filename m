Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8515D346ACD;
	Fri, 25 Sep 2026 02:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790301868; cv=none; b=WBASlSaoC2gIbuwutQlRUVH3/BiylOTMsOs9rLwz1CcXbe2gquBOZDbZ8b4jwTI8m4D/G4hj20sBv0DqQyxY/33riVcUnZXJHMW34wKppW+JXvKLdD3VP/q8nqrBpIltYCFi/esOD/BlhXSiB93rA6K+wDWWOhGvEGWrijl5JaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790301868; c=relaxed/simple;
	bh=1myobDPbsNnaPTnzEFMQg0wBxNrb5WoIHLoU5/hskqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ih7tJYIF+aMe8O5jDwrS4gXo4wqLOYwqWdzlsc9BuUldanAs/UYgjYrN5TyCAYq8OJzmE8mnK9vVsZlpAWUNJR8AkkN5Hjry2r1WizmVr+blpYCzvAw6FU2guHf1SDaYRNVyIYUn5Y8BsrAu+fY+TtZK+nqhpXTvCkOljH0UeGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2NEdn/i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2NEdn/i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 023251F000FF;
	Fri, 25 Sep 2026 02:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790301867;
	bh=wW+BAwJ115lKHzkVtPbY39q6Ec1PWGoy4bXyW9Rh36w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l2NEdn/itUJq0FGNeF5uTNNnMipfapi/n0/cIzcMO2/QL7kfGl5mr8CgVIwt4HYNO
	 yYBp1rK+QC96FAOk8ikA72BuUpmQDK1m+/5D1h8JxNMoEXa64LJInizG6u+VRtWzVQ
	 rZevZghLIcG7SdhnJGBEau8QBUiLJGxreBNJMC9m8r14HO7N6vIVr/St7LvcVOyl4W
	 WF4I7eTSocT8Ar+A0ZhM9Q3SXS4yU4X4oR2LPaSvYNBYjSqdIc9h84XJjVV3/QYjwK
	 RJB0pCKDcDVnXyjjfEaPAdc8WjyptHgmWEWLOzaxVfuikqRV/4fcumjvmp1lDXaD5s
	 LhywfjFOkn7MQ==
Date: Fri, 25 Sep 2026 03:04:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ryan Brue <ryanbrue.dev@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Lee
 Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>, Luca Leonardo
 Scorcia <l.scorcia@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v3 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Message-ID: <20260925030423.18d48456@jic23-hlaptop>
In-Reply-To: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-2-c00edacbee64@gmail.com>
References: <20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-0-c00edacbee64@gmail.com>
	<20260920-rbrue-suez-upstreaming-mt6397-auxadc-v3-2-c00edacbee64@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 00:31:52 -0500
Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
> built around this PMIC it is the only way to read the battery: the SoC's
> AUXADC is wired to board thermistors and the charger ICs these boards use
> have no ADC of their own.
> 
> Add a driver exposing the battery voltage and battery temperature
> channels. Only those two are described, so a channel ID in the device tree
> indexes the driver's channel array rather than the PMIC's channel number,
> as mt6323-auxadc does. The ready bit lives in a channel's raw result
> register, but the value comes from the chip's factory-calibrated copy.
> 
> The battery voltage is measured through ISENSE, because a board with a
> switching charger in the power path leaves BATSNS on the charger's system
> rail instead of on the pack. The thermistor only reads correctly with the
> PMIC's battery-detect bias and input buffer enabled, which take 20 ms to
> settle. Both are switched back off afterwards.
> 
> Reads average sixteen conversions in software; the chip's sample
> accumulator makes no measurable difference at any setting, so it is left
> at one sample per conversion.
> 
> Assisted-by: LLM
> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> 
Hi Ryan,

A few things related to code flow and readability inline.

> diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
> new file mode 100644
> index 000000000000..d860cd3a8922
> --- /dev/null
> +++ b/drivers/iio/adc/mt6397-auxadc.c


> +static int mt6397_auxadc_isense_enable(struct mt6397_auxadc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +
> +	/*
> +	 * Two of the five independent input enables, not a select field:
> +	 * BATSNS is cleared first so that the two inputs are never enabled
> +	 * onto the battery channel at the same time.

I'm not following this comment. Perhaps consider a rewrite?

> +	 */
> +	ret = regmap_clear_bits(map, MT6397_CHR_CON16, MT6397_CHR_CON16_ADCIN_VBAT_EN);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6397_CHR_CON16, MT6397_CHR_CON16_ADCIN_VSEN_EN);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_set_bits(map, MT6397_AUXADC_CON14,
> +			       MT6397_AUXADC_CON14_CH0_NORM_SEL |
> +			       MT6397_AUXADC_CON14_CH0_LBAT_SEL);
> +}


> +static int mt6397_auxadc_read_channel(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      int *val)
> +{
> +	struct mt6397_auxadc *adc = iio_priv(indio_dev);
> +	bool isense = chan->channel == MT6397_AUXADC_ISENSE;
> +	int ret, stop_err, release_err;
> +
> +	guard(mutex)(&adc->lock);
Go back to conventional mutex_lock() / mutex_unlock() or wrap
everything under the guard so you can avoid mixing goto and 
guards() (see cleanup.h docs for some of the reason why).

One option would be to just move them up in to the switch statement
from which this is called with scope carefully defined there.
It's not ideal but having a wrapper for just taking a lock
isn't pretty either and you need to do one or the other if you
don't want to fallback to non guard() approaches.

> +
> +	if (isense) {
> +		ret = mt6397_auxadc_isense_enable(adc);
> +		if (!ret)
> +			fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);

Keep to errors out of line 
		if (ret)
			goto err_stop;

		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);

> +	} else {
> +		ret = mt6397_auxadc_battemp_bias_on(adc);
> +		if (!ret)
> +			fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
> +	}
> +
> +	if (!ret)

With changes above you won't get here with ret not 0 so this can go.

> +		ret = mt6397_auxadc_read_burst(adc, chan, val);
> +
> +	/*
> +	 * The teardown is unconditional: once any part of the setup has been
> +	 * written it has to run, even if the setup itself failed part-way.
> +	 * Lowering START also leaves the converter unarmed between reads.
> +	 * A caller has nothing to do with a teardown error, so it is logged
> +	 * rather than returned.
> +	 */
> +	stop_err = regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
> +				     MT6397_AUXADC_CON1_START);
> +
> +	if (isense)
> +		release_err = mt6397_auxadc_isense_disable(adc);
> +	else
> +		release_err = mt6397_auxadc_battemp_bias_off(adc);
> +
> +	if (stop_err || release_err)
> +		dev_err(&indio_dev->dev, "failed to release channel %d\n",
> +			chan->channel);

I would make a little helper for the stuff that has to run.
So everything from the comment onwards. Then

	return mt6397_read_channel_tear_down();

err_stop:
	mt6397_read_channel_tear_down();

	return ret;
(with locks if you don't move those up into a wrapper.

> +
> +	return ret;
> +}
