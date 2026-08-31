Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2043905F4
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207794; cv=none; b=INyVv6SAEZ2DORyfYidSrLnmOfNaD9Pm/EenVB3UvDUvH36vrR4QhF54ZEUiD4LZF8Hj4uAkneHihsayjvQAWMmAcEF30F5HBYFyjRn1/MkcqkcQOTTixP1FMvvAmuMVOOEByRZi9IaxHFZ+bGQINM4qx0WnjrPLp/2KHEdITHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207794; c=relaxed/simple;
	bh=3VkGyzucBxff06v+8a5uGjErpd/DNDWM15efWFyJEyk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VlPZy66O7TPdXN1zWrLiD3uRxv6JLX/6ifLuw5Y2acjjJlV4/fmh0zF2hSMAmU7VfbYDMoF/DF8KL3/imQSZF+/H/Wx+9LVwXc+/Q5mMeOlIW7MyQ647Rw6XTfCyqGkUyjsRMYBdDVcaSNAdr640YE7LsDmqlT69yThJb74GYR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=h5WITTsF; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="h5WITTsF"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b057877851so165796eaf.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1788207790; x=1788812590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e8I1y1IAioxl0/tLNEachDsyp86Yg+01+n2ksOqLGNo=;
        b=h5WITTsF+KOZZm10tlESfm9Qh2XZSnV5I3HU88b2hj+J5viYTl/BeG//ktiFP9znuV
         BDy2gW1T+txF4AiKtS39N0nTLucaKtjsXkzoIDe75kOKFGOv1O6ZkQHhQIvXPrhWTKiP
         AQLUJ9AoMB/59eM+mkXGxrrlU1aO9EZXbIGIF+i1g7XnPIRYanVNgCs+OVyfWlVSXWe+
         PdbSgnDJXVKqvf35gGY9sxljead4oNyFdMgjyGIl1SGO4JQ5yMs3iuCgdbb/FVf88eJg
         Hvok/9wPEmBeVngqtvdbQPelJALSHB950yR8L7qu0Clwv+Wh84KEatxHRtn+uh0PcFGA
         +lGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788207790; x=1788812590;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8I1y1IAioxl0/tLNEachDsyp86Yg+01+n2ksOqLGNo=;
        b=MVa4XcEn7QD40fyyix/twg8Ckm5hnkhB9JQOdRb3xlUPOLat0mdx06/KaFTthJRlVS
         20dr7oPluXai6Zw2v8R9DYjbCyxyHyQl3HzJqMKeAqo6L851n8IImt2X2StPQvM2aCXv
         QMSUcistXlZFqHPwrFn2jD05Hxwsk97Gjf2jfGUDnXOVZJokjHBa8srm/qZ9aLz6lfod
         G0DOMUFEiJvItABzEcPgGhtWD5n2VSxrU06cz/77qBX6khqvv44ryCxxPJqdib32grq7
         QDahFJEwRqunLUi7+rGxR1nN+d9Vp1KUxYky8Qvi0LEvl8NSud6nftqW2n2mriT9vwO9
         QAYw==
X-Forwarded-Encrypted: i=1; AHgh+RpXuXsN4mEpJfTUtGTMDiIZ97wUcdpUTwLCb1DCA0k5ysGyKY/Xa/CB2+kBF/mlO2E0bcWZi4NItMI=@vger.kernel.org
X-Gm-Message-State: AFuF++nKmandg0K7EOkuZOyoY15Bytkr+EcUmY5NW2CcU3nnLqvbVN/4
	pBE9Km/Mc/dERwtBg8934zftc/X5K7vJfI73eF7FrriwPYDVwt/chAGG1Vefdu+GE/c=
