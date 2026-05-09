Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12013D332A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778370157; cv=none; b=cdJED/12rZd76URVyYf38ioIjofePA/a2RZEIUOSL79F4b5Smwgsiq1mbA7L5UCi8CGwLBlmEbhpK21rmsr8h0eoriic5p9plm3cXFLqScDnLorgFLwNAFIN1cvGyU+MAS65DRxdIs2SNuFxC0W5Cj2JaVksmTUftxADmmxCKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778370157; c=relaxed/simple;
	bh=T0gDmFVgj57zNhTmFhBj+ydr1gDl5OEMABvzuiPcR6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmXOxHu8mwfXoIaoZEFePFiNI3P4c5pOoAI2egghaY8E9MWpBV15Qj1xUEyUSiE1bwCsoas2lLGdtGg3dl18rjRKFNafX2fP8EtvCU9+2NNA+wvmkoGSOLsEx3a9x3DLNUTjAqmMsgJfTzfm+ckndE1FYAoa+EcmIEZv8XMktWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=G3PNQqr5; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="G3PNQqr5"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-45f053b7b90so1917066b6e.0
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 16:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1778370152; x=1778974952; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=orayVjokWMl7WU2iKBJjwtG8NxDANQqNCDPyr5HdufQ=;
        b=G3PNQqr5Om7ySqsRp/+Z1E4KuAqllIIwNDWpuSkmZ+oSkm9lLnQfZAuBSrVWtwgJMy
         pcpghzkwZxtq/Yn7ExsDuGqDtgF0HAinuKZwkQwQQCrkTw+hgzibHmwV3eJqHbVM2mUu
         95fcYOrzvqHdCz0MlEo33aE91bWwKnDY5avw9Wt3lFLnVK+ucv1ACtGu/lKSD2qqGBUH
         tK/livGpxNjC0eRoD0HfeayAE4V17gHZZgQ04OHu7M3MpoEVA1D+Mt2SzwOsrx3jdIgk
         y5kGRZuXJSBngIXy19tvOg47gYdSjnA9L8tgjZQKdsdJLKS+SzdYWmPbDRo46LpBoKnM
         TawA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778370152; x=1778974952;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orayVjokWMl7WU2iKBJjwtG8NxDANQqNCDPyr5HdufQ=;
        b=s6KjQWdZwclAKr6/dmU9i4gMLkJ4LIrsFF2HXSWuvdf7FksQp3JEfwpLKTRyJh9iDS
         kceCJ6iBKqOjCOBpT2YcE4HspAlTU7s4g3o9ln7ODigccWNzF9uspi1VcHMYyDJP97do
         jVThZ8Q/zsAyyGsle9NZSkbwpNseSHwV8VEkcS2QAWL2GcvGDcgcZQlK+Yd2m64iYMBj
         U+ue7N1XelHjvfrJJg227oQdrdo2yNXTIiGFaalfUCOYu06Jc19DZ4Qe3Lk+eHab5+kA
         03j3Q1snUtah88StVsCA3qqLKs9xepKZSnP8/kG1luBuRR/INyDVpGcBUteqAxk709jA
         xE4Q==
X-Forwarded-Encrypted: i=1; AFNElJ995ezY9nCXmytvvyFBlEFBAfw/oIm8MmzwbktMW9ed2U0XfXcitbAlyBBYu0XXlgDO0wGQV+TrNBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA39gtEMk7J2AUYpVhobbR/fViuXs/9ef14spn3egRZbTgobFX
	JDRFfbBLzbLP5ir3tzyebeLbQzjsy6BI9NvnPdpc+3AaSD/RJWGIwKF0/Nea/HQLmRo=
X-Gm-Gg: Acq92OEpxLbDYUMmq2M5X1kUdRlW5EscoC2cJd7IAxYoRWhiBBRYFv1WkV99Cloq5Z9
	ofjDc2WiwKvo/wyS5a9lTQjgpEB1KcE8nmPGvpJG/TDIBDOkldbClGjdKYgmaWsedAhBEp/vCfV
	lfkw+/3SyEvXwafa69ahZubUvIHlqeV7IT6btxnYkCPi+XeUj4HVtyyD7V9FYbhAA14Rg2j/Hax
	UMyzNt+2ZGXu/LAo8nADInpXW1x1hc1DMLydm5PSTUt0N+OOZhX+2EGhbU8w2jt9UHGYyB+5lA8
	2Jm19XcL6VpYF4NPRFXOSAMH++BTad/JfM7moMe29Lsbl1HXkgK3jq4gaHoPZNpgQi4xJrCwaKr
	uPXA6QMCKJJXOMLUq/vhGGm4awItvWIX5bTqLHHpbuNwVs8O8Hly3eOn7AW17dEPzMntoEY2CpJ
	DNdn77f+AGKtNqGutPfZGiI5mMzWYwf909N4blPifWvulQltVmEGuV2qFMlmJ+B7P4B6HWmp0=
