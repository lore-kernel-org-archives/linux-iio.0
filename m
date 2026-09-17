Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3A328267;
	Thu, 17 Sep 2026 03:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789616941; cv=none; b=GGgk9G/isppvPhctT6MZ6lj33GYa7Rlah16ZVHmjvqvkAnh8XOs2tI0yMeayJXxSVtedXnTuHWtUjh5WpHX17EnFavG1qJDNZMPyBabntWof8ZCHeGKzw54VjjKMbw9ty5VKqrPBg9+tTKpvGefOKQQ00C+TM78grUN12B17QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789616941; c=relaxed/simple;
	bh=Uat/z6cGATNJ4kkEWkITpJru7QWK9y/TQx+wvyOKnSs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MX0x5m+h+Y/B2nsHxDEo3f9YVNYZqKDC/P95DM4qE4FCk7o76j7E6QVZ+2uKY3fN8PCzanYFj0U3T3sg+7AAMcRQOdxrb7TmJJUnB82TmuSJLzar6GvIiTWQ/E2ZACXNfsTGOJhJJ06VcZYygouLtZGofQJDuBXmBCVz+zGn7tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aU/V5gQ9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aU/V5gQ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B5011F000FF;
	Thu, 17 Sep 2026 03:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789616939;
	bh=Y6cGKpFcCklW5Jo9lNnPFtDobTnBJlFsS9ENQ2sHdzE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aU/V5gQ93+pC+HRvqA/GfcLuuoJerzIZRwAVgWFNc1LPfEN8aD/9NTQTIHJhKnRGz
	 P65Loi3/d44DMrYVZYIBARgqHf9R6cwuxfZbhOMxd56L4yRuEAv3QZPwQkWsK3/0Fh
	 0DavfcfmTFDDYChL6uO/OZO9md8pqPXyuO/PgtZUNQSu8ncGDMjAxbwIoRDdORoDTy
	 zd6rm/pduy0W2mtPO4P2jFyL0STx4B3wMwkTfi1vECbn5MUwMSkUIzwLd0dd7fpvrg
	 OYKgu5R18lPgUS9d/AzoJ2AZQCYwv7NIyuqnIP/JwcDNDCX8gUOHj9rkEkEZOLVC18
	 cC0HI/3hZMQZQ==
Date: Thu, 17 Sep 2026 04:48:52 +0100
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
 Scorcia <l.scorcia@gmail.com>
Subject: Re: [PATCH 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
Message-ID: <20260917044852.3da6f7e5@jic23-hlaptop>
In-Reply-To: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-2-d35d2ac3d6f0@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
	<20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-2-d35d2ac3d6f0@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 23:15:27 -0500
Ryan Brue <ryanbrue.dev@gmail.com> wrote:

> The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
> built around this PMIC it is the only way to read the battery: the SoC's
> AUXADC is wired to board thermistors and the charger ICs these boards use
> have no ADC of their own.
> 
> Add a driver exposing the battery voltage and battery temperature
> channels. Only those two are described, so a channel ID in the device tree
> is an index into the driver's channel array rather than the PMIC's channel
> number, as mt6323-auxadc does. The ready bit lives in a channel's raw
> result register, but the value comes from the chip's trimmed copy of it,
> which is what the vendor driver reads for a measurement.
> 
> Both channels need more than that, as the vendor programs them. The
> battery voltage is measured through ISENSE, because a board with a
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

I took a quick look but Andy called out the biggest question,
why doesn't it make sense to extend an existing driver to
cover this part?  Might not make sense but you need to talk
through why not in the cover letter.

> diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
> new file mode 100644
> index 000000000000..dbfa82341d6c
> --- /dev/null
> +++ b/drivers/iio/adc/mt6397-auxadc.c
...

> +/*
> + * CHR_CON16 and the two SOURCE_CH0 selects route either BATSNS or ISENSE onto
> + * the battery channel. Only ISENSE is used: with a switching charger in the
> + * power path BATSNS sits on the system rail rather than on the pack.
> + */
> +#define MT6397_CHR_CON16		0x0020
> +#define MT6397_CHR_CON16_ADCIN_VSEN_EN	BIT(11)
> +#define MT6397_CHR_CON16_ADCIN_VBAT_EN	BIT(10)

These are used as values for the ADCIN_SEL.
I think they should have names to make that clear and be
1 and 2 rather than bits.

> +#define MT6397_CHR_CON16_ADCIN_SEL	(MT6397_CHR_CON16_ADCIN_VSEN_EN | \
> +					 MT6397_CHR_CON16_ADCIN_VBAT_EN)

