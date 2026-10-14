Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4CF551985;
	Wed, 14 Oct 2026 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791990961; cv=none; b=KkzKBEDGBdXHn1rDvkoXR5pJZOWDQ6KO8IFWWHYlX93oFoNlyQT+0mQMmALRhHVsSzebo1UsuAFj9COQP9B2GG9BCmasHc+RJQkU6RRub9Mea7BQ0PnwX+ET85BF7qQX9sZ0Q13kYAYdl9q0Lv315bXGCx0Bs7XdqGydtEBhu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791990961; c=relaxed/simple;
	bh=da/Ta1JvxajZY2CzpGsXRs9Ct+4CftaOfi5W0X5CI7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SELcFCIBXt9z2pLI+ddNjBmn7NXXV0NKPATowd57aRtxEDvrYHUOmSipnYkcy6zrzMPiaTQfR17gD/dwoVoqYUW88WZJU5n8mCuSqd4eJN9qtYz7Z7qMTJbJNGFZjodVSAGL7mpP0zx8fd8y5BZpGtqz/7ykvB6NQRd/TS1wbdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5YUPj17; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5YUPj17"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903C01F000C4;
	Wed, 14 Oct 2026 15:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791990958;
	bh=iLGFxT3LpQisUlcvSZoVD1R5romywJtb5bDVbgrtQLE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e5YUPj17wU5tJ5EKkwj9IdgLtTAi7/hIZHn9ZuIJNiSMmwr51h4NVYJZzbhr07WtA
	 o2F23BNbJC6jv3gfIViAK30PZ+mnBjd9VDlSijeImaxvD3AFISvYdEhfjVJMnUXAIB
	 9A7GIB+JGJPThGfyme3vculLUDW1qeYOySTWuYI8f/YdjQvttbBMsE0avmn7UuwpwI
	 +Sk70Dy4UGbFL+kiXQw+JTgdNDtsTGenB4KuDuUQZjGE9uM976V5xDLRGQBlV6Rnrb
	 zowmqBTTV0krxumZ0c2qVbNKABj/5hnwYMnREw94t6bJsysu1mjt0fcZRvsenl7Mbq
	 d37vOcXyW1+nw==
Date: Wed, 14 Oct 2026 16:15:53 +0100
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
Message-ID: <20261014-untrimmed-partly-81a4a21db49c@spud>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-2-olivier.moysan@foss.st.com>
 <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
 <20261009-8db882a9fa159f8759aa7327@squawk>
 <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="daw9WKulJwF5PBoA"
Content-Disposition: inline
In-Reply-To: <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>

--daw9WKulJwF5PBoA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:
> Hi Conor,
>=20
> On 10/9/26 21:12, Conor Dooley wrote:
> > On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
> > > Hi Conor,
> > >=20
> > > On 10/8/26 12:11, Conor Dooley wrote:
> > > > On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wrote:
> > > > > Hi Conor,
> > > > >=20
> > > > > Thanks for the review
> > > > >=20
> > > > > On 10/1/26 20:32, Conor Dooley wrote:
> > > > > > On Thu, Oct 01, 2026 at 04:56:45PM +0200, Olivier Moysan wrote:
> > > > > > > Add bindings that describes STM32 MDF settings to support
> > > > > > > digital filtering for Pulse Density Modulation (PDM) micropho=
nes
> > > > > > > and analog sigma delta modulators.
> > > > > > >=20
> > > > > > > Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > > > ---
> > > > > > >     .../bindings/iio/adc/st,stm32-mdf-adc.yaml    | 383 +++++=
+++++++++++++
> > > > > > >     1 file changed, 383 insertions(+)
> > > > > > >     create mode 100644 Documentation/devicetree/bindings/iio/=
adc/st,stm32-mdf-adc.yaml
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm=
32-mdf-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-ad=
c.yaml
> > > > > > > new file mode 100644
> > > > > > > index 000000000000..f2fbc3e150e8
> > > > > > > --- /dev/null
> > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-mdf-=
adc.yaml
> > > > > > > @@ -0,0 +1,383 @@
> > > > > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > > > > +%YAML 1.2
> > > > > > > +---
> > > > > > > +$id: http://devicetree.org/schemas/iio/adc/st,stm32-mdf-adc.=
yaml#
> > > > > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > > > +
> > > > > > > +title: STMicroelectronics STM32 Multi-function Digital Filte=
r (MDF) ADC
> > > > > > > +
> > > > > > > +maintainers:
> > > > > > > +  - Olivier Moysan <olivier.moysan@foss.st.com>
> > > > > > > +
> > > > > > > +description: |
> > > > > > > +  STM32 MDF ADC is a sigma delta analog-to-digital converter=
 dedicated to
