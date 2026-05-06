Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C083E9F9E
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 10:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778064073; cv=none; b=ZDobV3klFKHwEp0+FzHSXrGpneeB44Qj3RPpWay9XCMUtqI3Qqp0wQ9bdfMDsnMlvQPopxDmlg7ccAHnbiQnwbBYZREa1bbAf1qbmNj6fcNY7ve8qIwhLllWjDBVZ/WTVYAebMaYK/ElEsa/LcHWBwwxCEsmQGwHJZlWtHU4jzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778064073; c=relaxed/simple;
	bh=YGdrnZDHEAKU19puluFb0aQrRnmCH5AJB66zLm2mhzs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kEDutg3/Ail/37704UROqxaYmm4RtI6aKxvzxb54qSHfYVYZ6QHDnpmfX1luz8NCtIJcLjMZJ0swPHaSED4lRWDmervGe/UCGw9w+2l7tZ/q5kYeAtTdgqcYbkLsrvmpPIlFc2Cl791trLZWc1G514Dh4qWj01HcFCCishDld84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1xgW5IJ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1xgW5IJ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-449e96a8a80so3761030f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 03:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778064069; x=1778668869; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAMMS6+ymkXk81im8PQp9ngpssGuoAIg/fNUOQlqE+c=;
        b=D1xgW5IJZQDHV/Ke/TctsM2v6C28KsdfiNWCIJ6dkDvwCGF6FPZSBEClVZif6IR/IO
         alqhQtkdRtKwQ86ovhXS7zoQChwkpp87vNv/OAxy4lZumqOCu8zAP39x/66FPV8BS1Pf
         eOtxWqYZWRQAfOJhnbCtu1s9AR0Dt6V9V/eHmnQGJd0Y7l7rBxpbwZUpYKOqCiHxn7LQ
         sJ5xaDK2vushhdG5birTHrgsW+6qnu1XQ3c5CQV5PEQxjSodurdJJJSpMSsSLj6uN1SB
         x5j+4g0+Lg8QMhj3M9GmD35V7dQYlVCj1Sansajb3SaR1/E8/cdn5u84erAlqrQvYi9n
         DqfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778064069; x=1778668869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAMMS6+ymkXk81im8PQp9ngpssGuoAIg/fNUOQlqE+c=;
        b=jwFtIv7jB/41XmKGaCNYCSjlQIc19RUhRdJgoCYb+aqdvBh/IaBVKHnnvk3hHJCNGS
         aSd8CzfzrpSsqGGVinYErUSdyP6GDjqrbCaTXirYKpBaIxIWKXWkKBtz5GFb2Hf5lQNQ
         xKWY6chb9tu18iA4r8/EGXOOoql5eLQzJGyJwh39QMmBuYembXfx95UKjkdAzVJCkkPg
         PkV3WSQ/pDXbOYKj7cw9EYWI0lwB2L2eC+wXP7Qej0sq0B2PR4MqEUtVbcO1rKm3rF3x
         Eynivj9SQFYqWySdmc+1Zph11k9s8pmLim6ws6BvFyBvRrniNylSK6bZNZoqOaKKys/l
         RPjQ==
X-Forwarded-Encrypted: i=1; AFNElJ/9FPf8YWXJ23pEBJbsv+lTPouZp0d3a8CY5xrn4lhX0LSeyHPnvj3IFqD5YZTu9IH8wdH96fS0pVE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywg5iAYOBrgQ9hsD4tTabPyOdFT7g/mSl4f/2k8ACXsMMGvhNpv
	6VXepk8eku2GXItHLH+UD/7IYvrZap/InpOnBmWJP0oaYl9nFn751TVU
