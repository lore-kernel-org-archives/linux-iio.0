Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0641D798E;
	Sun, 15 Feb 2026 18:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771180965; cv=none; b=aWtB969ZqFeEhPZcfylGbQ20U48lztcyNF9xMI9DqFz/LFbvq4SZtnxOBC/wWxSo16tvMgq4C48o/qCqjpVtUTb1Sp95dd/58yfP02k6PnUJbaWq1tDQTFJPCTmZLAQLoi1ipZORkCFd9Br2IaRnMqJcm9xH97tPYlTMlU0l240=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771180965; c=relaxed/simple;
	bh=ywWcPTltKimiru4H9ss3Q54YkrwPZ//an3ET9kV+eB8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iCi/w2fMTt/Y6+4jfebUF/3kOY4EvfczZWvLOjuPsoddXuRlcIXsWKl7Pmrc0shJFfdkNfVzUYSNZ5CEn+f8I8A6KNTXiGuloGiQhCF+QSgaEIkBpjBgKZwMSajzJWU46i+sqZNbBQ1th/X4d9HVywruSygqZpNjfMnVad8Biyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5gBwvYp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5gBwvYp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3A5C4CEF7;
	Sun, 15 Feb 2026 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771180964;
	bh=ywWcPTltKimiru4H9ss3Q54YkrwPZ//an3ET9kV+eB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=r5gBwvYpCCv8bnN+Cmlx5uJd7Hk3wlhYlXZ2F+fswVShw5h0KYyhrEVKQ2D8OLuQ8
	 sWMvHlbaT48CjqLb2LGz9/dzcvQesWLWSmuU3ETQlXT+RZUOK3yeUrBJJmEdCXK1Cg
	 3tz0eYSScQbmNq7cAvm1d9Y3S1vvNsKSlZABnnJqRxc2zOB4T/1EekM1ZNXhdjDn28
	 g6ECAlbg9TdsAa3+nLs8zzKtOiy6mCS9r25GTUmH7byf6mBZU9CvAnYfMJX5D+jxab
	 96YcMBz/6ClvZCwiMZfPcs2LPJY0EDbbxI+4nvsuTGK+OAAD5c4H46SVANzbY0dZm6
	 hi9U4D+bDyKyg==
Date: Sun, 15 Feb 2026 18:42:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 5/5] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260215184234.7822f94a@jic23-huawei>
In-Reply-To: <20260213144742.16394-6-antoniu.miclaus@analog.com>
References: <20260213144742.16394-1-antoniu.miclaus@analog.com>
	<20260213144742.16394-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Feb 2026 16:47:37 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

One small thing inline.

> @@ -617,13 +731,34 @@ static int ad4080_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get and enable supplies\n");
>  
> -	st->regmap = devm_regmap_init_spi(spi, &ad4080_regmap_config);
> -	if (IS_ERR(st->regmap))
> -		return PTR_ERR(st->regmap);
> +	/* Setup primary SPI device (channel 0) */
> +	st->spi[0] = spi;
> +	st->regmap[0] = devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap[0]))
> +		return PTR_ERR(st->regmap[0]);
>  
> -	st->info = spi_get_device_match_data(spi);
> -	if (!st->info)
> -		return -ENODEV;
> +	/* Setup ancillary SPI devices for additional channels */
> +	if (st->info->num_channels > 1) {
> +		u32 reg[AD4080_MAX_CHANNELS];
> +
> +		ret = device_property_read_u32_array(dev, "reg", reg,
> +						     st->info->num_channels);
Can we just use

		spi_get_chipselect(spi, 1) ?

I think the generic firmware parser will have already parsed the DT and filled
that in by this point.

> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing reg entries for multi-channel device\n");
> +
> +		for (int i = 1; i < st->info->num_channels; i++) {
> +			st->spi[i] = devm_spi_new_ancillary_device(spi, reg[i]);
> +			if (IS_ERR(st->spi[i]))
> +				return dev_err_probe(dev, PTR_ERR(st->spi[i]),
> +						     "failed to register ancillary device\n");
> +
> +			st->regmap[i] = devm_regmap_init_spi(st->spi[i],
> +							     &ad4080_regmap_config);
> +			if (IS_ERR(st->regmap[i]))
> +				return PTR_ERR(st->regmap[i]);
> +		}
> +	}


