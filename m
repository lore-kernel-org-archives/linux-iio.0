Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED68F3DB33F;
	Thu, 30 Jul 2026 18:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434969; cv=none; b=m8+4611NRZguf1ztYkHs5UjRh2lJmdigLmCktk+8/n9l+CTI63ew5XhXvu6oec4BSfYTOAD0ThK1YJNebWPsxOWvDw4NnoIBflmMn7S89qiPaa0FAmns9jAG4PCUfzMRi5VLcmHRUXE/yUdXvQlfTrbaKvfveO7nyZuM4WVQiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434969; c=relaxed/simple;
	bh=38S5mggfiKJMJ6yejSOI13WAhMncSsSdt79DQwXG2GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=delv7Pt86K4WVBiv1hZpyZjMoJeUnT310+eoiOGM7T9BT0cdo23IHauf4mFigaoGsepnMbJb3qJw4cNXDdAA5psnfdK4saLqGQxYdlemwyWI30A00LXW0VHytv12Qrluip/iCiH3DRnRmRzosp0oCnA7jJHUTNVUV1C8zLwQZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O06up/GF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O06up/GF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B59A1F000E9;
	Thu, 30 Jul 2026 18:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785434966;
	bh=ZFvqsQpk7BNZsJpr0ZuUQSxPFENeZUYiYXjDEtPbpsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O06up/GF/F8bp6hzZTzFeoVjsvjb6aWrTl7cQXdUE3JalhvZvnv7EwBS6gqPwbAGf
	 TjfVHl0fp1QKcZ7PRIrW1zgQeqRNwFP4yMDq45JFMDyH3o5QZlW/KD6M6aKowCSa01
	 /+kYSTi4Uzz3nY0M4HbjFieR07RljMIHIgl8ndY0yJvAE+SC/nxt3HN6bqN9SUqCkM
	 DW66MRZYqYmROeqhIYGAYQnrmmf1K7uYdJETCACkv2oo0MK4f+BGCTKjKDBj24nVZg
	 NSZ9qnXPuNoB92jZw1zdEBDheyeyYpDFctAD+esBiI/lbKIwFNG5Snb/skTPRHmxgH
	 3+gOs67q1RIuQ==
Date: Thu, 30 Jul 2026 19:09:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>,
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260730-mouse-shininess-0bb63d414cef@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
 <20260730000929.2ec20cf8@jic23-huawei>
 <amslUWahHYtwXuCG@nsa>
 <20260730183425.22f2ba8c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="M/EdlGA/+GbAd2me"
Content-Disposition: inline
In-Reply-To: <20260730183425.22f2ba8c@jic23-huawei>

--M/EdlGA/+GbAd2me
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 06:34:25PM +0100, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 11:25:34 +0100
> Nuno S=E1 <noname.nuno@gmail.com> wrote:
>=20
> > On Thu, Jul 30, 2026 at 12:09:29AM +0100, Jonathan Cameron wrote:
> > > On Wed, 29 Jul 2026 21:47:45 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Tue, 28 Jul 2026 17:00:55 +0100
> > > > > Conor Dooley <conor@kernel.org> wrote:
> > > > >    =20
> > > > > > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrot=
e:   =20
> > > > > > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > > > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > > > >      =20
> > > > > > > > On 7/22/26 2:54 AM, Janani Sunil wrote:     =20
> > > > > > > > > Add the generic spi-device-addr property to the binding a=
nd deprecate
> > > > > > > > > the existing vendor specific microchip,hw-device-address =
property.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > > > > > ---
> > > > > > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml  =
       | 10 ++++++++--
> > > > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > > > >=20
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/mi=
crochip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,=
mcp3564.yaml
> > > > > > > > > index 675319276197..de1ea289e7f5 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip=
,mcp3564.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip=
,mcp3564.yaml
> > > > > > > > > @@ -80,6 +80,7 @@ properties:
> > > > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >      minimum: 0
> > > > > > > > >      maximum: 3
> > > > > > > > > +    deprecated: true
> > > > > > > > >      description:
> > > > > > > > >        The address is set on a per-device basis by fuses =
in the factory,
> > > > > > > > >        configured on request. If not requested, the fuses=
 are set for 0x1.
