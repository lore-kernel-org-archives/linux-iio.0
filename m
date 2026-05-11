Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14717365A19;
	Mon, 11 May 2026 11:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498311; cv=none; b=WU2Nm1Ts90Hqt/XgOaCKyv6VeODur1WA4zdTLzFOwa/vTeqTHYVr2JoLD7NKgt2WlxVHKU5I6o0nAHkVMcr1lK5iCVcxzxXfwhkfEdRELAmkzvlCTze/f1bjKzWYZBLfVTy6VAxOoIND8x5a6zovn4qEaTageANO3wLvhROuISk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498311; c=relaxed/simple;
	bh=BgroUMz6Qu2EX2YYMtZ2XpcV3R4JJ1YcXNclcmuMs2k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1XKTR/5sHGHxJJtEhmDg6Nc9EZCzn5wN9drBwEU/RAgY4mTgE6ISfG3p7/BJmpD3ilnGuawivShIy7Whisu5BAysAU55yxZ79Ks/UIj9cgLBmKjjes79XyLpLKP8BY4Z88UFNSRhQhUhcy+mrnNxLuW1Kk7lwhD+bw7Osa062s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9p29SM7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9p29SM7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4182C2BCB0;
	Mon, 11 May 2026 11:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778498310;
	bh=BgroUMz6Qu2EX2YYMtZ2XpcV3R4JJ1YcXNclcmuMs2k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L9p29SM7ZOcU/wo5RM7Qi7wCnpOG/xKjFQh/wAq7OJK2qdzG6PKOruUZjfeWRRIF+
	 71t2vP11DUV/5Rf38YTf4Kg+jgOtIs4QbXJAD1gEUDCiThMxX6d5gvNmarAfuhhzvF
	 Jcfr1Ze9iFShRXFQBV/BQxNVsmiROh2NQH48cdWvPUd6iIaN2UQm6tELeY86dzLfch
	 gvGWugLLED9E3B05Uhc7xnIYhrWvF7x9GoT1Amaq0oAXVKMxWofwPw2jP8MR09ylVg
	 8Tp5wRCcwFj8uDqz5Ye0BmoyEytylx47g5QPH+HgXyFsmwkniEGvQL/LDojqIv7N5y
	 3g6JGXGTIZ81w==
Date: Mon, 11 May 2026 12:18:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Stan, Liviu" <Liviu.Stan@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
 "Sa, Nuno" <Nuno.Sa@analog.com>, David Lechner <dlechner@baylibre.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: ltc2983: Add support for ADT7604
Message-ID: <20260511121820.3be9e635@jic23-huawei>
In-Reply-To: <SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
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
	<20260509154600.02e2d11a@jic23-huawei>
	<SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 07:52:17 +0000
"Stan, Liviu" <Liviu.Stan@analog.com> wrote:

> On Fri, 8 May 2026, Nuno S=C3=A1 wrote:
> > > > > A leak detector is a sensor like the raindrop detection modules, =
whose
> > > > > resistance decreases as more of its surface is contacted by liqui=
d. In this
> > > > > case, for example, if half of the sensor's surface is in contact=
=20
> > > > > with a liquid, the ADT7604 should, with an appropiate user-provid=
ed=20
> > > > > resistance-vs-coverage table, report 50% coverage in the IIO chan=
nel. =20
> > > >
> > > > And, AFAIU, depending on the coverage the resistance changes and th=
at's
> > > > how we get into the indirect temperature variations? =20
> > >
> > > If I understand your comment correctly, you're implying that there are
> > > indirect temperature variations caused by resistance changes, and=20
> > > that's what the chip is measuring? The chip does not measure any actu=
al
> > > temperature for this sensor type, the value in the temperature result=
=20
> > > register bank is solely a result of the chip's interpolation of the=20
> > > user-defined custom table. =20
> >
> > I meant that's what the table is trying to accomplish? That's why I kind
> > of put it as "indirect". My understanding was the chip does not measure
> > any temperature as well. =20
>=20
> Oh, okay, I understand now. Yes, this is what the table is trying to acco=
mplish.
>=20
> On Sat, 9 May 2026, Jonathan Cameron wrote:
> > > I meant that's what the table is trying to accomplish? That's why I k=
ind
> > > of put it as "indirect". My understanding was the chip does not measu=
re
> > > any temperature as well.
> > > =20
> > Ok. So what are our options here?  Present it as simple resistance and =
leave
> > userspace to figure it out or add a new channel type? To me feels like =
new
> > channel type makes sense. =20
>=20
> The current approach presents it as IIO_TEMP since the chip outputs cover=
age
> (using the custom table interpolation) via the temperature result bank, n=
ot the
> resistance bank, but I agree a new channel type makes sense. Should I
> create a specific type like IIO_COVERAGE_PERCENT or would a general
> IIO_PERCENTAGE be better?

For ABI purposes we don't care where it comes from.

We already have some 'ratio' type measurements like concentration which are
percentages and similar to those I think we need some indication of 'what'
is being measured given it's unit free.  Hence IIO_COVERAGE_PERCENT seems
the better choice to me.

Jonathan


>=20
> Thanks,
> Liviu

