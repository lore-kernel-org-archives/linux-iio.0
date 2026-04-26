Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15FEEBB;
	Sun, 26 Apr 2026 13:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777209020; cv=none; b=uushzJVfrbzW/snkOYvqVRKorJyulw5dEE7bFnlsRuGPIT1jnDgfHsYr+vlABsDyxso2xKmDHTVGJrhKDnBGbqOEJRanpKVWRlXZDSDeZTa7Ov+jrZnyy2/4YEwwO6ffmflFLf+DBQfHi2ELGxQtoEEkNQVwZMi4e/tWxh641hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777209020; c=relaxed/simple;
	bh=M88+FGeSHNYEn4+846epwLjqCVNm33ezLGjx3Tt8I0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UaYN48TRhk1tpaiXNO2oQOcd8GYJ1GKguvfZx35FkZQo1NWyveO/b3REGXWxzPIzHlvWlOUaWfuf7WPybzKGFfyfsMkNW87mYNo3QH0OjY42UtPpRxOryMgVkkpf7pYl2zQFZrBTE9WHF+Bne9BSHHEvEBrn1naE1bctiOxWGLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNolzSd3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNolzSd3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72443C2BCAF;
	Sun, 26 Apr 2026 13:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777209020;
	bh=M88+FGeSHNYEn4+846epwLjqCVNm33ezLGjx3Tt8I0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZNolzSd3IGDKr7yO0/6LNuZ/ekCJbQrkIRAxtef58+35D6yCy0OWfsegOGZ7D3yaC
	 qZJ/3BTgfSRw6NCwgRnXm5347RkiyptKk1VqlXLTBtDXEoHBdNlynZK4Rjjyv88Qrv
	 84aCOC70PHz6caSp94j6kqjGbqQCMVSjRLXCHDrwEWQ6KDjAhQhNOG4odU3nggGLrG
	 p8NNp7chDVJya8+YGdjjoDRNzBHnqmHM6EhgoUWIZNkn64Hcolz0PjWi+twYVMdFT3
	 H2qWNvlrC3V1ET9Uiy3uTJ7/rGtar/yX7DUXWHXqg+33hbujC1Vyr3f2lcJ7NNurFs
	 zD3pjG59/GIig==
Date: Sun, 26 Apr 2026 14:10:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
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
Message-ID: <20260426141007.345c76e4@jic23-huawei>
In-Reply-To: <20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
References: <20260417-ad9910-iio-driver-v3-0-29b93712a228@analog.com>
	<20260417-ad9910-iio-driver-v3-9-29b93712a228@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Apr 2026 09:17:38 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add documentation for the AD9910 DDS IIO driver, which describes channels,
> DDS modes, attributes and ABI usage examples.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>

Hi Rodrigo,

I think this is getting close to something workable subject to some tweaks
to not make the priority thing visible and use rate of change parameters
so /Sec rather than steps.

Given this defines the ABI for a whole class of new devices that are
rather complex, one concern is whether whatever we define here is general
enough to be useful.  

Do you have any other DDS in your queue to upstream? Maybe it's worth
sanity checking the ABI against them to see if it is fit for purpose?

Thanks,

Jonathan

> ---
>  Documentation/iio/ad9910.rst | 586 +++++++++++++++++++++++++++++++++++++++++++
>  Documentation/iio/index.rst  |   1 +
>  MAINTAINERS                  |   1 +
>  3 files changed, 588 insertions(+)
> 
> diff --git a/Documentation/iio/ad9910.rst b/Documentation/iio/ad9910.rst
> new file mode 100644
> index 000000000000..a79819b5afe5
> --- /dev/null
> +++ b/Documentation/iio/ad9910.rst
> @@ -0,0 +1,586 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +=============
> +AD9910 driver
> +=============
> +
> +DDS (Direct Digital Synthesizer) driver for the Analog Devices Inc. AD9910.
More conventional to do term then acronym.

Direct Digital Synthesizer (DDS) driver ..

> +The module name is ``ad9910``.
> +
> +* `AD9910 <https://www.analog.com/en/products/ad9910.html>`_
> +
> +The AD9910 is a 1 GSPS DDS with a 14-bit DAC, driven over SPI. The driver

Controlled maybe rather than driven?  Driven sort of implies that the SPI bus
is driving the output at 1G.

> +exposes the device through the IIO ``altvoltage`` channel type and supports
...

