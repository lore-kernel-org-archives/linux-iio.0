Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAF47A0BC;
	Thu,  2 Jul 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994196; cv=none; b=grNnA/IFp0DYHYoDSFJFmYBeUMy3sff8uaWIJ8tLLcSrjx5bLwzgt2+RXiQla/nSgci0BHdnxQaAHjXRPfKZE8z9ut7rcSfmuUGZlpeicCU1D+xDaNwhdZJrdZRBBEvjLdCxI1VH0M1U2sIZreQvmJ+PyCYMdg/LIgvTBvS0H7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994196; c=relaxed/simple;
	bh=EmWZV2ehRtvYZ67TamUlmuOjOamHc07GXyD4SH18O/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XePZ/fXFV1zZ2PaRor/rFyLqzINkC2yioSWiBD2yfi8RKPN9xyuxBtXDa786W3+1+MlS4sJ1+lpA96HLKLiDtsPOJ0G3flALQmDtsAKC7I0gqm8KxYbRJxBbN+7xm4v+WM69Dwriqij6jku84Xuft+N61vXxNiXUJtAMdaoDBnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lZA7Nmc8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lZA7Nmc8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC9731F000E9;
	Thu,  2 Jul 2026 12:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782994193;
	bh=Zer7p0Blh7A//tSo3eo/vnBX2xvZTMRC8YzE9BbqskU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lZA7Nmc8ZfMKDu35xCcPLy+AldOJJAtVFQcp+4Gt0r30CAJ+bupfkS3Gexb54iUcS
	 p64Asn/YDR5WNDW1g9XErKrlRxKLFv+GpHlPhF/13yZo34MbWQ6Ar7ejfCf9zXZHmH
	 lqOkCaDeIJjK+5HvMHd8mRToe8+fBWBpYk2yfvyTvJ1H/veVqQJCXUg3cA3f0Z9VYZ
	 5YpzzmabU5+1EdJywt/QNP8PPf7E3bWWbblFsvWm5p1eSR3BIsZeADU39qaTcEZbYl
	 hmyxRy0i3Z7wA/yb1MtWKf1T/FF1hcsO0FrtrOo4mwuwfEEC+CAcKCE0RD1zMNAaCM
	 b7S5lb4g3k+qw==
Date: Thu, 2 Jul 2026 14:09:50 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: deselect shub page before
 reading whoami
Message-ID: <akZVDry41WEl5y4Y@lore-desk>
References: <20260702104059.1744219-1-andreas.kempe@actia.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tCkRrf7zk0qle7rg"
Content-Disposition: inline
In-Reply-To: <20260702104059.1744219-1-andreas.kempe@actia.se>


--tCkRrf7zk0qle7rg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> As part of driver initialization, e.g. st_lsm6dsx_init_shub() selects
> the shub register page using st_lsm6dsx_set_page(). Selecting the shub
> register page shadows the regular register space so whoami, among other
> registers, is no longer accessible.
>=20
> In applications where the IMU is permanently powered separately from the
> processor, there is a window where a reset of the CPU leaves the IMU in
> the shub register page. Once this occurs, any subsequent probe attempt
> fails because of the register shadowing.
>=20
> Using the ism330dlc, the error typically looks like
>=20
>     st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
>=20
> with the unknown whoami read from a reserved register in the shub page.
>=20
> The reset register is also shadowed by the page select, preventing a
> reset from recovering the chip.
>=20
> Unconditionally clear the shub page before the whoami readout to ensure
> normal register access and allow the initialization to proceed.
>=20
> Place the fix in st_lsm6dsx_check_whoami() before the whoami check
> because hw->settings, which st_lsm6dsx_set_page() relies on, is first
> assigned in that function.
>=20
> Placing the fix in a more logical place than the whoami check would
> require a bigger restructuring of the code.
>=20
> Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> ---
>=20
>  Changes in v2:
>    - Drop st_lsm6dsx_get_page() and unconditionally clear the shub page.
>    - Make the code comment clearer.
>    - Document the placement rationale in the commit message.
>    - Link to v1: https://lore.kernel.org/linux-iio/20260604132646.1099072=
-1-andreas.kempe@actia.se/
>=20
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 21 +++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 630e2cae6f19..f4edcb73ec8c 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1712,6 +1712,26 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6d=
sx_hw *hw, int id,
>  		return -ENODEV;
>  	}
> =20
> +	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> +
> +	if (hw->settings->shub_settings.page_mux.addr) {
> +		/*
> +		 * If the IMU has the shub page selected on init, for example
> +		 * after a CPU watchdog reset while the page is selected, the
> +		 * regular register space is shadowed. While the regular
> +		 * register space is shadowed, the registers needed for
> +		 * initializing the IMU are not available.
> +		 *
> +		 * Unconditionally clear the shub page selection to ensure
> +		 * normal register access.
> +		 */
> +		err =3D st_lsm6dsx_set_page(hw, false);
> +		if (err < 0) {
> +			dev_err(hw->dev, "failed to clear shub page\n");
> +			return err;
> +		}
> +	}
> +
>  	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
>  	if (err < 0) {
>  		dev_err(hw->dev, "failed to read whoami register\n");
> @@ -1724,7 +1744,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6ds=
x_hw *hw, int id,
>  	}
> =20
>  	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> -	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> =20
>  	return 0;
>  }
> --=20
> 2.53.0

--tCkRrf7zk0qle7rg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCakZVDgAKCRA6cBh0uS2t
rNzuAQCx6ZOfZtUZCoatNcBhXvB1tGAim8hqvPy5H/wKP/yiAwD/YUxl2mffdRnr
nzah+Z0cgGRLRly5ZKva1lgG1/UtIgQ=
=oTUd
-----END PGP SIGNATURE-----

--tCkRrf7zk0qle7rg--
