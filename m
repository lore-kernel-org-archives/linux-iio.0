Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03494418D7;
	Wed,  6 May 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078093; cv=none; b=EUkid0vr0xkyIJZ4FLZw1pqbjKnrXkJwTkJUBCzrrhjfk0SiHIOse3lCPPelJtwbV5UCKWelC85DWiWhs82tK3jgA73aoZIi4ehd6OixW4Ry92j1Fe57OVCovcj8/y6Rc+QceufkK6zhA0Xk2PGK381q5XhbaEWWWkebGjKdTzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078093; c=relaxed/simple;
	bh=rWWauLQzlV2wptjyoaQgJpNJJ+5e4n9FrJgSH3PBKM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOZFFZqXDCBptHXfwQC5X07dB1OcfrFMtsLf9d414Sr9SfTEzxgEM+QWCSJkJF+6rKZMc76XaA3c5aHTo1vJl9fT+xMd2jlITPZ3Pqcl5VdYhqCqjbeCzNGUoPVwD7pzn5a2T2ubRDNqLbUjOBVphLvt3HJGLD/dTUZZECtcMlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQoT3f0M; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQoT3f0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D32FC2BCB8;
	Wed,  6 May 2026 14:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078092;
	bh=rWWauLQzlV2wptjyoaQgJpNJJ+5e4n9FrJgSH3PBKM4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lQoT3f0MffEWko7rP2yJrR5fTcTMyGuC1ryQVukmca/OYBQzzkaVUP+wNMlJIue1j
	 GIwXN7+jpv+N77kzEg9jtaXrMkTT6XhHO2/Hu4Yn9s3Kit6BZXicuI1e7Jfq2hclrA
	 iHYLX0nyOp55x157evsGbrLVXbuekhNf701GmgURxSPvhfeRMkTByAtyaipkq2jQzo
	 qnJ/niAuOiQEI3sLlRzrbzvEi9vsUbVTgCNp+AFFHEp/h/lbJCMluv/KOseJsPv9tX
	 5mjqm8ScChWy/CFOOAMKFNQCnSzVYM9m5VjC9PsXe3GTBFVohPbg1hy7Kt7nnKqqaf
	 Q0b323rH+rfVQ==
Date: Wed, 6 May 2026 15:34:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 9/9] docs: iio: add documentation for ad9910
 driver
Message-ID: <20260506153440.0d1811ab@jic23-huawei>
In-Reply-To: <kwx4kgvagwoaljurnkvuvwggrss2qdjwzszpju6mkdxjfi4n4n@yjsv33ewxkzy>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
	<20260426141007.345c76e4@jic23-huawei>
	<lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
	<20260427104608.7819a134@jic23-huawei>
	<dsppqeyqtelrt3arkgxdgkhxvgtqpxkvf6n3rbkz4wk7zgfwqb@cn4rqk7p4g6i>
	<20260505180827.2972124e@jic23-huawei>
	<kwx4kgvagwoaljurnkvuvwggrss2qdjwzszpju6mkdxjfi4n4n@yjsv33ewxkzy>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 May 2026 11:41:00 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/05/05 06:08PM, Jonathan Cameron wrote:
> > On Mon, 27 Apr 2026 15:35:21 +0100
> > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> >   
> > > On 26/04/27 10:46AM, Jonathan Cameron wrote:  
> > > > On Sun, 26 Apr 2026 21:42:15 +0100
> > > > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > > >     
> > > > > On 26/04/26 02:10PM, Jonathan Cameron wrote:    
> > > > > > On Fri, 17 Apr 2026 09:17:38 +0100
> > > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > > >       
> > > > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > > > 
> > > > > > > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > > > > > > DDS modes, attributes and ABI usage examples.
> > > > > > > 
> > > > > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>      
> > > > > > 
> > > > > > Hi Rodrigo,
> > > > > > 
> > > > > > I think this is getting close to something workable subject to some tweaks
> > > > > > to not make the priority thing visible and use rate of change parameters
> > > > > > so /Sec rather than steps.      
> > > > > 
> > > > > I am not sure about this one. Getting the value into units per seconds will
> > > > > increase the range of values by a lot, e.g., for the frequency case the step
> > > > > size can range from a few Hz up to the entire supported range (hundreds of
> > > > > MHz), and if you consider that one would often have the sampling_frequency
> > > > > at 250 MHz... an attribute frequency_roc could have an order of 10^17 Hz/s,
> > > > > and I am not sure how practical is that, although it can have a physical meaning,
> > > > > like a "chirp slope".    
> > > > 
> > > > That scaling is indeed a bit of a pain though it will go in a 64 bit int
> > > > however, seems likely we'll get higher frequency devices one day that will
> > > > limb even faster.
> > > > 
> > > > Maybe wait and see if anyone else has input on this.  
> 
> Maybe we add this _roc ABI for this device and figure out scaling issues on new devices
> later.