X-Received: by 2002:a05:6808:2f0c:b0:467:5573:3d3b with SMTP id 5614622812f47-48042589f5fmr11192034b6e.44.1778370151472;
        Sat, 09 May 2026 16:42:31 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:12a0:9178:ab4:39cc? ([2600:8803:e7e4:500:12a0:9178:ab4:39cc])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-435570ad92dsm5789660fac.2.2026.05.09.16.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 May 2026 16:42:29 -0700 (PDT)
Message-ID: <b8f9a174-f3d0-4cb8-a571-605be79165d6@baylibre.com>
Date: Sat, 9 May 2026 18:42:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v4 10/10] docs: iio: add documentation for ad9910
 driver
To: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
References: <20260508-ad9910-iio-driver-v4-0-d26bfd20ee3d@analog.com>
 <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260508-ad9910-iio-driver-v4-10-d26bfd20ee3d@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/8/26 12:00 PM, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> DDS modes, attributes and ABI usage examples.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  Documentation/iio/ad9910.rst | 607 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 609 insertions(+)
> 
> diff --git a/Documentation/iio/ad9910.rst b/Documentation/iio/ad9910.rst
> new file mode 100644
> index 000000000000..7c5dad054d5f
> --- /dev/null
> +++ b/Documentation/iio/ad9910.rst
> @@ -0,0 +1,607 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD9910 driver
> +=============
> +
> +Direct Digital Synthesizer (DDS) driver for the Analog Devices Inc. AD9910.
> +The module name is ``ad9910``.
> +
> +* `AD9910 <https://www.analog.com/en/products/ad9910.html>`_
> +
> +The AD9910 is a 1 GSPS DDS with a 14-bit DAC, controlled over SPI. The driver
> +exposes the device through the IIO ``altvoltage`` channel type and supports
> +five DDS operating modes: single tone, parallel port modulation, digital ramp
> +generation (DRG), RAM playback and output shift keying (OSK). The device has
> +8 hardware profiles, each capable of storing independent single tone and RAM
> +playback parameters.
> +
> +
> +Channel hierarchy
> +=================
> +
> +The driver exposes the following IIO output channels, each identified by a
> +unique channel number and a human-readable label:
> +

Can we format this as a table with a header to make it clear what each item is?
I'm guessing that the second `` is the label?

And perhaps provide a link to the sections below that describe the common attributes
of each channel type?

> +* ``out_altvoltage100``: ``phy``: Physical output: system clock and profile control

Any attributes on this one?

> +
> +  * ``out_altvoltage101``: ``profile[0]``: Single tone control for profile 0:

Why not just ``profile0``?

Also, why not ``out_altvoltage110`` so that the last digit matches the profile
index? It looks like we are skipping by 10s later anyway.

> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage102``: ``profile[1]``: Single tone control for profile 1:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage103``: ``profile[2]``: Single tone control for profile 2:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage104``: ``profile[3]``: Single tone control for profile 3:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage105``: ``profile[4]``: Single tone control for profile 4:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage106``: ``profile[5]``: Single tone control for profile 5:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage107``: ``profile[6]``: Single tone control for profile 6:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage108``: ``profile[7]``: Single tone control for profile 7:
> +    frequency, phase, amplitude
> +
> +  * ``out_altvoltage110``: ``parallel_port``: Parallel port modulation channel

I guess no attributes on this one yet since implementation is deferred?

> +
> +  * ``out_altvoltage120``: ``digital_ramp_generator``: DRG control: enable
> +
> +    * ``out_altvoltage121``: ``digital_ramp_up``: DRG ramp-up parameters:
> +      dwell enable, limits, rate of change, ramp rate
> +    * ``out_altvoltage122``: ``digital_ramp_down``: DRG ramp-down parameters:
> +      dwell enable, limits, rate of change, ramp rate

