Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FE34398EB
	for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 15:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785512261; cv=none; b=dmJH1JXcTPonWzRFHPff/UhYF7rliCRnuPcrWc5C+6wgILX1nPDCsbwbPmN5iaeDsRetCsgidL2ysmLUPFBhEeANhlNyVdBBex5CGf2XWXjaPofp7z6MZ059Apg+e+Fc+vtpWnaz7IJoogkEqI9T91gUMlHEb7t05UzA0QSe7DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785512261; c=relaxed/simple;
	bh=RIz5uFE89/3AH5trnb7BdwCqncYcoo8lgng/GM8KbCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YvP8DdCehkC91osm+yxel7S2lA2SqGFNORNzngqp+MlzoK7HS7YB6Q53YkGfNmXJDLMIP1ETd95f/uAmSAjWGnwlovcxbEi41gCAcwe8uluFdwoD4NXfn8qsmODIF4VLJx1ZFJUOt827WWM1CkqNZ+PfA1XB9hhWZYoWlCN8bQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKle13pT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKle13pT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47fd66a094eso113908f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 31 Jul 2026 08:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785512258; x=1786117058; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vFQpJGkjtdvHQP74/GFmQMxkPA36mSxEMNEvA9IJDZ8=;
        b=RKle13pT+wyckSLBqbfKxJ+KQsMj2pJC06LPrRFW4i9GGCSXhLW93IHWrEzhcfhFdd
         S0Kk7GK4mOTwBujfNxQmJFFbpCH6CFrn2JcRptB3m8lYgkIN81KimkM3dLclqxN4xDTV
         f+yW3qHfrWMCwDANGEQwdjDAjwf+FnkNETLjeMv1ME7g+13Laq5R1jsNlYKsljD8mfeV
         b8b5nD/pH+1jGs7j560D6zmaPkpsPyqq7W9YrysoivtL0AFK/1jbQlkjqa8UB8aQZQUY
         tJckjO3+l3T7/1Sn/hJOuKk4j29bJAK4Sv95czkq4C9GvERc44UnzMqr5eDMEJ8V7FuX
         gE0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785512258; x=1786117058;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vFQpJGkjtdvHQP74/GFmQMxkPA36mSxEMNEvA9IJDZ8=;
        b=RW+P03+OkXoYsrwPMjumzv5IoLpj5mOzKr4wykSaXAHJbdZKzSdej7F6OP5NHfHuLT
         HpLjGB9LT7tRKoxwp9hNt0vLh1tZ4XKkA6LavWsC3r/LHb8ZaIrosNAD1MlZjAa1fgQz
         EZ4elu9IEc6O5m1ljfrRHI2mjuFNurbeJ7ko3PRstroj1hU/SyP5jrdQmqjbGtO7krNJ
         GNGKFQLdiLYe4fzfhdB/S0gqX4/22IJvA0h4wz+e8pCzDWDzKLhiV6wkxxJdnad7zyhd
         qp4UWLyJZNlcD5KJ4UCeHIbIeM6IumVEW3qRJ7+SI64+wJN7kRO5SOtj6F9AgtRR5OzH
         T5Zg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ37CLUAUS36XkwrvPoBtZZtIy/LM/CraeAhPrRx/ryTrJNhfGXau1Snfu1DRnTDZfbosmBqVj09o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI4EVSrSE5WkpzIZ55ypqxiFDtmki4OgT3PpQuiLmcJ8Kg3mdj
	QddyS5pqpQJdcXDutjJqYvLWQ02YwtAMWNgHL946l5kJy0G+YhgykXNB
X-Gm-Gg: AR+sD10JtdQaNjauLiG072f1/dx6L/qrTNhNPy/r+mNWPOvmxqfjtbIDRuQ6iq2CF4V
	ZtxgM4gQMVIHViPPWVuGJ4D+vKauqW7LaeNS5Bxa4vptXCR/XCOMD27F4iPfjhgw52wG7Pa+aTN
	F7nGp4tFGSQXhkvMjfyWm06sTpoNzSIISyto+culBpjeQjUBNdU1frqUqc1F4ulqDEF0Jdym7v2
	g4T4Zu0ogIRKYx57OMGrE8x0MweQe1bVgOMcWLkVJJIhakM9b35eWyd6KLSZN/XwJvmyxN5sapS
	CtNHmFuu5GGEenIrYcniTL/EpQsj1/9WSbtCD8pjuuMS5Z3Zcudnk2WLO4Np8e41FfsgDfKv6t2
	MBgZACtRKrTqbJWYiJwj0bMNhHotE9XF302RO25GoZ1fW6T/pL6nWGWDgPe4R7l1iMzVML6V7rx
	Jvt5R5uXWYRxVTxvDpCttv8vDxcv2y3YVML8GulB5sDOF96JYh3ukLeM/1S+rKhT8=