That sounds like a way forwards. If we do end up with a more complex ABI long term
we can always add it to this driver if useful - but only once we know what it needs
to look like.

> 
> > > > >     
> > > > > > 
> > > > > > Given this defines the ABI for a whole class of new devices that are
> > > > > > rather complex, one concern is whether whatever we define here is general
> > > > > > enough to be useful.  
> > > > > > 
> > > > > > Do you have any other DDS in your queue to upstream? Maybe it's worth
> > > > > > sanity checking the ABI against them to see if it is fit for purpose?      
> > > > > 
> > > > > Not really, still the only DDS. Other DDS of the same family have a similar
> > > > > Digital Ramp Generator with controls over ramp limits, rates and step.     
> > > > 
> > > > There are two in staging that have been there a very long time... 
> > > > ad9832 and ad9834.  I haven't looked at how they correspond to this.    
> > > 
> > > It seems they can benefit of this child channel concept, as they define
> > > multiple frequency and phase configuration for the same physical DAC.
> > > I see the following in the most complicated one:
> > > - out_altvoltage0_frequency0
> > > - out_altvoltage0_frequency1
> > > - out_altvoltage0_frequency_scale
> > > - out_altvoltage0_phase0
> > > - out_altvoltage0_phase1
> > > - out__altvoltage0_phase_scale
> > > - out_altvoltage0_pincontrol_en
> > > - out_altvoltage0_frequencysymbol
> > > - out_altvoltage0_phasesymbol
> > > - out_altvoltage0_out_enable
> > > - out_altvoltage0_out1_enable
> > > - out_altvoltage0_out0_wavetype
> > > - out_altvoltage0_out1_wavetype
> > > - out_altvoltage0_out0_wavetype_available
> > > - out_altvoltage0_out1_wavetype_available
> > > 
> > > less complicated, no RAM, no DRG nor parallel port. In terms of common stuff I can see
> > > frequency_scale and pinctrl_en.    
> > 
> > My main concern here is IIRC these are very much PSK / FSK devices with expectation
> > of symbol being externally controlled. (maybe I remembered that wrong ;)
> > So the symbol relationship would need to map to child channels in some fashion.  
> 
> With multiple channels, I'd say that is already figured with the standard "enable" ABI,
> As the "symbol" to select is a choice of one of the channels to enable. Like it is
> being done here for the single tone profiles. Being externally controlled is a user
> problem, being its responsability to make sure that expectations on the values are
> aligned during some specific actions. For instance, this very driver, expects the selected profile
> to be trully selected by the profile pins so that RAM loading works. Also, there is another
> weird case, where the profile needs to be selected to make sure a read of the profile register
> works (which is another reason to use cached reads). Apart from those cases, I suppose
> profile pin control can be "detached" from the driver. 

If you are doing FSK or PSK they are almost always detached from the driver as driven by
some high speed external source.  This chip is probably massive overkill for anyone
wanting to do something so simple. So maybe it's not a thing.
If we need to retrofit it I can see assigning a new _symbol type label to
channels as a way to make it obvious how they are related.  Can solve
that when we need to (if we ever do!)


