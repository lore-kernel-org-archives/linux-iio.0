Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAE429CE9;
	Thu,  4 Jun 2026 14:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583804; cv=none; b=RCDOAsjP2hC7kcAIhT/tHNcBvibj5p3dklhCuOYxfTMgb6wYZz85QUZt+PYCSiKhmJ0x/ipoWR4ZR2mMXWtYY8MK8bI1cBxv/6lG/7hJfchw7OBvH4ydbg/j3MMRz1Am0YRSJNwuWHJF+20Q05ZBJedXDYGM7gHtWELuhN4wABo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583804; c=relaxed/simple;
	bh=/J88rb0nDX5NLeYxmYzL+XfJ89mE+NzWKatyBREKCGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4fIxCo96dedzTSRsFk5o45TXVYKtG8lnOStTCdyfKd2M/qwQJlT4Dsac2JLPBFXn4UGPIQQP/41j/umsFYGy7b3YGYR4/Ji6JGAlYFV8iazGQ/ExatWV7VgUkYQDISNdehCwCryZ9a97MVRousY6ciURD65V1V62r+zo61puoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maibUjG+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maibUjG+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEFD1F00893;
	Thu,  4 Jun 2026 14:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780583802;
	bh=QCshPOzRUQuYbh/OHgbGqUvnRbDVRsdgiAEtv8f1Ed0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=maibUjG+Yi9rGjTl322FmDnOb3yEYKJhCfDv3XQn1md8IIEURiQvQZTqYTmBGLDnu
	 czgc7BA36WvjAtxZnllkTsKoNE0zTkA3C1e1DZpLNLxsCTGDzlyS+uOmgCSQMAnX4i
	 rzBux0+bOQVdIEK3X8QGKKi0hqZD3FH7qf/pq0CV6YJEQb1R/695YnUGrz9kOSexqg
	 OoEmWZi2m4N1IsAYsKECyITRZLHE0xc1YoFMgEa0tPm48zMbHCeMH9w+ePyzTnPlue
	 tvEtmDeiTTrj9OSk4LdJPCnNIxWy384cDUgw2NfsRv1s8jJtyLxFplz7YJ+o0rmMEG
	 B9HVT03bvx4Iw==
Date: Thu, 4 Jun 2026 16:36:40 +0200
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
Message-ID: <aiGNeKTzOR30w-Qf@lore-desk>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk>
 <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xd+h65mR+BPvoK+x"
Content-Disposition: inline
In-Reply-To: <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>


--Xd+h65mR+BPvoK+x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Thu, Jun 04, 2026 at 04:13:03PM +0200, Lorenzo Bianconi wrote:
> > CAUTION: This email originated from outside of the organization. Do not=
 click links or open attachments unless you recognize the sender and know t=
he content is safe.
> >=20
>=20
> > Date: Thu, 4 Jun 2026 16:13:03 +0200
> > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > To: Andreas Kempe <andreas.kempe@actia.se>
> > Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
> >  <dlechner@baylibre.com>, Nuno S=E1 <nuno.sa@analog.com>, Andy Shevchen=
ko
> >  <andy@kernel.org>, "linux-iio@vger.kernel.org"
> >  <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
> >  <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
> > Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before
> >  reading whoami
> >=20
> > > As part of driver initialisation, e.g. st_lsm6dsx_init_shub() selects
> > > the shub register page using st_lsm6dsx_set_page(). Selecting the shub
> > > register page shadows the regular register space so whoami, among oth=
er
> > > registers, is no longer accessible.
> > >=20
> > > In applications where the IMU is permanently powered separately from =
the
> > > processor, there is a window where a reset of the CPU leaves the IMU =
in
> > > the shub register page. Once this occurs, any subsequent probe attempt
> > > fails because of the register shadowing.
> >=20
> > Hi Andreas,
> >=20
>=20
> Hello Lorenzo,
>=20
> > can you please provide more details about how this issue can occur?
>=20
> In our specific case, we have gotten field returns that we can see are
> caused by our ism330dlc being stuck with its register file switched to
> the shub one. This causes the driver to permanently fail to probe.
>=20
> The IMU is permanently powered because we need to use it as a wakeup
> source.
>=20
> We don't have definitive proof, but we think this has been caused by
> either our watchdog biting or the CPU browning out while the init
> sequence has the shub file selected. When Linux comes back up, the
> current driver implementation can't handle it.

