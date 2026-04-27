Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BD82DF717
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300534; cv=none; b=NsK1V5wZMFFpZK4+A5wxRZx3cxNNnHaKQeqU4VvSATMiggdsNUcNFRNMBrmaH/FmHjxh96dITrQVfhZU6uN/j3xDSsLBEbB1nWHkWj2OFoCR9gh6CW6hhh5oz/FmwGT4dIlaJgnoFPwwt/Q1LtzdZuUGd++9aFUSxiBFgqXcxOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300534; c=relaxed/simple;
	bh=GC9y6ZeFpNxiLJpdJRpklB05yWPNR5jf0Po0PTihRJA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SS03pKRmnvErOjngPX1hCfo3P4KRcG6SoyGmj1D7Zku/PdUYkheQdN42ZSfjHrD60TFwoCB+9yL1unKx7vMKnw/XOQ1o3DhrmMC62VpIdbrjMiJwEfi7it87fdQTA3v1rvTcNNk13OwVe7omSdVuBfIElMNErJ6aXn5YOYUVK98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv96X9wZ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv96X9wZ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso85366865e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 07:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777300529; x=1777905329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hRgOVjzY0WPKeRu1tjw/v8enwVsEo7JfCfjcDRuFA2A=;
        b=Yv96X9wZWMYBPaIrrShal7/mxWrMrqY6+fNRYKvs2gEA0iijHZ0g7KIZuixvhfkCIy
         jthunk0cwkF/cqRReaXSaVI2892llD9qE/xgyFaS6xY15ouhuV4HAw7FuUeXnqFwU4qV
         KQSSPxfuT11b4nypo1AWsI55phXcP1D9N02CXhmsBG0EVA1gUoxQBb3wewfYFx54DsSA
         JRTjdT/drEi9cPNs6ioVy0FqMDtgd87CRZzCuIloZS3RzSAs3HErt00SrvHUQSG5fiVr
         b4KCqxyNNXu7ZN0WP2suXTlMXMLg6fa6Ntj/E0i02336Ou/Exw1ITiQ6YEJ+0394+w1w
         2AXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777300529; x=1777905329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hRgOVjzY0WPKeRu1tjw/v8enwVsEo7JfCfjcDRuFA2A=;
        b=UzOAWDsTLmPgsLqDVX9bmzH3kZaO1FUlykKBaOalUjfMq1C9E09L1IO8696PHSpx7P
         u26QOXxqH6Pjd8SPWeJHq++MlZJZrJPhKxdZF5+VaTCvT3Fru70RFvdN2gcGyMt/3cS9
         mAd7D/nXClDGEzKNNZYAxib4XNjgZg1T323ndLnrRk//TbbzdzbksruuuMH+sBVpcXmB
         gX6/cht61ro/ZVcds+thDblJlP8XzSfTeDhlDi0sbiBZ1HrOShyCQm5vz618xzIuSpWe
         eqDHZr0TbyaUo9Q8dUHN3g8oKtUsmX1BmPNNIx+Ht1gJ7thJn1icDUpP8+fMaAf/TSps
         4M9g==
X-Forwarded-Encrypted: i=1; AFNElJ9xPOYyNvhDgDUWGjyqQGBgN214aLGJd7NqD6jk2QYDEW326NVF2VbHEyO0QtrKXJ7WThkqkjpappM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhzFOnR2dUm3O62Xzw46FERypZ5sPF+AfDcddXngDnmLTXiUZ1
	X7R0ylUUUuQ/38DjxS1W0BD/AlrZu7UMbpq6bg/436c7OgNItKecdD9J
