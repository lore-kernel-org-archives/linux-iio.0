Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256FD3C1D7B;
	Fri,  9 Oct 2026 19:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791573129; cv=none; b=d+Td1PfSy1iS72B1BK3UEK1Y8l2wGGuPNSeACZLRgISElrHF+D0eGVPg8b3GhFxJFDCjXWeAbt8nH2LHz/gh7ZZlBxaCaGL7beYvkMDGJJypDbZvjHm9CURapLgsyNnec7yDSipt3vx/7lbl/l6FaPvGtrhBEM7XbMd2OmKGBFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791573129; c=relaxed/simple;
	bh=KyR/lL1NmZ7piWi9jIFr2i9mKD8s7N7B7qMj1YshJ/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fKDnJS7UASFDexNgwPgLrk4GGiAE91DJp/XxnoiuMg4S5TM4jIoALFpyoQ4/1A+v0P1pPiuZUgMU3L4Tpyztz8ViJXcGZch3PGQI9gQ0rz2E82/9sWaerS5FqeswjIY29up2527GvZtCNM2WDGpYFd7MDfewN5dWR+iX3QtvXOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hN3RyDdc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hN3RyDdc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED6B1F000FF;
	Fri,  9 Oct 2026 19:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791573126;
	bh=RsF0iWa1jIyQlfz4Z831bWade7RvwRRqmO6a4QpxkNY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hN3RyDdc+XI8bY54/1xj5e3UGVCnDDNmWznvNm3pGWk9JSnWXHDfB/Roi/UdrRTjO
	 1/SttwU8NcNtCAFsZCW04gG3Fy5Y/nJJS54jNI4q9S0loNBOnOv7KLUo5O8EON4fBq
	 9dx85f2BmAs/INBGcnTCpQ525lOCQ0Bsk1uVP1GOnay9YF7a21Xk0S0wOkaLi2byqK
	 DWlXG5e3p0MWZ0pXytbDDVjdMvU7rH/ipSc0/HPgDMB5GbeKQGaE+f6ulJiVWgDDfA
	 oKfN6XcDtEEW20Od3ZkxLdDhZSlJsZD07OwH01lqFASgk/LuC9bC6Av3z139LUwSr8
	 0m4CRFbxTdmAA==
Date: Fri, 9 Oct 2026 20:12:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: adc: add bindings for stm32 mdf
 filter
Message-ID: <20261009-8db882a9fa159f8759aa7327@squawk>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="QAjpR0J89M4SwmDI"
Content-Disposition: inline
In-Reply-To: <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>

--QAjpR0J89M4SwmDI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
> Hi Conor,
>=20
> On 10/8/26 12:11, Conor Dooley wrote:
> > On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
> > > Hi Conor,
> > >=20
> > > Thanks for the review
> > >=20
> > > On 10/1/26 20:32, Conor Dooley wrote:
> > > > On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
> > > > > Add bindings that describes STM32 MDF settings to support
> > > > > digital filtering for Pulse Density Modulation (PDM) microphones
> > > > > and analog sigma delta modulators.
> > > > >=20
> > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > ---
> > > > >    .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 ++++++++++=
++++++++
> > > > >    1 file changed, 383 insertions(+)
> > > > >    create mode 100644 Documentation/devicetree/bindings/iio/adc/s=
t,stm32-mdf-adc.yaml
> > > > >=20
> > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-m=
df-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.ya=
ml
> > > > > new file mode 100644
> > > > > index 000000000000..f2fbc3e150e8
> > > > > --- /dev/null
> > > > > +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-adc.=
yaml
> > > > > @@ -0,0 +1,383 @@
> > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > +%YAML 1.2
> > > > > +---
> > > > > +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.yaml#
> > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > +
> > > > > +title: STMicroelectronics STM32 Multi-function Digital Filter (M=
DF) ADC
> > > > > +
> > > > > +maintainers:
> > > > > +  - Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > +
> > > > > +description: |
> > > > > +  STM32 MDF ADC is a sigma delta analog-to-digital converter ded=
icated to
> > > > > +  interface external sigma delta modulators to STM32 micro contr=
ollers.
> > > > > +
> > > > > +properties:
> > > > > +  compatible:
> > > > > +    enum:
> > > > > +      - st,stm32mp25-mdf
> > > > > +      - st,stm32mp23-mdf
> > > > > +
> > > > > +  reg:
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > >=20
> > > > This needs an items list here. The size of the regions seems like c=
rap
> > > > to begin with...
> > > >=20
> > > > > +
> > > > > +  clocks:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  clock-names:
> > > > > +    description: Internal clock used for MDF digital processing.
> > > > > +    items:
> > > > > +      - const: ker_ck
> > > >=20
> > > > This is pointless when you only have one.
> > > >=20
> > >=20
> > > I agree that it could be dropped. However, it is useful for using
> > > devm_regmap_init_mmio_clk.
> >=20
> > Ah, because that function if you pass NULL to it, it doesn't mean no
> > string, it means no clock.
> >=20
>=20
> The MDF has two clocks (AHB clock for register accesses and ker_ck for
> peripheral processing). However, these two clocks share the same gate. So,
> only the ker_ck clock is exposed in the driver.

