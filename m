Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD286412BF6
	for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 11:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791803535; cv=none; b=R92DjKzQaUe+lcgiEH39d56sF7NhsSG5cbZWGeZ5jpm3IQICG17cF6uRxPkS+ft5yf8nm+YiBK7nAhqPGctdk7MRinLLhTgroLwwm5G+vPI03IO7qQgn3DRQOhmzygT/lUfJwzNcPg7c5uPLEawyoWYQ8EIwQCaMLjcbtZLYaaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791803535; c=relaxed/simple;
	bh=9tKgi4nob0gWR6jL8cW6sSvoweRp2FvqFVGmLEAabvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhbwaFzoLTV+/PDl9fFk5A/UGNkHx0JH2VuMSRglsqAoDOENT3mchcKIGc1XXlzqwBdY3vGSf1ZLluJGJ2q1nILFgAhBmJFyDMKz73ySTTK+k/z2CAVi4AeRVbh9opZhkpvFtFOKR5PTvrn+JBo9ibl7hF8vnVQgdlKd0tqmSNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=eJLxshFX; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="eJLxshFX"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso13869105e9.2
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2026 04:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1791803532; x=1792408332; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=F75F9HJtYHpGQDNYPN6c7t7CsTnjwZyQElA+GAGdfiI=;
        b=eJLxshFXW66ujj/jUXKO15xOdtOFscSAK+pmJ2/+1NXsGcHUBQR29/z3ASxDTsccvO
         mY7d2/ZnwtDkYW12WxhQHq65i53s7v4TnjwFmYz+PAa7Djc0epEJV3Brj3UnW5r1v4LA
         hzZyVjyaO0aMEXQfdtTOsHAJSqRat0Om3IfRn6yIWy8doINC+cTJ38Rhh7nLVwM8HmIG
         CLfbIA92w+QDrS3TNTnaGKDZqMZOOavlf5Bx2mBEc/qgtWwQD/ORXoTq9MAu3953eXAk
         3LQRkmwvtK2Op6NJP95x1UtoJSc4arU+RKW43jrpEYaJlYgoMBi6f98AtldAVcWwrgvM
         uHZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791803532; x=1792408332;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=F75F9HJtYHpGQDNYPN6c7t7CsTnjwZyQElA+GAGdfiI=;
        b=Skrx+oWVHuakolTSiu6h32M+ifYI5+Ve3yfRaN7dw7Io9ljS+ioXUunCc2wgTOFNZx
         om7MARAfAv7s8ca15Ue8YX5FbM55xGwOa5em3f+AyVB+FuJZLEIYKTTG6WTp3p9FmGF0
         JRHoI+GYmvTWWWnjDN6wg/WGl58m2VhbVOkKq1bDIO1cooVuScj3qGf+487vmDgGswWv
         Wync1Q9suOFf8j2eMLPc3Bv6Q6iDN2ZekvLFUhZHINslqORyI721KWDdTlg31p2ppATO
         nxHNyZGSMifRYV1gqdOisqvSQsMBBdDeK6Y0fi85UaHCXeviFVs1LehcH+Q0BFcrWo4a
         wyRA==
X-Forwarded-Encrypted: i=1; AKwUvBz+/+PK8jXET5lExHn8P4oYqW93aMpc84M+PhXfufo3ldYlFQv9JPcbn863MwbymgTRJsTQDgZRdpw=@vger.kernel.org
X-Gm-Message-State: AFq9FYLl9o0QX2mNSMaBc/tFfmBedRvqIcwQtV1cDIHYRH1Da6ZHgN4/
	Jnkvzj8UFQTSa2CFUKOUeLI79xbj4qK5NRgGl7wcrmfJFC7GSTj6SKgcY7+w1DJsQ08=