Oh, I guess these are just the general "control knob" name, not the actual
sysfs attribute name.

> +
> +  * ``out_altvoltage130``: ``ram_control``: RAM playback: enable, frequency,
> +    phase and sampling frequency for active profile. Other configurations are
> +    provided through a firmware upload interface.
> +
> +  * ``out_altvoltage150``: ``output_shift_keying``: OSK: enable, amplitude
> +    scale, ramp rate, rate of change control
> +
> +The ``phy`` channel is the root of the hierarchy. Changing its
> +``sampling_frequency`` reconfigures the system clock (SYSCLK) which affects all
> +other channels.
> +
> +Most of the mode-specific channels (single-tone, DRG, RAM, OSK) have an
> +``enable`` attribute that turns the mode on/off.
> +
> +DDS modes
> +=========
> +
> +The AD9910 supports multiple modes of operation that can be configured
> +independently or in combination. Such modes and their corresponding IIO channels
> +are described in this section. Each DDS core parameter (frequency, phase and
> +amplitude) value can come from different sources, but only one is active at a
> +time. This activation depends on a priority list, which is based on the enable
> +and destination configurations for such modes. The following tables are
> +extracted from the AD9910 datasheet and summarizes the control parameters for
> +each mode and their priority when multiple sources are enabled simultaneously:
> +
> +.. flat-table:: DDS Frequency Control
> +   :header-rows: 1
> +
> +   * - Priority
> +     - Data Source
> +     - Conditions
> +
> +   * - Highest Priority
> +     - RAM
> +     - RAM enabled and data destination is frequency
> +
> +   * -
> +     - DRG
> +     - DRG enabled and data destination is frequency
> +
> +   * -
> +     - Parallel data and FTW (frequency_offset)
> +     - Parallel data port enabled and data destination is frequency
> +
> +   * -
> +     - FTW register (frequency)
> +     - RAM enabled and data destination is not frequency
> +
> +   * - Lowest Priority
> +     - FTW (frequency) in single tone channel for the active profile
> +     - All other cases
> +
> +.. flat-table:: DDS Phase Control
> +   :header-rows: 1
> +
> +   * - Priority
> +     - Data Source
> +     - Conditions
> +
> +   * - Highest Priority
> +     - RAM
> +     - RAM enabled and data destination is phase or polar
> +
> +   * -
> +     - DRG
> +     - DRG enabled and data destination is phase
> +
> +   * -
> +     - Parallel data port
> +     - Parallel data port enabled and data destination is phase
> +
> +   * -
> +     - Parallel data port and POW register LSBs (phase_offset)
> +     - Parallel data port enabled and data destination is polar
> +
> +   * -
> +     - POW register (phase)
> +     - RAM enabled and destination is not phase nor polar
> +
> +   * - Lowest Priority
> +     - POW (phase) in single tone channel for the active profile
> +     - All other cases
> +
> +.. flat-table:: DDS Amplitude Control
> +   :header-rows: 1
> +
> +   * - Priority
> +     - Data Source
> +     - Conditions
> +
> +   * - Highest Priority
> +     - ASF register and OSK generator
> +     - OSK enabled
> +
> +   * -
> +     - RAM
> +     - RAM enabled and data destination is amplitude or polar
> +
> +   * -
> +     - DRG
> +     - DRG enabled and data destination is amplitude
> +
> +   * -
> +     - Parallel data port
> +     - Parallel data port enabled and data destination is amplitude
> +
> +   * -
> +     - Parallel data port and ASF register LSBs (scale_offset)
> +     - Parallel data port enabled and data destination is polar
> +
> +   * - Lowest Priority
> +     - ASF (scale) in single tone channel for the active profile
> +     - (Amplitude scale is already enabled by default)
> +
> +While debugging or testing, the debug attributes ``frequency_source``,
> +``phase_source`` and ``amplitude_source`` can be used to read the label of
> +the channel that is actively controlling the correspondent DDS parameter,
> +which reflects the priority list described above.
> +
> +Single Tone mode
> +----------------
> +
> +Single tone is the baseline operating mode. The ``profile[Y]`` channels
> +provides enable, frequency, phase and amplitude control:
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean (0 or 1)
> +     - Enable/disable profile Y. Only one profile can be active at a
> +       time. Then enabling a profile disables the current active profile.
> +       Disabling an active profile brings the device to a powered down state.
> +
> +   * - ``frequency``
> +     - Hz
> +     - Output frequency. Range :math:`[0, f_{SYSCLK}/2)`. Stored in the
> +       profile's frequency tuning word (FTW).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase offset. Range :math:`[0, 2\pi)`. Stored in the profile's phase
> +       offset word (POW).
> +
> +   * - ``scale``
> +     - fractional
> +     - Amplitude scale factor. Range :math:`[0, 1]`. Stored in the profile's
> +       amplitude scale factor (ASF).
> +
> +Profile switching is allowed while RAM mode is enabled. In that case single tone
> +parameters are stored in a shadow register and are not written to hardware until
> +RAM mode is disabled.
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Configure a 100 MHz tone in profile to 2 and set it as the active profile:
> +
> +.. code-block:: bash
> +
> +  echo 100000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_frequency
> +  echo 0.5 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_scale
> +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_phase
> +
> +  # Activate profile 2
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_en
> +
> +Read back the current single tone frequency:
> +
> +.. code-block:: bash
> +
> +  cat /sys/bus/iio/devices/iio:device0/out_altvoltage103_frequency
> +
> +Parallel Port mode
> +------------------
> +
> +The parallel port allows real-time modulation of DDS parameters through a
> +16-bit external data bus.
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``frequency_scale``
> +     - power-of-2
> +     - FM gain multiplier applied to 16-bit parallel input. Range :math:`[1, 32768]`,

