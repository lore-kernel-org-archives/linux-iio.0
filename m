Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896802FC876;
	Tue, 12 May 2026 10:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778583330; cv=none; b=OKCP1uU0vglYGm0PZaBWMQU9G7b6Z2ywAWH7N8LzxMC8M0AZLULgCH+iURd0dpQsAS3CZThM7OQX79Mhez/LBZoA/2wuvFqTE5ypgOf45Ig8QVYYnaPBMmfEbhNe7s7CvZdXmxbMN43lIlsGNeSzXn9fMWprSuCyehJsoZ6iJTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778583330; c=relaxed/simple;
	bh=jPDSuj8n3LefLlUaxAnle+AzeQ/R4d+xmVZSwukbA50=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4KeHpKdgtgP1dGvdXYtM06zT+dsYdwsR7BIlLRwZLL+JDjEa8pvUDl4m0GIW3ua1FZJyuDvqmK1+28FL19QIcGqyjY985diXWM+3hFOwtilYwc+7ZbW8EdyJlvrHO3xv9mX0EkyO1LLR7QfRlmtWrPbNmR+CiSDFnjvJ39SoFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=muCBVgtV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="muCBVgtV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B09EC2BCB0;
	Tue, 12 May 2026 10:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778583330;
	bh=jPDSuj8n3LefLlUaxAnle+AzeQ/R4d+xmVZSwukbA50=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=muCBVgtVb88FGGqQCo3jnxUnhRvZvs78QpcubO6MIKaSpOCeyQjraeYdqpCeGVs8X
	 hCJUGsiekrIYftkT44d6kroTwdBULe0byUTMZajLQzH+zRDxVQAXCsAEDsonEiYZS0
	 rxfOGEhfjqpSslAlmf57O2Rxms5koeG17CxfUIZqJsa5Mjy3ft8qf44T6T7F7aI9mD
	 9c5L76O422mUukyFULz3pMFfmAAaM9pG5SHIzWIyBsM+JEmcSHmgpROFVF9PAKyX20
	 OlPMUq3jL2zAn5Z7ipiDdR2k+wCGpiNNIk253HVC9U/Dutc/Wo3Mt+vLuFXhHhyTxU
	 hSDJcEJgiRxNg==
Date: Tue, 12 May 2026 11:55:20 +0100
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
Message-ID: <20260512115520.5833ce45@jic23-huawei>
In-Reply-To: <agLhb-S2ISSjaopc@nsa>
References: <af2no3bJA9MSjXvV@nsa>
	<20260508121441.39ad9f65@jic23-huawei>
	<SA5PR03MB83778AB3C41E0AF56EC754F8F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af3oezNmmBhI4Yu4@nsa>
	<SA5PR03MB837710AE7FD8B8FFF138B7C5F63D2@SA5PR03MB8377.namprd03.prod.outlook.com>
	<af4LCQiqNaiMzFkX@nsa>
	<20260509154600.02e2d11a@jic23-huawei>
	<SA5PR03MB83770D945E92C40A74D9C0DAF6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<20260511121820.3be9e635@jic23-huawei>
	<SA5PR03MB83772A1A57DC052CB21B9187F6382@SA5PR03MB8377.namprd03.prod.outlook.com>
	<agLhb-S2ISSjaopc@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 09:24:27 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, May 11, 2026 at 12:02:31PM +0000, Stan, Liviu wrote:
> > On Mon, 11 May 2026 Jonathan Cameron wrote: =20
> > > > > Ok. So what are our options here?  Present it as simple resistanc=
e and leave
> > > > > userspace to figure it out or add a new channel type? To me feels=
 like new
> > > > > channel type makes sense. =20
> > > >
> > > > The current approach presents it as IIO_TEMP since the chip outputs=
 coverage
> > > > (using the custom table interpolation) via the temperature result b=
ank, not
> > > > the resistance bank, but I agree a new channel type makes sense. Sh=
ould I
> > > > create a specific type like IIO_COVERAGE_PERCENT or would a general
> > > > IIO_PERCENTAGE be better? =20
> > >=20
> > > For ABI purposes we don't care where it comes from.
> > >=20
> > > We already have some 'ratio' type measurements like concentration whi=
ch are
> > > percentages and similar to those I think we need some indication of '=
what'
> > > is being measured given it's unit free.  Hence IIO_COVERAGE_PERCENT s=
eems
> > > the better choice to me. =20
> >=20
> > Understood. Will do that in v2. =20
>=20
> I do wonder if a complete type is what we want? How will we present it?
>=20
> in_coverage_ratio?
>=20
> What I'm not too convinced is that coverage is relative to what? Well
> it's a percentage so I guess we could not care and leave interpretation to
> userspace (to know which device is dealing with). Still I wonder if a
> new iio_chan_info wouldn't be more appropriate? In this case applied to
> iio_resistance. So something like:
>=20
> in_resistance_coverage_ratio

I'm perhaps missing something - as far as I understand it there is no meani=
ngful
connection to resistance in what is being measured.
I think what you are proposing is similar to measuring current via voltage
drop over a sense resistor. We don't present that as modified voltage, we
present it as current.

Here the thing being measured is coverage rather than resistance
so keeping resistance in there is confusing for the user.

If we wanted a type to modify then we could do this as a modified area meas=
urement.
Channel type IIO_AREA (which is new) and modifier IIO_MOD_RATIO (also new).

Jonathan

>=20
> So it's clear what physical quantity coverage ratio is affecting.
>=20
> Thoughts?
> - Nuno S=C3=A1
>=20
> >=20
> > Thank you!
> >=20
> > Liviu =20

