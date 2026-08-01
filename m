Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF8B3033E1;
	Sat,  1 Aug 2026 01:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785548166; cv=none; b=O1qeUUdh9+vppCeRTx7Ljti0NCgbu6osjktyAqLnJ59HwhZoVYta3PQZL1nuAILzl1dkCjK6BOzIRht6J5EEkqJyB/Ig9DIX3PKVjB1V+BKAVgXI34qrHOhlK2328iyBHTa4HhtJJkecjA/aZjk2uDk03CTR7MDbfGPN6jZbyNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785548166; c=relaxed/simple;
	bh=r7oiTiYjeQju6tHE//0QjsxRju5s7cFFKs85vjyZIkw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uzNE+igniJli9HzqSPbaaHTPNLSVZhgCrZv8PVyNt7UmOQN+q7JuWwLLkgo9PqBWRS7Cux9z7DJnufPazuxRpJqKW76lX/70qz440IUL7bxVgAFaloM01/DhTTTV6T4OA36H6QXt4Pqw30lKTVKewuc2iX7zS8i6wrhiGepo3Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOWIYA5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOWIYA5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CDCD1F00AC4;
	Sat,  1 Aug 2026 01:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785548164;
	bh=4jArxDM9USCSkaqFBmc3NyMcgznnCOvA1OiMury80ow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mOWIYA5xbqWHtr1MHcnrYyFa0Js7eIBtbRbesGfezjMe4VPnRvFwvs18UHSLiKUpt
	 BGiEf5RZqArEEUWGcfbuYeVHQYL/slLUuqtaTMy1mASZRZpoRXJVAaXfbqe8wsCJDb
	 rLl/XS1ekqVsMcwuoOpz8QUCRtNn9bM9zJtQ6h7tdHCmQ+u8WqueEt1D3Q3xqH1tup
	 4p0Dki1+/kTpHC1UpSF/EmkkkFvC0NQ5K2qZ04KiE+Ww/eEtuhV9HMihgMFcR5GMjC
	 VBM3LAva2Rb2cASV4PTomwnZ0qsh1bD8n/Y3kK8G3qdNbgoGLI1x4kG3dnnU6xIoL8
	 A3Ww6Zhnm84pw==
Date: Sat, 1 Aug 2026 02:35:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Janani Sunil <janani.sunil@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Marius
 Cristea <marius.cristea@microchip.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
 <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260801023559.3c0b7f2d@jic23-huawei>
In-Reply-To: <20260730-mouse-shininess-0bb63d414cef@spud>
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
	<20260730-mouse-shininess-0bb63d414cef@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 30 Jul 2026 19:09:19 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Thu, Jul 30, 2026 at 06:34:25PM +0100, Jonathan Cameron wrote:
> > On Thu, 30 Jul 2026 11:25:34 +0100
> > Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
> >  =20
> > > On Thu, Jul 30, 2026 at 12:09:29AM +0100, Jonathan Cameron wrote: =20
> > > > On Wed, 29 Jul 2026 21:47:45 +0100
> > > > Conor Dooley <conor@kernel.org> wrote:
> > > >    =20
> > > > > On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:=
   =20
> > > > > > On Tue, 28 Jul 2026 17:00:55 +0100
> > > > > > Conor Dooley <conor@kernel.org> wrote:
> > > > > >      =20
> > > > > > > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wr=
ote:     =20
> > > > > > > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > > > > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > > > > >        =20
> > > > > > > > > On 7/22/26 2:54 AM, Janani Sunil wrote:       =20
> > > > > > > > > > Add the generic spi-device-addr property to the binding=
 and deprecate
> > > > > > > > > > the existing vendor specific microchip,hw-device-addres=
s property.
> > > > > > > > > >=20
> > > > > > > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > > > > > > ---
> > > > > > > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml=
         | 10 ++++++++--
> > > > > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > > > > >=20
> > > > > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/=
microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchi=
p,mcp3564.yaml
> > > > > > > > > > index 675319276197..de1ea289e7f5 100644
> > > > > > > > > > --- a/Documentation/devicetree/bindings/iio/adc/microch=
ip,mcp3564.yaml
> > > > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microch=
ip,mcp3564.yaml
> > > > > > > > > > @@ -80,6 +80,7 @@ properties:
> > > > > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > >      minimum: 0
> > > > > > > > > >      maximum: 3
> > > > > > > > > > +    deprecated: true
> > > > > > > > > >      description:
> > > > > > > > > >        The address is set on a per-device basis by fuse=
s in the factory,
> > > > > > > > > >        configured on request. If not requested, the fus=
es are set for 0x1.
> > > > > > > > > > @@ -91,6 +92,12 @@ properties:
> > > > > > > > > >        clocking of the device address (BITS[7:6] - top =
two bits of COMMAND BYTE
> > > > > > > > > >        which is first one on the wire).
> > > > > > > > > > =20
> > > > > > > > > > +  spi-device-addr:
> > > > > > > > > > +    maxItems: 1         =20
> > > > > > > > >=20
> > > > > > > > > Does it not make sense to all for more than once device c=
onnected
> > > > > > > > > to the same CS here? I would expect maxItems to be 4 to m=
atch the
> > > > > > > > > number of possible addresses.
> > > > > > > > >        =20
> > > > > > > >=20
> > > > > > > > I think for this part their isn't a reason to aggregate.
> > > > > > > > No magic accesses that touch them all at once.  So this hits
> > > > > > > > exactly the point you raised about how we set the address f=
or
> > > > > > > > more than one of them.       =20
> > > > > > >=20
> > > > > > > No David is actually right here, and maxitems should be 4.
> > > > > > > Setting the address for multiple was already discussed I thou=
ght, with
> > > > > > > the property being an array and each compatible being used to=
 determine
> > > > > > > the "stride" between entries based on the number of supported=
 channels?     =20
> > > > > >=20
> > > > > > I don't think that applies for this device or at least to do so
> > > > > > is a major driver rewrite, not a simple binding change.  Probab=
ly we'd     =20
> > > > >=20
> > > > > Whether or not it is a big driver change, the binding should repr=
esent
> > > > > what the hardware is capable of.
> > > > >    =20
> > > > > > just add a bus and hang the 4 instances off it. They are runnin=
g on own
> > > > > > timing etc so we can't grab data across all of them in any sort=
 of
> > > > > > synchronous way - the clocks will probably drift over time etc.=
     =20
> > > > >=20
> > > > > Did I miss something about the ADI devices in this thread where t=
hey
> > > > > have some multicast ability to read all devices at once? I though=
t that
> > > > > that was a different series where each device had dedicated mosi =
and
> > > > > miso lines, rather than the shared ones here. I didn't think the =
ad5529r
> > > > > did anything special from my reading of the datasheet but I'm not=
 the
> > > > > expert in this area!   =20
> > > >=20
> > > > It's a DAC so other way around but yes they have exactly that in th=
e section:
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad5529r.pdf
> > > >=20
> > > > 	Register Details: Hotpath DAC registermap.
> > > >=20
> > > > The is a brief description earlier of the whole feature that might
> > > > serve for this discussion:
> > > >=20
> > > > "DAC HOTPATH
> > > > The DAC hotpath is a dedicated register region that optimizes
> > > > DAC updates in multidevice configurations where several AD5529R
> > > > devices share a common SPI bus. It reduces the number of SPI
> > > > frames required to write DAC data and supports synchronized
> > > > output updates across devices. In single device systems, the hotpath
> > > > offers no advantage over the standard register map and can be
> > > > disregarded."
> > > >=20
> > > > As an example
> > > > MULTI DEVICE SW LDAC MODE 0 REGISTER
> > > > "This register sends a software LDAC update to the selected devices
> > > > that share the SPI lines but have different addresses, using the ID0
> > > > and ID1 pins. The selection is done on a per-device basis correspon=
ding
> > > > to the configured bit field."
> > > >=20
> > > > This one triggers all selected DACs (there is bit corresponding to
> > > > each address) to update in sync. (Lets put aside normal systems
> > > > where an LDAC gpio is wired to multiple devices as that is a whole
> > > > different problem).
> > > >=20
> > > >=20
> > > > It is this part that is driving the suggestion of having
> > > > a combined device representation for multiple physical devices.
> > > > In practice it is very similar to chained devices where we do that
> > > > already in that a longer access sequence is used to talk to multiple
> > > > devices at once.
> > > >=20
> > > > Those SPI messages do not carry the address (or they are ignored - =
I didn't
> > > > dig into the mechanism).
> > > >=20
> > > >    =20
> > > > >    =20
> > > > > > They are independent devices (think of them using spi-device-ad=
dress
> > > > > > like an i2c address) -  so why have one DT node for up to 4 of
> > > > > > them?  Note this is different from the AD5529R where the design
> > > > > > is intended for them to operate as one single larger device.   =
  =20
