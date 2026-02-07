Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EFF189BB0;
	Sat,  7 Feb 2026 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770476690; cv=none; b=Oeikb8p9WcxrC+M9+R9zqP61ixo61M5sjqar+TKW8Fodi6V2XUlbKt1f9l9dPAeeJSqa5FteBmcsJ1iUGjaIEgG6Mq+ovzbCdYgsvZy2Wpx/KXmcEnWTkuC8XbZp+7LJC1VBN/vD03g0kwD7RCF5YEcirhVCiCfAT9jKpdwuE5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770476690; c=relaxed/simple;
	bh=jlnmIh3OeYeJSmwoNRcq3xnz2glp/SDfnQV04uScHrI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uucjq5imR9Weoesd9TixxEmaWQSkUKTqD47tT0sZL2OCBVp2gQL3QuWLfFeowLPL6rKzsSoveP6rxQC/e46nWvQz6/Ispp32UlXyJc2PqePjA6rl0GZ/lzw81j80/Ywmwie6Fc53Evz0C5126Db/SahwfTMZ/6krgTGr71jHSOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FhxAMpaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FhxAMpaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11C38C116D0;
	Sat,  7 Feb 2026 15:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770476690;
	bh=jlnmIh3OeYeJSmwoNRcq3xnz2glp/SDfnQV04uScHrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FhxAMpaCS99G+B/0R4O3BKYN/tecyiQjwX3gWRqRvLQKBbsJhVSu/1DS6u0N0udwn
	 6TS/EVWh6vAIwLtIbLs2rj7/Cf04qfkIi+ECRK8QvHoz/avtBObBYdot3ls7ZAv/u0
	 w3qnp2Qb02yTeSJPbtaFBUdU/jSMjqzLmlP9jJGp4VeuxW/Y3qhek/mHG1cjusc4pE
	 dVEmKEfm4oLS2mu6dvKtW3LICZX+RoUDSOU3CMeOefVi7Xqnf93O6XHc90Pc9hjLoO
	 Z9YgRntqnvMTvYUdH7l0MmOOm9xlVqsTD79rX579F/d/tRdeUTW1W8w1bX/ramIeF/
	 e56xeUexI43NQ==
Date: Sat, 7 Feb 2026 15:04:40 +0000
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
Subject: Re: [PATCH v2 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260207150440.46d83d48@jic23-huawei>
In-Reply-To: <8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
References: <cover.1770393792.git.antoniu.miclaus@analog.com>
	<8685e3e53667e82c7cdfd66ee6fb1ec3d3c009cd.1770393792.git.antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Feb 2026 18:07:16 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
> 
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

Just one minor comment from me.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Use second reg entry instead of custom adi,aux-spi-cs property for
>     secondary channel chip select
>   - Use devm_iio_backend_get_by_index() instead of named backends for
>     multi-channel backend lookup
>   - Separate iio_info structures for single-channel (ad4080) and
>     multi-channel (ad4880) devices
>   - Keep filter_type as shared attribute for single-channel devices,
>     use per-channel only for AD4880
>   - Add separate AD4880_CHANNEL_DEFINE macro with per-channel attributes
> 
>  drivers/iio/adc/ad4080.c | 256 +++++++++++++++++++++++++++++++--------
>  1 file changed, 205 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
> index 7cf3b6ed7940..2b26f8a4d548 100644
> --- a/drivers/iio/adc/ad4080.c
> +++ b/drivers/iio/adc/ad4080.c

>
> @@ -617,13 +736,37 @@ static int ad4080_probe(struct spi_device *spi)
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

I wonder if this would be clearer as a loop?  When there is a 2 channel device
around, a 4 channels one often shows up later.

	for (int i = 1; i < st->info->num_channels; i++) {

> +		u32 reg[2];
> +
> +		ret = device_property_read_u32_array(dev, "reg", reg,
> +						     ARRAY_SIZE(reg));
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing second reg entry for multi-channel device\n");
> +
> +		st->spi[1] = spi_new_ancillary_device(spi, reg[1]);
> +		if (IS_ERR(st->spi[1]))
> +			return dev_err_probe(dev, PTR_ERR(st->spi[1]),
> +					     "failed to register ancillary device\n");
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