That's incorrect, you should have two clocks in DT if the block has two
even if they have a shared gate.

> The regmap api is a convenient way to manage registers and gate the AHB
> clock only on register accesses. Removing clock-names no longer allows you
> to benefit from clock management handled by the regmap framework, and mea=
ns
> that this must be managed explicitly, partially or entirely, in the drive=
r.
>=20
> > >=20
> > > > > +
> > > > > +  "#clock-cells":
> > > > > +    enum: [0, 1]
> > > >=20
> > > > Why is this not fixed? Also why are parts of your own device consum=
ing
> > > > the clocks?
> >=20
> > Reading the docs, this has to be 1, you have two clocks?
> >=20
> > Not sure why you skipped this and skipped explaining why you are
> > consuming your own clocks.
> >=20
>=20
> Yes, we can have two clocks gated independently but sharing the same rate.
>=20
> Using the clock framework apis seemed to me the right way to manage cck1 =
and
> cck0 gating and divider computing. I think I would have to introduce
> proprietary properties and have to implement code in the driver, that wou=
ld
> be handled natively by the framework otherwise.

The CCF is still the right way to do it, especially since CCK0/1 can be
exported to other devices. I don't believe you need to actually have a
reference in DT to do this though, plenty of "real" clock controllers
have only one input clock and hang a whole tree with multiple layers off
that.
Down below I mentioned this under "ouroboros devices", I think this kind
of ability to chose which clock a channel uses is a fairly normal thing
to do in IIO land, I just dunno what the preferred mechanism is - I just
know that it is not referencing yourself (probably it's some sort of
property that you put in a channel node that says 'blah-clock =3D "cck0"',
but better that the IIO folks answer.

> > > > > +  clock-output-names:
> > > > > +    description: |
> > > > > +      CCK0 and CCK1 are optional output clocks, which share the =
same clock frequency,
> > > > > +      but can be gated independently to save power.
> > > > > +    minItems: 1
> > > > > +    maxItems: 2
> > > > > +    oneOf:
> > > > > +      - items:
> > > > > +          - const: cck0
> > > > > +      - items:
> > > > > +          - const: cck1
> > > > > +      - items:
> > > > > +          - const: cck0
> > > > > +          - const: cck1
> > > > > +
> > > > > +  clock-frequency:
> > > > > +    description: |
> > > > > +      Common clock frequency (Hz) for CCK0 and CCK1 output clock=
s.
> > > > > +      The frequency must be a multiple of the "ker_ck" clock fre=
quency.
> > > > > +    maximum: 25000000
> > > >=20
> > > > Should not be needed, the consumers request what they need.
> > > >=20
> > >=20
> > > The CCKx clock frequency depends on the maximum rate supported by the=
 sigma
> > > delta converters (for instance a digital mic) and the expected decima=
tion
> > > ratio on the bitstream. Typically this determines the frequency on th=
e SPI
> > > bus.
> > > This rate is defined statically and shared by the CCKx clocks. So IMH=
O, as
> > > this rate is unique, it can look strange to let the consumer define i=
t.
> > > Moreover, it seems to me that clock-frequency is already used to conf=
igure
> > > the frequency of a provider in some other bindings.
> > > For instance: Documentation/devicetree/bindings/clock/silabs,si570.ya=
ml
> >=20
> > This is a binding from the age of antiquity, using it to justify your
> > use is actually harming your argument rather than helping. Your clock
> > consumers should be providing the information about what the rate should
> > be, and if you need to do this in dt you can use assigned-clock-rates.
> >=20
>=20
> ok, I will move this to clock consumer with assigned-clock properties.
>=20
> > > So, it's not clear for me, what is the restriction on clock-frequency
> > > property.
> > > > > +
> > > > > +  ranges: true
> > > > > +
> > > > > +  clock-ranges: true
> > > > > +
> > > > > +  resets:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  reset-names:
> > > > > +    items:
> > > > > +      - const: mdf
> >=20
> > Same applies here as to the clock names fwiw.
> >=20
>=20
> Yes, I removed this.
>=20
> > > > > +
> > > > > +  access-controllers:
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +    description: |
> > > > > +      Phandle to the rifsc device to check access right.
> > > > > +
> > > > > +  power-domains:
> > > > > +    maxItems: 1
> > > > > +
> > > > > +  st,interleave:
> > > > > +    description: |
> > > > > +      List of phandles of interleaved filters. The indexes of in=
terleaved filters must be
> > > > > +      consecutives starting from 0 (i.e in range [0..N]). The sa=
mples from interleaved filters
> > > > > +      are muxed in a single channel and retrieved through the de=
vice associated to the filter 0.
> > > > > +      The filters 1..N have to be enabled, but inherit their con=
figuration from filter 0.
> > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > >=20
> > > > No idea what these even are, but this is probably not the right way=
 to
> > > > represent the relationship between devices. They're apparently ADCs=
, but
> > > > this is also an ADC so I'm not sure what's going on here at all.
> >=20
> > Yeah, after more thought this should not be done like this at all,
> > especially if these filters the phandle point to are part of this device
> > itself, which I suspect they are. If that's the case, you don't need
> > phandles to even do this, you just need an int that says what N is.
> >=20
>=20
> Yes, can be an index as it is an internal reference. I will change this.
>=20
> > > >=20
> > > > > +
> > > > > +required:
> > > > > +  - compatible
> > > > > +  - reg
> > > > > +  - ranges
> > > > > +  - clocks
> > > > > +  - clock-names
> > > > > +  - clock-ranges
> > > > > +  - "#address-cells"
> > > > > +  - "#size-cells"
> > > > > +
> > > > > +additionalProperties: false
> > > > > +
> > > > > +patternProperties:
> > > > > +  "^sitf@[0-9]+$":
> > > > > +    type: object
> > > > > +    description: Serial interface child node
> > > >=20
> > > > Why is this a child node at all?
> > > > Probably not worth reviewing more without a link to the docs for th=
is
> > > > device so I can figure out what on earth is going on!
> > > >=20
> > >=20
> > > The MDF is a digital filter for sigma-delta bitstreams, rather than t=
he
> > > analog-to-digital converter itself.
> > >=20
> > > Here is the link to STM32MP25 reference manuel
> > > https://www.st.com/resource/en/reference_manual/rm0457-stm32mp2325xx-=
advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
> > > Chapter 45: Multi-function digital filter (MDF)
> > >=20
> > > On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) and 8 =
digital
> > > filters (DFLT) which can be connected through a multiplexer.
> > >=20
> > > Below is a schematic view of typical applications targeted by this
> > > peripheral
> > >=20
> > >=20
> > > Audio use case:
> > >=20
> > > 		mdf
> > >              +-------------------------------------+
> > > +------+    | +------+    +------+    +------+    |
> > > | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio device
> > > +------+    | +------+    +------+    +------+    |
> > >              +-------------------------------------+
> > >=20
> > > For instance, in an audio use case the serial interface can be config=
ured to
> > > provide the clock to the digital microphone (cck0, cck1 or both) at a=
 common
