Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521551799F
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 09:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778405420; cv=none; b=aM0GMehunonrIYSdlmnqwzXOrJnjJaS/Pe6wVYbq0BTohax1UWjxxjAEjOMAj/18F8tVX7p1QKURLfwY7dFLdux59A6EFdy5kBiS1+AdY3ICosewfPt6P/hw+O2T79eHs/xg55eHXHHHwz96dBRusngfMgFOR0NKDfP4yfjrSUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778405420; c=relaxed/simple;
	bh=YJwhwrDm4/NswyGYCUyvXn9RnqzIrsiylcYFCx/kk0g=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Upk3ERJxjfE51DsMhBR+0mikZUGw9FkfIRE4co/A5PIBPjwrufeON4mZihDEIwCf1B3J2SUDmS5O32U/Nbr+Gnz9skI8U30Npo5VG6/65C4yJQNvX1tKSh43M47Krmmi5MnZ2VcspG+Z0cD1FcBDxMSqynIui4ikMfOOc9/I61M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IY1hG0EM; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IY1hG0EM"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-444826c16ffso2945358f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 02:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778405416; x=1779010216; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4iLuePCyXrKAdAA7gI1umPA8P9y0VxotcIe9QKUhTpg=;
        b=IY1hG0EM+kN/57wgUKBams16tgGdm7HOM8Z/tDGRe7yKF4MGqIBQn+Owlp13Wbdddz
         69huE3E72+/+QRitwIQHVyiKGWZk5qkI9jlixurdvOfimlT1Cye2XEF5KzJfC42ESEQS
         XoBiSTilKBhn0jN3s3pup8+WGSEPe0OczRm4Xt43t2Nv7l7xfYsKyd8qdKvGH36+agAr
         4Spiaqtl0roMTOeSSLdEBiWB45cEq6CerpGeeyOw8PPqyhdmhC1mNhfP2zIAhN0aRSwJ
         pl7ChhIociIMRBnKTPanVerNhZRehD1sZAULxkUUxY+FFsLYo+XuyB0XpbO5MU0I/0hB
         x03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778405416; x=1779010216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4iLuePCyXrKAdAA7gI1umPA8P9y0VxotcIe9QKUhTpg=;
        b=oHTw4RUTkcToycVCwHdwkckBFb21g37PzIMO1YUB41+skcPtXys6RvY8ajjCSGrl0z
         k2uOy5CVwSAVuF9wyJPkyUa77HF0SF8Dsh+/QZHTCmfdidh0cKNExXZeEOawpTslFnK7
         zM1zIQFXnVoAiHArRFCeF2cwy+D47NVcRUbDR39Xo9wMjcqyOQbb4w38sViecZCjjkm8
         +VHd/6QPSMUv4iU70JIAsrOLLK0oYsKvRaykHQnn5VPG3fiklR1VE8pKoHdYEGVl7BKq
         M3Qf9gMxouKDsKQPYyiMQAiASBk3eGqNpkVxfyQcoagUHFziJQ1j54uzcc5YB7FR8ao6
         chNA==
X-Forwarded-Encrypted: i=1; AFNElJ//uoxHxSgyWtKXEguuRtq9iwPKLSueqSuVZokKBUwnlq5O8N82O6RSib1269KaXuKaQpxny4UL8bw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRAb2LSmGbIrMNGt9lXP9h/xVbtd6N/4lo4UlyFlAQRkeTGyBd
	z2I7NtR6Wwn1Q2RtvZFS3tf11LStIcxKriYgeib4MOb3uqb9i12PTPQ4
X-Gm-Gg: Acq92OHQNNm7oKlPAIjv4PnT9CPx2XGnN1HbF0azplK+ITWEIgdQP80bRHdb1ar38Uo
	QPkT+Zwm//h08DR6CqT9EGp0PWhm+GMFjrDg4eaZIm5JMdUn2bH+2bLzsgs9rgC0MjWaa3WFE7O
	j4CBX01u1ZH45ZbhTOMeGXIJMFSnzX3L8EkXP+SVnFb8ger/vx/on80PI08/sVx/Gr2woN0KYhD
	1KdxtRZx5ehWFnaUm4hXckksnwJSNsPO3FwGl7KULTUZaoENAk3JkiLqO5AWdI6QK2KLYJ4Wt4K
	RhoZP/s1PP+ZjUOUyah5oJRJSoiV5uasY6pU3Thrdp/WICfoKaVfO9imIVkY4IRgtUBe/zDRuZm
	v/65nlUM60vgbKjxM/PsS3YhhNQMV2Pb4hHD5ksqJ39yCj0oCCO8CCKdOIwbl2krNHzlAk+PXHf
	xQ+Em6faCVEnWQXUuh1aiXsDpCSq+AYpXNO4RYRjTPCB1eknzICzqY0Ryj2NiAiTjI38u85fPaI
	I5DJmmKLXAhuTqQK24Wwv7p49eiT5BRx/mYdB5sCKCCM0FXEw==
