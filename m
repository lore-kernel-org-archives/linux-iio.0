Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3B33F589;
	Wed, 24 Jun 2026 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323248; cv=none; b=HK5YzEU7k7/IS0wRhOdP8ycpDfowR83OjNjlcY7Uy47xww0xNImiEkJXgLBEPfE3T2i8Cj/7MEOHxonUm9QskUaSdWvPSahjYfQuKn/U3RklF2Zdt+LiNYRFIkq5sWThOuPAqw4MEWl8CfUUOtInO+hPYYgEbPSx9Rm2OtrxbYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323248; c=relaxed/simple;
	bh=3cFZuLjxynkyyjqcVB/tlzGI9IQOzrAxGj2dYnDHBsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BnsVRNb/D+a593pW8vYs3qeUnWJveVXpXSNLUzXIbRGkUGoY6Ms9AHV/4iq5OinyKGs+Uugk2JzdjCEkFwjMPLUu4Man2Cd96bYe+s2PxI82JJL+xHQySYtZy/K3X7tfF8hhLGaM0gkGI0ebLBP0LprWjKNagVwfP5u4IEnsVko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMpuis/4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMpuis/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AD511F000E9;
	Wed, 24 Jun 2026 17:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782323246;
	bh=Z7Ci93mq1iy3fnNmknyfUuVe78hmVORY2A8WV8GY5ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BMpuis/4Iq4QgWnU4nYaeztFue0tsfIZdXRVFlaido6tyUUr4FRUaacVtnyN1ZGBR
	 WubLhGbc80d7eD8HWP9S5UV/HkMtC1IJCNCRGnEQHFSMPHx9SdPxp3JJi6CmX3O6gS
	 t2fKAbd3nDD6XSa2e85l6WA9YJOgglcAq1vUpZOAUPhOC4OH74rcRxz6oBXS2LyJ6c
	 vGHJjAt0uVnJSu1tLsqpLBvaX9zLYeHyYT45+J35Dl1zqDmwT4NjEjTpps82u27Vr+
	 mqWCvBgaeFlAxyhgzy5hwWQi7SK8KZ9VE2CLuruqoZo1SmAcM9kaL5xyxV+IzZ84w+
	 jSyuI1HGgemMw==
Date: Wed, 24 Jun 2026 18:47:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] iio: imu: adis16550: Simplify device
 abstraction
Message-ID: <20260624184718.51755e2a@jic23-huawei>
In-Reply-To: <d20edfa8ce9685c6c3d2654186e9b80625c61e24.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
	<d20edfa8ce9685c6c3d2654186e9b80625c61e24.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 19 Jun 2026 17:54:35 +0200
Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@baylibre.com> wrot=
e:

> The driver supports a single chip variant only. Simplify the driver by
> hard-coding the device properties instead of using the id_table's
> abstraction for a single chip type and a lookup in a table with only one
> entry.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub) <u.kleine-koenig@b=
aylibre.com>

For this one I'd like some feedback from Analog people.

The reason being that we could do similar to Andy's suggestion for the
tsc2046 and rip out the chip_info structure in favour of hard coding everyt=
hing
in there.  However, if we know there are similar parts and that their is
some plan to add support for them - I'd rather not have the churn of ripping
it out only to revert a little later.

So Nuno, Michael etc, where do we think this one is going?

(and yes I'm too busy / lazy / behind on review to go look for parts that l=
ook similar!)

Jonathan


> ---
>  drivers/iio/imu/adis16550.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> index 75679612052f..0fd18e16942f 100644
> --- a/drivers/iio/imu/adis16550.c
> +++ b/drivers/iio/imu/adis16550.c
> @@ -1064,9 +1064,8 @@ static int adis16550_probe(struct spi_device *spi)
>  		return -ENOMEM;
> =20
>  	st =3D iio_priv(indio_dev);
> -	st->info =3D spi_get_device_match_data(spi);
> -	if (!st->info)
> -		return -EINVAL;
> +	st->info =3D &adis16550_chip_info;
> +
>  	adis =3D &st->adis;
>  	indio_dev->name =3D st->info->name;
>  	indio_dev->channels =3D st->info->channels;
> @@ -1117,13 +1116,13 @@ static int adis16550_probe(struct spi_device *spi)
>  }
> =20
>  static const struct spi_device_id adis16550_id[] =3D {
> -	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
> +	{ .name =3D "adis16550" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(spi, adis16550_id);
> =20
>  static const struct of_device_id adis16550_of_match[] =3D {
> -	{ .compatible =3D "adi,adis16550", .data =3D &adis16550_chip_info },
> +	{ .compatible =3D "adi,adis16550" },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, adis16550_of_match);

