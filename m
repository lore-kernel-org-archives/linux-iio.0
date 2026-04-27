Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BC13B388F;
	Mon, 27 Apr 2026 09:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283183; cv=none; b=QP7PPO3KSP8rCDuozoie0EUTnaCkIMJLjz+f2E2AyMAtiC0GIolRgjWrKf6rNedQ0UcSTLSvz0eBm04+ij5khxjFNlEfMYUEwtJVZ1s8T0kWWiggL7WvKdDFdsgUz7Id0x+578m3uz6SA7iJx6rXKOzT1VbPREwkUA6c2tusQTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283183; c=relaxed/simple;
	bh=NU9EPjl9Gcf4DhW/Cn54ZqRb0KBGvHt3uRAKVUgt3p8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t4ERGNbrmBHMAr5xG1/fdTVR25kBkJtnva8r7sZIaFQnEC6q1MwzbCXZPBnSdIz3WbLmIoEVWq5IibuISbOh0IhflcEpGKVSDgHIlEnBbbAgWULGqnoj+pYohCrQpDSDFlKmbgS9fjzXzcGp9/HkMgARUt4F+aC9h9UQ95Xk0eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7x0NJ46; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7x0NJ46"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E04C19425;
	Mon, 27 Apr 2026 09:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777283182;
	bh=NU9EPjl9Gcf4DhW/Cn54ZqRb0KBGvHt3uRAKVUgt3p8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=m7x0NJ464m3BV1JQ75EwcN5GLDiXJsmt8mWPeF8Yu/pO8/Z/UZ1GId3S0wSHiLWwk
	 /Frr34sLPcyFxy5gHkP8ncRQoxu9e0zCAPIgsJ2ThhqDNI+9b2dgvUe6UrCQB5C/cA
	 YgiNyTY/zI84dj3yZeo0PRFaGKDKKv95aZfVHW80RU8qsp1CxflHOFcTEoEalqZoFo
	 rO1Ur5j9sAdgPuE4gGO/kyEjeHsHOUOeO/I+n2YL/4ICordBE5Bn+hheB7BAf9/5V7
	 JleJoWMXtBaZd1wgTp7kP+1TsbKOuknBvLv8+BR069XGHdB7Qj8muZyySSc1bmWE8k
	 cKBQRzp8u3etw==
Date: Mon, 27 Apr 2026 10:46:08 +0100
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
Message-ID: <20260427104608.7819a134@jic23-huawei>
In-Reply-To: <lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
	<20260426141007.345c76e4@jic23-huawei>
	<lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 26 Apr 2026 21:42:15 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/04/26 02:10PM, Jonathan Cameron wrote:
> > On Fri, 17 Apr 2026 09:17:38 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > > DDS modes, attributes and ABI usage examples.
> > > 
> > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > 
> > Hi Rodrigo,
> > 
> > I think this is getting close to something workable subject to some tweaks
> > to not make the priority thing visible and use rate of change parameters
> > so /Sec rather than steps.  
> 
> I am not sure about this one. Getting the value into units per seconds will
> increase the range of values by a lot, e.g., for the frequency case the step
> size can range from a few Hz up to the entire supported range (hundreds of
> MHz), and if you consider that one would often have the sampling_frequency
> at 250 MHz... an attribute frequency_roc could have an order of 10^17 Hz/s,
> and I am not sure how practical is that, although it can have a physical meaning,
> like a "chirp slope".

That scaling is indeed a bit of a pain though it will go in a 64 bit int
however, seems likely we'll get higher frequency devices one day that will
limb even faster.

Maybe wait and see if anyone else has input on this.	
> 
> > 
> > Given this defines the ABI for a whole class of new devices that are
> > rather complex, one concern is whether whatever we define here is general
> > enough to be useful.  
> > 
> > Do you have any other DDS in your queue to upstream? Maybe it's worth
> > sanity checking the ABI against them to see if it is fit for purpose?  
> 
> Not really, still the only DDS. Other DDS of the same family have a similar
> Digital Ramp Generator with controls over ramp limits, rates and step. 