X-Received: by 2002:a5d:588b:0:b0:44a:47a4:ce91 with SMTP id ffacd0b85a97d-4515cf11cdemr32479350f8f.25.1778405415929;
        Sun, 10 May 2026 02:30:15 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm16802617f8f.20.2026.05.10.02.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 02:30:15 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Sun, 10 May 2026 10:30:09 +0100
To: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
Message-ID: <zvulxrrvg4sf7m5pjfpfucg7yssgallfu6zi6mcyblu2qy24hn@wdzs7h77vkoz>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
 <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>

On 26/05/09 06:42PM, David Lechner wrote:
> On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Add documentation for the AD9910 DDS IIO driver, which describes channels,
> > DDS modes, attributes and ABI usage examples.

...

> > +Channel hierarchy
> > +=================
> > +
> > +The driver exposes the following IIO output channels, each identified by a
> > +unique channel number and a human-readable label:
> > +
> 
> Can we format this as a table with a header to make it clear what each item is?
> I'm guessing that the second `` is the label?
> 
> And perhaps provide a link to the sections below that describe the common attributes
> of each channel type?

Yes, that is a label. A table is better indeed.
 
> > +* ``out_altvoltage100``: ``phy``: Physical output: system clock and profile control
> 
> Any attributes on this one?
> 
> > +
> > +  * ``out_altvoltage101``: ``profile[0]``: Single tone control for profile 0:
> 
> Why not just ``profile0``?
> 
> Also, why not ``out_altvoltage110`` so that the last digit matches the profile
> index? It looks like we are skipping by 10s later anyway.

Yeah, that can be done. I thought of out_altvoltage110 being a channel to hold common
things between profiles, but it ended up empty so I left the spot as a placeholder.

> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage102``: ``profile[1]``: Single tone control for profile 1:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage103``: ``profile[2]``: Single tone control for profile 2:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage104``: ``profile[3]``: Single tone control for profile 3:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage105``: ``profile[4]``: Single tone control for profile 4:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage106``: ``profile[5]``: Single tone control for profile 5:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage107``: ``profile[6]``: Single tone control for profile 6:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage108``: ``profile[7]``: Single tone control for profile 7:
> > +    frequency, phase, amplitude
> > +
> > +  * ``out_altvoltage110``: ``parallel_port``: Parallel port modulation channel
> 
> I guess no attributes on this one yet since implementation is deferred?

Only basic knobs will be exposed, proper implementation will come with a later backend
support.

> > +
> > +  * ``out_altvoltage120``: ``digital_ramp_generator``: DRG control: enable
> > +
> > +    * ``out_altvoltage121``: ``digital_ramp_up``: DRG ramp-up parameters:
> > +      dwell enable, limits, rate of change, ramp rate
> > +    * ``out_altvoltage122``: ``digital_ramp_down``: DRG ramp-down parameters:
> > +      dwell enable, limits, rate of change, ramp rate
> 
> Oh, I guess these are just the general "control knob" name, not the actual
> sysfs attribute name.

Correct, just a description.

> 
> > +
> > +  * ``out_altvoltage130``: ``ram_control``: RAM playback: enable, frequency,
> > +    phase and sampling frequency for active profile. Other configurations are
> > +    provided through a firmware upload interface.
> > +
> > +  * ``out_altvoltage150``: ``output_shift_keying``: OSK: enable, amplitude
> > +    scale, ramp rate, rate of change control
> > +
> > +The ``phy`` channel is the root of the hierarchy. Changing its
> > +``sampling_frequency`` reconfigures the system clock (SYSCLK) which affects all
> > +other channels.
> > +
> > +Most of the mode-specific channels (single-tone, DRG, RAM, OSK) have an
> > +``enable`` attribute that turns the mode on/off.
> > +

...

> > +Parallel Port mode
> > +------------------
> > +
> > +The parallel port allows real-time modulation of DDS parameters through a
> > +16-bit external data bus.
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``frequency_scale``
> > +     - power-of-2
> > +     - FM gain multiplier applied to 16-bit parallel input. Range :math:`[1, 32768]`,
> 
> General comment for the whole doc. Can you spell out the acronyms the
> first time they are used for us noobs.
> 
> > +       must be a power of 2.
> > +
> > +   * - ``frequency_offset``
> > +     - Hz
> > +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
> > +
> > +   * - ``phase_offset``
> > +     - rad
> > +     - Base phase for polar modulation. Lower 8 bits of POW register.
> > +       Range :math:`[0, 2\pi/256)`.
> > +
> > +   * - ``scale_offset``
> > +     - fractional
> > +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
> > +       Range :math:`[0, 1/256)`.
> > +
> 
> I guess there was some discussion on these attributes. I see some of these in the
> ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
> me from the documentation here what they actually do though. I guess they are
> just basic transformations on the input signal?

