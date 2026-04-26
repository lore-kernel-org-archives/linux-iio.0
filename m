Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F950390208
	for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 20:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777236147; cv=none; b=mOj5f6cRl2TLrmz6dO0db1lc729ENH4Xr6h05ctRPCVk2oWDpXzzvac900ZVfUA9/6tTHkxplJUe5w+UzAjk7VzDvCL7G0ynbd8zDy6c+jcHFXHFVTCWTrzdYkpBBQKN/by6yhD+jDvBrmyFLp9pC4Fty45REotNKmgmtOpzvcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777236147; c=relaxed/simple;
	bh=ykKXvnSRz9iUDo4K56DOvU0a/sVIIS4s5xC3DhWdMXw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/ygiTpZYmUV59OpEPUc8C9zeQxPaHtP7iiQ+hKssYt2Sba15Z3tUVEm0bKrSgDSDJN779IKi5FVZpJjHd1nki9lWTD++vXxlC26vS0PuS4QW6z4iw87LhHYr46tViCe4435G0mmMrpca6SDc4k4fOhOmf0hjbwyM6ZW+cnwWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REPVPzGD; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REPVPzGD"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488ad135063so87106915e9.0
        for <linux-iio@vger.kernel.org>; Sun, 26 Apr 2026 13:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777236143; x=1777840943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OR4oZS/Wc9pjklJHF6eAzgSWKS/rksyyMF49+wAiASo=;
        b=REPVPzGDtLZLhmr1ZX+3GUAsyCX50xObnw0Rv3Gh1J+0A0FK/lqdfONF9y/jSXJ/dH
         BBsoG9X0iQQxI0hemGReyxE9vVNBZMCoNhFm9azXXP3RNNofgCt0VjcMuybYLV6jYTVM
         c6rheYehM3/lSQ3qNn0RmwN1spdI1H7uZLO8KPqyfIanPYGL7SLW83s5U7RJPluwWlrU
         LuXcMJm1QyakBZpIDoIiYmGgcp0je2Qeo60bRA8brDPvTQCU2810BL9wYB8MjpSzg0iG
         pKdwwTSAGXz5qQEnZjpVdDExodIisaDb8faVUyi6jbBXFnZlHkU8QWXJXYiMFw48LZAP
         /fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777236143; x=1777840943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OR4oZS/Wc9pjklJHF6eAzgSWKS/rksyyMF49+wAiASo=;
        b=qav05CLrtzZGfkI4O3Zw+yKA2GiIJbrmEcUHorGWAcCr6Rvk00yHDjlajUrS2I8ghh
         8T9jN0lg4fNdtgQtRWVw/Btkyej6CQpSVPo0qVr9QKgBKdsT8PYNAhtE4kFWZBVhAXkB
         97JYPnCk3rynEQ9UjJwcGqVL1veHMtY9qP/ukT4yWbWtis70MXovd2ABEVeEzXXo/5Dp
         WW8g5RW+4g4u7wVuUh92GPu76dMYf8TnTY4wVZKm1GjaONIybtKPlPtVhpyet60bsFCp
         yD0hyheq7zTiuUPBHI5r8cB3pkcLatcJsqlaP4X5XPrHd/hwsixnrRHkGhePx9LqcRAl
         y7zQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Q771uSWR1PU6qpuG5v+8t331G+akmVRK9FfDTTEqmt0nupJtEkUx/FCQmxbN3uCZtn6Dg4DNIZas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd6XwH8LIp7CiO5XkyL7nGZOEojenx8RlFLcadoZLXE7I7oMmV
	uO2AohEiHsap4rWqg8wwxGnsyHbZ0SS8PTj4gUM7RnWnGiQW33O5ciBK
X-Gm-Gg: AeBDievzphjMpRNn+jd2GBMR5A9PuKWCDiOXcZt2xjdwSHdvwjVx8s030HtIj2Ho3/5
	hMZd0lx2+GWpw90oO/+QF9T2b/JjBCl/BWU/csIQyJSAs3x6D67mUI2x1nVl9fNyZ33NL+dmKhX
	UqYkUptAXgXGiEweSOKNovxSSHGvcAgmGQzswsfpJpu8ERQ4qNb8OV560jFFJj4Vki5ZVnT1KIZ
	6opx9CMRv5Oup+d99rXnw6Hg0f72fo551e8YAi+xrLnsKhJ0LWZUuQhi88dU6LVgeQik0n/NyXC
	PigO2b598py9Ez9FTD6WFsK/WN31U7YEbAV3rZSmuMZ09QlexTg8Eu19y+0wZI1btWpBf+LntPu
	rlkB0krA1bPCG/f+pjJF8kKvnicNkShvP9NzznDjGq08kF4xeueFThHmOOIxxSyryL5Zx2gUyge
	LCGB9/tKvALi7oPABNQYRK0WiS/h88F34F7tVjtJuHHaRzb0BUFLtzjUS6T4hBAFBuNaF2YjLNI
	p4A6gk3woXJ8Ugn69uYez05280ww2b9UXnuX5Z0ymefvadcsS34O4uOMIV7