There are two in staging that have been there a very long time... 
ad9832 and ad9834.  I haven't looked at how they correspond to this.

We should think hard about whether to bring them inline with this
and out of staging, or just delete them.

> 
> ...
> 
> > > +DDS modes
> > > +=========
> > > +
> > > +The AD9910 supports multiple modes of operation that can be configured
> > > +independently or in combination. Such modes and their corresponding IIO channels
> > > +are described in this section. The following tables are extracted from the
> > > +AD9910 datasheet and summarizes the control parameters for each mode and their
> > > +priority when multiple sources are enabled simultaneously:  
> > 
> > Maybe add a bit on what priority means.  Does it mean that only the highest
> > priority one is acted on?  If so why do we need to expose that others are
> > enabled? Just report only the highest priority one as enabled.
> > 
> > I can see the hardware needs to do priority so it knows where to go when
> > a given source is disabled but from a software point of view that
> > can be controlled by us enabling that next item (and the driver does
> > things in the right order to get the appropriate transition)
> > 
> > That may mean that if all modes are disabled, we have to disable any output
> > but seems doable.  
> 
> That is a bit complicated, as you can see, this part has modes that target
> one DDS parameter or multiple (destinations: phase, frequency, amplitude).
> Also, multiple modes can coexist, when they target different parameters/destination.
> At the same time, RAM mode complicates everything because even though it targets
> one specific parameter, once it is enabled influences the base mode for the
> other parameters because single-tone is off. I have ordered the mode channels so
> that higher index have higher priority, so that can be a bit clearer.
> 
> Right now, all the controls are provided, what might be missing is a way
> to query which level of those priorities is currently active, but those levels
> are not the same thing as the controls. If we turn the priority levels into the
> controls themselves it would be a different ABI and it would get a lot messy.
> That is why I am dumping this priority table in this document! =(

I understand (at least some) of the hardware complexity but I don't like
the fact this is effectively exposing it to userspace. + I really don't want
more ABI to indicate whether a mode is actively doing anything or not.
Whilst I agree the code will be more complex, having clarity on what is
enabled at any given time is definitely something we ant to aim for.

Can we work out a transition diagram?  That might make it easier to
tell whether it's possible to map it as single enables at a time and
incorporate weird corners like the RAM one.  Maybe not needed if the
RAM one is the only real oddity and otherwise it's just going up
and down the priority lists.

One complexity I can see with single enables is that they'd need
to be separate for each of frequency, phase and amplitude to reflect
the transitions that can occur.

Also the fun of profiles, where those profile pins are basically picking
symbols - could be used for multi level PSK or FSK for example if wired
up to an external symbol source.  I'd be a bit surprised if those are
always wired up to a host CPU.

*sigh* I'm talking my self around to needing ABI to indicate a channel
is active.  The symbol stuff gets us some of the way there (and would
work for the tones) but doesn't cover the added complexity of RAM etc.
So 'maybe' new ABI for _isactive or something like that?

Perhaps the boundary we put on this is the ABI should be such that
simple choices such as enabling a single tone, or single RAM mode
setting are intuitive. 

Why do we only have one ram channel? I'd kind of expect the firmware
to fill all 8 RAM profiles because of that 'external' profile pins
use case.


> 
> > > +
> > > +.. flat-table:: DDS Frequency Control
> > > +   :header-rows: 1
> > > +
> > > +   * - Priority
> > > +     - Data Source
> > > +     - Conditions
> > > +
> > > +   * - Highest Priority
> > > +     - RAM
> > > +     - RAM enabled and data destination is frequency
> > > +
> > > +   * -
> > > +     - DRG
> > > +     - DRG enabled and data destination is frequency
> > > +
> > > +   * -
> > > +     - Parallel data and FTW (frequency_offset)
> > > +     - Parallel data port enabled and data destination is frequency
> > > +
> > > +   * -
> > > +     - FTW (frequency)
> > > +     - RAM enabled and data destination is not frequency
> > > +
> > > +   * -
> > > +     - FTW (frequency) in single tone channel for the active profile
> > > +     - DRG enabled and data destination is not frequency
> > > +
> > > +   * -
> > > +     - FTW (frequency) in single tone channel for the active profile
> > > +     - Parallel data port enabled and data destination is not frequency
> > > +
> > > +   * - Lowest Priority
> > > +     - FTW (frequency) in single tone channel for the active profile
> > > +     - None  
> >   
> > > +
> > > +Single tone mode
> > > +----------------
> > > +
> > > +Single tone is the baseline operating mode. The ``profile[Y]`` channels
> > > +provides enable, frequency, phase and amplitude control:
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable/disable profile Y. Only one profile can be active at a
> > > +       time. Then enabling a profile disables the current active profile.
> > > +       Disabling an active profile enables the next profile in ascending order,
> > > +       wrapping around from 7 to 0.  
> > 
> > That passing on to the next one seems rather non user friendly.  Can we just
> > disable the whole unit under those conditions instead?  As above that may mean
> > turning of the output entirely.  So to change mode it would always be transition
> > to the one that is enabled.  A disable of a given channel results in no output.  
> 
> Yes, I can go for the software powerdown in that case! and the powerdown attribute
> could be removed?

Yes, I think that works.  If all sources are disabled, then powerdown.
Maybe we keep the powerdown as well though as that's standard DAC ABI.

> 
> >   
> > > +
> > > +   * - ``frequency``
> > > +     - Hz
> > > +     - Output frequency. Range [0, SYSCLK/2). Stored in the profile's frequency
> > > +       tuning word (FTW).
> > > +
> > > +   * - ``phase``
> > > +     - rad
> > > +     - Phase offset. Range [0, 2*pi). Stored in the profile's phase offset word
> > > +       (POW).
> > > +
> > > +   * - ``scale``
> > > +     - fractional
> > > +     - Amplitude scale factor. Range [0, 1]. Stored in the profile's amplitude
> > > +       scale factor (ASF).
> > > +
> > > +Profile switching is allowed while RAM mode is enabled. In that case single tone
> > > +parameters are stored in a shadow register and are not written to hardware until
> > > +RAM mode is disabled.  
> > 
> > This is only visible to userspace because of the priority thing?  If we hide
> > that away to transition from RAM to this mode would just mean enabling this mode.  
> 
> Partially, but the real reason is that single-tone and RAM shares the same profile
> registers. So I have things cached, which allows user to change single-tone stuff
> while RAM is enabled.

Ah. So there is no smooth (e.g. race free) path to transition from RAM mode to
single tone? That is annoying.

> 
> ...
> 
> > > +Digital ramp generator (DRG)
> > > +----------------------------
> > > +
> > > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > > +hardware. It is controlled through three channels: a parent control channel
> > > +(``digital_ramp_generator``) and two child ramp channels
> > > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> > > +sets the destination to frequency.
> > > +
> > > +Control channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable/disable the DRG.
> > > +
> > > +Ramp channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> > > +attribute set but configure ascending and descending ramp parameters
> > > +independently:
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> > > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > > +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up  
> > 
> > transition
> >   
> > > +       only, ramp-down only or bidirectional with dwell at the limits.  
> > 
> > Feels a little unintuitive to use the generic enable for this.
> > We might need a specific control for this one.   
> 
> How about dwell_en, but it might not sound that generic. I used "enable" because:
> - no-dwell high means a ramp-up pattern (only enabling the ramp-up channel)
> - no-dwell low means a ramp-down pattern (only enabling the ramp-down channel)
> - both no-dwell is a continuous ramp that goes up and down. (both enabled)
> The last case is a bit off though, when both are disabled we get the normal mode, which
> is also a ramps up and down, but dwelling in the limits.
>  
> > > +
> > > +   * - ``frequency``
> > > +     - Hz
> > > +     - Frequency ramp limit. Range [0, SYSCLK/2).
> > > +
> > > +   * - ``phase``
> > > +     - rad
> > > +     - Phase ramp limit. Range [0, 2*pi).

Looking at this again, how do we set the DRG mode?  E.g. if it effects
only phase? 

> > > +
> > > +   * - ``scale``
> > > +     - fractional
> > > +     - Amplitude scale ramp limit. Range [0, 1).
> > > +
> > > +   * - ``sampling_frequency``
> > > +     - Hz
> > > +     - Ramp clock rate: SYSCLK / (4 * divider).
> > > +
> > > +   * - ``frequency_step``
> > > +     - Hz
> > > +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).  
> > 
> > So this was the bit I referred to earlier.  Normally we do
> > rate of change measurements for this stuff rather than what happens on
> > each tick (based on how we handle things like ROC events)
> > 
> > So could we make these
> > 	``frequency_roc`` units HZ/Sec
> > etc?  Then from the mix configured would need to work out the optimum
> > tick to deliver it.
> > 
> > I suppose it's possible that someone might want a stepped frequency
> > though which would break this approach?  Does anyone actually do that?
> > If so we'd need to keep the samping_frequency but then control _roc
> > with that in mind.  
> 
> yeah... frequency steps would make sense when the user controls when to
> perform the updates, or when it comes from certain events.

