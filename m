Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2784C1FB1;
	Sun, 22 Feb 2026 20:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792299; cv=none; b=OKo0X0IrNnAPVPFDWEsjtzqFBV9W5Lh4ro6k9JqzlFJh6U0rWx+zZB0otIjwpcQ5GborLFAbreHC+dKU+72UdKSnQj4Y2v7UItOb4KadsUrFCc2k0dO2GhXsKN9wLQ/1hn8S19D5UTZaOcEdM03F/2A4ehM1TTWcdzL9Nnq3rNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792299; c=relaxed/simple;
	bh=QDzA1BJmOlER6MfdknxfJWRYhncHtlKGoUaInW+Autk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snzFAa8wKIpQr0rbYzWZR5APgDhmOrEjhXCQ3x+azU1HREXbbhVnIZqDP+ydl3eri+ttyS3EM3QJy5lZfSxPCCD5N7GBgASmhMXIrSGSbQkbTZOxvmBK5HYj0g4Ad96SOSqFd+LFJ2QTvirw+AgQO6MN1RhYebAIF/oCZ6Rq1c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQndXCUb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQndXCUb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11593C116D0;
	Sun, 22 Feb 2026 20:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771792298;
	bh=QDzA1BJmOlER6MfdknxfJWRYhncHtlKGoUaInW+Autk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bQndXCUbRqG5LVj6e4/FrLm/OBzANnSATqVpGOa+DyCsLySEWRDJfPZe69FnYr9OG
	 EVnqFi3CzXTFxSwJStaA0wLJKw4MTeGEX2ajvRMLzcWCdPI1cYQgBo964cCM2OaFeH
	 BSbS8QH0l3bE3meecxjCQGtdMDA6969P7vYbeEEXZFGewKrd1OtET35qFhwMywDdLD
	 yvJU4YkUh2bVGCUHRh4k/F+BkZ8OQsP+K61g/Fp84rFmmF2Ap2OhcOelvLQdJdG1Q7
	 Kqb7CShwygW0gAMcgdCnsxUQgvL5l9YL/KuB1eL4LdDzsUroXYkPj1KsvVElFqeoIW
	 YDNo1Dddfu70A==
Date: Sun, 22 Feb 2026 20:31:33 +0000
From: Conor Dooley <conor@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH RFC 1/8] dt-bindings: iio: frequency: add ad9910
Message-ID: <20260222-waking-crumpled-99560bc96985@spud>
References: <20260220-ad9910-iio-driver-v1-0-3b264aa48a10@analog.com>
 <20260220-ad9910-iio-driver-v1-1-3b264aa48a10@analog.com>
 <41190a42-70ab-45b9-922f-317e792b25a0@baylibre.com>
 <n5oxnxatgdqpomuijz6avvautkndg7r52kmobakemcgggdkjh2@q7m6h2ndjx7w>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XOOlD0HUpO/PpCZo"
Content-Disposition: inline
In-Reply-To: <n5oxnxatgdqpomuijz6avvautkndg7r52kmobakemcgggdkjh2@q7m6h2ndjx7w>


--XOOlD0HUpO/PpCZo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 22, 2026 at 10:47:41AM +0000, Rodrigo Alencar wrote:
> On 26/02/21 02:43PM, David Lechner wrote:
> > On 2/20/26 10:46 AM, Rodrigo Alencar via B4 Relay wrote:
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>

> > > +
> > > +  reset-gpios:
> > > +    maxItems: 2
> > > +    description:
> > > +      GPIOs controlling the device reset and the I/O_RESET pins. Thi=
s is only
> > > +      used if resets property is not defined.
> > > +
> > > +  powerdown-gpios:
> > > +    maxItems: 1
> > > +    description:
> > > +      GPIO controlling the EXT_PWR_DWN pin.
> > > +
> > > +  update-gpios:
> > > +    maxItems: 1
> > > +    description:
> > > +      GPIO controlling the I/O_UPDATE pin.
> > > +
> > > +  profile-gpios:
> > > +    minItems: 3
> > > +    maxItems: 3
> > > +    description:
> > > +      GPIOs controlling the PROFILE[2:0] pins for profile selection.
> > > +
> >=20
> > Looks like possibly some interrupts as well: RAM_SWP_OVR and SYNC_SMP_E=
RR
>=20
> Interrupts are not handled by the driver at this point, so they were not =
added
> here. The device is meant to have some features exposed through SPI, but =
to
> extract the most of it needs to interface with an FPGA. For that, an IIO
> backend is in the works.

The binding should be complete, if there are interrupts then document
them even if the driver doesn't use them. If this is where you say you
mentioned the io-backends, that's not what I meant - you need to do it
in the patch itself to explain why you have the odd setup with resets
and reset-gpios.
That said, if you don't know what the io-backends stuff is going to look
like for this device, you should probably exclude those resets until the
design for the io-backend IP is complete. reset-gpios are usually
optional anyway (since they are often just wired high/low), so there
shouldn't be any downside there.

