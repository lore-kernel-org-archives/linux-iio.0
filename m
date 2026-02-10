Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C5B3271EB
	for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 12:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725470; cv=none; b=gAi4aDSP7VIPCTmY+DZdSVhjIx+OsPheCm/UiJ1n+qVLoFqGJ7kjrSEhtixN636Zcdjbw3WKvzMkMiVTHI1AKrW4rUpfPGeWhyJhiJloFF+9QSjMNPKnODipsRSVf2Kxk/NG6m7u1WknLOziQH4UvIoz/oijgRORnO6j+6fyI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725470; c=relaxed/simple;
	bh=aIqgcOyS2tGSkldTfhyJtvf2YJyfVC7eBzUOKbqnd8E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iWIU4B2RuqD4EvJwOV9AnUKHRxwEFV5I2LaIqJEw7yizaDqv7Gqp8gAtlTTmpn0cKp2Z+T2Eorg4J7OLjAcdBzeb6vsNQHIDbgvvZ6Dr4yyil5ZEhyxD2cYVIJ5LRqMIL54V/iuUVy/QoLrsFEWeVFqIIRZiXuUCuncaszOKEpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjPl3HJn; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjPl3HJn"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so9084055e9.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Feb 2026 04:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770725467; x=1771330267; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=L/aBGhVtAGcnR8udEv0fvW2/wHXLRgg8jTfhj8B88qc=;
        b=QjPl3HJnbqeRlKqr485cm2XKVEXxJWPeVqbk6D3aQYAIQncunUpxxArPOz4xl+WZnW
         DlAZOpMoAZceaLNAkB0olPI5vEydEYQXzgLy06LpDa7xYaOLwITALpXXwVA2Cir4ol0i
         /HLCSf1Q+A9ozMxAI1+/sau31ioSNJ291NophWKWuemkdFqAg7E1AGadjJZwXPRR4R4F
         RnH7rZPIKBihcJmNznoQkUPk3D9hqWAXoYhaGwxBUm8U7brv4L64ldcZvhm4rBYdtEUM
         WCFm7YPzLltNCH5JB2KJ2GAe4ZdUoPXvV0z/9llPiuRb4B2OW2m5RpW9BckI1KsMO42R
         OQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770725467; x=1771330267;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/aBGhVtAGcnR8udEv0fvW2/wHXLRgg8jTfhj8B88qc=;
        b=LXj3C8BxbEcJa5QZzk2oeXJz/dgw5df9ZlPwMZMkKMNfANVeMi2zLK7/w8O1/GcUS8
         Dc5lq8PQ5GMZWC8pBEfcPmMLCOEmGm+nltIRWwE/LuJb6mX/ZBEBLwXPLyhnH//xM4R5
         T3u2Mw1edBNT9L9lULqbHfFM1Gd8oAyrdr6oYntOsP79z22HkCI1wExEJiEMMntkSiu9
         kWflKdzVRGulxt1tpzbTgu2Pv6RFYsItRqXAZrW0ku7Q0LgBpWd7ovKpFDhDEUGPM0Dr
         XFvZ+EIT33VVpTZaMIcP3Sp8ZMWcnMnaNCw+NrSlNQrD5h79Nd4PXkE/xTza6O27You7
         xkOw==
X-Gm-Message-State: AOJu0YyKv8BuwTjbA0mBzEIIkIzChWfBWSumiAa7/5Dja52x9BbITSAS
	w+s3wjY27Wejrnkd191NnBGz5f2KrNs2/RNb0EZtTPpDm8G7+wFVSsGz
X-Gm-Gg: AZuq6aLqYFkR6cBZ3/8jwCHyVIRF48hUtoRG3ko4YErhEzJq/6yCR75K73LZU8nIh63
	K2vcfX29k6drSCyIzHZyB0YWLErH0vPMN5QVJ5spDS0pgB8vliUSPff6QIbfG0aInOAsuBBSr86
	/jFg1W/FRUmxB3YO6jH7Ja2upNw7hNil63apITBzM/KD57qQOaYVKj8Gld1r+p76GoVIStuop+k
	ETDPB9HGNlevPVsZGYhhkZYQLjxw6Hq/mYOvivNruYx/QPY34FyEQiwx23CL+UCuw9Smee9N9dA
	uQGnua9gJNjuZw4eLN2fCtojp47uPJFl3vU6zrcLLEDWTEQUUOg6b9JXdUQHe7peuOPrR9hl9pX
	XPY6Bq6pCH1kKwK1fa1vD6uchPu/U/GAnLQ1mWlA1d4DyDhZpDMPb4V+lxv0L/ahrhRlUuj6IuR
	Ns3DLfAiZu0/JIqGfm5EBUj2ZDbupgM40=
