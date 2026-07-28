Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F6139021E;
	Tue, 28 Jul 2026 16:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785257524; cv=none; b=s+ZgPFpJRkLE+YP0eKyHTwhZzJEGprAfCm5yvtPbLsOa1FClc9EUCwanM4ZD2X+Yw5IueMI3Jvkz0YhgtOZ5y4wFZGICG9KYaI+O7y7eafaNHMAqKTsHU0fk48fKRhd+1tbAqMG6uVWbvEYuBo79GIfxn+jjuCe5LqjfzFCHoos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785257524; c=relaxed/simple;
	bh=cF84Aluq7zOpr48gpuCferNUW8pj6MmSwBQbgoGJYvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYnlnVgVyJrke3MXv6fXtjcYB2H8mIucVNoodDfn0imwvXsBfz9TQ0hwcbMkpCk2ZmS106szy4s+i6l5M+dcru94ChRP3dHJ9tgv9/UXeyO8yeNdD3h3FmxigoT+ZlBnsYv4sNqEh/8S+okf76KZbo73/QlsJuTSXDlrwvUFNWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RouYSSBb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RouYSSBb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A65561F000E9;
	Tue, 28 Jul 2026 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785257522;
	bh=WKwEeYD7Il3cUt4y4I43rvbKa4JayoZIADcBnGDf8sA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RouYSSBbHApS4ZxxzGytO1gh5MPEdKb/YCUJ0EHyUSfe3ZgUhMOUlSuTO1uNnJn00
	 1hL/o9tNdRabUbgxH4cC2bqyKRSldzXNNXYWL3f/3EvXW8NjC0OaRu26AkfcogKekI
	 rYPTf+IQ87A3VbY82bld8hkGO95Wk+I/FVrAly9WH9BOkbnqECEpsp3Vz2Bjem2WvX
	 FImjmddjN5qjrZHROCMhPvLbgtW8Ju3iEP26KEOI4SyA5q/t9+Zftv+JkSctxo0jNI
	 yiYXjGeV1Db40aahT1ySPDA7cyOV5NJzmcbmTkJZjfnRiAbgaKPtDRFQmFa1f/lW1W
	 8kEcvvi16FLJg==
Date: Tue, 28 Jul 2026 17:51:57 +0100
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
Subject: Re: [PATCH v2 2/4] iio: imu: inv_icm42600: warn on whoami mismatch
 instead of failing probe
Message-ID: <20260728-extradite-yanking-42d918637f61@spud>
References: <20260724202708.128267-1-jorijnvdgraaf@catcrafts.net>
 <20260724202708.128267-3-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9rBZKHmncbl1SZZf"
Content-Disposition: inline
In-Reply-To: <20260724202708.128267-3-jorijnvdgraaf@catcrafts.net>

--9rBZKHmncbl1SZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:27:06PM +0200, Jorijn van der Graaf wrote:
> A WHOAMI value differing from the one the compatible implies aborts
> probe with -ENODEV, which prevents a register-compatible part described
> with a fallback compatible from probing at all.
>=20
> The devicetree compatible is authoritative for which part is fitted:
> demote the mismatch to a warning and continue, as st_sensors does since
> commit a3c2c5c937ed ("iio: st_sensors: relax WhoAmI check in
> st_sensors_verify_id()"). This changes the probe outcome on mismatch
> for all parts the driver supports.
>=20
> Tested via a backport to a Fairphone 6 running a 7.1-based kernel: its
> ICM-42630 (WHOAMI 0x0C), described with an icm42631 fallback compatible
> and matched as icm42631, warns once and probes, and accelerometer,
> gyroscope and temperature reads work.
>=20
> Suggested-by: Conor Dooley <conor@kernel.org>

I don't want this to warn, I want it gone. Fallback use should not
produce a warning.

> Link: https://lore.kernel.org/all/20260722-creature-volley-0f083b904c1d@s=
pud/
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
> ---
> New in v2.
>  drivers/iio/imu/inv_icm42600/inv_icm42600_core.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c b/drivers/i=
io/imu/inv_icm42600/inv_icm42600_core.c
> index dc97d8a274e3..f306e3ffca48 100644
> --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_core.c
> @@ -509,11 +509,9 @@ static int inv_icm42600_setup(struct inv_icm42600_st=
ate *st,
>  	ret =3D regmap_read(st->map, INV_ICM42600_REG_WHOAMI, &val);
>  	if (ret)
>  		return ret;
> -	if (val !=3D hw->whoami) {
> -		dev_err(dev, "invalid whoami %#02x expected %#02x (%s)\n",
> -			val, hw->whoami, hw->name);
> -		return -ENODEV;
> -	}
> +	if (val !=3D hw->whoami)
> +		dev_warn(dev, "unexpected whoami %#02x, expected %#02x (%s)\n",
> +			 val, hw->whoami, hw->name);
>  	st->name =3D hw->name;
> =20
>  	/* reset to make sure previous state are not there */
> --=20
> 2.55.0
>=20

--9rBZKHmncbl1SZZf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjeLQAKCRB4tDGHoIJi
0nxXAP9+g+b9V3pRyFw2nHjqhTi5NkcV7nyaAEeQH5nzVsbCzgD8Dvj969hmiF9A
gXX6JP+uwjONiH8knXxlwW0Fmk67+AQ=
=qMDO
-----END PGP SIGNATURE-----

--9rBZKHmncbl1SZZf--
