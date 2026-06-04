Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8420448035F;
	Thu,  4 Jun 2026 14:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780582388; cv=none; b=i3dxAQ9C++1JD88lb8dNjQiqeasFosjH7bGrjVCI+oC+qeg9jH8dmoKCfMOs8qxFAeZcIXdrP+wtQffQLiv1xSaPWxRdzMXc32sDASrue7YaYkJV/a9rQmKZmMTAmxTNmLLX1RSdLi4YKRg3y2+GeTWHfXxrWDA05EjTVOkginI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780582388; c=relaxed/simple;
	bh=vHgi/AACnYLnVQdFX/if5Viri6tXrrFYuSjzdt037wE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3lhd79LuQjk6hnwZnqF+rINdmkdUEsWkPbvt4Cfq0/fLttweDIUVTim1WiE/NfyW0bp8j3TzKmiGaMQpAEVBYnDDojgi1DpMOwBpyUQhjZ/xe8nNrKilhxuOftcTey+X9NU77hxVc6ozL5EwPrsiymrBOaEfl9bFoZoIEwvP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZD5Usb+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZD5Usb+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FD11F00899;
	Thu,  4 Jun 2026 14:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780582386;
	bh=/oIOnA3OC5iSOyvRReGRrAYxyai63yPPdWirPEsLc7Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FZD5Usb+UQgHMvEbzXxgjnSwW4XN/FDMAvKvq1+hRJZ2mC7CROpbu7MzIwObrMC5c
	 00rt2iWAhZm0NBYT2Gu7JkT2muriHOOYqlHEEn7+DUJzdpnjrTqNbR8ciyRPVSTHqS
	 IXKpmTUTCDvDtf0+A8Z1H1oMtI/KbCirPduqJ2/XsR/bnBEJGIZKlS6fcn6+wzmoSl
	 GIVLriu/WonHWmQ32wpT+jp8tYdjJ4bf6+t5jUkE01cvIwWGDEEr86V1WtveyJhNJI
	 SHtJxp+llNtySv9P4tHM/F6BBjtfPlNvq6FRQhhIHle0zg5zGsphBfNNVGA130448x
	 pVqHjEQHyS6Fw==
Date: Thu, 4 Jun 2026 16:13:03 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andreas Kempe <andreas.kempe@actia.se>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Message-ID: <aiGH7x531jwzOVxF@lore-desk>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8FU6kNJ0H40OcJpp"
Content-Disposition: inline
In-Reply-To: <20260604132646.1099072-1-andreas.kempe@actia.se>


--8FU6kNJ0H40OcJpp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> As part of driver initialisation, e.g. st_lsm6dsx_init_shub() selects
> the shub register page using st_lsm6dsx_set_page(). Selecting the shub
> register page shadows the regular register space so whoami, among other
> registers, is no longer accessible.
>=20
> In applications where the IMU is permanently powered separately from the
> processor, there is a window where a reset of the CPU leaves the IMU in
> the shub register page. Once this occurs, any subsequent probe attempt
> fails because of the register shadowing.

Hi Andreas,

can you please provide more details about how this issue can occur?
Is it enough, if the shub is available, to just always run
st_lsm6dsx_set_page(, false) before checking the whoami?

Regards,
Lorenzo

>=20
> Using the ism330dlc, the error typically looks like
>=20
> 	st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
>=20
> with the unknown whoami read from a reserved register in the shub page.
>=20
> The reset register is also shadowed by the page select, preventing a
> simple reset from recovering the chip.
>=20
> Add a readout of the shub register page selection and deselect the page
> if needed before reading whoami. This allows the driver to recover and
> probe correctly.
>=20
> Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 +++++++++++++++++++-
>  1 file changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 630e2cae6f19..6fef99f2e9f1 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -1692,10 +1692,27 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *hw,=
 bool enable)
>  	return err;
>  }
> =20
> +static int st_lsm6dsx_get_page(struct st_lsm6dsx_hw *hw, bool *enable)
> +{
> +	const struct st_lsm6dsx_shub_settings *hub_settings;
> +	unsigned int data;
> +	int err;
> +
> +	hub_settings =3D &hw->settings->shub_settings;
> +	err =3D regmap_read(hw->regmap, hub_settings->page_mux.addr, &data);
> +	if (err < 0)
> +		return err;
> +
> +	*enable =3D data & hub_settings->page_mux.mask;
> +
> +	return 0;
> +}
> +
>  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
>  				   const char **name)
>  {
>  	int err, i, j, data;
> +	bool enable;
> =20
>  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
>  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> @@ -1712,6 +1729,30 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6d=
sx_hw *hw, int id,
>  		return -ENODEV;
>  	}
> =20
> +	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> +
> +	if (hw->settings->shub_settings.page_mux.addr) {
> +		/*
> +		 * whoami is not available in the shub register page.
> +		 * Deselect the shub page if needed so whoami can be
> +		 * correctly read.
> +		 */
> +		err =3D st_lsm6dsx_get_page(hw, &enable);
> +		if (err < 0) {
> +			dev_err(hw->dev, "failed to get shub page\n");
> +			return err;
> +		}
> +
> +		if (enable) {
> +			dev_warn(hw->dev, "shub page selected; clearing it\n");
> +			err =3D st_lsm6dsx_set_page(hw, false);
> +			if (err < 0) {
> +				dev_err(hw->dev, "failed to clear shub page\n");
> +				return err;
> +			}
> +		}
> +	}
> +
>  	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
>  	if (err < 0) {
>  		dev_err(hw->dev, "failed to read whoami register\n");
> @@ -1724,7 +1765,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6ds=
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

--8FU6kNJ0H40OcJpp
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiGH7wAKCRA6cBh0uS2t
rAf4AP9I/ZNtRSKzV8miPxrC0V5LUq/mxZ48NkWuV5vH04kp0QEA4CsZRDLWfjAy
5S+tJl22PSQOhXbtX60SUU4ZEImMLwU=
=LrI3
-----END PGP SIGNATURE-----

--8FU6kNJ0H40OcJpp--
