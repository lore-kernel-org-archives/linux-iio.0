Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A893E3EDAA0;
	Thu,  3 Sep 2026 06:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788418332; cv=none; b=JiD8c0RM/+5Zn2rwolrpDrfs28Dl6/3zTifZ3L1vpdzHnnI73poVBTOvm1NwiIsGtjk8kH83ULD66/taLDQO4HRma+a3f/QVDz8AdAC+ATvy6uMKnxB03jHY5f6llOWLiKPRSG7h2gloqddXpvG3FVQug84KFjVTWPnjE1QnAVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788418332; c=relaxed/simple;
	bh=UBP2ZlvBFV2v+MwOAsqYB6RadAJRiLG8Nce7MoBGlzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OqF4JKFlIG+ymaCNo3TY7vw7F9hI86uEeubKHFT5hMmYQWA3ANNaC3zKYbiRjErRbWfsbSzpZgUTmQzFkUnOXIVeH9E8dBVk19wUoHZRYM5AE/rLqh0hRYCryjBMYfYYp1XNROm57pVpQ+q6GpSsIiU3nebShYN/wjv/XHr9SJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCoP8jSp; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCoP8jSp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788418331; x=1819954331;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UBP2ZlvBFV2v+MwOAsqYB6RadAJRiLG8Nce7MoBGlzg=;
  b=JCoP8jSpGUguHUDXYJm8765fF1L6+5aRh9WxMYgIIvUXUp4TXtISx+WE
   XRm8viUEU20zzoTvIXRGR12UKf7/4yP0+Ds+sd5daBWsuOZRvnVu7KhGX
   t/OvqNmWTOQ+eNcg8Z5pPGV7TzFXzHhcETG88iwy7hqD9Zyc2TIwnrEKf
   zx6uhww9UC7svF4YPNfY1RzcxRFXs/NDVWtcM/tN4fyslb/Q7t+SUydEu
   NYUNrXAAK1pU0g0hERbs2Sm9hllpbf0VcnZHcQajSJFn8C8Vn2k4gTddU
   GVUOXoXXhqiYA9AdQqxygnsOu9p3E3WXJAjGQS+6vjM1zuLqap0rxB9NX
   Q==;
X-CSE-ConnectionGUID: pgeuXlsKQEuNn0OocTMYqw==
X-CSE-MsgGUID: wOjrcHBiS/SCydjHX0EK4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="106409675"
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="106409675"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:52:10 -0700
X-CSE-ConnectionGUID: 1/Rlu0gBSqC5CWaszdgSOg==
X-CSE-MsgGUID: BmBIMcb3QnW+b2MuWOQ2dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,258,1779174000"; 
   d="scan'208";a="265304827"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2026 23:52:07 -0700
Date: Thu, 3 Sep 2026 09:52:04 +0300
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
Subject: Re: [PATCH v3 3/3] iio: adc: ltc2497: add 2x conversion speed mode
Message-ID: <apkZFOmT01nNnNb4@ashevche-desk.local>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
 <20260902064415.132588-4-andrei.stancovici@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902064415.132588-4-andrei.stancovici@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 02, 2026 at 09:44:12AM +0300, Andrei Stancovici wrote:
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

Are the commit messages written with AI assistance?
If so, can you shorten them straight to the point?
Some of the details can be read in the datasheet or code, I think.
(For datasheet it makes sense to add Datasheet tag).

...

> +	/*
> +	 * Parts with a speed mode expose in_voltage_sampling_frequency and
> +	 * in_voltage_sampling_frequency_available on the voltage channels only.
> +	 * SPD is ignored during a temperature measurement, so the temperature
> +	 * channel deliberately carries no SAMP_FREQ attribute.  Patch a private
> +	 * copy of the shared channel array so parts without a speed mode stay
> +	 * untouched.
> +	 */
> +	if (ddata->chip_info->has_speed_mode) {
> +		struct iio_chan_spec *channels;
> +
> +		channels = devm_kmemdup(dev, ltc2497core_channel,
> +					sizeof(ltc2497core_channel), GFP_KERNEL);
> +		if (!channels)
> +			return -ENOMEM;
> +
> +		for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +			if (channels[i].type != IIO_VOLTAGE)
> +				continue;

+ blank line.

> +			channels[i].info_mask_shared_by_type |=
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +			channels[i].info_mask_shared_by_type_available |=
> +				BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		}
> +
> +		indio_dev->channels = channels;
> +	}

-- 
With Best Regards,
Andy Shevchenko


