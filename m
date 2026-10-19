Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777EC35C1B1;
	Mon, 19 Oct 2026 02:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792376020; cv=none; b=VtVeHdWYXKkpZkeuE1rV2jZkTmi/haIYr8J9EGh1edr7ZMFVtorSMJvNlFe7Q1hf5aHYUc9liS/+t0oRlATD7VU/10Urw9Jpubx9xoTmzXoChbYIQc+9ONWpUNOJtxqQKry7x0SdrLhsNJEBSEcs9PnsC/o7DdVOPHl+F5fCFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792376020; c=relaxed/simple;
	bh=wxDdBy0anSXi0XacyEa0RDHc47kzkwLEQAmg0kUTRwE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqlJJytt5HwY1Tr8RT0XuTdGCyx9EziO0QXMGK7g3EgTlKLQjeX/AN5wF/F5YRL0Bf2QRH6qRbwq6Y1TdmXMdm0KHfvdAYJb/aAnpWFeIK8s0BqlE4HrEAkO5y5fOm30kqXB2Uge4CYNeMwj45bVJZga2w7/VFVpIGx9B/9c508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GKU6Xjhh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GKU6Xjhh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F52E1F000C4;
	Mon, 19 Oct 2026 02:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792376019;
	bh=OTeAHhDu6rLdIC+c7Ig9cS6MPdi5FFeMFdNOO55dM1c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GKU6XjhhijXdkLvmKWqe2lHLbB69e8YJyKEBgRBXBX0UKQ9bA6S9G+Om7USxlUmSe
	 0pQX1fEdIOiBPTfh2TQf6BFvoNNh9Ga0CwTWmPoeeEQcp3d9kVQVatwi84yNU75fD3
	 rwxyaZcB1ozG7EuT5EpDA/o1xO+w/wN4s4C7IaxDzKSuZuC+TQJXSy2+EL9wOSJzM5
	 AV+CEses5L1/LgQBDoJVCtXOCizpoHWfDmsJC/Nc1g9v11BEr+Z7/Xm2wfBPrTWM4x
	 DkE92auy1x01Gcu2YXObxGdnKnjqOizVA83Mw/k7G3lFUiEJs+taTrAmvtC1vDggBi
	 07MykhZB0Xhnw==
Date: Mon, 19 Oct 2026 03:13:33 +0100
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
Subject: Re: [PATCH v4 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Message-ID: <20261019031333.1010682f@jic23-hlaptop>
In-Reply-To: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-2-23533a0d30e3@gmail.com>
References: <20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-0-23533a0d30e3@gmail.com>
	<20260928-rbrue-suez-upstreaming-mt6397-auxadc-v4-2-23533a0d30e3@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Sep 2026 15:57:20 -0500
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
Hi Ryan

Sorry for the delay.

Just one thing inline. If I wasn't tired from a long day
of review I might just have made the change and asked you
to check it. So bad luck on that!

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
> new file mode 100644
> index 000000000000..8d1702658876
> --- /dev/null
> +++ b/drivers/iio/adc/mt6397-auxadc.c

> +static void mt6397_auxadc_release(struct mt6397_auxadc *adc,
> +				  const struct iio_chan_spec *chan)
> +{
> +	/* Lowering START leaves the converter unarmed between reads. */
> +	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1, MT6397_AUXADC_CON1_START);
> +
> +	if (chan->channel == MT6397_AUXADC_ISENSE)
> +		mt6397_auxadc_isense_disable(adc);
> +	else
> +		mt6397_auxadc_battemp_bias_off(adc);
> +}
> +
> +static int mt6397_auxadc_read_channel(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      int *val)
> +{
> +	struct mt6397_auxadc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&adc->lock);
> +
> +	if (chan->channel == MT6397_AUXADC_ISENSE) {
> +		ret = mt6397_auxadc_isense_enable(adc);
> +		if (ret)
> +			goto out_release;
> +
> +		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
> +	} else {
> +		ret = mt6397_auxadc_battemp_bias_on(adc);
> +		if (ret)
> +			goto out_release;
> +
> +		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
> +	}
> +
> +	ret = mt6397_auxadc_read_burst(adc, chan, val);
> +
> +out_release:
> +	mt6397_auxadc_release(adc, chan);
This ends up rather confusing.  Would you mind instead doing it as a pair of helpers
and a top level bit of code that does.

	guard(mutex)(&adc->lock);
	if (chan->channel == MT6397_AUXADC_ISENSE) {
		return mt6397_auxadc_isense_read();
	else
		return mt6397_auxadc_battemp_read();


The only thing that get duplicated is the call to read_burst()
which seems simpler than having a pair of if / else on the channel
(one hidden in this release).

> +	mutex_unlock(&adc->lock);
> +
> +	return ret;
> +}


