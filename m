Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA539335564;
	Sat, 17 Oct 2026 19:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792263841; cv=none; b=Byf+A09Lz8BXHw2+QzzZHhuuk7r4ABf2rFn5Yz7gZrfM4aES5n7Dr3jLoxR2cgrUij9zGEPw/D0TxbctFEeWqoCfPL4HmCT+CgxDVZtR9a9J+GgFXn1X426DTAca7VCkDwrDNUbEZo+4/1oXrTo+Uy1gHCi9ctAwSipme2G5jRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792263841; c=relaxed/simple;
	bh=2AozhjYn608MQwxmaMENSYYMnUQ2NfjVfCFKBcebf78=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyvtaTTKNnm74ouarg9kEpQgEpvuY3jpNlJnfukBNY4ilxzMKQCsW13GrfqEHHH/0RP1BksIATP1ZIplY2HOzRR4ius65jU/Tz1QMAfK/ky0CTUvwY/qX1rxLhlZWF0Jz99JSKq1EHPQFRGb2NjvHJsjULjRvUQ6z9A1P+pnZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbkUNpTj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbkUNpTj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F631F000C4;
	Sat, 17 Oct 2026 19:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792263839;
	bh=OH3U8u6orc4B4I3tUISqTAJgxXs5Rq+kG5e6idsxYeE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QbkUNpTj4o7d1NnuNvJ9Mb96jryQCDDSC3CRpkOE9FwbM8MoYe/CMquTEiio3oQdT
	 BSLjhASFK9G3d46djIdVLmn/4hLSDDual+Zgw6PYYwiyffUrtwb57FtAq9z4/FwD8W
	 Dy/bLE/M+blGblYIn3Cwo71Qcff5Pq+rPpLH0OBFwWjwaYdJ2shqb5IFMQMyGw8B78
	 Nj73LFtQADn0NbXbKKZ+tPMjS4Y5FllFKVaerR87GJXUoTGtmdSUXOzV8jtPvIJf1G
	 VvO4uIvfp+Tls0mdtXycBRyIKeBgZ6925hMqXhhQHiBrGfP5UrZ52CbnpX0kltxqxu
	 hH35sjEqF6Fiw==
Date: Sat, 17 Oct 2026 20:03:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>, <nuno.sa@analog.com>,
 <dlechner@baylibre.com>, <andy@kernel.org>, <Michael.Hennerich@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <corbet@lwn.net>, <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v5 12/15] iio: adc: ad4134: Support SPI 4-wire mode
Message-ID: <20261017200353.7b3dfbba@jic23-hlaptop>
In-Reply-To: <fabe47973d8de0bc2f5177a99ef032a26b42d926.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
	<fabe47973d8de0bc2f5177a99ef032a26b42d926.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 22:59:56 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> AD4134 devices can be wired in a few different ways. So far, only minimum
> I/O mode was supported. While minimum I/O mode allows interfacing with
> AD4134 with a reduced number of wires, that wiring configuration is not
> suitable for high-throughput data acquisition.
> 
> Extend AD4134 support to enable interfacing in SPI 4-wire configuration.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

I think a bit of ACQUIRE() magic sprinkled in here to handle
the claim / release pairs would make this more readable.

Otherwise, just a few little style suggestions.

> diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
> index eaf5bb55f25b..6b05e40f7aeb 100644
> --- a/drivers/iio/adc/ad4134.c
> +++ b/drivers/iio/adc/ad4134.c
...

> +
> +/*
> + * Must be balanced with successful calls to ad4134_claim_reg_access().

If you follow the ACQUIRE() suggestion below, probably don't need
this comment.

> + */
> +static int ad4134_release_reg_access(struct ad4134_state *st)
> +{
> +	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && st->mux_st[AD4134_SDO_INPUT])
> +		return mux_state_deselect(st->mux_st[AD4134_SDO_INPUT]);
> +
> +	return 0;
> +}