> > > > > > > > > @@ -91,6 +92,12 @@ properties:
> > > > > > > > >        clocking of the device address (BITS[7:6] - top tw=
o bits of COMMAND BYTE
> > > > > > > > >        which is first one on the wire).
> > > > > > > > > =20
> > > > > > > > > +  spi-device-addr:
> > > > > > > > > +    maxItems: 1       =20
> > > > > > > >=20
> > > > > > > > Does it not make sense to all for more than once device con=
nected
> > > > > > > > to the same CS here? I would expect maxItems to be 4 to mat=
ch the
> > > > > > > > number of possible addresses.
> > > > > > > >      =20
> > > > > > >=20
> > > > > > > I think for this part their isn't a reason to aggregate.
> > > > > > > No magic accesses that touch them all at once.  So this hits
> > > > > > > exactly the point you raised about how we set the address for
> > > > > > > more than one of them.     =20
> > > > > >=20
> > > > > > No David is actually right here, and maxitems should be 4.
> > > > > > Setting the address for multiple was already discussed I though=
t, with
> > > > > > the property being an array and each compatible being used to d=
etermine
> > > > > > the "stride" between entries based on the number of supported c=
hannels?   =20
> > > > >=20
> > > > > I don't think that applies for this device or at least to do so
> > > > > is a major driver rewrite, not a simple binding change.  Probably=
 we'd   =20
> > > >=20
> > > > Whether or not it is a big driver change, the binding should repres=
ent
> > > > what the hardware is capable of.
> > > >  =20
> > > > > just add a bus and hang the 4 instances off it. They are running =
on own
> > > > > timing etc so we can't grab data across all of them in any sort of
> > > > > synchronous way - the clocks will probably drift over time etc.  =
 =20