General comment for the whole doc. Can you spell out the acronyms the
first time they are used for us noobs.

> +       must be a power of 2.
> +
> +   * - ``frequency_offset``
> +     - Hz
> +     - Base FTW to which scaled parallel data is added. Range :math:`[0, f_{SYSCLK}/2)`.
> +
> +   * - ``phase_offset``
> +     - rad
> +     - Base phase for polar modulation. Lower 8 bits of POW register.
> +       Range :math:`[0, 2\pi/256)`.
> +
> +   * - ``scale_offset``
> +     - fractional
> +     - Base amplitude for polar modulation. Lower 6 bits of ASF register.
> +       Range :math:`[0, 1/256)`.
> +

I guess there was some discussion on these attributes. I see some of these in the
ad9832 driver in staging, but I'm guessing they are new ABI. It isn't clear to
me from the documentation here what they actually do though. I guess they are
just basic transformations on the input signal?

And a practical note, they should be "frequencyscale". I don't like that it is
harder to read, but it is easier for a machine to parse.

> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Set parallel port frequency modulation with a scale of 16 and a 50 MHz
> +offset:
> +
> +.. code-block:: bash
> +
> +  echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_scale
> +  echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage113_frequency_offset
> +
> +Digital ramp generator (DRG)
> +----------------------------
> +
> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> +hardware. It is controlled through three channels: a parent control channel
> +(``digital_ramp_generator``) and two child ramp channels
> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_roc``
> +sets the destination to frequency.

Would it be better to say that the destination is set when the the
value is non-zero? Otherwise, how would one change the destination
once set?

