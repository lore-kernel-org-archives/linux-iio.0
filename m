Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06ACD389DE8;
	Tue, 28 Jul 2026 16:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257624; cv=none; b=a95BtmHLUMi86FpMcZ87Ewqux/OlkhZP+WBDiTCuxzocte9ossv8ijFXebBKqiAJH8thxA7TzOoXQe4w9nmBHH9A+vP83A17PCdZZC45g2xwSS4qeu5l6t3Xm6PqNa1jWKuipIaMaW2IDTwV9d3JrgYX5LqaNVogPUDEPtUrZlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257624; c=relaxed/simple;
	bh=AfNmsVjHjzL/OxbsYZwIMpIVv/WjdKhbh8y03HM5K+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0UKG0jaJmR08R0QX/zmARErEnR5Xb3Fj+0qV2C0eiWBH9+oEIdm3dNnRdWi4llHpxujQl8aIUcKeJdg9Ly2RbSnpEGd4LdH1sK5Kq3fJ5KVet0Fby3AG9SA4kAJjuOUNsIak0qVQiQxU2TnfldrY1st9Z5ejJWs1Shfb7NC19M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCLqBHVX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCLqBHVX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45081F000E9;
	Tue, 28 Jul 2026 16:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257622;
	bh=fVpYF+txQfE6xmbYKLu5QG2YgRYvKj+7jnCAY62oqFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCLqBHVXkFHb1S8Y+UdBjUHr0MJ4B8jTHy4pG3PnhZROo/jo68gXkRLIn4T4e0hZS
	 ajXo4EBKXDZ6R09+giUcw0JPYnRWDm6/PTbl29a7B+MUgz6q6QMkRbfIJ/Jr9/zfyO
	 kaZbQiIBChEs6oIzB841vGxeUliOcEpDFWVwpwIaFjEsdxguLhSIEEFRfPua6ULMd7
	 kNBlND0Dgza6sOLFis8+H9cAf19SxHGS4xxbB+v49uGMAai4/y/bGdsISC0EkQeh69
	 PV5cpwRgjmiq686EJ2zwbaZ84GnuueG+Bofh95QjP4fZZuhXuRhVqkWWj0NrWQzj3g
	 E3hK0kaKwRvwg==
Date: Tue, 28 Jul 2026 17:53:37 +0100
From: Conor Dooley <conor@kernel.org>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chris Morgan <macromorgan@hotmail.com>,
	Luca Weiss <luca.weiss@fairphone.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: imu: inv_icm42600: add support for icm42630
Message-ID: <20260728-hardwood-support-f18e98366142@spud>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
 <20260724202708.128267-5-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zeQ6IDqFsTS8F60G"
Content-Disposition: inline
In-Reply-To: <20260724202708.128267-5-jorijnvdgraaf@catcrafts.net>

--zeQ6IDqFsTS8F60G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:27:08PM +0200, Jorijn van der Graaf wrote:
> The TDK InvenSense ICM-42630 is a 6-axis IMU of the ICM-42600 family,
> found e.g. in the Fairphone 6. It is register-compatible with its
> siblings (the existing driver works on it unmodified) and reports
> WHOAMI value 0x0C.
>=20
> The part appears to be a mobile SKU and has no public datasheet: the
> identity comes from the Fairphone 6 platform documentation and
> schematics naming the part, and the WHOAMI value was read from the
> hardware, whose bank 0 register defaults match the ICM-42600 family
> layout.
>=20
> Add the chip id, WHOAMI value and I2C/SPI match entries, using the
> family default configuration like the ICM-42631. Devicetrees describe
> the part with an icm42631 fallback; the dedicated entries bind the
> exact part where the kernel knows it.
>=20
> Tested on the Fairphone 6 via a backport of this change to the
> device's 7.1-based kernel (only the id-table style and entry placement
> adjusted to that base), on a bit-banged SPI bus with INT1 wired to the
> SoC: probe, accelerometer, gyroscope and temperature raw reads, all
> full-scale ranges, multiple sampling frequencies, and watermark-paced
> FIFO reads through the INT1 interrupt.
>=20
> Acked-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>

This patch is not needed because you can make use of the fallback and
should be dropped.

Thanks,
Conor.

