Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B782D97A6;
	Tue, 27 Jan 2026 15:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526234; cv=none; b=uOWyI9tp32EO4JUSDZrtI3Wah6PFyfqSGbZ2ZYzQVnetVCnDqKRcPa1VD3lXxT8/wf4pPXuNyW7gqWh45F8NwEq+B5k9CUISjr1030vqmaAFcP0kts0CbV8+iTEh+JGuNPdjq0WjCWqnhsEusPyYPuIxUF0lf2UzESbZJV7cxr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526234; c=relaxed/simple;
	bh=S9pFT1rLbsisPZyKFZV837mgzqhq13rR9qAvzpCz7mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcPOZapFk5cwbkIbTN+i2fdhanZvNJW24x/uD+7u6IvwvbDtURZde8zoHmvPkxRgrzfyc4FUfll39WYp4pWXe9qMWJeV1UfxCPAZ2Ul70lY1hov3TdoSrxupn3L0SoaHVJhDP5WZd0GBMvFcBlBLYamoY2ZDqM3+wLhe1Xbj8jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CxFEGDx+; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CxFEGDx+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769526232; x=1801062232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S9pFT1rLbsisPZyKFZV837mgzqhq13rR9qAvzpCz7mU=;
  b=CxFEGDx+LxD8bf2WuPs8ObRrVwA8EG973weJU1OJPkLjjwPoxv2IwYna
   DvjZFo2ra7UzsCH5ONDgdedG++qz1/+aH0afC79NuMpECAG1ZBzU8hLex
   RnWsi+GvThbCQtwgRVTVnkdTaQi6bsmCx1dH8M7xEBS2DtAdNv0KrCvKi
   eHNxF8hFLR9sdb4eTeehnHmgnMrsmhWAxBhfeLA0lGJCdJORrVKaepXZ6
   gsKuq0pUOLeQ3uovebaWPFmdIJJbv/HnG0894FKNQtwE/t//nqbVu1MSD
   Ti8aiLvuY5qRJJOjcnUqvYF3e3/F2HxwRyrfQ5zQO6IzXz0qCln1fiRAS
   Q==;
X-CSE-ConnectionGUID: FZL8rkriSOqNGVQLgfDkYw==
X-CSE-MsgGUID: Ho4tXK6DTm29MfFDUZ8NOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70884110"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70884110"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 07:03:51 -0800
X-CSE-ConnectionGUID: 4LAM8vILRouB9T75Nw7T8g==
X-CSE-MsgGUID: +7XpMB4dSKqFW0z6CKOLSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208046713"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 07:03:49 -0800
Date: Tue, 27 Jan 2026 17:03:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 6/6] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aXjT0nzububDex2-@smile.fi.intel.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
 <20260127-b4-rfd77402_v5-v7-6-3e7f2d452da2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-b4-rfd77402_v5-v7-6-3e7f2d452da2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 01:02:20AM +0530, Shrikant Raskar via B4 Relay wrote:

> Add interrupt handling support to enable event-driven data acquisition
> instead of continuous polling. This improves responsiveness, reduces
> CPU overhead, and supports low-power operation by allowing the system
> to remain idle until an interrupt occurs.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
assuming the below is getting be addressed.
...

> +#define RFD77402_ICSR_CLR_CFG   BIT(0)
> +#define RFD77402_ICSR_CLR_TYPE  BIT(1)

You should use tabs for indenting the values. It's inconsistent with the rest.

-- 
With Best Regards,
Andy Shevchenko


