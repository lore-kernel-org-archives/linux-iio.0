Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0A93DF015
	for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 12:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773230665; cv=none; b=iUV0aPz4BQhBejXC08+IZHlsZWlmhfWet8E4b6k6dO0VxCpuxEw1AX7f9xSNC16e/BoVgFSq0CVI9GCn7PLsXtq+6ViB2hnZwX3goodjiQzDVB7Wuza8KTOHengCFPMm4N2tBsUB34mm2JDEKbwQj4BIVSYkHSE7q+k2PsC7Zys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773230665; c=relaxed/simple;
	bh=NBN4EYs7xt7jqIXewQhOoqZ3pl2OD60sVTf4oEtRNyw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T/yrCO3cfIvKIExltfC2aivvJ234KswQo1Mnlj0m623wDUw8f2Bi5pt0IMWIdqPSJh0KbECAdU5SZKD86K2En57PA5Kde4opq6GjiJXG1Akf0ajBEtKHswibbOThXLOwQSEX262YoiwTksh0GU8qxS13O5v43IJ2WUc54kVwm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9ZyC9mF; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9ZyC9mF"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so44047675e9.2
        for <linux-iio@vger.kernel.org>; Wed, 11 Mar 2026 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773230663; x=1773835463; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jIB3UajcKC7uFG6gjs/tsitE9iXxd/jUwRngeL3b5Yc=;
        b=S9ZyC9mFbmn0KcGhQ5cDnm7yUIiOWLCvQv2+adNqktzO+NslLdZV85jWqEkta7Z2CA
         XqhxIutckRxv+caQxgYSpsDAMx5e6V/HOb0+6B/ryaC314kDpzEynG08p6ArsIOkN6W2
         nZuAfoXbUMVASHDNs6e3wHStvTIt8SP/ypKVXN+8iHybO7dofoefoaRtTJMQpsBCFh6Y
         5hYQocoslTTJ0KKarSxJySRFdoEULwzk2ZZuXFNz6VKcNXpE4HNZItow6B9WRD2uH5+h
         kgIGuGU0y7qA6+uN8oLht9lEqNrQjCx5NWsJvdg9rKtn4R4WB3rVbFGLXGjfPcmdzQ4q
         pAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773230663; x=1773835463;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIB3UajcKC7uFG6gjs/tsitE9iXxd/jUwRngeL3b5Yc=;
        b=dG/1USl/LygacewQinZYu4qDbHra4ri6pMitdjRAPFGcgEUsDwGjVEiNwxe5Zj/E5A
         0lyjARXXr5IkNnXtZOfnKnuyLkyqtuH0dt+fLFR/FrikPEM6lfo7woOiOX1jn3Y/sQEA
         eqVK+BiQO6uq6P/Q7tH+TQAPqulPMGX0jXmdjn2c77qtKAbTTQPsTStpxxuDRGvwxMbG
         OyCfFPJWWGFrxLUufA8R8EDWO9EqwZfZ9f6Jjne0yd3a7pzx9tmXpXZWSjHXqtO95lTU
         7FOR8Lf51frByz2JXWlJV7QbkIJYdmAc6MH+SUBKRF6wTUIz2piDuXjboXRT7dJMMMhJ
         iElw==
X-Forwarded-Encrypted: i=1; AJvYcCV63JPzB1QVEes+D/EoNuV6xGFM6oWvpC96ZUuvXY1v9t5HnxQwSBxm14woamPQnzUONgw2f/0WIXY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxf5wzBWv5FutfTds2F8JqjCfB0gXPAS231pbowfTNz1CFU/y+
	5XT7OrILjfy1hiXoTb1x9hi6xurwGnAQlUonhEGYfOFhk8ceuAzDj0yF
X-Gm-Gg: ATEYQzw8zLH8WCzkYqZmWfkhXapMRAtKy+27anT+4+66r1GfxueAC9pU8xl6vcd11P/
	b+/jo5VqX4tjWRurgCAgJAwvKPAKDXThE2KWb9WI82RuAz8+YXaaY894QB2bZXHz+EbpME4Rkf5
	tyS1RbDFqJIOumDRNbuZEmyZB2McQ4YSzLUvW5OXgukRZ5PjtbG/x0yCrPsJtpMPWsRFWzWthjo
	8tpi1M0Es8azy3dxad6MXL5PZx7mw1CwAGBuDmk42+PIqtz3hW3WWrs1czPzn83PTzZrHBSY9Fo
	cTc6KdTkbYCdC3F/nxxWc2i+8b5iG6V0idl8okEVPdHC9kyitD+PRUHs380gjuhOZQMf3gew8Rb
	6Tksr4eN7XLehTDurywTh/rn+EcxXIW0Dk571AFiimt74nHWYbYc3OoSU5Wsb1P0F4aoMXccRc8
	6qm1E3tqhKZA2a/0+/+hi0f3mUE/xYjV08A1p9fTuYLw==
X-Received: by 2002:a05:600c:46d2:b0:485:410c:119b with SMTP id 5b1f17b1804b1-4854b10f69fmr36440635e9.13.1773230662587;
        Wed, 11 Mar 2026 05:04:22 -0700 (PDT)
