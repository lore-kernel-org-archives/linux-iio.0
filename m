Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795803411;
	b=Vb5EXk5aI4UCoBCCkLCmBRHAw1NaS59tx9tABI6XbQN0a3UQn+ZZCLavPMshtCIqkOnG
	 g33+1Bzats/Hwj9ym2VwBlLRNVxAARMVP1WDo71Skhm0snrIK3Cg8MpmjzcHRXGgVWXY9
	 hjOUgB3gUjJaGAU4IxTdKzE3G0U9MJeKIMOSQ5jAFmjAHX8bO0x4cvOl1wpO8fxciw3Hd
	 WbKsfaGo7LcETAOMx/H3I+Dcv9jIsrDXeDEUxJ6Ov/+TmTo5aLD6RoILVAIFjDZ3ze7Uu
	 5ArodUprNuNAEOGZEQLU9+NvNz9plF8ET4bf1xUPRg4mpQzDFLh9YYSpyspTV67ksbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795803411;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=TwQ5+poHQt70GNjq0hNt+O/ZyTbGgJobuW6RMudpiyY=;
	b=WxuxMQ0uMmk+HSu6aDry9jVwGoB+EZk0U8rPDP3k0HY5HPGRMofxeziZmSUyOoEki8NY
	 J7+3tvLYSUIg+Uk3BuoRpA2AfUS5IsgnlrKkHAY7LzG8fA03Dm6Jt47U7IRFyc5mYCzF8
	 WIWHlvCIIgoLFquWKQ/6YJrOOPOXiY/vN0Sggi6FIJEEGEyZAUK6D1kuo4PanjQkhuLsn
	 6Atfkoo3q+F8qFqfXt3tn+dRu1fG86aT5x2j/5hw+shbUoBZ4P2gqksWc01FkTJ1hJtIH
	 zpN0SYEaVQVGbddjb9EVB75GUdDW+w/5+hUBLYfMy4i78bjiGHHGxI+epOrGMy791RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYzeKJM0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6588606A31C;
	Fri, 27 Nov 2026 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aYzeKJM0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C4E1F00893;
	Fri, 27 Nov 2026 18:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795803411;
	bh=TwQ5+poHQt70GNjq0hNt+O/ZyTbGgJobuW6RMudpiyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aYzeKJM0oXzjZjlJU8hTHJKS5IOUPyxNoEt3ohmnIiZ7cKKOmfx3LbdkdUX84Oyce
	 WDxr8z3DHA8iu/4+ZTy27ZNqRMoL8IqqZtXl8ZFEwQ4H6eDmnh8G6e6oaIu4jyX0JY
	 GAk10xQ22ZBnpG7PAAkA8/tIgHdjk29T7OqCpwTqWWJAAvBumGaSTs1t4Ef2BhOBgL
	 eytpouMWQYYcU+JpR8xqd2sNrwfxtdNYkIyPzpd+gQgh1XdnjSQs+mhT1rLZBcUKaZ
	 YbMoEHTPZ5izrDNgXiWPR6FXgpG4HCcIRZRGd/8LKAKEu7o9sHvIHLkI1JLchRwPRF
	 nP/ry1v1XzVkQ==
Date: Fri, 27 Nov 2026 18:16:46 +0000
From: Conor Dooley <conor@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux@analog.com,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/6] dt-bindings: iio: adc: add AD7793 and similar ADCs
Message-ID: <20261127-vertigo-smoking-fe2f90e28c88@spud>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <20261125-iio-adi-legacy-platdata-v1-5-54e4c8830b57@analog.com>
 <20261125-whenever-spinning-36a6dc477a00@spud>
 <awgLBWt6MWIRK-cM@nsa>
 <20261126-hunter-catatonic-12f9c835f94e@spud>
 <awlg_vzuEmw95dQM@nsa>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JNEX2uBHo/cCsBlR"
Content-Disposition: inline
In-Reply-To: <awlg_vzuEmw95dQM@nsa>

