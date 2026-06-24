Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013313D9696;
	Wed, 24 Jun 2026 17:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322727; cv=none; b=fmkvx8kK8ZTHoLkU0b7lnATGq+4e2QDOl+noB4hH/CWNrCDZhG91bbX2jpItkq7CtJq6A8FWek5PNWaCoTfrCoXrL6Ps64TVQTquIv+0Ia/Ov+4Ei0CyyCS/ty0QBAA/cBi5EbRyARkc7FFBwA1U/T29Zvn6dJrXtgzVrXCs+vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322727; c=relaxed/simple;
	bh=IASPH+J9zyLtuspX4DI7ZNZML+anJ+yekJ9VOfYviGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ri1doxasze8z2Ubn6MI/aB3wDlPXgfHsAMw6L31O04kvg9OSbR1Tgk5pzypKK0l9oOT5aT3TGR6/xOi9iNCDqtX6R3mpOhpe7cHCpj+ieZ0Iy8MQwVo9h0poYAve60MeYFt/H0d/2hEXwwxk3Z+4OWhLlxxMhlzgNc5mjBU13uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gNdTU5yS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gNdTU5yS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003F51F000E9;
	Wed, 24 Jun 2026 17:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782322725;
	bh=qxay9+T8ijJYfuxx34Mmihh8hZfPCL7wuWk/kbSUaBU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gNdTU5ySRJaxJ9kGUGtjTJMlLN/6VTK02rqWFwHJAiNwfq+WONZICqjyjdPY/4PJq
	 0esa/U+pjKj9o1zra5kcCroZjOeU6kdfBhk5art+Suvo0Al+hfSlxmg9v/2dNkrSFf
	 rcHu9QBg5CJwhXcXmTcTD284gqodhSF2hctudGnvWPDzi7hRO/Fu4569Ztui072OOx
	 /d9suKatibf/9Gu3mtXzTRlmTjQZR2rZPjzQd+lhE327hC/utYIMrQvdd1TbvP/+KA
	 8weQyI+2+YyFwi/H/p+HycF6oHieVuOTC9UqoW5BzEY9Y0Nrkb0gWg1x2dYspIDQun
	 /b574WjvLUpKQ==
Date: Wed, 24 Jun 2026 18:38:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 05/13] iio: dac: max5522: Simplify device abstraction
Message-ID: <20260624183837.78aae906@jic23-huawei>
In-Reply-To: <54b79462e753b99c132a835f6b618b3cef76fa9c.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<54b79462e753b99c132a835f6b618b3cef76fa9c.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:33 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver only supports a single chip variant since it's birth in 2022.
> Both the spi id_table and the of id_table are essentially unused (only
> assigned to a write-only member in private data).
>=20
> Hardcode the device name and then drop various unused stuff from the
> driver. While touching the spi id_table assign .name using a named
> initializer.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>
Hmm. This one was a bit silly wasn't it? :)

Applied.

> ---
>  drivers/iio/dac/max5522.c | 31 +++----------------------------
>  1 file changed, 3 insertions(+), 28 deletions(-)
>=20
> diff --git a/drivers/iio/dac/max5522.c b/drivers/iio/dac/max5522.c
> index b52a9cc1da79..cfbe3a6e0449 100644
> --- a/drivers/iio/dac/max5522.c
> +++ b/drivers/iio/dac/max5522.c
> @@ -25,15 +25,8 @@
> =20
>  #define MAX5522_REG_DATA(x)	((x) + MAX5522_CTRL_LOAD_IN_A)
> =20
> -struct max5522_chip_info {
> -	const char *name;
> -	const struct iio_chan_spec *channels;
> -	unsigned int num_channels;
> -};
> -
>  struct max5522_state {
>  	struct regmap *regmap;
> -	const struct max5522_chip_info *chip_info;
>  	unsigned short dac_cache[2];
>  	int vref_mV;
>  };
> @@ -58,18 +51,6 @@ static const struct iio_chan_spec max5522_channels[] =
=3D {
>  	MAX5522_CHANNEL(1),
>  };
> =20
> -enum max5522_type {
> -	ID_MAX5522,
> -};
> -
> -static const struct max5522_chip_info max5522_chip_info_tbl[] =3D {
> -	[ID_MAX5522] =3D {
> -		.name =3D "max5522",
> -		.channels =3D max5522_channels,
> -		.num_channels =3D 2,
> -	},
> -};
> -
>  static inline int max5522_info_to_reg(struct iio_chan_spec const *chan)
>  {
>  	return MAX5522_REG_DATA(chan->channel);
> @@ -140,9 +121,6 @@ static int max5522_spi_probe(struct spi_device *spi)
>  	}
> =20
>  	state =3D iio_priv(indio_dev);
> -	state->chip_info =3D spi_get_device_match_data(spi);
> -	if (!state->chip_info)
> -		return -EINVAL;
> =20
>  	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vrefin");
>  	if (ret < 0)
> @@ -159,22 +137,19 @@ static int max5522_spi_probe(struct spi_device *spi)
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
>  	indio_dev->channels =3D max5522_channels;
>  	indio_dev->num_channels =3D ARRAY_SIZE(max5522_channels);
> -	indio_dev->name =3D max5522_chip_info_tbl[ID_MAX5522].name;
> +	indio_dev->name =3D "max5522";
> =20
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
> =20
>  static const struct spi_device_id max5522_ids[] =3D {
> -	{ "max5522", (kernel_ulong_t)&max5522_chip_info_tbl[ID_MAX5522] },
> +	{ .name =3D "max5522" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, max5522_ids);
> =20
>  static const struct of_device_id max5522_of_match[] =3D {
> -	{
> -		.compatible =3D "maxim,max5522",
> -		.data =3D &max5522_chip_info_tbl[ID_MAX5522],
> -	},
> +	{ .compatible =3D "maxim,max5522" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, max5522_of_match);

