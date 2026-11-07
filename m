Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794018014;
	b=xDkMspi6R1St7hN6g3HUByLt99hxmprgfWaFUc6UzFuCdd/WM5gFMUypR5e+pNtcVbEc
	 krjIgFJDbaOQ2V2e02jqYt71bUXNsiUvdJUU0vSVfgBr+FvD/fxckeDSd9MIMtwShe2Dj
	 /aS7aMzMbhFflD72BsuwsRUTiu9hZ3f71XaP1fSRzWIuS+AFPNLVTf6zoysMEYLSpPHMs
	 NANFfNS3NpryNw4FI7Euhfw6baApVMpq/ZYHIDK3exGqzHQc/F+y9J8OfRP+jpGQR3dSl
	 O41OJtIkNh/rhBFlNNiRVI40r+ndyN0hpnJEWkRmRoxwDd/l4h0k13fvfPOTaXbJLgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794018014;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=TgK14/J0hc7f9pjW58cAEHgo2XlbV/wSbtMpBuqYx0U=;
	b=cXnw6ZxwMowhDHx6DwglmQn/uUPYIwP+eaKK/plHHJ4h5Zdnp03ucHlLnK6jJk+RZszJ
	 3P+COGoD+0H+aEqJdLGlt6L5Boxs+wAdSEeNAjIyiOEuLOB+4HBZLsgMbqkjIIso8d5Vw
	 fxQvKZMR8f47w0ii3/putNXCld3bWXL0+0rgm6HdmxeNL9JLhOhOSNnvpAiPlp6b5WXkN
	 DFsFhz2aFiQ9Pi6fyWc9zdSCRRsCd3IZwFqZyCYVW/GV6fumNc/S8X/RTf4CI1X+2zzch
	 456/VfP+z17wFlQB9ALwI1mBvkWSkX+IwvLRziv56CLOEpAdNzu36SfmbOzACvX2HEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGEFlYBW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6D5606A326;
	Sat,  7 Nov 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UGEFlYBW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2FD1F008A1;
	Sat,  7 Nov 2026 02:20:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794018014;
	bh=TgK14/J0hc7f9pjW58cAEHgo2XlbV/wSbtMpBuqYx0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UGEFlYBWiMU2fefFx9xYAhQ99RD+olaFvSZLJ1up4np56wTQ/IhLJ0SHrz5yS5ZjR
	 0j+kNKhOO06HyUU50BFnESHF63ojblixYjcBRDlPxm8O6bm3ZN2ZlFKl06pHAAgQeM
	 KRS8OMEt6EoAjLaZGHhP4MhRLXQF7rUTsm7eGnb2DgVwwbCRXQ22wuvuzQtexlkgmi
	 i5XVF8ROuKU/UnjNS0oYbL3qCW2+iC58Z/e9YvZ8d6NPmSRMnz15kt4+qyBwJmeV3B
	 RBZ34wFF57nBNscQhYEG91Vz8vOmFjCuAwuftn98GyihUnb19E4JQK8KPO4kuebqey
	 3phlMSEzCHdVw==
Date: Sat, 7 Nov 2026 02:20:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Rob
 Herring <robh@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Michael Hennerich <michael.hennerich@analog.com>, Trevor Gamblin
 <tgamblin@baylibre.com>, Joshua Crofts <crofts@kernel.org>, Sergiu
 Cuciurean <sergiu.cuciurean@analog.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 7/7] iio: adc: ad7625: add LTC2387 and ADAQ2387x
 support
Message-ID: <20261107022006.32b72f38@jic23-hlaptop>
In-Reply-To: <20261106160529.876251-8-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261106160529.876251-8-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 18:05:19 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> 
> Add the LTC2387-16, LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 as chip
> data of this driver. The same two PWMs and IIO backend read them. Chip data
PWMs don't tend to read anything. Rephrase as something like 

"The same two PWMs and IIO backend are used to read from them."

