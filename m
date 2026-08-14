Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08552836F;
	Fri, 14 Aug 2026 12:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786708906; cv=none; b=bMRmgaws/4koUYbFW8kkhnoP8EWIQcJHU6UjXHE3uwDF+3XCz5oPJuZagZ5IhByDyKHD/F1A3ef4Dc7A0JOZZlypXSRoYRIRBfPj19xG2GVOSUGPLq2OyjiWNUCV+fm0pEMwpgPYg/xINJTGhMbor64v/HoVyudECh2mGfSAFaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786708906; c=relaxed/simple;
	bh=LsZ1ffheV4O7q3moUGa5YcGjkztBypSGSErLt2fBA/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vke6cALm4BfKni9n3jKXQQw2KKuMAb9E5WQL9RZCQea/B4XPdD0aYcDMXMziWxSiWiqqkFgP6JS8gFPx7WhxJjBDVW+DMQZpMcEDH3bRenZXjWRnD1gLqzf27Wn2yyI/FGuDKP5ZfwuYASy13BbgZe2ym+poAySeVY36CnacP6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I0bbuOed; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I0bbuOed"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786708903; x=1818244903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsZ1ffheV4O7q3moUGa5YcGjkztBypSGSErLt2fBA/o=;
  b=I0bbuOed4Ec1hqIlylrRvpXxMfN6hsNh59rd0RwONRhTxyHoBQ9f00UT
   w0QfaWIHIfClwirPyicYb6zIud9jLupFpm/KNocyq7p8yeCzNd4RD8h55
   A4/2DWJIMPz19VegMlheOSGiCoQ91Nyack0ONCgnisHMjp5/xwo3hsthA
   CyPtfL5HBqUPkXdukCqbnD1UtUbm8269F4GV32PbNCs1iKSBlsG07VH41
   abuA0u+qPd3qd+QMHb/B9E1bDmDwZZaQcDrQyuKw25JLMtkmThKHKl3f7
   LL9VxosIaFHHWDXQxfbx2iNwIwm3itaJ2lhRC9oS3IWUxHtpwjA5vn1Wk
   w==;
X-CSE-ConnectionGUID: aAuQEf/RRHeXL7cdC1DjOg==
X-CSE-MsgGUID: oScaSBjBSwi8DUBNXAPWRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="97878071"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="97878071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:01:42 -0700
X-CSE-ConnectionGUID: BLDSw9ZCQYqdx0rvZmGwlw==
X-CSE-MsgGUID: WIyz2X6MTlaYrF2XCvQQBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; 
   d="scan'208";a="289003358"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.134])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 05:01:39 -0700
Date: Fri, 14 Aug 2026 15:01:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <an8DoMHly_vwwnni@ashevche-desk.local>
References: <20260813160139.70000-1-andrei.stancovici@analog.com>
 <20260813160139.70000-4-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260813160139.70000-4-andrei.stancovici@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 13, 2026 at 07:01:37PM +0300, Andrei Stancovici wrote:
> The LTC2499 supports a 2x output rate (SPD bit in the second
> configuration byte).  In 2x mode the offset auto-calibration is
> disabled, roughly doubling the conversion rate (~13.6Hz vs ~6.8Hz in
> simultaneous 50/60Hz rejection) while leaving linearity and full-scale
> errors unchanged (datasheet).  During a temperature measurement the part
> always converts at 1x regardless of SPD.
> 
> Expose the rate through the standard sampling_frequency /
> sampling_frequency_available ABI on the voltage channels only: SPD is
> ignored for temperature conversions, so the temperature channel
> deliberately carries no SAMP_FREQ attribute.  A new has_speed_mode
> capability flag gates the feature (LTC2499); the two-byte command path
> is now taken for has_temp || has_speed_mode, since both features need the
> second config byte.
> 
> The conversion-time wait becomes mode dependent: 150ms at 1x, 76ms at 2x
> (datasheet t_CONV max, simultaneous rejection, rounded up).  The wait is
> keyed on the conversion currently in flight, whose duration is fixed by
> the mode that was active when it started - not by the newly selected
> mode.  This matters on a 1x->2x switch: a 1x conversion may still be
> running when the first 2x read arrives, and reprogramming the device
> before it finishes would be NACKed with -EIO.  Timing is centralized in
> ltc2497core_conv_time_ms() so a future FA/FB rejection-mode selection
> can extend it into a [rejection][speed] lookup without touching callers.
> 
> LTC2496/LTC2497 (no speed mode) keep the single-byte path and the
> unchanged 150ms wait.
> 
> Validated on a live LTC2499: 20 reads take ~3.1s at 1x and ~1.6s at 2x
> (~0.5x, no -EIO), voltage and temperature readings stay sane in both
> modes, and the temperature/voltage interleave (sticky-PTAT) regression
> still passes at 1x and 2x.