--JNEX2uBHo/cCsBlR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2026 at 11:04:36AM +0000, Nuno S=E1 wrote:
> On Thu, Nov 26, 2026 at 06:25:13PM +0000, Conor Dooley wrote:
> > On Thu, Nov 26, 2026 at 12:24:28PM +0000, Nuno S=E1 wrote:
> > > On Wed, Nov 25, 2026 at 05:41:08PM +0000, Conor Dooley wrote:
> > > > On Wed, Nov 25, 2026 at 10:19:21AM +0000, Nuno S=E1 wrote:
> > > > > Add a binding for the AD7785, AD7792, AD7793, AD7794, AD7795, AD7=
796,
> > > > > AD7797, AD7798 and AD7799 low power sigma-delta ADCs. The driver =
has
> > > > > supported these parts for a long time, but only through platform =
data.
> > > > >=20
> > > > > The ADC reference is described by which supplies are present: REF=
IN
> > > > > (REFIN1 on the AD7794/AD7795), then REFIN2, and otherwise the int=
ernal
> > > > > 1.17 V reference. In the same way, an external clock on the CLK p=
in is
> > > > > used if one is given, and the internal 64 kHz clock otherwise.
> > > > >=20
> > > > > The remaining properties describe how the analog front end is wir=
ed:
> > > > > the input buffer (enabled by default, as it is at power-up), unip=
olar
> > > > > or bipolar coding, the burnout current sources, the bias voltage
> > > > > generator and the excitation current sources.
> > > > >=20
> > > > > Signed-off-by: Nuno S=E1 <nuno.sa@analog.com>
> > > > > ---
> > > > >  .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++=
++++++++++++++
> > > > >  MAINTAINERS                                        |  10 +
> > > > >  2 files changed, 246 insertions(+)
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7793=
=2Eyaml b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > > > new file mode 100644
> > > > > index 000000000000..c4a0be06e5c0
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
> > > > > @@ -0,0 +1,236 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/adi,ad7793.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: Analog Devices AD7793 and similar sigma-delta ADCs
> > > > > +
> > > > > +maintainers:
> > > > > +  - Michael Hennerich <michael.hennerich@analog.com>
> > > > > +  - Nuno S=E1 <nuno.sa@analog.com>
> > > > > +
> > > > > +description:
> > > > > +  Low power, low noise sigma-delta ADCs with an SPI interface.
> > > > > +
> > > > > +  https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7785.pdf
> > > > > +  https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7792_7793.pdf
> > > > > +  https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7794_7795.pdf
> > > > > +  https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7796_7797.pdf
> > > > > +  https://www.analog.com/media/en/technical-documentation/data-s=
heets/AD7798_7799.pdf
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - adi,ad7785
> > > > > +      - adi,ad7792
> > > > > +      - adi,ad7793
> > > > > +      - adi,ad7794
> > > > > +      - adi,ad7795
> > > > > +      - adi,ad7796
> > > > > +      - adi,ad7797
> > > > > +      - adi,ad7798
> > > > > +      - adi,ad7799
> > > > > +
> > > > > +  reg:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  spi-cpol: true
> > > > > +
> > > > > +  spi-cpha: true
> > > > > +
> > > > > +  interrupts:
> > > > > +    description: Interrupt connected to the DOUT/RDY pin.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  rdy-gpios:
> > > > > +    description:
> > > > > +      GPIO reading the DOUT/RDY line. DOUT/RDY also toggles duri=
ng SPI
> > > > > +      transfers, which usually triggers spurious interrupts. Rea=
ding this GPIO
> > > > > +      allows to tell those apart from real conversion done event=
s.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  avdd-supply: true
> > > > > +
> > > > > +  dvdd-supply: true
> > > > > +
> > > > > +  refin-supply:
> > > > > +    description:
> > > > > +      External reference applied between REFIN(+) and REFIN(-), =
or between
> > > > > +      REFIN1(+) and REFIN1(-) on the AD7794 and AD7795. If prese=
nt, it is used
> > > > > +      as the ADC reference. If neither refin-supply nor refin2-s=
upply are
> > > > > +      present, the internal 1.17 V reference is used.
> > > > > +
> > > > > +  refin2-supply:
> > > > > +    description:
> > > > > +      External reference applied between REFIN2(+) and REFIN2(-)=
=2E Used as the
> > > > > +      ADC reference if refin-supply is not present.
> > > > > +
> > > > > +  clocks:
> > > > > +    description:
> > > > > +      External clock connected to the CLK pin. Either 64 kHz, or=
 128 kHz in