X-Received: by 2002:a05:6000:3111:b0:47f:8ac0:282 with SMTP id ffacd0b85a97d-47fd72c6ec4mr276940f8f.17.1785512257261;
        Fri, 31 Jul 2026 08:37:37 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd41e296csm6031471f8f.12.2026.07.31.08.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 08:37:36 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:38:45 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Janani Sunil <janani.sunil@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, 
	Marius Cristea <marius.cristea@microchip.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Janani Sunil <jan.sun97@gmail.com>, 
	linux-spi@vger.kernel.org, Kent Gustavsson <nedo80@gmail.com>
Subject: Re: [PATCH v7 2/7] dt-bindings: iio: adc: microchip,mcp3564: Add
 spi-device-addr
Message-ID: <amzBUS2usZEBaSmZ@nsa>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260730183425.22f2ba8c@jic23-huawei>

On Thu, Jul 30, 2026 at 06:34:25PM +0100, Jonathan Cameron wrote:
> On Thu, 30 Jul 2026 11:25:34 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Thu, Jul 30, 2026 at 12:09:29AM +0100, Jonathan Cameron wrote:
> > > On Wed, 29 Jul 2026 21:47:45 +0100
> > > Conor Dooley <conor@kernel.org> wrote:
> > >   
> > > > On Tue, Jul 28, 2026 at 10:17:19PM +0100, Jonathan Cameron wrote:  
> > > > > On Tue, 28 Jul 2026 17:00:55 +0100
> > > > > Conor Dooley <conor@kernel.org> wrote:
> > > > >     
> > > > > > On Sat, Jul 25, 2026 at 11:07:39PM +0100, Jonathan Cameron wrote:    
> > > > > > > On Sat, 25 Jul 2026 15:57:07 -0500
> > > > > > > David Lechner <dlechner@baylibre.com> wrote:
> > > > > > >       
> > > > > > > > On 7/22/26 2:54 AM, Janani Sunil wrote:      
> > > > > > > > > Add the generic spi-device-addr property to the binding and deprecate
> > > > > > > > > the existing vendor specific microchip,hw-device-address property.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> > > > > > > > > ---
> > > > > > > > >  .../devicetree/bindings/iio/adc/microchip,mcp3564.yaml         | 10 ++++++++--
> > > > > > > > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > > > > > > > > 
> > > > > > > > > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > > > > index 675319276197..de1ea289e7f5 100644
> > > > > > > > > --- a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > > > > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > > > > > > > > @@ -80,6 +80,7 @@ properties:
> > > > > > > > >      $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > >      minimum: 0
> > > > > > > > >      maximum: 3
> > > > > > > > > +    deprecated: true
> > > > > > > > >      description:
> > > > > > > > >        The address is set on a per-device basis by fuses in the factory,
> > > > > > > > >        configured on request. If not requested, the fuses are set for 0x1.
> > > > > > > > > @@ -91,6 +92,12 @@ properties:
> > > > > > > > >        clocking of the device address (BITS[7:6] - top two bits of COMMAND BYTE
> > > > > > > > >        which is first one on the wire).
> > > > > > > > >  
> > > > > > > > > +  spi-device-addr:
> > > > > > > > > +    maxItems: 1        
> > > > > > > > 
> > > > > > > > Does it not make sense to all for more than once device connected
> > > > > > > > to the same CS here? I would expect maxItems to be 4 to match the
> > > > > > > > number of possible addresses.
> > > > > > > >       
> > > > > > > 
> > > > > > > I think for this part their isn't a reason to aggregate.
> > > > > > > No magic accesses that touch them all at once.  So this hits
> > > > > > > exactly the point you raised about how we set the address for
> > > > > > > more than one of them.      
> > > > > > 
> > > > > > No David is actually right here, and maxitems should be 4.
> > > > > > Setting the address for multiple was already discussed I thought, with
> > > > > > the property being an array and each compatible being used to determine
> > > > > > the "stride" between entries based on the number of supported channels?    
> > > > > 
> > > > > I don't think that applies for this device or at least to do so
> > > > > is a major driver rewrite, not a simple binding change.  Probably we'd    
> > > > 
> > > > Whether or not it is a big driver change, the binding should represent
> > > > what the hardware is capable of.
> > > >   
> > > > > just add a bus and hang the 4 instances off it. They are running on own
> > > > > timing etc so we can't grab data across all of them in any sort of
> > > > > synchronous way - the clocks will probably drift over time etc.    
> > > > 
> > > > Did I miss something about the ADI devices in this thread where they
> > > > have some multicast ability to read all devices at once? I thought that
> > > > that was a different series where each device had dedicated mosi and
> > > > miso lines, rather than the shared ones here. I didn't think the ad5529r
> > > > did anything special from my reading of the datasheet but I'm not the
> > > > expert in this area!  
> > > 
> > > It's a DAC so other way around but yes they have exactly that in the section:
> > > https://www.analog.com/media/en/technical-documentation/data-sheets/ad5529r.pdf
> > > 
> > > 	Register Details: Hotpath DAC registermap.
> > > 
> > > The is a brief description earlier of the whole feature that might
> > > serve for this discussion:
> > > 
> > > "DAC HOTPATH
> > > The DAC hotpath is a dedicated register region that optimizes
> > > DAC updates in multidevice configurations where several AD5529R
> > > devices share a common SPI bus. It reduces the number of SPI
> > > frames required to write DAC data and supports synchronized
> > > output updates across devices. In single device systems, the hotpath
> > > offers no advantage over the standard register map and can be
> > > disregarded."
> > > 
> > > As an example
> > > MULTI DEVICE SW LDAC MODE 0 REGISTER
> > > "This register sends a software LDAC update to the selected devices
> > > that share the SPI lines but have different addresses, using the ID0
> > > and ID1 pins. The selection is done on a per-device basis corresponding
> > > to the configured bit field."
> > > 
> > > This one triggers all selected DACs (there is bit corresponding to
> > > each address) to update in sync. (Lets put aside normal systems
> > > where an LDAC gpio is wired to multiple devices as that is a whole
> > > different problem).
> > > 
> > > 
> > > It is this part that is driving the suggestion of having
> > > a combined device representation for multiple physical devices.
> > > In practice it is very similar to chained devices where we do that
> > > already in that a longer access sequence is used to talk to multiple
> > > devices at once.
> > > 
> > > Those SPI messages do not carry the address (or they are ignored - I didn't
> > > dig into the mechanism).
> > > 
> > >   
> > > >   
> > > > > They are independent devices (think of them using spi-device-address
> > > > > like an i2c address) -  so why have one DT node for up to 4 of
> > > > > them?  Note this is different from the AD5529R where the design
> > > > > is intended for them to operate as one single larger device.    
> > > > 
> > > > I don't buy this argument, I just don't see what differs between the
> > > > devices. The microchip datasheet I read talked about using 3 devices to
> > > > measure 3 phase power setups (I think that's what it was) which is, in
> > > > my book, evidence that they're not just intended to be used
> > > > independently.  
> > > 
> > > Sure but that could just as easily be done with normal SPI and 3 chip
> > > selects. For these devices there is no broadcast write magic (I think
> > > anyway!)
> > >   
> > > > 
> > > > That said, the more this discussion goes on, the more I think that
> > > > merging the devices into a single node is a mistake. Logically there may
> > > > be one device, but really there are one to four devices. Doing the
> > > > logical device thing is nice maybe for software but I no longer think
> > > > that it represents the hardware correctly. I know this will cause
> > > > problems with registration of devices in the SPI core, but we need to
> > > > pick one representation for these devices that fits in all usecases
> > > > and with the things brought up in the other mail I am having a lot of
> > > > doubts.  
> > > 
> > > This wasn't about use cases as such but the broadcast like facilities the
> > > ADI parts have which to me smell like the main reason you'd put them on
> > > a single bus and use this feature in the first place - you are making
> > > one big DAC from multiple chips.
> > >   
> > > > 
> > > > Only going to reply to this for now, I'll reply to the other thread of
> > > > this conversation later so as not to end up duplicating discussion, but
> > > > I am thinking of things like what if someone puts a mcp3654r and an
> > > > ad5529r on the same chip select? I think that's actually perfectly
> > > > functional on a hardware level, provided the fuses/pins are set up
> > > > correctly (and if it is not, mixing the microchip devices is possible
> > > > and probably mixing future ADI ones will be too).  
> > > 
> > > The broadcast stuff is what breaks this.  Otherwise I fully agree they
> > > should be independent and we should have SPI allow that.
> > >   
> > 
> > Exactly! The idea of having the devices as separate nodes always felts
> > really appealing to me given that's what we have (strictly sepaking) in
> > HW. But as you stated, the big reason to pack multiple devices (for the
> > ADI case) is to basically increase the number of channels and so
> > aggregate the devices together.
> 
> Key detail is not just aggregate devices but have them act as one device
> from an interface point of view (just like SPI chaining).  One message
> affects multiple devices.

Basically what I meant yes. Also from a (channels) buffering point of
view.

- Nuno Sá

> 
> > But taking on David's suggestion,
> > couldn't we somehow reuse that for AD5529R such that the additional
> > DAC's would be child nodes?
> 
> 
> If they were child nodes that just means we have a device specific binding
> and in practice ends up the same as a binding that just makes it one device.
> 
> adc@cs {
> 
> 	adc@spi-device-addr0 {
> 		spi-device-addr = spi-device-addr0;
> 	};
> 	adc@spidevice-addr1 {
> 		spi-device-addr = spi-device-addr1;
> 	};
> }
> 
> Fun question of where we do the xlate for references to channels so
> does a consumer point at the outer node or the inner one?
> 
> I'm not seeing a gain over having an array of spi-device-addr in the
> top level node.
> 
> > 
> > I agree that we should just pick one representation and it feels
> > to me that device@cs,spi-addr (or something like it) is the more
> > flexible approach.
> 
> Agreed though if there is an array it will be first spi-addr.  That
> should be fine.
> 
> > 
> > - Nuno Sá
> > 
> 