X-Gm-Gg: AR+sD10Iu3eNz3yMJSr75Npwl+EV0LI8cDvC/lXDYBveyAAlkAsvS1yCSZeCBqgBbIA
	L4ZSXqCTBdk+6QI0cktDopdlxXK1TElnr5jpqaFfvRjT/bztzUOmIdwodpvJaFbIFLaNz8+w1+8
	Vy+362rs3f9f8M6KSRzVJcP3taYwckn5WSXL+kuJzWkAUeqnsBG9iT+XnzSPqpF5FI2FDKh6QOd
	jM/dztiaTypCuhPZqmy6fVSRX7PrWqKoqg+E1T7XIdUhtiMIRxfzkuFyHzVylV1BBaJptr7Aa73
	YHTtCyS6sHe36mVY29bcVToCSlm37TZpWiMPDR/eQfFhlHeDQTOIpjjB/rj4xKbChZXKjYYmpCo
	3dZxj/QrpPx39FT+RGTGl2oVIKbciB5MAVDCulCGO1FBNo0SesRrkypTc/E1+1ASVJLIMhBgbF5
	LlARmpvRqVdgZYsMA47Bs9fkoJ3WQTK/Qrji64yWVeEBPVolU/DgfjEjd2H/cCaQzQAt9FLDY1y
	ch2dQ3DxC8zC515DNl4nvhH3LlkQqwRK/gr
X-Received: by 2002:a05:6820:824:b0:6b3:6d00:263b with SMTP id 006d021491bc7-6b36d00398emr4731570eaf.19.1788207790176;
        Mon, 31 Aug 2026 13:23:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:778b:da9:a8a1:bc78? ([2600:8803:e7e4:500:778b:da9:a8a1:bc78])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-468a5891079sm11546266fac.17.2026.08.31.13.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Aug 2026 13:23:06 -0700 (PDT)
Message-ID: <bc00d888-9944-4a22-88e3-8f4d7384d037@baylibre.com>
Date: Mon, 31 Aug 2026 15:22:57 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/10] iio: adc: add the ti-ads1262 driver
To: Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260828-ads126x-v4-0-1dc27e9c0260@gmail.com>
 <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260828-ads126x-v4-3-1dc27e9c0260@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/26 1:38 AM, Kurt Borja wrote:
> Add the ti-ads1262 driver with initial support for the primary ADC
> (ADC1). The ADS1263 auxiliary ADC (ADC2) is handled by a separate driver
> and interoperability considerations were taken into account.
> 

...

> +#define ADS1262_FW_CHANNEL_COUNT		16
> +#define ADS1262_MON_CHANNEL_COUNT		4
> +#define ADS1262_REGMAP_WRITE_SZ			8
> +#define ADS1262_MONITOR_ADDR_OFFSET		100

Where does this offset come from? I would make the address the value that
gets written to MUXP/MUXN. But it looks like we are using the same value
for the .channel, so setting .address to that would be redundant.