> +DDS modes
> +=========
> +
> +The AD9910 supports multiple modes of operation that can be configured
> +independently or in combination. Such modes and their corresponding IIO channels
> +are described in this section. The following tables are extracted from the
> +AD9910 datasheet and summarizes the control parameters for each mode and their
> +priority when multiple sources are enabled simultaneously:

Maybe add a bit on what priority means.  Does it mean that only the highest
priority one is acted on?  If so why do we need to expose that others are
enabled? Just report only the highest priority one as enabled.

I can see the hardware needs to do priority so it knows where to go when
a given source is disabled but from a software point of view that
can be controlled by us enabling that next item (and the driver does
things in the right order to get the appropriate transition)

That may mean that if all modes are disabled, we have to disable any output
but seems doable.

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
> +     - FTW (frequency)
> +     - RAM enabled and data destination is not frequency
> +
> +   * -
> +     - FTW (frequency) in single tone channel for the active profile
> +     - DRG enabled and data destination is not frequency
> +
> +   * -
> +     - FTW (frequency) in single tone channel for the active profile
> +     - Parallel data port enabled and data destination is not frequency
> +
> +   * - Lowest Priority
> +     - FTW (frequency) in single tone channel for the active profile
> +     - None

> +
> +Single tone mode
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
> +     - boolean
> +     - Enable/disable profile Y. Only one profile can be active at a
> +       time. Then enabling a profile disables the current active profile.
> +       Disabling an active profile enables the next profile in ascending order,
> +       wrapping around from 7 to 0.

That passing on to the next one seems rather non user friendly.  Can we just
disable the whole unit under those conditions instead?  As above that may mean
turning of the output entirely.  So to change mode it would always be transition
to the one that is enabled.  A disable of a given channel results in no output.


> +
> +   * - ``frequency``
> +     - Hz
> +     - Output frequency. Range [0, SYSCLK/2). Stored in the profile's frequency
> +       tuning word (FTW).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase offset. Range [0, 2*pi). Stored in the profile's phase offset word
> +       (POW).
> +
> +   * - ``scale``
> +     - fractional
> +     - Amplitude scale factor. Range [0, 1]. Stored in the profile's amplitude
> +       scale factor (ASF).
> +
> +Profile switching is allowed while RAM mode is enabled. In that case single tone
> +parameters are stored in a shadow register and are not written to hardware until
> +RAM mode is disabled.

This is only visible to userspace because of the priority thing?  If we hide
that away to transition from RAM to this mode would just mean enabling this mode.

> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Set the active profile to 2 and configure a 100 MHz tone:
> +
> +.. code-block:: bash
> +
> +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_en
> +	echo 100000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_frequency
> +	echo 0.5 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_scale
> +	echo 0 > /sys/bus/iio/devices/iio:device0/out_altvoltage103_phase

I'd expect to set frequency scale and phase before moving to the tone. Other wise
we get random garbage until those are set.  So probably reorder the example.
Fine to say you can also modify them live, but that isn't the most common thing
to do.
> +
> +Read back the current single tone frequency:
> +
> +.. code-block:: bash
> +
> +	cat /sys/bus/iio/devices/iio:device0/out_altvoltage103_frequency
> +
> +Parallel port mode
> +------------------
> +

...

> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Enable parallel port with a frequency scale of 16 and a 50 MHz offset:
> +
> +.. code-block:: bash
> +
> +	echo 16 > /sys/bus/iio/devices/iio:device0/out_altvoltage110_frequency_scale
> +	echo 50000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage110_frequency_offset
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage110_en
Odd indent.

> +
> +Digital ramp generator (DRG)
> +----------------------------
> +
> +The DRG produces linear frequency, phase or amplitude sweeps using dedicated
> +hardware. It is controlled through three channels: a parent control channel
> +(``digital_ramp_generator``) and two child ramp channels
> +(``digital_ramp_up``, ``digital_ramp_down``). DRG destination is set when
> +ramp attributes are written, i.e. writing to ``frequency`` or ``frequency_step``
> +sets the destination to frequency.
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
> +   * - ``en``
> +     - boolean
> +     - Enable/disable the ramp no-dwell behavior. Enabling both creates a
> +       bidirectional continuous ramp (Triangular pattern). Other configurations
> +       creates a single-shot ramp at the trasition of the DRCTL pin: ramp-up

transition

> +       only, ramp-down only or bidirectional with dwell at the limits.

Feels a little unintuitive to use the generic enable for this.
We might need a specific control for this one. 

