Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA53A517BA7;
	Thu, 15 Oct 2026 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792067651; cv=none; b=Xre0KEH1fftRaLtPBZSx7zUVpRZDeLjwWb+hbRxpuJLai5lTlsjmFCqd0+kyKWgRsNYbiLbqtiejYZ7JT3oK6NELEvZgUVGOUklxf/fHwEvlVGxntBdjdbwqtH7sg8IT/ULamHpmva5V8oCTYQW80ZMCwAYxAVnSylSB4KGeu9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792067651; c=relaxed/simple;
	bh=p27s2VWFrHAqilqGBoUIdsBBRaEGbHxwMz3zCfccEzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dd/SuMC60SoBNgOdaoV8isAaFuRTJW29fPdv0WcEEyiVMxYngoBvH6MrGkEyG1QdHrDOO+yHuoc4QijvnkQ04dgIIBXgMSp/6zRPYrMrgPW9wMDjedxj0k0xS7IsH8qeAugllEQyfBs1wqKNVakoIeGS9l2amQuaqasf2AJBP6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7BZb1fx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7BZb1fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F3D01F000C4;
	Thu, 15 Oct 2026 12:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792067649;
	bh=Ea9IWsCeD09j98ilJsUEEHsq1UpfLk0qemcn5duHRIw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J7BZb1fxR0O7goAxUfGpjxhAU08AxKj+AOfsHnwVLKlkGnyA4153xUiHLRauTv+Uz
	 DaTVkp0j+6yXVeiu2JVXVd94I+KxEhLlm1YhYu4iuDza5ccCAtIujijTdrzd82c/UY
	 3cXfeaq9Qmx3j+upU5o6lkryTkcrju69Fx1o09kILj+3VWlTC3beaBTqSy5A4JMXgP
	 4CeK3sXPwLrVgWsfL4U4Po22PJ9papa8VdLY3Ye97o6UukjPRFhogehGomXagBOfP5
	 i/1S5ufBPJ8VZ+9IDI3sDTmmmp6zKNu9j5nC/p9nKG2p7YDc3jPJT74ntPNMZ/v+JV
	 FdhzOdOp8wfwA==
Date: Thu, 15 Oct 2026 13:34:04 +0100
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
Message-ID: <20261015-attentive-conflict-1a1f538de77d@spud>
References: <20261001-tribesman-gauze-862e1ef0cdd8@spud>
 <bb8af256-5a77-4215-9eeb-fbcd0cae1829@foss.st.com>
 <20261008-9e2a48675c1a4c28f2dfa73b@squawk>
 <950f2801-a613-4f5a-a5a7-cb30101cf293@foss.st.com>
 <20261009-8db882a9fa159f8759aa7327@squawk>
 <2ba9235f-182e-4906-92e2-e35cf831d289@foss.st.com>
 <20261014-untrimmed-partly-81a4a21db49c@spud>
 <48e528a5-0c54-4778-bd29-b6f44ae95be7@foss.st.com>
 <20261014-unmade-sphinx-71cb25110d58@spud>
 <436ef0bf-4146-435d-8252-acec68e64b9e@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FGGwO6lNFVG+3aVf"
Content-Disposition: inline
In-Reply-To: <436ef0bf-4146-435d-8252-acec68e64b9e@foss.st.com>