> +
> +Control channel attributes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean
> +     - Enable/disable the DRG.
> +
> +Ramp channel attributes
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The ``digital_ramp_up`` and ``digital_ramp_down`` channels share the same
> +attribute set but configure ascending and descending ramp parameters
> +independently:
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``dwell_en``
> +     - boolean
> +     - Enable dwell at the ramp limit. When disabled, the ramp auto-transitions
> +       at this limit without waiting for the DRCTL pin. Disabling both creates a
> +       bidirectional continuous ramp (Triangular pattern). Other configurations
> +       create a single-shot ramp at the transition of the DRCTL pin: ramp-up
> +       only, ramp-down only or bidirectional with dwell at the limits.
> +
> +   * - ``frequency``
> +     - Hz
> +     - Frequency ramp limit. Range: :math:`[0, f_{SYSCLK}/2)`. Writing a value
> +       sets the ramp destination to frequency. Reading back returns the
> +       currently active frequency limit or -EBUSY if other destination is
> +       active (phase or amplitude).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase ramp limit. Range: :math:`[0, 2\pi)`. Writing a value sets the
> +       ramp destination to phase. Reading back returns the currently active
> +       phase limit or -EBUSY if other destination is active (frequency or
> +       amplitude).
> +
> +   * - ``scale``
> +     - fractional
> +     - Amplitude scale ramp limit. Range: :math:`[0, 1)`. Writing a value sets
> +       the ramp destination to amplitude. Reading back returns the currently
> +       active scale limit or -EBUSY if other destination is active (frequency
> +       or phase).
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - Ramp clock rate. It is controlled by an integer divider so the requested
> +       value will adjust to nearest supported value.
> +
> +   * - ``frequency_roc``
> +     - Hz/s
> +     - Frequency rate of change. Sets the per-tick frequency increment/decrement
> +       based on the current ramp clock rate.
> +
> +   * - ``phase_roc``
> +     - rad/s
> +     - Phase rate of change. Sets the per-tick phase increment/decrement based
> +       on the current ramp clock rate.
> +
> +   * - ``scale_roc``
> +     - 1/s
> +     - Amplitude scale rate of change. Sets the per-tick amplitude scale
> +       increment/decrement based on the current ramp clock rate.
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Configure a frequency sweep from 40 MHz to 60 MHz with a rate of change of
> +25 GHz/s:
> +
> +.. code-block:: bash
> +
> +  # Disable dwell on both limits for a bidirectional continuous ramp
> +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_dwell_en
> +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_dwell_en
> +
> +  # Set ramp limits
> +  echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> +  echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> +
> +  # Set ramp rate
> +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> +
> +  # Set frequency rate of change (Hz/s)
> +  echo 25000000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_roc
> +  echo 25000000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_roc
> +
> +  # Enable the DRG
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
> +
> +RAM mode
> +--------
> +
> +The AD9910 contains a 1024 x 32-bit RAM that can be loaded with waveform data
> +and played back to modulate frequency, phase, amplitude, or polar (phase +
> +amplitude) parameters.
> +
> +RAM control channel attributes
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean
> +     - Enable/disable RAM playback. Toggling swaps profile registers between
> +       single tone and RAM configurations across all 8 profiles.
> +
> +   * - ``frequency``
> +     - Hz
> +     - Frequency tuning word used as the single tone frequency when
> +       RAM destination is not ``frequency``. Range: :math:`[0, f_{SYSCLK}/2)`.
> +
> +   * - ``phase``
> +     - rad
> +     - Phase offset word used as the single tone phase when RAM destination
> +       is not ``phase``. Range: :math:`[0, 2\pi)`.
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - RAM playback step rate of the active profile, which controls how fast the
> +       address counter advances. It is controlled by an integer divider so the
> +       requested value will adjust to nearest supported value.
> +
> +Loading RAM data
> +^^^^^^^^^^^^^^^^
> +
> +RAM data is loaded through the firmware upload framework. The driver registers
> +a firmware upload sysfs entry named ``iio_deviceX:ram``. The FW data follows
> +a simple binary format:
> +
> +- 80-byte header:
> +
> +  - 4-byte big-endian magic word: 0x00AD9910;
> +  - 4-byte big-endian CFR1 value: configuration for the CFR1 register. Only
> +    bits relevant to RAM mode (data destination and internal profile control)
> +    are considered. Other bits are ignored and have no effect:
> +
> +    - Bits [30:29]: RAM data destination:
> +
> +      - 00: frequency;
> +      - 01: phase;
> +      - 10: amplitude;
> +      - 11: polar;
> +
> +    - Bits [20:17]: Internal profile control (see Table 14 of the datasheet);
> +
> +  - 8 sets of 8-byte big-endian profile data for profiles 0-7. Each set contains:
> +
> +    - Bits [55:40]: Address step rate value;
> +    - Bits [39:30]: End address for the profile;
> +    - Bits [23:14]: Start address for the profile;
> +    - Bit [5]: no-dwell high for ramp-up mode;
> +    - Bit [3]: zero-crossing for direct-switch mode;
> +    - Bits [2:0]: operating mode:
> +
> +      - 000: direct switch;
> +      - 001: ramp-up;
> +      - 010: bidirectional;
> +      - 011: bidirectional continuous;
> +      - 100: ramp-up continuous;
> +
> +  - 4-byte big-endian reserved word: set to 0;

Will it be enough? :-)

Another option could be to include a file format version field.

