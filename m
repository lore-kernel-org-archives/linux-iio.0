Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B6C2571C7;
	Sat,  9 May 2026 14:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337970; cv=none; b=CDACXt5CaUPZIQjRNXBmzdKAQX2paGJyLx2o0W1s2ytK/QcdcmdNoi1qpEnhE8MWUSCwVxPd1K/JLxnmaKuqInD5KQ7R851lF1oM46ZExeA8+lv9jpvXWBpXzbiCsWzyUMzQygaL+LVKwzNs63Qlu6WRWC7jVIuC1j/efc4dmus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337970; c=relaxed/simple;
	bh=i5fKdGSPuWGbNpYa1XMgwdSm8esm6Qe9Wqc5n6R9HdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RdI54H/Rwg1IzGTbU0Sx9BPnrrYILIffZXKnKqUwP6LYa5frT6iNG9g1VedE5OnPJHhlWHYD/q7qCLtmXh6Am0qsOUyAzALs59DRjajnwbunblOGEKHnt8eO+vvIw0RBGcCUrsTFJZ3IEEtqA++ON0Bbj1FtjV3GHPtVy09otX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLLxh5K7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLLxh5K7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0336C2BCB2;
	Sat,  9 May 2026 14:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337970;
	bh=i5fKdGSPuWGbNpYa1XMgwdSm8esm6Qe9Wqc5n6R9HdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jLLxh5K7MGuIvPBwvnLXuIGcSqlW09X4ULF4eNXAahm99fMeNdGt+PXs4+bcOUZNx
	 U/jw/h1K0TIaMQSbtZgt4W0VFFsfvPAJ0MMFGcfqLCayf2m5OfvexXgOLBAY1UKmkJ
	 VsZYa3/u086PJsGCKokRPa2KJwdJ+QmmNt6mMFPekp36B4d7aYCHtLzQiSpERcgy0E
	 9nhgnC7XM+tD3uPs25JPoAelaKecJCuRg4SPsLIEr0mJNa4cM6Ex12OJoWt58FY24U
	 WnakglfT//LknVxSHh/O6OaxOghiZo9R65ssMT39EXU6eHbyl5u1yLKDahyf5+RnMp
	 wPJnu5Sz73zBQ==
Date: Sat, 9 May 2026 15:46:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: "Stan, Liviu" <Liviu.Stan@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <20260509154600.02e2d11a@jic23-huawei>
In-Reply-To: <af4LCQiqNaiMzFkX@nsa>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-3-liviu.stan@analog.com>
	<afCVtXBHIIoLlsRo@nsa>
	<SA5PR03MB83772D8F6A3CC39094DE5241F63C2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af2no3bJA9MSjXvV@nsa>
	<20260508121441.39ad9f65@jic23-huawei>
	<SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 8 May 2026 17:13:14 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Fri, May 08, 2026 at 02:48:39PM +0000, Stan, Liviu wrote:
> > On Fri, May 08, 2026 Nuno S=C3=A1 wrote: =20
> > > > On Fri, 8 May 2026 Jonathan Cameron wrote: =20
> > > > > > Will defer this to Jonathan but if we can have a real of the co=
verage
> > > > > > given the temperature, I guess this is ok. Given that I think w=
e don't have
> > > > > > a better channel (unless we add one?) for this. Or just extende=
d_info...
> > > > > > =20
> > > > >
> > > > > I have no idea what coverage percentage means in this case.
> > > > > Can you provide some more details or a reference?  Google isn't g=
iving me
> > > > > anything useful. =20
> > > >
> > > > A leak detector is a sensor like the raindrop detection modules, wh=
ose
> > > > resistance decreases as more of its surface is contacted by liquid.=
 In this case,
> > > > for example, if half of the sensor's surface is in contact with a l=
iquid, the
> > > > ADT7604 should, with an appropiate user-provided resistance-vs-cove=
rage
> > > > table, report 50% coverage in the IIO channel. =20
> > >=20
> > > And, AFAIU, depending on the coverage the resistance changes and that=
's
> > > how we get into the indirect temperature variations? =20
> >=20
> > If I understand your comment correctly, you're implying that there are =
indirect
> > temperature variations caused by resistance changes, and that's what th=
e chip is
> > measuring? The chip does not measure any actual temperature for this se=
nsor
> > type, the value in the temperature result register bank is solely a res=
ult of the=20
> > chip's interpolation of the user-defined custom table.
> >  =20
>=20
> I meant that's what the table is trying to accomplish? That's why I kind
> of put it as "indirect". My understanding was the chip does not measure
> any temperature as well.

Ok. So what are our options here?  Present it as simple resistance and leave
userspace to figure it out or add a new channel type? To me feels like new
channel type makes sense.

Jonathan


>=20
> - Nuno S=C3=A1
>=20
> > Liviu =20

