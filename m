Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6B01D516C;
	Sun, 22 Mar 2026 17:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774200189; cv=none; b=LajntVJmALZpV+cu/W6oMHVdS+Cuus7E2WvDG7ga/MbLfAuS7AP1+v6TBLdfTrB96zLVYfBu7y18oBB/onvr3NBD+3ppzr9xhA9GUaUu0RQUylsLH8WMXjqXGm8Q3UbGF0j0qlTLVn2am83AdxH5gQDSrCZ37uU1CTRpZbUAyUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774200189; c=relaxed/simple;
	bh=+G51Z5ohTUqZo8vVbJfaEitukk1enAHhY/Zv6Alq23c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saZiscFIoNOGseaj20BZPqeaoD0eIOdLSKaPp6IbryaaO7JALjGzF/VPXSHzEzdyH+1azDoqXRSm+vum+r39rx3E/x1y3oDwvToGUHioQCmpoQNLBjb27vHeIcOrQmR4fH2r++SBBDQzARJ0S8VlpR/ojicW52CsOUMgfT+XvOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QG7sOEnx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QG7sOEnx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD24C19424;
	Sun, 22 Mar 2026 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774200188;
	bh=+G51Z5ohTUqZo8vVbJfaEitukk1enAHhY/Zv6Alq23c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QG7sOEnx3rqAALcXLB8Df08ubULYbrCgw9efPj58in23+7YHLnsOTF9BQrwxvPfMQ
	 adkI37BewLtR9Ub+/ju/XNelRKxdY6oHAdjpp4mw3khdZ8RjnHvt29Updh8WcudUD0
	 sPwGmgL8vLTz0oe7k9o4qmqoS++ftRJ0rPTRRuz1cWjIyorLY7aKW67/0sZK4xPk0h
	 zEk2NLjmbhi9/b1iP7/lKHUsYS+e6O3mg0mjEwJeNdoDctEGtJBLOdXsPwmkP4avKs
	 RsP5Rn89zEYVC92yoXptI9bAWGrnwAQBytLgYo8pywzyGBvv1ZFnAlpbd0qXeYIZgY
	 GHvOYXHzznuXA==
Date: Sun, 22 Mar 2026 17:22:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Jonathan
 Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 8/9] Documentation: ABI: testing: add docs for
 ad9910 sysfs entries
Message-ID: <20260322172257.1681de69@jic23-huawei>
In-Reply-To: <20260318-ad9910-iio-driver-v2-8-e79f93becf11@analog.com>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
	<20260318-ad9910-iio-driver-v2-8-e79f93becf11@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 18 Mar 2026 17:56:08 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add ABI documentation file for the DDS AD9910 with sysfs entries to
> control Parallel Port, Digital Ramp Generator, RAM and OSK parameters.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
Thanks for writing this up.  Let's see how others view it. There is a lot
going on here!  My main comment has been around trying to write the
docs as a generic thing rather than focusing on device details.

Jonathan

>  .../ABI/testing/sysfs-bus-iio-frequency-ad9910     | 182 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 183 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
> new file mode 100644
> index 000000000000..120de494f6b1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
> @@ -0,0 +1,182 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_profile
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the active profile index [0, 7] from/to the physical
> +		channel. The AD9910 supports 8 profiles, each storing a complete
> +		set of single tone (frequency, phase, amplitude) and RAM playback
> +		parameters.

This one is interesting.  Can we treat them as symbols that we are picking
between?  We have similar DAC ABIs for that already.

Is this picking between them for purposes of configuration or setting which one is
in being output currently?

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the parallel port frequency offset in Hz. This is the
> +		base frequency tuning word (FTW register) to which the scaled
> +		parallel port data is added during parallel data port modulation.
> +		Valid range is [0, SYSCLK/2).

Ideally think about how these controls generalize (if they do) and avoid
device specific descriptions.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_scale
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the parallel port frequency modulation gain. The value
> +		must be a power of 2 in the [1, 2^15] range. This value scales the
> +		16-bit parallel data port input before adding it to the
> +		frequency_offset value.

Can we provide an _available for this with all 16 values?  Then avoid the specific
device nature of the documentation instead saying see the _available for what is possible.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the parallel port phase offset in radians. Valid range
> +		is [0, 2*pi/256). This sets the lower 8 bits of the phase offset
> +		word (POW register) used as a base during parallel port polar
> +		modulation.

Given it does full phase shift, I don't think for userspace docs we care about the 8
bits of whatever register.  

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_offset
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the parallel port amplitude scale offset. Valid range
> +		is [0, 1/256). This sets the lower 6 bits of the amplitude scale
> +		factor (ASF register) used as a base during parallel port polar
> +		modulation.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_destination
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the digital ramp generator (DRG) or the RAM control
> +		destination parameter. Determines which DDS core parameter is to
> +		be modulated when the child mode channel is enabled.
> +
> +		Available values can be read from the corresponding
> +		out_altvoltageY_destination_available attribute.
> +
> +		Valid values: "polar" (only for RAM control), "frequency", "phase"
> +		and "amplitude"