Not sure how the ABI is not clear:

	For a channel that allows amplitude control through buffers, this
	represents the value for a base amplitude scale. The actual output
	amplitude scale is a result with the sum of this value.

So yes, it is a basic transformation.

> 
> And a practical note, they should be "frequencyscale". I don't like that it is
> harder to read, but it is easier for a machine to parse.

Parsers like the ones in libiio is not having problems with that.

> > +Usage examples
> > +^^^^^^^^^^^^^^
> > +
> > +Set parallel port frequency modulation with a scale of 16 and a 50 MHz
> > +offset:
> > +
> > +.. code-block:: bash
> > +
> > +  echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_scale
> > +  echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_offset
> > +
> > +Digital ramp generator (DRG)
> > +----------------------------
> > +
> > +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> > +hardware. It is controlled through three channels: a parent control channel
> > +(``digital_ramp_generator``) and two child ramp channels
> > +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> > +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
> > +sets the destination to frequency.
> 
> Would it be better to say that the destination is set when the the
> value is non-zero? Otherwise, how would one change the destination
> once set?

Destination is only one, so you just need to write phase or phase_roc, if you want
to target phase then. Does that not sound intuitive?

Zero is a valid value to be written.

> 
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
> > +   * - ``dwell_en``
> > +     - boolean
> > +     - Enable dwell at the ramp limit. When disabled, the ramp auto-transitions
> > +       at this limit without waiting for the DRCTL pin. Disabling both creates a
> > +       bidirectional continuous ramp (Triangular pattern). Other configurations
> > +       create a single-shot ramp at the transition of the DRCTL pin: ramp-up
> > +       only, ramp-down only or bidirectional with dwell at the limits.
> > +
> > +   * - ``frequency``
> > +     - Hz
> > +     - Frequency ramp limit. Range: :math:`[0, f_{SYSCLK}/2)`. Writing a value
> > +       sets the ramp destination to frequency. Reading back returns the
> > +       currently active frequency limit or -EBUSY if other destination is
> > +       active (phase or amplitude).
> > +
> > +   * - ``phase``
> > +     - rad
> > +     - Phase ramp limit. Range: :math:`[0, 2\pi)`. Writing a value sets the
> > +       ramp destination to phase. Reading back returns the currently active
> > +       phase limit or -EBUSY if other destination is active (frequency or
> > +       amplitude).
> > +
> > +   * - ``scale``
> > +     - fractional
> > +     - Amplitude scale ramp limit. Range: :math:`[0, 1)`. Writing a value sets
> > +       the ramp destination to amplitude. Reading back returns the currently
> > +       active scale limit or -EBUSY if other destination is active (frequency
> > +       or phase).
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - Ramp clock rate. It is controlled by an integer divider so the requested
> > +       value will adjust to nearest supported value.
> > +
> > +   * - ``frequency_roc``
> > +     - Hz/s
> > +     - Frequency rate of change. Sets the per-tick frequency increment/decrement
> > +       based on the current ramp clock rate.
> > +
> > +   * - ``phase_roc``
> > +     - rad/s
> > +     - Phase rate of change. Sets the per-tick phase increment/decrement based
> > +       on the current ramp clock rate.
> > +
> > +   * - ``scale_roc``
> > +     - 1/s
> > +     - Amplitude scale rate of change. Sets the per-tick amplitude scale
> > +       increment/decrement based on the current ramp clock rate.
> > +
> > +Usage examples
> > +^^^^^^^^^^^^^^
> > +
> > +Configure a frequency sweep from 40 MHz to 60 MHz with a rate of change of
> > +25 GHz/s:
> > +
> > +.. code-block:: bash
> > +
> > +  # Disable dwell on both limits for a bidirectional continuous ramp
> > +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_dwell_en
> > +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_dwell_en
> > +
> > +  # Set ramp limits
> > +  echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> > +  echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> > +
> > +  # Set ramp rate
> > +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> > +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> > +
> > +  # Set frequency rate of change (Hz/s)
> > +  echo 25000000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_roc
> > +  echo 25000000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_roc
> > +
> > +  # Enable the DRG
> > +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
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
> > +
> > +   * - ``frequency``
> > +     - Hz
> > +     - Frequency tuning word used as the single tone frequency when
> > +       RAM destination is not ``frequency``. Range: :math:`[0, f_{SYSCLK}/2)`.
> > +
> > +   * - ``phase``
> > +     - rad
> > +     - Phase offset word used as the single tone phase when RAM destination
> > +       is not ``phase``. Range: :math:`[0, 2\pi)`.
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - RAM playback step rate of the active profile, which controls how fast the
> > +       address counter advances. It is controlled by an integer divider so the
> > +       requested value will adjust to nearest supported value.
> > +
> > +Loading RAM data
> > +^^^^^^^^^^^^^^^^
> > +
> > +RAM data is loaded through the firmware upload framework. The driver registers
> > +a firmware upload sysfs entry named ``iio_deviceX:ram``. The FW data follows
> > +a simple binary format:
> > +
> > +- 80-byte header:
> > +
> > +  - 4-byte big-endian magic word: 0x00AD9910;
> > +  - 4-byte big-endian CFR1 value: configuration for the CFR1 register. Only
> > +    bits relevant to RAM mode (data destination and internal profile control)
> > +    are considered. Other bits are ignored and have no effect:
> > +
> > +    - Bits [30:29]: RAM data destination:
> > +
> > +      - 00: frequency;
> > +      - 01: phase;
> > +      - 10: amplitude;
> > +      - 11: polar;
> > +
> > +    - Bits [20:17]: Internal profile control (see Table 14 of the datasheet);
> > +
> > +  - 8 sets of 8-byte big-endian profile data for profiles 0-7. Each set contains:
> > +
> > +    - Bits [55:40]: Address step rate value;
> > +    - Bits [39:30]: End address for the profile;
> > +    - Bits [23:14]: Start address for the profile;
> > +    - Bit [5]: no-dwell high for ramp-up mode;
> > +    - Bit [3]: zero-crossing for direct-switch mode;
> > +    - Bits [2:0]: operating mode:
> > +
> > +      - 000: direct switch;
> > +      - 001: ramp-up;
> > +      - 010: bidirectional;
> > +      - 011: bidirectional continuous;
> > +      - 100: ramp-up continuous;
> > +
> > +  - 4-byte big-endian reserved word: set to 0;
> 
> Will it be enough? :-)
> 
> Another option could be to include a file format version field.

