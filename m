Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072C5339861;
	Thu,  4 Jun 2026 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780586957; cv=none; b=phN7Y2+JiPzK2cTHHfjZx3EXmjtH7d7JjfJWMgjnRyHzswEi/MFjJ7dp2aNGdRfUf/uuUfYcC7gKASqpJeHqhT875OnyLx5ec3VdKh4zgj3Pl5h2Ct0azGxnr0xkkGImzCTbzkbqu+MUGfGT9Bi98kUxm5udIQwS0g0mFrjpRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780586957; c=relaxed/simple;
	bh=FhmfDmse2gIXlMJZ/5YGocYcI6VLSMZTbC0Gx1/kpTs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ms+HPwDi0kGlgGMveXUzV8VBO+VTBj9WeGIQDA9fRA7wjox46EH9PWn019HwU4IWUZZhgpWfbPlOYL7S/ZGupySglNryj+CMS4ppKc3WBqx03VtfKhSABZtyUpKm1TGy8p9H3h9E0ss/uZ2OrcLivvviLjeuwpjNFuoOuoee+lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.61; Thu, 4 Jun
 2026 17:29:12 +0200
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%3]) with mapi id
 15.01.2507.061; Thu, 4 Jun 2026 17:29:12 +0200
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
Thread-Index: AQHc9CXmt5PDPY90VUWMABLjTdSxxbYuTrCAgAADbYCAAAMsAIAADqyA
Date: Thu, 4 Jun 2026 15:29:12 +0000
Message-ID: <aiGZxzz8DF-E-tux@w570anl.actianordic.se>
References: <20260604132646.1099072-1-andreas.kempe@actia.se>
 <aiGH7x531jwzOVxF@lore-desk> <aiGKz9iMAUfFqxUP@w570anl.actianordic.se>
 <aiGNeKTzOR30w-Qf@lore-desk>
In-Reply-To: <aiGNeKTzOR30w-Qf@lore-desk>
Accept-Language: sv-SE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2956B1445F637764
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <153588CDE773704A85D190A0544B37C2@actia.se>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, Jun 04, 2026 at 04:36:40PM +0200, Lorenzo Bianconi wrote:
> CAUTION: This email originated from outside of the organization. Do not c=
lick links or open attachments unless you recognize the sender and know the=
 content is safe.
>=20

> Date: Thu, 4 Jun 2026 16:36:40 +0200
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
> > On Thu, Jun 04, 2026 at 04:13:03PM +0200, Lorenzo Bianconi wrote:
> > > CAUTION: This email originated from outside of the organization. Do n=
ot click links or open attachments unless you recognize the sender and know=
 the content is safe.
> > >=20
> >=20
> > > Date: Thu, 4 Jun 2026 16:13:03 +0200
> > > From: Lorenzo Bianconi <lorenzo@kernel.org>
> > > To: Andreas Kempe <andreas.kempe@actia.se>
> > > Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
> > >  <dlechner@baylibre.com>, Nuno S=E1 <nuno.sa@analog.com>, Andy Shevch=
enko
> > >  <andy@kernel.org>, "linux-iio@vger.kernel.org"
> > >  <linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
> > >  <linux-kernel@vger.kernel.org>, John Ernberg <john.ernberg@actia.se>
> > > Subject: Re: [PATCH] iio: imu: st_lsm6dsx: deselect shub page before
> > >  reading whoami
> > >=20
> > > > As part of driver initialisation, e.g. st_lsm6dsx_init_shub() selec=
ts
> > > > the shub register page using st_lsm6dsx_set_page(). Selecting the s=
hub
> > > > register page shadows the regular register space so whoami, among o=
ther
> > > > registers, is no longer accessible.
> > > >=20
> > > > In applications where the IMU is permanently powered separately fro=
m the
> > > > processor, there is a window where a reset of the CPU leaves the IM=
U in
> > > > the shub register page. Once this occurs, any subsequent probe atte=
mpt
> > > > fails because of the register shadowing.
> > >=20
> > > Hi Andreas,
> > >=20
> >=20
> > Hello Lorenzo,
> >=20
> > > can you please provide more details about how this issue can occur?
> >=20
> > In our specific case, we have gotten field returns that we can see are
> > caused by our ism330dlc being stuck with its register file switched to
> > the shub one. This causes the driver to permanently fail to probe.
> >=20
> > The IMU is permanently powered because we need to use it as a wakeup
> > source.
> >=20
> > We don't have definitive proof, but we think this has been caused by
> > either our watchdog biting or the CPU browning out while the init
> > sequence has the shub file selected. When Linux comes back up, the
> > current driver implementation can't handle it.
>=20
> If we have this issue, are you sure all the other functionalities are wor=
king
> properly?
>=20

I'm not entirely sure what you mean by other functionalities so I'm
giving you a rundown of our analysis. If you need something else/more,
please feel free to clarify.

We got a field return where the IMU was reporting whoami 10 as per the
log in the commit message of the patch. We read out a number of
registers from the IMU.

Register=3Dvalue
0x01=3D0x80
0x0f=3D0x10
0x10=3D0x7a
0x11=3D0x69
0x12=3D0x32
0x13=3D0x06

0x80 in register 0x1 indicates that the shub register file is
selected. 0x0f is the whoami returning 0x10, the same value the error
log gave.

