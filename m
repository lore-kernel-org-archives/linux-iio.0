Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6214311C2A;
	Thu, 23 Jul 2026 23:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784848541; cv=none; b=RfmwEXiEYKnVP2EQFmmT6PDaATDszLPY6qPt5MP3VN/z5v6KlXkmPrrFTP4VACT6Bh66zBnmLTnBolHvmqQiweJKET50eoRXlwmG0RoC9DORG1JMUTBHWkzZl9fOHF6b8Ldfzkst5Irqlwklm9nh6vHS5I3Qess4EPEqDg2uHSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784848541; c=relaxed/simple;
	bh=byqjKbVkLIvqDk6HOYLYZazYe4VJ8u+SNghPk6AXupE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zv2k+4HjZJ5TpQFlYAnQL9/f8yjQZxYLJg70G1ECN6nTYx6Ct4a/GVygYyC2RaNMpfYVsYQPZh//qikTAPT+/KoM5LmXH3LLfYxrYmZYY9fr40t+WboPg1G1vS4bmmGaqdURQ5wC0oGmmhtUThNMeZuo3Ry07AjFMWUw+0VUJf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0vIRSI4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0vIRSI4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7654D1F000E9;
	Thu, 23 Jul 2026 23:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784848540;
	bh=yFszR+aoiyfsqBGg5FluY44HniJLCj3pYOcguVsSajE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=d0vIRSI4UckEKljXRVTQyYQQEPewZ0fcFxotGaOgpq+7qKFDqXB37RCmMPfl9tPz3
	 +fW/ZzA0EgYgbNVyjolcmNIfW9XZVu4EzW08Qoj9lgoJAIdjDkV0TOWjq+btM0yupb
	 Mslvf10ELmmL5YsYmlfL3GDegyj4dkufbIPAQ81m8HUL0T0G0l+enQqjBqsAsudT5q
	 oKvJhU/lixlndcj+aBiVsXFee+2pShQy34wAt/EJ09hyS68U0l+DwXuYfo53+5tSlQ
	 VKz2RqBUTzMkZFjRdoZ8rnorkY+wK5Tk7OJnCTOyckbJ2CI4yXCTHRodmg+iQKXpN5
	 +lf2p2aDjj9Tw==
Date: Fri, 24 Jul 2026 00:15:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
 andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com, Chris
 Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH v16 04/10] iio: imu: inv_icm42607: Add inv_icm42607 Core
 Driver
Message-ID: <20260724001535.5991853b@jic23-huawei>
In-Reply-To: <alYoUSf_jGegFP9E@monoceros>
References: <20260713215842.69097-1-macroalpha82@gmail.com>
	<20260713215842.69097-5-macroalpha82@gmail.com>
	<alYoUSf_jGegFP9E@monoceros>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 14 Jul 2026 14:18:53 +0200
Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> wrote:

> Hello,
>=20
> On Mon, Jul 13, 2026 at 04:58:34PM -0500, Chris Morgan wrote:
> > +#include <linux/i2c.h>
> > +#include <linux/mod_devicetable.h> =20
>=20
> Please don't use <linux/mod_devicetable.h>, to get i2c_device_id and
> of_device_id it's enough to have <linux/i2c.h>.
>=20
> > +static const struct i2c_device_id inv_icm42607_id[] =3D {
> > +	{
> > +		.name =3D "icm42607",
> > +		.driver_data =3D (kernel_ulong_t)&inv_icm42607_hw_data,
> > +	}, {
> > +		.name =3D "icm42607p",
> > +		.driver_data =3D (kernel_ulong_t)&inv_icm42607p_hw_data,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
> > +
> > +static const struct of_device_id inv_icm42607_of_matches[] =3D {
> > +	{
> > +		.compatible =3D "invensense,icm42607",
> > +		.data =3D &inv_icm42607_hw_data,
> > +	}, {
> > +		.compatible =3D "invensense,icm42607p",
> > +		.data =3D &inv_icm42607p_hw_data,
> > +	},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches); =20
>=20
> It would be enough to provide the driver_data pointers in the
> i2c_device_id array only.
I'd prefer to keep them in both.

The match function tries the of_device_id path first and if we
should ever get a typo or mismatch we can end up with a driver
failing in a way that is annoyingly hard to track down. =20
It has happened :(  Now I'd love us to get to the point
where we could just have the of_device_id table (and maybe
ACPI on occasion) but we aren't there today.

This came up in v17 where I asked why they were missing and Chris
mentioned it would be fine to drop them.

Jonathan

>=20
> Best regards
> Uwe