> > > predefined rate, and to retrieve the PDM samples.
> > > The serial interface provides this samples to a digital filter, which
> > > delivers PCM samples on its output.
> > >=20
> > >=20
> > > Analog use case:
> > >=20
> > > 		mdf
> > >                +-------------------------------------+
> > > +--------+    | +------+    +------+    +------+    |
> > > | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio device
> > > +--------+    | +------+    +------+    +------+    |
> > >                +-------------------------------------+
> >=20
> >=20
> > So, looking at the docs and a brief chat with Jonathan about this
> > device, I believe you've got things backwards and this is actually the =
backend,
> > and the adc should be the one populating the io-backends property
> > pointing to this device. You should have io-backend-cells, and I assume
> > that there should be a cell for the adc to select which dlft it is conn=
ected
> > to.
> >=20
>=20
> There have already been lengthy discussions in the past about a DFSDM
> peripheral on STM32MP1, which has features similar to those of the MDF and
> similar implementation constraints. For the DFSDM, a solution based on an
> IIO backend had been upstreamed. The MDF follows the same architecture. I
> need to take a little time to dive back into this issue.

One thing to note there is that you retrofitted the backends onto that
device, and the original design here is much older (it's a text
binding).


>=20
> DFSDM sources:
> drivers/iio/adc/stm32-dfsdm-adc.c
> drivers/iio/adc/stm32-dfsdm-core.c
>=20
> Here is a sample of DFSDM DT
>=20
> sd_adc0: simple-sd-adc0 {
> 	compatible =3D "sd-modulator";
> 	#io-backend-cells =3D <0>;
> 	vref-supply =3D <&v3v3>;

Yeah, pretty sure this is wrong (backwards). The backend is the thing
that gets data from an ADC not the ADC.

Thanks,
Conor.

> };
>=20
> dfsdm0 {
> 	compatible =3D "st,stm32-dfsdm-adc";
> 	...
>=20
> 	channel@0 {
> 		reg =3D <0>;
> 		label =3D "in0";
> 		...
> 		io-backends =3D <&sd_adc0>;
> 	};	=09
> };
>=20
> > I think all of these child nodes should just get deleted - all your
> > devices here seem completely fake, since you've got stuff that's only a
> > single word wide. With that, you could also throw away these mickey
> > mouse nodes with sound-dai-cels of 0, and use 1 instead, with that cell
> > again determining which dlft is in use.
> >=20
> > The only child node I can really thing of any justification for here is
> > channels - albeit not adc channels since this is not an adc - so that
> > you can individually configure a dlft using those channel nodes.
> >=20
> > These serial inputs, what is the source for the data that is ever
> > actually sent there? I am assuming it's effectively another IIO device,
> > just not the onboard adc? Are the outputs exposed on pins on the
> > package?
> >=20
> > I would encourage you to remodel this system, where this device is the
> > backend and also try to get rid of as much of the consuming your own
> > clock as possible. Certainly consuming ker_clk should never be required.
> > It's hard to reason about what should happen with the serial interface
> > clocks, when I have no idea what the input/data source device actually
> > is in those cases. Being a clock controller does make sense, because the
> > device exposes CCK0/1 to the outside world, it's the internal routing to
> > the SITF blocks that I am not sure how to deal with. A ouroboros device
> > that is consuming a clock it provides is not really a done thing,
> > hopefully the IIO guys can tell you how these kinds of things are
> > typically done here, since I'm sure there's plenty of other devices
> > that have some sort of ability to change the clock source for a channel.
> >=20
> > Probably you need to add two optional input clocks to this device, since
> > mdf_cck0/1 can be inputs too?
> >=20
> > Let me know if any of this feedback is intractable stuff, and maybe hang
> > on for someone like David or Jonathan to provide some review before
> > going about a significant rework. It's worth bearing in mind that I am a
> > binding reviewer and not a domain expert in ADCs etc.
> >=20
> > Thanks,
> > Conor.
> >=20
>=20
> Best regards
> Olivier
>=20
> > > > > +
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        enum:
> > > > > +          - st,stm32mp25-sitf-mdf
> > > > > +
> > > > > +      reg:
> > > > > +        description: Specify the SITF serial interface instance
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      clocks:
> > > > > +        description: |
> > > > > +          Serial interface clock (optional depending on interfac=
e mode)
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      st,sitf-mode:
> > > > > +        description: |
> > > > > +          Select serial interface protocol
> > > > > +          - spi: SPI mode
> > > > > +          - lf_spi: low frequency SPI mode for low power applica=
tions
> > > > > +        $ref: /schemas/types.yaml#/definitions/string
> > > > > +        enum:
> > > > > +          - spi
> > > > > +          - lf_spi
> > > > > +
> > > > > +    required:
> > > > > +      - reg
> > > > > +      - st,sitf-mode
> > > > > +
> > > > > +    additionalProperties: false
> > > > > +
> > > > > +  "^filter@[0-9]+$":
> > > > > +    type: object
> > > > > +    description: Digital filter path child node
> > > > > +
> > > > > +    properties:
> > > > > +      compatible:
> > > > > +        enum:
> > > > > +          - st,stm32mp25-mdf-dmic
> > > > > +          - st,stm32mp25-mdf-adc
> > > > > +
> > > > > +      reg:
> > > > > +        description: Specify the MDF filter instance
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      interrupts:
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      clocks:
> > > > > +        minItems: 1
> > > > > +        description: Internal clock used for MDF digital process=
ing and control blocks.
> > > > > +
> > > > > +      clock-names:
> > > > > +        items:
> > > > > +          - const: ker_ck
> > > > > +
> > > > > +      dmas:
> > > > > +        maxItems: 1
> > > > > +
> > > > > +      dma-names:
> > > > > +        items:
> > > > > +          - const: rx
> > > > > +
> > > > > +      "#io-channel-cells":
> > > > > +        const: 1
> > > > > +
> > > > > +      '#address-cells':
> > > > > +        const: 1
> > > > > +
> > > > > +      '#size-cells':
> > > > > +        const: 0
> > > > > +
> > > > > +      st,cic-mode:
> > > > > +        description: |
> > > > > +          Cascaded-integrator-comb (CIC) filter configuration
> > > > > +          - 0: MCIC & ACIC filters in FastSinc mode
> > > > > +          - [1-3]: MCIC & ACIC filters in Sinc mode order 1 to 3
> > > > > +          - [4-5]: Single CIC filter in Sinc mode order 4 to 5
> > > > > +          For audio purpose it is recommended to use CIC Sinc4 o=
r Sinc5
> > > > > +          This property is mandatory for filter 0 or filters not=
 used in interleave mode.
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        minimum: 0
> > > > > +        maximum: 5
> > > > > +
> > > > > +      st,delay:
> > > > > +        description: Filter delay in samples
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        maximum: 127
> > > > > +
> > > > > +      st,rs-filter-bypass:
> > > > > +        description: Bypass RSFLT reshaping filter.
> > > > > +        $ref: /schemas/types.yaml#/definitions/flag
> > > > > +
> > > > > +      st,hpf-filter-cutoff-bp:
> > > > > +        description: |
> > > > > +          High Pass Filter (HPF) cut-off frequency expressed as =
a fraction of the PCM sampling rate.
> > > > > +          Cut-off frequency =3D st,hpf-filter-cutoff-bp x Fpcm /=
 10000.
