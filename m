Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB88492520;
	Mon, 31 Aug 2026 14:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788185135; cv=none; b=QlP8TTVm8jbBcv/3KiZkO1uOdMd6Ni0qGWXaEgB74/10ExA2akSTifn5UftRRBNkOlvkXhu5pkpilMe6ZVh249lP28ORdWXXlTOgTaq5L4Pa6/Ivpw++OQvNpdPWg1gcKok8tR6Ou18EqYVHBakcQJb92ZR4WLLoCXrRkP3V0k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788185135; c=relaxed/simple;
	bh=oAaZfGE0LIHaxXfesnXqiw1eLC+pyih9L152sojN/6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnGcxtD49uKVyyGlyoqp8I6hsyVDNy/ptftot4f2mxNETrBkw4ZogL66V/A6fY25j6UBWWLQgLeEzcWOJuYSAy+/dhmM/fduTlBHeTR/4otHlDt6yTZI+xoA4HBKuf5azhNukPcIHG183hBY2xlb/+rAj8tVKBC10YEJ9PIsec8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZ5I3bPi; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZ5I3bPi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788185133; x=1819721133;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oAaZfGE0LIHaxXfesnXqiw1eLC+pyih9L152sojN/6M=;
  b=HZ5I3bPid572ErEWH1P2vY5eTZPlfMoGccBuPIWIAfqATNtgWYJDAAHj
   mNCwOXZRiGCHrYBh6EVrB1evCpHNM7M/gt5AUzHclFrelrxTmOUuJe0bM
   XPnbHEzS1kfLgy3om//r1XXe21z1fqwyoGQtNspJ8oeCz+cdcES+aLiff
   9biDovgUND/jFY9lXMzUrs55XjlFI6fEnq0Oyhk4+PlCZ6zRlaktj3ejP
   NvkAtV6QiL/0sNllcp0JEvxe+k4hurbNlx42tKc+xHd7eIxS62roXzfJe
   Mp3WlfzdYsOg/2RySvGZhlexuhOF74ZF8Dl5IcUSyFGzZMtj9wZm12VrD
   Q==;
X-CSE-ConnectionGUID: rXDTv4fbQzyPBuJ6nDa41A==
X-CSE-MsgGUID: o/kRP+ksSIOGM8uHC0eBXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88469550"
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="88469550"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:05:22 -0700
X-CSE-ConnectionGUID: T0R3EfDeTYW6/E9ENg7iSw==
X-CSE-MsgGUID: XJteXT1URma2VSypDslLYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,254,1779174000"; 
   d="scan'208";a="307032910"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 07:05:17 -0700
Date: Mon, 31 Aug 2026 17:05:15 +0300
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
Subject: Re: [PATCH v9 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <apWKGyFYmmJLe-Wx@ashevche-desk.local>
References: <20260831134334.196359-1-stefan.popa@analog.com>
 <20260831134334.196359-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831134334.196359-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 04:43:34PM +0300, Stefan Popa wrote:
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

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


