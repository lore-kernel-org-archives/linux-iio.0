Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22B0191F91;
	Sun, 10 May 2026 18:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778437130; cv=none; b=lFJiwIeKa+jKw9Ah4DwYNwud/UiDLwsWimzRXcoe8q7Qr9vQhVlpIHd05t0ZEtJqW1JnCb1IE+XnB58sHIGZ/WZ7a2/CNTueZcpgzbaJLQ1vLivxXM/ydrXF92u2cKdG5taCAoZxkBsBLunWs9rBrdSPuaXWm/b6QsvZrhAPpmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778437130; c=relaxed/simple;
	bh=Wo6ciYnwp7VrRlzM17PKmckf3vb/nFBdz1p6Dfz8p54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jj3IU1MoBgu46cRxWt0j9oJVPShRUakEnxfEWCrnyaMFhFUrHGiLNinUXt+ERz/tGkqIUqVcOIlumFFxX9x9u0oe2s4Sj8sReUZDHYfAMW8I1fV26WAlwiRhxt7GbSZwE2svMNW55YdYhsgFMz7btGWxpb5y89ffygO7ANYyS6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJHLMY3Z; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJHLMY3Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778437129; x=1809973129;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wo6ciYnwp7VrRlzM17PKmckf3vb/nFBdz1p6Dfz8p54=;
  b=lJHLMY3Zmg+giS1rcuthpWRA5o1RAe9hMhcwMTcWv4TAyBRoBtvyTZic
   YirSgjiurY8kibX5GUedR5f14giD//8ROizhLAMALqLRMOqEPKF6P12or
   B+TmU1YtufqBUOTh5QxFAKs+P3ceS6m6kW0P+K/j45155ru31YT5d8c8j
   Yq2/N5XM0+NviySCez3/wpShbCADOs2MRhGsyk1olHzet9cic8WUqPsbn
   Oopk4gDBViL4whWQoqUjCBqF4pmjd6jVIcgr1Z9YCWvGHuEhhpoNsPaxp
   IyMjOV1z0YUy0DXbqK8IuNvbEuVfAhraPmdytlBDPBPDW0zJwhm+bJe7h
   A==;
X-CSE-ConnectionGUID: 0AtX7xhcRyyGxFgmgzCxyw==
X-CSE-MsgGUID: DAQwsctUS0yluCmrtv0h5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="89641454"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="89641454"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:18:48 -0700
X-CSE-ConnectionGUID: 418/jP/iTg+lMKEE+Litqg==
X-CSE-MsgGUID: VehhhkgVSLuscYIYskjCtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241231618"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:18:45 -0700
Date: Sun, 10 May 2026 21:18:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: azkali.limited@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, CTCaer <ctcaer@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: bh1730: Add bh1730 light sensor driver
Message-ID: <agDMAiBUtXLamFHY@ashevche-desk.local>
References: <20260511-bh1730-v1-0-e0df1f499135@gmail.com>
 <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-bh1730-v1-2-e0df1f499135@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:09:50AM +0700, Alexandre Hamamdjian via B4 Relay wrote:

> Add a driver for the ROHM BH1730FVC ambient light sensor. The device
> is a 16-bit I2C digital sensor with separate visible and infrared
> photodiodes, four selectable gains (1x/2x/64x/128x) and a programmable
> integration time.
> 
> The driver exposes illuminance via IIO, performs runtime gain and
> integration-time tracking to keep the ADC in range, and supports
> optional als-vdd / als-vid regulators. Per-board lux calibration data
> (integration cycles, lux multiplier, optical-window coefficients, and
> gain sensitivity coefficients) can be supplied via device tree;
> sensible defaults are used otherwise.

> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>

> +#include <linux/of.h>

Regular drivers do not to be OF-centric. This won't allow them to be used
outside of OF-only platforms.

> +#include <linux/time.h>
> +#include <linux/regulator/consumer.h>

Missing a lot of headers, follow IWYU.

...


Here I stop my review and recommend you first to review others' patches and
learn from other reviews. This will help you a lot with avoiding typical
mistakes.

Also Matti would be the best reviewer for this as he worked (still works?)
for ROHM and knows the HW a bit more than average kernel developer.

-- 
With Best Regards,
Andy Shevchenko