X-Gm-Gg: AeBDietD8Jbxoa/6NWJUPsuePXAR01QJ3w+Czero+y7dhuhJvKKn7WXVgM3TeQ6Rsqt
	kg8yweyWM65i4vlslhdQMVDntzh36Ip3Hd5GKkS73RTjT7SsjM0JmZ/3B8DfDSnRMVuLWl7SSJj
	PWFaZjC/Kpy8zTSwghS960O+AC2OHZPQlsBTQffvQp+rbSxTASClv+s4bQi8gbMtyiDsmvX5oiz
	xem/vBt6mHN4W3w0UX1m2QRTCeT3ktx0U0K3wOhyq6gFBzRrceYE6wSfxHS3sURZyBqCEpvYWlF
	J2J6aIpGxkJPWxQFZd++wuNstq1CDpA+HMK4jSRxZKzzLv02sHxPrsTNAyiBlFPpTvYls0SYsR1
	wr04wS74WpukO8h11oOlDEqMZrCieRDfJ5RWKAHScfobaK2qWeFuUf3v/PbGfBmEUaXvYrwdUsc
	2zZZavzE3dvxLRdDf4jhEsXWPynzlxVew2VQl+N83GIfdIUdda83oNWfzO5izcscpVYSaWe8mzW
	KiThHZY61NkWcAFwiGmyu4qz1ilgC16ftux+b+LKtKCuKIRHRFuizDIrkgP
X-Received: by 2002:adf:f44d:0:b0:452:1868:8e5f with SMTP id ffacd0b85a97d-45218688ee3mr1327753f8f.3.1778064068378;
        Wed, 06 May 2026 03:41:08 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45054b02c5asm11432708f8f.19.2026.05.06.03.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 03:41:07 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Wed, 6 May 2026 11:41:00 +0100
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
Message-ID: <kwx4kgvagwoaljurnkvuvwggrss2qdjwzszpju6mkdxjfi4n4n@yjsv33ewxkzy>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
 <20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
 <20260426141007.345c76e4@jic23-huawei>
 <lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
 <20260427104608.7819a134@jic23-huawei>
 <dsppqeyqtelrt3arkgxdgkhxvgtqpxkvf6n3rbkz4wk7zgfwqb@cn4rqk7p4g6i>
 <20260505180827.2972124e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505180827.2972124e@jic23-huawei>

On 26/05/05 06:08PM, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 15:35:21 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> 
> > On 26/04/27 10:46AM, Jonathan Cameron wrote:
> > > On Sun, 26 Apr 2026 21:42:15 +0100
> > > Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > >   
> > > > On 26/04/26 02:10PM, Jonathan Cameron wrote:  
> > > > > On Fri, 17 Apr 2026 09:17:38 +0100
> > > > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> > > > >     
> > > > > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > > > > 
> > > > > > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > > > > > DDS modes, attributes and ABI usage examples.
> > > > > > 
> > > > > > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>    
> > > > > 
> > > > > Hi Rodrigo,
> > > > > 
> > > > > I think this is getting close to something workable subject to some tweaks
> > > > > to not make the priority thing visible and use rate of change parameters
> > > > > so /Sec rather than steps.    
> > > > 
> > > > I am not sure about this one. Getting the value into units per seconds will
> > > > increase the range of values by a lot, e.g., for the frequency case the step
> > > > size can range from a few Hz up to the entire supported range (hundreds of
> > > > MHz), and if you consider that one would often have the sampling_frequency
> > > > at 250 MHz... an attribute frequency_roc could have an order of 10^17 Hz/s,
> > > > and I am not sure how practical is that, although it can have a physical meaning,
> > > > like a "chirp slope".  
> > > 
> > > That scaling is indeed a bit of a pain though it will go in a 64 bit int
> > > however, seems likely we'll get higher frequency devices one day that will
> > > limb even faster.
> > > 
> > > Maybe wait and see if anyone else has input on this.

Maybe we add this _roc ABI for this device and figure out scaling issues on new devices
later.