> +
> +#define ADS1262_ADC1_RESOLUTION			32
> +
> +struct ads1262 {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct gpio_desc *start_gpiod;
> +	/* protects concurrent SPI transfers */
> +	struct mutex xfer_lock;
> +	/* protects channel state */
> +	struct mutex chan_lock;
> +	struct completion drdy;
> +	unsigned long clk_rate;
> +	u8 dev_id;
> +};
> +
> +static const char * const ads1262_device_id_to_name[] = {
> +	[ADS1262_DEV_ID] = "ads1262",
> +	[ADS1263_DEV_ID] = "ads1263",
> +};
> +
> +static const struct iio_chan_spec ads1262_monitor_chan_specs[] = {
> +	{
> +		.type = IIO_TEMP,
> +		.channel = ADS1262_INPMUX_TEMP,
> +		.channel2 = ADS1262_INPMUX_TEMP,

Since these are the same, I would just not set .channel2 and later say
MUXN = spec->differential ? spec->channel2 : spec->channel. Same applies
to others below.

> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 0,
> +		.scan_type = {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),

Where is SCALE and OFFSET?

> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = ADS1262_INPMUX_AVDD,
> +		.channel2 = ADS1262_INPMUX_AVDD,
> +		.indexed = 1,
> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 1,
> +		.scan_type = {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = ADS1262_INPMUX_DVDD,
> +		.channel2 = ADS1262_INPMUX_DVDD,
> +		.indexed = 1,
> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 2,
> +		.scan_type = {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +	{
> +		.type = IIO_VOLTAGE,
> +		.channel = ADS1262_INPMUX_TDAC,
> +		.channel2 = ADS1262_INPMUX_TDAC,

Hmm... a differential where channel == channel2 usually means a shorted
input. TDACP and TDACN can be controlled indepedantly, so really are two
separate channels.

> +		.indexed = 1,
> +		.differential = 1,
> +		.address = ADS1262_MONITOR_ADDR_OFFSET + 3,
> +		.scan_type = {
> +			.format = IIO_SCAN_FORMAT_SIGNED_INT,
> +			.realbits = ADS1262_ADC1_RESOLUTION,
> +			.storagebits = 32,
> +			.endianness = IIO_BE,
> +		},
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +	},
> +};
> +

...

> +static int ads1262_channel_read(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *spec, __be32 *val)
> +{
> +	struct ads1262 *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	ret = ads1262_set_runmode(st, ADS1262_RUNMODE_PULSE);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_channel_enable(st, spec);
> +	if (ret)
> +		return ret;
> +
> +	reinit_completion(&st->drdy);
> +
> +	ret = ads1262_dev_start_one(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_wait_for_conversion(st);
> +	if (ret)

Since wait is interruptable, do we need to do something to stop the
conversion here?

> +		return ret;
> +
> +	return ads1262_dev_read_by_cmd(st, ADS1262_OPCODE_RDATA1, val);
> +}
> +

...

> +static int ads1262_fwnode_xlate(struct iio_dev *indio_dev,
> +				const struct fwnode_reference_args *iiospec)
> +{
> +	/* REVISIT: the auxiliary ADC (ADC2) is currently not supported */
> +	if (iiospec->nargs > 1 && iiospec->args[1])
> +		return -EINVAL;
> +
> +	if (!iiospec->nargs)
> +		return 0;
> +
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {

Won't this include the timestamp channel?

> +		if (indio_dev->channels[i].address == iiospec->args[0])

I don't think .address is the right thing to use here (it is coming from
reg in the devcietree). I would expect channel. Otherwise consumers in the
devicetree have to be away of how channels were assigned rather than picking
the datasheet channel number.

And the devicetree bindings should mention the monitor channel numbers (11 - 14).

> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}
> +

...

> +static int ads1262_spi_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ads1262 *st;
> +	unsigned long rate;
> +	struct clk *clk;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &ads1262_iio_info;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	init_completion(&st->drdy);
> +
> +	ret = devm_mutex_init(dev, &st->chan_lock);
> +	if (ret)
> +		return ret;
> +	ret = devm_mutex_init(dev, &st->xfer_lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_parse_channels(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_supply_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	clk = devm_clk_get_optional_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return dev_err_probe(dev, PTR_ERR(clk), "failed to get external clock\n");
> +
> +	rate = clk_get_rate(clk);
> +	if (clk && !rate)
> +		return dev_err_probe(dev, -EINVAL, "failed to get clock rate\n");
> +	st->clk_rate = rate ? rate : ADS1262_NOMINAL_CLK_RATE;
> +
> +	st->start_gpiod = devm_gpiod_get_optional(dev, "start", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->start_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(st->start_gpiod),
> +				     "failed to get start GPIO\n");
> +
> +	st->regmap = devm_regmap_init(dev, &ads1262_regmap_bus, st,
> +				      &ads1262_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return PTR_ERR(st->regmap);
> +
> +	ret = ads1262_dev_configure(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to configure device\n");
> +
> +	indio_dev->name = ads1262_device_id_to_name[st->dev_id];

Not so sure about this. Almost always, this is coming from the compatible
match data. So unless we plan on trusting the device ID returned by the
chip over the devicetree when we add more to the device id tables and looking
up per-chip behavior from there instead of the compatible, I would go with
the traditional approach. That way the name userpace sees match the driver
behavior that goes with the other chip-specific match data that is likely
to be added in the future.

> +
> +	/*
> +	 * REVISIT: This chip has software polling capabilities, which could be
> +	 * used to stop depending on the DRDY signal.
> +	 *
> +	 * Additionally, the MISO pin also can be used as a DRDY IRQ, in which
> +	 * case the interrupt would be named 'doutdrdy', but requires extra
> +	 * timing and synchronization considerations to be reliable.
> +	 */
> +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq,
> +				     "the 'drdy' IRQ is currently required for operation\n");
> +
> +	ret = devm_request_irq(dev, irq, ads1262_irq_handler, IRQF_NO_THREAD,
> +			       indio_dev->name, st);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