--FGGwO6lNFVG+3aVf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 11:19:19AM +0200, Olivier MOYSAN wrote:
> Hi Conor,
>=20
> On 10/15/26 00:49, Conor Dooley wrote:
> > On Wed, Oct 14, 2026 at 06:51:45PM +0200, Olivier MOYSAN wrote:
> > > On 10/14/26 17:15, Conor Dooley wrote:
> > > > On Mon, Oct 12, 2026 at 02:56:04PM +0200, Olivier MOYSAN wrote:
> > > > > On 10/9/26 21:12, Conor Dooley wrote:
> > > > > > On Thu, Oct 08, 2026 at 06:37:26PM +0200, Olivier MOYSAN wrote:
> > > > > > > On 10/8/26 12:11, Conor Dooley wrote:
> > > > > > > > On Wed, Oct 07, 2026 at 11:01:28AM +0200, Olivier MOYSAN wr=
ote:
> > > > > > > > > On 10/1/26 20:32, Conor Dooley wrote:
> > > > > > > > > >=20
> > > > > > > > > > > +
> > > > > > > > > > > +required:
> > > > > > > > > > > +  - compatible
> > > > > > > > > > > +  - reg
> > > > > > > > > > > +  - ranges
> > > > > > > > > > > +  - clocks
> > > > > > > > > > > +  - clock-names
> > > > > > > > > > > +  - clock-ranges
> > > > > > > > > > > +  - "#address-cells"
> > > > > > > > > > > +  - "#size-cells"
> > > > > > > > > > > +
> > > > > > > > > > > +additionalProperties: false
> > > > > > > > > > > +
> > > > > > > > > > > +patternProperties:
> > > > > > > > > > > +  "^sitf@[0-9]+$":
> > > > > > > > > > > +    type: object
> > > > > > > > > > > +    description: Serial interface child node
> > > > > > > > > >=20
> > > > > > > > > > Why is this a child node at all?
> > > > > > > > > > Probably not worth reviewing more without a link to the=
 docs for this
> > > > > > > > > > device so I can figure out what on earth is going on!
> > > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > The MDF is a digital filter for sigma-delta bitstreams, r=
ather than the
> > > > > > > > > analog-to-digital converter itself.
> > > > > > > > >=20
> > > > > > > > > Here is the link to STM32MP25 reference manuel
> > > > > > > > > https://www.st.com/resource/en/reference_manual/rm0457-st=
m32mp2325xx-advanced-armbased-3264bit-mpus-stmicroelectronics.pdf
> > > > > > > > > Chapter 45: Multi-function digital filter (MDF)
> > > > > > > > >=20
> > > > > > > > > On STMP32MP25 SoC, the MDF provides 8 serial interfaces (=
SITF) and 8 digital
> > > > > > > > > filters (DFLT) which can be connected through a multiplex=
er.
> > > > > > > > >=20
> > > > > > > > > Below is a schematic view of typical applications targete=
d by this
> > > > > > > > > peripheral
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Audio use case:
> > > > > > > > >=20
> > > > > > > > > 		mdf
> > > > > > > > >                 +-------------------------------------+
> > > > > > > > > +------+    | +------+    +------+    +------+    |
> > > > > > > > > | dmic | -> | | sitf | -> | mux  | -> | dflt | -- | -> au=
dio device
> > > > > > > > > +------+    | +------+    +------+    +------+    |
> > > > > > > > >                 +-------------------------------------+
> > > > > > > > >=20
> > > > > > > > > For instance, in an audio use case the serial interface c=
an be configured to
> > > > > > > > > provide the clock to the digital microphone (cck0, cck1 o=
r both) at a common
> > > > > > > > > predefined rate, and to retrieve the PDM samples.
> > > > > > > > > The serial interface provides this samples to a digital f=
ilter, which
> > > > > > > > > delivers PCM samples on its output.
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > Analog use case:
> > > > > > > > >=20
> > > > > > > > > 		mdf
> > > > > > > > >                   +-------------------------------------+
> > > > > > > > > +--------+    | +------+    +------+    +------+    |
> > > > > > > > > | sd adc | -> | | sitf | -> | mux  | -> | dflt | -- | -> =
iio device
> > > > > > > > > +--------+    | +------+    +------+    +------+    |
> > > > > > > > >                   +-------------------------------------+
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > So, looking at the docs and a brief chat with Jonathan abou=
t this
> > > > > > > > device, I believe you've got things backwards and this is a=
ctually the backend,
> > > > > > > > and the adc should be the one populating the io-backends pr=
operty
> > > > > > > > pointing to this device. You should have io-backend-cells, =
and I assume
> > > > > > > > that there should be a cell for the adc to select which dlf=
t it is connected
> > > > > > > > to.
> > > > > > > >=20
> > > > > > >=20
> > > > > > > There have already been lengthy discussions in the past about=
 a DFSDM
