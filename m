Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B039D23AE62
	for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785014680; cv=none; b=is/dQgbMw9U+Ed6YZAJpZscrmFy/8n9+OPFpERmvV2gr831bkZFRS1P0tvPpC+iZ7YwsovOQZrmx/eJMbkj1x4ELDW0WbUPxwrxgiiRCrd0m6kBk/eKFr12OnbqSEN1y1wZ+1LDKpUddHXCbyGsMnQ6KLsdzTcer91lVtI0MK3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785014680; c=relaxed/simple;
	bh=4gz5R9M+oa/P32DT0BIugV/l9k7FJJm7zZXwSsQIvZ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4bUi2oKq0v1rhgtBE0oZcdK3jylpijHjN0gkUL76OhD49yTs3a+29Cvk8Hh9VR6GwY7sOa2Zu465MBagKmz45YiyQQLNo2v/1VDNRT4fVxmObp+Tv5aefdldj4qxs1BE+yrDH5k5X4+JOjrk6vAUY8ebLrZ52nDpmV8ymE6yYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=cekW0Zof; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="cekW0Zof"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6aae244ef49so886219eaf.2
        for <linux-iio@vger.kernel.org>; Sat, 25 Jul 2026 14:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785014677; x=1785619477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Q45Gsx0m2v4LPXx0jIGvR8WQdPydqxbJsSsLtf8XUc=;
        b=cekW0Zof0qwE/aK8zWwC2EkFGEXgLmkgiGm0mEZVXl7C/FpW8boutwMmD4JqwzV8Ew
         Mcoxh6plj2HRKX+UO7YoX0FeSMOUGrZgdjs+aPBcEHiHkLz9fvUatvsRoYsFtdAG7CXB
         aDm5R4BTIl+Z9YCzkMzHbhy2D5+aLGN9hte932zziO917xU4Dq/L304drkGnfKUk3WlN
         Y6RM2i5KfsAlyDA5S46gnz1ObmXBadpOSMxG4SiHa1lYtkimuaJyseQVvIeOV7dfWJED
         OuqjMvj1j80eVRRzN1zb/FfCEmLLDpku3OpKzqnTOaIMFGdPzjDvo5mxwDganMFo0g1o
         xcYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785014677; x=1785619477;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Q45Gsx0m2v4LPXx0jIGvR8WQdPydqxbJsSsLtf8XUc=;
        b=obn45SIPyUOWdlLocRNoiMajmaP3TePxHmUXAaZtrOP7wTGCGM2ViCBb66bw2DJn8h
         NqjhrVRKduqNJNMTThC7d6ICPIsgf8wZJinPRuOaiLni1thn3sqUqSEqG3qeloI75eiP
         u1/IRViOr3/7RDlmGo4htzEyMuqzcKo2ZYpdRUouksvkwMU3NtTCq4zTsD3uYG7djUwQ
         FjzRr1MSDCwqbgtKNyXAcyfzL8+H9WzLWBYKk9TSbYXT+j+EA4EQMQJ8RY77WlyCDK1q
         L3CIfCjNNpf1ackoaPjeVTAilMzMw59Ob0LaIOh2Ts5JwFg3rfoTUVNC6m+AHI9r0pY7
         T22w==
X-Gm-Message-State: AOJu0Yz3IynMAlcs8AfaWFmb8lbwOCVxHvPP5xDp1H7LYlAMuHCzwmnR
	a7GqXSDsjR+HisTsWAsp5wYas5SBAwilbFXe+9JzLnKrp1m6dL12TOe1tPHHWVPCcF0=
X-Gm-Gg: AR+sD13qdexNCsxJo9413fmyTuT5F3JSpm/NsAd75nSPMxGRl8kSfYEp4Cdo17jTbC3
	KvhFEHJC6Y4oAMFKH8KZsyzHO1u/5om7yP/n+5ALX9nOzHVVdUz+ot1R/cZ22/g9PIXhlYBrM/j
	412zAaNoH2InJ2DuR9/JdtTSOnN1wgl9/zckQ6qKd2e0FVpx4Rpb6WWRYYSm5kW4J9WtYBvjBl/
	XwF97jLEsBsky5batZnArIhAcBg/aaOHcbwbrUIJgSpZy7zPr8smAl5wqfeoqIKWQvd8DEyBsHe
	LJgV9cpmfWVYb2hyniPCclMVDEXBFjtlmWTNX8l0pUuvd6ikIKCmzj802WLZXuAW3xt4t8kzfMf
	mXgoeiPD/0AhRzEhh4jE4vAzGifhw7EigOGNqDwIH+jiQcZtt1xHjmvpiTc8DzDl99J5yEK/SiX
	d9unvBPqAQmDEJOuPc2RWGiNtdjjPiyQ57cGgd7uovZTsDOeo=