...

> -static int ltc2497core_wait_conv(struct ltc2497core_driverdata *ddata)
> +static unsigned int ltc2497core_conv_time_ms(struct ltc2497core_driverdata *ddata,
> +					     u8 address)

Wondering if you use --histogram when preparing patches. If not, try it, it may give
more human-readable diffs.

...

> +static int ltc2497core_write_raw(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan,
> +				 int val, int val2, long mask)
> +{
> +	struct ltc2497core_driverdata *ddata = iio_priv(indio_dev);
> +	bool sped_2x;
> +	unsigned int i;

Reversed xmas tree ordering (longer lines first).

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/* Match the (val, val2) pair against the advertised rates. */
> +		for (i = 0; i < ARRAY_SIZE(ltc2497core_samp_freq_avail); i += 2) {
> +			if (val == ltc2497core_samp_freq_avail[i] &&
> +			    val2 == ltc2497core_samp_freq_avail[i + 1])
> +				break;
> +		}
> +		if (i == ARRAY_SIZE(ltc2497core_samp_freq_avail))
> +			return -EINVAL;
> +
> +		sped_2x = i / 2;
> +
> +		mutex_lock(&ddata->lock);
> +		ddata->sped_2x = sped_2x;
> +		/*
> +		 * The new speed only takes effect once the second command byte
> +		 * is reprogrammed, so force the next read to reprogram rather
> +		 * than reuse the value already latched for this address.
> +		 * LTC2497_CONFIG_DEFAULT is not a valid channel/temperature
> +		 * address, so it is a safe re-arm sentinel (as used at probe).
> +		 *
> +		 * A conversion started under the old speed may still be in
> +		 * flight; its own duration (conv_time_prev), not the new mode's,
> +		 * still gates the next reprogram, so the timing state is left
> +		 * untouched here.
> +		 */
> +		ddata->addr_prev = LTC2497_CONFIG_DEFAULT;
> +		mutex_unlock(&ddata->lock);
> +
> +		return 0;
> +
>  	default:
>  		return -EINVAL;
>  	}

>  };

...

> +	/*
> +	 * Parts with a speed mode expose in_voltage_sampling_frequency /
> +	 * _available on the voltage channels only.  SPD is ignored during a

Spell the node name in full, I can't really get if you meant
in_voltage_available or something else.

> +	 * temperature measurement, so the temperature channel deliberately
> +	 * carries no SAMP_FREQ attribute.  Patch a private copy of the shared
> +	 * channel array so parts without a speed mode stay untouched.
> +	 */

...

>  	/*
> -	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
> -	 * configuration via a second command byte and only re-evaluate it when
> -	 * that byte has EN2 set; a single byte, or a second byte with EN2 = 0,
> -	 * means "keep previous". A one-byte channel select therefore cannot pull
> -	 * the device back out of temperature mode, so a voltage read after a
> -	 * temperature read would keep returning the PTAT result. Always drive the
> -	 * second byte with EN2 set on these parts: IM = 1 for a temperature read,
> -	 * EN2 alone (IM = 0) to (re)select an external input. FA = FB = 0 keeps
> -	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
> -	 * conversion time the driver's wait already covers.
> +	 * Parts with a second config byte (LTC2499: internal PTAT sensor and/or
> +	 * the 2x speed mode) latch their converter configuration from that byte
> +	 * and only re-evaluate it when EN2 is set; a single byte, or a second
> +	 * byte with EN2 = 0, means "keep previous". A one-byte channel select

Please, be consistent with 1-space versus double-space at the start of a new
sentences. See just above comment and compare.

> +	 * therefore cannot pull the device back out of temperature mode, so a
> +	 * voltage read after a temperature read would keep returning the PTAT
> +	 * result. Always drive the second byte with EN2 set on these parts:
> +	 *   - temperature read: IM = 1 (SPD is ignored by the part in
> +	 *     temperature mode and is left 0 here);
> +	 *   - voltage read: IM = 0 (external input), plus SPD when 2x is
> +	 *     selected.
> +	 * FA = FB = 0 keeps the power-on simultaneous 50/60Hz rejection, whose
> +	 * worst-case conversion time the driver's wait already covers.
>  	 *
>  	 * The two bytes are assembled in the DMA-safe st->data buffer rather than
>  	 * on the stack, so the pointer handed to i2c_master_send() stays valid on
>  	 * adapters that DMA the transfer (e.g. with CONFIG_VMAP_STACK).
>  	 */


-- 
With Best Regards,
Andy Shevchenko