X-Received: by 2002:a05:600c:46cb:b0:488:ac01:72de with SMTP id 5b1f17b1804b1-488fb7451e4mr589339335e9.5.1777236143203;
        Sun, 26 Apr 2026 13:42:23 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d6casm74951410f8f.32.2026.04.26.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 13:42:22 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 26 Apr 2026 21:42:15 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hardening@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v3 9/9] docs: iio: add documentation for ad9910 driver
Message-ID: <lkvrmc6y2z45b4qsmaxg3c2iaiar6hjmim3hdbkxqx3536yx3p@o6h7de4ire2d>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
 <20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
 <20260426141007.345c76e4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260426141007.345c76e4@jic23-huawei>

On 26/04/26 02:10PM, Jonathan Cameron wrote:
> On Fri, 17 Apr 2026 09:17:38 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > DDS modes, attributes and ABI usage examples.
> > 
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Hi Rodrigo,
> 
> I think this is getting close to something workable subject to some tweaks
> to not make the priority thing visible and use rate of change parameters
> so /Sec rather than steps.

I am not sure about this one. Getting the value into units per seconds will
increase the range of values by a lot, e.g., for the frequency case the step
size can range from a few Hz up to the entire supported range (hundreds of
MHz), and if you consider that one would often have the sampling_frequency
at 250 MHz... an attribute frequency_roc could have an order of 10^17 Hz/s,
and I am not sure how practical is that, although it can have a physical meaning,
like a "chirp slope".

> 
> Given this defines the ABI for a whole class of new devices that are
> rather complex, one concern is whether whatever we define here is general
> enough to be useful.  
> 
> Do you have any other DDS in your queue to upstream? Maybe it's worth
> sanity checking the ABI against them to see if it is fit for purpose?

Not really, still the only DDS. Other DDS of the same family have a similar
Digital Ramp Generator with controls over ramp limits, rates and step. 

...

> > +DDS modes
> > +=========
> > +
> > +The AD9910 supports multiple modes of operation that can be configured
> > +independently or in combination. Such modes and their corresponding IIO channels
> > +are described in this section. The following tables are extracted from the
> > +AD9910 datasheet and summarizes the control parameters for each mode and their
> > +priority when multiple sources are enabled simultaneously:
> 
> Maybe add a bit on what priority means.  Does it mean that only the highest
> priority one is acted on?  If so why do we need to expose that others are
> enabled? Just report only the highest priority one as enabled.
> 
> I can see the hardware needs to do priority so it knows where to go when
> a given source is disabled but from a software point of view that
> can be controlled by us enabling that next item (and the driver does
> things in the right order to get the appropriate transition)
> 
> That may mean that if all modes are disabled, we have to disable any output
> but seems doable.

That is a bit complicated, as you can see, this part has modes that target
one DDS parameter or multiple (destinations: phase, frequency, amplitude).
Also, multiple modes can coexist, when they target different parameters/destination.
At the same time, RAM mode complicates everything because even though it targets
one specific parameter, once it is enabled influences the base mode for the
other parameters because single-tone is off. I have ordered the mode channels so
that higher index have higher priority, so that can be a bit clearer.