> ---
> v2: place the match entries in numeric position (the only code
> change); kept the Acked-by.
>  drivers/iio/imu/inv_icm42600/inv_icm42600.h      | 2 ++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 5 +++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c  | 4 ++++
>  drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c  | 4 ++++
>  4 files changed, 15 insertions(+)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/iio/im=
u/inv_icm42600/inv_icm42600.h
> index b55d993f0264..349de5458581 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> @@ -28,6 +28,7 @@ enum inv_icm42600_chip {
>  	INV_CHIP_ICM42622,
>  	INV_CHIP_ICM42688,
>  	INV_CHIP_ICM42631,
> +	INV_CHIP_ICM42630,
>  	INV_CHIP_NB,
>  };
> =20
> @@ -386,6 +387,7 @@ struct inv_icm42600_sensor_state {
>  #define INV_ICM42600_WHOAMI_ICM42622			0x46
>  #define INV_ICM42600_WHOAMI_ICM42688			0x47
>  #define INV_ICM42600_WHOAMI_ICM42631			0x5C
> +#define INV_ICM42600_WHOAMI_ICM42630			0x0C
> =20
>  /* User bank 1 (MSB 0x10) */
>  #define INV_ICM42600_REG_SENSOR_CONFIG0			0x1003
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c
> index f306e3ffca48..da7bc0f1155c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -177,6 +177,11 @@ static const struct inv_icm42600_hw inv_icm42600_hw[=
INV_CHIP_NB] =3D {
>  		.name =3D "icm42631",
>  		.conf =3D &inv_icm42600_default_conf,
>  	},
> +	[INV_CHIP_ICM42630] =3D {
> +		.whoami =3D INV_ICM42600_WHOAMI_ICM42630,
> +		.name =3D "icm42630",
> +		.conf =3D &inv_icm42600_default_conf,
> +	},
>  };
> =20
>  const struct iio_mount_matrix *
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_i2c.c
> index e44ed6dcde02..672b19d2e41c 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_i2c.c
> @@ -78,6 +78,7 @@ static const struct i2c_device_id inv_icm42600_id[] =3D=
 {
>  	{ .name =3D "icm42602", .driver_data =3D INV_CHIP_ICM42602 },
>  	{ .name =3D "icm42605", .driver_data =3D INV_CHIP_ICM42605 },
>  	{ .name =3D "icm42622", .driver_data =3D INV_CHIP_ICM42622 },
> +	{ .name =3D "icm42630", .driver_data =3D INV_CHIP_ICM42630 },
>  	{ .name =3D "icm42631", .driver_data =3D INV_CHIP_ICM42631 },
>  	{ .name =3D "icm42686", .driver_data =3D INV_CHIP_ICM42686 },
>  	{ .name =3D "icm42688", .driver_data =3D INV_CHIP_ICM42688 },
> @@ -98,6 +99,9 @@ static const struct of_device_id inv_icm42600_of_matche=
s[] =3D {
>  	}, {
>  		.compatible =3D "invensense,icm42622",
>  		.data =3D (void *)INV_CHIP_ICM42622,
> +	}, {
> +		.compatible =3D "invensense,icm42630",
> +		.data =3D (void *)INV_CHIP_ICM42630,
>  	}, {
>  		.compatible =3D "invensense,icm42631",
>  		.data =3D (void *)INV_CHIP_ICM42631,
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c b/drivers/ii=
o/imu/inv_icm42600/inv_icm42600_spi.c
> index 3e2f4eb42e97..3707460d77e1 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_spi.c
> @@ -75,6 +75,7 @@ static const struct spi_device_id inv_icm42600_id[] =3D=
 {
>  	{ .name =3D "icm42602", .driver_data =3D INV_CHIP_ICM42602 },
>  	{ .name =3D "icm42605", .driver_data =3D INV_CHIP_ICM42605 },
>  	{ .name =3D "icm42622", .driver_data =3D INV_CHIP_ICM42622 },
> +	{ .name =3D "icm42630", .driver_data =3D INV_CHIP_ICM42630 },
>  	{ .name =3D "icm42631", .driver_data =3D INV_CHIP_ICM42631 },
>  	{ .name =3D "icm42686", .driver_data =3D INV_CHIP_ICM42686 },
>  	{ .name =3D "icm42688", .driver_data =3D INV_CHIP_ICM42688 },
> @@ -95,6 +96,9 @@ static const struct of_device_id inv_icm42600_of_matche=
s[] =3D {
>  	}, {
>  		.compatible =3D "invensense,icm42622",
>  		.data =3D (void *)INV_CHIP_ICM42622,
> +	}, {
> +		.compatible =3D "invensense,icm42630",
> +		.data =3D (void *)INV_CHIP_ICM42630,
>  	}, {
>  		.compatible =3D "invensense,icm42631",
>  		.data =3D (void *)INV_CHIP_ICM42631,
> --=20
> 2.55.0
>=20

--zeQ6IDqFsTS8F60G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjekQAKCRB4tDGHoIJi
0gYOAP9z13siGCfqufukPn+GeIWpy6anuxfPfIIys8TbE0SJNQEAymF1OBhvAqkz
DvQ9S4JdrxfquvlbEZvkkUuE5H+LXAs=
=b4Aw
-----END PGP SIGNATURE-----

--zeQ6IDqFsTS8F60G--
