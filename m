Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D84246782;
	Thu,  2 Apr 2026 08:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775119425; cv=none; b=B1Bl/9fOtuMAaV/s5HNH4paN0wbcBTcJD5UZEKjdNDita982Hsr0enGiC8TVjcxvhkL5cV9JtrCOdARqspB0nIwOyC3CFrOSJdkx5kW0ljjncB7lRAph5M/QNQgXZqcozkjOmGFkSUsTDXQXt62Dq5O6Mf8bzTzlG0yvW5f1mI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775119425; c=relaxed/simple;
	bh=DAeLaRbwEGpG12OxiKHBdDUKIDOSbjgDMk8n0IAwzf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3CorEp0kasnmlhBC4vT5iODhkh4XT9lDdWsKUhJMe0jn1IVrySeDoOP1j5qFNluRGltOa0DddEZBouW/9A4ufAiaHmUWDs8WxQeJsu/cYTwwpePyigHwTv6Ux7NyQccwaApGghlO+MDzaSENGNaRlinVNCcXR1PRNscsP2gEJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4pnX5LM; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4pnX5LM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775119424; x=1806655424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DAeLaRbwEGpG12OxiKHBdDUKIDOSbjgDMk8n0IAwzf4=;
  b=S4pnX5LMvVFiCEMxX0fNI8XQDRcp+MhoP6aX07oHmGQ605pzf7nlCz84
   /CByvsDzXPEG/697FRTHeJek7brviHjt2tyMmEbryq9b1fzEZBxCxZ0cS
   xGjZHjSrThuoPOs366+UwIPBjQ1yJWEVsslUPsFmo+phcAU63dbqF5203
   pf0a+TfTC2SzqnCM7CRrxRUnnGteH17xVGsU4ae3SeAU46kOWweXw4X5L
   Lf022zh5sDGij+tg7MS+Ps2YtWwQlECokjPuyBWBlU6AJEV8Gpahlq3AW
   smPNNMGH04TKRTMJgCs4VNXi9fNv87w7AyvGWo+Jt8jMijyssc86GQSOq
   g==;
X-CSE-ConnectionGUID: 7vF9FOP+SCaSSzhcShUrxw==
X-CSE-MsgGUID: VydElqWaQ6GZSBlS4zpH0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76054204"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="76054204"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:43:43 -0700
X-CSE-ConnectionGUID: CCtSA4PATT6iPxmFk2s5kw==
X-CSE-MsgGUID: Ge8Z8s8YTWigVApWdF624w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; 
   d="scan'208";a="226082690"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.31])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2026 01:43:40 -0700
Date: Thu, 2 Apr 2026 11:43:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sheng Kun Chang <nothingchang@mirrorstack.ai>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	gregkh@linuxfoundation.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Move adis16203 inclinometer driver out of staging
Message-ID: <ac4sOgGSTiKx1S0d@ashevche-desk.local>
References: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401162458.88110-1-nothingchang@mirrorstack.ai>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 01, 2026 at 04:24:54PM +0000, Sheng Kun Chang wrote:
> This series moves the ADIS16203 Programmable 360 Degrees Inclinometer
> driver out of staging and into drivers/iio/accel/.
> 
> The driver already uses standard IIO channel interfaces and devm
> managed APIs. The only missing piece was devicetree binding
> documentation, which is added in patch 1.
> 
> Patch 1: Add devicetree binding documentation
> Patch 2: Fix MODULE_LICENSE to match SPDX identifier
> Patch 3: Move the driver from staging to drivers/iio/accel/

Please, add also MAINTAINERS record.

-- 
With Best Regards,
Andy Shevchenko