> > > > *sigh* I'm talking my self around to needing ABI to indicate a channel
> > > > is active.  The symbol stuff gets us some of the way there (and would
> > > > work for the tones) but doesn't cover the added complexity of RAM etc.
> > > > So 'maybe' new ABI for _isactive or something like that?    
> > > 
> > > active_params or active_targets? listing out DDS parameters that is currently
> > > active for that mode/channel? like printing "frequency phase amplitude", so
> > > that would mean the mode is driving all of them. That would be a read-only
> > > status.   
> > 
> > Would have to be simple per channel sysfs attribute that would say
> > is this particular channel actually contributing to the current output.
> > Where it can contribute in multiple ways we'll need separate attributes.
> > 
> > Anything else is going to break the rules on one thing per each sysfs
> > attribute.
> > out_altvoltageXXX_phase_active
> > out_altvoltageXXX_freq_active
> > or something like that.  
> 
> Yes, that could be done. This would be just informative, and I suppose that
> any userspace software that knows how to control the part would not even
> look at those. Probably it would just be used while debugging.

Agreed it is mostly about debugging but I think this thing is complex enough
that it's useful info.  I guess we could put it in debugfs for now.

>  
> > >   
> > > > Perhaps the boundary we put on this is the ABI should be such that
> > > > simple choices such as enabling a single tone, or single RAM mode
> > > > setting are intuitive. 
> > > > 
> > > > Why do we only have one ram channel? I'd kind of expect the firmware
> > > > to fill all 8 RAM profiles because of that 'external' profile pins
> > > > use case.    
> > > 
> > > Most of the RAM configuration is now comming from the firmware, so there
> > > is no much info to display/configure in multiple channels. The per-profile
> > > configs require the weird ABI like operating modes and address start/end.
> > > By removing those, I have mostly "global" stuff.  
> > If folk are doing profile control from external pins I'd kind of expect to
> > see some description of what they are controlling even if it's read only.
> > 
> > Maybe we don't do this now but we should make sure there is space in the ABI
> > by thinking what it might look like.  
> 
> Right now, I am not seeing anything generic in RAM control appart from a
> "sampling_frequency". A lot of it seems device-specific:
> 
> - Destination (freq/phase/amplitude/polar)
> - Internal profile control config (sequenced modes I had before)
> - Per-profile config:
> 	- Start address
> 	- End address
> 	- Address step rate (sampling freq)
> 	- RAM mode:
> 		- direct switch
> 		- ramp-up
> 		- bidirectional
> 		- bidirectional continuous
> 		- ramp-up continuous
> 	- No-dwell high bit (specific to ramp-up mode)
> 	- Zero-crossing bit (specific to direct switch mode)

It's the external use of the profile pins that makes me wonder if we
will need this at somepoint. For now it may just be a case of making
sure there is room in the channel numbering etc which I guess there
already is.

