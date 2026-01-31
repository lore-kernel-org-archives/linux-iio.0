Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB66035BDD5;
	Sat, 31 Jan 2026 18:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769883590; cv=none; b=UAgeFEsan79BpDgqIOGSeh9JwJ9/HQz9brUW5ohckFW6tXyKkP6kW+FNC2RcKSR92GxFFd0+7Uy25X7mwteGcbbJWy0bKX7OfkovJkUrfJOxM3LJ8eUUkAD+pKGWOECDK7OGHdgYtTfrj8HtQgcRhLRzxXKBeHn0hVVeTR80RKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769883590; c=relaxed/simple;
	bh=SwJLaRHzDzcedbndVZ/AQiNXflFf1QMUGYlwtBRz5cc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HjFEZruWcue6axrLXLD0PU9cr6x1ADbcPi0lDstl6p3otbRtXwNBJf+mMC+a9zETR6wK5HOG8bpNWOieKdmk4/2LFTmgUHRHfN8ErrFsmMPCPP3DDH6Zzae2LDQ0bE2Z0enwU6vXyoT3VyJtfyut6IQPF2WzbY8uszofecMjOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiyYgG9Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiyYgG9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D23C4CEF1;
	Sat, 31 Jan 2026 18:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769883589;
	bh=SwJLaRHzDzcedbndVZ/AQiNXflFf1QMUGYlwtBRz5cc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aiyYgG9ZC1GjtBqZcgF2CncP7cUVbMfITQo2pT/cSpY7dP952P2AUxSLor7Ieq2aT
	 SmQKBj196W+fdHIr45URWVPn/TIE4zL+bv6fdQtljxi//oeaUdWbydyNB/31ct4Kj8
	 X5OUV/F4JB6QjlP2KS05oupD8n3BCp/Dmq3ogIfCs/oKPrrSdtSR+WmDk8lFYjIyw6
	 AfHIrRBTXMgRiO2tp8Oj9x7PJgRVWa+87BqYLlvP0M9gtj2FjtsdTc1/F36Zg1lbv2
	 pTsb5yEt8IxGsuxAn0fURI9kLRsG0+PoiMAAJdigPjgY4mVmS2AEWK12GcxbYdEM28
	 rJRpJkc9c230w==
Date: Sat, 31 Jan 2026 18:19:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260131181939.29b35a98@jic23-huawei>
In-Reply-To: <20260129152731.154368-3-antoniu.miclaus@analog.com>
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
	<20260129152731.154368-3-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 29 Jan 2026 17:27:30 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
> 
> Key changes:
> - Add AD4880 chip info with 2 channels
> - Extend state structure to support arrays of regmaps and backends
> - Refactor setup into per-channel function
> - Add adi,aux-spi-cs property for secondary channel chip select
> - Add channel index parameter to channel macro for scan_index support
> - Make all IIO attributes per-channel (filter_type, oversampling_ratio,
>   sampling_frequency) for independent channel configuration
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

A few additional comments from me to add to those of the other reviewers.

Jonathan

> ---
>  drivers/iio/adc/ad4080.c | 236 ++++++++++++++++++++++++++++-----------
>  1 file changed, 172 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cf3b6ed7940..e588ff23a7a5 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c

>  static int ad4080_probe(struct spi_device *spi)
>  {
> +	static const char * const backend_names[] = { "0", "1" };
>  	struct iio_dev *indio_dev;
>  	struct device *dev = &spi->dev;
>  	struct ad4080_state *st;
>  	struct clk *clk;
> +	unsigned int ch;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -610,6 +683,10 @@ static int ad4080_probe(struct spi_device *spi)
>  
>  	st = iio_priv(indio_dev);
>  
> +	st->info = spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
>  	ret = devm_regulator_bulk_get_enable(dev,
>  					     ARRAY_SIZE(ad4080_power_supplies),
>  					     ad4080_power_supplies);
> @@ -617,13 +694,35 @@ static int ad4080_probe(struct spi_device *spi)
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
> +	/* Setup ancillary SPI device for additional channel (AD4880) */
> +	if (st->info->num_channels > 1) {

This hard codes assumption that it is 2. So perhaps better to check for
that explicitly rather than simply > 1.
Maybe turn this into an appropriate loop so you don't need to care that
it's 2 or bigger.

> +		u32 aux_cs;
> +
> +		ret = device_property_read_u32(dev, "adi,aux-spi-cs", &aux_cs);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing adi,aux-spi-cs for multi-channel device\n");
> +
> +		st->spi[1] = spi_new_ancillary_device(spi, aux_cs);
> +		if (IS_ERR(st->spi[1]))
> +			return PTR_ERR(st->spi[1]);
> +
> +		ret = devm_add_action_or_reset(dev, ad4080_unregister_ancillary,
> +					       st->spi[1]);
> +		if (ret)
> +			return ret;
> +
> +		st->regmap[1] = devm_regmap_init_spi(st->spi[1],
> +						     &ad4080_regmap_config);
> +		if (IS_ERR(st->regmap[1]))
> +			return PTR_ERR(st->regmap[1]);
> +	}
>  
>  	ret = devm_mutex_init(dev, &st->lock);
>  	if (ret)
> @@ -644,15 +743,22 @@ static int ad4080_probe(struct spi_device *spi)
>  
>  	st->clk_rate = clk_get_rate(clk);
>  
> -	st->back = devm_iio_backend_get(dev, NULL);
> -	if (IS_ERR(st->back))
> -		return PTR_ERR(st->back);
> +	/* Get backends for all channels */
> +	for (ch = 0; ch < st->info->num_channels; ch++) {
> +		if (st->info->num_channels > 1)
> +			st->back[ch] = devm_iio_backend_get(dev, backend_names[ch]);
> +		else
> +			st->back[ch] = devm_iio_backend_get(dev, NULL);

To me, it makes sense to always use names for multi channel devices and only
fall back to this if there is only one supported channel.
Something like
		char *name = NULL;

		if (st->info->num_channels != 1)
			name = backend_names[ch];

		st->back[ch] = devm_iio_backend_get(dev, name);


>  
> -	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> -	if (ret)
> -		return ret;
> +		if (IS_ERR(st->back[ch]))
> +			return PTR_ERR(st->back[ch]);
> +
> +		ret = devm_iio_backend_enable(dev, st->back[ch]);

This changes the ordering so we now enable it before requesting the buffer.
That may well be fine, but I'd kind of prefer that to be made clear. Perhaps
with a precursor patch reorganizing that order where you can talk about why
it is fine to do so.

> +		if (ret)
> +			return ret;
> +	}
>  
> -	ret = devm_iio_backend_enable(dev, st->back);
> +	ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);

Add a comment on why requesting only the first buffer is enough.

>  	if (ret)
>  		return ret;
>  