> > > +  adi,pll-multiplier:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 12
> > > +    maximum: 127
> > > +    description:
> > > +      PLL feedback divider value (N). The system clock frequency is
> > > +      REFCLK * N. When not specified, the PLL is bypassed.
> >=20
> > What determines the value that should be selected here? This doesn't se=
em like
> > something we would normally put in the devicetree. (Smells like configu=
ration
> > rather than describing what is wired up.)
>=20
> The sysclk frequency is something we want fixed because it derives the sy=
nc_clk
> and pd_clk which can be constraints for FPGA desing or when interfacing w=
ith

btw, the datasheet for this device (rev e) says:
| SYNC_CLK is a rising edge active signal. It is derived from the
| system clock and a divide-by-4 frequency divider. SYNC_CLK,
| which is externally provided, can be used to synchronize external
| hardware to the AD9910 internal clocks.

It's not externally provided, so the third sentence here is confusing.

> the parallel port (high-speed up to 250 MHz). Also, when using the PLL pa=
th to
> derive the sysclk, the external loop filter will pretty much define the v=
alues
> to be used here, as it would be optimized for a certain frequency range.
>=20
> > > +
> > > +  adi,pll-vco-select:
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +    minimum: 0
> > > +    maximum: 5
> > > +    description: |
> > > +      VCO frequency range selection (0-5). When not specified and th=
e PLL
> > > +      is enabled, the VCO range is automatically selected based on t=
he
> > > +      computed system clock frequency. Typical VCO frequency ranges =
are:
> > > +      - Range 0: 370 MHz to 510 MHz (Auto-selected when <=3D 465 MHz)
> > > +      - Range 1: 420 MHz to 590 MHz (Auto-selected when > 465 MHz an=
d <=3D 545 MHz)
> > > +      - Range 2: 500 MHz to 700 MHz (Auto-selected when > 545 MHz an=
d <=3D 650 MHz)
> > > +      - Range 3: 600 MHz to 880 MHz (Auto-selected when > 650 MHz an=
d <=3D 790 MHz)
> > > +      - Range 4: 700 MHz to 950 MHz (Auto-selected when > 790 MHz an=
d <=3D 885 MHz)
> > > +      - Range 5: 820 MHz to 1050 MHz (Auto-selected when > 885 MHz)
> > > +
> >=20
> > Same here. How does this depend on how the chip is wired up?
>=20
> That applies to when the PLL path is used. FPGA interface and loop filter=
 design.
> I can write those details as part of the description.

This property definitely needs justification given that it looks like
the device will just do the right thing without the property.

> > > +
> > > +  adi,sync-clk-disable:
> > > +    type: boolean
> > > +    description:
> > > +      Disable the SYNC_CLK output pin. SYNC_CLK runs at one quarter
> > > +      of the system clock frequency.
> >=20
> > Clock outputs should be described as clock-controller and #clock-cells.
> > The actual enabling/disabling can be done at runtime.
>=20
> I thought of that, but when interfacing with an FPGA, the clock consumer
> will be the IIO backend itself, which this device driver would depend on.
> It would create a cyclic dependency during the probe of the drivers:
> - This device being a clock provider and an IIO backend consumer
> - The FPGA IP being a IIO backend provider and a clock consumer.
>=20
> This would be just save some power when not interfacing with an FPGA,
> there would not be a clock consumer to get the clock disabled.
> Normally, clock consumers would want to have clock enabled, which is
> already the case by default.
>=20
> I would add the FPGA/IIO backend support in a separate patch series,
> as it would bring more stuff here.

Honestly, this binding design seems so tightly integrated with the
io-backend that you're shooting yourself in the foot, and making it hard
for us to review, by not including it. I think this really should be a
clock provider and the io-backend a clock consumer, even if it causes a
cyclical dependency. One of the two can probably be a post-init-provider
to the other, probably something like sync_clk doesn't need to be set at
probe, and setting the rate can be delayed until we start needing data
=66rom the device? Since both sync_clk and pdclk are provided by the
ad9910 to the io-backend, your driver will have control over what the
rates of these clocks are and you shouldn't need to hard code the
multipliers etc. You just need to know if the parallel bus is in use or
not. I'm not sure if that's a given if there's an io-backend and you're
not on a serial bus or if would need a property to identify.

Most of the clocking related properties here seem like they go away if
you make the device a clock-controller, for example the driver should be
able to decide if the needs to enable reference-div2 to achieve the
internal frequencies that it needs. sync-clk-disable would be done
automatically if there's no consumer of sync_clk etc.


--XOOlD0HUpO/PpCZo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZtnpQAKCRB4tDGHoIJi
0v6IAP4lYL2iFc/OVIXYybAQI/OC1Iddg0mDTcakuSAGjr6Q+wD9GWFOc4Zed0/K
lFchSkB31AlXEMAQaLvD79Y58YnpIgY=
=gLI0
-----END PGP SIGNATURE-----

--XOOlD0HUpO/PpCZo--