>  static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
> @@ -301,14 +416,18 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
>  		.len = st->crc_en ? AD4134_SPI_MAX_XFER_LEN : 2,
>  	};
>  	unsigned int inst;
> -	int ret;
> +	int access_ret, ret;
> +
> +	ret = ad4134_claim_reg_access(st);
> +	if (ret)
> +		return ret;
>  
>  	inst = AD4134_REG_READ_MASK | reg;
>  	ad4134_prepare_spi_tx_buf(inst, 0, st->tx_buf);
>  
>  	ret = spi_sync_transfer(st->spi, &xfer, 1);
>  	if (ret)
> -		return ret;
> +		goto out_read_release;
>  
>  	*val = st->rx_buf[1];
>  
> @@ -316,7 +435,12 @@ static int ad4134_register_read(struct ad4134_state *st, unsigned int reg,
>  	if (st->crc_en && st->rx_buf[2] != st->tx_buf[2])
>  		dev_dbg(&st->spi->dev, "reg read CRC check failed\n");
>  
> -	return 0;
> +out_read_release:
> +	access_ret = ad4134_release_reg_access(st);
> +	if (access_ret)
> +		dev_err(&st->spi->dev, "error on access release: %d\n", access_ret);

If you are going to not return access_ret anyway (which is common simplifying
approach for cases like this where we are stuck anyway), then how about wrapping
all this in an ACQUIRE() and letting the cleanup.h magic call the release for you?

> +
> +	return ret;
>  }

>  static int ad4134_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long info)
> @@ -440,11 +579,6 @@ static int ad4134_min_io_mode_setup(struct ad4134_state *st)
>  	int ret;
>  
>  	st->crc_en = true; /* In minimum I/O mode CRC cannot be disabled */
> -	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
> -	if (IS_ERR(st->odr_gpio))
> -		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
> -				     "failed to get ODR GPIO\n");
> -
>  	ret = regmap_update_bits(st->regmap, AD4134_DIG_IF_CFG_REG,
>  				 AD4134_DIF_IF_CFG_FORMAT_MASK,
>  				 FIELD_PREP(AD4134_DIF_IF_CFG_FORMAT_MASK,
> @@ -591,10 +725,61 @@ static int ad4134_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->regmap),
>  				     "failed to initialize regmap");
>  
> -	ret = ad4134_min_io_mode_setup(st);
> -	if (ret)
> -		return dev_err_probe(dev, ret,
> -				     "failed to setup minimum I/O mode\n");
> +	if (device_property_present(dev, "adi,spi-mode")) {
> +		ret = device_property_match_property_string(dev, "adi,spi-mode",
> +							    ad4134_spi_modes,
> +							    ARRAY_SIZE(ad4134_spi_modes));
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "getting adi,spi-mode property failed\n");
> +
> +		st->spi_mode = ret;
> +	} else {
> +		/* Default to no-cs mode if adi,spi-mode is not specified */
> +		st->spi_mode = AD4134_SPI_MODE_NO_CS;
> +	}
> +
> +	if (st->spi_mode == AD4134_SPI_MODE_NO_CS) {
> +		/*
> +		 * The support hardware for AD4134 may have a multiplexer for
> +		 * selecting between AD4134 SDO and AD4134 DOUT0. If that mux
> +		 * is set but the user still wants to run AD4134 in minimum I/O
> +		 * mode, then DOUT0 is not used and the multiplexer OUTSIDE OF
> +		 * AD4134 SILICON must be set to select AD4134 SDO. See AD4134
> +		 * IIO documentation for details.
> +		 */
> +		st->mux_st[AD4134_SDO_INPUT] =
> +			devm_mux_state_get_optional_selected(dev, "reg_access");
> +		if (IS_ERR(st->mux_st[AD4134_SDO_INPUT]))
> +			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_SDO_INPUT]),
> +					     "failed to get reg_access mux-state\n");

Maybe use a local variable for the return of devm_mux_state_get_optional_selected
and only sets st->mux_st[] after we know it's not an error. Should make this
a little more readable.

Similar applies in other places.

> +
> +		ret = ad4134_min_io_mode_setup(st);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to setup minimum I/O mode\n");

When it's 80-90 chars, feel free to put dev_err_probe() on one line.

> +	} else {
> +		/*
> +		 * This controls a multiplexer OUTSIDE OF AD4134 SILICON.
> +		 * See AD4134 IIO documentation for details.
> +		 */
> +		st->mux_st[AD4134_SDO_INPUT] = devm_mux_state_get(dev, "reg_access");
> +		if (IS_ERR(st->mux_st[AD4134_SDO_INPUT]))
> +			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_SDO_INPUT]),
> +					     "failed to get reg_access mux-state\n");
> +
> +		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
> +		if (IS_ERR(st->mux_st[AD4134_DOUT0_INPUT]))
> +			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_DOUT0_INPUT]),
> +					     "failed to get data_read mux-state\n");
> +
> +		indio_dev->setup_ops = &ad4134_buffer_setup_ops;
> +	}
> +
> +	st->odr_gpio = devm_gpiod_get(dev, "odr", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->odr_gpio))
> +		return dev_err_probe(dev, PTR_ERR(st->odr_gpio),
> +				     "failed to get ODR GPIO\n");
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,