> > > > > > > peripheral on STM32MP1, which has features similar to those o=
f the MDF and
> > > > > > > similar implementation constraints. For the DFSDM, a solution=
 based on an
> > > > > > > IIO backend had been upstreamed. The MDF follows the same arc=
hitecture. I
> > > > > > > need to take a little time to dive back into this issue.
> > > > > >=20
> > > > > > One thing to note there is that you retrofitted the backends on=
to that
> > > > > > device, and the original design here is much older (it's a text
> > > > > > binding).
> > > > > >=20
> > > > > >=20
> > > > > > >=20
> > > > > > > DFSDM sources:
> > > > > > > drivers/iio/adc/stm32-dfsdm-adc.c
> > > > > > > drivers/iio/adc/stm32-dfsdm-core.c
> > > > > > >=20
> > > > > > > Here is a sample of DFSDM DT
> > > > > > >=20
> > > > > > > sd_adc0: simple-sd-adc0 {
> > > > > > > 	compatible =3D "sd-modulator";
> > > > > > > 	#io-backend-cells =3D <0>;
> > > > > > > 	vref-supply =3D <&v3v3>;
> > > > > >=20
> > > > > > Yeah, pretty sure this is wrong (backwards). The backend is the=
 thing
> > > > > > that gets data from an ADC not the ADC.
> > > > > >=20
> > > > >=20
> > > > > The backend framework was introduced to implement complex IIO agg=
regate
> > > > > devices. The hardwares that were driving this need were analog de=
vice ad9467
> > > > > and ST DFSDM.
> > > > >=20
> > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-h=
uawei/T/#m222f5175273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > >=20
> > > > >   From drivers/iio/industrialio-backend.c:
> > > > >=20
> > > > > "The typical architecture is to have one device as the frontend d=
evice which
> > > > > can be "linked" against one or multiple backend devices. All the =
IIO and
> > > > > userspace interface is expected to be registers/managed by the fr=
ontend
> > > > > device which will callback into the backends when needed (to get/=
set some
> > > > > configuration that it does not directly control)."
> > > > >=20
> > > > >    *                                    ---------------------
> > > > >    * ------------------                 | ------------
> > > > >    * |     ADC        |-----------------| | ADC CORE |
> > > > >    * | (Frontend/IIO) | Serial Data (eg | |(backend) |-------
> > > > >    * |                |-----------------| ------------
> > > > >    * ------------------                 ---------------------
> > > > >=20
> > > > > The MDF (or DFSDM) use case, follows this topology:
> > > > > - The SD modulator (ADC core) registers in backend framework
> > > > > - The MDF registers in IIO framework and exposes the IIO devices
> > > > >     It also get configuration (ref voltage) from SD modulator, to=
 compute
> > > > > scaling.
> > > > >=20
> > > > > I agree that if we consider the terms frontend and backend, the e=
lements in
> > > > > the data flow do not have the roles that we would naturally expec=
t. However,
> > > > > if we consider the expected role of the elements using the iio-ba=
ckend
> > > > > framework, the usage seems coherent to me.
> > > >=20
> > > > I didn't even get as far as sd modulators or whatever, if I underst=
and
> > > > correctly the ADC inputs on this device are fed by the onboard ADC?
> > > > (https://lore.kernel.org/linux-iio/20261006-adc-stm32mp25-v1-v4-0-d=
31ec75aecf3@foss.st.com/)
> > > > In that case, I can't really see how it makes sense for the primary=
 iio
> > > > device to change when data is fed back through the mdf or taken
> > > > directly from the ADC itself, particularly given how that would aff=
ect
> > > > the userspace interface.
> > > >=20
> > > > The "serial" side of this seems in a similar vein to the adi,axi-adc
> > > > stuff, which when considered with the ADC inputs, really does give =
me
> > > > the impression this is backwards.
> > >=20
> > > Some clarifications about the STM32MP25. This SoC does indeed provide=
 ADCs,
> > > and these can be connected to the MDF via a dedicated interface. (but=
 not
> > > the serial interface).
> > >=20
> > > However, this use case is not supported by the driver. Only sigma-del=
ta
> > > modulators, external to the SoC and connected via the serial interfac=
e, are
> > > supported. On ST boards, the only available SD modulators are digital
> > > microphones.
> >=20
> > Quite frankly, I don't care what you are choosing to implement in the
> > driver or what your first-party boards support. The binding must
> > represent the capabilities of the device, not what subset you deem
> > relevant at this point in time. I'm not going to ack anything that does
> > not consider all use cases for the device, especially since I the more I
> > look the more I am convinced that this is the wrong way to model the
> > relationship between devices and therefore intentionally ignoring a use=
 case
> > is likely to be problematic when someone does decide that they want to =
use
> > that feature.
> >=20
> > > Anyway, if the internal ADC to MDF use case was supported, the issue =
would
> > > be the same. The whole ADC + MDF set would be presented at the interf=
ace as
> > > an aggregated device, and the ADC data would not be directly accessib=
le to
> > > the user.
> >=20
> > Of course, that's what I was talking about when I said:
> > | In that case, I can't really see how it makes sense for the primary i=
io
> > | device to change when data is fed back through the mdf or taken
> > | directly from the ADC itself, particularly given how that would affect
> > | the userspace interface.
> >=20
> > To me, in that ADC to MDF use case, the frontend portion of the aggrega=
te
> > device presented to userspace needs to be the ADC and the MDF needs to =
be
> > the backend, since otherwise the ADC will simultaneously be frontend and
> > backend, depending on which channel is considered. That makes no sense =
to me
> > when the MDF can always be the backend, for all use cases and avoid that
> > sort of problem entirely.
> > I've heard no argument as to why the MDF cannot be a backend, just that=
 you
> > don't want to because the previous device didn't, but copying what was
> > done before isn't a justification that bears weight if how it was done
> > before isn't the way it should be done.
> >=20
>=20
> These topology problems were discussed at length in the case of DFSDM.
> The main blocking point being support for interleaved channels (scan mode=
),
> a problematic issue that is still found with MDF.

If I am not mistaken, you're talking about what's described in the
section labelled "Interleaved-transfer mode" of the document you
provided previously?

> The constraints that led to this approach are in the following thread:
> https://lore.kernel.org/all/20210919191414.09270f4e@jic23-huawei/

That to me seemed like a discussion about why the MDF/interleaver needs
to be represented as a separate device, I don't see anything that
explains why the MDF cannot be a backend.

Reading the document, "Interleaved-transfer mode" doesn't trash the
association between data and which fifo, and thereby which sensor or
ADC, it came from. Using #io-backend-cells =3D <1> in the MDF, the
sensor/ADC can provide the channel to which it is linked, and the data
association restored. You already know what the set of interleaved channels
is from the st,interleave property so there's no extra properties required
for this I think.

The problem here must be that you want to access the interleaved data? That
could be handled by having a cell value that represents the interleaved
data (e.g. -1), rather than a channel (1-N)? That'd support systems that
want interleaved data (like an array of identical sensors?) and systems
using the mode for the stated aim of it in documentation of optimising
DMA request resources who have disparate devices where interleaved data
itself is not useful?

Thanks,
Conor.

--FGGwO6lNFVG+3aVf
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatDIPAAKCRB4tDGHoIJi
0lSLAP4+83dGmyYNV8OdycrYzvbbmgn56o9ZFI7sRbVCNVHMAQD/eQxpY2Ywsgh3
eVcR9wfNHtbq0BalljDqp9VRLdn8YAU=
=Da9G
-----END PGP SIGNATURE-----

--FGGwO6lNFVG+3aVf--
