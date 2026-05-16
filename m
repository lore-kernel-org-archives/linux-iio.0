Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18E5405C38;
	Sat, 16 May 2026 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778927868; cv=none; b=EgMElGpxqu/eDq+fVrkMMQqko8DcRJJmrdrEaO8ogZWk4zCjHtgmnMAQMbWlaFJrj9iX+PtvYpLlNDSCYJ3qHdejVLU64qd5tBYnyvkWp7NSfzs0UbpOC2AD7k6/eljv+8PRSXZo9aqpncLx7HvaPdwOsu1/c1qyVA2LqNZTsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778927868; c=relaxed/simple;
	bh=c312wq5rLmmSolfCWWPgTKOAr/E3Jsx7423lokHn5Ho=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0sHLXU8P8Oi5PbSN2NXkntwZOQChZBYOvOiEUA8sf7Vf/KuG2A2ENjcfj3+vyxwflcbl0clIH4ZptiUgfMwWUlCRPIyyJMH7dm36zUhFaPf8IS6dVNCT9E3BholMqfMoJTLrgN3K9WUUtrT6KbWAIweAUcr3TvOlGKEA3xzGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skonmPuz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skonmPuz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40F2EC19425;
	Sat, 16 May 2026 10:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778927867;
	bh=c312wq5rLmmSolfCWWPgTKOAr/E3Jsx7423lokHn5Ho=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=skonmPuzr2zYcV0F5sBMyceRZcCzaw82/EKdNI+hcfK1WqsgE1WB7qZnW3H1byYTl
	 9ahMBXYO0XrTFCqfBSXVhCCZwoWwxf2D+GoBQXBfDj/UxMyU+WxT1UThAuoMI6sfOR
	 OP8l/w9xuSRLJ41XTkg2Pxpx4UVYbdMFd26hpdWFZt6X6Ugfj0bWwjisLJTKdUrLug
	 7dfP1TDbQz0/dFtSs6gAmx+8ozzwXcntTuZDfYyN8TaBdrC2zOxJHP02rvgrX5A/NP
	 3967XFs18RPsBCcLr2dFyAz/+PAAT3z19qgZEVvIH5HGHRgKONLEVq+tK1aaazgvUQ
	 cEt9qMxdaqy/w==
Date: Sat, 16 May 2026 11:37:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <jonath4nns@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [RFC] iio: adc: support for multi-device aggregation
Message-ID: <20260516113738.4103f388@jic23-huawei>
In-Reply-To: <agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com>
References: <af0EGv172ZMl/6N5@JSANTO12-L01.ad.analog.com>
	<af2gJyG3rDjsjFmo@nsa>
	<agdKRhtywsThg/gT@JSANTO12-L01.ad.analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 13:31:02 -0300
Jonathan Santos <jonath4nns@gmail.com> wrote:

> On 05/08, Nuno S=C3=A1 wrote:
> > On Thu, May 07, 2026 at 06:28:58PM -0300, Jonathan Santos wrote: =20
> > > Hi all,
> > >=20
> > > We have a request to support multiple devices tied together in a sing=
le evaluation
> > > board. The goal is to be able to read them simultaneously via the IIO=
 framework,
> > > while also controlling them individually. Currently we have two ADC d=
evices that
> > > would benefit from this, but there might be more in the future.
> > >=20
> > > This is the scenario:
> > >=20
> > > +---------------+                                                =20
> > > |     ADC 0     |                                                =20
> > > |               |                                                =20
> > > |        SYNC_IN|---+---------------------------+                =20
> > > |          DRDY0|---|------------------------+  |                =20
> > > |               |   |                        |  |   +------------+
> > > |          SCLK0|---|------+                 |  |   |    HOST    |
> > > |           SDI0|---|------|--+              |  |   |            |
> > > |            CS0|---|------|--|-----------+  |  +-->|ADC_SYNC    |
> > > |          DOUT0|---|------|--|--------+  |  |      |            |
> > > |               |   |      |  |        |  |  |      |            |
> > > +---------------+   |      +--|--------|--|--|----->|SCLK        |
> > >                     |      |  +--------|--|--|----->|MOSI        |
> > > +---------------+   |      |  |        |  |  |      |            |
> > > |     ADC 1     |   |      |  |        |  |  |      |            |
> > > |               |   |      |  |        |  |  +----->|DRDY0       |
> > > |        SYNC_IN|---+      |  |        |  +-------->|CS0         |
> > > |          DRDY1|---|------|--|----+   +----------->|MISO0       |
> > > |               |   |      |  |    |                |            |
> > > |          SCLK1|---|------+  |    |                |            |
> > > |           SDI1|---|------|--+    +--------------->|DRDY1       |
> > > |            CS1|---|------|--|-------------------->|CS1         |
> > > |          DOUT1|---|------|--|-------------------->|MISO1       |
> > > |               |   |      |  |                     |            |
> > > +---------------+   |      |  |                     | .          |
> > >                     |      |  |                     | .          |
> > >        ...          |      |  |                     | .          |
> > >                     |      |  |                     |            |
> > > +---------------+   |      |  |            +------->|DRDYN       |
> > > |     ADC N     |   |      |  |            | +----->|CSN         |
> > > |               |   |      |  |            | | +--->|MISON       |
> > > |        SYNC_IN|---+      |  |            | | |    |            |
> > > |          DRDYN|----------|--|------------+ | |    +------------+
> > > |               |          |  |              | |                 =20
> > > |          SCLKN|----------+  |              | |                 =20
> > > |           SDIN|-------------+              | |                 =20
> > > |            CSN|----------------------------+ |                 =20
> > > |          DOUTN|------------------------------+                 =20
> > > |               |                                                =20
> > > +---------------+                                                    =
                                               =20