Right now, all the controls are provided, what might be missing is a way
to query which level of those priorities is currently active, but those levels
are not the same thing as the controls. If we turn the priority levels into the
controls themselves it would be a different ABI and it would get a lot messy.
That is why I am dumping this priority table in this document! =(

> > +
> > +.. flat-table:: DDS Frequency Control
> > +   :header-rows: 1
> > +
> > +   * - Priority
> > +     - Data Source
> > +     - Conditions
> > +
> > +   * - Highest Priority
> > +     - RAM
> > +     - RAM enabled and data destination is frequency
> > +
> > +   * -
> > +     - DRG
> > +     - DRG enabled and data destination is frequency
> > +
> > +   * -
> > +     - Parallel data and FTW (frequency_offset)
> > +     - Parallel data port enabled and data destination is frequency
> > +
> > +   * -
> > +     - FTW (frequency)
> > +     - RAM enabled and data destination is not frequency
> > +
> > +   * -
> > +     - FTW (frequency) in single tone channel for the active profile
> > +     - DRG enabled and data destination is not frequency
> > +
> > +   * -
> > +     - FTW (frequency) in single tone channel for the active profile
> > +     - Parallel data port enabled and data destination is not frequency
> > +
> > +   * - Lowest Priority
> > +     - FTW (frequency) in single tone channel for the active profile
> > +     - None
> 
> > +
> > +Single tone mode
> > +----------------
> > +
> > +Single tone is the baseline operating mode. The ``profile[Y]`` channels
> > +provides enable, frequency, phase and amplitude control:
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable/disable profile Y. Only one profile can be active at a
> > +       time. Then enabling a profile disables the current active profile.
> > +       Disabling an active profile enables the next profile in ascending order,
> > +       wrapping around from 7 to 0.
> 
> That passing on to the next one seems rather non user friendly.  Can we just
> disable the whole unit under those conditions instead?  As above that may mean
> turning of the output entirely.  So to change mode it would always be transition
> to the one that is enabled.  A disable of a given channel results in no output.

Yes, I can go for the software powerdown in that case! and the powerdown attribute
could be removed?

> 
> > +
> > +   * - ``frequency``
> > +     - Hz
> > +     - Output frequency. Range [0, SYSCLK/2). Stored in the profile's frequency
> > +       tuning word (FTW).
> > +
> > +   * - ``phase``
> > +     - rad
> > +     - Phase offset. Range [0, 2*pi). Stored in the profile's phase offset word
> > +       (POW).
> > +
> > +   * - ``scale``
> > +     - fractional
> > +     - Amplitude scale factor. Range [0, 1]. Stored in the profile's amplitude
> > +       scale factor (ASF).
> > +
> > +Profile switching is allowed while RAM mode is enabled. In that case single tone
> > +parameters are stored in a shadow register and are not written to hardware until
> > +RAM mode is disabled.
> 
> This is only visible to userspace because of the priority thing?  If we hide
> that away to transition from RAM to this mode would just mean enabling this mode.

Partially, but the real reason is that single-tone and RAM shares the same profile
registers. So I have things cached, which allows user to change single-tone stuff
while RAM is enabled.

...

> > +Digital ramp generator (DRG)
> > +----------------------------
> > +
> > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > +hardware. It is controlled through three channels: a parent control channel
> > +(``digital_ramp_generator``) and two child ramp channels
> > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> > +sets the destination to frequency.
> > +
> > +Control channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable/disable the DRG.
> > +
> > +Ramp channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> > +attribute set but configure ascending and descending ramp parameters
> > +independently:
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up
> 
> transition
> 
> > +       only, ramp-down only or bidirectional with dwell at the limits.
> 
> Feels a little unintuitive to use the generic enable for this.
> We might need a specific control for this one. 

How about dwell_en, but it might not sound that generic. I used "enable" because:
- no-dwell high means a ramp-up pattern (only enabling the ramp-up channel)
- no-dwell low means a ramp-down pattern (only enabling the ramp-down channel)
- both no-dwell is a continuous ramp that goes up and down. (both enabled)
The last case is a bit off though, when both are disabled we get the normal mode, which
is also a ramps up and down, but dwelling in the limits.
 
> > +
> > +   * - ``frequency``
> > +     - Hz
> > +     - Frequency ramp limit. Range [0, SYSCLK/2).
> > +
> > +   * - ``phase``
> > +     - rad
> > +     - Phase ramp limit. Range [0, 2*pi).
> > +
> > +   * - ``scale``
> > +     - fractional
> > +     - Amplitude scale ramp limit. Range [0, 1).
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - Ramp clock rate: SYSCLK / (4 * divider).
> > +
> > +   * - ``frequency_step``
> > +     - Hz
> > +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).
> 
> So this was the bit I referred to earlier.  Normally we do
> rate of change measurements for this stuff rather than what happens on
> each tick (based on how we handle things like ROC events)
> 
> So could we make these
> 	``frequency_roc`` units HZ/Sec
> etc?  Then from the mix configured would need to work out the optimum
> tick to deliver it.
> 
> I suppose it's possible that someone might want a stepped frequency
> though which would break this approach?  Does anyone actually do that?
> If so we'd need to keep the samping_frequency but then control _roc
> with that in mind.

yeah... frequency steps would make sense when the user controls when to
perform the updates, or when it comes from certain events.

sampling frequency defines the timing and this roc attr would
also depend on timing... there would be two options:
* ignore updating ramp step when sampling freq is updated. Here roc
  would have a different value when readback.
* cache the "requested" roc and use it update ramp step when sampling
  freq is updated, so roc remains with the value initially configured. 

