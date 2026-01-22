Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFB21FF7C8;
	Thu, 22 Jan 2026 19:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769110405; cv=none; b=jbZPUAYIYTn4NvSosDUsctkOxW+kuQ3wjWhPmfdNUlLtbdJ0zx3LbIvskqde1+ICEupViYMFplFbqITJLVhh+ESo+ghrY5n1fB6MCEGgb3GgrXUsx8zTkVyz9iGAegwRNlwrkVF+IRlwAJ/7ws3HXGEV8TCsIFw0Z7ZetlgqT5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769110405; c=relaxed/simple;
	bh=7SgLk2UDB0FZRkvj2BvFR8LJLwcq8f+XoFkuLPLDdVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omU2jqMKdn8NfZL6T4jDTdHGicUWZOXlUwVEThKHmPE/l6GwZ1ni6zCkXYQfvg8H+egUcfoNB0Pk+YvgmxjjlAeQXEzXIiJsVMIm9ZhCRXjGcIMGlZpXQVZ38cxoLunQSGnHBdvCm64nPsySvj9itDiXO20k90N3G6j1vpgFYHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TnxDSKT6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TnxDSKT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C694C116C6;
	Thu, 22 Jan 2026 19:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769110404;
	bh=7SgLk2UDB0FZRkvj2BvFR8LJLwcq8f+XoFkuLPLDdVo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TnxDSKT6W31tNcauhdZq7Ceg+ocFPLhOBPnJQJ7V4b9UXh2OSldzBbpzgfkzavZZJ
	 LZOvczhZlGS275G6tQI6IfrmKgTwpvUs/QmlUmXAs+FeD47+rl0Dr9yLn1UUYs0SgP
	 qq4S/Z15Vj27fTz7WJQakvB4lsWegvHtucW7J5dC61c8rhxj6Gw7lCZnvG3n/AFNKZ
	 WmJSwYUcm/6VZWvzne2j//rWFa8iV6U0BhEzB7rDot5Y3VbJCMDpGB29G9uqO+2c83
	 chpzbj+sJgd4x+ufdd0LgdYfOLQ6YZJpyu1AJx87zdHV4j/CyqCr2m3LJK1hfrkGl/
	 3CX8qsVTL/cTg==
Date: Thu, 22 Jan 2026 19:33:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Rodrigo Alencar 
 <455.rodrigo.alencar@gmail.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, rodrigo.alencar@analog.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-doc@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko	 <andy@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v4 3/7] iio: frequency: adf41513: driver implementation
Message-ID: <20260122193312.0a84ac33@jic23-huawei>
In-Reply-To: <99789eb34873eca976a3324c363a1dc70a2f0d3d.camel@gmail.com>
References: <aW3dxuelYDM67pqZ@smile.fi.intel.com>
	<texwv5s2tvcy34bwr4iruj5xofmea663pwletmpqpuh66zulmv@m7qvjgqbhalv>
	<aW40ylvMwVhqNQMw@smile.fi.intel.com>
	<hgy3bcrqqsvt7pobhnzuvwzhb2taetpxltkaxpigmmlvmlirod@v6anhmrsvv2r>
	<aW5kk6K30Izckvg5@smile.fi.intel.com>
	<e5lcg5kkey3c6u2l4rlzzpolp7qkudhcofyzcx5s2tjbh2iwkg@js3fisv23zyj>
	<CAHp75VepcSZo_E4_UxhKRfHrMFDd7huJg14m8=6zVo4ENKFXkA@mail.gmail.com>
	<vvdk3whhwua73g63eetnmn46t2cpbpkzzkx7m6wsbverp7gcvs@mi7cipis3i4t>
	<aW-Fai68pk1tAeyY@smile.fi.intel.com>
	<kmdqcaewxxg7isappgfxuf5ode5fepbywrdriksmvrzmaykcjd@crpr27tt3bmf>
	<aXChxvlZxKVrOMsW@smile.fi.intel.com>
	<99789eb34873eca976a3324c363a1dc70a2f0d3d.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 21 Jan 2026 14:21:00 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-01-21 at 11:52 +0200, Andy Shevchenko wrote:
> > On Wed, Jan 21, 2026 at 09:41:25AM +0000, Rodrigo Alencar wrote: =20
> > > On 26/01/20 03:38PM, Andy Shevchenko wrote: =20
> > > > On Tue, Jan 20, 2026 at 01:07:49PM +0000, Rodrigo Alencar wrote: =20
> > > > > On 26/01/20 01:24PM, Andy Shevchenko wrote: =20
> > > > > > On Tue, Jan 20, 2026 at 12:43=E2=80=AFPM Rodrigo Alencar
> > > > > > <455.rodrigo.alencar@gmail.com> wrote: =20
> > > > > > > On 26/01/19 07:07PM, Andy Shevchenko wrote: =20
> > > > > > > > On Mon, Jan 19, 2026 at 04:37:09PM +0000, Rodrigo Alencar w=
rote: =20
> > > > > > > > > On 26/01/19 03:42PM, Andy Shevchenko wrote: =20
> > > > > > > > > > On Mon, Jan 19, 2026 at 11:21:59AM +0000, Rodrigo Alenc=
ar wrote: =20
> > > > > > > > > > > On 26/01/19 09:31AM, Andy Shevchenko wrote: =20
> > > > > > > > > > > > On Fri, Jan 16, 2026 at 02:32:22PM +0000, Rodrigo A=
lencar via B4 Relay wrote: =20
> >=20
> > ...
> >  =20
> > > > > > > > > > > The current implementation is kind of a stripped vers=
ion of
> > > > > > > > > > > __iio_str_to_fixpoint(). Would you prefer something l=
ike this, then?: =20
> > > > > > > > > >=20
> > > > > > > > > > Do they have most of the parts in common? If so, why ca=
n't we use
> > > > > > > > > > __iio_str_to_fixpoint() directly? Or why can't we sligh=
tly refactor
> > > > > > > > > > that to give us the results we need here? =20
> > > > > > > > >=20
> > > > > > > > > __iio_str_to_fixpoint() only parses "int" chunks, adf4151=
3_parse_uhz
> > > > > > > > > was modified to accomodate the u64 parsing removing unnec=
essary stuff. =20
> > > > > > > >=20
> > > > > > > > But why? The fractional part most likely will be kept int (=
it's up to 10=E2=81=BB=E2=81=B9).
> > > > > > > > The integer can be bigger than 10=E2=81=B9? =20
> > > > > > >=20
> > > > > > > Correct, integer part of the frequency value goes up to 26.5 =
GHz
> > > > > > > (uint_max is approx 4.3 GHz). Also, with the dual modulus, th=
e PLL can
> > > > > > > achieve micro Hz resolution. =20
> > > > > >=20
> > > > > > =C2=B5Hz is not a problem since it's up to nHz.
> > > > > > So, the difference so far is the integer part that can be 64-bi=
t.
> > > > > > Again, can we factor out something to be used for this and for =
the
> > > > > > __iio_str_to_fixpoint() cases? =20
> > > > >=20
> > > > > I am not sure what you are suggesting, =20
> > > >=20
> > > > To make changes to reuse the code.
> > > >  =20
> > > > > but I am avoiding changes to iio core at this point. =20
> > > >=20
> > > > Why? =20
> > >=20
> > > I understood that core changes would require more than one user
> > > supporting the change. =20
> >=20
> > At least one. And we have tons of them as the callers of
> > __iio_str_to_fixpoint() are not going to disappear. Basically it's a su=
rgery in
> > the middle of the existing chain of APIs. To me one user is enough just=
ification
> > for such a surgery. For the newly introduced API (imagine __iio_str_to_=
fixpoint()
> > as an example) it's indeed one user not enough.
> >  =20
> > > > > If any other user needs similar behavior,
> > > > > I'd say we would need to have __iio_str_to_fixpoint() implementat=
ion
> > > > > modified, so to create a version of iio_str_to_fixpoint() that ha=
ndles
> > > > > long long variables. Possibly consuming simple_strtoull instead of
> > > > > doing the manual parsing. =20
> > > >=20
> > > > That's the problem here. With Yet Another Cool Parser this all beco=
mes
> > > > unmaintainable very soon =20
> > >=20
> > > Considering that the need for a new parser for 64-bit parts is only d=
riven
> > > by this specific PLL driver, I wonder how things become that unmainta=
inable. =20
> >=20
> > Because there is a duplication of the code (to some extent) and if we f=
ound
> > a bug in the one implementation it will be hard to fix (or even remeber=
) about
> > the other. =20
>=20
> Agreed!
>=20
> >  =20
> > > > (basically as you said when new comer needs a third
> > > > variant of it). This is not good. Instead better to create (amend, =
expand)
> > > > existing test cases, split out a foundation API that parses 64-bit =
parts
> > > > (maybe even for fractional as well, dunno) and evolve a needed (sub=
)API
> > > > from it. =20
> > >=20
> > > I don't disagree with you though, I suppose I will need a green light=
 to
> > > move on with this? =20
> >=20
> > Fine with me, let's gather opinions of David, Nuno, Jonathan, and other=
s. =20
>=20
>=20
> Fine with me.
Likewise. A common / foundational function with specialized wrappers would
be good.

>=20
> - Nuno S=C3=A1
>=20

