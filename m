Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29C388E49;
	Thu, 30 Jul 2026 18:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434536; cv=none; b=qZvWziwQ1pkJ4nZBHXqKCunbePI9eYevBIzC95N6NrHUhOmgDiiKvs/X8ZgWf8qAfM/9c42d00fFq4Hhi4nl0wKpFYS1Fa15t91A0qu+4FpHQ/D+0D0LQMKcvRyFycXObBplzOUH3lKGqeyMzmyuQBWYMeKXYWKYgB3dcouhejA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434536; c=relaxed/simple;
	bh=Yj0QMHocc9aTaPcCvlBNYypGystoTrAhdkNiel0r9tE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKWADVj7vSF0nWDSfhCXjBXF2iiRpTb6TJ9iLGDnqnDNauO+4OLixRVd11IChWq7vTRn0lmKz7LhPGyDpdFxsfE1gHnyr7KHhH8nXoB6+ja/F3fQnd0bVX4oDPQhAlFjWrvIarZDSX9K9Qbd6Xm1T5k+ZIoC7oiA7OHnwAh2+ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ORWjC9i5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ORWjC9i5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A480E1F000E9;
	Thu, 30 Jul 2026 18:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785434535;
	bh=UJtAlxCLZK+CMU2qX4oKdPEiUKAw+wOclZpIGOAen1w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ORWjC9i583+tYjXwRuBspPO2aFbmCPzEp8lJRJkBo32w/nRcFpEmoxJGZlag2ITNS
	 ZWDM19w6yRoXtJ12cjegYIWg5cYPE5gTuNqCzjgicUJkEXYwN/iGHHTMWgjjf0n8mu
	 xvciCqq7pHvWYmjqmKfdVYvv0XR2i4XxIDp6NBym5squ5J4UvVHpMwm4nK+7wJm67u
	 sffvCwdPV4BGwC8San5VB0FU9FzduGY/lMtB9w8zv0J/1/zlYaQ7YMzWwfRsgWSaj6
	 bxzAe4pa7uYksHwPsMYQ1bAbsinRGqWiMducJ3ClbT6j98mQzcFCfJ1vrTem2sw2MO
	 0rFyJ3c9esClw==
Date: Thu, 30 Jul 2026 19:02:08 +0100
From: Conor Dooley <conor@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
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
Message-ID: <20260730-impaired-protector-b58ae56ae3f6@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
 <20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
 <cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
 <20260725230739.63ff7000@jic23-huawei>
 <20260728-patronize-thwarting-56fab2e11077@spud>
 <20260728221719.7f668a73@jic23-huawei>
 <20260729-hundredth-suffice-f28afa67bc06@spud>
 <20260730000929.2ec20cf8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ySe+qNYy9FceFUoD"
Content-Disposition: inline
In-Reply-To: <20260730000929.2ec20cf8@jic23-huawei>

--ySe+qNYy9FceFUoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 12:09:29AM +0100, Jonathan Cameron wrote:
> On Wed, 29 Jul 2026 21:47:45 +0100
> Conor Dooley <conor@kernel.org> wrote:
>=20
> > On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:
> > > On Tue, 28 Jul 2026 17:00:55 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >  =20
> > > > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote: =
=20
> > > > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > >    =20
> > > > > > On 7/22/26 2:54 AM, Janani Sunil wrote:   =20
> > > > > > > Add the generic spi-device-addr property to the binding and d=
eprecate
> > > > > > > the existing vendor specific microchip,hw-device-address prop=
erty.
> > > > > > >=20
> > > > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > > > ---
> > > > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml      =
   | 10 ++++++++--
> > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > >=20
> > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/microc=
hip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3=
564.yaml
> > > > > > > index 675319276197..de1ea289e7f5 100644
> > > > > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp=
3564.yaml
> > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp=
3564.yaml
> > > > > > > @@ -80,6 +80,7 @@ properties:
> > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > >      minimum: 0
> > > > > > >      maximum: 3
> > > > > > > +    deprecated: true
> > > > > > >      description:
> > > > > > >        The address is set on a per-device basis by fuses in t=
he factory,
> > > > > > >        configured on request. If not requested, the fuses are=
 set for 0x1.
