Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573F0392C5F;
	Wed, 20 May 2026 15:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290081; cv=none; b=PwVhAEGJzdw71siOmuLcAmrK0oZQS9WCDwgb2YHjeJdTvvuXfH5Y4+Bjo2Ejrv6Y/KrFqSjp4ZNxUQ0o7fNhfGiyG6YoAXsN+S8YUefzNrrex/JRvcF7vPSJKkHdDFqPLJG7XzrfS+nIcI4DGtU6McIjR7WLb4nohiBL7jpyySI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290081; c=relaxed/simple;
	bh=F8Y8cI/SIAskckkrr4sUehEYGbbKBZ80V4hJvJD079I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qimyiICTbPqUPBDMGIHvH1i+8PF1NXuG+KpcCaOwkWiaYYh2VGuSNgg3idib99P0HtdSW08KWUz0/HpQo5AvQExIiF8Wrw16VS+/Z7o28JFiqFsf/H2PFq84h+cKbLxpHyvNYDAW2baJcH9C7p4GjeLS5Nq60muIn1aJ9sm2WNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfpDwSgC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfpDwSgC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB541F000E9;
	Wed, 20 May 2026 15:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779290080;
	bh=XbX/87GI1uNFOuP32RszaxPrfcBWBCvRmCZexvI/vZs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RfpDwSgCJrnsvRUvCN6jQnKZTI6NwM7ueAVpGCmH0ZWh8ZvZMZgWkEqumJQmLqLiQ
	 cbAYsEKIBdgjYtKmBkCBOeJ3caukH7gbc6TEVO3LImugseY3TgrRBD/BBXtPr6++dq
	 tMi3TU5QNDKfJombcsip6g0xlJZxkZOk8e6PLkrKUCbFnjkb0yfORIlPaoPlANcIuX
	 Dg+bVaFuj14rsNYwnWu3RXrsGFz8RRVeH2zRp/fgBPgHOnnDaL1yE7ppgIzSW4h2zV
	 6yIs8ISCNVA1vtnhhpBemNuDHYk6s8JZfaBVInVbYswzpAk3hQRVxDtoFaZGCcumym
	 udqetJBTOR/3w==
Date: Wed, 20 May 2026 16:14:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Xingyu Wu <xingyu.wu@starfivetech.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Message-ID: <20260520-relic-chloride-c5cdb96696ce@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DHsYS039fMOlZLHv"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--DHsYS039fMOlZLHv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote:
> On 2026/5/19 18:00, Conor Dooley wrote:
> >=20
> > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> > > On 2026/5/19 00:24, Conor Dooley wrote:
> > > >
> > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > > > > Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> > > > >
> > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > ---
> > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++=
++++++
> > > > >  1 file changed, 62 insertions(+)
> > > > >  create mode 100644
> > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.y
> > > > > aml
> > > > >
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > > > > .yam
> > > > > l
> > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > > > > .yam
> > > > > l
> > > > > new file mode 100644
> > > > > index 000000000000..ba8e19b72ad7
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > +++ radc
> > > > > +++ .yaml
> > > > > @@ -0,0 +1,62 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > > > +---
> > > > > +$id:
> > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml
> > > > > +#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Successive Approximation Register (SAR) A/D converter for
> > > > > +the StarFive JHB100 SoC
> > > > > +
> > > > > +maintainers:
> > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    const: starfive,jhb100-saradc
> > > > > +
> > > > > +  reg:
> > > > > +    maxItem: 1
> > > > > +
> > > > > +  interrupts:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clocks:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  resets:
> > > > > +    maxItems: 2
> > > > > +
> > > > > +  "#io-channel-cells":
> > > > > +    const: 1
> > > > > +
> > > > > +  upper-bound-mv:
> > > > > +    description: The upper bound voltage value of the monitor.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > +
> > > > > +  lower-bound-mv:
> > > > > +    description: The lower bound voltage value of the monitor.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > +
> > > > > +  scan-freq:
> > > > > +    description: Number of the scan cycle interval.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > >
> > > > Can you explain why any of these three properties are something that
> > > > should be in the devicetree rather than software controlled?
> > >
> > > My intention is to be able to obtain the initial values from the devi=
cetree during
> > probe and preset them.
> > > Do I need to drop them and just set them through sysfs?
> >=20
> > Unless the hardware configuration determines the values (which I can't =
really see
> > being the case for scan-freq at least) then yes, you need to drop and s=
et them via
> > sysfs.
>=20
> The ADC hardware can be set the scan-freq register to determine how frequ=
ent it should scan its inputs.
> The calculation is:
> 	frequency =3D 100/((register value) + 5) MHz, The register value should =
>=3D 15.
> The maximum allowable scan frequency is 5MHz.=20
>=20
> >=20
> > > > How are the bounds calculated?
> > >
> > > The measurement range of this ADC hardware is from 0 to 1800 mV. This=
 set
> > value cannot exceed it. This explanation will be added later.
> >=20
> > I'm asking how this is calculated so that I can tell if you the propert=
y is permitted or
> > not.
>=20
> The calculation of bound is:
> bound-mv =3D 1800mv * (register value) / 0xFFF

These are the formulas, but how does someone know what the value for
bound-mv needs to be? Why would someone not just want to always use
1800mv?

>=20
> Best regards,
> Xingyu Wu
>=20

--DHsYS039fMOlZLHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag3P2wAKCRB4tDGHoIJi
0r3MAQCKOqNpxB79fsS+sZ9SbV8dV4T7rzFe/+1tif1AeXMLDAEA7Pg9kUwoEkKh
pYc74wuBveR4RyZ5gbUp43rAN9GxKA0=
=3z1+
-----END PGP SIGNATURE-----

--DHsYS039fMOlZLHv--
