Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00B41D638;
	Tue, 28 Jul 2026 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253294; cv=none; b=eWXVJegmk7op4YuFmA9QxLY3HEWcz9Lx8ZtgCBUVShqRD5Yvg72iBh8ZJhBTeAMMC3fUku5YUoE6DWfAwWxA9ymAyX70CQ43NgCn/8X5CCwIMupR5JMEne/XH8rLD6Uru0P/72tusZ9SVGiC9o6IMtveJ/a0SJeauHp/1VArEgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253294; c=relaxed/simple;
	bh=swG3UxAhhK/mEY0PP+j/48S/NXKotXJQT0xx5fxyH5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Udebh5VJ8aXnxCwr2XIZynxgFTZxPuScX0MiS1QCL+7kmXP8TP9Wm42EHIug8/v6smsRU4dxZk6/R4Lh4G5ENPcC6vL4QjMSULJ/M/d397hyONRjWPiuYad0aXpKn7n4xjqqMsr46DOtqjiJanfjYAoc4lD/utTOLzqn9vJSEY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bTugzkng; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bTugzkng"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0F171F00AC4;
	Tue, 28 Jul 2026 15:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785253292;
	bh=viNqCJqKCav85XPi9IbGjxy5ALG3OVfZkoc0jfp2Btk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bTugzkng+4UoY6mBvJeHNOxLASQ5Q1OdkDo9zBhPgsNqfWYgeaIo8qONHJAMR4mqX
	 wOiCfsxin9aZSOn1senbaSDMCdgAvV02OERVLlMPAV395+tyDvjRubBenw811vp6mz
	 +qxlEUke+qwT8AYGtntZ2It8f4bIhnQGVNBGP9HB7u/NEq3gj0x7VqyshwTGvBtACo
	 Np5SmpoVFsJkenCOwIsxJ9Oh1N6JqDNFiHKtaVQL09Wqx/hoSHIJFMZ5LJRVw45sto
	 a4tJisl9HqIDHOucwVNsX7mSJ56JkewglkZh0TGjB+QTGehtjE49L1ZwVdoEM+/Zks
	 LgzsvV/8Kpuiw==
Date: Tue, 28 Jul 2026 16:41:26 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kim Seer Paller <kimseer.paller@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/4] dt-bindings: iio: dac: add adi,ad5710r.yaml
Message-ID: <20260728-selected-pancake-8fa8a066f95d@spud>
References: <20260721-iio-ad5710r-upstream-v2-0-324949dc72da@analog.com>
 <20260721-iio-ad5710r-upstream-v2-2-324949dc72da@analog.com>
 <20260721-clustered-jolliness-30d70a2acc49@spud>
 <20260724225738.2e090842@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="AEhZ5P1g6XrlKNht"
Content-Disposition: inline
In-Reply-To: <20260724225738.2e090842@jic23-huawei>

--AEhZ5P1g6XrlKNht
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 10:57:38PM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 16:52:10 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Jul 21, 2026 at 04:47:11PM +0800, Kim Seer Paller wrote:
> > > Add device tree bindings for the Analog Devices AD5710R/AD5711R
> > > 8-channel 12-/16-bit Configurable IDAC/VDAC.
> > >=20
> > > Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> > > ---
> > >  .../devicetree/bindings/iio/dac/adi,ad5710r.yaml   | 143 +++++++++++=
++++++++++ =20
> >=20
> > > +patternProperties:
> > > +  "^channel@[0-7]$":
> > > +    $ref: /schemas/iio/dac/dac.yaml#
> > > +    type: object
> > > +    description:
> > > +      Represents the external channels which are connected to the DA=
C.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: Channel number
> > > +        items:
> > > +          minimum: 0
> > > +          maximum: 7
> > > +
> > > +      adi,ch-func:
> > > +        description:
> > > +          Channel output type. Use CH_FUNC_VOLTAGE_OUTPUT for voltage
> > > +          output or CH_FUNC_CURRENT_OUTPUT for current output.
> > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > +        enum: [1, 2] =20
> >=20
> > Please make this property a string.
>=20
> It's an existing binding.  I guess it is generic enough that perhaps we
> should make it a generic channel property and as part of that we can
> flip over to a string.

Ah, if it is something already established then it can stay as-is.

> We may need to create a top level channels.yaml to cover both ADC and DAC
> channels though and reference that from both files.

I mean yeah, that was one thought I had originally about the
spi-device-address property. I'm surprised there's already not more
commonality to begin with.

Just how common is some sort of "channel function" property and how
many devices are bastardising other properties like diff-channel with a
virtual channel to achieve the same result?

>=20
> I guess we don't need to do that yet though given this is a DAC only devi=
ce.
> The original place we added adi,ch-func is a combined ADC / DAC and=20
> has a lot more possible functions.
>=20
> Jonathan
>=20
>=20

--AEhZ5P1g6XrlKNht
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamjNpgAKCRB4tDGHoIJi
0liXAPwLY0NB610GhKTshIgo0xoN1LC8fy1qiN7chYjskX3j9QEA9swxph1amSbi
b7QjkJ8qbY4AoqiJVTeNO3IP6p8uFAk=
=3Sbn
-----END PGP SIGNATURE-----

--AEhZ5P1g6XrlKNht--
