Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770B3B42CB;
	Fri, 28 Aug 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787910112; cv=none; b=d/thbg9aX04GO0U+f1Cn/rFMvk7n7CAKso6u8kDIHkZjSvoGLmtVOW8Uh25UPrKRhGXN3Hwp7TEi0RTRTTON4NG1k8jipV6hqRISfm/dCxqmNzzxh/89Cqi734LioequK9OA1OxJlVwubXctJNXiINR4zs0ZchwK2Hv5acN+jXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787910112; c=relaxed/simple;
	bh=XVfMnRDLyzarJ8i3B4INKLgSnm5L6biIsyuCw1cxosA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGdV9avvVhWY9JLrrokNZaXiHFqXpiMwQAxfM/jJwVuhaZNhWpHcHi8I9TTqXZu0ov9Gh8ZiUJ2uy0iTXMdGwSL5xFJWiOlV2BwDUQ3An2IBkykT/lMi2ntxHOW8xexy8aTOfVgkGYH5BDs/9CrOBvcPyjxEJBazHcI2WHs68Ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RNlU8p+y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RNlU8p+y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787910111; x=1819446111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XVfMnRDLyzarJ8i3B4INKLgSnm5L6biIsyuCw1cxosA=;
  b=RNlU8p+y4vP3AWYxJqKVGi4MfggWAopmbDp5N/DBFpI4kaK/Zo4WqLeW
   /6eq0u/Zgh6f2t+5vdj/WTtd3jDLsjsGiqi7ZXAf8Cq6xlkV0ASo7pqLK
   Pb9SKV7YzdffoR3F2xO1oL8ZHKR7+kxepCPN8xVeEAiNIMQgGRN9GxyG3
   mAwZZsZLG2RexKhoVGjrWzHKvMLwv/zdUOAkv9hYGCBifUSXnbU4RYJXx
   MLsoTRO0COabBiwTITIsJk1l/017L0iT9hbRGCZWmStmqzEqz3K6Q2te3
   hbRaRiJbFD3M44Zlaun8Lyuh2PNcL+EyvbwX+SguobkjSpWIe8DtuGEPI
   Q==;
X-CSE-ConnectionGUID: OZvVMnFfSzG1nbyijpSBnw==
X-CSE-MsgGUID: VVT4THwvRwK63G11299AuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88180496"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88180496"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 02:41:50 -0700
X-CSE-ConnectionGUID: zpuMb7soRnK8ZiFBzS9QGQ==
X-CSE-MsgGUID: 05IuzeUVSr6NFpW7JwKEZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="263831834"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.34])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 02:41:45 -0700
Date: Fri, 28 Aug 2026 12:41:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, siratul.islam@linux.dev,
	u.kleine-koenig@baylibre.com, linux@roeck-us.net,
	joshua.crofts1@gmail.com, ciprian.hegbeli@analog.com,
	krzysztof.kozlowski@oss.qualcomm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <apFX16p9OGwA5cjB@ashevche-desk.local>
References: <20260828083119.54495-1-stefan.popa@analog.com>
 <20260828083119.54495-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828083119.54495-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 28, 2026 at 11:31:18AM +0300, Stefan Popa wrote:
> The MAX40080 is a bidirectional current-sense amplifier with an
> integrated 12-bit ADC and an I2C/SMBus interface. It measures the
> voltage across an external shunt resistor and the input bus voltage,
> storing the results in an internal FIFO.
> 
> Add a direct-mode IIO driver exposing the current and voltage channels
> with raw, scale and hardware-gain attributes, a configurable
> oversampling (digital averaging) ratio, and PEC-protected register
> access. The current scale is derived from the shunt resistor value
> described in the device tree.
> 
> The driver operates in single-measurement mode: each raw read triggers
> an on-demand conversion via SMBus Quick Command and returns a matched
> current/voltage pair. This avoids the latency and complexity of the
> continuous FIFO mode while ensuring each read reflects the current
> state. The two selectable current-sense ranges are exposed through
> scale/scale_available.
> 
> Continuous FIFO buffering, threshold events and the alert interrupt are
> intentionally left out of this initial submission and may be added
> later.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/types.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>

+ types.h // uXX

> +#include <linux/units.h>

...

> +static int max40080_read_iv(struct max40080_state *st, u32 *iv)
> +{
> +	u32 tmp = 0;
> +	int ret, io_ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = max40080_trigger_measurement(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * Wait for the conversion to complete by polling the FIFO valid bit
> +	 * (or bail out on an I2C error). Polling the device's own status makes
> +	 * this independent of the actual conversion time, which varies with the
> +	 * oversampling ratio and the bus speed. The timeout is only a safety
> +	 * ceiling: the worst case is the maximum 128x averaging on both the
> +	 * current and voltage channels at the slowest 15 ksps base rate plus the
> +	 * inter-channel switching time, i.e. roughly 20 ms; 50 ms leaves ample
> +	 * margin.
> +	 */
> +	ret = read_poll_timeout(max40080_read_iv_once, io_ret,
> +				io_ret || (tmp & MAX40080_IV_VALID_MSK),
> +				500, 50000, false, st, &tmp);

50 * USEC_PER_MSEC
(needs time.h)

> +	/*
> +	 * Propagate the last-read value even on timeout so the caller can
> +	 * inspect it for debugging.
> +	 */
> +	*iv = tmp;

But would it make sense when IO error happened?

> +	if (ret)
> +		return ret;

> +	return io_ret;

Actually IO error might have a precedence over timeout. I would check for it
first.

> +}

-- 
With Best Regards,
Andy Shevchenko


