Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C642379960;
	Fri, 17 Jul 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311128; cv=none; b=loKazUnKbJCquIMuDtp3HLzdrUTevpLInvjSdmu7DJVbbhqBBbbdvD+04iA52C790lUx7pPKbT/FKuizzHjgj0kJ/LuVT/9s0j8KYTUf9PVQanadQjZK0guUbmakl75pyKnf7DItBcgKg1yoZ+qCKB0sxF4p7LeCtAyJUiewEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311128; c=relaxed/simple;
	bh=8rjsxe/+hBTNSxWiB7hQbS3d98WUbAUDizYkOQYvCdk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AvoBEDJ9wtj9Zyvngi/wJaptCm9yJ2BqjzAYNCnrgtK8Vh9aX4VkilwBb/j4M6EaeMybk2AhREPyaAD1GTzN20fHW++gXcsUMcsmkdoNns/cbPvL70iWWXZIYOsh7N6xsc3XQH8yKxt2L0R97jdsEbLPwVKceeQAIentEWfRn2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rf8onXkH; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rf8onXkH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784311127; x=1815847127;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8rjsxe/+hBTNSxWiB7hQbS3d98WUbAUDizYkOQYvCdk=;
  b=Rf8onXkHhrs3dGaDWr0PW7pYShtnl6Bo+dmX3bpKQU0z3K1ifhVP1u6V
   WvgivXFdGUysZuaBrmHN2XiTQQHsyNhJGlHMzhAGmkU3WpGEwWoaKkegf
   zJdCDyJzms4gWWI+SpTdkd7GtLktfEJQ37JjlmdK7bl6NS61OSwoeQVvn
   vwfWCGiByekPzDrzaYv8RIX/7mlh7OvL1WvQha5x39SYmulcSn7HgExkW
   LxA+gpwEednX3Icew0XnXzRgmziu76gVU8VXQwSQMyuZxfQWA3BtGBbv+
   bvKTBki8V4cp7FvHi6u+UG+QVK4PVBsqYjeFyletBVr8oiyS445p68Flu
   A==;
X-CSE-ConnectionGUID: WbAE88FaSMWtVJ3Jxm6rKA==
X-CSE-MsgGUID: +LfMEYNISH+Xs7ckjAv3tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="85079773"
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="85079773"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:58:46 -0700
X-CSE-ConnectionGUID: eri9T9lNT4atpIO1QIPHeQ==
X-CSE-MsgGUID: hJ2wjK+eQFGJolFSjQ3Y1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,169,1779174000"; 
   d="scan'208";a="257477854"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.143])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 10:58:44 -0700
Date: Fri, 17 Jul 2026 20:58:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com,
	devicetree@vger.kernel.org,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>
Subject: Re: [PATCH v4 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <alptURwc08RaBA7H@ashevche-desk.local>
References: <20260717123852.1140893-1-stefan.popa@analog.com>
 <20260717123852.1140893-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717123852.1140893-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 17, 2026 at 03:38:49PM +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> No existing IIO driver covers this device or a register-compatible part.
> The closest relatives target different silicon with incompatible register
> maps and feature sets: max9611 is a unidirectional high-side sensor with a
> die-temperature channel and MUX-selected gain and no FIFO/PEC, while
> max34408 is an 8-bit multi-channel current monitor. The MAX40080 has a
> device-specific register map with bidirectional 13-bit current, a 64-entry
> FIFO, PEC, a single-measurement mode triggered by an SMBus Quick Command,
> and two selectable input ranges, so it warrants its own driver.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw and scale attributes, a configurable oversampling (digital
> averaging) ratio, and PEC-protected register access. The two selectable
> current-sense ranges are exposed through scale/scale_available; the
> current scale is derived from the shunt-resistor-micro-ohms device-tree
> property.

...

> +struct max40080_state {
> +	struct i2c_client *client;
> +	/* Serializes read-modify-write access to the CFG register. */
> +	struct mutex lock;
> +	u32 shunt_resistor_uOhm;
> +	/*
> +	 * Cached configuration, also used to restore the device on resume after
> +	 * a suspend that may have cut its power: the selected RANGE index and
> +	 * the oversampling ratio.
> +	 */
> +	unsigned int range;
> +	int oversampling_ratio;
> +	/*
> +	 * Precomputed current scale (mA per code) for each RANGE setting, as
> +	 * {integer, nano} pairs for IIO_VAL_INT_PLUS_NANO. The range is
> +	 * selected by writing the corresponding scale.
> +	 */
> +	int current_scale[ARRAY_SIZE(max40080_csa_gain)][2];

> +	/* DMA-safe buffer for i2c_smbus_read_i2c_block_data(). */
> +	u8 buf[4] ____cacheline_aligned;

Why don't you use the specific IIO macro for this?
Do you have internal reviews for this patch series?

> +};

-- 
With Best Regards,
Andy Shevchenko


