Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3F3220687;
	Thu,  4 Jun 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780583125; cv=none; b=P6oQiquWJfW71W80z/HBip1q0twTw5dSmLoX5B1MumQtjqRJjcN7CfHSdDQ3NthJXDa6rTRS6atPQJH/ey77xRfhDZCcKIQDFTbhKpVVNHYHT/+YVNv5doG0oVTW2AxoVtHaYu1Yz/HFBQEtszpvIonCNBskt/vK0E0rQZQ4kLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780583125; c=relaxed/simple;
	bh=O3O1B7rePUYuioYduE7/04lgvS131PjRiDu9E8dfXQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YFT9ktAAXZxJh90nfYzmjjn+3ERD8swXQxRBSXfUoVrGph71k0DgQ7T7TEtN3QP69aNwYCSOv+6JWrXVbf5cjTeREG6N9DclK9+PXwijIM9Hk0A6NgwczzfKHABJffzg/hELPKLYTxUK44LzXjR9MRKbS8zoIMh3L37J12B8kAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 4 Jun
 2026 16:25:20 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Thu, 4 Jun 2026 16:25:20 +0200
From: Andreas Kempe <andreas.kempe@actia.se>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?iso-8859-1?Q?Nuno_S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Topic: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before reading
 whoami
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxbYuTrCAgAADbYA=
Date: Thu, 4 Jun 2026 14:25:20 +0000
Message-ID: <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk>
In-Reply-To: <aiGH7x531jwzOVxF@lore-desk>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445F637766
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <DAB2C72A7DC93B44B9AC48238009D27E@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Jun 04, 2026 at 04:13:03PM +0200, Lorenzo Bianconi wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20

> Date: Thu, 4 Jun 2026 16:13:03 +0200
> From: Lorenzo Bianconi <lorenzo@kernel.org>
> To: Andreas Kempe <andreas.kempe@actia.se>
> Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
>  <dlechner@baylibre.com>, Nuno S=E1 <nuno.sa@analog.com>, Andy Shevchenko
>  <andy@kernel.org>, "linux-iio@vger.kernel.org"
>  <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
>  <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
> Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before
>  reading whoami
>=20
> > As part of driver initialisation, e.g. st_lsm6dsx_init_shub() selects
> > the shub register page using st_lsm6dsx_set_page(). Selecting the shub
> > register page shadows the regular register space so whoami, among other
> > registers, is no longer accessible.
> >=20
> > In applications where the IMU is permanently powered separately from th=
e
> > processor, there is a window where a reset of the CPU leaves the IMU in
> > the shub register page. Once this occurs, any subsequent probe attempt
> > fails because of the register shadowing.
>=20
> Hi Andreas,
>=20

Hello Lorenzo,

> can you please provide more details about how this issue can occur?

In our specific case, we have gotten field returns that we can see are
caused by our ism330dlc being stuck with its register file switched to
the shub one. This causes the driver to permanently fail to probe.

The IMU is permanently powered because we need to use it as a wakeup
source.

We don't have definitive proof, but we think this has been caused by
either our watchdog biting or the CPU browning out while the init
sequence has the shub file selected. When Linux comes back up, the
current driver implementation can't handle it.

> Is it enough, if the shub is available, to just always run
> st_lsm6dsx_set_page(, false) before checking the whoami?
>=20

I think that should be fine, yes. I only added the readout to lessen
the risk of unnecessary writes to potentially unknown devices.

Best regards,
Andreas Kempe

> Regards,
> Lorenzo
>=20
> >=20
> > Using the ism330dlc, the error typically looks like
> >=20
> > 	st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
> >=20
> > with the unknown whoami read from a reserved register in the shub page.
> >=20
> > The reset register is also shadowed by the page select, preventing a
> > simple reset from recovering the chip.
> >=20
> > Add a readout of the shub register page selection and deselect the page
> > if needed before reading whoami. This allows the driver to recover and
> > probe correctly.
> >=20
> > Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 +++++++++++++++++++-
> >  1 file changed, 41 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 630e2cae6f19..6fef99f2e9f1 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -1692,10 +1692,27 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_hw *h=
w, bool enable)
> >  	return err;
> >  }
> > =20
> > +static int st_lsm6dsx_get_page(struct st_lsm6dsx_hw *hw, bool *enable)
> > +{
> > +	const struct st_lsm6dsx_shub_settings *hub_settings;
> > +	unsigned int data;
> > +	int err;
> > +
> > +	hub_settings =3D &hw->settings->shub_settings;
> > +	err =3D regmap_read(hw->regmap, hub_settings->page_mux.addr, &data);
> > +	if (err < 0)
> > +		return err;
> > +
> > +	*enable =3D data & hub_settings->page_mux.mask;
> > +
> > +	return 0;
> > +}
> > +
> >  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int id,
> >  				   const char **name)
> >  {
> >  	int err, i, j, data;
> > +	bool enable;
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> >  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > @@ -1712,6 +1729,30 @@ static int st_lsm6dsx_check_whoami(struct st_lsm=
6dsx_hw *hw, int id,
> >  		return -ENODEV;
> >  	}
> > =20
> > +	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > +
> > +	if (hw->settings->shub_settings.page_mux.addr) {
> > +		/*
> > +		 * whoami is not available in the shub register page.
> > +		 * Deselect the shub page if needed so whoami can be
> > +		 * correctly read.
> > +		 */
> > +		err =3D st_lsm6dsx_get_page(hw, &enable);
> > +		if (err < 0) {
> > +			dev_err(hw->dev, "failed to get shub page\n");
> > +			return err;
> > +		}
> > +
> > +		if (enable) {
> > +			dev_warn(hw->dev, "shub page selected; clearing it\n");
> > +			err =3D st_lsm6dsx_set_page(hw, false);
> > +			if (err < 0) {
> > +				dev_err(hw->dev, "failed to clear shub page\n");
> > +				return err;
> > +			}
> > +		}
> > +	}
> > +
> >  	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data);
> >  	if (err < 0) {
> >  		dev_err(hw->dev, "failed to read whoami register\n");
> > @@ -1724,7 +1765,6 @@ static int st_lsm6dsx_check_whoami(struct st_lsm6=
dsx_hw *hw, int id,
> >  	}
> > =20
> >  	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> > -	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > =20
> >  	return 0;
> >  }
> > --=20
> > 2.53.0