> > > > > +      which case it gets divided by 2 internally. If not present=
, the internal
> > > > > +      64 kHz clock is used.
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  bipolar:
> > > > > +    description: see Documentation/devicetree/bindings/iio/adc/a=
dc.yaml
> > > > > +    type: boolean
> > > >=20
> > > > This is odd, why not ref the file normally?
> > >=20
> > > Yes, was not sure on this one but saw precedence in:
> > >=20
> > > https://elixir.bootlin.com/linux/v7.4-rc1/source/Documentation/device=
tree/bindings/iio/adc/adi,ad7192.yaml#L106
> > >=20
> > > Which might obviously be wrong! And I just noticed that in that one we
> > > do have it again referenced in the channel properties. So it might be
> > > just some legacy thing.
> >=20
> > Ah right of course, adc.yaml is for channels...
> >=20
> > >=20
> > > But in here the case is really this is a device wide (not per channel)
> > > property. But I realize that can just do:
> > >=20
> > > $ref: /schemas/iio/adc/adc.yaml#/properties/bipolar
> > >=20
> > > right?
> >=20
> > Happens a good bit for ports, I don't see why not here either.
>=20
> Will do.
>=20
> >=20
> > >=20
> > > >=20
> > > > > +
> > > > > +  adi,buffer-disable:
> > > > > +    description:
> > > > > +      Operate the analog inputs in unbuffered mode. Unbuffered m=
ode allows the
> > > > > +      inputs to go from 30 mV below GND to 30 mV above AVDD, whi=
le buffered
> > > > > +      mode needs 100 mV of headroom to the supply rails but tole=
rates source
> > > > > +      impedances in front of the inputs. Buffered mode is always=
 used for gains
> > > > > +      higher than 2.
> > > > > +    type: boolean
> > > >=20
> > > > What determines if the gain is higher than 2?
> > >=20
> > > Userspace does, through the scale attribute. So this property only ha=
s an effect when the gain is 1 or 2.
> > > For higher gains the buffer is always on
> > >=20
> > > >=20
> > > > > +
> > > > > +  adi,burnout-currents-enable:
> > > > > +    description:
> > > > > +      Enable the 100 nA burnout current sources in the signal pa=
th, which allow
> > > > > +      to detect an open circuit on the selected analog input. Th=
ey can only be
> > > > > +      enabled when either the buffer or the in-amp is active.
> > > >=20
> > > > The former should be somewhat enforceable with the binding, what
> > > > determins this in-amp's setting?
> > >=20
> > > Same deal. For gains >=3D 4, the in-amp becomes active in the path (a=
nd the buffer is forced on),
> > > so there's no way we can enforce this at the binding level:
> > >=20
> > > For gains 1 or 2, with adi,buffer-disable, adi,burnout-currents-enabl=
e is irrelevant, as the
> > > datasheet onl allows the burnout currents with the buffer or in-amp a=
ctive.
> > >=20
> > > For gains >=3D 4 it's the other way around: adi,buffer-disable is irr=
elevant.
> > >=20
> > > So it should be the driver to make sure all of it remains sane.
> > >=20
> > > But I did take a look on the datasheet and this actually seems wrong =
to
> > > be honest (the burnout stuff). Datasheet:
> > >=20
> > > "These currents can be used to verify that an external transducer is =
still operational before
> > > attempting to take measurements on that channel."
> > > "For normal operation, these burnout currents are turned off by writi=
ng a 0 to the BO bit
> > > in the configuration register."
> > >=20
> > > So I'll just drop the burnout property and maybe have it as a debugfs
> > > thing.
> >=20
> > For both of these properties, I think meaning assigned to them should
> > change (if kept). e.g. buffer-disable should not be a property that
> > disables the buffer, but instead tells software that the conditions for
> > disabling the buffer have been met by the hardware, and it is up to the
> > software to disable it if the gain is suitable. I assume that the buffer
>=20
> Maybe adi,low-source-impedance then? Disabling the input buffer is

Sure.

> basically handy when the source impedance is low enough so that we can
> disable the buffer and have no gain errors which allows for less power
> consumption and extend the input range by 30mV.

--JNEX2uBHo/cCsBlR
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCawnJDgAKCRB4tDGHoIJi
0m9EAQDxr4TDLdKaX6/x8BHDDe0v5RlyDDXeq12cGT9cLsQQ5QD9HYWMjpz5+FQd
j8FUt3TUML17mx1fZzJ5Gf49mbeA+g8=
=vrND
-----END PGP SIGNATURE-----

--JNEX2uBHo/cCsBlR--
