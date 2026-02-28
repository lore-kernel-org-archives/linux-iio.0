Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A7317155;
	Sat, 28 Feb 2026 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772305815; cv=none; b=AcnU0PtFj/sjD0WevzJ2WZCSwU/LStdAZcvCrT+IPTCXkMCcIjnGGh9mBK8suOJ/JXs5rmqPIvaS586Q4NBX/K18sKreKL1ZVt9ldD7Kz848igWWxuBHvEEOj28WHNvXhGPdk5jiQZ682n+4xpbU7dpoakDKRs0WaQ17jKbJW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772305815; c=relaxed/simple;
	bh=XsFYZlIw0JggzOI88pUkP+DQG5W+3B1ZOma8yBHXafk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nqmea1RKAgACUl1ZktSXLo/+zZQ5Nh0/Zz/fuF3wG95w1ujmpU6jUPt/zXaxsNm/ENuYuKimU3tgzj483C6F9KJx1dAPsC+qow/80YPx2q1aRsa+3TLbmXTB65fFmMNFEUgj8dmLW+dsMAHdcDAp3fLWoquGkpYhDrOMrn3Jv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNI/ZJ0I; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNI/ZJ0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6F9C116D0;
	Sat, 28 Feb 2026 19:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772305815;
	bh=XsFYZlIw0JggzOI88pUkP+DQG5W+3B1ZOma8yBHXafk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNI/ZJ0IIPr5sQvDU6p1e7t5UTM+krOlL1cA+LW5eH2evO1VrdKk30vZvpWVCb/vp
	 r2OvnX97QhTEnF9uywx5BBvmqTvE80RfNGN0YuvX7fIYQf7u/ijEj1YrfmxWB4iI65
	 j7YWWnIPMjS/k20lSbzpQSsFz0CS9N0zaFc6b0FdEnrOfzkL9fCBjrgPJENExUmt0y
	 X5rmku8iCN+xBooQ1QTSfXqCrUFC91/5g3Zgg7fBAs0vNQh/+HpSnUDAao8FoW1aEu
	 CODvRV+OEDE/K+42rSs9zqNMo49jYgz8r8aJmbzQyJHw8azo5He38VXJj42CUuM59a
	 bQb2yov8Dzlgw==
Date: Sat, 28 Feb 2026 19:10:04 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Mark Brown <broonie@kernel.org>, "Sebastian
 Reichel" <sebastian.reichel@collabora.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <20260228191004.35be7652@jic23-huawei>
In-Reply-To: <20260223162110.156746-6-antoniu.miclaus@analog.com>
References: <20260223162110.156746-1-antoniu.miclaus@analog.com>
	<20260223162110.156746-6-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 23 Feb 2026 18:21:04 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> integrated fully differential amplifiers (FDA).
>=20
> The AD4880 has two independent ADC channels, each with its own SPI
> configuration interface. The driver uses spi_new_ancillary_device() to
> create an additional SPI device for the second channel, allowing both
> channels to share the same SPI bus with different chip selects.
>=20
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu

One minor question / comment below. Not particularly important
but as you will be doing a v5 anyway, seems reasonable to aks the
question.

>  static int ad4080_properties_parse(struct ad4080_state *st)
>  {
> -	struct device *dev =3D regmap_get_device(st->regmap);
> +	struct device *dev =3D regmap_get_device(st->regmap[0]);
> =20
>  	st->lvds_cnv_en =3D device_property_read_bool(dev, "adi,lvds-cnv-enable=
");
> =20
> @@ -602,6 +711,7 @@ static int ad4080_probe(struct spi_device *spi)
>  	struct device *dev =3D &spi->dev;
>  	struct ad4080_state *st;
>  	struct clk *clk;
> +	unsigned int ch;
>  	int ret;
> =20
>  	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -610,6 +720,10 @@ static int ad4080_probe(struct spi_device *spi)
> =20
>  	st =3D iio_priv(indio_dev);
> =20
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -ENODEV;
> +
>  	ret =3D devm_regulator_bulk_get_enable(dev,
>  					     ARRAY_SIZE(ad4080_power_supplies),
>  					     ad4080_power_supplies);
> @@ -617,13 +731,27 @@ static int ad4080_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, ret,
>  				     "failed to get and enable supplies\n");
> =20
> -	st->regmap =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> -	if (IS_ERR(st->regmap))
> -		return PTR_ERR(st->regmap);
> -
> -	st->info =3D spi_get_device_match_data(spi);
> -	if (!st->info)
> -		return -ENODEV;

Moving this up doesn't seem to be necessary.  Am I missing a reason
st->info should be set earlier? If not I'd have left it down here simpl
to avoid the churn.

> +	/* Setup primary SPI device (channel 0) */
> +	st->spi[0] =3D spi;
> +	st->regmap[0] =3D devm_regmap_init_spi(spi, &ad4080_regmap_config);
> +	if (IS_ERR(st->regmap[0]))
> +		return PTR_ERR(st->regmap[0]);
> +
> +	/* Setup ancillary SPI devices for additional channels */
> +	if (st->info->num_channels > 1) {
> +		for (int i =3D 1; i < st->info->num_channels; i++) {
> +			st->spi[i] =3D devm_spi_new_ancillary_device(spi,
> +					spi_get_chipselect(spi, i));
> +			if (IS_ERR(st->spi[i]))
> +				return dev_err_probe(dev, PTR_ERR(st->spi[i]),
> +						     "failed to register ancillary device\n");
> +
> +			st->regmap[i] =3D devm_regmap_init_spi(st->spi[i],
> +							     &ad4080_regmap_config);
> +			if (IS_ERR(st->regmap[i]))
> +				return PTR_ERR(st->regmap[i]);
> +		}
> +	}