> 
> ...
> 
> > > > > > > +Digital ramp generator (DRG)
> > > > > > > +----------------------------
> > > > > > > +
> > > > > > > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > > > > > > +hardware. It is controlled through three channels: a parent control channel
> > > > > > > +(``digital_ramp_generator``) and two child ramp channels
> > > > > > > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > > > > > > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> > > > > > > +sets the destination to frequency.
> > > > > > > +
> > > > > > > +Control channel attributes
> > > > > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > > +
> > > > > > > +.. flat-table::
> > > > > > > +   :header-rows: 1
> > > > > > > +
> > > > > > > +   * - Attribute
> > > > > > > +     - Unit
> > > > > > > +     - Description
> > > > > > > +
> > > > > > > +   * - ``en``
> > > > > > > +     - boolean
> > > > > > > +     - Enable/disable the DRG.
> > > > > > > +
> > > > > > > +Ramp channel attributes
> > > > > > > +^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > > +
> > > > > > > +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> > > > > > > +attribute set but configure ascending and descending ramp parameters
> > > > > > > +independently:
> > > > > > > +
> > > > > > > +.. flat-table::
> > > > > > > +   :header-rows: 1
> > > > > > > +
> > > > > > > +   * - Attribute
> > > > > > > +     - Unit
> > > > > > > +     - Description
> > > > > > > +
> > > > > > > +   * - ``en``
> > > > > > > +     - boolean
> > > > > > > +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> > > > > > > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > > > > > > +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up      
> > > > > > 
> > > > > > transition
> > > > > >       
> > > > > > > +       only, ramp-down only or bidirectional with dwell at the limits.      
> > > > > > 
> > > > > > Feels a little unintuitive to use the generic enable for this.
> > > > > > We might need a specific control for this one.       
> > > > > 
> > > > > How about dwell_en, but it might not sound that generic. I used "enable" because:
> > > > > - no-dwell high means a ramp-up pattern (only enabling the ramp-up channel)
> > > > > - no-dwell low means a ramp-down pattern (only enabling the ramp-down channel)
> > > > > - both no-dwell is a continuous ramp that goes up and down. (both enabled)
> > > > > The last case is a bit off though, when both are disabled we get the normal mode, which
> > > > > is also a ramps up and down, but dwelling in the limits.
> > > > >      
> > > > > > > +
> > > > > > > +   * - ``frequency``
> > > > > > > +     - Hz
> > > > > > > +     - Frequency ramp limit. Range [0, SYSCLK/2).
> > > > > > > +
> > > > > > > +   * - ``phase``
> > > > > > > +     - rad
> > > > > > > +     - Phase ramp limit. Range [0, 2*pi).    
> > > > 
> > > > Looking at this again, how do we set the DRG mode?  E.g. if it effects
> > > > only phase?     
> > > 
> > > You mean the destination? I removed the destination ABI. so now destination is
> > > set when we write to either frequency, phase or scale properties.
> > > * writing to frequency or frequency_step sets the destination to frequency
> > > * writing to phase or phase_step sets the destination to phase
> > > * writing to scale or scale_step sets the destination to amplitude  
> > 
> > So it's last write that sets it.  We definitely need a way to know which
> > one is active if we get multiple writes.  What do the others return if they
> > were set but something else has been set since?  
> 
> All those values represent the same set of registers with different scaling for
> frequency, phase or scale units. I can get the other values to return -EBUSY
> when reading a destination attribute that was not set.

Given the overlap is non obvious I think that making it clear the channel is not
in use makes sense.  Mind you it's a bit of an odd interface to return -EBUSY on
reads but allow writes.  I'd like others input on this one.

