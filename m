Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E350E37BE80;
	Fri, 31 Jul 2026 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785530688; cv=none; b=EydRw1S6l71+TfqlZcvP7necR2ezb6KWbbhAmg0OuSTdTCw2QRQy8B0lWgz4Uc73RYs38Hx/EuCSILzETWu9IzOsFV7WSlfcm5lorBOVrSxK+UY4AkJjl0he1gG83pcd0w7j4cIwnflYRcR+132AGxHmLs+KPiBKr3kwdgvmwXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785530688; c=relaxed/simple;
	bh=xJQyLT1zFVZ07W1xKvXzgh21Lk27PGBHX2D1Exjrcf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmuAxcLTEtD4txT99iOWBSo21xju4AJ50+c4cCLQolEJTN8eoXwU/sA/oBIAescIDSqA90MGl88ecVIwbPryoMt919s+TPl7ScU1HjAfhA+H8aZqt4XDi1OHudLUpNTRVusLrxIULJJ/pEdCSMmgud+L4nks0QQtewjLeapFKZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrdWQjb4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrdWQjb4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053FC1F00AC4;
	Fri, 31 Jul 2026 20:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785530687;
	bh=axSbroHLVON0dOpL+Fi1SxOoRIfDTyR/Z1muZpucATo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KrdWQjb408NDN3mfqeGfdgf7yyI6umuyLUbC99uqyfYXDKA1UJ5jfXdhX+kybaYJD
	 6IpqWbXeS5cE2vlPWulSHmytEy2VSX9Ols2f+e8SXL8sABjin404xVFJBsxlzFDyCe
	 NF+3wyR5eEjhJn+qHnvPbKWiBCv0qLsR9s0p4CiCW2L7MuVQOrnKGlsUd2OrlJVzSn
	 I/55VUDqpI1uz8xKwdaJveA0BnUAqcXJed2ixKs+8Pxm723jwveIDbTKXQf2HEb+oX
	 C7cgQjHnSL0aUjMM7sya+FDJPM4uckx+HK6zQGWaD6FHL2+VyPfhehWVUJlUz04QTi
	 TwaopCzUzlowg==
Date: Fri, 31 Jul 2026 22:44:44 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Update enable mask when using
 sensor fusion
Message-ID: <am0JPMfepRUkMNfy@lore-qca>
References: <20260731174702.2665870-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="lXY97sJpBYsqVMno"
Content-Disposition: inline
In-Reply-To: <20260731174702.2665870-1-flavra@baylibre.com>

--lXY97sJpBYsqVMno
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> The enable_mask struct member keeps track of which sensors are enabled in
> the IMU. When enabling and disabling the sensor fusion functionality, the
> driver does not properly update this struct member. This prevents a corre=
ct
> calculation of the number of samples that should be read from the hardware
> FIFO; as a result, reads from the FIFO can be unnecessarily split into
> multiple transactions, some of which can read past the FIFO length.

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> Fixes: cd4e1141bff8 ("iio: imu: st_lsm6dsx: Add support for rotation sens=
or")
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> index 2e72c7ba94dd..5321033daebc 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c
> @@ -112,6 +112,11 @@ int st_lsm6dsx_fusion_set_enable(struct st_lsm6dsx_s=
ensor *sensor, bool enable)
>  		return err;
>  	}
> =20
> +	if (enable)
> +		hw->enable_mask |=3D BIT(ST_LSM6DSX_ID_FUSION);
> +	else
> +		hw->enable_mask &=3D ~BIT(ST_LSM6DSX_ID_FUSION);
> +
>  	return st_lsm6dsx_fusion_page_disable(hw);
>  }
> =20
> --=20
> 2.39.5
>=20

--lXY97sJpBYsqVMno
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCam0JPAAKCRA6cBh0uS2t
rFpSAP0bg7JRxu5b8/ZfMWnP4vMa4ye90ZtH+ojMN/lBhLhORwD+Jkte54B6STtW
IFlCcf/05yni+S1EuMNdOmiyAv0Pswk=
=LzDt
-----END PGP SIGNATURE-----

--lXY97sJpBYsqVMno--