If we have this issue, are you sure all the other functionalities are worki=
ng
properly?

>=20
> > Is it enough, if the shub is available, to just always run
> > st_lsm6dsx_set_page(, false) before checking the whoami?
> >=20
>=20
> I think that should be fine, yes. I only added the readout to lessen
> the risk of unnecessary writes to potentially unknown devices.

I guess you just need to check the shub is supported, then it is fine to
disable shub register access at that point (it is supposed to be that way).

Regards,
Lorenzo

>=20
> Best regards,
> Andreas Kempe
>=20
> > Regards,
> > Lorenzo
> >=20
> > >=20
> > > Using the ism330dlc, the error typically looks like
> > >=20
> > > 	st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
> > >=20
> > > with the unknown whoami read from a reserved register in the shub pag=
e.
> > >=20
> > > The reset register is also shadowed by the page select, preventing a
> > > simple reset from recovering the chip.
> > >=20
> > > Add a readout of the shub register page selection and deselect the pa=
ge
> > > if needed before reading whoami. This allows the driver to recover and
> > > probe correctly.
> > >=20
> > > Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> > > ---
> > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 ++++++++++++++++++=
+-
> > >  1 file changed, 41 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/i=
io/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > index 630e2cae6f19..6fef99f2e9f1 100644
> > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > @@ -1692,10 +1692,27 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw =
*hw, bool enable)
> > >  	return err;
> > >  }
> > > =20
> > > +static int st_lsm6dsx_get_page(struct st_lsm6dsx_hw *hw, bool *enabl=
e)
> > > +{
> > > +	const struct st_lsm6dsx_shub_settings *hub_settings;
> > > +	unsigned int data;
> > > +	int err;
> > > +
> > > +	hub_settings =3D &hw->settings->shub_settings;
> > > +	err =3D regmap_read(hw->regmap, hub_settings->page_mux.addr, &data);
> > > +	if (err < 0)
> > > +		return err;
> > > +
> > > +	*enable =3D data & hub_settings->page_mux.mask;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> > >  				   const char **name)
> > >  {
> > >  	int err, i, j, data;
> > > +	bool enable;
> > > =20
> > >  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> > >  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > > @@ -1712,6 +1729,30 @@ static int st_lsm6dsx_check_whoami(struct st_l=
sm6dsx_hw *hw, int id,
> > >  		return -ENODEV;
> > >  	}
> > > =20
> > > +	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > > +
> > > +	if (hw->settings->shub_settings.page_mux.addr) {
> > > +		/*
> > > +		 * whoami is not available in the shub register page.
> > > +		 * Deselect the shub page if needed so whoami can be
> > > +		 * correctly read.
> > > +		 */
> > > +		err =3D st_lsm6dsx_get_page(hw, &enable);
> > > +		if (err < 0) {
> > > +			dev_err(hw->dev, "failed to get shub page\n");
> > > +			return err;
> > > +		}
> > > +
> > > +		if (enable) {
> > > +			dev_warn(hw->dev, "shub page selected; clearing it\n");
> > > +			err =3D st_lsm6dsx_set_page(hw, false);
> > > +			if (err < 0) {
> > > +				dev_err(hw->dev, "failed to clear shub page\n");
> > > +				return err;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > >  	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> > >  	if (err < 0) {
> > >  		dev_err(hw->dev, "failed to read whoami register\n");
> > > @@ -1724,7 +1765,6 @@ static int st_lsm6dsx_check_whoami(struct st_ls=
m6dsx_hw *hw, int id,
> > >  	}
> > > =20
> > >  	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> > > -	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > > =20
> > >  	return 0;
> > >  }
> > > --=20
> > > 2.53.0
>=20
>=20

--Xd+h65mR+BPvoK+x
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCaiGNeAAKCRA6cBh0uS2t
rNNbAQCEXgYr67SCKl++mE9xjxITTlKYYY/PwLlk/Bhkru5hXAEA4gO8wi2N9bP+
m64JMGtq4thKDMHU7zE12+hOAuD/wAU=
=uQjc
-----END PGP SIGNATURE-----

--Xd+h65mR+BPvoK+x--