> +
> +   * - ``frequency``
> +     - Hz
> +     - Frequency ramp limit. Range [0, SYSCLK/2).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase ramp limit. Range [0, 2*pi).
> +
> +   * - ``scale``
> +     - fractional
> +     - Amplitude scale ramp limit. Range [0, 1).
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - Ramp clock rate: SYSCLK / (4 * divider).
> +
> +   * - ``frequency_step``
> +     - Hz
> +     - Per-tick frequency increment/decrement. Range [0, SYSCLK/2).

So this was the bit I referred to earlier.  Normally we do
rate of change measurements for this stuff rather than what happens on
each tick (based on how we handle things like ROC events)

So could we make these
	``frequency_roc`` units HZ/Sec
etc?  Then from the mix configured would need to work out the optimum
tick to deliver it.

I suppose it's possible that someone might want a stepped frequency
though which would break this approach?  Does anyone actually do that?
If so we'd need to keep the samping_frequency but then control _roc
with that in mind.


> +
> +   * - ``phase_step``
> +     - rad
> +     - Per-tick phase increment/decrement. Range [0, 2*pi).
> +
> +   * - ``scale_step``
> +     - fractional
> +     - Per-tick amplitude scale increment/decrement. Range [0, 1).
> +
> +Usage examples
> +^^^^^^^^^^^^^^
> +
> +Configure a frequency sweep from 40 MHz to 60 MHz at a 1 kHz step:
> +
> +.. code-block:: bash
> +
> +	# Enable both no-dwell modes for a bidirectional ramp
> +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_en
> +  echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_en

Fix indents as mix of tabs and spaces.  As above I think using this enable
for no dwell is not going to generalize well.  I think we need new ABI for this
though I'm open to anyone suggesting something we can reuse.

> +
> +	# Set ramp limits
> +	echo 60000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency
> +	echo 40000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency
> +
> +	# Set ramp step size to 1 kHz
> +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_frequency_step
> +	echo 1000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_frequency_step
> +
> +	# Set ramp rate at 25 MHz
> +	echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage121_sampling_frequency
> +  echo 25000000 > /sys/bus/iio/devices/iio:device0/out_altvoltage122_sampling_frequency
> +
> +	# Enable the DRG
> +	echo 1 > /sys/bus/iio/devices/iio:device0/out_altvoltage120_en
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

So this might be a fly in the ointment of my previous comment about using
enable of profile to turn off ram.  I guess disabling RAM drops into the
matched number tone profile?  That's a pain but not disastrous. We'd have
to only allow transitions by enabling the match number tone profile.

So transitions allowed would be

	tone_profileX -> ram_profileX
	tone_profileX -> tone_profileY
	ram_profileX -> tone_profileX
	ram_profileX -> ram_profileY

But not
	tone_profileX -> ram_profileY
where X!=Y

> +
> +   * - ``frequency``
> +     - Hz
> +     - Frequency tuning word used as the single tone frequency when
> +       RAM destination is not ``frequency``. Range [0, SYSCLK/2).
> +
> +   * - ``phase``
> +     - rad
> +     - Phase offset word used as the single tone phase when RAM destination
> +       is not ``phase``. Range [0, 2*pi).
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - RAM playback step rate of the active profile, which controls how fast the
> +       address counter advances: SYSCLK / (4 * step_rate).

Why do we care what the sysclk relationship is? It's ticking in HZ.

> +
> +Output shift keying (OSK)
This is a new one on me... 
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
> +     - boolean
> +     - Enable/disable OSK.
> +
> +   * - ``scale``
> +     - fractional
> +     - Target amplitude for the OSK ramp. 14-bit ASF field. Range [0, 1).
> +
> +   * - ``sampling_frequency``
> +     - Hz
> +     - OSK ramp rate: SYSCLK / (4 * divider).
> +
> +   * - ``pinctrl_en``
> +     - boolean
> +     - Enable manual external pin control. When enabled, the OSK pin directly
> +       gates the output on/off instead of using the automatic ramp.

I wonder if we should split the various OSK modes into different channels given
only some properties apply to each of automatic and manual modes. Also I think
automatic mode is meaningless without pinctrl_en (so that can be replaced
by simply enabling that mode).  I have no idea if anyone cares about pin ctrl
with manual mode or not?  That one seems even more odd.

> +
> +   * - ``scale_step``
> +     - fractional
> +     - Automatic OSK amplitude step. Writing non-zero enables automatic OSK
> +       and sets the per-tick increment. Writing ``0`` disables it. Rounded to
> +       nearest hardware step: 0.000061, 0.000122, 0.000244 or 0.000488.

Similar thing about rate of change of amplitude fitting better with current ABI
than step does.

...