> > > >=20
> > > > Did I miss something about the ADI devices in this thread where they
> > > > have some multicast ability to read all devices at once? I thought =
that
> > > > that was a different series where each device had dedicated mosi and
> > > > miso lines, rather than the shared ones here. I didn't think the ad=
5529r
> > > > did anything special from my reading of the datasheet but I'm not t=
he
> > > > expert in this area! =20
> > >=20
> > > It's a DAC so other way around but yes they have exactly that in the =
section:
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/a=
d5529r.pdf
> > >=20
> > > 	Register Details: Hotpath DAC registermap.
> > >=20
> > > The is a brief description earlier of the whole feature that might
> > > serve for this discussion:
> > >=20
> > > "DAC HOTPATH
> > > The DAC hotpath is a dedicated register region that optimizes
> > > DAC updates in multidevice configurations where several AD5529R
> > > devices share a common SPI bus. It reduces the number of SPI
> > > frames required to write DAC data and supports synchronized
> > > output updates across devices. In single device systems, the hotpath
> > > offers no advantage over the standard register map and can be
> > > disregarded."
> > >=20
> > > As an example
> > > MULTI DEVICE SW LDAC MODE 0 REGISTER
> > > "This register sends a software LDAC update to the selected devices
> > > that share the SPI lines but have different addresses, using the ID0
> > > and ID1 pins. The selection is done on a per-device basis correspondi=
ng
> > > to the configured bit field."
> > >=20
> > > This one triggers all selected DACs (there is bit corresponding to
> > > each address) to update in sync. (Lets put aside normal systems
> > > where an LDAC gpio is wired to multiple devices as that is a whole
> > > different problem).
> > >=20
> > >=20
> > > It is this part that is driving the suggestion of having
> > > a combined device representation for multiple physical devices.
> > > In practice it is very similar to chained devices where we do that
> > > already in that a longer access sequence is used to talk to multiple
> > > devices at once.
> > >=20
> > > Those SPI messages do not carry the address (or they are ignored - I =
didn't
> > > dig into the mechanism).
> > >=20
> > >  =20
> > > >  =20
> > > > > They are independent devices (think of them using spi-device-addr=
ess
> > > > > like an i2c address) -  so why have one DT node for up to 4 of
> > > > > them?  Note this is different from the AD5529R where the design
> > > > > is intended for them to operate as one single larger device.   =
=20
> > > >=20
> > > > I don't buy this argument, I just don't see what differs between the
> > > > devices. The microchip datasheet I read talked about using 3 device=
s to
> > > > measure 3 phase power setups (I think that's what it was) which is,=
 in
> > > > my book, evidence that they're not just intended to be used
> > > > independently. =20
> > >=20
> > > Sure but that could just as easily be done with normal SPI and 3 chip
> > > selects. For these devices there is no broadcast write magic (I think
> > > anyway!)
> > >  =20
> > > >=20
> > > > That said, the more this discussion goes on, the more I think that
> > > > merging the devices into a single node is a mistake. Logically ther=
e may
> > > > be one device, but really there are one to four devices. Doing the
> > > > logical device thing is nice maybe for software but I no longer thi=
nk
> > > > that it represents the hardware correctly. I know this will cause
> > > > problems with registration of devices in the SPI core, but we need =
to
> > > > pick one representation for these devices that fits in all usecases
> > > > and with the things brought up in the other mail I am having a lot =
of
> > > > doubts. =20
> > >=20
> > > This wasn't about use cases as such but the broadcast like facilities=
 the
> > > ADI parts have which to me smell like the main reason you'd put them =
on
> > > a single bus and use this feature in the first place - you are making
> > > one big DAC from multiple chips.
> > >  =20
> > > >=20
> > > > Only going to reply to this for now, I'll reply to the other thread=
 of
> > > > this conversation later so as not to end up duplicating discussion,=
 but
> > > > I am thinking of things like what if someone puts a mcp3654r and an
> > > > ad5529r on the same chip select? I think that's actually perfectly
> > > > functional on a hardware level, provided the fuses/pins are set up
> > > > correctly (and if it is not, mixing the microchip devices is possib=
le
> > > > and probably mixing future ADI ones will be too). =20
> > >=20
> > > The broadcast stuff is what breaks this.  Otherwise I fully agree they
> > > should be independent and we should have SPI allow that.
> > >  =20
> >=20
> > Exactly! The idea of having the devices as separate nodes always felts
> > really appealing to me given that's what we have (strictly sepaking) in
> > HW. But as you stated, the big reason to pack multiple devices (for the
> > ADI case) is to basically increase the number of channels and so
> > aggregate the devices together.
>=20
> Key detail is not just aggregate devices but have them act as one device
> from an interface point of view (just like SPI chaining).  One message
> affects multiple devices.

Do you have an example of this "SPI chaining"?

> > But taking on David's suggestion,
> > couldn't we somehow reuse that for AD5529R such that the additional
> > DAC's would be child nodes?
>=20
>=20
> If they were child nodes that just means we have a device specific binding
> and in practice ends up the same as a binding that just makes it one devi=
ce.
>=20
> adc@cs {
>=20
> 	adc@spi-device-addr0 {
> 		spi-device-addr =3D spi-device-addr0;
> 	};
> 	adc@spidevice-addr1 {
> 		spi-device-addr =3D spi-device-addr1;
> 	};

If you were doing this, the spi-device-addr property would just become
"reg" FWIW.

> }
>=20
> Fun question of where we do the xlate for references to channels so
> does a consumer point at the outer node or the inner one?
>=20
> I'm not seeing a gain over having an array of spi-device-addr in the
> top level node.

Yeah, I can think of some things but I don't think it is anything more
than net neutral.

--M/EdlGA/+GbAd2me
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamuTTwAKCRB4tDGHoIJi
0jw5AP0SEM6Y4nWYVsW7s/JLlHk7cPx1Lpshg84x73rqTpgw5AEAnOlJf92Kub2R
jxFzXntxKENQSaYklB20hiXXlsZoWwA=
=vxxS
-----END PGP SIGNATURE-----

--M/EdlGA/+GbAd2me--