> > > > > > > +  interface external sigma delta modulators to STM32 micro c=
ontrollers.
> > > > > > > +
> > > > > > > +properties:
> > > > > > > +  compatible:
> > > > > > > +    enum:
> > > > > > > +      - st,stm32mp25-mdf
> > > > > > > +      - st,stm32mp23-mdf
> > > > > > > +
> > > > > > > +  reg:
> > > > > > > +    minItems: 1
> > > > > > > +    maxItems: 2
> > > > > >=20
> > > > > > This needs an items list here. The size of the regions seems li=
ke crap
> > > > > > to begin with...
> > > > > >=20
> > > > > > > +
> > > > > > > +  clocks:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  clock-names:
> > > > > > > +    description: Internal clock used for MDF digital process=
ing.
> > > > > > > +    items:
> > > > > > > +      - const: ker_ck
> > > > > >=20
> > > > > > This is pointless when you only have one.
> > > > > >=20
> > > > >=20
> > > > > I agree that it could be dropped. However, it is useful for using
> > > > > devm_regmap_init_mmio_clk.
> > > >=20
> > > > Ah, because that function if you pass NULL to it, it doesn't mean no
> > > > string, it means no clock.
> > > >=20
> > >=20
> > > The MDF has two clocks (AHB clock for register accesses and ker_ck for
> > > peripheral processing). However, these two clocks share the same gate=
=2E So,
> > > only the ker_ck clock is exposed in the driver.
> >=20
> > That's incorrect, you should have two clocks in DT if the block has two
> > even if they have a shared gate.
> >=20
>=20
> This would not be consistent with the architectural choice made for the
> STM32MP25. The RCC driver provides an abstraction to manage these two clo=
cks
> as one, since they are controlled by the same gate. The binding incorpora=
tes
> this abstraction to manage only a single clock.
>=20
> A large number of peripherals on STM32MP25 have the same architecture and
> follow this implementation rule. So managing both clocks in the MDF driver
> would create a consistency issue with the other peripherals.

Doesn't really matter how you've modelled the clock controller, cos you
can just have the same clock be both inputs, and retain a correct model
of this hardware?

>=20
> > > The regmap api is a convenient way to manage registers and gate the A=
HB
> > > clock only on register accesses. Removing clock-names no longer allow=
s you
> > > to benefit from clock management handled by the regmap framework, and=
 means
> > > that this must be managed explicitly, partially or entirely, in the d=
river.
> > >=20
> > > > >=20
> > > > > > > +
> > > > > > > +  "#clock-cells":
> > > > > > > +    enum: [0, 1]
> > > > > >=20
> > > > > > Why is this not fixed? Also why are parts of your own device co=
nsuming
> > > > > > the clocks?
> > > >=20
> > > > Reading the docs, this has to be 1, you have two clocks?
> > > >=20
> > > > Not sure why you skipped this and skipped explaining why you are
> > > > consuming your own clocks.
> > > >=20
> > >=20
> > > Yes, we can have two clocks gated independently but sharing the same =
rate.
> > >=20
> > > Using the clock framework apis seemed to me the right way to manage c=
ck1 and
> > > cck0 gating and divider computing. I think I would have to introduce
> > > proprietary properties and have to implement code in the driver, that=
 would
