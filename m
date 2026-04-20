Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A64E9443;
	Mon, 20 Apr 2026 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675793; cv=none; b=sAG3eGvb/nLDbgDG9JsLRHOUnzLveL11Vw8p1/iamZz2KYkh6GemJMS2hA9MdlwtxfjKVr6ihBYUTlxnlT0P17kSyrhgPXCKqmAvyj6ZankyWknj4ntMZd2yuVUsiJaqK+dYkicdrfVSRkrGnU+SbXZA6267I6wRu3r3gGxmcV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675793; c=relaxed/simple;
	bh=67VzqhbKwALZK7Y/a1nS8JCBjL6EyytkhYeRNCAq2JQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGlTRKwK0wcOS6TkkT3DtAS0ChO3tDbxIx+lvjTQPzKgydSXfAp0OOUufnRPXQT3ctOJmvvC8ceFMK5HUQj9H7MaLht+Nnq5gT6SWdfy1Xmt/5rz4pso/qVnXe0PQprjp9N+DSJgn57bzotF6zBh4CYW8YGwMr9UyInSGTaKh+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gsXVQOFG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gsXVQOFG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776675792; x=1808211792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=67VzqhbKwALZK7Y/a1nS8JCBjL6EyytkhYeRNCAq2JQ=;
  b=gsXVQOFG1U1YvnmkMu2WPF5KOCi+0EypWY6iKikGiuknCYzia3uelgTG
   1/L8Xn91iQthv2tsLuS1gyxJA421Ny0QqoRYf8VUEomHFIzIiDm6s6x+n
   sKP9SLOour/UfBC+/i3jO1um2NrNmraMSQ2ZjJ+xdFOrsXNhVklsSBbtX
   FFR9O5Ro70OkHR+rf8VHmATH52Mmcyd7vMna9SzA0DJ4rlx8nYxONH3R6
   4OCAW5CiF6TWXmhhFzEMBONj4BAFL8nzhwxuVwiSXSmvY0O8CqE+bPaIx
   TYgWZFzu+cfH1aZl9yL7RNtCi7suQVAXIfZJuJ9fkpYJMoMen4riyR9Px
   g==;
X-CSE-ConnectionGUID: fhKJ9cO4SM2/1FYpM5uggg==
X-CSE-MsgGUID: gLNOwaIETBq+PxMYttxRCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88660178"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="88660178"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:03:11 -0700
X-CSE-ConnectionGUID: /Jo1DNrzRje9XoL9qUsoLg==
X-CSE-MsgGUID: f1k6+AIFQ6u+I4GhKmoegg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="230634648"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:03:08 -0700
Date: Mon, 20 Apr 2026 12:03:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: jic23@kernel.org, ak@it-klinger.de, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: hx711: add support for HX710B
Message-ID: <aeXryRD34RLveqDi@ashevche-desk.local>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
 <20260419174654.683692-3-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419174654.683692-3-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 11:16:40PM +0530, Piyush Patle wrote:
> The HX711 uses trailing SCK pulses after each 24-bit conversion to
> select the channel and gain for the next measurement: 1 pulse gives
> channel A at gain 128, 2 pulses give channel B at gain 32, and 3 pulses
> give channel A at gain 64.
> 
> The HX710B works differently: gain is fixed at 128 and the trailing
> pulses select only the channel. One trailing pulse selects the
> differential input (channel 0, 10 SPS) and two trailing pulses select
> the DVDD-AVDD supply monitor (channel 1, 40 SPS).
> 
> Refactor the driver around a per-chip hx711_chip_info structure so both
> variants can share the same core. Each chip provides its own
> iio_chan_spec array and iio_info pointer. The HX710B stores per-channel
> trailing pulse counts in chan->address (1 for channel 0, 2 for
> channel 1) instead of a separate array. A bool fixed_gain flag and
> fixed_gain_val field in hx711_chip_info distinguish the fixed-gain path
> from the HX711's user-selectable gain path without conflating unrelated
> properties. The HX710B differential input channel is described with
> .differential=1 and .channel2=1 as required by the IIO ABI.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> Changes in v2:
> - Fix pulse count bug: hx710b values were {25, 26} (total SCK cycles);
>   corrected to {1, 2} (trailing-only, hx711_read() clocks 24 data bits)

Which questions how it was tested...

