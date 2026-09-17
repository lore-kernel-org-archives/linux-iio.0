Received: from mail-oi2-f6.google.com (mail-oi2-f6.google.com [74.125.231.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F53ACA54
	for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 23:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789686027; cv=none; b=p0LAfFzC7uXj9C0DqgghrsAilt3Ji6RiKFfWO4tyCcdrsPti9IbGfVCpIA3G6fseMbdV+nuvHhlzJwSxQpG76jEyIeRmv8wsBTlFO2VGJTEMeJCK+Ih41ByUJMtQwghvyJO0/w9OSUbg0hE3jRVCVvfflwBnfrlLQG51lX/bhqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789686027; c=relaxed/simple;
	bh=s+1zhFpdB1wm5BdZsjQ6h3Bd7mObo5d3kpwCgiLcVw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fPmYAXKI5gjOpcLF8AEHzwFvtyDboo1Xxc+5quEJK4qYN1WI2Z2+OF4BmIOLZX4Am6LH9FOOI7UXai93tAOeP6cFb1dAw8ujmdhv6ek1E2xESPBZAK8vDALp1DOWGxwAZgRfx9tFN+mNvYKUK1QdwmnR6a4ZBEUajXvBwAFgWx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hvh6GQh9; arc=none smtp.client-ip=74.125.231.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvh6GQh9"
Received: by mail-oi2-f6.google.com with SMTP id 46e09a7af769-7f4e6693089so37650a34.0
        for <linux-iio@vger.kernel.org>; Thu, 17 Sep 2026 16:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789686023; x=1790290823; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=u9YGfpGG2ynRncYGiDzoG8oC5Zk7r9CYJBEST6kv/j8=;
        b=Hvh6GQh9FcrMWTvtqKb0IlZV5CTX/y3xKDIhsrW0MLN5BrvanBMVMuXS7r/z+4LdeY
         NTrK9kDyYTrxE/5lBzQv/SNyv7RlMZqdkh5YwsGwcUYRWlrZqrYQqnth6MxXp5hySjyS
         A90PIupEOCTA8w4Z7uoiL3b/OPfJhAOgMx7KlclpeCzPePr2a/5snE1xupco4CJLqFWA
         wf2DfutLqQK1iCkquq+Xj744OzCYuuX/ynJXTlZ5ufXaupGGUHqdhQXn1Acfka+J7Cp5
         yUUhakydu6DdeIlMavnHcOKEdACD1evry3WwUWHCfKXqpAj0gJN27l2BKm9mm2PDXIfS
         xnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789686023; x=1790290823;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=u9YGfpGG2ynRncYGiDzoG8oC5Zk7r9CYJBEST6kv/j8=;
        b=XGATDkafPgkNo+z2XFBWOYjjp8/rzkGQwEp5oPsaMH6NQcezWbs2hpc3lv7YiXCqjQ
         Omme5NGwDCSXRqg6uCT2VG7sPkWUt18p3PrpwgJkPFTnWqBwcvYJ4vZGxMd2pM1OwARV
         A5vlxxF7yM1najjEc/XXpM8bO+T2Yf3Wj3IR3m4jgyCrSeyRDh1d6/5FQZFpFczlwgIh
         b/rxDe7p+kh2Mqj8y1neZ3XlYGTbpit6XeM5gO+wkiR1mN4h/vN1Zw9KaKftN+iv+ohB
         Df64q1iY8PdWj4XTV3U9/dOzf+IyBm7p+GvzfGkJHlKmlAotOIAZfYs7bx4Pi1rRISC/
         j+Lw==
X-Forwarded-Encrypted: i=1; AKwUvBxPUfT/toN1NuLAENn1UZMRvkYYOcgy/cGizcSY2MVqv6Fi+OhFDSe2RPjR+qtKgA4ZT8i3itb0kIA=@vger.kernel.org
X-Gm-Message-State: AFuF++lZ1VxD7FG+yo0vPDudINsnDzZ0E9FFydYqytdX/lUu3cQ/JJ6c
	85wc6S/DBX0j4L5qcUC866JPEH2Vje8i9EbvwgtiuAGP5dntLlS9znyfif1YJaI/tmI=
X-Gm-Gg: AYBFou0qu3PAly+zqA/UEpY97li+q0pUVedLd8JaThCVD3nolx85+7M4oneZolU0jHl
	2enfK5fk0f3I6if+/Fhzssx6qoAjj5oJAbgMqIaub3MUsSKyT85KxGv98SjdeKIKNo3ZSh14G5A
	l5HsWLTm6WyfEDJ2qv8+uD6tJFbBis/0ODU2NMktRCrD7YpDv7pNefdfaO1vn7kILBidrpQERO0
	FXcSd/ZqQNG+ZWBpAMTsZpDsqtr/n2TCU/fwWhkhQbTXK8u2qA3ctwfXWtGR3j6CQQzgut3p4FT
	tKFh1AZZ417aBXpz/0o1rzfc4N01vQJmYWM2MqbQbwlpxsB14AfW/fkhn69+cA1kceHvFpRuw5v
	mcfXUI3cv9r/D9bwLWXrVOp3zT4+jUUG4nQ4RtwKeVq62RMn0jdAZv27e1JdJ8wuWW18BS4xJ+B
	buMP+j2wFVf1cssP9R1KteXVegliRYwpGdjgIicQbiJ75AVZXYyusdUSEWZHuG7musqaLS64y6N
	8YS/nVtdyjLV0U=
X-Received: by 2002:a05:6830:7009:b0:805:b3e5:18d9 with SMTP id 46e09a7af769-80ddff697ddmr866597a34.10.1789686022798;
        Thu, 17 Sep 2026 16:00:22 -0700 (PDT)
Received: from ?IPV6:2600:8804:5716:d800::b712? ([2600:8804:5716:d800::b712])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c4669b120sm4449271a34.10.2026.09.17.16.00.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2026 16:00:21 -0700 (PDT)
Message-ID: <9a4a8288-47e0-4388-8991-8674b85e2306@gmail.com>
Date: Thu, 17 Sep 2026 18:00:19 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: adc: mt6397-auxadc: add mt6397 PMIC AUXADC
 driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Lee Jones <lee@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 mfd@lists.linux.dev, Roman Vivchar <rva333@protonmail.com>,
 Luca Leonardo Scorcia <l.scorcia@gmail.com>
References: <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-0-d35d2ac3d6f0@gmail.com>
 <20260915-rbrue-suez-upstreaming-mt6397-auxadc-v1-2-d35d2ac3d6f0@gmail.com>
 <20260917044852.3da6f7e5@jic23-hlaptop>
Content-Language: en-US
From: Ryan Brue <ryanbrue.dev@gmail.com>
In-Reply-To: <20260917044852.3da6f7e5@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/26 10:48 PM, Jonathan Cameron wrote:
> On Tue, 15 Sep 2026 23:15:27 -0500
> Ryan Brue <ryanbrue.dev@gmail.com> wrote:
>
>> The mt6397 AUXADC is a 10-bit ADC behind the SoC's PMIC wrapper. On boards
>> built around this PMIC it is the only way to read the battery: the SoC's
>> AUXADC is wired to board thermistors and the charger ICs these boards use
>> have no ADC of their own.
>>
>> Add a driver exposing the battery voltage and battery temperature
>> channels. Only those two are described, so a channel ID in the device tree
>> is an index into the driver's channel array rather than the PMIC's channel
>> number, as mt6323-auxadc does. The ready bit lives in a channel's raw
>> result register, but the value comes from the chip's trimmed copy of it,
>> which is what the vendor driver reads for a measurement.
>>
>> Both channels need more than that, as the vendor programs them. The
>> battery voltage is measured through ISENSE, because a board with a
>> switching charger in the power path leaves BATSNS on the charger's system
>> rail instead of on the pack. The thermistor only reads correctly with the
>> PMIC's battery-detect bias and input buffer enabled, which take 20 ms to
>> settle. Both are switched back off afterwards.
>>
>> Reads average sixteen conversions in software; the chip's sample
>> accumulator makes no measurable difference at any setting, so it is left
>> at one sample per conversion.
>>
>> Assisted-by: LLM
>> Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
> I took a quick look but Andy called out the biggest question,
> why doesn't it make sense to extend an existing driver to
> cover this part?  Might not make sense but you need to talk
> through why not in the cover letter.
I replied to Andy with an explanation [1], and I will justify in my 
cover letter for v2. In short, I think the new driver is justified, but 
if it's desired to roll in the mt6397 with another driver, let me know.
>> diff --git a/drivers/iio/adc/mt6397-auxadc.c b/drivers/iio/adc/mt6397-auxadc.c
>> new file mode 100644
>> index 000000000000..dbfa82341d6c
>> --- /dev/null
>> +++ b/drivers/iio/adc/mt6397-auxadc.c
> ...
>
>> +/*
>> + * CHR_CON16 and the two SOURCE_CH0 selects route either BATSNS or ISENSE onto
>> + * the battery channel. Only ISENSE is used: with a switching charger in the
>> + * power path BATSNS sits on the system rail rather than on the pack.
>> + */
>> +#define MT6397_CHR_CON16		0x0020
>> +#define MT6397_CHR_CON16_ADCIN_VSEN_EN	BIT(11)
>> +#define MT6397_CHR_CON16_ADCIN_VBAT_EN	BIT(10)
> These are used as values for the ADCIN_SEL.
> I think they should have names to make that clear and be
> 1 and 2 rather than bits.
The OR between VSEN_EN and VBAT_EN was a mistake. These two bits are 
part of a larger set of 5 mutually exclusive enable bits (CON16 bits 
12:8). I fixed this in v2, and also added the #define s for the others. 
Let me know if I shouldn't add those because we don't use them, I'm on 
the fence for that.
>> +#define MT6397_CHR_CON16_ADCIN_SEL	(MT6397_CHR_CON16_ADCIN_VSEN_EN | \
>> +					 MT6397_CHR_CON16_ADCIN_VBAT_EN)
> This would then be a register field mask from GENMASK()
Mentioned above, but these are mutually exclusive bits, not a field, but 
it's my fault that it looked like one. Fixed in v2.
>
>> +#define MT6397_AUXADC_CON14		0x055e
>> +#define MT6397_AUXADC_CON14_CH0_NORM_SEL BIT(2)
>> +#define MT6397_AUXADC_CON14_CH0_LBAT_SEL BIT(0)
> A common visual trick in IIO drivers separates register addresses from fields
> and from values.
> #define MT6397_AUXADC_CON14		0x055e
> #define   MT6397_AUXADC_CON14_CH0_NORM_SEL BIT(2)
> #define   MT6397_AUXADC_CON14_CH0_LBAT_SEL BIT(0)
>
> Also blank line here as the settle time is not directly related to the
> register.
>> +#define MT6397_AUXADC_ISENSE_SETTLE_US	USEC_PER_MSEC
>> +
>> +struct mt6397_auxadc {
>> +	struct regmap *regmap;
>> +	/* AUXADC doesn't support reading multiple channels simultaneously. */
> I'd rather you said why than simply not supported. Seems
> that it's a multi register sequence so needs to be atomic wrt
> to other channel reads.
Ack, I'll justify it in v2. You're right about the reason. In 
particular, all the channel reads need CON1.
>> +	struct mutex lock;
>> +};
>> +
>> +#define MTK_PMIC_IIO_CHAN(_name, _chan, _hwchan)                \
>> +{                                                               \
>> +	.type = IIO_VOLTAGE,                                    \
>> +	.indexed = 1,                                           \
>> +	.channel = _chan,                                       \
>> +	.address = _hwchan,                                     \
>> +	.datasheet_name = __stringify(_name),                   \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>> +			      BIT(IIO_CHAN_INFO_SCALE),         \
>> +}
> For two the macro is of marginal benefit. I'd just put the structure
> values in directly.  Then we know which parameter is which etc.
Done in v2. If I had to guess why the LLM might have chosen the macro, 
it might be because there are other channels that exist, just not 
channels that my device uses (referencing the vendor's Amazon Fire OS 
which is based on Linux 3.18). Making it a macro would make it maybe 
cleaner for anybody who comes in and needs to add more channels? Who knows.
>> +
>> +/*
>> + * A device tree channel ID indexes this array; .address holds the PMIC channel
>> + * number. The thermistor reports as a voltage because that is all the PMIC
>> + * measures: the divider across an NTC whose curve belongs to the board.
>> + */
>> +static const struct iio_chan_spec mt6397_auxadc_channels[] = {
>> +	MTK_PMIC_IIO_CHAN(isense,   MT6397_AUXADC_ISENSE,
> If you do keep this, one space is enough. Aligning when there
> are lines in between brings little value that I can see.
>
>> +			  MT6397_AUXADC_HWCHAN_BATSNS),
>> +	MTK_PMIC_IIO_CHAN(bat_temp, MT6397_AUXADC_BAT_TEMP,
>> +			  MT6397_AUXADC_HWCHAN_BAT_TEMP),
>> +};
>> +
>> +static int mt6397_auxadc_read_once(struct mt6397_auxadc *adc,
>> +				   const struct iio_chan_spec *chan, int *val)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	unsigned int reg;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(map, MT6397_AUXADC_CON1,
>> +				 MT6397_AUXADC_CON1_CHSEL,
>> +				 FIELD_PREP(MT6397_AUXADC_CON1_CHSEL,
>> +					    chan->address));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* START is edge triggered: it has to be lowered before being raised. */
>> +	ret = regmap_clear_bits(map, MT6397_AUXADC_CON1,
>> +				MT6397_AUXADC_CON1_START);
> For lines that go not much over 80 chars and where it helps readability it
> is fine to break that limit.  I think that applies here.
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_set_bits(map, MT6397_AUXADC_CON1,
>> +			      MT6397_AUXADC_CON1_START);
> and here.
Both done in v2.
>> +	if (ret)
>> +		return ret;
>> +
>> +	fsleep(MT6397_AUXADC_START_US);
>> +
>> +	ret = regmap_read_poll_timeout(map, MT6397_AUXADC_ADC(chan->address),
>> +				       reg, reg & MT6397_AUXADC_ADC_RDY,
>> +				       100, 100 * USEC_PER_MSEC);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = regmap_read(map, MT6397_AUXADC_ADC_TRIM(chan->address), &reg);
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = FIELD_GET(MT6397_AUXADC_ADC_VAL, reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mt6397_auxadc_battemp_bias(struct mt6397_auxadc *adc, bool on)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	int ret;
>> +
>> +	if (on) {
>> +		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
>> +				      MT6397_AUXADC_CON0_BUF_PWD_ON);
>> +		if (ret)
>> +			return ret;
> Add a blank line here
>> +		ret = regmap_set_bits(map, MT6397_AUXADC_CON0,
>> +				      MT6397_AUXADC_CON0_BUF_PWD_B);
>> +		if (ret)
>> +			return ret;
> and here.  Small readability improvement but worth having!
Done in v2
>> +		return regmap_set_bits(map, MT6397_CHR_CON7,
>> +				       MT6397_CHR_CON7_BATON_TDET_EN);
>> +	}
> For cases like this I'd use and else.
> Not strictly necessary but makes it visually obvious it is an either or
> question.
Done in v2
>> +
>> +	ret = regmap_clear_bits(map, MT6397_CHR_CON7,
>> +				MT6397_CHR_CON7_BATON_TDET_EN);
>> +	ret = ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
>> +				       MT6397_AUXADC_CON0_BUF_PWD_B);
>> +	return ret ?: regmap_clear_bits(map, MT6397_AUXADC_CON0,
>> +					MT6397_AUXADC_CON0_BUF_PWD_ON);
>> +}
>> +
>> +static int mt6397_auxadc_isense_disable(struct mt6397_auxadc *adc)
>> +{
>> +	struct regmap *map = adc->regmap;
>> +	int ret;
>> +
>> +	ret = regmap_clear_bits(map, MT6397_AUXADC_CON14,
>> +				MT6397_AUXADC_CON14_CH0_NORM_SEL |
>> +				MT6397_AUXADC_CON14_CH0_LBAT_SEL);
>> +
>> +	return ret ?: regmap_clear_bits(map, MT6397_CHR_CON16,
>> +					MT6397_CHR_CON16_ADCIN_SEL);
> Andy called this out already.  LLM being too clever maybe?
> Anyhow, just burn a few lines of code for readability!
Oh yeah, almost certainly. These are the kinds of lessons I learn when 
I'm new to kernel development and have no clue how simple or complex 
certain blocks should be, haha.
Done in v2, Sashiko also pointed out that the early return could leave 
some register bits set that should be cleared, so that will be fixed in 
v2 as well.
>> +}
>> +
>> +static int mt6397_auxadc_read_channel(struct mt6397_auxadc *adc,
>> +				      const struct iio_chan_spec *chan,
>> +				      int *val)
>> +{
>> +	unsigned int i, sum = 0;
> Please split variables that are initialized from ones that aren't.
> Can be hard to spot when just one is.
Done in v2.
>> +	int ret, sample;
>> +
>> +	/* Held across the whole burst: the channel select is shared state. */
>> +	guard(mutex)(&adc->lock);
>> +
>> +	if (chan->channel == MT6397_AUXADC_ISENSE) {
>> +		ret = mt6397_auxadc_isense_enable(adc);
>> +		if (ret)
>> +			return ret;
>> +		fsleep(MT6397_AUXADC_ISENSE_SETTLE_US);
>> +	} else {
>> +		ret = mt6397_auxadc_battemp_bias(adc, true);
>> +		if (ret)
>> +			return ret;
>> +		fsleep(MT6397_AUXADC_BATTEMP_SETTLE_US);
>> +	}
>> +
>> +	for (i = 0; i < MT6397_AUXADC_SAMPLES; i++) {
> 	for (unsigned int i = 0; ...
>
>> +		ret = mt6397_auxadc_read_once(adc, chan, &sample);
>> +		if (ret)
>> +			break;
>> +
>> +		sum += sample;
>> +	}
>> +
>> +	/* Lower START so the converter is not left armed between reads. */
>> +	regmap_clear_bits(adc->regmap, MT6397_AUXADC_CON1,
>> +			  MT6397_AUXADC_CON1_START);
>> +
>> +	if (chan->channel == MT6397_AUXADC_ISENSE)
>> +		mt6397_auxadc_isense_disable(adc);
>> +	else
>> +		mt6397_auxadc_battemp_bias(adc, false);
>> +
>> +	if (ret)
>> +		return ret;
>> +
>> +	*val = DIV_ROUND_CLOSEST(sum, MT6397_AUXADC_SAMPLES);
>> +
>> +	return 0;
>> +}
>> +
>> +static int mt6397_auxadc_init(struct mt6397_auxadc *adc)
>> +{
>> +	return regmap_update_bits(adc->regmap, MT6397_AUXADC_CON0,
>> +				  MT6397_AUXADC_CON0_SPL_NUM,
>> +				  FIELD_PREP(MT6397_AUXADC_CON0_SPL_NUM, 1));
> Not worth having a helper to call just one thing. Put this regmap
> call inline.
Done in v2.
>> +}
>> +
>> +static const struct of_device_id mt6397_auxadc_of_match[] = {
>> +	{ .compatible = "mediatek,mt6397-auxadc" },
>> +	{ /* sentinel */ }
> 	{ }
>
> Is enough.  The sentinel nature of that is kind of obvious so
> a while back we removed all those comments from IIO.
>
Done in v2.
>> +};
>> +MODULE_DEVICE_TABLE(of, mt6397_auxadc_of_match);
>>

Thanks for the review!

[1] 
https://lore.kernel.org/all/2d1b80f2-53f6-4ed6-81bf-e35c0a9efb26@gmail.com/

Best regards,
Ryan