Yeah, maybe a CRC and a version as you pointed out. In terms of RAM functionality,
that would be all. Maybe a table for this one too...

> > +  - 4-byte big-endian word count: number of 32-bit words to be loaded (0-1024);
> > +
> > +- Followed by the specified number of 32-bit big-endian data words.
> > +
> > +Usage examples
> > +^^^^^^^^^^^^^^
> > +
> > +Configure RAM mode with firmware data and enable it:
> > +
> > +.. code-block:: bash
> > +
> > +  # Load RAM data via firmware upload
> > +  echo 1 > /sys/class/firmware/iio\:device0\:ram/loading
> > +  cat ad9910-ram.bin > /sys/class/firmware/iio\:device0\:ram/data
> > +  echo 0 > /sys/class/firmware/iio\:device0\:ram/loading
> > +
> > +  # Enable RAM mode
> > +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage130_en
> > +

...

> > +Physical channel
> > +================
> > +
> > +The ``phy`` channel provides device-level control:
> > +
> > +.. flat-table::
> > +   :header-rows: 1
> > +
> > +   * - Attribute
> > +     - Unit
> > +     - Description
> > +
> > +   * - ``sampling_frequency``
> > +     - Hz
> > +     - System clock (SYSCLK) frequency. With PLL enabled, configures the PLL
> > +       multiplier (range 420-1000 MHz). Without PLL, ref clock can only be
> > +       divided by 2.
> 
> What controls the PLL?

It gets enabled in the device-tree. One would want that when feeding a lower clock rate
source as a reference clock. It would also need a loop-filter connected to the device.

This property can be used to configure the desired sysclk frequency, the PLL divider/multiplier
and VCO configs will be derived from that. 

> > +
> > +   * - ``powerdown``
> > +     - boolean (0 or 1)
> > +     - Software power-down. Writing 1 powers down the digital core, DAC,
> > +       reference clock input and auxiliary DAC simultaneously.
> > +

...

> 
> I like the direction this is going. Looks sensible to me.
> 
> I didn't have time to read the code, so just going off of the docs for now.

Thanks for the review. The code would need some cleanup after the ABI is mature.
Also, sashiko is pointing out a lot of issues already.. so those I suppose I can
handle on my own for now. 

-- 
Kind regards,

Rodrigo Alencar
