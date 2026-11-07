Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794081073;
	b=Npscb7BJW5T79xvY6kOu3Us8gHHiyyZr0qvuQIQAKPfVq+HV2LzvcaUe9CtQ3TA9VFvM
	 R19R1ifiXN0fcJdUUq/zylYY4A7WB9l4CLHkUDGeNOpwarnQdSNIoVAA7/gQZ9pFGqPSt
	 nCFtj4sTQEDHrzUbEozssGxR3EcOU+mft4s2ImvzQa8K6VeJf7xDoj5yx29J/1Juxh/I1
	 kECRLv/rgB25f3kbumR/YQsGnzo9LNIPdeSvCvg5gq2uV+dRikCZ+HNQKS0sAjxxFCefV
	 1tTVPyEEx7ZfCiCWZcLxLy6Tk9M4nFWrAi0lPow/1MSMxfshsjo9I99epnkHN/EcLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794081073;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=UDvmCQ2Mp69rlItAe1Pmra1hYt7TLJHyH49CzxuAoNg=;
	b=4g7iIiAMh9iP0yv51MIQQwo4lUusZQCVt6UUMuELAGU749zlutUvYoei0E79MIP/tcyf
	 Vo7nc1dLLSHGkBLupVjnRBkQaro2wl6sQWtJl+sDgSzmifchJRUHhF4E7c9FP0J3VVtn9
	 VJR6H3V6VkxrIDTsDjUNbQUG7/7Swmv0EUcjPiiu01i1k2XWPkWHCixge1qow5hxn4pl8
	 c7u5hdaLjVN0SgjTbhNhoWnCBiOcKFsiXO+6/CuJxEqMDoNxyJ8UP8Z1rGUc6ehBtRf/+
	 V9CvVJGRdCo5lg/j5pmSYXGvvdZwwkC8pF549I43hwma0gOFHIhRuTgpV8CW4auZntA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFnq4xRl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E42606A326;
	Sat,  7 Nov 2026 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QFnq4xRl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7AC1F0089F;
	Sat,  7 Nov 2026 19:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794081072;
	bh=UDvmCQ2Mp69rlItAe1Pmra1hYt7TLJHyH49CzxuAoNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QFnq4xRl1G5WyrZCAjnknG2tv8gfOJOniu/+HzgE/oGpcULtQDvntr6WfO8n04zh8
	 5XPCCEubaA5PWspB8WTA0hnzF2klzF8ImvaeueVpg4+rDr6HoV+6A9J/QW/rX4nfZ0
	 6zzIJl4VlYj1pY5fPC4aCynFHu9T5Gd2CxrrzsNP4bBKay2NFIwp49u6USh9q5g0uG
	 t+f1EXW6lb8A2VaGQLjudW7Un/tRbcC/O2C6YKZeX6scTvkD7v6zk2XmOPLFvn0HSk
	 OjnDRq93NJ4zg9AQc0hSCxlDA3mwPV4sFFhMd10gRcV5orA8hUxMk4fFq0pvEN+wy8
	 sXbKofz2xGdxA==
Date: Sat, 7 Nov 2026 19:51:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Esben Haabendal <esben@geanix.com>, Kuppuswamy
 Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, "Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The Capable Hub)"
 <u.kleine-koenig@baylibre.com>, Pan Chuang <panchuang@vivo.com>, Hemanth
 Selam <hemanth.selam@gmail.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Nikita Travkin <nikita@trvn.ru>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: light: ltr501: Switch to modern match
 mechanism
Message-ID: <20261107195107.56d0b766@jic23-hlaptop>
In-Reply-To: <CAPVz0n250nXs5A4BDY-sXW=eBLAzSn2x9CA-Zf692x6La3rFBg@mail.gmail.com>
References: <20261106091943.35783-1-clamor95@gmail.com>
	<20261106091943.35783-3-clamor95@gmail.com>
	<20261107033029.0b2d3ee1@jic23-hlaptop>
	<CAPVz0n250nXs5A4BDY-sXW=eBLAzSn2x9CA-Zf692x6La3rFBg@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Nov 2026 12:13:44 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D0=B1, 7 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 05:=
30 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri,  6 Nov 2026 11:19:41 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > Remove the chip enum, break the chip list structure into individual
> > > elements, and pass each element using i2c_get_match_data(). =20
> >
> > Sashiko calls out that for ACPI this results in an ABI change.
> > The original code did the ABI wrong but that unfortunately doesn't
> > mean we can change this one as it is an artefact of a time when
> > we weren't so careful about those names.
> >
> > So you'll need to put special handling back in for the ACPI parts
> > and that name. Some other things in the existing code noted inline
> > that would be nice to clean up whilst you are here.
> > =20
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/ltr501.c | 165 +++++++++++++++++------------------=
--
> > >  1 file changed, 74 insertions(+), 91 deletions(-)
> > >
> > > diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
> > > index cc5d7af44d77c..d5ce6468a229b 100644
> > > --- a/drivers/iio/light/ltr501.c
> > > +++ b/drivers/iio/light/ltr501.c =20
> > =20
> > > +static const struct ltr501_chip_info ltr301_chip_info_tbl =3D {
> > > +     .partid =3D 0x08,
> > > +     .als_gain =3D ltr501_als_gain_tbl,
> > > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr501_als_gain_tbl),
> > > +     .als_mode_active =3D BIT(0) | BIT(1),
> > > +     .als_gain_mask =3D BIT(3),
> > > +     .als_gain_shift =3D 3,
> > > +     .channels =3D ltr301_channels,
> > > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > > +};
> > > +
> > > +static const struct ltr501_chip_info ltr303_chip_info_tbl =3D {
> > > +     .partid =3D 0x0A,
> > > +     .als_gain =3D ltr559_als_gain_tbl,
> > > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > > +     .als_mode_active =3D BIT(0),
> > > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4),
> > > +     .als_gain_shift =3D 2,
> > > +     .channels =3D ltr301_channels,
> > > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > > +};
> > > +
> > > +static const struct ltr501_chip_info ltr329_chip_info_tbl =3D {
> > > +     .partid =3D 0x0A,
> > > +     .als_gain =3D ltr559_als_gain_tbl,
> > > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > > +     .als_mode_active =3D BIT(0),
> > > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4), =20
> >
> > As below.  Same for all the others.  That would be a separate
> > cleanup patch though -> perhaps do it with getting rid of
> > the als_gain_shift.
> > =20
>=20
> This is all out of scope of my series. I am not a code janitor!

