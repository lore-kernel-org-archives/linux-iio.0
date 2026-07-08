Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADE432BF6;
	Wed,  8 Jul 2026 11:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783510329; cv=none; b=GKaGoj2WA6E4E7duj33jRc4o9rDiVFDKJOiIQFkJ8qFOHGeZtTCNSLWAnM/8tYEsDKS0AiJIvjdmKBdI8RF2WOIENNJ17Fg3JIAZylOjpG4oz0yj3zZ/sEdnPzFuS19tbWSqVktuDQxUFApSJK0OmX4RuwPwlgqAXIi2jB9xChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783510329; c=relaxed/simple;
	bh=XVx3vKYNLH3qA2psRIM/a2V36roIvIUJSmHhDT/Mfts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kk+giJrVcxLCrbxJTy47ClcnPruywNnhePC/Ezy5PaMOIa9slAd1AYAditV5pd63yxnGax3b0gQv2axyDOXSzycaaz8fhbYwmQcv/1QIHF2CKqAawxgwwwNCYZ/MxZGfoiUaVZ4/guV24W5xzIcoPgKiPLoN8vAvFNX7NGrlLJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ho9teVTe; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ho9teVTe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783510327; x=1815046327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XVx3vKYNLH3qA2psRIM/a2V36roIvIUJSmHhDT/Mfts=;
  b=ho9teVTeXDmLBQC4Mkygz4e87910ceS3I+pDCaYVXVMBwS/IdNtXffYF
   iplQ9w8vfODn6V387ph6fEhcF11pMtFiVZrDSZra7CaFf/KUjOoNv42mE
   Fe2XgMXG0TD/Onkgzbb9hHMUeveVMQZRojHAaC/ItiYoAlLFJ6fYPzHav
   H47hJ7oNRhZenG8/Dy7aIg7Qzj5MiUiQah0O40q3bR0zZ5/eE2f5CwSVY
   CakGVTwlyNWt7Y4t2b24bRxYcZSv2q6GE4UheLApLp40+7AnFNwBR5IjN
   ul1m6W+1H2C+XBX+xAt2FYwyGDPISG9eoB8jkMkSPVAAIoONjorw9wM1L
   w==;
X-CSE-ConnectionGUID: QA+MVCsHQ5Ob3r2rn2MFJQ==
X-CSE-MsgGUID: 2uQ0PeA8RKKgg3bzPrSaag==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="83147528"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="83147528"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:32:06 -0700
X-CSE-ConnectionGUID: nLomc+jpSGW0M6+jBnxUjw==
X-CSE-MsgGUID: a23HxCJOREydOqKG/YQXjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="250280686"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2026 04:32:04 -0700
Date: Wed, 8 Jul 2026 14:32:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lukas Metz <lukas.metz@gmx.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: dac: dac8163: Add driver for DAC8163
Message-ID: <ak41MZNHFvVzeq6Z@ashevche-desk.local>
References: <20260708-dac8163-work-v2-0-3acd1bf20182@gmx.net>
 <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260708-dac8163-work-v2-2-3acd1bf20182@gmx.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 08, 2026 at 11:52:44AM +0200, Lukas Metz wrote:
> The DAC756x, DAC816x, and DAC856x devices are low-power, voltage-output,
> dual-channel, 12-, 14-, and 16-bit digital-to-analog converters (DACs),
> respectively. These devices include a 2.5-V, 4-ppm/°C internal
> reference, giving a full-scale output voltage range of 2.5 V or 5 V.

At the first glance it seems I already commented on the issues in this driver.
Yes, I see that I commented

  "Leave trailing commas in the non-terminator entries here and there."

and in several places in this version it has not been addressed.
Taking into account this I don't want to go through and check what
else is missing, so please go again to v1 and carefully read *all*
the comments and either address them, or explain why it's not done.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/err.h>

> +#include <linux/errno.h>

Not needed, err.h provides for standard error codes.

> +#include <linux/gpio/consumer.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/stddef.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

-- 
With Best Regards,
Andy Shevchenko


