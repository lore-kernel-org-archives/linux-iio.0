Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28778279DAF;
	Fri, 12 Jun 2026 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781301641; cv=none; b=BrF6q1N4hlLTuKxUVl4snIuYHjfEzUtE4KIupFNfAWYitcol3IbkW3w1YiC72vDEBj9kUne13R7yqICAdake6IWQ499B5JnLMLXD1KQ+puDMD/rKDiucXI11NQfNU5ujo5y/PUizGSRuF/yAdR5r85o06cjUAkAExNpVuLBotF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781301641; c=relaxed/simple;
	bh=wlf9ZQnOV85DoqcF1uIAIGioOBiU+efF3Efz8F5pQ1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTcuK3C/4dqId+3nBeENoefJHTC/qNAYtgsLtOTXlAap+Qd0BjaNh/HrQ1NCA0Xjhy8kyO/wqsLH33QVdY0L3J7xOooprD5GFJXj3nMDKr7nJLBv/g7Vw2a4omIK1JPOR764b7VRqRCTrrrmUXqbdiuVHsQxQ0A6nLMGWiotLiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5XuX0zQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5XuX0zQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B8201F000E9;
	Fri, 12 Jun 2026 22:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781301639;
	bh=D+YSTYoQ7GqxqAcW6PUBkEPM5pJV9AVmonvuxFY/zts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5XuX0zQInySl+v2Y6jt8M81H5uOu3ky/3e3VsMMS4h96B/NwrkuoEH5N+X58Vmca
	 B15KOYcenCPD7kqVVAwMkNIKnkpEdNgneFuZWJp8f4772dQho+O1A0j3CCjdXOkLo+
	 A3e2Q7jrzPx7ugdHu8bW+JxI5J2qTQDeb+vtXioNu2cYhht3vKPDk6f+SxyQVClMEF
	 MaF3BZwZ8PJ6wXisQSi92AwKipVwDbAgKrvmxZ3NsvJ3onu9rBEa4kmqYNp6E22emT
	 MlCRxxI03RZkzw5ujGviOqqo+3MYgu0gqr5WRcTxJKi1kusHsN/orY5xegobv3k+dK
	 pgNmri53ae/tQ==
Date: Fri, 12 Jun 2026 23:00:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Wadim Mueller <wafgo01@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S
 liquid flow sensor
Message-ID: <20260612-engraved-graves-6ff82d41d68e@spud>
References: <20260530205435.37326-1-wafgo01@gmail.com>
 <20260530205435.37326-3-wafgo01@gmail.com>
 <20260601-banana-narwhal-of-music-0b4d3a@quoll>
 <20260601150959.49bbf125@jic23-huawei>
 <1dbd3ab3-de6c-44dd-8100-e8ee60f558c8@kernel.org>
 <20260604100304.11d0e003@jic23-huawei>
 <200a6c34-3321-4c2c-9746-52348e700cd9@kernel.org>
 <20260605132135.141422d8@jic23-huawei>
 <20260607-quixotic-steel-puma-133410@quoll>
 <20260612190543.34d90b87@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2ecldXCkI3oxCYD8"
Content-Disposition: inline
In-Reply-To: <20260612190543.34d90b87@jic23-huawei>


--2ecldXCkI3oxCYD8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 12, 2026 at 07:05:43PM +0100, Jonathan Cameron wrote:
> On Sun, 7 Jun 2026 10:30:07 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On Fri, Jun 05, 2026 at 01:21:35PM +0100, Jonathan Cameron wrote:
> > > On Thu, 4 Jun 2026 13:22:17 +0200
> > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >  =20
> > > > On 04/06/2026 11:03, Jonathan Cameron wrote: =20
> > > > > On Wed, 3 Jun 2026 16:29:10 +0200
> > > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >    =20
> > > > >> On 01/06/2026 16:09, Jonathan Cameron wrote:   =20
> > > > >>> On Mon, 1 Jun 2026 13:53:23 +0200
> > > > >>> Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > >>>      =20
> > > > >>>> On Sat, May 30, 2026 at 10:54:31PM +0200, Wadim Mueller wrote:=
     =20