This would then be a register field mask from GENMASK()

> +#define MT6397_AUXADC_CON14		0x055e
> +#define MT6397_AUXADC_CON14_CH0_NORM_SEL BIT(2)
> +#define MT6397_AUXADC_CON14_CH0_LBAT_SEL BIT(0)

A common visual trick in IIO drivers separates register addresses from fields
and from values.
#define MT6397_AUXADC_CON14		0x055e
#define   MT6397_AUXADC_CON14_CH0_NORM_SEL BIT(2)
#define   MT6397_AUXADC_CON14_CH0_LBAT_SEL BIT(0)

Also blank line here as the settle time is not directly related to the
register.
> +#define MT6397_AUXADC_ISENSE_SETTLE_US	USEC_PER_MSEC
> +
> +struct mt6397_auxadc {
> +	struct regmap *regmap;
> +	/* AUXADC doesn't support reading multiple channels simultaneously. */

I'd rather you said why than simply not supported. Seems
that it's a multi register sequence so needs to be atomic wrt
to other channel reads.

> +	struct mutex lock;
> +};
> +
> +#define MTK_PMIC_IIO_CHAN(_name, _chan, _hwchan)                \
> +{                                                               \
> +	.type = IIO_VOLTAGE,                                    \
> +	.indexed = 1,                                           \
> +	.channel = _chan,                                       \
> +	.address = _hwchan,                                     \
> +	.datasheet_name = __stringify(_name),                   \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
> +			      BIT(IIO_CHAN_INFO_SCALE),         \
> +}
For two the macro is of marginal benefit. I'd just put the structure
values in directly.  Then we know which parameter is which etc.
> +
> +/*
> + * A device tree channel ID indexes this array; .address holds the PMIC channel
> + * number. The thermistor reports as a voltage because that is all the PMIC
> + * measures: the divider across an NTC whose curve belongs to the board.
> + */
> +static const struct iio_chan_spec mt6397_auxadc_channels[] = {
> +	MTK_PMIC_IIO_CHAN(isense,   MT6397_AUXADC_ISENSE,

If you do keep this, one space is enough. Aligning when there
are lines in between brings little value that I can see.

> +			  MT6397_AUXADC_HWCHAN_BATSNS),
> +	MTK_PMIC_IIO_CHAN(bat_temp, MT6397_AUXADC_BAT_TEMP,
> +			  MT6397_AUXADC_HWCHAN_BAT_TEMP),
> +};
> +
> +static int mt6397_auxadc_read_once(struct mt6397_auxadc *adc,
> +				   const struct iio_chan_spec *chan, int *val)
> +{
> +	struct regmap *map = adc->regmap;
> +	unsigned int reg;
> +	int ret;
> +
> +	ret = regmap_update_bits(map, MT6397_AUXADC_CON1,
> +				 MT6397_AUXADC_CON1_CHSEL,
> +				 FIELD_PREP(MT6397_AUXADC_CON1_CHSEL,
> +					    chan->address));
> +	if (ret)
> +		return ret;
> +
> +	/* START is edge triggered: it has to be lowered before being raised. */
> +	ret = regmap_clear_bits(map, MT6397_AUXADC_CON1,
> +				MT6397_AUXADC_CON1_START);
For lines that go not much over 80 chars and where it helps readability it
is fine to break that limit.  I think that applies here.
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_set_bits(map, MT6397_AUXADC_CON1,
> +			      MT6397_AUXADC_CON1_START);
and here.

> +	if (ret)
> +		return ret;
> +
> +	fsleep(MT6397_AUXADC_START_US);
> +
> +	ret = regmap_read_poll_timeout(map, MT6397_AUXADC_ADC(chan->address),
> +				       reg, reg & MT6397_AUXADC_ADC_RDY,
> +				       100, 100 * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(map, MT6397_AUXADC_ADC_TRIM(chan->address), &reg);
> +	if (ret)
> +		return ret;
> +
> +	*val = FIELD_GET(MT6397_AUXADC_ADC_VAL, reg);
> +
> +	return 0;
> +}
> +
> +static int mt6397_auxadc_battemp_bias(struct mt6397_auxadc *adc, bool on)
> +{
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +
> +	if (on) {
> +		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
> +				      MT6397_AUXADC_CON0_BUF_PWD_ON);
> +		if (ret)
> +			return ret;
Add a blank line here 
> +		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
> +				      MT6397_AUXADC_CON0_BUF_PWD_B);
> +		if (ret)
> +			return ret;
and here.  Small readability improvement but worth having!

> +		return regmap_set_bits(map, MT6397_CHR_CON7,
> +				       MT6397_CHR_CON7_BATON_TDET_EN);
> +	}