> 
> > +
> > +   * - ``phase_step``
> > +     - rad
> > +     - Per-tick phase increment/decrement. Range [0, 2*pi).
> > +
> > +   * - ``scale_step``
> > +     - fractional
> > +     - Per-tick amplitude scale increment/decrement. Range [0, 1).
> > +
> > +Usage examples
> > +^^^^^^^^^^^^^^
> > +
> > +Configure a frequency sweep from 40 MHz to 60 MHz at a 1 kHz step:
> > +
> > +.. code-block:: bash
> > +
> > +	# Enable both no-dwell modes for a bidirectional ramp
> > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_en
> > +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_en
> 
> Fix indents as mix of tabs and spaces.  As above I think using this enable
> for no dwell is not going to generalize well.  I think we need new ABI for this
> though I'm open to anyone suggesting something we can reuse.

I suggested dwell_en, and I am not sure what else could be used here.
Something like hold_en could work and sounds more generic.. not sure.  

> > +
> > +	# Set ramp limits
> > +	echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> > +	echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> > +
> > +	# Set ramp step size to 1 kHz
> > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_step
> > +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_step
> > +
> > +	# Set ramp rate at 25 MHz
> > +	echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> > +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> > +
> > +	# Enable the DRG
> > +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
> > +
> > +RAM mode
> > +--------
> > +
> > +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> > +and played back to modulate frequency, phase, amplitude, or polar (phase +
> > +amplitude) parameters.
> > +
> > +RAM control channel attributes
> > +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable/disable RAM playback. Toggling swaps profile registers between
> > +       single tone and RAM configurations across all 8 profiles.
> 
> So this might be a fly in the ointment of my previous comment about using
> enable of profile to turn off ram.  I guess disabling RAM drops into the
> matched number tone profile?  That's a pain but not disastrous. We'd have
> to only allow transitions by enabling the match number tone profile.
> 
> So transitions allowed would be
> 
> 	tone_profileX -> ram_profileX
> 	tone_profileX -> tone_profileY
> 	ram_profileX -> tone_profileX
> 	ram_profileX -> ram_profileY
> 
> But not
> 	tone_profileX -> ram_profileY
> where X!=Y

No, there is only one RAM enable bit, once it is on, all single tone
profiles go away (all profile registers are repurposed for RAM mode
usage).

> > +
> > +   * - ``frequency``
> > +     - Hz
> > +     - Frequency tuning word used as the single tone frequency when
> > +       RAM destination is not ``frequency``. Range [0, SYSCLK/2).
> > +
> > +   * - ``phase``
> > +     - rad
> > +     - Phase offset word used as the single tone phase when RAM destination
> > +       is not ``phase``. Range [0, 2*pi).
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - RAM playback step rate of the active profile, which controls how fast the
> > +       address counter advances: SYSCLK / (4 * step_rate).
> 
> Why do we care what the sysclk relationship is? It's ticking in HZ.

Can be removed, but just to point out that the configured value will adjust to the
value where the divider is an integer. Maybe the user should be aware of that.

> > +
> > +Output shift keying (OSK)
> This is a new one on me... 
> > +-------------------------
> > +
> > +OSK controls the output amplitude envelope, allowing the output to be ramped
> > +on/off rather than switched abruptly.
> 
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``en``
> > +     - boolean
> > +     - Enable/disable OSK.
> > +
> > +   * - ``scale``
> > +     - fractional
> > +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - OSK ramp rate: SYSCLK / (4 * divider).
> > +
> > +   * - ``pinctrl_en``
> > +     - boolean
> > +     - Enable manual external pin control. When enabled, the OSK pin directly
> > +       gates the output on/off instead of using the automatic ramp.
> 
> I wonder if we should split the various OSK modes into different channels given
> only some properties apply to each of automatic and manual modes. Also I think
> automatic mode is meaningless without pinctrl_en (so that can be replaced
> by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
> with manual mode or not?  That one seems even more odd.

OSK is either in manual or auto:
* In manual mode the OSK pin enables and disables the output based on its level.
* In auto, the OSK pin controls the direction the amplitude updates. 

If we enable RAM mode, and other modes do not target amplitude, the only way to
manually configure the amplitude in software (i.e. without using an OSK gpio)
is going manual mode (scale_step == 0), disable this pinctrl_en and then set the
scale property (ASF register). That is the only reason I added this property.

> > +
> > +   * - ``scale_step``
> > +     - fractional
> > +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> > +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> > +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.
> 
> Similar thing about rate of change of amplitude fitting better with current ABI
> than step does.

ok... and this one is still missing the correspondent available attr.

-- 
Kind regards,

Rodrigo Alencar