You've lost me here.  How can they do that?  Some external clocking
or event?

> 
> sampling frequency defines the timing and this roc attr would
> also depend on timing... there would be two options:
> * ignore updating ramp step when sampling freq is updated. Here roc
>   would have a different value when readback.
> * cache the "requested" roc and use it update ramp step when sampling
>   freq is updated, so roc remains with the value initially configured. 

If we do end up going the roc route both are valid ABI, but the second is
nicer from useability point of view. 

> 
> >   
> > > +
> > > +   * - ``phase_step``
> > > +     - rad
> > > +     - Per-tick phase increment/decrement. Range [0, 2*pi).
> > > +
> > > +   * - ``scale_step``
> > > +     - fractional
> > > +     - Per-tick amplitude scale increment/decrement. Range [0, 1).
> > > +
> > > +Usage examples
> > > +^^^^^^^^^^^^^^
> > > +
> > > +Configure a frequency sweep from 40 MHz to 60 MHz at a 1 kHz step:
> > > +
> > > +.. code-block:: bash
> > > +
> > > +	# Enable both no-dwell modes for a bidirectional ramp
> > > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_en
> > > +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_en  
> > 
> > Fix indents as mix of tabs and spaces.  As above I think using this enable
> > for no dwell is not going to generalize well.  I think we need new ABI for this
> > though I'm open to anyone suggesting something we can reuse.  
> 
> I suggested dwell_en, and I am not sure what else could be used here.
> Something like hold_en could work and sounds more generic.. not sure. 

