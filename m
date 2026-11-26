Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795658434;
	b=cHGArUmZUWjvRQbU16d9IPszAFF6/uyMhcoyXeuu70EbWeTTnI8qBMlAwwaDHyN54MUr
	 Hbn/LZ+/DEMoaLInXWzc5o5qfQwzvJe2/D58FBIlSd8ILCLAZ7SmY+dfba14jddg4u5My
	 IC+Wgm8ykW1yYP2zoQoYUZ34yGij9xxiz6Vzbwh6fWzBeSyHjtqyxBhjVxQ2/mwGjvuCM
	 5f+pQiTA+cYLsbxvGRTAAtljfuWxYf5YLD6vtM1UEOFJcENGOip6V1PMe7L3uYM4m4wXk
	 tcNJryr1bCkPAvFggFRhIHV33wkEMl/CmX/QjaPdfOeGSxFzCxPOY+GJWZXbvVK24sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658434;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rclIhKxKVrA3v/EDPy0FH8lxHjo9Lwc467SMjq6lroE=;
	b=ksOijRv6f0OfqG4u2VOYtw6/1C5pRTrDRZ3yhktXo/uxnFB2Ca10nKT+nwoOUdakjFZc
	 M+NcYdq/MFrNh1Sa70Q4M+j8ecmoeSnPq8V3MPvM+zwLXOTrl2orFkRoFBPfJXPPg7Ipw
	 dFL++x2vSNP6etUEfVYNDwv/FolU8UAoSf0ziXNr15rEZvzF93FqywX8jar0Jiof6Nl+z
	 KuMwloOeIeyqdwZiFjeHzyrQiQAQr2mdPJj+acMDldV3gz5dSmAEK2fwwwqFWZT401Slp
	 3UY6aqC2Rq88dcK8rvgUkFANhQi6Nk6btuUKxCNoHEkUjXTIob3nQYR0mBDzlIaQd8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBbfAcrF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C681C606A31E;
	Thu, 26 Nov 2026 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OBbfAcrF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47DE1F000C0;
	Thu, 26 Nov 2026 02:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795658434;
	bh=rclIhKxKVrA3v/EDPy0FH8lxHjo9Lwc467SMjq6lroE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OBbfAcrFN10TQVbAIzfEXXA41ULoT16vWthMwAfD/WtHnQ1DbxbTTjjacX3qDBVwI
	 ey/YxI82YDQkkgEp9f0+1xNeXyXYexMZZwJBhrbuHE+f5DM4u6lYp3zj31iR6tvZQP
	 0Kox2Cpk4p9gVyamH66XJl+mYMjv14FjZorgdq5OI3iZNZlWYLNcYZCOf3VfEhVHd0
	 W20gZRSOPL+h+DjYWY0XK4zbjhkHJ8dG48NESaUZKwjctTYhJ0A2QUbEbLJnEPqoY0
	 sJryXb2WuxB84YyR+ilpjto9p3b8n5iWMhtLDE357NsG9y5XIn02Kfe9hRKNbXsnkz
	 kifqr0/31AAYg==
Date: Thu, 26 Nov 2026 02:00:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux@analog.com, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Arnd
 Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Message-ID: <20261126020028.62a67891@jic23-hlaptop>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
	<20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Nov 2026 10:19:22 +0000
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The driver refuses to probe without struct ad7793_platform_data, and
> there are no in-tree users of it. That means the driver can not be used
> at all on a modern system.
>=20
> Get the configuration from firmware properties instead, following the
> new binding, and drop the platform data header:
>=20
> - The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 if
>   refin2-supply is present, and the internal 1.17 V reference otherwise.
>   Parts without an internal reference need refin-supply.
> - An external clock on the CLK pin is used if given. A 128 kHz clock
>   is divided by 2 internally.
> - The input buffer stays enabled (as it is at power-up) unless
>   adi,buffer-disable is set, and unipolar coding is used unless bipolar
>   is set.
> - The bias voltage generator, the burnout currents and the excitation
>   current sources get their own properties.
>=20
> While at it, also enable the AVDD and DVDD supplies, add an OF match
> table and fold the platform data checks into the property parsing.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Looks fine in general but could as Andy suggested be package
a tiny bit differently to be nicer to reviewers!


> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index b0f44c144f20..f3e3ca724ec2 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c

> =20
> +static int ad7793_parse_excitation(struct device *dev,
> +				   struct ad7793_config *cfg)
> +{
> +	static const char * const iout_pins[] =3D { "iout1", "iout2" };
> +	u32 pins[] =3D { 1, 2 };
> +	const char *names[2];
> +	u32 val;
> +	int ret;
> +
> +	ret =3D device_property_read_u32(dev, "adi,excitation-current-microamp",
> +				       &val);

Feel free to go a bit long on things like this.