> > > > > > > @@ -91,6 +92,12 @@ properties:
> > > > > > >        clocking of the device address (BITS[7:6] - top two bi=
ts of COMMAND BYTE
> > > > > > >        which is first one on the wire).
> > > > > > > =20
> > > > > > > +  spi-device-addr:
> > > > > > > +    maxItems: 1     =20
> > > > > >=20
> > > > > > Does it not make sense to all for more than once device connect=
ed
> > > > > > to the same CS here? I would expect maxItems to be 4 to match t=
he
> > > > > > number of possible addresses.
> > > > > >    =20
> > > > >=20
> > > > > I think for this part their isn't a reason to aggregate.
> > > > > No magic accesses that touch them all at once.  So this hits
> > > > > exactly the point you raised about how we set the address for
> > > > > more than one of them.   =20
> > > >=20
> > > > No David is actually right here, and maxitems should be 4.
> > > > Setting the address for multiple was already discussed I thought, w=
ith
> > > > the property being an array and each compatible being used to deter=
mine
> > > > the "stride" between entries based on the number of supported chann=
els? =20
> > >=20
> > > I don't think that applies for this device or at least to do so
> > > is a major driver rewrite, not a simple binding change.  Probably we'=
d =20
> >=20
> > Whether or not it is a big driver change, the binding should represent
> > what the hardware is capable of.
> >=20
> > > just add a bus and hang the 4 instances off it. They are running on o=
wn
> > > timing etc so we can't grab data across all of them in any sort of
> > > synchronous way - the clocks will probably drift over time etc. =20
> >=20
> > Did I miss something about the ADI devices in this thread where they
> > have some multicast ability to read all devices at once? I thought that
> > that was a different series where each device had dedicated mosi and
> > miso lines, rather than the shared ones here. I didn't think the ad5529r
> > did anything special from my reading of the datasheet but I'm not the
> > expert in this area!
>=20
> It's a DAC so other way around but yes they have exactly that in the sect=
ion:
> https://www.analog.com/media/en/technical-documentation/data-sheets/ad552=
9r.pdf
>=20
> 	Register Details: Hotpath DAC registermap.
>=20
> The is a brief description earlier of the whole feature that might
> serve for this discussion:
>=20
> "DAC HOTPATH
> The DAC hotpath is a dedicated register region that optimizes
> DAC updates in multidevice configurations where several AD5529R
> devices share a common SPI bus. It reduces the number of SPI
> frames required to write DAC data and supports synchronized
> output updates across devices. In single device systems, the hotpath
> offers no advantage over the standard register map and can be
> disregarded."
>=20
> As an example
> MULTI DEVICE SW LDAC MODE 0 REGISTER
> "This register sends a software LDAC update to the selected devices
> that share the SPI lines but have different addresses, using the ID0
> and ID1 pins. The selection is done on a per-device basis corresponding
> to the configured bit field."
>=20
> This one triggers all selected DACs (there is bit corresponding to
> each address) to update in sync. (Lets put aside normal systems
> where an LDAC gpio is wired to multiple devices as that is a whole
> different problem).
>=20
>=20
> It is this part that is driving the suggestion of having
> a combined device representation for multiple physical devices.
> In practice it is very similar to chained devices where we do that
> already in that a longer access sequence is used to talk to multiple
> devices at once.

Ah I see. I definitely missed this section.

> Those SPI messages do not carry the address (or they are ignored - I didn=
't
> dig into the mechanism).

It's definitely hard to tell this at a glance, nor does it really
matter.

> > > They are independent devices (think of them using spi-device-address
> > > like an i2c address) -  so why have one DT node for up to 4 of
> > > them?  Note this is different from the AD5529R where the design
> > > is intended for them to operate as one single larger device. =20
> >=20
> > I don't buy this argument, I just don't see what differs between the
> > devices. The microchip datasheet I read talked about using 3 devices to
> > measure 3 phase power setups (I think that's what it was) which is, in
> > my book, evidence that they're not just intended to be used
> > independently.
>=20
> Sure but that could just as easily be done with normal SPI and 3 chip
> selects. For these devices there is no broadcast write magic (I think
> anyway!)

I don't think there's any magic, and yes I do buy the argument that it
could be done normally.
Quite frankly, I don't know why the device works like this other than
pin saving. Probably some customer asked for it rather than there being
a generic use case.

> > That said, the more this discussion goes on, the more I think that
> > merging the devices into a single node is a mistake. Logically there may
> > be one device, but really there are one to four devices. Doing the
> > logical device thing is nice maybe for software but I no longer think
> > that it represents the hardware correctly. I know this will cause
> > problems with registration of devices in the SPI core, but we need to
> > pick one representation for these devices that fits in all usecases
> > and with the things brought up in the other mail I am having a lot of
> > doubts.
>=20
> This wasn't about use cases as such but the broadcast like facilities the
> ADI parts have which to me smell like the main reason you'd put them on
> a single bus and use this feature in the first place - you are making
> one big DAC from multiple chips.

No, I think the use case bit is important. The representation (in dt)
shouldn't change because someone wants to use the device as one big dac
or 4 smaller dacs. The multicast thing does certainly lend a lot of
weight to treating the dacs as one device, so I guess that would be the
designated representation for this dac.
But then I don't see why the microchip devices couldn't be dealt with in
the same way, even if they don't have multicast, in order to create a
single consistent way of describing the devices.

> > Only going to reply to this for now, I'll reply to the other thread of
> > this conversation later so as not to end up duplicating discussion, but

One of the arguments in the other part of the discussion was about "what
if regulators aren't shared", but I don't think that's a big deal? It's
easy to just add additional "vcc1-supply" (or whatever name) regulators
to the node.

> > I am thinking of things like what if someone puts a mcp3654r and an
> > ad5529r on the same chip select? I think that's actually perfectly
> > functional on a hardware level, provided the fuses/pins are set up
> > correctly (and if it is not, mixing the microchip devices is possible
> > and probably mixing future ADI ones will be too).
>=20
> The broadcast stuff is what breaks this.  Otherwise I fully agree they
> should be independent and we should have SPI allow that.

And hopefully we can be blissfully ignorant and nobody actually mixes
and matches devices in this way anyway so we never have to deal with
it.


--ySe+qNYy9FceFUoD
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCamuRoAAKCRB4tDGHoIJi
0jo+AQDQIYwhUTINlc5q2xh0WcrK3oZnmfX9+2iuHTNFIBXniAEA+ShubVt5juXt
RcwiOaiYIsInHBbkUlUyQne6sGz/Gg8=
=xOT/
-----END PGP SIGNATURE-----

--ySe+qNYy9FceFUoD--
