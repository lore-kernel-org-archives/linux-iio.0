Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCF5381B14;
	Thu, 21 May 2026 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779358858; cv=none; b=gyhIIN3cYDZavI/tchD7kSb1PXagWJEfaxw+pn8xPLZO31ibl6/WUb+JoJmrDBGrWikwk2W4qFlqiC2GMlmCJ6tUge9wWYiUL32A5XUFs5vPz/6rV9pINNEbP1MLndxek7P5b3WpmvAjEXzyMBCq750bKMS2y4khWDoOT99Tqf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779358858; c=relaxed/simple;
	bh=a2ncnNV7IjmKEJ9IsUGpN7Bf+hyEtIkIWwk+JzChYko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jG51+Bh7JlSoMNflXq+hl09OpEuLemiYmbCExTCPjneZ5WCzhFDaqLivoEs7Z4Ncv6h6iY8jcUV4f/qL/1Cq3DgHCakS3jmLFa7/na5biqc5VHgdzBEjunzqQBDywC2VPMfGDJk6ooYTmW2wyT6rtJMleHvOtX2uh5Gj0yJyefU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ptinu+N2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ptinu+N2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C57401F000E9;
	Thu, 21 May 2026 10:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779358856;
	bh=T5V9Yj5pfgawijtZVx/ydtOTEzD3j6n+Tyt9ivz7/j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ptinu+N2T7WV9+RwrtCJRB9IyHjxi4mvaxHXBpCcR0Od7e6WqKGoQBQQiJ88f0r2x
	 Oi87vuLsc+kgU0976zsoJdoE9DtAdppvPZtEyod4PMeM0Q9ucQafayWEFtUCjrn+9Y
	 5lHcudhPXAzE40gupeCf7DYp2oRV9zX4q0jAxYIrFKIUN8+EAESatMD8qJZx3Q3nQ2
	 QeU/2JnYx1g/IUlVbmpe1bf9sBffjxpKNBFg62jC86YL/gD/14rcfsRMcXoZf/FMQN
	 PEUmt9EsdkZbaIVvq1tnyCMT5+U/sHzUxeNf5WQps5axtcXJ7ZbEBriBxuA9RctOa8
	 Eok8Y2SuDQoKw==
Date: Thu, 21 May 2026 11:20:52 +0100
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
Message-ID: <20260521-growing-brunt-4e5a9f955a4f@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260520-relic-chloride-c5cdb96696ce@spud>
 <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="bOKcuUqf1MiQTvxJ"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--bOKcuUqf1MiQTvxJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 09:54:27AM +0000, Xingyu Wu wrote:
> On 2026/5/20 23:15, Conor Dooley wrote:
> >=20
> > On Wed, May 20, 2026 at 09:43:02AM +0000, Xingyu Wu wrote:
> > > On 2026/5/19 18:00, Conor Dooley wrote:
> > > >
> > > > On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> > > > > On 2026/5/19 00:24, Conor Dooley wrote:
> > > > > >
> > > > > > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > > > > > > Add the new documentation of SAR-ADC for the StarFive JHB100 =
SoC.
> > > > > > >
> > > > > > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > ---
> > > > > > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++=
++++++++++
> > > > > > >  1 file changed, 62 insertions(+)  create mode 100644
> > > > > > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sara
> > > > > > > dc.y
> > > > > > > aml
> > > > > > >
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > > radc
> > > > > > > .yam
> > > > > > > l
> > > > > > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-sa
> > > > > > > radc
> > > > > > > .yam
> > > > > > > l
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..ba8e19b72ad7
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb10
> > > > > > > +++ 0-sa
> > > > > > > +++ radc
> > > > > > > +++ .yaml
> > > > > > > @@ -0,0 +1,62 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML
> > > > > > > +1.2
> > > > > > > +---
> > > > > > > +$id:
> > > > > > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.
> > > > > > > +yaml
> > > > > > > +#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: Successive Approximation Register (SAR) A/D converter
> > > > > > > +for the StarFive JHB100 SoC
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    const: starfive,jhb100-saradc
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    maxItem: 1
> > > > > > > +
> > > > > > > +  interrupts:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  resets:
> > > > > > > +    maxItems: 2
> > > > > > > +
> > > > > > > +  "#io-channel-cells":
> > > > > > > +    const: 1
> > > > > > > +
> > > > > > > +  upper-bound-mv:
> > > > > > > +    description: The upper bound voltage value of the monito=
r.
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > +
> > > > > > > +  lower-bound-mv:
> > > > > > > +    description: The lower bound voltage value of the monito=
r.
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > > > +
> > > > > > > +  scan-freq:
> > > > > > > +    description: Number of the scan cycle interval.
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > > > >
> > > > > > Can you explain why any of these three properties are something
> > > > > > that should be in the devicetree rather than software controlle=
d?
> > > > >
> > > > > My intention is to be able to obtain the initial values from the
> > > > > devicetree during
> > > > probe and preset them.
> > > > > Do I need to drop them and just set them through sysfs?
> > > >
> > > > Unless the hardware configuration determines the values (which I
> > > > can't really see being the case for scan-freq at least) then yes,
> > > > you need to drop and set them via sysfs.
> > >
> > > The ADC hardware can be set the scan-freq register to determine how f=
requent it
> > should scan its inputs.
> > > The calculation is:
> > > 	frequency =3D 100/((register value) + 5) MHz, The register value sho=
uld >=3D 15.
> > > The maximum allowable scan frequency is 5MHz.
> > >
> > > >
> > > > > > How are the bounds calculated?
> > > > >
> > > > > The measurement range of this ADC hardware is from 0 to 1800 mV.
> > > > > This set
> > > > value cannot exceed it. This explanation will be added later.
> > > >
> > > > I'm asking how this is calculated so that I can tell if you the
> > > > property is permitted or not.
> > >
> > > The calculation of bound is:
> > > bound-mv =3D 1800mv * (register value) / 0xFFF
> >=20
> > These are the formulas, but how does someone know what the value for bo=
und-
> > mv needs to be? Why would someone not just want to always use 1800mv?
> >=20
>=20
> Can I add the 'maximum' and ' minimum' to provide clarification? And the =
driver will also check.

All that does is repeat the 1800 mV though, what I am interested in is
how someone determines if they should use 1600 mV or 200 mV etc. What
aspect of the hardware do the bounds depend on?

--bOKcuUqf1MiQTvxJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCag7chAAKCRB4tDGHoIJi
0ntOAQDC7PikN8qCI9rfAshmRg+nClMVsUR5T/g+2MPrswZ3ggD/SiBGA8M5X4Mi
+xmwdcH3kQ44q4bY1SeVsDxrfgYD6AY=
=po+Y
-----END PGP SIGNATURE-----

--bOKcuUqf1MiQTvxJ--