X-Gm-Gg: AeBDiettRJA36JDw/muklQ2Gytpgy2hsUpw5RweSZlPX51XhjGLrte0nysPsE5lgA9s
	aTUD5UIwsgUCiz0p18dGrK1AMAlv0n4YZcapmnlkGaPGnYlQedQf1OPOWpNodoNEW50xWoV3I1u
	MCKl/pzSUhxg8rlMEWqMcu/dd+7l8fwvY2yBzi39oUzQ3xywipKzWZ6aC6sx1xCg8/Yq3HP0YEG
	KYzt+4aCT4JoxgI0Y+rDCzXlmTgcH2UHQMXg+9gMLYKgtV3Pt+napSWvV1myqEos+4qZfRLuJwS
	QHYkZKBmqBavGpeIzPjMsVZNeR86hC2JyrbPO18nlelLJUjIiVfB8PZHrNzLsx7ZnvzrUweRVgt
	GwAcwza7ONMyUJe5TnIa9SnLiAdCEgWFnLJMBxgyoQOSOmO6sKyWklQdDCjnc4Vv+Ck177pOzpf
	vvtx4lKtKPBw+jJ9aRhIozwTS+Z98uuL9f1L4MnvhH993+qaUC4qp3ijCaSHWa7lY7EU6y+P3E7
	IcJ1iRTnuv9nodjwX97RAHY4IpNZZown/Oj5wppEIAyWt+UcTklPvmKFrHI4Q==
X-Received: by 2002:a05:600c:a088:b0:48a:75b9:5e07 with SMTP id 5b1f17b1804b1-48a75b95e3dmr19443905e9.11.1777300528740;
        Mon, 27 Apr 2026 07:35:28 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a557412eesm215414805e9.9.2026.04.27.07.35.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:35:27 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 27 Apr 2026 15:35:21 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>, rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 9/9] docs: iio: add documentation for ad9910 driver
Message-ID: <dsppqeyqtelrt3arkgxdgkhxvgtqpxkvf6n3rbkz4wk7zgfwqb@cn4rqk7p4g6i>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
 <20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
 <20260426141007.345c76e4@jic23-huawei>
 <lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
 <20260427104608.7819a134@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427104608.7819a134@jic23-huawei>

On 26/04/27 10:46AM, Jonathan Cameron wrote:
> On Sun, 26 Apr 2026 21:42:15 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/04/26 02:10PM, Jonathan Cameron wrote:
> > > On Fri, 17 Apr 2026 09:17:38 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > >   
> > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > 
> > > > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > > > DDS modes, attributes and ABI usage examples.
> > > > 
> > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>  
> > > 
> > > Hi Rodrigo,
> > > 
> > > I think this is getting close to something workable subject to some tweaks
> > > to not make the priority thing visible and use rate of change parameters
> > > so /Sec rather than steps.  
> > 
> > I am not sure about this one. Getting the value into units per seconds will
> > increase the range of values by a lot, e.g., for the frequency case the step
> > size can range from a few Hz up to the entire supported range (hundreds of
> > MHz), and if you consider that one would often have the sampling_frequency
> > at 250 MHz... an attribute frequency_roc could have an order of 10^17 Hz/s,
> > and I am not sure how practical is that, although it can have a physical meaning,
> > like a "chirp slope".
> 
> That scaling is indeed a bit of a pain though it will go in a 64 bit int
> however, seems likely we'll get higher frequency devices one day that will
> limb even faster.
> 
> Maybe wait and see if anyone else has input on this.	
> > 
> > > 
> > > Given this defines the ABI for a whole class of new devices that are
> > > rather complex, one concern is whether whatever we define here is general
> > > enough to be useful.  
> > > 
> > > Do you have any other DDS in your queue to upstream? Maybe it's worth
> > > sanity checking the ABI against them to see if it is fit for purpose?  
> > 
> > Not really, still the only DDS. Other DDS of the same family have a similar
> > Digital Ramp Generator with controls over ramp limits, rates and step. 
> 
> There are two in staging that have been there a very long time... 
> ad9832 and ad9834.  I haven't looked at how they correspond to this.