> > > be handled natively by the framework otherwise.
> >=20
> > The CCF is still the right way to do it, especially since CCK0/1 can be
> > exported to other devices. I don't believe you need to actually have a
> > reference in DT to do this though, plenty of "real" clock controllers
> > have only one input clock and hang a whole tree with multiple layers off
> > that.
> > Down below I mentioned this under "ouroboros devices", I think this kind
> > of ability to chose which clock a channel uses is a fairly normal thing
> > to do in IIO land, I just dunno what the preferred mechanism is - I just
> > know that it is not referencing yourself (probably it's some sort of
> > property that you put in a channel node that says 'blah-clock =3D "cck0=
"',
> > but better that the IIO folks answer.
> >=20
>=20
> The adc.yaml binding do not expose clock properties. But maybe IIO experts
> can answer about this.
>=20
> > > > > > > +  clock-output-names:
> > > > > > > +    description: |
> > > > > > > +      CCK0 and CCK1 are optional output clocks, which share =
the same clock frequency,
> > > > > > > +      but can be gated independently to save power.
> > > > > > > +    minItems: 1
> > > > > > > +    maxItems: 2
> > > > > > > +    oneOf:
> > > > > > > +      - items:
> > > > > > > +          - const: cck0
> > > > > > > +      - items:
> > > > > > > +          - const: cck1
> > > > > > > +      - items:
> > > > > > > +          - const: cck0
> > > > > > > +          - const: cck1
> > > > > > > +
> > > > > > > +  clock-frequency:
> > > > > > > +    description: |
> > > > > > > +      Common clock frequency (Hz) for CCK0 and CCK1 output c=
locks.
> > > > > > > +      The frequency must be a multiple of the "ker_ck" clock=
 frequency.
> > > > > > > +    maximum: 25000000
> > > > > >=20
> > > > > > Should not be needed, the consumers request what they need.
> > > > > >=20
> > > > >=20
> > > > > The CCKx clock frequency depends on the maximum rate supported by=
 the sigma
> > > > > delta converters (for instance a digital mic) and the expected de=
cimation
> > > > > ratio on the bitstream. Typically this determines the frequency o=
n the SPI
> > > > > bus.
> > > > > This rate is defined statically and shared by the CCKx clocks. So=
 IMHO, as
> > > > > this rate is unique, it can look strange to let the consumer defi=
ne it.
> > > > > Moreover, it seems to me that clock-frequency is already used to =
configure
> > > > > the frequency of a provider in some other bindings.
> > > > > For instance: Documentation/devicetree/bindings/clock/silabs,si57=
0.yaml
> > > >=20
> > > > This is a binding from the age of antiquity, using it to justify yo=
ur
> > > > use is actually harming your argument rather than helping. Your clo=
ck
> > > > consumers should be providing the information about what the rate s=
hould
> > > > be, and if you need to do this in dt you can use assigned-clock-rat=
es.
> > > >=20
> > >=20
> > > ok, I will move this to clock consumer with assigned-clock properties.
> > >=20
> > > > > So, it's not clear for me, what is the restriction on clock-frequ=
ency
> > > > > property.
> > > > > > > +
> > > > > > > +  ranges: true
> > > > > > > +
> > > > > > > +  clock-ranges: true
> > > > > > > +
> > > > > > > +  resets:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  reset-names:
> > > > > > > +    items:
> > > > > > > +      - const: mdf
> > > >=20
> > > > Same applies here as to the clock names fwiw.
> > > >=20
> > >=20
> > > Yes, I removed this.
> > >=20
> > > > > > > +
> > > > > > > +  access-controllers:
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > > > +    description: |
> > > > > > > +      Phandle to the rifsc device to check access right.
> > > > > > > +
> > > > > > > +  power-domains:
> > > > > > > +    maxItems: 1
> > > > > > > +
> > > > > > > +  st,interleave:
> > > > > > > +    description: |
> > > > > > > +      List of phandles of interleaved filters. The indexes o=
f interleaved filters must be
> > > > > > > +      consecutives starting from 0 (i.e in range [0..N]). Th=
e samples from interleaved filters
> > > > > > > +      are muxed in a single channel and retrieved through th=
e device associated to the filter 0.
> > > > > > > +      The filters 1..N have to be enabled, but inherit their=
 configuration from filter 0.
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > > > > >=20
> > > > > > No idea what these even are, but this is probably not the right=
 way to
> > > > > > represent the relationship between devices. They're apparently =
ADCs, but
> > > > > > this is also an ADC so I'm not sure what's going on here at all.
> > > >=20
> > > > Yeah, after more thought this should not be done like this at all,
> > > > especially if these filters the phandle point to are part of this d=
evice
> > > > itself, which I suspect they are. If that's the case, you don't need
> > > > phandles to even do this, you just need an int that says what N is.
> > > >=20
> > >=20
> > > Yes, can be an index as it is an internal reference. I will change th=
is.
> > >=20
> > > > > >=20
> > > > > > > +
> > > > > > > +required:
> > > > > > > +  - compatible
> > > > > > > +  - reg
> > > > > > > +  - ranges
> > > > > > > +  - clocks
> > > > > > > +  - clock-names
> > > > > > > +  - clock-ranges
> > > > > > > +  - "#address-cells"
> > > > > > > +  - "#size-cells"
> > > > > > > +
> > > > > > > +additionalProperties: false
> > > > > > > +
> > > > > > > +patternProperties:
> > > > > > > +  "^sitf@[0-9]+$":
> > > > > > > +    type: object
> > > > > > > +    description: Serial interface child node
> > > > > >=20
> > > > > > Why is this a child node at all?
> > > > > > Probably not worth reviewing more without a link to the docs fo=
r this
> > > > > > device so I can figure out what on earth is going on!
> > > > > >=20
> > > > >=20
> > > > > The MDF is a digital filter for sigma-delta bitstreams, rather th=
an the
> > > > > analog-to-digital converter itself.
> > > > >=20
> > > > > Here is the link to STM32MP25 reference manuel
> > > > > https://www.st.com/resource/en/reference_manual/rm0457-stm32mp232=
5xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
> > > > > Chapter 45: Multi-function digital filter (MDF)
> > > > >=20
> > > > > On STMP32MP25 SoC, the MDF provides 8 serial interfaces (SITF) an=
d 8 digital
> > > > > filters (DFLT) which can be connected through a multiplexer.
> > > > >=20
> > > > > Below is a schematic view of typical applications targeted by this
> > > > > peripheral
> > > > >=20
> > > > >=20
> > > > > Audio use case:
> > > > >=20
> > > > > 		mdf
> > > > >               +-------------------------------------+
> > > > > +------+    | +------+    +------+    +------+    |
> > > > > | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> audio devi=
ce
> > > > > +------+    | +------+    +------+    +------+    |
> > > > >               +-------------------------------------+
> > > > >=20
> > > > > For instance, in an audio use case the serial interface can be co=
nfigured to
> > > > > provide the clock to the digital microphone (cck0, cck1 or both) =
at a common
> > > > > predefined rate, and to retrieve the PDM samples.
> > > > > The serial interface provides this samples to a digital filter, w=
hich
> > > > > delivers PCM samples on its output.
> > > > >=20
> > > > >=20
> > > > > Analog use case:
> > > > >=20
> > > > > 		mdf
> > > > >                 +-------------------------------------+
> > > > > +--------+    | +------+    +------+    +------+    |
> > > > > | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> iio devi=
ce
> > > > > +--------+    | +------+    +------+    +------+    |
> > > > >                 +-------------------------------------+
> > > >=20
> > > >=20
> > > > So, looking at the docs and a brief chat with Jonathan about this
> > > > device, I believe you've got things backwards and this is actually =
the backend,
> > > > and the adc should be the one populating the io-backends property
> > > > pointing to this device. You should have io-backend-cells, and I as=
sume
> > > > that there should be a cell for the adc to select which dlft it is =
connected
> > > > to.
> > > >=20
> > >=20
> > > There have already been lengthy discussions in the past about a DFSDM
> > > peripheral on STM32MP1, which has features similar to those of the MD=
F and
> > > similar implementation constraints. For the DFSDM, a solution based o=
n an
> > > IIO backend had been upstreamed. The MDF follows the same architectur=
e. I
> > > need to take a little time to dive back into this issue.
> >=20
> > One thing to note there is that you retrofitted the backends onto that
> > device, and the original design here is much older (it's a text
> > binding).
> >=20
> >=20
> > >=20
> > > DFSDM sources:
> > > drivers/iio/adc/stm32-dfsdm-adc.c
> > > drivers/iio/adc/stm32-dfsdm-core.c
> > >=20
> > > Here is a sample of DFSDM DT
> > >=20
> > > sd_adc0: simple-sd-adc0 {
> > > 	compatible =3D "sd-modulator";
> > > 	#io-backend-cells =3D <0>;
> > > 	vref-supply =3D <&v3v3>;
> >=20
> > Yeah, pretty sure this is wrong (backwards). The backend is the thing
> > that gets data from an ADC not the ADC.
> >=20
>=20
> The backend framework was introduced to implement complex IIO aggregate
> devices. The hardwares that were driving this need were analog device ad9=
467
> and ST DFSDM.
>=20
> https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/=
#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
>=20
> From drivers/iio/industrialio-backend.c:
>=20
> "The typical architecture is to have one device as the frontend device wh=
ich
> can be "linked" against one or multiple backend devices. All the IIO and
> userspace interface is expected to be registers/managed by the frontend
> device which will callback into the backends when needed (to get/set some
> configuration that it does not directly control)."
>=20
>  *                                    ---------------------
>  * ------------------                 | ------------
>  * |     ADC        |-----------------| | ADC CORE |
>  * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
>  * |                |-----------------| ------------
>  * ------------------                 ---------------------
>=20
> The MDF (or DFSDM) use case, follows this topology:
> - The SD modulator (ADC core) registers in backend framework
> - The MDF registers in IIO framework and exposes the IIO devices
>   It also get configuration (ref voltage) from SD modulator, to compute
> scaling.
>=20
> I agree that if we consider the terms frontend and backend, the elements =
in
> the data flow do not have the roles that we would naturally expect. Howev=
er,
> if we consider the expected role of the elements using the iio-backend
> framework, the usage seems coherent to me.

I didn't even get as far as sd modulators or whatever, if I understand
correctly the ADC inputs on this device are fed by the onboard ADC?
(https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d31ec75ae=
cf3@foss.st.com/)
In that case, I can't really see how it makes sense for the primary iio
device to change when data is fed back through the mdf or taken
directly from the ADC itself, particularly given how that would affect
the userspace interface.

The "serial" side of this seems in a similar vein to the adi,axi-adc
stuff, which when considered with the ADC inputs, really does give me
the impression this is backwards.

--daw9WKulJwF5PBoA
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas+cqQAKCRB4tDGHoIJi
0vjrAP9bGRQrGs/YcMGw8wt/KTggN+lbhYobYz8FRuTX/GNV5wD+O9lnMWipDKp6
fOWbwmaImLFW/eZD9mx5ZIy6OeXJDg8=
=X5b1
-----END PGP SIGNATURE-----

--daw9WKulJwF5PBoA--