> and a few quirks cover the differences, see the binding patch for the list:
The 'quirks' here concerns me.  We want everything to be covered
by chip data even if some of it is 'apply quirk' :)
> 
> - Data is output at double data rate on one or two lanes, so the CLK burst
>   is the number of bits divided by 2 or 4 pulses long.
> - The burst of one conversion starts at least t_FIRSTCLK after its CNV and
>   ends at most t_LASTCLK after the next CNV, so at the maximum rate it runs
>   into the next conversion period.
> - No EN pins.
> - The ADAQ parts divide the scale by the gain of their front end.
> 
> Changes:
> 
> - Add chip info for the five parts, maximum sampling frequency 15 MSPS,
>   plus OF and platform device ID entries.
> - Add struct ad7625_ddr_timing with t_CNVH, t_FIRSTCLK and t_LASTCLK. The
>   chip info of the new parts points to it, and a non-NULL pointer marks a
>   part with DDR output.
> - Add ad7625_set_sampling_freq_ddr(). Unlike the AD762x and AD796x, the
>   sampling period rises until the CLK burst fits t_LASTCLK, so the period
>   clamp doesn't limit the maximum rate to 10 MSPS.
> - Build waveforms in whole PWM steps, read with
>   pwm_get_waveform_step_might_sleep() at probe and on each sampling
>   frequency change.
> - Get the second PWM as "clk" for the new parts and "clk_gate" for the
>   existing ones. No reference clock for the new parts, as the step gives
>   the PWM clock rate.
> - Add ad7625_parse_ddr() reading adi,use-two-lanes and adi,gain-milli. Gain
>   defaults to the fixed ADAQ23875 gain and to 1 for the LTC2387. It is
>   required for the ADAQ23876 and ADAQ23878, whose gain is pin strapped, and
>   must be a supported value.
> - Divide the scale by the front end gain for the new parts.
> - Enable the supplies of the new parts, with VS- of the ADAQ modules
>   optional as it can be tied to ground. Read the optional ref-supply and
>   use the internal reference when it is absent.
> - Set the backend number of lanes for the new parts. Skipping is allowed
>   only if the backend can't set it and one lane is used.
> - Limit the default sampling frequency of the new parts to the PWM clock
>   rate.
> - Skip the EN pin mode setup for the new parts, as they have no EN pins.
> - Include math64.h, minmax.h, property.h and types.h for the new code.
> - Add the new parts, sorted by part number, to the Kconfig help and
>   Documentation/iio/ad7625.rst.
> - Make the Kconfig prompt, the top comment of the driver and
>   MODULE_DESCRIPTION() generic, as the driver supports more than the
>   AD7625.
> - Add new maintainer entries.

That is a massive list that is more or less describing the patch.  Trim
it down to just those bits that are non obvious or need to be highlighted.
No need to mention everything.  I'm going to guess perhaps an LLM was involved?
If so they need poking to avoid doing this sort of list.

> 
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
> ---
>  Documentation/iio/ad7625.rst |  34 +++-
>  MAINTAINERS                  |   2 +
>  drivers/iio/adc/Kconfig      |   7 +-
>  drivers/iio/adc/ad7625.c     | 358 ++++++++++++++++++++++++++++++++++-
>  4 files changed, 392 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/iio/ad7625.rst b/Documentation/iio/ad7625.rst
> index 61761e3b75c3..d37420b76d4b 100644
> --- a/Documentation/iio/ad7625.rst
> +++ b/Documentation/iio/ad7625.rst
> @@ -4,8 +4,9 @@
>  AD7625 driver
>  ====================
>  
> -ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, and AD7961
> -devices. The module name is ``ad7625``.
> +ADC driver for Analog Devices Inc. AD7625, AD7626, AD7960, AD7961, LTC2387-16,
> +LTC2387-18, ADAQ23875, ADAQ23876 and ADAQ23878 devices. The module name is
> +``ad7625``.

The next section says what is supproted. I'd be tempted to avoid
repeating that here in a fashion that is churn heavy.  Use something like
'and fairly similar' to avoid naming more than the one the driver is named after.

>  
>  Supported devices
>  =================
> @@ -16,8 +17,14 @@ The following chips are supported by this driver:
>  * `AD7626 <https://www.analog.com/AD7626>`_
>  * `AD7960 <https://www.analog.com/AD7960>`_
>  * `AD7961 <https://www.analog.com/AD7961>`_
> +* `ADAQ23875 <https://www.analog.com/ADAQ23875>`_
> +* `ADAQ23876 <https://www.analog.com/ADAQ23876>`_
> +* `ADAQ23878 <https://www.analog.com/ADAQ23878>`_
> +* `LTC2387-16 <https://www.analog.com/LTC2387-16>`_
> +* `LTC2387-18 <https://www.analog.com/LTC2387-18>`_
>  
> -The driver requires use of the Pulsar LVDS HDL project:
> +The driver requires use of the Pulsar LVDS HDL project for the AD7625, AD7626,
> +AD7960 and AD7961:
>  
>  * `Pulsar LVDS HDL <http://analogdevicesinc.github.io/hdl/projects/pulsar_lvds/index.html>`_
>  
> @@ -65,6 +72,27 @@ The source is determined by the device tree. If ``ref-supply`` is present, then
>  the external reference is used. If ``refin-supply`` is present, then the internal
>  buffer is used. If neither is present, then the internal reference is used.
>  
> +LTC2387 and ADAQ2387x
> +---------------------
> +
> +These parts output data on one or two lanes at double data rate, selected by
> +the TWOLANES pin, which the ``adi,use-two-lanes`` property describes. They have no
> +EN pins and no ``clocks`` property. The driver asks the two PWMs for their
> +step with ``pwm_get_waveform_step_might_sleep()`` and builds the CNV and CLK
> +waveforms in whole steps, so that the burst of CLK pulses starts at least
> +t\ :sub:`FIRSTCLK` after CNV and ends at most t\ :sub:`LASTCLK` after the
> +next CNV. The burst can run into the next conversion period, which limits the
> +sampling frequency in one-lane mode. The ADAQ parts divide the scale by the
> +gain of their front end, given by ``adi,gain-milli``.
> +
> +The driver counts every cycle of the clock that the PWM reports as one pulse
> +of the CLK input, so the clock gated onto CLK has to be the one the PWM
> +counts. They need an AXI ADC design of their own, not the Pulsar LVDS one: the
> +DDR capture and the lane count have to match it, as the AXI ADC backend has no
> +DDR operation to select it, and for two lanes it has to implement
> +``num_lanes_set``. The first sample after the buffer is enabled can be stale,
> +as the CLK burst of a conversion may fall into the next conversion period.
> +
>  Unimplemented features
>  ----------------------
>  

> diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
> index 133c83df8a52..0e7a059df8a6 100644
> --- a/drivers/iio/adc/ad7625.c
> +++ b/drivers/iio/adc/ad7625.c

> +
> +static int ad7625_set_sampling_freq_ddr(struct ad7625_state *st, u32 freq)
> +{
> +	u32 period, min_period, gate, offset, lastclk, cnvh, burst_end;
> +	const struct ad7625_ddr_timing *t = st->info->ddr_timing;
> +	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
> +	struct pwm_waveform_step step;
> +	u32 cycles_per_step;
> +	int ret;
> +
> +	/* The step changes if the clock of the PWMs was reconfigured since probe. */
> +	ret = ad7625_ddr_read_step(st, &step);
> +	if (ret)
> +		return ret;
> +
> +	st->step = step;
> +
> +	if (!freq || freq > st->info->max_sample_freq_hz ||
> +	    freq > st->step.clk_rate_Hz)
> +		return -EINVAL;
> +
> +	cycles_per_step = st->step.clk_cycles_per_step;
> +
> +	/* Everything but lastclk and burst_end is in steps of the PWMs. */
> +	gate = ad7625_ddr_burst_pulses(st) / cycles_per_step;
> +	cnvh = ad7625_ddr_ns_to_cycles(st, t->cnv_high_min_ns);
> +	cnvh = max(ad7625_ddr_cycles_to_steps(st, cnvh), 1U);
Similar to offset.
> +	offset = ad7625_ddr_ns_to_cycles(st, t->first_clk_min_ns);

Maybe use a different local variable for offset_cycles just to avoid
the units of the variable changing in two lines.  

> +	offset = ad7625_ddr_cycles_to_steps(st, offset);
> +	lastclk = mul_u64_u64_div_u64(t->last_clk_max_ns, st->step.clk_rate_Hz,
> +				      NSEC_PER_SEC);
> +
> +	/*
> +	 * The gated clock burst for one conversion starts t_FIRSTCLK after its
> +	 * CNV and may run into the next period, but has to end within
> +	 * t_LASTCLK of the next CNV. It must also leave the gate low for at
> +	 * least one step per period.
> +	 */
> +	burst_end = (offset + gate) * cycles_per_step;
> +	min_period = burst_end > lastclk ?
> +		     DIV_ROUND_UP(burst_end - lastclk, cycles_per_step) : 0;
> +	period = DIV_ROUND_UP(st->step.clk_rate_Hz, freq);
> +	period = max3(DIV_ROUND_UP(period, cycles_per_step), gate + 1, min_period);
> +
> +	cnv_wf.period_length_ns = ad7625_ddr_steps_to_ns(st, period);
> +	cnv_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, cnvh);
Perhaps set the whole thing down here with 
	cnv_wf = (struct pwm_waveform) {
		.period_length_ns = ....
		.duty_lenght_ns = ...
	};
rather that clear it then fill stuff in down here.
Maybe also explicitly set the offset to 0 to show it's the baseline
(I assume) for the other one that follows?

> +
> +	clk_gate_wf.period_length_ns = cnv_wf.period_length_ns;
> +	clk_gate_wf.duty_length_ns = ad7625_ddr_steps_to_ns(st, gate);
> +	clk_gate_wf.duty_offset_ns = ad7625_ddr_steps_to_ns(st, offset % period);

Similar for this one.