For cases like this I'd use and else.
Not strictly necessary but makes it visually obvious it is an either or
question.

> +
> +	ret = regmap_clear_bits(map, MT6397_CHR_CON7,
> +				MT6397_CHR_CON7_BATON_TDET_EN);
> +	ret = ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
> +				       MT6397_AUXADC_CON0_BUF_PWD_B);
> +	return ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
> +					MT6397_AUXADC_CON0_BUF_PWD_ON);
> +}

> +
> +static int mt6397_auxadc_isense_disable(struct mt6397_auxadc *adc)
> +{
> +	struct regmap *map = adc->regmap;
> +	int ret;
> +
> +	ret = regmap_clear_bits(map, MT6397_AUXADC_CON14,
> +				MT6397_AUXADC_CON14_CH0_NORM_SEL |
> +				MT6397_AUXADC_CON14_CH0_LBAT_SEL);
> +
> +	return ret ?: regmap_clear_bits(map, MT6397_CHR_CON16,
> +					MT6397_CHR_CON16_ADCIN_SEL);

Andy called this out already.  LLM being too clever maybe?
Anyhow, just burn a few lines of code for readability!

> +}
> +
> +static int mt6397_auxadc_read_channel(struct mt6397_auxadc *adc,
> +				      const struct iio_chan_spec *chan,
> +				      int *val)
> +{
> +	unsigned int i, sum = 0;

Please split variables that are initialized from ones that aren't.
Can be hard to spot when just one is.

> +	int ret, sample;
> +
> +	/* Held across the whole burst: the channel select is shared state. */
> +	guard(mutex)(&adc->lock);
> +
> +	if (chan->channel == MT6397_AUXADC_ISENSE) {
> +		ret = mt6397_auxadc_isense_enable(adc);
> +		if (ret)
> +			return ret;
> +		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
> +	} else {
> +		ret = mt6397_auxadc_battemp_bias(adc, true);
> +		if (ret)
> +			return ret;
> +		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
> +	}
> +
> +	for (i = 0; i < MT6397_AUXADC_SAMPLES; i++) {

	for (unsigned int i = 0; ...

> +		ret = mt6397_auxadc_read_once(adc, chan, &sample);
> +		if (ret)
> +			break;
> +
> +		sum += sample;
> +	}
> +
> +	/* Lower START so the converter is not left armed between reads. */
> +	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
> +			  MT6397_AUXADC_CON1_START);
> +
> +	if (chan->channel == MT6397_AUXADC_ISENSE)
> +		mt6397_auxadc_isense_disable(adc);
> +	else
> +		mt6397_auxadc_battemp_bias(adc, false);
> +
> +	if (ret)
> +		return ret;
> +
> +	*val = DIV_ROUND_CLOSEST(sum, MT6397_AUXADC_SAMPLES);
> +
> +	return 0;
> +}

> +
> +static int mt6397_auxadc_init(struct mt6397_auxadc *adc)
> +{
> +	return regmap_update_bits(adc->regmap, MT6397_AUXADC_CON0,
> +				  MT6397_AUXADC_CON0_SPL_NUM,
> +				  FIELD_PREP(MT6397_AUXADC_CON0_SPL_NUM, 1));

Not worth having a helper to call just one thing. Put this regmap
call inline.

> +}

> +
> +static const struct of_device_id mt6397_auxadc_of_match[] = {
> +	{ .compatible = "mediatek,mt6397-auxadc" },
> +	{ /* sentinel */ }
	{ }

Is enough.  The sentinel nature of that is kind of obvious so
a while back we removed all those comments from IIO.


> +};
> +MODULE_DEVICE_TABLE(of, mt6397_auxadc_of_match);