It is common practice to ask anyone who is modifying the code to
tidy up inconsistencies, modernise and make minor general improvements.
If nothing else, if someone else makes those improvements within
a short window of you working on the driver I'm going ask you to
test them anyway.

I very rarely make a request for major refactoring because that
burden is unreasonable. This would fall under the scope of what
I'd normally consider reasonable.

Leaving that cleanup for future is fine. Just state that in
you have chosen to do so in the cover letter for the next version.

>=20
> > > +     .als_gain_shift =3D 2,
> > > +     .no_irq_support =3D true,
> > > +     .channels =3D ltr301_channels,
> > > +     .no_channels =3D ARRAY_SIZE(ltr301_channels),
> > > +};
> > > +
> > > +static const struct ltr501_chip_info ltr501_chip_info_tbl =3D {
> > > +     .partid =3D 0x08,
> > > +     .als_gain =3D ltr501_als_gain_tbl,
> > > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr501_als_gain_tbl),
> > > +     .ps_gain =3D ltr501_ps_gain_tbl,
> > > +     .ps_gain_tbl_size =3D ARRAY_SIZE(ltr501_ps_gain_tbl),
> > > +     .als_mode_active =3D BIT(0) | BIT(1), =20
> > As below =20
> > > +     .als_gain_mask =3D BIT(3),
> > > +     .als_gain_shift =3D 3,
> > > +     .channels =3D ltr501_channels,
> > > +     .no_channels =3D ARRAY_SIZE(ltr501_channels),
> > > +};
> > > +
> > > +static const struct ltr501_chip_info ltr559_chip_info_tbl =3D {
> > > +     .partid =3D 0x09,
> > > +     .als_gain =3D ltr559_als_gain_tbl,
> > > +     .als_gain_tbl_size =3D ARRAY_SIZE(ltr559_als_gain_tbl),
> > > +     .ps_gain =3D ltr559_ps_gain_tbl,
> > > +     .ps_gain_tbl_size =3D ARRAY_SIZE(ltr559_ps_gain_tbl),
> > > +     .als_mode_active =3D BIT(0),
> > > +     .als_gain_mask =3D BIT(2) | BIT(3) | BIT(4), =20
> > Is it really 3 separate bits, or GENMASK(4, 2) to
> > represent a 3 bit shift?
> >
> > Whilst you are touching the driver can we get rid of the
> > separate shift by using field_prep() field_get() using
> > just the mask?
> > =20
> > > +     .als_gain_shift =3D 2,
> > > +     .channels =3D ltr501_channels,
> > > +     .no_channels =3D ARRAY_SIZE(ltr501_channels),
> > >  };
> > >
> > >  static int ltr501_write_contr(struct ltr501_data *data, u8 als_val, =
u8 ps_val)
> > > @@ -1393,14 +1387,11 @@ static int ltr501_powerdown(struct ltr501_dat=
a *data)
> > >
> > >  static int ltr501_probe(struct i2c_client *client)
> > >  {
> > > -     const struct i2c_device_id *id =3D i2c_client_get_device_id(cli=
ent);
> > >       static const char * const regulator_names[] =3D { "vdd", "vddio=
" };
> > >       struct ltr501_data *data;
> > >       struct iio_dev *indio_dev;
> > >       struct regmap *regmap;
> > > -     const void *ddata =3D NULL;
> > > -     int partid, chip_idx;
> > > -     const char *name;
> > > +     int partid;
> > >       int ret;
> > >
> > >       indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*data)=
);
> > > @@ -1480,18 +1471,10 @@ static int ltr501_probe(struct i2c_client *cl=
ient)
> > >       if (ret < 0)
> > >               return ret;
> > >
> > > -     if (id) {
> > > -             name =3D id->name;
> > > -             chip_idx =3D id->driver_data;
> > > -     } else {
> > > -             name =3D iio_get_acpi_device_name_and_data(&client->dev=
, &ddata);
> > > -             chip_idx =3D (intptr_t)ddata;
> > > -     }
> > > -     if (!name)
> > > +     data->chip_info =3D i2c_get_match_data(client);
> > > +     if (!data->chip_info)
> > >               return -ENODEV; =20
> >
> > As above. Unfortunately at this point we'll still need to
> > do some special handling to match the existing indio_dev->name.
> > =20
>=20
> const struct i2c_device_id *id =3D i2c_client_get_device_id(client);
>=20
> ...
>=20
> indio_dev->name =3D id ? id->name :
> iio_get_acpi_device_name_and_data(&client->dev, NULL);
>=20
> Will this be acceptible?

Yes. I think that should work.