> +
> +	/*
> +	 * The waveforms are whole steps, so nothing should have to grow. If it
> +	 * did, a minimum time of the part is no longer met.
> +	 */
> +	ret = pwm_round_waveform_might_sleep(st->cnv_pwm, &cnv_wf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret)
> +		return -EINVAL;
> +
> +	ret = pwm_round_waveform_might_sleep(st->clk_gate_pwm, &clk_gate_wf);
> +	if (ret < 0)
> +		return ret;
> +	if (ret)
> +		return -EINVAL;
> +
> +	st->cnv_wf = cnv_wf;
> +	st->clk_gate_wf = clk_gate_wf;
> +	st->sampling_freq_hz =
> +		DIV64_U64_ROUND_CLOSEST(st->step.clk_rate_Hz,
> +					mul_u32_u32(period, cycles_per_step));
> +
> +	return 0;
> +}
> +
>  static int ad7625_set_sampling_freq(struct ad7625_state *st, u32 freq)
>  {
>  	struct pwm_waveform clk_gate_wf = { }, cnv_wf = { };
>  	unsigned long target;
>  	int ret;
>  
> +	if (st->info->ddr_timing)
> +		return ad7625_set_sampling_freq_ddr(st, freq);
> +
>  	if (!freq)
>  		return -EINVAL;
>  
> @@ -239,6 +469,14 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  
>  	case IIO_CHAN_INFO_SCALE:
> +		if (st->info->ddr_timing) {
> +			/* Referred to the input of the ADAQ front end, so divided by its gain. */

Why does something called DDR timing have anything to do with the scaling
here?  Is it being used as a proxy for parts that happen to have some other
characteristic?

> +			*val = st->vref_mV * MILLI;
> +			*val2 = st->gain << (chan->scan_type.realbits - 1);
> +
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +
>  		*val = st->vref_mV;
>  		*val2 = chan->scan_type.realbits - 1;
>  
> @@ -421,6 +659,33 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
>  	}
>  }


> @@ -498,6 +779,37 @@ static int devm_ad7625_pwm_get(struct device *dev,
>  	return 0;
>  }
>  
> +static int devm_ad7625_ddr_regulator_setup(struct device *dev,
> +					   struct ad7625_state *st)
> +{
> +	int ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, st->info->num_supplies,
> +					     st->info->supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable supplies\n");
> +
> +	/* VS- of the ADAQ modules is left out if it is tied to ground. */
> +	ret = devm_regulator_get_enable_optional(dev, "vs-n");
> +	if (ret && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable VS-\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "ref");
> +	if (ret == -ENODEV) {
> +		/* Without ref-supply the internal reference is used. */
> +		st->vref_mV = AD7625_INTERNAL_REF_MV;
> +		return 0;
> +	}
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
> +	if (ret == 0)
> +		return dev_err_probe(dev, -EINVAL, "REF voltage must not be 0\n");

Obviously it's nonsense if it is 0, but why do we exclude 0 but not 1 which also
ends up being scaled to 0?  The function succeeded so I'm not sure we need
to check for 0 explicitly unless it indicates some other failure path I'm not
thinking of.

> +
> +	st->vref_mV = ret / (MICRO / MILLI);
> +
> +	return 0;
> +}

> @@ -649,6 +970,19 @@ static int ad7625_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	if (st->info->ddr_timing) {
> +		if (st->two_lanes) {
> +			ret = iio_backend_num_lanes_set(st->back, 2);
> +		} else {
> +			ret = iio_backend_num_lanes_set(st->back, 1);
> +			/* Without the op, a backend can only be left on one lane. */
That's a little esoteric.  I guess the issue is we can't assume a default
as maybe we will one day have a backend that only does 4 and 6 lanes.
No guarantee 1 will always be there.

ok. I argued myself around to agreeing this is the best we can do :)

> +			if (ret == -EOPNOTSUPP)
> +				ret = 0;
> +		}
> +		if (ret)
> +			return dev_err_probe(dev, ret, "failed to set the number of lanes\n");
> +	}
> +

> @@ -699,6 +1047,6 @@ static struct platform_driver ad7625_driver = {
>  module_platform_driver(ad7625_driver);
>  
>  MODULE_AUTHOR("Trevor Gamblin <tgamblin@baylibre.com>");
> -MODULE_DESCRIPTION("Analog Devices AD7625 ADC");
> +MODULE_DESCRIPTION("Analog Devices high speed LVDS ADC");

We tend to keep some part indication of the first part supported
in these because at somepoint I'm sure another LVDS part from analog
will come along that is too different to roll in here.  Designers
are a creative bunch and tend to eventually manage to make generic
drivers impossible.

"Analog Devices high speed LVDS ADCs similar to the AD7625"
or something like that.

>  MODULE_LICENSE("GPL");
>  MODULE_IMPORT_NS("IIO_BACKEND");