> - Add .differential = 1 and .channel2 = 1 to HX710B channel 0
> - Move trailing pulse counts from a separate array to chan->address
>   (1 for ch0, 2 for ch1); remove chan_pulse_count / num_chan_pulses
> - Replace chan_pulse_count != NULL tests with dedicated bool fixed_gain
>   flag; add fixed_gain_val field to hx711_chip_info
> - Add const struct iio_info *iio_info to hx711_chip_info; probe sets
>   indio_dev->info = chip_info->iio_info directly
> - Remove NULL check after device_get_match_data()
> - Remove reset_channel from hx711_chip_info (always 0; use literal)
> - Change hx711_reset_read() and hx710b_set_channel() to take
>   const struct iio_chan_spec * instead of int chan
> - Revert hx711_data struct member alignment noise
> - Restore trailing blank line at end of file (unrelated removal reverted)
> - Sort of_device_id entries alphabetically (hx710b before hx711)
> - Expand commit message to explain HX711 vs HX710B trailing-pulse model
> - Restore file header to mention weight sensor modules

...

>  config HX711
> -	tristate "AVIA HX711 ADC for weight cells"
> +	tristate "AVIA HX711 and HX710B ADC"

This won't scale. Better to put something like "and compatible".
Also use plural "ADCs".

>  	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for AVIA HX711 ADC which is used
> -	  for weigh cells
> +	  If you say yes here you get support for AVIA HX711 and HX710B ADCs
> +	  which are used for bridge sensors such as weigh cells.

Usually for the less churn in the future we list them one per line. This
will give easier understanding of what is supported (keep them also sorted).

	  If you say Y here you get support for the following AVIA ADCs:
	    - HX710B
	    - HX711
	  which are used for bridge sensors such as weigh cells.

>  	  This driver uses two GPIOs, one acts as the clock and controls the
>  	  channel selection and gain, the other one is used for the measurement
>  	  data
>  
> +	  The HX710B is a variant with fixed gain and a different channel
> +	  selection scheme.
> +
>  	  Currently the raw value is read from the chip and delivered.
>  	  To get an actual weight one needs to subtract the
>  	  zero offset and multiply by a scale factor.

...

> - * HX711: analog to digital converter for weight sensor module
> + * HX711/HX710B: ADC driver for weight sensor modules

Use same as in Kconfig:

 * HX711 and compatible ADCs driver for weight sensor modules

 ...

> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification
> + * @num_channels: number of channels
> + * @iio_info: IIO info ops for this variant
> + * @fixed_gain: true if the variant has a fixed ADC gain (e.g. HX710B)
> + * @fixed_gain_val: the fixed gain value used to compute scale (when fixed_gain)
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;
> +	int				num_channels;

Why signed?

> +	const struct iio_info		*iio_info;
> +	bool				fixed_gain;
> +	int				fixed_gain_val;
> +};

...

>  struct hx711_data {
>  	struct device		*dev;
>  	struct gpio_desc	*gpiod_pd_sck;
>  	struct gpio_desc	*gpiod_dout;
>  	int			gain_set;	/* gain set on device */
>  	int			gain_chan_a;	/* gain for channel A */

> +	int			channel_set;	/* HX710B current channel */
> +	int			scale;		/* HX710B fixed scale */

Check if those need to be signed.

> +	const struct hx711_chip_info *chip_info;
>  	struct mutex		lock;

>  }

...

> -	for (i = 0; i < hx711_get_gain_to_pulse(hx711_data->gain_set); i++)
> +	for (i = 0; i < trailing_pulses; i++)

If 'i' is used only once here, it can be converted to

	for (unsigned int i = 0; i < trailing_pulses; i++)

>  		hx711_cycle(hx711_data);
>  
>  	return value;

...

> +	.num_channels	= ARRAY_SIZE(hx711_chan_spec),

You also probably want to revisit inclusion block. At least follow IWYU in the
code you added here, exempli gratia include array_size.h and types.h if not yet
included.

...

>  	hx711_data->clock_frequency = 400000;

Sounds like I2C or SD standard speed :-)

Not sure, but can be also converted to use 400 * HZ_PER_KHZ (from units.h)
in a separate change.

...

>  	hx711_data->data_ready_delay_ns =
>  				1000000000 / hx711_data->clock_frequency;

Side note, in a separate change you can use constants from time.h, id est
NSEC_PER_SEC.

...

>  static const struct of_device_id of_hx711_match[] = {
> -	{ .compatible = "avia,hx711", },
> +	{ .compatible = "avia,hx710b", .data = &hx710b_chip },

Please, split this to a separate change. So, first introduce the chip_info,
then add your device support using given infrastructure.

That said, you also can convert the driver to use guard()() from cleanup.h
in a separate change.


> +	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
>  	{ }
>  };

...

> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");

Ah, this removes crucial information. So, this driver probably just needs to
use i2c_gpio?

> +MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");

Use what is written in Kconfig.

-- 
With Best Regards,
Andy Shevchenko