> 
> > > 
> > > The DRG mode (dwell mode) is now controlled with the enable bits in the ramp
> > > up/down channels 
> > >   
> > > > > > > +
> > > > > > > +   * - ``scale``
> > > > > > > +     - fractional
> > > > > > > +     - Amplitude scale ramp limit. Range [0, 1).
> > > > > > > +
> > > > > > > +   * - ``sampling_frequency``
> > > > > > > +     - Hz
> > > > > > > +     - Ramp clock rate: SYSCLK / (4 * divider).
> > > > > > > +
> > > > > > > +   * - ``frequency_step``
> > > > > > > +     - Hz
> > > > > > > +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).      
> > > > > > 
> > > > > > So this was the bit I referred to earlier.  Normally we do
> > > > > > rate of change measurements for this stuff rather than what happens on
> > > > > > each tick (based on how we handle things like ROC events)
> > > > > > 
> > > > > > So could we make these
> > > > > > 	``frequency_roc`` units HZ/Sec
> > > > > > etc?  Then from the mix configured would need to work out the optimum
> > > > > > tick to deliver it.
> > > > > > 
> > > > > > I suppose it's possible that someone might want a stepped frequency
> > > > > > though which would break this approach?  Does anyone actually do that?
> > > > > > If so we'd need to keep the samping_frequency but then control _roc
> > > > > > with that in mind.      
> > > > > 
> > > > > yeah... frequency steps would make sense when the user controls when to
> > > > > perform the updates, or when it comes from certain events.    
> > > > 
> > > > You've lost me here.  How can they do that?  Some external clocking
> > > > or event?    
> > > 
> > > That would depend on what the user does. This part has this DRHOLD pin
> > > which can freeze the ramp. If the user sets this HIGH and creates pulses
> > > it is able to control the stepping of the RAMP manually. But I assume
> > > that no one would do that... such application is unknown to me.  
> > 
> > They'd have to sync that with the clock driving the ramp. I guess that's
> > possible - but nasty.  I vote we pretend this usecase doesn't exist for now ;)
> >   
> > > > > > > +
> > > > > > > +Output shift keying (OSK)      
> > > > > > This is a new one on me...       
> > > > > > > +-------------------------
> > > > > > > +
> > > > > > > +OSK controls the output amplitude envelope, allowing the output to be ramped
> > > > > > > +on/off rather than switched abruptly.      
> > > > > >       
> > > > > > > +
> > > > > > > +.. flat-table::
> > > > > > > +   :header-rows: 1
> > > > > > > +
> > > > > > > +   * - Attribute
> > > > > > > +     - Unit
> > > > > > > +     - Description
> > > > > > > +
> > > > > > > +   * - ``en``
> > > > > > > +     - boolean
> > > > > > > +     - Enable/disable OSK.
> > > > > > > +
> > > > > > > +   * - ``scale``
> > > > > > > +     - fractional
> > > > > > > +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> > > > > > > +
> > > > > > > +   * - ``sampling_frequency``
> > > > > > > +     - Hz
> > > > > > > +     - OSK ramp rate: SYSCLK / (4 * divider).
> > > > > > > +
> > > > > > > +   * - ``pinctrl_en``
> > > > > > > +     - boolean
> > > > > > > +     - Enable manual external pin control. When enabled, the OSK pin directly
> > > > > > > +       gates the output on/off instead of using the automatic ramp.      
> > > > > > 
> > > > > > I wonder if we should split the various OSK modes into different channels given
> > > > > > only some properties apply to each of automatic and manual modes. Also I think
> > > > > > automatic mode is meaningless without pinctrl_en (so that can be replaced
> > > > > > by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
> > > > > > with manual mode or not?  That one seems even more odd.      
> > > > > 
> > > > > OSK is either in manual or auto:
> > > > > * In manual mode the OSK pin enables and disables the output based on its level.
> > > > > * In auto, the OSK pin controls the direction the amplitude updates. 
> > > > > 
> > > > > If we enable RAM mode, and other modes do not target amplitude, the only way to
> > > > > manually configure the amplitude in software (i.e. without using an OSK gpio)
> > > > > is going manual mode (scale_step == 0), disable this pinctrl_en and then set the
> > > > > scale property (ASF register). That is the only reason I added this property.    
> > > > 
> > > > Ah.  Maybe we hide that away and make the amplitude a property of RAM channel?    
> > > 
> > > And what if a user is in fact willing to use the OSK pin?  
> > 
> > Sigh. I don't have a good answer, but I don't like the weird 'special' nature
> > of this attribute.  I guess sometimes there isn't a good answer to be found.
> > 
> > OSK + RAM is odd enough that I'm not that bothered if we have to go weird
> > here.  
> 
> I will remove this then. I suppose that adding another possible value for
> scale_roc allows us to go around this, i.e., if scale_roc is such that the
> amplitude step is a value equal or greater than the amplitude itself (or even the
> max amplitude value) I could assume that this would be the manual mode with pinctrl
> enable as it would be like an automatic mode with no ramp, but an immediate on-off
> transition. Then scale_roc == 0 means manual mode with pinctrl disabled.
> Will try to develop on this....

I'll reserve judgement on this.  Might work out but I'm never that keen on values
that aren't intuitive such as scaling anything by 0.

> 
> > >   
> > > > It can do this magic under the hood. I don't mind the attributes for OSK changing
> > > > if this trick is in use (they won't be active anyway).    
> > > 
> > > OSK has the highest priority of all, but it only acts on the amplitude.
> > >   
> > > > > > > +
> > > > > > > +   * - ``scale_step``
> > > > > > > +     - fractional
> > > > > > > +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> > > > > > > +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> > > > > > > +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.      
> > > > > > 
> > > > > > Similar thing about rate of change of amplitude fitting better with current ABI
> > > > > > than step does.      
> > > > > 
> > > > > ok... and this one is still missing the correspondent available attr.    
> > > > 
> > > > Available is a bit tricky when there is an inverse relationship involved in the maths
> > > > as what do we put the step as.  Maybe we should add a note on that to the ABI
> > > > docs.  [min step max] where step gives the minimum step that due to non linearity
> > > > may not be applicable between discrete values that may be taken away from that
> > > > minimum granularity base value.  If that occurs the driver will round to the
> > > > nearest possible value.    
> 