It seems they can benefit of this child channel concept, as they define
multiple frequency and phase configuration for the same physical DAC.
I see the following in the most complicated one:
- out_altvoltage0_frequency0
- out_altvoltage0_frequency1
- out_altvoltage0_frequency_scale
- out_altvoltage0_phase0
- out_altvoltage0_phase1
- out__altvoltage0_phase_scale
- out_altvoltage0_pincontrol_en
- out_altvoltage0_frequencysymbol
- out_altvoltage0_phasesymbol
- out_altvoltage0_out_enable
- out_altvoltage0_out1_enable
- out_altvoltage0_out0_wavetype
- out_altvoltage0_out1_wavetype
- out_altvoltage0_out0_wavetype_available
- out_altvoltage0_out1_wavetype_available

less complicated, no RAM, no DRG nor parallel port. In terms of common stuff I can see
frequency_scale and pinctrl_en.  

> We should think hard about whether to bring them inline with this
> and out of staging, or just delete them.
> 
> > 
> > ...
> > 
> > > > +DDS modes
> > > > +=========
> > > > +
> > > > +The AD9910 supports multiple modes of operation that can be configured
> > > > +independently or in combination. Such modes and their corresponding IIO channels
> > > > +are described in this section. The following tables are extracted from the
> > > > +AD9910 datasheet and summarizes the control parameters for each mode and their
> > > > +priority when multiple sources are enabled simultaneously:  
> > > 
> > > Maybe add a bit on what priority means.  Does it mean that only the highest
> > > priority one is acted on?  If so why do we need to expose that others are
> > > enabled? Just report only the highest priority one as enabled.
> > > 
> > > I can see the hardware needs to do priority so it knows where to go when
> > > a given source is disabled but from a software point of view that
> > > can be controlled by us enabling that next item (and the driver does
> > > things in the right order to get the appropriate transition)
> > > 
> > > That may mean that if all modes are disabled, we have to disable any output
> > > but seems doable.  
> > 
> > That is a bit complicated, as you can see, this part has modes that target
> > one DDS parameter or multiple (destinations: phase, frequency, amplitude).
> > Also, multiple modes can coexist, when they target different parameters/destination.
> > At the same time, RAM mode complicates everything because even though it targets
> > one specific parameter, once it is enabled influences the base mode for the
> > other parameters because single-tone is off. I have ordered the mode channels so
> > that higher index have higher priority, so that can be a bit clearer.
> > 
> > Right now, all the controls are provided, what might be missing is a way
> > to query which level of those priorities is currently active, but those levels
> > are not the same thing as the controls. If we turn the priority levels into the
> > controls themselves it would be a different ABI and it would get a lot messy.
> > That is why I am dumping this priority table in this document! =(
> 
> I understand (at least some) of the hardware complexity but I don't like
> the fact this is effectively exposing it to userspace. + I really don't want
> more ABI to indicate whether a mode is actively doing anything or not.
> Whilst I agree the code will be more complex, having clarity on what is
> enabled at any given time is definitely something we ant to aim for.

This part seems special, so I would not bother with the fact that userspace
needs to figure some things out.

Since there is this priority, there is a difference on enable vs active,
and things are different for each DDS parameter. Take the single tone example
when it is enabled, should that mean that it is active on frequency, phase
or amplitude? that granularity could be exposed like that if we create dedicated
channels for each parameter on every mode possible, which turns the ABI into
a greater mess.

> Can we work out a transition diagram?  That might make it easier to
> tell whether it's possible to map it as single enables at a time and
> incorporate weird corners like the RAM one.  Maybe not needed if the
> RAM one is the only real oddity and otherwise it's just going up
> and down the priority lists.

I still think it is not that simple, an enable is just a control for
a specific mode-destination pair.
 
> One complexity I can see with single enables is that they'd need
> to be separate for each of frequency, phase and amplitude to reflect
> the transitions that can occur.

As mentioned above, that would be messy to interface with...
 
> Also the fun of profiles, where those profile pins are basically picking
> symbols - could be used for multi level PSK or FSK for example if wired
> up to an external symbol source.  I'd be a bit surprised if those are
> always wired up to a host CPU.

Yes, some users may want to control the profile pins through an FPGA.

> *sigh* I'm talking my self around to needing ABI to indicate a channel
> is active.  The symbol stuff gets us some of the way there (and would
> work for the tones) but doesn't cover the added complexity of RAM etc.
> So 'maybe' new ABI for _isactive or something like that?

active_params or active_targets? listing out DDS parameters that is currently
active for that mode/channel? like printing "frequency phase amplitude", so
that would mean the mode is driving all of them. That would be a read-only
status. 

> Perhaps the boundary we put on this is the ABI should be such that
> simple choices such as enabling a single tone, or single RAM mode
> setting are intuitive. 
> 
> Why do we only have one ram channel? I'd kind of expect the firmware
> to fill all 8 RAM profiles because of that 'external' profile pins
> use case.

Most of the RAM configuration is now comming from the firmware, so there
is no much info to display/configure in multiple channels. The per-profile
configs require the weird ABI like operating modes and address start/end.
By removing those, I have mostly "global" stuff.

> > > > +
> > > > +.. flat-table:: DDS Frequency Control
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Priority
> > > > +     - Data Source
> > > > +     - Conditions
> > > > +
> > > > +   * - Highest Priority
> > > > +     - RAM
> > > > +     - RAM enabled and data destination is frequency
> > > > +
> > > > +   * -
> > > > +     - DRG
> > > > +     - DRG enabled and data destination is frequency
> > > > +
> > > > +   * -
> > > > +     - Parallel data and FTW (frequency_offset)
> > > > +     - Parallel data port enabled and data destination is frequency
> > > > +
> > > > +   * -
> > > > +     - FTW (frequency)
> > > > +     - RAM enabled and data destination is not frequency
> > > > +
> > > > +   * -
> > > > +     - FTW (frequency) in single tone channel for the active profile
> > > > +     - DRG enabled and data destination is not frequency
> > > > +
> > > > +   * -
> > > > +     - FTW (frequency) in single tone channel for the active profile
> > > > +     - Parallel data port enabled and data destination is not frequency
> > > > +
> > > > +   * - Lowest Priority
> > > > +     - FTW (frequency) in single tone channel for the active profile
> > > > +     - None  
> > >   
> > > > +
> > > > +Single tone mode
> > > > +----------------
> > > > +
> > > > +Single tone is the baseline operating mode. The ``profile[Y]`` channels
> > > > +provides enable, frequency, phase and amplitude control:
> > > > +
> > > > +.. flat-table::
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Unit
> > > > +     - Description
> > > > +
> > > > +   * - ``en``
> > > > +     - boolean
> > > > +     - Enable/disable profile Y. Only one profile can be active at a
> > > > +       time. Then enabling a profile disables the current active profile.
> > > > +       Disabling an active profile enables the next profile in ascending order,
> > > > +       wrapping around from 7 to 0.  
> > > 
> > > That passing on to the next one seems rather non user friendly.  Can we just
> > > disable the whole unit under those conditions instead?  As above that may mean
> > > turning of the output entirely.  So to change mode it would always be transition
> > > to the one that is enabled.  A disable of a given channel results in no output.  
> > 
> > Yes, I can go for the software powerdown in that case! and the powerdown attribute
> > could be removed?
> 
> Yes, I think that works.  If all sources are disabled, then powerdown.
> Maybe we keep the powerdown as well though as that's standard DAC ABI.

and what would happen when we power up and none of the profiles are enabled?

> > 
> > >   
> > > > +
> > > > +   * - ``frequency``
> > > > +     - Hz
> > > > +     - Output frequency. Range [0, SYSCLK/2). Stored in the profile's frequency
> > > > +       tuning word (FTW).
> > > > +
> > > > +   * - ``phase``
> > > > +     - rad
> > > > +     - Phase offset. Range [0, 2*pi). Stored in the profile's phase offset word
> > > > +       (POW).
> > > > +
> > > > +   * - ``scale``
> > > > +     - fractional
> > > > +     - Amplitude scale factor. Range [0, 1]. Stored in the profile's amplitude
> > > > +       scale factor (ASF).
> > > > +
> > > > +Profile switching is allowed while RAM mode is enabled. In that case single tone
> > > > +parameters are stored in a shadow register and are not written to hardware until
> > > > +RAM mode is disabled.  
> > > 
> > > This is only visible to userspace because of the priority thing?  If we hide
> > > that away to transition from RAM to this mode would just mean enabling this mode.  
> > 
> > Partially, but the real reason is that single-tone and RAM shares the same profile
> > registers. So I have things cached, which allows user to change single-tone stuff
> > while RAM is enabled.
> 
> Ah. So there is no smooth (e.g. race free) path to transition from RAM mode to
> single tone? That is annoying.

Indeed. To that, we add registers with different sizes and we have a bad digital design.

> > ...
> > 
> > > > +Digital ramp generator (DRG)
> > > > +----------------------------
> > > > +
> > > > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > > > +hardware. It is controlled through three channels: a parent control channel
> > > > +(``digital_ramp_generator``) and two child ramp channels
> > > > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > > > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> > > > +sets the destination to frequency.
> > > > +
> > > > +Control channel attributes
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > +.. flat-table::
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Unit
> > > > +     - Description
> > > > +
> > > > +   * - ``en``
> > > > +     - boolean
> > > > +     - Enable/disable the DRG.
> > > > +
> > > > +Ramp channel attributes
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> > > > +attribute set but configure ascending and descending ramp parameters
> > > > +independently:
> > > > +
> > > > +.. flat-table::
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Unit
> > > > +     - Description
> > > > +
> > > > +   * - ``en``
> > > > +     - boolean
> > > > +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> > > > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > > > +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up  
> > > 
> > > transition
> > >   
> > > > +       only, ramp-down only or bidirectional with dwell at the limits.  
> > > 
> > > Feels a little unintuitive to use the generic enable for this.
> > > We might need a specific control for this one.   
> > 
> > How about dwell_en, but it might not sound that generic. I used "enable" because:
> > - no-dwell high means a ramp-up pattern (only enabling the ramp-up channel)
> > - no-dwell low means a ramp-down pattern (only enabling the ramp-down channel)
> > - both no-dwell is a continuous ramp that goes up and down. (both enabled)
> > The last case is a bit off though, when both are disabled we get the normal mode, which
> > is also a ramps up and down, but dwelling in the limits.
> >  
> > > > +
> > > > +   * - ``frequency``
> > > > +     - Hz
> > > > +     - Frequency ramp limit. Range [0, SYSCLK/2).
> > > > +
> > > > +   * - ``phase``
> > > > +     - rad
> > > > +     - Phase ramp limit. Range [0, 2*pi).
> 
> Looking at this again, how do we set the DRG mode?  E.g. if it effects
> only phase? 

You mean the destination? I removed the destination ABI. so now destination is
set when we write to either frequency, phase or scale properties.
* writing to frequency or frequency_step sets the destination to frequency
* writing to phase or phase_step sets the destination to phase
* writing to scale or scale_step sets the destination to amplitude

The DRG mode (dwell mode) is now controlled with the enable bits in the ramp
up/down channels 

> > > > +
> > > > +   * - ``scale``
> > > > +     - fractional
> > > > +     - Amplitude scale ramp limit. Range [0, 1).
> > > > +
> > > > +   * - ``sampling_frequency``
> > > > +     - Hz
> > > > +     - Ramp clock rate: SYSCLK / (4 * divider).
> > > > +
> > > > +   * - ``frequency_step``
> > > > +     - Hz
> > > > +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).  
> > > 
> > > So this was the bit I referred to earlier.  Normally we do
> > > rate of change measurements for this stuff rather than what happens on
> > > each tick (based on how we handle things like ROC events)
> > > 
> > > So could we make these
> > > 	``frequency_roc`` units HZ/Sec
> > > etc?  Then from the mix configured would need to work out the optimum
> > > tick to deliver it.
> > > 
> > > I suppose it's possible that someone might want a stepped frequency
> > > though which would break this approach?  Does anyone actually do that?
> > > If so we'd need to keep the samping_frequency but then control _roc
> > > with that in mind.  
> > 
> > yeah... frequency steps would make sense when the user controls when to
> > perform the updates, or when it comes from certain events.
> 
> You've lost me here.  How can they do that?  Some external clocking
> or event?

