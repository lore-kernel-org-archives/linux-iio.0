Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEF337E315;
	Thu, 21 May 2026 16:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779381706; cv=none; b=K3aOwb4F7Z8LwstigxmUznbjsjAtrjaWAcFfeXCf1CwSq5PZsHDGlUH/sbsacPul+lJDylGLkIaOSOLTW8xYUCM9GXgaLjbRe5Ce5zmu6y/SXIqnZKZzigjwgiLhUTGSJB8CNoWP/6rnZPVlH93N5GdTLBqL0ZJXhjMB207XtBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779381706; c=relaxed/simple;
	bh=VU5Xfsz0sCvrdTzWBmqB7INU/yy52sjoFdkRTJVli6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upwpkl5SrIN0kVW2ntnaWBH7kbaPD03TQ0mBpf8YVYIYss1yMsd5SkLPmOOyc/+EE4OvXLF2d7/NTayXrM8j4jASUbE+46WcjX+alD1Ncu5rKBl3FVZiorUuml6YoudTYmM3tWsWrc6eqJZIgBNmDtr9JamGpm0jnBB1XOigwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uh5//KY9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uh5//KY9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFEBB1F000E9;
	Thu, 21 May 2026 16:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779381705;
	bh=B1Hochmn7Ftgm2hSmex2S+dtWfA5loj94Rn/V7AKHL4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uh5//KY9gzo+i0z0LDqFWk4F6Xj7Ny9DUca9c8yKywXwiyYVJSAEKC4msOzxbwiWG
	 VB/afahZlQYaqmmFYAMce46P4qEUKxmyUNizO8EgXbVx1CFtU2MnbsmUzy+OFg249R
	 zbPh3I+kEUinSaZHl6HQxhaINt2dEy/OOrQaazaxjLqEuwRq6JRnlTsLsn6THWROiU
	 yWGq7aZY5gaIF8UTYi76wpC1Yd+xnyksK9iyMmc6GIU08aQsCDbqeL4+kOk2/9Olge
	 t0EsunJH2wu1I6nDJicRvbiZ2X7s5M0a1xT68RXZVHthgvlLbeUOwvFyZOyV+EjBre
	 GoDiV78KC9Bow==
Date: Thu, 21 May 2026 17:41:40 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Xingyu Wu <xingyu.wu@starfivetech.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Message-ID: <20260521-bunny-ranch-77fddc80ad83@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260520-relic-chloride-c5cdb96696ce@spud>
 <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260521-growing-brunt-4e5a9f955a4f@spud>
 <20260521123949.20e3c0a8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="agohQFK3DQNGsMAx"
Content-Disposition: inline
In-Reply-To: <20260521123949.20e3c0a8@jic23-huawei>


