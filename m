Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301E82D321B;
	Tue, 30 Jun 2026 23:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782860558; cv=none; b=VOZFdyg5BL9k+qZQGqzyigyeNXQp8ABGfRW8/iBO820DLXXmM7W9YNt0j//1R7DtiyGwKhz5brj205THFJxMe+y79P/CtDlPrTdjyEcY9W4v6Fa4B1s4lfOKLEq09qP8xUAIWsK0G70uhUMiReEQTF/xLuLj6nSwdWfpb/oUfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782860558; c=relaxed/simple;
	bh=vewYM7+/0Mx8Us2bGa2kf6rEhXQToNX85RqF32+hadE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KZp39L+oqBMMBBXt0uubRRDJZWc96ZdbyMRM3wy3IkH2asfl6dJAfTCYMhdWcubPoquZ4p8FsQ7g/+Km1OSTbXLigeBgr1vuEfc9sNeLgUkqQUYxF9Mc0QETxmp7o/JoOV//gYJYobisX/QC97DXOSz7yQGeiCiSSSeNNqXsl5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVaCETV6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVaCETV6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13CA11F000E9;
	Tue, 30 Jun 2026 23:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782860556;
	bh=f9+i9K+DJqIZZjJdZPvridQs30wkr8i5BEOJQqta41U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TVaCETV6ffbqCw9xWkrt0hcm6vxAHkeK4Lt8IXDT4cPK1QugS4qOswT0Oaf37wYNQ
	 HQPRhmonf6/VezVIh+ZGVQXIWMBs+vDBkQiqPzB6xpaw8fSWlpwwKxFIHxjSo3g7Ph
	 ygNBT3XE4bCAh1XoOmnHKCyPIQda9Y7irEpOEEO28NT5VvLr7o718o4wBv8CthA2wQ
	 swJRm7IWuW4rUzI//RKMooHc3qXPB8RWHjzAtB/OyKdzmZzjKVFb5EPoauExaKiwo+
	 SQJY9tGsQSrGjtBnQuG0UnW6oK2op2TcsU0joRrDLKFCJGnwS5N8PUoTKkSNkhHEnx
	 0OocB6pW3l6aQ==
Date: Wed, 1 Jul 2026 00:02:31 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ti-tsc2046: Simplify device handling
Message-ID: <20260701000231.6b2ca57f@jic23-huawei>
In-Reply-To: <a3329201c27a1f2439f4b6c1c89cd1949dcab23c.1782833415.git.u.kleine-koenig@baylibre.com>
References: <cover.1782833415.git.u.kleine-koenig@baylibre.com>
	<a3329201c27a1f2439f4b6c1c89cd1949dcab23c.1782833415.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 30 Jun 2026 17:35:34 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver was introduced in 2021 and since then only supports a single
> chip variant. Simplify the driver by hard-coding the device properties
> instead of using the id_table's abstraction for a single chip type.
>=20
> Also drop the write-only struct member dcfg and the then unused struct
> definition.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Addresses feedback on v1, so all good,

Applied to the testing branch of iio.git.

I'll sit on patch 2 for a little while to see if it stirs up discussion!

Jonathan

> ---
>  drivers/iio/adc/ti-tsc2046.c | 25 ++++---------------------
>  1 file changed, 4 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index aba4b10a17ac..125f6d7e2d84 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -121,11 +121,6 @@ struct tsc2046_adc_group_layout {
>  	unsigned int skip;
>  };
> =20
> -struct tsc2046_adc_dcfg {
> -	const struct iio_chan_spec *channels;
> -	unsigned int num_channels;
> -};
> -
>  struct tsc2046_adc_ch_cfg {
>  	unsigned int settling_time_us;
>  	unsigned int oversampling_ratio;
> @@ -141,7 +136,6 @@ enum tsc2046_state {
> =20
>  struct tsc2046_adc_priv {
>  	struct spi_device *spi;
> -	const struct tsc2046_adc_dcfg *dcfg;
>  	bool internal_vref;
> =20
>  	struct iio_trigger *trig;
> @@ -214,11 +208,6 @@ const struct iio_chan_spec name ## _channels[] =3D {=
 \
> =20
>  static DECLARE_TI_TSC2046_8_CHANNELS(tsc2046_adc, 12);
> =20
> -static const struct tsc2046_adc_dcfg tsc2046_adc_dcfg_tsc2046e =3D {
> -	.channels =3D tsc2046_adc_channels,
> -	.num_channels =3D ARRAY_SIZE(tsc2046_adc_channels),
> -};
> -
>  /*
>   * Convert time to a number of samples which can be transferred within t=
his
>   * time.
> @@ -739,7 +728,6 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_a=
dc_priv *priv)
> =20
>  static int tsc2046_adc_probe(struct spi_device *spi)
>  {
> -	const struct tsc2046_adc_dcfg *dcfg;
>  	struct device *dev =3D &spi->dev;
>  	struct tsc2046_adc_priv *priv;
>  	struct iio_dev *indio_dev;
> @@ -752,10 +740,6 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  		return -EINVAL;
>  	}
> =20
> -	dcfg =3D spi_get_device_match_data(spi);
> -	if (!dcfg)
> -		return -EINVAL;
> -
>  	spi->mode &=3D ~SPI_MODE_X_MASK;
>  	spi->mode |=3D SPI_MODE_0;
>  	ret =3D spi_setup(spi);
> @@ -767,14 +751,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  		return -ENOMEM;
> =20
>  	priv =3D iio_priv(indio_dev);
> -	priv->dcfg =3D dcfg;
> =20
>  	priv->spi =3D spi;
> =20
>  	indio_dev->name =3D TI_TSC2046_NAME;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> -	indio_dev->channels =3D dcfg->channels;
> -	indio_dev->num_channels =3D dcfg->num_channels;
> +	indio_dev->channels =3D tsc2046_adc_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(tsc2046_adc_channels);
>  	indio_dev->info =3D &tsc2046_adc_info;
> =20
>  	ret =3D devm_regulator_get_enable_read_voltage(dev, "vref");
> @@ -829,13 +812,13 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>  }
> =20
>  static const struct of_device_id ads7950_of_table[] =3D {
> -	{ .compatible =3D "ti,tsc2046e-adc", .data =3D &tsc2046_adc_dcfg_tsc204=
6e },
> +	{ .compatible =3D "ti,tsc2046e-adc" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, ads7950_of_table);
> =20
>  static const struct spi_device_id tsc2046_adc_spi_ids[] =3D {
> -	{ "tsc2046e-adc", (unsigned long)&tsc2046_adc_dcfg_tsc2046e },
> +	{ .name =3D "tsc2046e-adc" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, tsc2046_adc_spi_ids);