> > > > > +          If this property is not defined the HPF is disabled.
> > > > > +        enum: [625, 1250, 2500, 9500]
> > > > > +
> > > > > +      st,sync:
> > > > > +        description:
> > > > > +          Synchronize to another filter.
> > > > > +          Must contain the phandle of the filter providing the s=
ynchronization.
> > > > > +        allOf:
> > > > > +          - $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +          - maxItems: 1
> > > > > +
> > > > > +      st,sitf:
> > > > > +        $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > +        items:
> > > > > +          - items:
> > > > > +              - description: Phandle of the serial interface con=
nected to the digital filter
> > > > > +              - description: |
> > > > > +                  The phandle's argument selects the bitstream o=
n the falling or rising edge
> > > > > +                  of the serial interface clock:
> > > > > +                  - 0: rising edge
> > > > > +                  - 1: falling edge
> > > > > +                enum: [0, 1]
> > > > > +                default: 0
> > > > > +        description:
> > > > > +          Should be phandle/bitstream pair.
> > > > > +
> > > > > +    required:
> > > > > +      - compatible
> > > > > +      - reg
> > > > > +      - interrupts
> > > > > +      - dmas
> > > > > +      - dma-names
> > > > > +      - "#io-channel-cells"
> > > > > +      - "#address-cells"
> > > > > +      - "#size-cells"
> > > > > +      - st,sitf
> > > > > +
> > > > > +    unevaluatedProperties: false
> > > > > +
> > > > > +    patternProperties:
> > > > > +      "^channel@([0-7])$":
> > > > > +        type: object
> > > > > +        $ref: adc.yaml
> > > > > +        description: Represents the external channel which is co=
nnected to the MDF.
> > > > > +
> > > > > +        properties:
> > > > > +          reg:
> > > > > +            maximum: 7
> > > > > +
> > > > > +          io-backends:
> > > > > +            description:
> > > > > +              Used to pipe external sigma delta modulator or int=
ernal ADC backend to MDF
> > > > > +              channel.
> > > > > +            maxItems: 1
> >=20
> > > > > +
> > > > > +        required:
> > > > > +          - reg
> > > > > +
> > > > > +        unevaluatedProperties: false
> > > > > +
> > > > > +    allOf:
> > > > > +      - if:
> > > > > +          properties:
> > > > > +            compatible:
> > > > > +              contains:
> > > > > +                const: st,stm32mp25-mdf-adc
> > > > > +
> > > > > +        then:
> > > > > +          patternProperties:
> > > > > +            "^channel@[0-7]$":
> > > > > +              required:
> > > > > +                - io-backends
> > > > > +
> > > > > +      - if:
> > > > > +          properties:
> > > > > +            compatible:
> > > > > +              contains:
> > > > > +                const: st,stm32mp25-mdf-dmic
> > > > > +
> > > > > +        then:
> > > > > +          patternProperties:
> > > > > +            "^mdf-dai+$":
> > > > > +              type: object
> > > > > +              description: child node
> > > > > +
> > > > > +              properties:
> > > > > +                compatible:
> > > > > +                  enum:
> > > > > +                    - st,stm32mp25-mdf-dai
> > > > > +
> > > > > +                "#sound-dai-cells":
> > > > > +                  const: 0
> > > > > +
> > > > > +                io-channels:
> > > > > +                  description:
> > > > > +                    From common IIO binding. Used to pipe extern=
al sigma delta
> > > > > +                    modulator or internal ADC output to MDF chan=
nel.
> > > > > +
> > > > > +                power-domains:
> > > > > +                  maxItems: 1
> > > > > +
> > > > > +                port:
> > > > > +                  $ref: /schemas/sound/audio-graph-port.yaml#
> > > > > +                  unevaluatedProperties: false
> > > > > +
> > > > > +              required:
> > > > > +                - compatible
> > > > > +                - "#sound-dai-cells"
> > > > > +                - io-channels
> > > > > +
> > > > > +              additionalProperties: false
> > > > > +
> > > > > +examples:
> > > > > +  - |
> > > > > +    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
> > > > > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > > > > +    mdf1: mdf@504d0000 {
> > > > > +      compatible =3D "st,stm32mp25-mdf";
> > > > > +      ranges =3D <0 0x504d0000 0x1000>;
> > > > > +      reg =3D <0x504d0000 0x8>, <0x504d0ff0 0x10>;
> > > > > +      #address-cells =3D <1>;
> > > > > +      #size-cells =3D <1>;
> > > > > +      clocks =3D <&rcc CK_KER_MDF1>;
> > > > > +      clock-names =3D "ker_ck";
> > > > > +      clock-ranges;
> > > > > +      #clock-cells =3D <1>;
> > > > > +      clock-output-names =3D "cck0", "cck1";
> > > > > +      clock-frequency =3D <2048000>;
> > > > > +
> > > > > +      sitf5: sitf@300 {
> > > > > +        compatible =3D "st,stm32mp25-sitf-mdf";
> > > > > +        reg =3D <0x300 0x4>;
> > > > > +        st,sitf-mode =3D "spi";
> > > > > +        clocks =3D <&mdf1 0>;
> > > > > +      };
> > > > > +
> > > > > +      filter0: filter@84 {
> > > > > +        compatible =3D "st,stm32mp25-mdf-dmic";
> > > > > +        reg =3D <0x84 0x70>;
> > > > > +        #io-channel-cells =3D <1>;
> > > > > +        interrupts =3D <GIC_SPI 184 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +        dmas =3D <&hpdma 63 0x63 0x12 0>;
> > > > > +        dma-names =3D "rx";
> > > > > +        st,cic-mode =3D <5>;
> > > > > +        st,sitf =3D <&sitf5 0>;
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <0>;
> > > > > +
> > > > > +        channel@0 {
> > > > > +          reg =3D <0>;
> > > > > +        };
> > > > > +
> > > > > +        asoc_pdm0: mdf-dai {
> > > > > +          compatible =3D "st,stm32mp25-mdf-dai";
> > > > > +          #sound-dai-cells =3D <0>;
> > > > > +          io-channels =3D <&filter0 0>;
> > > > > +        };
> > > > > +      };
> > > > > +
> > > > > +      filter1: filter@104  {
> > > > > +        compatible =3D "st,stm32mp25-mdf-adc";
> > > > > +        reg =3D <0x104 0x70>;
> > > > > +        #io-channel-cells =3D <1>;
> > > > > +        interrupts =3D <GIC_SPI 185 IRQ_TYPE_LEVEL_HIGH>;
> > > > > +        dmas =3D <&hpdma 64 0x63 0x12 0>;
> > > > > +        dma-names =3D "rx";
> > > > > +        st,cic-mode =3D <2>;
> > > > > +        st,sitf =3D <&sitf5 1>;
> > > > > +        #address-cells =3D <1>;
> > > > > +        #size-cells =3D <0>;
> > > > > +
> > > > > +        channel@1 {
> > > > > +          reg =3D <1>;
> > > > > +          settling-time-us =3D <1000>;
> > > > > +          io-backends =3D <&sd_adc1>;
> > > > > +        };
> > > > > +      };
> > > > > +    };
> > > > > +
> > > > > +...
> > > > > --=20
> > > > > 2.43.0
> > > > >=20
> > >=20
>=20

--QAjpR0J89M4SwmDI
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCask8gAAKCRB4tDGHoIJi
0gnhAP9TQdxdR2vEGvXn0WAs2fLV8lDzCaBP0Dp6IE0EzErIKgEAr5CRGjM2fj1z
oxLzVYsVBBfZWjpnRXtj+rzgTh+GOgk=
=JeId
-----END PGP SIGNATURE-----

--QAjpR0J89M4SwmDI--
