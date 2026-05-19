Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713B93F0ABA;
	Tue, 19 May 2026 10:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779184804; cv=none; b=h1mQ/w1L4vGhxgozZCtAone+r80lZTmBZkPSGmFEfTgrz2nE4KkOslWuncYOVCqXQuws0Lkpr8sLE5V3jx9b4IOq7RFLEiOFzOnG5eKmfUwJNKWFGOZcLkN8G2wBPpzVYt1/aeII+5Dk6hEhS+IlwKXIqyFHoXnVKmqhPAFiOKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779184804; c=relaxed/simple;
	bh=uAiScvczUI4O3IsIs5+lkIvh8gaciDdlXIubMhnM/Ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEABA7Sy5ZHSYuKP6kDLsdpSlDHTha4c3Yfr/V7lqB58PnakFJinycCDu1zXi+3I5ytXn287N1el5/X9TP/fyBkackKI+hNXShg3Ffo4mCYFWxPl51G9iE9Ow7QPz884GSmZOCMIpygXBVVbQ13rn/UxY568fQehS4jNhn4fUOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gct/8KWP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gct/8KWP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16DC3C2BCC6;
	Tue, 19 May 2026 10:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779184804;
	bh=uAiScvczUI4O3IsIs5+lkIvh8gaciDdlXIubMhnM/Ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gct/8KWPNYNL0cizP6viBRRDzICv+sJIt1OIlTDUboCm/cyeRRneaX04JU9lDNpqJ
	 JbcThIHqxwlCCaVsh3QNNbphNiAS2ASHg7I7YWQsneEJqdaD+KHCxj/452N/yrSY/l
	 xEDEDag8+ZHMXV/ltaQArvyR8P562k66ybKDNZTgKAsmZYExJW5uJ/hNQn3Qf1d82t
	 htzgXf8w8gyx2yhNQAk+oAw+a6r9JAbT/kGg2SuWmMNaxOWmRoXXkwosPMI2SF4G09
	 OAm7OIeJvQJUeg03Qhz3KxuCyi0WiZ23VT1lg45wsRxLAdKOFdl6OQT7NJiXvntpMB
	 N59HylcbfD+GQ==
Date: Tue, 19 May 2026 10:59:59 +0100
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
Message-ID: <20260519-undoing-ambitious-012d608ebd7f@spud>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cVzWKkqrBwvAqBeG"
Content-Disposition: inline
In-Reply-To: <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>


--cVzWKkqrBwvAqBeG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 09:26:03AM +0000, Xingyu Wu wrote:
> On 2026/5/19 00:24, Conor Dooley wrote:
> >=20
> > On Mon, May 18, 2026 at 04:18:51PM +0800, Xingyu Wu wrote:
> > > Add the new documentation of SAR-ADC for the StarFive JHB100 SoC.
> > >
> > > Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> > > ---
> > >  .../iio/adc/starfive,jhb100-saradc.yaml       | 62 +++++++++++++++++=
++
> > >  1 file changed, 62 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yaml
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yam
> > > l
> > > b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc.yam
> > > l
> > > new file mode 100644
> > > index 000000000000..ba8e19b72ad7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/starfive,jhb100-saradc
> > > +++ .yaml
> > > @@ -0,0 +1,62 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +http://devicetree.org/schemas/iio/adc/starfive,jhb100-saradc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Successive Approximation Register (SAR) A/D converter for the
> > > +StarFive JHB100 SoC
> > > +
> > > +maintainers:
> > > +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: starfive,jhb100-saradc
> > > +
> > > +  reg:
> > > +    maxItem: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    maxItems: 1
> > > +
> > > +  resets:
> > > +    maxItems: 2
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +  upper-bound-mv:
> > > +    description: The upper bound voltage value of the monitor.
> > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > +
> > > +  lower-bound-mv:
> > > +    description: The lower bound voltage value of the monitor.
> > > +    $ref: /schemas/types.yaml#/definitions/uint16
> > > +
> > > +  scan-freq:
> > > +    description: Number of the scan cycle interval.
> > > +    $ref: /schemas/types.yaml#/definitions/uint16
> >=20
> > Can you explain why any of these three properties are something that sh=
ould be in
> > the devicetree rather than software controlled?
>=20
> My intention is to be able to obtain the initial values from the devicetr=
ee during probe and preset them.
> Do I need to drop them and just set them through sysfs?

Unless the hardware configuration determines the values (which I can't
really see being the case for scan-freq at least) then yes, you need to
drop and set them via sysfs.

> > How are the bounds calculated?
>=20
> The measurement range of this ADC hardware is from 0 to 1800 mV. This set=
 value cannot exceed it. This explanation will be added later.

I'm asking how this is calculated so that I can tell if you the property
is permitted or not.=20

Cheers,
Conor.

--cVzWKkqrBwvAqBeG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagw0nwAKCRB4tDGHoIJi
0hCiAQCUqcpmQkzaUypN9U0GqbGgA3LpY8xMgAIm4L+K8XQaiQEA4V2Z0epYb85N
XR1/AqfdtL5G5oynVOg0Vv/ReV12iA4=
=+IcM
-----END PGP SIGNATURE-----

--cVzWKkqrBwvAqBeG--