> > > > >=20
> > > > > I don't buy this argument, I just don't see what differs between =
the
> > > > > devices. The microchip datasheet I read talked about using 3 devi=
ces to
> > > > > measure 3 phase power setups (I think that's what it was) which i=
s, in
> > > > > my book, evidence that they're not just intended to be used
> > > > > independently.   =20
> > > >=20
> > > > Sure but that could just as easily be done with normal SPI and 3 ch=
ip
> > > > selects. For these devices there is no broadcast write magic (I thi=
nk
> > > > anyway!)
> > > >    =20
> > > > >=20
> > > > > That said, the more this discussion goes on, the more I think that
> > > > > merging the devices into a single node is a mistake. Logically th=
ere may
> > > > > be one device, but really there are one to four devices. Doing the
> > > > > logical device thing is nice maybe for software but I no longer t=
hink
> > > > > that it represents the hardware correctly. I know this will cause
> > > > > problems with registration of devices in the SPI core, but we nee=
d to
> > > > > pick one representation for these devices that fits in all usecas=
es
> > > > > and with the things brought up in the other mail I am having a lo=
t of
> > > > > doubts.   =20
> > > >=20
> > > > This wasn't about use cases as such but the broadcast like faciliti=
es the
> > > > ADI parts have which to me smell like the main reason you'd put the=
m on
> > > > a single bus and use this feature in the first place - you are maki=
ng
> > > > one big DAC from multiple chips.
> > > >    =20
> > > > >=20
> > > > > Only going to reply to this for now, I'll reply to the other thre=
ad of
> > > > > this conversation later so as not to end up duplicating discussio=
n, but
> > > > > I am thinking of things like what if someone puts a mcp3654r and =
an
> > > > > ad5529r on the same chip select? I think that's actually perfectly
> > > > > functional on a hardware level, provided the fuses/pins are set up
> > > > > correctly (and if it is not, mixing the microchip devices is poss=
ible
> > > > > and probably mixing future ADI ones will be too).   =20
> > > >=20
> > > > The broadcast stuff is what breaks this.  Otherwise I fully agree t=
hey
> > > > should be independent and we should have SPI allow that.
> > > >    =20
> > >=20
> > > Exactly! The idea of having the devices as separate nodes always felts
> > > really appealing to me given that's what we have (strictly sepaking) =
in
> > > HW. But as you stated, the big reason to pack multiple devices (for t=
he
> > > ADI case) is to basically increase the number of channels and so
> > > aggregate the devices together. =20
> >=20
> > Key detail is not just aggregate devices but have them act as one device
> > from an interface point of view (just like SPI chaining).  One message
> > affects multiple devices. =20
>=20
> Do you have an example of this "SPI chaining"?

Sure, there are a few in tree.  The adi,ad7280a is an example
used for automotive many cell lithium ion battery monitoring.
That one lets you daisy chain up to 8 spi devices.  Each
device has both upstream and downstream SPI connections
and to read from all ADCs you just keep reading one after
another. See ad7280_read_all_channels()=20

The length of the chain isn't in the binding as a simple discovery
routine works.  We haven't been particularly consistent on this
aspect. For the ad7944 we have to set a mode that says there is
a chain - I don't recall if there is a reason for that and haven't
checked.


>=20
> > > But taking on David's suggestion,
> > > couldn't we somehow reuse that for AD5529R such that the additional
> > > DAC's would be child nodes? =20
> >=20
> >=20
> > If they were child nodes that just means we have a device specific bind=
ing
> > and in practice ends up the same as a binding that just makes it one de=
vice.
> >=20
> > adc@cs {
> >=20
> > 	adc@spi-device-addr0 {
> > 		spi-device-addr =3D spi-device-addr0;
> > 	};
> > 	adc@spidevice-addr1 {
> > 		spi-device-addr =3D spi-device-addr1;
> > 	}; =20
>=20
> If you were doing this, the spi-device-addr property would just become
> "reg" FWIW.

Good point.=20

>=20
> > }
> >=20
> > Fun question of where we do the xlate for references to channels so
> > does a consumer point at the outer node or the inner one?
> >=20
> > I'm not seeing a gain over having an array of spi-device-addr in the
> > top level node. =20
>=20
> Yeah, I can think of some things but I don't think it is anything more
> than net neutral.

