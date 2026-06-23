Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2AD3ACF02;
	Tue, 23 Jun 2026 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782249779; cv=none; b=jMXf5yHYx9ZC9rxAJjWdflSFioHB9chMchLRYxpErNNcfLHXOAnGfNsNidBGAdyBvhnQIlT6CtLsK0gU1lVGv0FmU4atqmDAsdfhgi6PjT3S4HoX5tDEZvK5NET+Fn6aFr2J0nZpfZAf2dKBFmSC64gwq+lsRc6rKOuSyDLo7Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782249779; c=relaxed/simple;
	bh=AKXV4muuFBAbGj4jCPBZwKR37ivYTelH5ksj5TS5Clg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSDgJH5z5YgQUC+LXG5dRvKMKlIuRWf9zUvpCo7740gVTfcn21I5c/m3Yv3tHJ0TIx3t+azi3sZVecApV8DA8f5Xdc4cCUjZ4E4iwBmfy3pMfnFFsEFvgTzEcFHbuzs/c1fc/RvhH9Hq69ESwUxyOvsAnUGS7vmSul94SPzVKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mu0Ln98g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mu0Ln98g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782249777; x=1813785777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKXV4muuFBAbGj4jCPBZwKR37ivYTelH5ksj5TS5Clg=;
  b=mu0Ln98gMREQMjbYutYG3WZsL+6tBzOYcXf/hKBA7QN6QDeoVhQc4nIO
   oH1Xnr06DY0xU86s4O0oVTfYYmUNxzIAgcgpRu6HKS2f12QKB4O1AL6h7
   euBnhkX6IMwOkjfOWf/pkUaabHtt2dGp356iwZm3jArQbqTkHFPadIJsO
   lIdE2B7mhAGTlMFdtlqkE2cW6T8T42woqfAWdNjM/1rph401I1s74l1kn
   DEtkSr3CC0FXd+eHLq4GCfA71eJMLoOlEQdoWJBn3sgW1OvdpwYMnqg9Z
   TXABavBvLs5UiMxAiy4vQ1PpQZfg3e5OlXfWxQyxTKq7nO7Q56cYwy4Zz
   Q==;
X-CSE-ConnectionGUID: bTu8cq7lT2Oggj4TdHTv3w==
X-CSE-MsgGUID: QUw6vnzGRTiEUy7jWADPEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="83044946"
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="83044946"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:22:56 -0700
X-CSE-ConnectionGUID: +O/5Yu9XRy2OyPRl9TD3QA==
X-CSE-MsgGUID: kJADlDnMQamLWZjchZ8MYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,221,1774335600"; 
   d="scan'208";a="287753248"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 14:22:53 -0700
Date: Wed, 24 Jun 2026 00:22:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 1/2] iio: dac: add mcf54415 DAC
Message-ID: <ajr5Kj1GH-z9x2_k@ashevche-desk.local>
References: <20260618-wip-stmark2-dac-v6-0-48761dbb96d7@baylibre.com>
 <20260618-wip-stmark2-dac-v6-1-48761dbb96d7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618-wip-stmark2-dac-v6-1-48761dbb96d7@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 18, 2026 at 11:04:15PM +0200, Angelo Dureghello wrote:

> Add basic version of mcf54415 DAC driver. DAC is embedded in the SoC and
> DAC configuration registers are mapped in the internal IO address space.
> 
> The DAC accepts a 12-bit digital signal and creates a monotonic 12-bit
> analog output varying from DAC_VREFL to DAC_VREFH. The DAC module
> consists of a conversion unit, an output amplifier, and the associated
> digital control blocks. Default register values for DAC_VREFL and DAC_VREFH
> are respectively 0 and 0xfff, left untouched in this initial version.
> 
> This initial version of the driver is minimalistic, "output raw" only, to
> be extended in the future. DMA and external sync are disabled, default mode
> is high speed, default format is right-justified 12-bit on 16-bit word.

...

> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>

> +#include <linux/io.h>

Is it used now?

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>

...

> +	platform_set_drvdata(pdev, indio_dev);

Is it used?

...

Otherwise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