This is very device specific. Maybe we are better representing these as separate
channels each with their own controls for DRG.  No problem if changing one changes
another.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_destination_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists the available destination values for the DRG channel:
> +		"frequency phase amplitude"; or for the RAM control channel:
> +		"frequency phase amplitude polar".
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_operating_mode
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the DRG or RAM control operating mode. For the DRG
> +		channel it controls the no-dwell behavior of the ramp.
> +
> +		Available values can be read from the corresponding
> +		out_altvoltageY_operating_mode_available attribute.
> +
> +		Valid values for DRG channel:
> +
> +		  - "bidirectional": Normal ramp generation (ramp up then
> +		    down, dwelling at limits).

Some sort of trapezium wave?  Maybe this and continuous forms are combined
and we have a separate dwell time control?

> +		  - "ramp_down": No-dwell low; the ramp resets to upper
> +		    limit upon reaching the lower limit.
> +		  - "ramp_up": No-dwell high; the ramp resets to lower
> +		    limit upon reaching the upper limit.
> +		  - "bidirectional_continuous": Both no-dwell high and low;
> +		    the ramp continuously sweeps without dwelling.

Triangle wave?  bidirectional continuous is a rather confusing term so maybe
we should rethink this one.

> +
> +		Valid values for RAM control channel:
> +
> +		  - "direct_switch": start address defines fixed word to be used
> +		    by the selected profile.
> +		  - "ramp_up": One-shot ramp up through current profile's address
> +		    range.
> +		  - "bidirectional": Ramp up then down through PROFILE0 pin.

Avoid specifics like this.  Can we call external control pin or something like that?

> +		  - "bidirectional_continuous": Continuous ramp up/down
> +		    through current profile's address range.
> +		  - "ramp_up_continuous": Continuous ramp up through
> +		    current profile's address range.

I guess this goes back to start on finishing ramping up?

> +		  - "sequenced": Sequenced playback of RAM profiles up to
> +		    the active profile. Requires active profile > 0.
Is this just running through each profile one after another? (other than profile 0)?
> +		  - "sequenced_continuous": Continuous sequenced playback
> +		    of RAM profiles up to the active profile. Requires
> +		    active profile > 0.
Similar to above, maybe separate out dwell time if that's the difference between
sequenced and sequenced_continuous.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_operating_mode_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For the DRG channel it lists the available operating mode values:
> +		"bidirectional ramp_down ramp_up bidirectional_continuous".
> +
> +		For the RAM control channel it lists the available operating mode
> +		values:
> +		"direct_switch ramp_up bidirectional bidirectional_continuous
> +		ramp_up_continuous sequenced sequenced_continuous".
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency_step
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the DRG frequency step size in Hz for ramp up and ramp
> +		down DRG channels. This is the increment/decrement step applied to
> +		the DRG frequency value, which is input to the DDS core and it is
> +		updated at each ramp clock tick when the DRG destination is
> +		set to "frequency". Valid range is [0, sysclk/2).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase_step
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the DRG phase step size in radians for ramp up and ramp
> +		down DRG channels. This is the increment/decrement step applied to
> +		the DRG phase value, which is input to the DDS core and it is
> +		updated at each ramp clock tick when the DRG destination is
> +		set to "phase". Valid range is [0, 2*pi).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_scale_step
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For the DRG ramp up/down channels this is used to read/write the
> +		DRG amplitude step size, which is applied as an
> +		increment/decrement to the DRG amplitude value, input to the DDS
> +		core, updated at each ramp clock tick when the DRG destination is
> +		set to "amplitude". Valid range is [0, 1].
> +
> +		For the OSK channel this is used to read/write the automatic OSK
> +		amplitude ramp step size. Writing a	non-zero value enables
> +		automatic OSK mode and sets the amplitude step size. Writing "0"
> +		disables automatic OSK mode. The value is rounded to the nearest
> +		hardware supported step: 0.000061, 0.000122, 0.000244, or
> +		0.000488.

Those need to come from available attribute. Don't belong in the docs as if we
have them here there is little chance of generalizing later to cover more devices.

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_address_start
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the RAM start address for the active profile. Defines
> +		the first RAM word address used during playback. Cannot be
> +		changed while RAM mode is enabled. Valid range is [0, 1023].
> +		If set above the current end address, the end address is
> +		automatically adjusted to match.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_address_end
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the RAM end address for the active profile. Defines
> +		the last RAM word address used during playback. Cannot be
> +		changed while RAM mode is enabled. Valid range is
> +		[address_start, 1023].
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_pinctrl_en
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write the OSK manual external control enable. Writing '1'
> +		enables manual control of the output amplitude envelope via an
> +		external pin. Writing '0' disables it. When enabled, the OSK pin
> +		directly controls the amplitude on/off state rather than using
> +		the automatic OSK ramp.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6403439b530d..edd87ee7da5f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1635,6 +1635,7 @@ M:	Rodrigo Alencar <rodrigo.alencar@analog.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Supported
>  W:	https://ez.analog.com/linux-software-drivers
> +F:	Documentation/ABI/testing/sysfs-bus-iio-frequency-ad9910
>  F:	Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
>  F:	drivers/iio/frequency/ad9910.c
>  
> 