Unfortunately, we power cycled the entire system after this so we
didn't test just changing the register file. After the power cycle,
the IMU was back to full functionality as far as we can tell with the
self-test sequence from the data sheet passing and human inspection of
returned values looking correct.

If we reproduce the symptoms by unbinding the IMU from the driver and
manually select the shub using i2cset, we get an identical readout
from the chip and behaviour of the driver as when the chip was in the
fault condition. With my patch, the driver recovers and everything
goes back to normal.

I apologise that I can't test my patch on a real malfunctioning board
as they, luckily, are few and far between.

> >=20
> > > Is it enough, if the shub is available, to just always run
> > > st_lsm6dsx_set_page(, false) before checking the whoami?
> > >=20
> >=20
> > I think that should be fine, yes. I only added the readout to lessen
> > the risk of unnecessary writes to potentially unknown devices.
>=20
> I guess you just need to check the shub is supported, then it is fine to
> disable shub register access at that point (it is supposed to be that way=
).
>=20

You are thinking of gating st_lsm6dsx_set_page() on
shub_settings.page_mux.addr like I do, but without the read? Or do you
want to gate on something else?

I'm willing to submit a v2 if you want it.


Best regards,
Andreas Kempe

> > >=20
> > > >=20
> > > > Using the ism330dlc, the error typically looks like
> > > >=20
> > > > 	st_lsm6dsx_i2c 3-006a: unsupported whoami [10]
> > > >=20
> > > > with the unknown whoami read from a reserved register in the shub p=
age.
> > > >=20
> > > > The reset register is also shadowed by the page select, preventing =
a
> > > > simple reset from recovering the chip.
> > > >=20
> > > > Add a readout of the shub register page selection and deselect the =
page
> > > > if needed before reading whoami. This allows the driver to recover =
and
> > > > probe correctly.
> > > >=20
> > > > Signed-off-by: Andreas Kempe <andreas.kempe@actia.se>
> > > > ---
> > > >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 42 ++++++++++++++++=
+++-
> > > >  1 file changed, 41 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers=
/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > index 630e2cae6f19..6fef99f2e9f1 100644
> > > > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > > > @@ -1692,10 +1692,27 @@ int st_lsm6dsx_set_page(struct st_lsm6dsx_h=
w *hw, bool enable)
> > > >  	return err;
> > > >  }
> > > > =20
> > > > +static int st_lsm6dsx_get_page(struct st_lsm6dsx_hw *hw, bool *ena=
ble)
> > > > +{
> > > > +	const struct st_lsm6dsx_shub_settings *hub_settings;
> > > > +	unsigned int data;
> > > > +	int err;
> > > > +
> > > > +	hub_settings =3D &hw->settings->shub_settings;
> > > > +	err =3D regmap_read(hw->regmap, hub_settings->page_mux.addr, &dat=
a);
> > > > +	if (err < 0)
> > > > +		return err;
> > > > +
> > > > +	*enable =3D data & hub_settings->page_mux.mask;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int st_lsm6dsx_check_whoami(struct st_lsm6dsx_hw *hw, int i=
d,
> > > >  				   const char **name)
> > > >  {
> > > >  	int err, i, j, data;
> > > > +	bool enable;
> > > > =20
> > > >  	for (i =3D 0; i < ARRAY_SIZE(st_lsm6dsx_sensor_settings); i++) {
> > > >  		for (j =3D 0; j < ST_LSM6DSX_MAX_ID; j++) {
> > > > @@ -1712,6 +1729,30 @@ static int st_lsm6dsx_check_whoami(struct st=
_lsm6dsx_hw *hw, int id,
> > > >  		return -ENODEV;
> > > >  	}
> > > > =20
> > > > +	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > > > +
> > > > +	if (hw->settings->shub_settings.page_mux.addr) {
> > > > +		/*
> > > > +		 * whoami is not available in the shub register page.
> > > > +		 * Deselect the shub page if needed so whoami can be
> > > > +		 * correctly read.
> > > > +		 */
> > > > +		err =3D st_lsm6dsx_get_page(hw, &enable);
> > > > +		if (err < 0) {
> > > > +			dev_err(hw->dev, "failed to get shub page\n");
> > > > +			return err;
> > > > +		}
> > > > +
> > > > +		if (enable) {
> > > > +			dev_warn(hw->dev, "shub page selected; clearing it\n");
> > > > +			err =3D st_lsm6dsx_set_page(hw, false);
> > > > +			if (err < 0) {
> > > > +				dev_err(hw->dev, "failed to clear shub page\n");
> > > > +				return err;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +
> > > >  	err =3D regmap_read(hw->regmap, ST_LSM6DSX_REG_WHOAMI_ADDR, &data=
);
> > > >  	if (err < 0) {
> > > >  		dev_err(hw->dev, "failed to read whoami register\n");
> > > > @@ -1724,7 +1765,6 @@ static int st_lsm6dsx_check_whoami(struct st_=
lsm6dsx_hw *hw, int id,
> > > >  	}
> > > > =20
> > > >  	*name =3D st_lsm6dsx_sensor_settings[i].id[j].name;
> > > > -	hw->settings =3D &st_lsm6dsx_sensor_settings[i];
> > > > =20
> > > >  	return 0;
> > > >  }
> > > > --=20
> > > > 2.53.0
> >=20
> >=20