> +  - 4-byte big-endian word count: number of 32-bit words to be loaded (0-1024);
> +
> +- Followed by the specified number of 32-bit big-endian data words.
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Configure RAM mode with firmware data and enable it:
> +
> +.. code-block:: bash
> +
> +  # Load RAM data via firmware upload
> +  echo 1 > /sys/class/firmware/iio\:device0\:ram/loading
> +  cat ad9910-ram.bin > /sys/class/firmware/iio\:device0\:ram/data
> +  echo 0 > /sys/class/firmware/iio\:device0\:ram/loading
> +
> +  # Enable RAM mode
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage130_en
> +
> +Output Shift Keying (OSK)
> +-------------------------
> +
> +OSK controls the output amplitude envelope, allowing the output to be ramped
> +on/off rather than switched abruptly.
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``en``
> +     - boolean (0 or 1)
> +     - Enable/disable OSK.
> +
> +   * - ``scale``
> +     - fractional
> +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range: :math:`[0, 1)`.
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - OSK ramp rate. It is controlled by an integer divider so the requested
> +       value will adjust to nearest supported value.
> +

Would be more logical to to keep scale attributes together.

> +   * - ``scale_roc``
> +     - 1/s
> +     - Amplitude scale rate of change. Writing a non-zero value enables
> +       automatic OSK and selects the closest hardware step size. Writing ``0``
> +       disables automatic ramping (manual control of the ASK register using
> +       ``scale``). Writing the maximum available value enables pin-controlled
> +       immediate transition with no ramping.
> +
> +   * - ``scale_roc_available``
> +     - 1/s
> +     - Lists the available ``scale_roc`` values based on the current
> +       ``sampling_frequency``. The first value is always ``0`` (disabled) and
> +       the last value corresponds to pin-controlled immediate mode.
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Enable OSK with automatic ramping:
> +
> +.. code-block:: bash
> +
> +  # Set ramp rate
> +  echo 1000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_sampling_frequency
> +
> +  # Check available rate of change values
> +  cat /sys/bus/iio/devices/iio:device0/out_altvoltage150_scale_roc_available
> +
> +  # Enable automatic OSK with a rate of change
> +  echo 61.035000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_scale_roc
> +
> +  # Enable OSK
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_en
> +
> +Enable pin-controlled immediate OSK:
> +
> +.. code-block:: bash
> +
> +  # Read the last (highest) available value for pin-controlled mode
> +  cat /sys/bus/iio/devices/iio:device0/out_altvoltage150_scale_roc_available
> +
> +  # Enable OSK in manual mode (no rate of change)
> +  echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_scale_roc
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_en
> +
> +  # Set target amplitude to full scale
> +  echo 1.0 > /sys/bus/iio/devices/iio:device0/out_altvoltage150_scale
> +
> +Physical channel
> +================
> +
> +The ``phy`` channel provides device-level control:
> +
> +.. flat-table::
> +   :header-rows: 1
> +
> +   * - Attribute
> +     - Unit
> +     - Description
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - System clock (SYSCLK) frequency. With PLL enabled, configures the PLL
> +       multiplier (range 420-1000 MHz). Without PLL, ref clock can only be
> +       divided by 2.

What controls the PLL?

> +
> +   * - ``powerdown``
> +     - boolean (0 or 1)
> +     - Software power-down. Writing 1 powers down the digital core, DAC,
> +       reference clock input and auxiliary DAC simultaneously.
> +
> +Usage examples
> +--------------
> +
> +Set the system clock to 1 GHz:
> +
> +.. code-block:: bash
> +
> +  echo 1000000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage100_sampling_frequency
> +
> +Read current system clock frequency:
> +
> +.. code-block:: bash
> +
> +  cat /sys/bus/iio/devices/iio:device0/out_altvoltage100_sampling_frequency
> +
> +Power down the device:
> +
> +.. code-block:: bash
> +
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage100_powerdown
> diff --git a/Documentation/iio/index.rst b/Documentation/iio/index.rst
> index 007e0a1fcc5a..1ada7b460066 100644
> --- a/Documentation/iio/index.rst
> +++ b/Documentation/iio/index.rst
> @@ -30,6 +30,7 @@ Industrial I/O Kernel Drivers
>     ad7606
>     ad7625
>     ad7944
> +   ad9910
>     ade9000
>     adis16475
>     adis16480
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b52c0aae96b7..57bff3d169d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1645,6 +1645,7 @@ S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
>  F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
> +F:	Documentation/iio/ad9910.rst
>  F:	drivers/iio/frequency/ad9910.c
>  
>  ANALOG DEVICES INC MAX22007 DRIVER
> 

I like the direction this is going. Looks sensible to me.

I didn't have time to read the code, so just going off of the docs for now.