> > > >   
> > > > > 
> > > > > Given this defines the ABI for a whole class of new devices that are
> > > > > rather complex, one concern is whether whatever we define here is general
> > > > > enough to be useful.  
> > > > > 
> > > > > Do you have any other DDS in your queue to upstream? Maybe it's worth
> > > > > sanity checking the ABI against them to see if it is fit for purpose?    
> > > > 
> > > > Not really, still the only DDS. Other DDS of the same family have a similar
> > > > Digital Ramp Generator with controls over ramp limits, rates and step.   
> > > 
> > > There are two in staging that have been there a very long time... 
> > > ad9832 and ad9834.  I haven't looked at how they correspond to this.  
> > 
> > It seems they can benefit of this child channel concept, as they define
> > multiple frequency and phase configuration for the same physical DAC.
> > I see the following in the most complicated one:
> > - out_altvoltage0_frequency0
> > - out_altvoltage0_frequency1
> > - out_altvoltage0_frequency_scale
> > - out_altvoltage0_phase0
> > - out_altvoltage0_phase1
> > - out__altvoltage0_phase_scale
> > - out_altvoltage0_pincontrol_en
> > - out_altvoltage0_frequencysymbol
> > - out_altvoltage0_phasesymbol
> > - out_altvoltage0_out_enable
> > - out_altvoltage0_out1_enable
> > - out_altvoltage0_out0_wavetype
> > - out_altvoltage0_out1_wavetype
> > - out_altvoltage0_out0_wavetype_available
> > - out_altvoltage0_out1_wavetype_available
> > 
> > less complicated, no RAM, no DRG nor parallel port. In terms of common stuff I can see
> > frequency_scale and pinctrl_en.  
> 
> My main concern here is IIRC these are very much PSK / FSK devices with expectation
> of symbol being externally controlled. (maybe I remembered that wrong ;)
> So the symbol relationship would need to map to child channels in some fashion.

With multiple channels, I'd say that is already figured with the standard "enable" ABI,
As the "symbol" to select is a choice of one of the channels to enable. Like it is
being done here for the single tone profiles. Being externally controlled is a user
problem, being its responsability to make sure that expectations on the values are
aligned during some specific actions. For instance, this very driver, expects the selected profile
to be trully selected by the profile pins so that RAM loading works. Also, there is another
weird case, where the profile needs to be selected to make sure a read of the profile register
works (which is another reason to use cached reads). Apart from those cases, I suppose
profile pin control can be "detached" from the driver. 

