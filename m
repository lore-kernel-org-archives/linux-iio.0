Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0513C918;
	Sat, 14 Feb 2026 18:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771095406; cv=none; b=MwBsHYb/tvNZZ+p+an6qUpXiAHOSpjFzBKWwn85lv1DbmkRK50MMwRwxA0WKPdpE49g2kKRg0BnetmIeQXNPtdjiTBSgC5nXxREqIaOROcoPTeuAEpszUTTZniKK6XLtXT2GNN6czwoQsIitGReSx0MYqCFPX9agRn30IuUHfkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771095406; c=relaxed/simple;
	bh=bOMrpaRNjBkWQjmA+5Kl6gah9Aa7BdY2gF3122mjPx4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ediDNw4t2p1GBfqwKvISP2PlsLHJk6I2X8vlPZqXRCvPdm+lJdT5jHur7sJXFnvDb6ZPYII3vuAUmoriCKFjyzAFQtim6557LD/1PxBiO77QiELuZajJDIXMwUULPMAD7iHKfzrekAWNfrtKA1wxl+FJ8cqH8NFOU6ZqUijO090=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1/pkLno; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1/pkLno"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B136FC16AAE;
	Sat, 14 Feb 2026 18:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771095406;
	bh=bOMrpaRNjBkWQjmA+5Kl6gah9Aa7BdY2gF3122mjPx4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=j1/pkLno1CeineWtm3xFnE8mDFd7h0K8gtpZSG9TuOECfmNsgSttz8YG2P9LIvydB
	 osbcjGTOPxWHSbeklzRyiPaCPk9+isSMwizf9VBN2LBknYY/NiQzKntLK5mpSG4x8p
	 /kt2ZWtlGMdD5wuc9M75rqQMN7ksHL+K7JJOjUiJfGJVuNh7BCPPCc37vM56SPWZsw
	 8J/Ay604MhR3rghct5Vt6Ylbs6rEqCMuQZvDpt1JWwtvO+6adQhPNyX7s6D4T3m9xj
	 ff1M1B3pMyoQk+UCINNtc16HUQsxfouOSPer/Yg+ePRVr0OOemq93gKz/lj8dWxsf4
	 1O6kGHBWj+qIQ==
Date: Sat, 14 Feb 2026 18:56:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 08/11] iio: amplifiers: ad8366: prepare for
 device-tree support
Message-ID: <20260214185636.6b7e2c7d@jic23-huawei>
In-Reply-To: <20260210-iio-ad8366-update-v4-8-15505f7b15b4@analog.com>
References: <20260210-iio-ad8366-update-v4-0-15505f7b15b4@analog.com>
	<20260210-iio-ad8366-update-v4-8-15505f7b15b4@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 19:42:08 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Drop switch case on the enum ID in favor of extended chip info table,
> containing:
> - gain_step, indicating with sign the start of the code range;
> - num_channels, to indicate the number IIO channels;
> - pack_code() function to describe how SPI buffer is populated;
> 
> Which allowed for a simplified read_raw() and write_raw() callbacks.
> The probe() function was adjusted accordingly.

Making the reset call on all devices is a material change (probably fine)
that should be called out here.

> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

> @@ -48,60 +53,58 @@ struct ad8366_state {
>  	unsigned char		data[2] __aligned(IIO_DMA_MINALIGN);
>  };
>  
> +static size_t ad8366_pack_code(struct ad8366_state *st)

See below. To me this is doing too much hidden stuff from point
of view of the caller. I think it needs some more explicit parameters.

> +{
> +	u8 ch_a = bitrev8(st->ch[0]) >> 2;
> +	u8 ch_b = bitrev8(st->ch[1]) >> 2;
> +
> +	put_unaligned_be16((ch_b << 6) | ch_a, &st->data[0]);
> +	return sizeof(__be16);
> +}

>  
> -static int ad8366_write(struct iio_dev *indio_dev,
> -			unsigned char ch_a, unsigned char ch_b)
> +static int ad8366_write_code(struct ad8366_state *st)
>  {
> -	struct ad8366_state *st = iio_priv(indio_dev);
> -	int ret;
> +	const struct ad8366_info *inf = st->info;
>  
> -	switch (st->type) {
> -	case ID_AD8366:
> -		ch_a = bitrev8(ch_a & 0x3F);
> -		ch_b = bitrev8(ch_b & 0x3F);
> +	if (inf->pack_code)
> +		spi_write(st->spi, st->data, inf->pack_code(st));

Check return value?

I'm also confused that this function now does two writes whereas it only
used to do one. 

This is a really confusing call as inf->pack_code() has side effects
that might not be obvious out here.  I'd have that callback explicitly
take the inputs and the output array so it's obvious what it can affect.
		count = inf->pack_code(st->chan, 2, st->chan_data);
or something along those lines.

>  
> -		st->data[0] = ch_b >> 4;
> -		st->data[1] = (ch_b << 4) | (ch_a >> 2);
> -		break;
> -	case ID_ADA4961:
> -		st->data[0] = ch_a & 0x1F;
> -		break;
> -	case ID_ADL5240:
> -		st->data[0] = (ch_a & 0x3F);
> -		break;
> -	case ID_HMC792:
> -	case ID_HMC1119:
> -		st->data[0] = ch_a;
> -		break;
> -	}
> -
> -	ret = spi_write(st->spi, st->data, indio_dev->num_channels);
> -	if (ret < 0)
> -		dev_err(&indio_dev->dev, "write failed (%d)", ret);
> -
> -	return ret;
> +	st->data[0] = st->ch[0];
> +	return spi_write(st->spi, st->data, 1);
>  }

>  static int ad8366_probe(struct spi_device *spi)
>  {
>  	struct device *dev = &spi->dev;
> @@ -261,35 +229,20 @@ static int ad8366_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret, "Failed to get regulator\n");
>  
>  	st->spi = spi;
> -	st->type = spi_get_device_id(spi)->driver_data;
> +	st->info = &ad8366_infos[spi_get_device_id(spi)->driver_data];
>  
> -	switch (st->type) {
> -	case ID_AD8366:
> -		indio_dev->channels = ad8366_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(ad8366_channels);
> -		break;
> -	case ID_ADA4961:
> -	case ID_ADL5240:
> -	case ID_HMC792:
> -	case ID_HMC1119:
> -		rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
> -		if (IS_ERR(rstc))
> -			return dev_err_probe(dev, PTR_ERR(rstc),
> -					     "Failed to get reset controller\n");
> +	rstc = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);

I was surprised not to see this change in the patch description.

I guess it's fine because if the chip doesn't have a reset it looks the same
as one that isn't wired?  Add a comment to say not all devices have resets or
add a flag to the info structure and go back to calling it only for devices
that at least have a reset pin.



> +	if (IS_ERR(rstc))
> +		return dev_err_probe(dev, PTR_ERR(rstc),
> +				     "Failed to get reset controller\n");
>  
> -		indio_dev->channels = ada4961_channels;
> -		indio_dev->num_channels = ARRAY_SIZE(ada4961_channels);
> -		break;
> -	default:
> -		return dev_err_probe(dev, -EINVAL, "Invalid device ID\n");
> -	}
> -
> -	st->info = &ad8366_infos[st->type];
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad8366_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad8366_channels;
> +	indio_dev->num_channels = st->info->num_channels;
>  
> -	ret = ad8366_write(indio_dev, 0, 0);
> +	ret = ad8366_write_code(st);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "failed to write initial gain\n");
>  
> 