> > >  =20
Took me a while to get to this.=20

Another datapoint to perhaps look at is daisychain SPI devices. That's
moderately common on high end ADCs with applications such as electric car b=
attery
monitoring as they need to scale to 100s of devices and separate CS for eac=
h would
be a pain. =20

For those we just handled it in the ADC driver.

If we need to have a device specific aggregator driver to make any scheme w=
ork
then it might be better to just make it a driver problem.

> >=20
> > Do we have any FPGA IP for high speed transfers? If so, it would be nice
> > to have it in the above diagram.
> >  =20
>=20
> We only use the SPI-engine offload with the new multilane data feature.
>=20
> > > To summarize, the devices share SPI pins such as SCLK and MOSI, but h=
ave individual
> > > chip-selects and MOSIs (we can consider individual SPI interfaces). T=
he ideia
> > > is to allow users to aggregate these devices so they can be read simu=
ltaneously
> > > from the user space.
> > >=20
> > > I found a similar case here involving the AD4880 (ad4080 driver), whi=
ch consists
> > > of two independent ADC channels, each with its own SPI interface for =
configuration.
> > > In that instance, the ancillary device feature was used because it wa=
s considered
> > > the approach of a single device with independent channels rather than=
 independent
> > > devices connected together. Additionally, the backend handled the buf=
fered data
> > > aggregation.
> > >=20
> > > However, I would like to discuss a more generic approach to support d=
evice aggregation
> > > across different drivers. Marcelo suggested a while ago to consider t=
he components
> > > framework. This would allow us to create a virtual device responsible=
 for=20