--agohQFK3DQNGsMAx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 12:39:49PM +0100, Jonathan Cameron wrote:
> On Thu, 21 May 2026 11:20:52 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Thu, May 21, 2026 at 09:54:27AM +0000, Xingyu Wu wrote:
> > > On 2026/5/20 23:15, Conor Dooley wrote: =20
> > > >=20
> > > > On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote: =20
> > > > > On 2026/5/19 18:00, Conor Dooley wrote: =20
> > > > > >
> > > > > > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote: =20
> > > > > > > On 2026/5/19 00:24, Conor Dooley wrote: =20
> > > > > > > >
> > > > > > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote: =
=20
> > > > > > > > > Add the new documentation of SAR-ADC for the StarFive JHB=
100 SoC.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > > ---
> > > > > > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++=
++++++++++++++
> > > > > > > > >  1 file changed, 62 insertions(+)  create mode 100644
> > > > > > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100=
-sara
> > > > > > > > > dc.y
> > > > > > > > > aml
> > > > > > > > >
> > > > > > > > > diff --git
> > > > > > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb1=
00-sa
> > > > > > > > > radc
> > > > > > > > > .yam
> > > > > > > > > l
> > > > > > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb1=
00-sa
> > > > > > > > > radc
> > > > > > > > > .yam
> > > > > > > > > l
> > > > > > > > > new file mode 100644
> > > > > > > > > index 000000000000..ba8e19b72ad7
> > > > > > > > > --- /dev/null
> > > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,=
jhb10
> > > > > > > > > +++ 0-sa
> > > > > > > > > +++ radc
> > > > > > > > > +++ .yaml
> > > > > > > > > @@ -0,0 +1,62 @@
> > > > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YA=
ML
> > > > > > > > > +1.2
> > > > > > > > > +---
> > > > > > > > > +$id:
> > > > > > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-sa=
radc.
> > > > > > > > > +yaml
> > > > > > > > > +#
> > > > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > > > +
> > > > > > > > > +title: Successive Approximation Register (SAR) A/D conve=
rter
> > > > > > > > > +for the StarFive JHB100 SoC
> > > > > > > > > +
> > > > > > > > > +maintainers:
> > > > > > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > > > +
> > > > > > > > > +properties:
> > > > > > > > > +  compatible:
> > > > > > > > > +    const: starfive,jhb100-saradc
> > > > > > > > > +
> > > > > > > > > +  reg:
> > > > > > > > > +    maxItem: 1
> > > > > > > > > +
> > > > > > > > > +  interrupts:
> > > > > > > > > +    maxItems: 1
> > > > > > > > > +
> > > > > > > > > +  clocks:
> > > > > > > > > +    maxItems: 1
> > > > > > > > > +
> > > > > > > > > +  resets:
> > > > > > > > > +    maxItems: 2
> > > > > > > > > +
> > > > > > > > > +  "#io-channel-cells":
> > > > > > > > > +    const: 1
> > > > > > > > > +
> > > > > > > > > +  upper-bound-mv:
> > > > > > > > > +    description: The upper bound voltage value of the mo=
nitor.
> > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > > +
> > > > > > > > > +  lower-bound-mv:
> > > > > > > > > +    description: The lower bound voltage value of the mo=
nitor.
> > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > > > +
> > > > > > > > > +  scan-freq:
> > > > > > > > > +    description: Number of the scan cycle interval.
> > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16 =20
> > > > > > > >
> > > > > > > > Can you explain why any of these three properties are somet=
hing
> > > > > > > > that should be in the devicetree rather than software contr=
olled? =20
> > > > > > >
> > > > > > > My intention is to be able to obtain the initial values from =
the
> > > > > > > devicetree during =20
> > > > > > probe and preset them. =20
> > > > > > > Do I need to drop them and just set them through sysfs? =20
> > > > > >
> > > > > > Unless the hardware configuration determines the values (which I
> > > > > > can't really see being the case for scan-freq at least) then ye=
s,
> > > > > > you need to drop and set them via sysfs. =20
> > > > >
> > > > > The ADC hardware can be set the scan-freq register to determine h=
ow frequent it =20
> > > > should scan its inputs. =20
> > > > > The calculation is:
> > > > > 	frequency =3D 100/((register value) + 5) MHz, The register value=
 should >=3D 15.
> > > > > The maximum allowable scan frequency is 5MHz.
> > > > > =20
> > > > > > =20
> > > > > > > > How are the bounds calculated? =20
> > > > > > >
> > > > > > > The measurement range of this ADC hardware is from 0 to 1800 =
mV.
> > > > > > > This set =20
> > > > > > value cannot exceed it. This explanation will be added later.
> > > > > >
> > > > > > I'm asking how this is calculated so that I can tell if you the
> > > > > > property is permitted or not. =20
> > > > >
> > > > > The calculation of bound is:
> > > > > bound-mv =3D 1800mv * (register value) / 0xFFF =20
> > > >=20
> > > > These are the formulas, but how does someone know what the value fo=
r bound-
> > > > mv needs to be? Why would someone not just want to always use 1800m=
v?
> > > >  =20
> > >=20
> > > Can I add the 'maximum' and ' minimum' to provide clarification? And =
the driver will also check. =20
> >=20
> > All that does is repeat the 1800 mV though, what I am interested in is
> > how someone determines if they should use 1600 mV or 200 mV etc. What
> > aspect of the hardware do the bounds depend on?
>=20
> There are two options here=20
> 1. This is critical stuff to avoid hardware damage. (If you are relying on
>    Linux for that you built your system wrong but if we ignore that...)
>    Then userspace control should not be possible - or at least should
>    only be able to move boundaries in directions that make them tighter.
> 2. It is advisory only and not related to hardware damage - in that case
>    generally doesn't belong in DT.

Per Xingyu's latest response
| These bounds are just for the monitor mode. If the input voltage is outsi=
de this range, interrupt will be triggered to report the user space.
| The bounds value (1600mv or 200mv) are determined by the users' applicati=
ons. Users can freely set them according to the range they want to monitor.
it controls the level at which interrupts occur, and is therefore not
suitable for DT.

Cheers,
Conor.

--agohQFK3DQNGsMAx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag81xAAKCRB4tDGHoIJi
0sFoAQCQDItEEWhdZzQ3dHjRK5GKPGLVqmqFoOawfYUgtLVjcAEAgvjg4V6jOywz
vPslUbxs262tAVwfQ96Jg4cWBNF0IQk=
=k/nI
-----END PGP SIGNATURE-----

--agohQFK3DQNGsMAx--
