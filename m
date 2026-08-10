Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0D43F8B9;
	Mon, 10 Aug 2026 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786389719; cv=none; b=rURuyUiTJuqyDY2MRs/tfKc29xLYim5wQuG4RmhbapWBXfv8dbwpKCJ3AfTqqm4/RW238cnjP88lKx5hMuFRvuaG025U1ZWmYU5VZA51V8kQNFkid+AIKumIm6224gZEPE1QRyXAy1q/QgsmE6I46aOtEcziPTH/1Wm7zVgj40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786389719; c=relaxed/simple;
	bh=EzwiOlEjLtHuJ5abMtEfyYDiUpYulexAeWtCmtJMcy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TQbLhehtU+oMJcju/3GL4RZFUDnR4ByrCA0exvaes4KsNkFZUm0/FNUakHT0b7mu6iiWZus+NCWy8LGVCE+LneseUq6cdAKvJd+NtPI8PaoUKmuSD/nJmwJxafWpn+I0yTa84UeHQtcaaD5KlvTw2ADhnqYJW8kYABa235XpMGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A+OZMxWQ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A+OZMxWQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786389716; x=1817925716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EzwiOlEjLtHuJ5abMtEfyYDiUpYulexAeWtCmtJMcy4=;
  b=A+OZMxWQ5zh9EhDRjR8jSt9welOdwzCO6Z7pAw7+33GXfbnl7oa+jiCm
   Yaojg/HWfJuExuRYhO8XPNRpn4Dq89rSvbovxYrpOFlvcFaqjO7gqsIp3
   dHciQ5vtxVbM1IRUxvnMGDv56H5LHeap9AmYFpJeLL+us1bBX3EoBiz7Y
   gJHcJmTXgUs65L0cFL4xZ2fyZaj9CkKSlimvhPlk1XXekwNFHVeeHICgA
   VdK1pkRAW6OYHXTpL2HYCn9yVSTBQn0UgsFYODLTucLFmSgRAtC/xmA+d
   5jF6N/ujHT578i1MJTRGFWAQSsQ9BNHXd320XbF6dG/KmahOxBeBmPqal
   g==;
X-CSE-ConnectionGUID: XraQQI74QqSqSB7p75e+zw==
X-CSE-MsgGUID: kkPEFvcVTMSkPBv6jXISUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90593627"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="90593627"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:21:55 -0700
X-CSE-ConnectionGUID: k06InC7XT4Wnhm3kgXBFvQ==
X-CSE-MsgGUID: PR5Iro5rQw6a/Rz1+5vL0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="266616753"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:21:51 -0700
Date: Mon, 10 Aug 2026 22:21:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stefan Popa <stefan.popa@analog.com>
Cc: linux-iio@vger.kernel.org, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, andy@kernel.org, nuno.sa@analog.com,
	linux@roeck-us.net, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com,
	ciprian.hegbeli@analog.com, siratul.islam@linux.dev,
	u.kleine-koenig@baylibre.com, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 2/2] iio: adc: add MAX40080 current-sense amplifier
 driver
Message-ID: <anokze3oDzq3oibL@ashevche-desk.local>
References: <20260730131738.822405-1-stefan.popa@analog.com>
 <20260730131738.822405-3-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260730131738.822405-3-stefan.popa@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 30, 2026 at 04:17:38PM +0300, Stefan Popa wrote:
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

> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/property.h>

+ types.h // uXX

> +#include <linux/unaligned.h>
> +#include <linux/units.h>

...

In general it _feels_ like some of the comments given in the previous rounds
were dropped or ignored. Is this true? Could it be that you mistakenly sent
one of the previous (early) versions?

That's why I stopped here.

-- 
With Best Regards,
Andy Shevchenko