> > > aggregating and controlling the sub-devices in a standard yet flexibl=
e manner. =20
> >=20
> > component might fit here but it has it's limitations and I fear (one of
> > the reasons I did not used for the backend stuff) is that it looks too =
geared for DRM. But yeah,
> > in theory is more or less what we have here with the distinction (I
> > think) that the type of devices are actually different :).
> >  =20
>=20
> Yes, they are different, but i did not find something more similar. Here
> the goal is to define a standard way of aggregating multiple devices
> from the same driver.
>=20
> > >=20
> > > The aggregate driver could either be an extension to the main driver =
(e.g. ad7768-1.c),
> > > or a separate file (e.g. ad7768-1-agreegator.c).  =20
> >=20
> > I guess we could support this in the main driver (more on this below).
> >  =20
> > >=20
> > > Here's an example of how the devicetree would look like:=20
> > > (includes the multiple data lanes feature)
> > >=20
> > > spi {
> > >     #address-cells =3D <1>;
> > >     #size-cells =3D <0>;
> > >=20
> > >     /* AD7768-1 physical devices */
> > >     adaq7768_1_0: adaq7768-1@0 {
> > > 	compatible =3D "adi,adaq7768-1";
> > > 	reg =3D <0>;  /* CS0 - First physical device */
> > >         spi-tx-lane-map =3D <0>;
> > >         spi-rx-lane-map =3D <0>;
> > > 	/* other properties */
> > >     };
> > >=20
> > >     adaq7768_1_1: adaq7768-1@1 {
> > >         compatible =3D "adi,adaq7768-1";
> > >         reg =3D <1>;  /* CS1 - Second physical device */
> > >         spi-tx-lane-map =3D <0>;
> > >         spi-rx-lane-map =3D <1>;
> > >         /* other properties */
> > >     };
> > >=20
> > >     adaq7768_1_2: adaq7768-1@2 {
> > >         compatible =3D "adi,adaq7768-1";
> > >         reg =3D <2>;  /* CS2 - Third physical device */
> > >         spi-tx-lane-map =3D <0>;
> > >         spi-rx-lane-map =3D <2>;
> > >         /* other properties */
> > >     };
> > >=20
> > >     adaq7768_1_3: adaq7768-1@3 {
> > >         compatible =3D "adi,adaq7768-1";
> > >         reg =3D <3>;  /* CS3 */
> > >         spi-tx-lane-map =3D <0>;
> > >         spi-rx-lane-map =3D <3>;
> > >         /* other properties */
> > >     };
> > >=20
> > >     /* AD7768-1 aggregator/virtual device */
> > >     quad_adaq7768: ad7768-1-aggregator@4 {
> > >         compatible =3D "adi,ad7768-1-aggregator";
> > >         reg =3D <4>; /* ? */
> > >=20
> > >         adaq7768-components =3D <&adaq7768_1_0>, <&adaq7768_1_1>, <&a=
daq7768_1_2>, <&adaq7768_1_3>;
> > >          =20
> >=20
> > I guess we can avoid the dummy device! The one having the components
> > with be the main/controller device but I guess we would still need a cu=
stom
> > property for the other nodes in case they need to do something specific
> > for this arrangement.
> >  =20
>=20
> Yeah, defining one device as the controller looks cleaner, but we still
> have that problem of the main "owning" or using the CS from the other
> devices (if they are registered separately).
>=20
Long ago I did some thinking about the fidlier problem of aggregating multi=
ple
unrelated device driver buffer outputs - was for sensor fusions stuff.
In the end I concluded it was easier to just do it in user space.  As long
as they ran off the same trigger then the data alignment problem wasn't too=
 hard.

Obviously here things are a bit different as the SPI offload IP is doing the
data marshalling.

> >  =20
> > >     };
> > >        =20
> > > };
> > >=20
> > > Is it ok to proceed with component helper for this purpose or do we h=
ave something
> > > better? If yes, I have some following questions:
> > >  =20
> > > -> How to read all devices simultaneously in buffer mode given we can=
't assert  =20
> > > all CS from the virtual device? =20
> >=20
> > Isn't this also an HW question? Not sure how that can be done
> > simultaneously without some kind of HW synchronization. In SW, I'm not
> > seeing other way other than  N SPI transfers and put them together in t=
he buffer.=20
> >  =20
>=20
> In HW we have that multiple data lane feature that receives the data
> from eache SDI lane and put them in order (for FIFO mode and offload mode=
).
> If we are not using offload, we could set N SPI transfers and then
> aggregate them into one buffer. But how to do that in offload? We cannot
> control the CS mask from userspace.

If it's not doing hardware offload is it worth the pain?  Easy enough to do
it in userspace - particularly if we have timestamps as a bit of nearest
timestamp maths allows easy buffer alignment.

>=20
> > thou>  =20
> > > -> Should the physical devices be registered in IIO during probe, or =
should only =20
> > > the aggregator be exposed to control attributes and general configura=
tion? =20
> >=20
> > Good question but it would likely make for a better/simpler interface i=
f only
> > one device was registered (with multiple channels - depending on the
> > number of devices). Similar to backends. I guess the idea is also to
> > only have one IIO buffer for all the channels?
> >  =20
>=20
> Yes, the ideia is to have a single buffer to allow reading them
> simultaneously from the userspace.
>=20
> > Or, IIUC, at the very least, only the aggregator could expose a buffer.
> > But again, linking the other device channels to the buffer is not really
> > doable without major changes in the core.
> >=20
> > Something that also just come to my mind! What about the IIO inkernel
> > interface and things like=20
> >=20
> > industrialio-buffer-cb.c
> > industrialio-hw-consumer.c
> >=20
> > Maybe they have some limitations but something that we can work on? Not
> > sure though...
> >  =20
>=20
> The Inkernel is interesting, I will see what can be done to cover this
> case.

How common do we think this requirement is?  If it's just a couple of
devices I'd go a similar route to the daisy chaining case and do
something in the specific driver.  Maybe the only point of generalization
is the dt-bindings if we got that way.  Designing that to maybe let
us do a generic answer in the long term might be the right compromise
in not adding complexity to the core until it's proven to be needed.

Now if you have customers asking for it on 10 different devices today then
sure let's look at it sooner!  Even then it might be some library code that
the drivers use rather than big changes to the data flow in the IIO core.

Jonathan

>=20
> > - Nuno S=C3=A1
> >  =20
> > >=20
> > > Regards,
> > > Jonathan S.
> > >  =20
>=20