Received: from [192.168.1.187] ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854b0b906esm24685175e9.4.2026.03.11.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:04:22 -0700 (PDT)
Message-ID: <35205bd9f56e042ffc4a1e469060880b0db2e90a.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] iio: dac: ad5504: fix scale via
 output-range-microvolt
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Taha Ed-Dafili
	 <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, 	nuno.sa@analog.com, andy@kernel.org,
 skhan@linuxfoundation.org, 	me@brighamcampbell.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 11 Mar 2026 12:05:07 +0000
In-Reply-To: <abBuAZTSeTjRhyZY@ashevche-desk.local>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
	 <20260310174835.24209-5-0rayn.dev@gmail.com>
	 <abBuAZTSeTjRhyZY@ashevche-desk.local>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 21:16 +0200, Andy Shevchenko wrote:
> On Tue, Mar 10, 2026 at 05:48:34PM +0000, Taha Ed-Dafili wrote:
> > The AD5504 full-scale range is hardware-determined by the
> > R_SEL pin (0-30V or 0-60V). Previously, the driver incorrectly used the
> > VCC regulator voltage to calculate the scale.
> >=20
> > Update the probe function to read the standard "output-range-microvolt"
> > property as a two-element array to determine the correct full-scale ran=
ge.
> > Use the MILLI macro for clearer millivolt assignments and simplify the
> > probe logic using a local device pointer.
>=20
> ...
>=20
> > =C2=A0static int ad5504_probe(struct spi_device *spi)
> > =C2=A0{
> > -	const struct ad5504_platform_data *pdata =3D dev_get_platdata(&spi->d=
ev);
> > +	struct device *dev =3D &spi->dev;
> > +	const struct ad5504_platform_data *pdata =3D dev_get_platdata(dev);
> > =C2=A0	struct iio_dev *indio_dev;
> > =C2=A0	struct ad5504_state *st;
> > =C2=A0	int ret;
> > +	u32 range[2];
>=20
> Preserve the reversed xmas tree order.
>=20
> > -	indio_dev =3D devm_iio_device_alloc(&spi->dev, sizeof(*st));
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
>=20
> Unrelated change. This should be split into another patch that makes use
> of it here and there.
>=20
> I have a d=C3=A9j=C3=A0 vu about these comments...
>=20
> > =C2=A0	if (!indio_dev)
> > =C2=A0		return -ENOMEM;
> > =C2=A0
> > =C2=A0	st =3D iio_priv(indio_dev);
> > =C2=A0
> > -	ret =3D devm_regulator_get_enable_read_voltage(&spi->dev, "vcc");
> > -	if (ret < 0 && ret !=3D -ENODEV)
> > +	ret =3D devm_regulator_get_enable(dev, "vcc");
> > +	if (ret)
> > =C2=A0		return ret;
>=20
> > -	if (ret =3D=3D -ENODEV) {
>=20
> Why remove this condition?
>=20
> This might break use of the driver on ACPI systems.
>=20
> > -		if (pdata->vref_mv)
> > -			st->vref_mv =3D pdata->vref_mv;
> > -		else
> > -			dev_warn(&spi->dev, "reference voltage unspecified\n");
> > -	} else {
> > -		st->vref_mv =3D ret / 1000;
> > -	}
> > +
> > +	st->vref_mv =3D 60 * MILLI;
> > +	ret =3D device_property_read_u32_array(dev, "output-range-microvolt",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0 range, 2);
>=20
> ARRAY_SIZE()
> (will require array_size.h)
>=20
> > +	if (!ret && range[1] =3D=3D 30 * MICRO)
> > +		st->vref_mv =3D 30 * MILLI;
>=20
> This looks unusual and hard to follow. It also misses the validation
> of the min of the range.

And the max FWIW. If the property is given we should be strict about it and=
 make
sure only valid inputs are given.=20

- Nuno S=C3=A1
>=20
> > +	if (pdata && pdata->vref_mv)
> > +		st->vref_mv =3D pdata->vref_mv;
>=20
> No, pdata should go.
>=20
> > =C2=A0
> > =C2=A0	st->spi =3D spi;
> > =C2=A0	indio_dev->name =3D spi_get_device_id(st->spi)->name;
>=20
> ...
>=20
> > =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > =C2=A0
> > =C2=A0	if (spi->irq) {
> > -		ret =3D devm_request_threaded_irq(&spi->dev, spi->irq,
> > -					=C2=A0=C2=A0 NULL,
> > -					=C2=A0=C2=A0 &ad5504_event_handler,
> > -					=C2=A0=C2=A0 IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > -					=C2=A0=C2=A0 spi_get_device_id(st->spi)->name,
> > -					=C2=A0=C2=A0 indio_dev);
> > +		ret =3D devm_request_threaded_irq(dev, spi->irq,
> > +						NULL,
> > +						&ad5504_event_handler,
> > +						IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> > +						spi_get_device_id(st->spi)->name,
> > +						indio_dev);
> > =C2=A0		if (ret)
> > =C2=A0			return ret;
> > =C2=A0	}
> > =C2=A0
> > -	return devm_iio_device_register(&spi->dev, indio_dev);
> > +	return devm_iio_device_register(dev, indio_dev);
> > =C2=A0}
>=20
> Unrelated changes.