likewise :(
 
> 
> > > +
> > > +	# Set ramp limits
> > > +	echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> > > +	echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> > > +
> > > +	# Set ramp step size to 1 kHz
> > > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_step
> > > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_step
> > > +
> > > +	# Set ramp rate at 25 MHz
> > > +	echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> > > +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> > > +
> > > +	# Enable the DRG
> > > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
> > > +
> > > +RAM mode
> > > +--------
> > > +
> > > +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> > > +and played back to modulate frequency, phase, amplitude, or polar (phase +
> > > +amplitude) parameters.
> > > +
> > > +RAM control channel attributes
> > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable/disable RAM playback. Toggling swaps profile registers between
> > > +       single tone and RAM configurations across all 8 profiles.  
> > 
> > So this might be a fly in the ointment of my previous comment about using
> > enable of profile to turn off ram.  I guess disabling RAM drops into the
> > matched number tone profile?  That's a pain but not disastrous. We'd have
> > to only allow transitions by enabling the match number tone profile.
> > 
> > So transitions allowed would be
> > 
> > 	tone_profileX -> ram_profileX
> > 	tone_profileX -> tone_profileY
> > 	ram_profileX -> tone_profileX
> > 	ram_profileX -> ram_profileY
> > 
> > But not
> > 	tone_profileX -> ram_profileY
> > where X!=Y  
> 
> No, there is only one RAM enable bit, once it is on, all single tone
> profiles go away (all profile registers are repurposed for RAM mode
> usage).

I'd missed the repurposing that basically means you never transition from
tone to RAM without going via some intermediate point (maybe power down).

> 
> > > +
> > > +   * - ``frequency``
> > > +     - Hz
> > > +     - Frequency tuning word used as the single tone frequency when
> > > +       RAM destination is not ``frequency``. Range [0, SYSCLK/2).
> > > +
> > > +   * - ``phase``
> > > +     - rad
> > > +     - Phase offset word used as the single tone phase when RAM destination
> > > +       is not ``phase``. Range [0, 2*pi).
> > > +
> > > +   * - ``sampling_frequency``
> > > +     - Hz
> > > +     - RAM playback step rate of the active profile, which controls how fast the
> > > +       address counter advances: SYSCLK / (4 * step_rate).  
> > 
> > Why do we care what the sysclk relationship is? It's ticking in HZ.  
> 
> Can be removed, but just to point out that the configured value will adjust to the
> value where the divider is an integer. Maybe the user should be aware of that.

If you keep it just add something to note that it takes discrete values
according to that formula.  I was reading more into it than that and
getting confused to where step_rate was coming from!

> 
> > > +
> > > +Output shift keying (OSK)  
> > This is a new one on me...   
> > > +-------------------------
> > > +
> > > +OSK controls the output amplitude envelope, allowing the output to be ramped
> > > +on/off rather than switched abruptly.  
> >   
> > > +
> > > +.. flat-table::
> > > +   :header-rows: 1
> > > +
> > > +   * - Attribute
> > > +     - Unit
> > > +     - Description
> > > +
> > > +   * - ``en``
> > > +     - boolean
> > > +     - Enable/disable OSK.
> > > +
> > > +   * - ``scale``
> > > +     - fractional
> > > +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> > > +
> > > +   * - ``sampling_frequency``
> > > +     - Hz
> > > +     - OSK ramp rate: SYSCLK / (4 * divider).
> > > +
> > > +   * - ``pinctrl_en``
> > > +     - boolean
> > > +     - Enable manual external pin control. When enabled, the OSK pin directly
> > > +       gates the output on/off instead of using the automatic ramp.  
> > 
> > I wonder if we should split the various OSK modes into different channels given
> > only some properties apply to each of automatic and manual modes. Also I think
> > automatic mode is meaningless without pinctrl_en (so that can be replaced
> > by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
> > with manual mode or not?  That one seems even more odd.  
> 
> OSK is either in manual or auto:
> * In manual mode the OSK pin enables and disables the output based on its level.
> * In auto, the OSK pin controls the direction the amplitude updates. 
> 
> If we enable RAM mode, and other modes do not target amplitude, the only way to
> manually configure the amplitude in software (i.e. without using an OSK gpio)
> is going manual mode (scale_step == 0), disable this pinctrl_en and then set the
> scale property (ASF register). That is the only reason I added this property.

Ah.  Maybe we hide that away and make the amplitude a property of RAM channel?
It can do this magic under the hood. I don't mind the attributes for OSK changing
if this trick is in use (they won't be active anyway).

> 
> > > +
> > > +   * - ``scale_step``
> > > +     - fractional
> > > +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> > > +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> > > +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.  
> > 
> > Similar thing about rate of change of amplitude fitting better with current ABI
> > than step does.  
> 
> ok... and this one is still missing the correspondent available attr.

Available is a bit tricky when there is an inverse relationship involved in the maths
as what do we put the step as.  Maybe we should add a note on that to the ABI
docs.  [min step max] where step gives the minimum step that due to non linearity
may not be applicable between discrete values that may be taken away from that
minimum granularity base value.  If that occurs the driver will round to the
nearest possible value.

Something like that.

J
> 

