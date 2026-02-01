Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4302426B2D2
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 17:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769966665; cv=none; b=rUn2wktwNZHkdW36a6nZ6sfXne/YjgBQk0psyNa4By7SAZ/BbOFpIdA3yQE+UUeQQR/Fx/UW390DE69sQ7YHoLGS738ImUQ1EZdKT8c/Yy508/vAHuddjAygKD4zBVrXZCW8FhisQOsXam68AnOSV5LXr1Z62/XFg++ZxnFt5/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769966665; c=relaxed/simple;
	bh=zh8WZ4F4gEJQZ41bjYhvfck2CjOJ3lRui3sd8j3hWWU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sb5RD2Kvc77cvStENJOx7pfvMhrVjM2MmgE9H4qLSeMheqBR5YEP9wDbLWlgL3KsNkxZaY/zDD+/8baQO1x3UuKKzz6zmdfPT1uSwDiWnKqXKO5Azr5lRn0r+hafYFx2YjDwOpoX63wclUeVzKSRMfKWkrBpspdxRybZ17Pg0UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=2daN+YOP; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="2daN+YOP"
Received: from [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8] (2a02-1812-162c-8f00-1e2d-b404-3319-eba8.ip6.access.telenet.be [IPv6:2a02:1812:162c:8f00:1e2d:b404:3319:eba8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id D6FB86D6A5C;
	Sun,  1 Feb 2026 18:24:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1769966661;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwTuiAwTBrsK+zpHa/TsYbtRzFGXAvdbwG3p6lnTSAg=;
	b=2daN+YOPoS6skjfl+V0IB/BaYRVAq1bMBwCHU+jUP2R1WvrvzWEky5xYQA4KvGyiGS9jEp
	yTtLdFQBrt6GQi46xGA7jJeuON21RmMwj+txmjgRn+jWKxoa1+7p1xIfohh98asYTIhky+
	0fflzJO08bToOIbxfc+HUeyDzZbroTQ6nwBf3+3HTlLIkg/WRG7kv6JlOPFDBVIob4KjV8
	yN6Ob+1zuGOx8n9iSgZflllYYNgmWYbDEODaPpx48t5fPKxfX9pgDeoLq2DYzoZiukH3Qn
	E+nxhP2qjI9cB5aukhOYPUydDpCWharWvg1IqzpBMp2EwWIyeyn5Ovdmu6c8ww==
Message-ID: <abeabd28e8ed4cfdfdf12e9c59cdbdc545c00e42.camel@svanheule.net>
Subject: Re: [PATCH v2 5/8] iio: dac: ds4424: convert to regmap
From: Sander Vanheule <sander@svanheule.net>
To: Oleksij Rempel <o.rempel@pengutronix.de>, Andy Shevchenko
 <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, kernel@pengutronix.de, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=	 <nuno.sa@analog.com>, David Jander
 <david@protonic.nl>
Date: Sun, 01 Feb 2026 18:24:19 +0100
In-Reply-To: <aX98dbnCcFnFY3ks@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
	 <20260127060939.3914006-6-o.rempel@pengutronix.de>
	 <2cfd142fbaad3ddd3b3fb632c77a4e9f58d50f66.camel@svanheule.net>
	 <aX98dbnCcFnFY3ks@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Oleksij,

Thanks for the quick reply!

On Sun, 2026-02-01 at 17:16 +0100, Oleksij Rempel wrote:
> Hi Sander,
>=20
> On Sun, Feb 01, 2026 at 03:42:28PM +0100, Sander Vanheule wrote:
> > Hi Oleksij,
> >=20
> > On Tue, 2026-01-27 at 07:09 +0100, Oleksij Rempel wrote:
> > > +static const struct regmap_access_table ds44x4_table =3D {
> > > + .yes_ranges =3D ds44x4_ranges,
> > > + .n_yes_ranges =3D ARRAY_SIZE(ds44x4_ranges),
> > > +};
> > > =C2=A0
> > > -static int ds4424_set_value(struct iio_dev *indio_dev,
> > > - =C2=A0=C2=A0=C2=A0=C2=A0 int val, struct iio_chan_spec const *chan)
> > > +static const struct regmap_config ds44x2_regmap_config =3D {
> > > + .reg_bits =3D 8,
> > > + .val_bits =3D 8,
> > > + .cache_type =3D REGCACHE_FLAT,
> > > + .max_register =3D DS4424_DAC_ADDR(1),
> > > + .rd_table =3D &ds44x2_table,
> > > + .wr_table =3D &ds44x2_table,
> > > +};
> >=20
> > Note that REGCACHE_FLAT will allocate 0xF8 unsigned longs you will neve=
r
> > use.
> > REGCACHE_MAPLE will probably be much closer to the size of the original
> > value
> > cache, for a small look-up performance penalty (but always fast compare=
d to
> > the
> > I2C bus).
>=20
> ACK, already migrated to REGCACHE_MAPLE in the v3:
> https://lore.kernel.org/all/20260128153824.3679187-8-o.rempel@pengutronix=
.de/

Thanks for the link. I'm not on the IIO list, so I hadn't seen this version=
 yet.

> Which works mostly fine except of the cache initialisation. If I use
> num_reg_defaults_raw with REGCACHE_MAPLE as proposed by Andy
> Shevchenko, first access to regmap values over debugfs will explode with
> NULL pointer etc...
> If I remove num_reg_defaults_raw, I need to read register manually
> to init defaul values as implemented in v3.

num_reg_defaults_raw without a raw register value buffer is also problemati=
c
IMHO. If it is used without a buffer, values will be read from hardware. Th=
is is
indeed widely used to prime a (flat) cache, but if you want to maintain the
documented behavior of regmap_sync() it should only be used if the hardware
really just came out of reset.

Not sure how likely it is that not all channels values are written after pr=
obe,
but for this driver specifically you might see:

   1. Driver probes with num_reg_defaults_raw, using current HW values as
      initial cache _and_ register defaults.
   2. No updates were written before device is suspended. DAC registers are=
 set
      to 0, cache marked dirty.
   3. No updates were written before device comes out of suspend and
      regmap_sync() is called. regmap_sync() sees a cache state which is st=
ill
      identical to the register defaults and omits (all) writes.

After 3. your device is considered online again, but the HW registers are s=
till
set to 0 and your cache is out-of-sync.

This also made me realize you do want to read all the channels at some poin=
t to
be able to resume to the same state after suspending.


> The REGCACHE_FLAT has one more problem, the cache will be inited with
> i2c NACKs (0xFF) if used with num_reg_defaults_raw.

That's rather nasty. I don't suppose you investigated why that's happening?=
 (not
saying you should, just wondering)

Best,
Sander