That would depend on what the user does. This part has this DRHOLD pin
which can freeze the ramp. If the user sets this HIGH and creates pulses
it is able to control the stepping of the RAMP manually. But I assume
that no one would do that... such application is unknown to me.

> > sampling frequency defines the timing and this roc attr would
> > also depend on timing... there would be two options:
> > * ignore updating ramp step when sampling freq is updated. Here roc
> >   would have a different value when readback.
> > * cache the "requested" roc and use it update ramp step when sampling
> >   freq is updated, so roc remains with the value initially configured. 
> 
> If we do end up going the roc route both are valid ABI, but the second is
> nicer from useability point of view. 
> 
> > 
> > >   
> > > > +
> > > > +   * - ``phase_step``
> > > > +     - rad
> > > > +     - Per-tick phase increment/decrement. Range [0, 2*pi).
> > > > +
> > > > +   * - ``scale_step``
> > > > +     - fractional
> > > > +     - Per-tick amplitude scale increment/decrement. Range [0, 1).
> > > > +
> > > > +Usage examples
> > > > +^^^^^^^^^^^^^^
> > > > +
> > > > +Configure a frequency sweep from 40 MHz to 60 MHz at a 1 kHz step:
> > > > +
> > > > +.. code-block:: bash
> > > > +
> > > > +	# Enable both no-dwell modes for a bidirectional ramp
> > > > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_en
> > > > +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_en  
> > > 
> > > Fix indents as mix of tabs and spaces.  As above I think using this enable
> > > for no dwell is not going to generalize well.  I think we need new ABI for this
> > > though I'm open to anyone suggesting something we can reuse.  
> > 
> > I suggested dwell_en, and I am not sure what else could be used here.
> > Something like hold_en could work and sounds more generic.. not sure. 
> 
> likewise :(
>  
> > 
> > > > +
> > > > +	# Set ramp limits
> > > > +	echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> > > > +	echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> > > > +
> > > > +	# Set ramp step size to 1 kHz
> > > > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_step
> > > > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_step
> > > > +
> > > > +	# Set ramp rate at 25 MHz
> > > > +	echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> > > > +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> > > > +
> > > > +	# Enable the DRG
> > > > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
> > > > +
> > > > +RAM mode
> > > > +--------
> > > > +
> > > > +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> > > > +and played back to modulate frequency, phase, amplitude, or polar (phase +
> > > > +amplitude) parameters.
> > > > +
> > > > +RAM control channel attributes
> > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > +
> > > > +.. flat-table::
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Unit
> > > > +     - Description
> > > > +
> > > > +   * - ``en``
> > > > +     - boolean
> > > > +     - Enable/disable RAM playback. Toggling swaps profile registers between
> > > > +       single tone and RAM configurations across all 8 profiles.  
> > > 
> > > So this might be a fly in the ointment of my previous comment about using
> > > enable of profile to turn off ram.  I guess disabling RAM drops into the
> > > matched number tone profile?  That's a pain but not disastrous. We'd have
> > > to only allow transitions by enabling the match number tone profile.
> > > 
> > > So transitions allowed would be
> > > 
> > > 	tone_profileX -> ram_profileX
> > > 	tone_profileX -> tone_profileY
> > > 	ram_profileX -> tone_profileX
> > > 	ram_profileX -> ram_profileY
> > > 
> > > But not
> > > 	tone_profileX -> ram_profileY
> > > where X!=Y  
> > 
> > No, there is only one RAM enable bit, once it is on, all single tone
> > profiles go away (all profile registers are repurposed for RAM mode
> > usage).
> 
> I'd missed the repurposing that basically means you never transition from
> tone to RAM without going via some intermediate point (maybe power down).

Yes. RAM mode is good and bad at the same time. Good because you can have a
flexible and budget friendly way to create custom frequency/phase/amplitude
patterns. A microcontroller and the DDS could do a lot with that. For other
fancy stuff we would need an FPGA.

> > > > +
> > > > +   * - ``frequency``
> > > > +     - Hz
> > > > +     - Frequency tuning word used as the single tone frequency when
> > > > +       RAM destination is not ``frequency``. Range [0, SYSCLK/2).
> > > > +
> > > > +   * - ``phase``
> > > > +     - rad
> > > > +     - Phase offset word used as the single tone phase when RAM destination
> > > > +       is not ``phase``. Range [0, 2*pi).
> > > > +
> > > > +   * - ``sampling_frequency``
> > > > +     - Hz
> > > > +     - RAM playback step rate of the active profile, which controls how fast the
> > > > +       address counter advances: SYSCLK / (4 * step_rate).  
> > > 
> > > Why do we care what the sysclk relationship is? It's ticking in HZ.  
> > 
> > Can be removed, but just to point out that the configured value will adjust to the
> > value where the divider is an integer. Maybe the user should be aware of that.
> 
> If you keep it just add something to note that it takes discrete values
> according to that formula.  I was reading more into it than that and
> getting confused to where step_rate was coming from!
> 
> > 
> > > > +
> > > > +Output shift keying (OSK)  
> > > This is a new one on me...   
> > > > +-------------------------
> > > > +
> > > > +OSK controls the output amplitude envelope, allowing the output to be ramped
> > > > +on/off rather than switched abruptly.  
> > >   
> > > > +
> > > > +.. flat-table::
> > > > +   :header-rows: 1
> > > > +
> > > > +   * - Attribute
> > > > +     - Unit
> > > > +     - Description
> > > > +
> > > > +   * - ``en``
> > > > +     - boolean
> > > > +     - Enable/disable OSK.
> > > > +
> > > > +   * - ``scale``
> > > > +     - fractional
> > > > +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> > > > +
> > > > +   * - ``sampling_frequency``
> > > > +     - Hz
> > > > +     - OSK ramp rate: SYSCLK / (4 * divider).
> > > > +
> > > > +   * - ``pinctrl_en``
> > > > +     - boolean
> > > > +     - Enable manual external pin control. When enabled, the OSK pin directly
> > > > +       gates the output on/off instead of using the automatic ramp.  
> > > 
> > > I wonder if we should split the various OSK modes into different channels given
> > > only some properties apply to each of automatic and manual modes. Also I think
> > > automatic mode is meaningless without pinctrl_en (so that can be replaced
> > > by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
> > > with manual mode or not?  That one seems even more odd.  
> > 
> > OSK is either in manual or auto:
> > * In manual mode the OSK pin enables and disables the output based on its level.
> > * In auto, the OSK pin controls the direction the amplitude updates. 
> > 
> > If we enable RAM mode, and other modes do not target amplitude, the only way to
> > manually configure the amplitude in software (i.e. without using an OSK gpio)
> > is going manual mode (scale_step == 0), disable this pinctrl_en and then set the
> > scale property (ASF register). That is the only reason I added this property.
> 
> Ah.  Maybe we hide that away and make the amplitude a property of RAM channel?

And what if a user is in fact willing to use the OSK pin?

> It can do this magic under the hood. I don't mind the attributes for OSK changing
> if this trick is in use (they won't be active anyway).

OSK has the highest priority of all, but it only acts on the amplitude.

> > > > +
> > > > +   * - ``scale_step``
> > > > +     - fractional
> > > > +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> > > > +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> > > > +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.  
> > > 
> > > Similar thing about rate of change of amplitude fitting better with current ABI
> > > than step does.  
> > 
> > ok... and this one is still missing the correspondent available attr.
> 
> Available is a bit tricky when there is an inverse relationship involved in the maths
> as what do we put the step as.  Maybe we should add a note on that to the ABI
> docs.  [min step max] where step gives the minimum step that due to non linearity
> may not be applicable between discrete values that may be taken away from that
> minimum granularity base value.  If that occurs the driver will round to the
> nearest possible value.

-- 
Kind regards,

Rodrigo Alencar