X-Gm-Gg: AYBFou0s7cBGagCmbrmuVCVVH7Oz6YsIpakzehvLMmC+K/WY7NJGRGB7pnXS6ngZ9nH
	G50C8js6GztgAKITW8S7Bz2zE6wzqOLXFXbSNV9/4jDXsS8vUgCxqvX+XdwRqMkvL7Z5nTNDOKA
	yZiKT6gbOrdQv6omKzY/lDmZRWHzaEyXSvgsOFzxhdnE/gLdiafaZu4CFx4Ot9Q1UboRKSDAh5j
	PWzg0KUeywC3Yrnxp3sxf2ZHSjMJtgfyoNK+V9a1SNrbnGkJwcBs7NwPrPu2Xr3s/Ofyay9kMie
	5Oy8ylYXA8Wp5y7n/CA+45eQXamgVz5EOlFc1etZDuwFMJ0EXfaO1I6wol9F47RMl+fEcplg/jR
	GvjP6vcsWK4q2vYgiNG4nAdzmbVhkVsrNs7Jo8BElf4dOhLBOAKz9F0+kMl3f2qoavF9RzBhLAS
	jG0PSynZWp91DVybF80ZRvsk67UHFC+FsmsdiCg0RKG1q0lnaVg57PHXAODsvVkD98PaVtVdYD8
	ffFEmeblO3tvP8j1ZglQN0pOohdib4q6Pc2845oiz9Fwfjlct2i75YUnGa6N3w=
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c10:1419 with SMTP id 5b1f17b1804b1-4a18e4cd667mr168009045e9.26.1791803531853;
        Mon, 12 Oct 2026 04:12:11 -0700 (PDT)
Received: from localhost (p200300f65f19a904ade4f69ba751c34c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:ade4:f69b:a751:c34c])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48db94e33c7sm20513096f8f.10.2026.10.12.04.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 04:12:10 -0700 (PDT)
Date: Mon, 12 Oct 2026 13:12:09 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: radu.sabau@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: imu: Add driver for the ADI ADIS16607
Message-ID: <aszAHLVf7MEqvht7@monoceros>
References: <20261001-adis16607-v1-0-9c89cee35d56@analog.com>
 <20261001-adis16607-v1-2-9c89cee35d56@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ztwc4ffmxytpfg57"
Content-Disposition: inline
In-Reply-To: <20261001-adis16607-v1-2-9c89cee35d56@analog.com>


--ztwc4ffmxytpfg57
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 2/2] iio: imu: Add driver for the ADI ADIS16607
MIME-Version: 1.0

On Thu, Oct 01, 2026 at 12:11:50PM +0300, Radu Sabau via B4 Relay wrote:
> +#include <linux/mod_devicetable.h>
> [...]
> +#include <linux/spi/spi.h>

Please don't use <linux/mod_devicetable.h>. <linux/spi/spi.h> is good
enough to provide spi_device_id and of_device_id already.

> +static const struct spi_device_id adis16607_id[] =3D {
> +	{ "adis16607-2", (kernel_ulong_t)&adis16607_2_chip_info },
> +	{ "adis16607-3", (kernel_ulong_t)&adis16607_3_chip_info },
> +	{ }

Please use named initializers, i.e.

	{ .name =3D "adis16607-2", .driver_data =3D (kernel_ulong_t)&adis16607_2_c=
hip_info },

> +};
> +MODULE_DEVICE_TABLE(spi, adis16607_id);
> +
> +static const struct of_device_id adis16607_of_match[] =3D {
> +	{ .compatible =3D "adi,adis16607-2", .data =3D &adis16607_2_chip_info },
> +	{ .compatible =3D "adi,adis16607-3", .data =3D &adis16607_3_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adis16607_of_match);
> +
> +static struct spi_driver adis16607_driver =3D {
> +	.driver =3D {
> +		.name =3D "adis16607",
> +		.of_match_table =3D adis16607_of_match,
> +	},
> +	.probe =3D adis16607_probe,
> +	.id_table =3D adis16607_id,
> +};
> +module_spi_driver(adis16607_driver);
> +
> +MODULE_AUTHOR("Radu Sabau <radu.sabau@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16607 IMU driver");
> +MODULE_IMPORT_NS("IIO_ADISLIB");
> +MODULE_LICENSE("GPL");
>=20
> --=20
> 2.43.0
>=20
>=20

--ztwc4ffmxytpfg57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrMwIcACgkQj4D7WH0S
/k7IjAf/aT3gFonGq9cs0V+D6m1lYBsVjBu3cKVYbQMkl+/IULwA3CPqPV1apAio
0KeyWJep0LQ92IHMvA+lIto+uTLywmqhWQSmMwaTnu3cbVr8xJa+upbV+hiJMOTm
6Q0DAv+UvHZ2D8WSGHh3LprDnR+kKGSoyJfsBnx3DSU2cW7zYf18Oq8kuCD9TBDo
U/fNRDEQeQTJSErdE+CLoGpd3cachuTxyw+slgvbjcARYreo51weR/XnnNbeORZa
tWWr3bv7LKZdpC8TS6lQrqB6AO8WTzc0fzhRSOt7BD3zs09sZPBILr2yqD52vFlF
Mo+3i15UQUp4Z8KamAPH3ZIaN+oJow==
=QDxW
-----END PGP SIGNATURE-----

--ztwc4ffmxytpfg57--
