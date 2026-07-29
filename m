Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA660381EA3;
	Wed, 29 Jul 2026 23:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785366577; cv=none; b=KxqymJaSWyZ05c+2KwOO757EdxbyrB/uzOWHitaZ71TsB2LAj039LEdBdSUCM02DvGMcvIdwSWoGQrNFFUrNaQuHqnoBxR/2sihajgZffZHfmN8/AzfScJlw+iMgWgWUHz8y6DnQCrwqtkYb5dFDVYbEIDwnOCDaDbWb6S38Ibs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785366577; c=relaxed/simple;
	bh=VaLLg4E77zypU7MzWB173soKqIC+WlqYXnBlXkX8m/g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFeN/h8wk1xTZePLCvIrdFCBxzPjBlY+bh8JqTaF0oEfXAfO0cMzKh06jnhi5plv2FObpQqqFH4hcNfSOLwi8vab71c4lqFwsw/ify0qm0CNCIhNGh1ZYDuzr01gaiaQ1V012wSYwTFjaWS2YIKn7hMo/bHLJzofnPE+s22Rj2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfYz/K6H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfYz/K6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 455DC1F000E9;
	Wed, 29 Jul 2026 23:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785366575;
	bh=qwCwB4l1jJif4G/OahJteb6HrtiO/YmN0M2WQ7WqvxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VfYz/K6H6vBzOEUoOcR7YxF7g0i3/wyZEw8vyRNkxRiIv4xT3VXaAghc5b30F2Vf8
	 P2DDahVCfbawqk1wiH4uerYZJhmH+a1Y99UCIurFB9sMr1a5WsxF4Es+4rwrhWPr+A
	 rhfZq4GaGVkV0ly3z1xc7Bq8Gj+Y5P/WfcyUokBztRW0m3TqiOESC6es2eGlUdeDXJ
	 SNRfKOvyPfcCrJqj7T7rJKrCO1Qb3jzL+1xLqNFfE+E26gsEecw9lenrnDr0cmA9uA
	 3WjZ+IA6EcJQurl7SkNfFeaRZtn7p/OE5MokutHvp+uy/tYhGjCmvbhSUQ/xbhO78r
	 F+4++YPB4XC+Q==
Date: Thu, 30 Jul 2026 00:09:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Janani Sunil
 <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Mark Brown
 <broonie@kernel.org>, Marius Cristea <marius.cristea@microchip.com>, Marcus
 Folkesson <marcus.folkesson@gmail.com>, Kent Gustavsson <kent@minoris.se>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil
 <jan.sun97@gmail.com>, linux-spi@vger.kernel.org, Kent Gustavsson
 <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <20260730000929.2ec20cf8@jic23-huawei>
In-Reply-To: <20260729-hundredth-suffice-f28afa67bc06@spud>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	<20260722-ad5529r-driver-v7-2-7781cd74ad75@analog.com>
	<cb4098c1-4bad-4a11-9a6f-a833e554f197@baylibre.com>
	<20260725230739.63ff7000@jic23-huawei>
	<20260728-patronize-thwarting-56fab2e11077@spud>
	<20260728221719.7f668a73@jic23-huawei>
	<20260729-hundredth-suffice-f28afa67bc06@spud>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Jul 2026 21:47:45 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:
> > On Tue, 28 Jul 2026 17:00:55 +0100
> > Conor Dooley <conor@kernel.org> wrote:
> >   
> > > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:  
> > > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > > David Lechner <dlechner@baylibre.com> wrote:
> > > >     
> > > > > On 7/22/26 2:54 AM, Janani Sunil wrote:    
> > > > > > Add the generic spi-device-addr property to the binding and deprecate
> > > > > > the existing vendor specific microchip,hw-device-address property.
> > > > > > 
> > > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > > ---
> > > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
> > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > 
> > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > index 675319276197..de1ea289e7f5 100644
> > > > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > @@ -80,6 +80,7 @@ properties:
> > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > >      minimum: 0
> > > > > >      maximum: 3
> > > > > > +    deprecated: true
> > > > > >      description:
> > > > > >        The address is set on a per-device basis by fuses in the factory,
> > > > > >        configured on request. If not requested, the fuses are set for 0x1.
> > > > > > @@ -91,6 +92,12 @@ properties:
> > > > > >        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > > > > >        which is first one on the wire).
> > > > > >  
> > > > > > +  spi-device-addr:
> > > > > > +    maxItems: 1      
> > > > > 
> > > > > Does it not make sense to all for more than once device connected
> > > > > to the same CS here? I would expect maxItems to be 4 to match the
> > > > > number of possible addresses.
> > > > >     
> > > > 
> > > > I think for this part their isn't a reason to aggregate.
> > > > No magic accesses that touch them all at once.  So this hits
> > > > exactly the point you raised about how we set the address for
> > > > more than one of them.    
> > > 
> > > No David is actually right here, and maxitems should be 4.
> > > Setting the address for multiple was already discussed I thought, with
> > > the property being an array and each compatible being used to determine
> > > the "stride" between entries based on the number of supported channels?  
> > 
> > I don't think that applies for this device or at least to do so
> > is a major driver rewrite, not a simple binding change.  Probably we'd  
> 
> Whether or not it is a big driver change, the binding should represent
> what the hardware is capable of.
> 
> > just add a bus and hang the 4 instances off it. They are running on own
> > timing etc so we can't grab data across all of them in any sort of
> > synchronous way - the clocks will probably drift over time etc.  
> 
> Did I miss something about the ADI devices in this thread where they
> have some multicast ability to read all devices at once? I thought that
> that was a different series where each device had dedicated mosi and
> miso lines, rather than the shared ones here. I didn't think the ad5529r
> did anything special from my reading of the datasheet but I'm not the
> expert in this area!

It's a DAC so other way around but yes they have exactly that in the section:
https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf

	Register Details: Hotpath DAC registermap.

The is a brief description earlier of the whole feature that might
serve for this discussion:

"DAC HOTPATH
The DAC hotpath is a dedicated register region that optimizes
DAC updates in multidevice configurations where several AD5529R
devices share a common SPI bus. It reduces the number of SPI
frames required to write DAC data and supports synchronized
output updates across devices. In single device systems, the hotpath
offers no advantage over the standard register map and can be
disregarded."

As an example
MULTI DEVICE SW LDAC MODE 0 REGISTER
"This register sends a software LDAC update to the selected devices
that share the SPI lines but have different addresses, using the ID0
and ID1 pins. The selection is done on a per-device basis corresponding
to the configured bit field."

This one triggers all selected DACs (there is bit corresponding to
each address) to update in sync. (Lets put aside normal systems
where an LDAC gpio is wired to multiple devices as that is a whole
different problem).


It is this part that is driving the suggestion of having
a combined device representation for multiple physical devices.
In practice it is very similar to chained devices where we do that
already in that a longer access sequence is used to talk to multiple
devices at once.

Those SPI messages do not carry the address (or they are ignored - I didn't
dig into the mechanism).


> 
> > They are independent devices (think of them using spi-device-address
> > like an i2c address) -  so why have one DT node for up to 4 of
> > them?  Note this is different from the AD5529R where the design
> > is intended for them to operate as one single larger device.  
> 
> I don't buy this argument, I just don't see what differs between the
> devices. The microchip datasheet I read talked about using 3 devices to
> measure 3 phase power setups (I think that's what it was) which is, in
> my book, evidence that they're not just intended to be used
> independently.

Sure but that could just as easily be done with normal SPI and 3 chip
selects. For these devices there is no broadcast write magic (I think
anyway!)

> 
> That said, the more this discussion goes on, the more I think that
> merging the devices into a single node is a mistake. Logically there may
> be one device, but really there are one to four devices. Doing the
> logical device thing is nice maybe for software but I no longer think
> that it represents the hardware correctly. I know this will cause
> problems with registration of devices in the SPI core, but we need to
> pick one representation for these devices that fits in all usecases
> and with the things brought up in the other mail I am having a lot of
> doubts.

This wasn't about use cases as such but the broadcast like facilities the
ADI parts have which to me smell like the main reason you'd put them on
a single bus and use this feature in the first place - you are making
one big DAC from multiple chips.

> 
> Only going to reply to this for now, I'll reply to the other thread of
> this conversation later so as not to end up duplicating discussion, but
> I am thinking of things like what if someone puts a mcp3654r and an
> ad5529r on the same chip select? I think that's actually perfectly
> functional on a hardware level, provided the fuses/pins are set up
> correctly (and if it is not, mixing the microchip devices is possible
> and probably mixing future ADI ones will be too).

The broadcast stuff is what breaks this.  Otherwise I fully agree they
should be independent and we should have SPI allow that.

Jonathan

> 
> Cheers,
> Conor.