X-Received: by 2002:a05:6820:4c02:b0:6a3:77e0:84b with SMTP id 006d021491bc7-6aaffaa784amr2679037eaf.60.1785014677542;
        Sat, 25 Jul 2026 14:24:37 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:105e:29ca:45cc:c7? ([2600:8803:e7e4:500:105e:29ca:45cc:c7])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6aaf96f4501sm2239669eaf.12.2026.07.25.14.24.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jul 2026 14:24:36 -0700 (PDT)
Message-ID: <a1970d93-6bfa-4eec-8bd5-a2457b49bd88@baylibre.com>
Date: Sat, 25 Jul 2026 16:24:33 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] iio: dac: Add AD5529R DAC driver support
To: Janani Sunil <janani.sunil@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Mark Brown <broonie@kernel.org>,
 Marius Cristea <marius.cristea@microchip.com>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 Kent Gustavsson <kent@minoris.se>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Janani Sunil <jan.sun97@gmail.com>, linux-spi@vger.kernel.org,
 Kent Gustavsson <nedo80@gmail.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-7-7781cd74ad75@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260722-ad5529r-driver-v7-7-7781cd74ad75@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/26 2:54 AM, Janani Sunil wrote:
> Add support for AD5529R 16-channel, 12/16 bit Digital to Analog Converter
> from Analog Devices.
> 

...

> +struct ad5529r_state {
> +	struct spi_device *spi;
> +	const struct ad5529r_model_data *model_data;
> +	struct regmap *regmap_8bit;
> +	struct regmap *regmap_16bit;
> +	struct iio_chan_spec channels[16];

Probably makes sense to make a macro for max num channels.

> +	unsigned int num_channels;
> +	enum ad5529r_output_range output_range_idx[16];
> +};
> +

...

> +static int ad5529r_probe(struct spi_device *spi)
> +{
> +	struct device *dev = &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct ad5529r_state *st;
> +	struct regmap_config regmap_8bit_cfg;
> +	struct regmap_config regmap_16bit_cfg;
> +	bool external_vref;
> +	u32 dev_addr = 0;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +
> +	st->spi = spi;
> +
> +	st->model_data = spi_get_device_match_data(spi);
> +	if (!st->model_data)
> +		return dev_err_probe(dev, -EINVAL,

We should pick a value and stick with it. Latest favorite is ENODATA.

> +				     "Failed to identify device variant\n");
> +
> +	device_property_read_u32(dev, "spi-device-addr", &dev_addr);
> +	if (dev_addr > 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "spi-device-addr %u out of range [0, 3]\n",
> +				     dev_addr);
> +
> +	regmap_8bit_cfg = (struct regmap_config) {
> +		.name = "ad5529r-8bit",
> +		.reg_bits = 16,
> +		.val_bits = 8,
> +		.max_register = AD5529R_8BIT_REG_MAX,
> +		.read_flag_mask = AD5529R_SPI_READ_FLAG,
> +		.rd_table = &ad5529r_8bit_readable_table,
> +		.wr_table = &ad5529r_8bit_writeable_table,
> +		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
> +	};
> +	regmap_16bit_cfg = (struct regmap_config) {
> +		.name = "ad5529r-16bit",
> +		.reg_bits = 16,
> +		.val_bits = 16,
> +		.max_register = AD5529R_MAX_REGISTER,
> +		.read_flag_mask = AD5529R_SPI_READ_FLAG,
> +		.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +		.rd_table = &ad5529r_16bit_readable_table,
> +		.wr_table = &ad5529r_16bit_writeable_table,
> +		.reg_stride = 2,
> +		.reg_base = dev_addr << AD5529R_ADDR_SHIFT,
> +	};
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(ad5529r_supply_names),
> +					     ad5529r_supply_names);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable regulators\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "hvss");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable hvss regulator\n");
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vref");
> +	if (ret == -ENODEV)
> +		external_vref = false;
> +	else if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get and enable vref regulator\n");
> +	else
> +		external_vref = true;
> +
> +	st->regmap_8bit = devm_regmap_init_spi(spi, &regmap_8bit_cfg);
> +	if (IS_ERR(st->regmap_8bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_8bit),
> +				     "Failed to initialize 8-bit regmap\n");
> +
> +	st->regmap_16bit = devm_regmap_init_spi(spi, &regmap_16bit_cfg);
> +	if (IS_ERR(st->regmap_16bit))
> +		return dev_err_probe(dev, PTR_ERR(st->regmap_16bit),
> +				     "Failed to initialize 16-bit regmap\n");
> +
> +	ret = ad5529r_reset(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset device\n");
> +
> +	ret = regmap_assign_bits(st->regmap_16bit, AD5529R_REG_REF_SEL,
> +				 AD5529R_REF_SEL_INTERNAL_REF,
> +				 external_vref ? 0 : AD5529R_REF_SEL_INTERNAL_REF);

regmap_assign_bits() take bool, so just external_vref without the ?:.

> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to configure reference\n");
> +
> +	ret = ad5529r_parse_channel_ranges(dev, st);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = st->model_data->model_name;
> +	indio_dev->info = &ad5529r_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = st->channels;
> +	indio_dev->num_channels = st->num_channels;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