X-Received: by 2002:a05:600c:3e87:b0:477:76c2:49c9 with SMTP id 5b1f17b1804b1-4832020025bmr203712055e9.2.1770725466921;
        Tue, 10 Feb 2026 04:11:06 -0800 (PST)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320961505sm229682495e9.4.2026.02.10.04.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 04:11:06 -0800 (PST)
Message-ID: <642f9ed3c426ecfff250b9d00dd822c595e0fdfd.camel@gmail.com>
Subject: Re: [PATCH v7 5/6] iio: adc: ad9467: simplify device pointer in
 probe
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
	 <andriy.shevchenko@intel.com>
Date: Tue, 10 Feb 2026 12:11:49 +0000
In-Reply-To: <20260210-b4-ad9467-optional-backend-v7-5-7a590ffe02df@vaisala.com>
References: 
	<20260210-b4-ad9467-optional-backend-v7-0-7a590ffe02df@vaisala.com>
	 <20260210-b4-ad9467-optional-backend-v7-5-7a590ffe02df@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-10 at 10:53 +0000, Tomas Melin wrote:
> Create alias for the device pointer to simplify referencing
> and keeping syntax and column width shorter.
>=20
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> ---

Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad9467.c | 19 ++++++++++---------
> =C2=A01 file changed, 10 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 59c3fa3bcc9b..ae9139290c22 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -1283,12 +1283,13 @@ static void ad9467_debugfs_init(struct iio_dev *i=
ndio_dev)
> =C2=A0
> =C2=A0static int ad9467_probe(struct spi_device *spi)
> =C2=A0{
> +	struct device *dev =3D &spi->dev;
> =C2=A0	struct iio_dev *indio_dev;
> =C2=A0	struct ad9467_state *st;
> =C2=A0	unsigned int id;
> =C2=A0	int ret;
> =C2=A0
> -	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> =C2=A0	if (!indio_dev)
> =C2=A0		return -ENOMEM;
> =C2=A0
> @@ -1303,16 +1304,16 @@ static int ad9467_probe(struct spi_device *spi)
> =C2=A0	if (AD9467_CAN_INVERT(st))
> =C2=A0		st->calib_map_size *=3D 2;
> =C2=A0
> -	st->clk =3D devm_clk_get_enabled(&spi->dev, "adc-clk");
> +	st->clk =3D devm_clk_get_enabled(dev, "adc-clk");
> =C2=A0	if (IS_ERR(st->clk))
> =C2=A0		return PTR_ERR(st->clk);
> =C2=A0
> -	st->pwrdown_gpio =3D devm_gpiod_get_optional(&spi->dev, "powerdown",
> +	st->pwrdown_gpio =3D devm_gpiod_get_optional(dev, "powerdown",
> =C2=A0						=C2=A0=C2=A0 GPIOD_OUT_LOW);
> =C2=A0	if (IS_ERR(st->pwrdown_gpio))
> =C2=A0		return PTR_ERR(st->pwrdown_gpio);
> =C2=A0
> -	ret =3D ad9467_reset(&spi->dev);
> +	ret =3D ad9467_reset(dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -1322,8 +1323,8 @@ static int ad9467_probe(struct spi_device *spi)
> =C2=A0
> =C2=A0	id =3D ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
> =C2=A0	if (id !=3D st->info->id) {
> -		dev_err(&spi->dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> -			id, st->info->id);
> +		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n", id,
> +			st->info->id);
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> @@ -1339,11 +1340,11 @@ static int ad9467_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_iio_backend_request_buffer(&spi->dev, st->back, indio_dev)=
;
> +	ret =3D devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_iio_backend_enable(&spi->dev, st->back);
> +	ret =3D devm_iio_backend_enable(dev, st->back);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> @@ -1351,7 +1352,7 @@ static int ad9467_probe(struct spi_device *spi)
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> -	ret =3D devm_iio_device_register(&spi->dev, indio_dev);
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