> > > > >>>>> Document the bindings for the Sensirion SLF3S family of digit=
al
> > > > >>>>> liquid-flow sensors on I2C.  The family currently covers the
> > > > >>>>> SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.
> > > > >>>>>
> > > > >>>>> The driver auto-detects the variant from the product-informat=
ion
> > > > >>>>> register at probe time; the per-variant compatible strings ex=
ist
> > > > >>>>> for documentation and dt_binding_check purposes.       =20
> > > > >>>>
> > > > >>>> Here...
> > > > >>>>     =20
> > > > >>>>> +description:
> > > > >>>>> +  Family of digital liquid-flow sensors from Sensirion with =
I2C
> > > > >>>>> +  interface.  All family members share the same register map=
; sub-types
> > > > >>>>> +  differ only in the flow scale factor and the calibrated me=
asurement
> > > > >>>>> +  range, both of which are detected at probe time via the
> > > > >>>>> +  product-information register.       =20
> > > > >>>>
> > > > >>>> And here...
> > > > >>>>     =20
> > > > >>>>> +
> > > > >>>>> +properties:
> > > > >>>>> +  compatible:
> > > > >>>>> +    enum:
> > > > >>>>> +      - sensirion,slf3s-0600f
> > > > >>>>> +      - sensirion,slf3s-1300f
> > > > >>>>> +      - sensirion,slf3s-4000b       =20
> > > > >>>>
> > > > >>>> And here something else. Confusing. Didn't you say device vari=
ants are
> > > > >>>> auto-detectable? So you have only one compatible sensirion,slf=
3s.     =20
> > > > >>>
> > > > >>> And then future fallback compatibles can never work.=20
> > > > >>> Basically as far as I have ever been able to establish this is =
why
> > > > >>> generic compatibles are almost always the wrong way to go.
> > > > >>>
> > > > >>> If we get a future part with an unknown ID and don't have these=
 existing
> > > > >>> specific compatibles, then we have no way to specify which one =
it is     =20
> > > > >>
> > > > >> But why would you have future part with unknown ID?   =20
> > > > >=20
> > > > > That's what manufacturers do on a very frequent basis.  They twea=
k something
> > > > > that has no affect on the interface or channel scaling etc and re=
lease a new part
> > > > > with a different ID.  Can be something like a part suited to diff=
erent operating
> > > > > conditions, or with a different supply tolerance.   =20
> > > >=20
> > > > and it will have a different, known that time ID. How could be "unk=
nown"? =20
> > >=20
> > > Known to us, sure, know to old kernel (or other software), not so muc=
h.
> > > For this sort of driver the main use of fallback compatibles is to wo=
rk on
> > > a not yet aware kernel. =20
> >=20
> > So you mean a case that sometime in the future, someone will write a DTS
> > with sensirion,slf3s fallback for a sensirion,slf3s-WAHTEVER_NEW_MODEL,=
 use
> > old kernel and be surprised it does not work?
>=20
> To me that is exactly what a fallback compatible is promising - if we have
> any kernel / driver that supports the part that we are saying is a valid
> fallback then we are saying we support at least the functionality of that
> part (sure there may be extra stuff that doesn't work)
>=20
> We had a long discussion a few years back on whether code that did
>=20
> 	if (read_reg_whoami() !=3D EXPECTED_ID)
> 		return -ENODEV;
>=20
> was correct. Someone (maybe Rob?) strongly argued that we must not
> do that because it effectively made fallbacks pointless as we always
> needed to upgrade the driver. I argued against this (on basis that
> swapping in incompatible parts is annoyingly common) but was eventually
> persuaded.
>=20
> If that is not a valid reading of what fallback compatibles mean, is
> there any documentation of the rules I can refer to?
>=20
> >=20
> > Our goal is not to stop whatever poor code people can ever come up with.
> >=20
> > Every future user wanting to the fallback MUST understand what the
> > fallback means.
>=20
> This is where we disagree.
>=20
> This is not hard to support, it just means not using generic compatibles
> when the device differ (and they are not self describing which these are
> not).

FWIW, I think the no generic compatible approach is reasonable.
The devices might be able to self-identify, but the featureset is not
discoverable, which makes the self-identification much less valuable.
Permitting drop-in replacement parts (or knock off devices from other
manufacturers etc) to use a compatible device as a fallback seems to me
exactly what fallbacks are intended for.

If the driver has to be updated every time a new device is created then
I think a generic compatible has effectively no value.

--2ecldXCkI3oxCYD8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaiyBgwAKCRB4tDGHoIJi
0p28AP9XOSHQnbHHjhRjTvlneq0BUeJFGPwNagekD+j0yVA5JgD/RF3ZeQWplfvK
kpDJA8GrSRLVp6jhZAyabO+COPB/6gI=
=JqHC
-----END PGP SIGNATURE-----

--2ecldXCkI3oxCYD8--