> 
> > 
> > > We should think hard about whether to bring them inline with this
> > > and out of staging, or just delete them.
> > >   
> > > > 
> > > > ...
> > > >   
> > > > > > +DDS modes
> > > > > > +=========
> > > > > > +
> > > > > > +The AD9910 supports multiple modes of operation that can be configured
> > > > > > +independently or in combination. Such modes and their corresponding IIO channels
> > > > > > +are described in this section. The following tables are extracted from the
> > > > > > +AD9910 datasheet and summarizes the control parameters for each mode and their
> > > > > > +priority when multiple sources are enabled simultaneously:    
> > > > > 
> > > > > Maybe add a bit on what priority means.  Does it mean that only the highest
> > > > > priority one is acted on?  If so why do we need to expose that others are
> > > > > enabled? Just report only the highest priority one as enabled.
> > > > > 
> > > > > I can see the hardware needs to do priority so it knows where to go when
> > > > > a given source is disabled but from a software point of view that
> > > > > can be controlled by us enabling that next item (and the driver does
> > > > > things in the right order to get the appropriate transition)
> > > > > 
> > > > > That may mean that if all modes are disabled, we have to disable any output
> > > > > but seems doable.    
> > > > 
> > > > That is a bit complicated, as you can see, this part has modes that target
> > > > one DDS parameter or multiple (destinations: phase, frequency, amplitude).
> > > > Also, multiple modes can coexist, when they target different parameters/destination.
> > > > At the same time, RAM mode complicates everything because even though it targets
> > > > one specific parameter, once it is enabled influences the base mode for the
> > > > other parameters because single-tone is off. I have ordered the mode channels so
> > > > that higher index have higher priority, so that can be a bit clearer.
> > > > 
> > > > Right now, all the controls are provided, what might be missing is a way
> > > > to query which level of those priorities is currently active, but those levels
> > > > are not the same thing as the controls. If we turn the priority levels into the
> > > > controls themselves it would be a different ABI and it would get a lot messy.
> > > > That is why I am dumping this priority table in this document! =(  
> > > 
> > > I understand (at least some) of the hardware complexity but I don't like
> > > the fact this is effectively exposing it to userspace. + I really don't want
> > > more ABI to indicate whether a mode is actively doing anything or not.
> > > Whilst I agree the code will be more complex, having clarity on what is
> > > enabled at any given time is definitely something we ant to aim for.  
> > 
> > This part seems special, so I would not bother with the fact that userspace
> > needs to figure some things out.
> 
> I'm kind of fine for that being needed for complex usecases but if I want
> to do something simple I'd like that to be standard and intuitive.
> Obviously gets blurry wrt to what counts as simple.
> 
> > 
> > Since there is this priority, there is a difference on enable vs active,
> > and things are different for each DDS parameter. Take the single tone example
> > when it is enabled, should that mean that it is active on frequency, phase
> > or amplitude? that granularity could be exposed like that if we create dedicated
> > channels for each parameter on every mode possible, which turns the ABI into
> > a greater mess.
> 
> I did wonder if we should separate those but agree it's tricky.
> 
> > 
> > > Can we work out a transition diagram?  That might make it easier to
> > > tell whether it's possible to map it as single enables at a time and
> > > incorporate weird corners like the RAM one.  Maybe not needed if the
> > > RAM one is the only real oddity and otherwise it's just going up
> > > and down the priority lists.  
> > 
> > I still think it is not that simple, an enable is just a control for
> > a specific mode-destination pair.
> >  
> > > One complexity I can see with single enables is that they'd need
> > > to be separate for each of frequency, phase and amplitude to reflect
> > > the transitions that can occur.  
> > 
> > As mentioned above, that would be messy to interface with...
> >  
> > > Also the fun of profiles, where those profile pins are basically picking
> > > symbols - could be used for multi level PSK or FSK for example if wired
> > > up to an external symbol source.  I'd be a bit surprised if those are
> > > always wired up to a host CPU.  
> > 
> > Yes, some users may want to control the profile pins through an FPGA.
> > 
> > > *sigh* I'm talking my self around to needing ABI to indicate a channel
> > > is active.  The symbol stuff gets us some of the way there (and would
> > > work for the tones) but doesn't cover the added complexity of RAM etc.
> > > So 'maybe' new ABI for _isactive or something like that?  
> > 
> > active_params or active_targets? listing out DDS parameters that is currently
> > active for that mode/channel? like printing "frequency phase amplitude", so
> > that would mean the mode is driving all of them. That would be a read-only
> > status. 
> 
> Would have to be simple per channel sysfs attribute that would say
> is this particular channel actually contributing to the current output.
> Where it can contribute in multiple ways we'll need separate attributes.
> 
> Anything else is going to break the rules on one thing per each sysfs
> attribute.
> out_altvoltageXXX_phase_active
> out_altvoltageXXX_freq_active
> or something like that.

Yes, that could be done. This would be just informative, and I suppose that
any userspace software that knows how to control the part would not even
look at those. Probably it would just be used while debugging.
 
> > 
> > > Perhaps the boundary we put on this is the ABI should be such that
> > > simple choices such as enabling a single tone, or single RAM mode
> > > setting are intuitive. 
> > > 
> > > Why do we only have one ram channel? I'd kind of expect the firmware
> > > to fill all 8 RAM profiles because of that 'external' profile pins
> > > use case.  
> > 
> > Most of the RAM configuration is now comming from the firmware, so there
> > is no much info to display/configure in multiple channels. The per-profile
> > configs require the weird ABI like operating modes and address start/end.
> > By removing those, I have mostly "global" stuff.
> If folk are doing profile control from external pins I'd kind of expect to
> see some description of what they are controlling even if it's read only.
> 
> Maybe we don't do this now but we should make sure there is space in the ABI
> by thinking what it might look like.

Right now, I am not seeing anything generic in RAM control appart from a
"sampling_frequency". A lot of it seems device-specific:

- Destination (freq/phase/amplitude/polar)
- Internal profile control config (sequenced modes I had before)
- Per-profile config:
	- Start address
	- End address
	- Address step rate (sampling freq)
	- RAM mode:
		- direct switch
		- ramp-up
		- bidirectional
		- bidirectional continuous
		- ramp-up continuous
	- No-dwell high bit (specific to ramp-up mode)
	- Zero-crossing bit (specific to direct switch mode)

...

> > > > > > +Digital ramp generator (DRG)
> > > > > > +----------------------------
> > > > > > +
> > > > > > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > > > > > +hardware. It is controlled through three channels: a parent control channel
> > > > > > +(``digital_ramp_generator``) and two child ramp channels
> > > > > > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > > > > > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> > > > > > +sets the destination to frequency.
> > > > > > +
> > > > > > +Control channel attributes
> > > > > > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > +
> > > > > > +.. flat-table::
> > > > > > +   :header-rows: 1
> > > > > > +
> > > > > > +   * - Attribute
> > > > > > +     - Unit
> > > > > > +     - Description
> > > > > > +
> > > > > > +   * - ``en``
> > > > > > +     - boolean
> > > > > > +     - Enable/disable the DRG.
> > > > > > +
> > > > > > +Ramp channel attributes
> > > > > > +^^^^^^^^^^^^^^^^^^^^^^^^
> > > > > > +
> > > > > > +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> > > > > > +attribute set but configure ascending and descending ramp parameters
> > > > > > +independently:
> > > > > > +
> > > > > > +.. flat-table::
> > > > > > +   :header-rows: 1
> > > > > > +
> > > > > > +   * - Attribute
> > > > > > +     - Unit
> > > > > > +     - Description
> > > > > > +
> > > > > > +   * - ``en``
> > > > > > +     - boolean
> > > > > > +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> > > > > > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > > > > > +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up    
> > > > > 
> > > > > transition
> > > > >     
> > > > > > +       only, ramp-down only or bidirectional with dwell at the limits.    
> > > > > 
> > > > > Feels a little unintuitive to use the generic enable for this.
> > > > > We might need a specific control for this one.     
> > > > 
> > > > How about dwell_en, but it might not sound that generic. I used "enable" because:
> > > > - no-dwell high means a ramp-up pattern (only enabling the ramp-up channel)
> > > > - no-dwell low means a ramp-down pattern (only enabling the ramp-down channel)
> > > > - both no-dwell is a continuous ramp that goes up and down. (both enabled)
> > > > The last case is a bit off though, when both are disabled we get the normal mode, which
> > > > is also a ramps up and down, but dwelling in the limits.
> > > >    
> > > > > > +
> > > > > > +   * - ``frequency``
> > > > > > +     - Hz
> > > > > > +     - Frequency ramp limit. Range [0, SYSCLK/2).
> > > > > > +
> > > > > > +   * - ``phase``
> > > > > > +     - rad
> > > > > > +     - Phase ramp limit. Range [0, 2*pi).  
> > > 
> > > Looking at this again, how do we set the DRG mode?  E.g. if it effects
> > > only phase?   
> > 
> > You mean the destination? I removed the destination ABI. so now destination is
> > set when we write to either frequency, phase or scale properties.
> > * writing to frequency or frequency_step sets the destination to frequency
> > * writing to phase or phase_step sets the destination to phase
> > * writing to scale or scale_step sets the destination to amplitude
> 
> So it's last write that sets it.  We definitely need a way to know which
> one is active if we get multiple writes.  What do the others return if they
> were set but something else has been set since?

All those values represent the same set of registers with different scaling for
frequency, phase or scale units. I can get the other values to return -EBUSY
when reading a destination attribute that was not set.

> > 
> > The DRG mode (dwell mode) is now controlled with the enable bits in the ramp
> > up/down channels 
> > 
> > > > > > +
> > > > > > +   * - ``scale``
> > > > > > +     - fractional
> > > > > > +     - Amplitude scale ramp limit. Range [0, 1).
> > > > > > +
> > > > > > +   * - ``sampling_frequency``
> > > > > > +     - Hz
> > > > > > +     - Ramp clock rate: SYSCLK / (4 * divider).
> > > > > > +
> > > > > > +   * - ``frequency_step``
> > > > > > +     - Hz
> > > > > > +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).    
> > > > > 
> > > > > So this was the bit I referred to earlier.  Normally we do
> > > > > rate of change measurements for this stuff rather than what happens on
> > > > > each tick (based on how we handle things like ROC events)
> > > > > 
> > > > > So could we make these
> > > > > 	``frequency_roc`` units HZ/Sec
> > > > > etc?  Then from the mix configured would need to work out the optimum
> > > > > tick to deliver it.
> > > > > 
> > > > > I suppose it's possible that someone might want a stepped frequency
> > > > > though which would break this approach?  Does anyone actually do that?
> > > > > If so we'd need to keep the samping_frequency but then control _roc
> > > > > with that in mind.    
> > > > 
> > > > yeah... frequency steps would make sense when the user controls when to
> > > > perform the updates, or when it comes from certain events.  
> > > 
> > > You've lost me here.  How can they do that?  Some external clocking
> > > or event?  
> > 
> > That would depend on what the user does. This part has this DRHOLD pin
> > which can freeze the ramp. If the user sets this HIGH and creates pulses
> > it is able to control the stepping of the RAMP manually. But I assume
> > that no one would do that... such application is unknown to me.
> 
> They'd have to sync that with the clock driving the ramp. I guess that's
> possible - but nasty.  I vote we pretend this usecase doesn't exist for now ;)
> 
> > > > > > +
> > > > > > +Output shift keying (OSK)    
> > > > > This is a new one on me...     
> > > > > > +-------------------------
> > > > > > +
> > > > > > +OSK controls the output amplitude envelope, allowing the output to be ramped
> > > > > > +on/off rather than switched abruptly.    
> > > > >     
> > > > > > +
> > > > > > +.. flat-table::
> > > > > > +   :header-rows: 1
> > > > > > +
> > > > > > +   * - Attribute
> > > > > > +     - Unit
> > > > > > +     - Description
> > > > > > +
> > > > > > +   * - ``en``
> > > > > > +     - boolean
> > > > > > +     - Enable/disable OSK.
> > > > > > +
> > > > > > +   * - ``scale``
> > > > > > +     - fractional
> > > > > > +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> > > > > > +
> > > > > > +   * - ``sampling_frequency``
> > > > > > +     - Hz
> > > > > > +     - OSK ramp rate: SYSCLK / (4 * divider).
> > > > > > +
> > > > > > +   * - ``pinctrl_en``
> > > > > > +     - boolean
> > > > > > +     - Enable manual external pin control. When enabled, the OSK pin directly
> > > > > > +       gates the output on/off instead of using the automatic ramp.    
> > > > > 
> > > > > I wonder if we should split the various OSK modes into different channels given
> > > > > only some properties apply to each of automatic and manual modes. Also I think
> > > > > automatic mode is meaningless without pinctrl_en (so that can be replaced
> > > > > by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
> > > > > with manual mode or not?  That one seems even more odd.    
> > > > 
> > > > OSK is either in manual or auto:
> > > > * In manual mode the OSK pin enables and disables the output based on its level.
> > > > * In auto, the OSK pin controls the direction the amplitude updates. 
> > > > 
> > > > If we enable RAM mode, and other modes do not target amplitude, the only way to
> > > > manually configure the amplitude in software (i.e. without using an OSK gpio)
> > > > is going manual mode (scale_step == 0), disable this pinctrl_en and then set the
> > > > scale property (ASF register). That is the only reason I added this property.  
> > > 
> > > Ah.  Maybe we hide that away and make the amplitude a property of RAM channel?  
> > 
> > And what if a user is in fact willing to use the OSK pin?
> 
> Sigh. I don't have a good answer, but I don't like the weird 'special' nature
> of this attribute.  I guess sometimes there isn't a good answer to be found.
> 
> OSK + RAM is odd enough that I'm not that bothered if we have to go weird
> here.

I will remove this then. I suppose that adding another possible value for
scale_roc allows us to go around this, i.e., if scale_roc is such that the
amplitude step is a value equal or greater than the amplitude itself (or even the
max amplitude value) I could assume that this would be the manual mode with pinctrl
enable as it would be like an automatic mode with no ramp, but an immediate on-off
transition. Then scale_roc == 0 means manual mode with pinctrl disabled.
Will try to develop on this....

> > 
> > > It can do this magic under the hood. I don't mind the attributes for OSK changing
> > > if this trick is in use (they won't be active anyway).  
> > 
> > OSK has the highest priority of all, but it only acts on the amplitude.
> > 
> > > > > > +
> > > > > > +   * - ``scale_step``
> > > > > > +     - fractional
> > > > > > +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> > > > > > +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> > > > > > +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.    
> > > > > 
> > > > > Similar thing about rate of change of amplitude fitting better with current ABI
> > > > > than step does.    
> > > > 
> > > > ok... and this one is still missing the correspondent available attr.  
> > > 
> > > Available is a bit tricky when there is an inverse relationship involved in the maths
> > > as what do we put the step as.  Maybe we should add a note on that to the ABI
> > > docs.  [min step max] where step gives the minimum step that due to non linearity
> > > may not be applicable between discrete values that may be taken away from that
> > > minimum granularity base value.  If that occurs the driver will round to the
> > > nearest possible value.  

-- 
Kind regards,

Rodrigo Alencar
