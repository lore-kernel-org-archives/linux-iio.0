Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388C530E0E0;
	Thu, 26 Feb 2026 08:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772093099; cv=none; b=sJnV4gxDr0ZVFQ3xoK/p+ZGkFbSXVE/Q23DhKwv/yxRUI1e1wLm/K4Ix5E/tvTAHluZSoUofFIA5Iu3lYjWWNOiMXSaUHGAPIOQ5SlTYTD9hikzNsN1IUFx8YelMl/vH9N7sMkD+ydYQIpS6Qs6Hs3SR2OpzjjR/TnTWB9NRyhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772093099; c=relaxed/simple;
	bh=eF7423Mj6eFQUyJb+g7FWRDLQdKmwQN21n+2dYFR1sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwvpdpCgYFWe1hfw9K6pMycEMOdPNRPv5rBNWKgw0qgyI4r8O9owiADyQ49PgV19Y6hHqYaj1IaGNh+oXjKODrtLJjwQqbuoERp1kwKXpKbEVOkAuS5c5uu/gPUOILjHd4glyXzORj1wr/qT5HUOUK6bubhdqb1HdBjmsG/OoUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQRB6Qqi; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQRB6Qqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772093099; x=1803629099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eF7423Mj6eFQUyJb+g7FWRDLQdKmwQN21n+2dYFR1sc=;
  b=cQRB6Qqi4oineaLpE75SIsQciqMcCLbu6xeBLfKLjekOitkD8He6CYOg
   NicrxIcVwpJN4gVbeYk7Gz5XULjHWf/O6mWMhIc2mD8yyjr2IYskkZ+B/
   lPV3HDffu3nlg+DS/QElnPnlAIsIvF30xC7ZvgLgLTSu1FIIYapV1ybfH
   nfJH5RrSKoUCK8kIHpdNVUR/cj3lmzl4VblTrloBFVQcOGin2/lbcRSPJ
   aycp+d1+iMXzizfYrvcv4Mg1IA5fBfSjj1vHlhsk/ynPD+ll5TteE7qLG
   /id4XyQzzrLC7yIzWyV/FsUp+L2KZhh+7ZjfrxaxYK1p3lW/qVqYExLyn
   A==;
X-CSE-ConnectionGUID: z8Ol0HasQ+6Aqy12OAXmCg==
X-CSE-MsgGUID: DmgAqbUNSUmUJs/zoUSeag==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="73018741"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="73018741"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 00:04:58 -0800
X-CSE-ConnectionGUID: o3jQRqw4SJqQPk9SqG2Hzg==
X-CSE-MsgGUID: 6QHY/hMHSqSw/xJ5JJg30w==
X-ExtLoop1: 1
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.167])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 00:04:56 -0800
Date: Thu, 26 Feb 2026 10:04:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: tsl2772: fix all kernel-doc warnings
Message-ID: <aZ_-pVTbTUkByPIJ@smile.fi.intel.com>
References: <20260226051258.555019-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226051258.555019-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Feb 25, 2026 at 09:12:57PM -0800, Randy Dunlap wrote:
> Use the correct kernel-doc notation for struct members to eliminate
> kernel-doc warnings:
> 
> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>  'prox_diode' not described in 'tsl2772_settings'
> Warning: include/linux/platform_data/tsl2772.h:88 struct member
>  'prox_power' not described in 'tsl2772_settings'

Hmm... I do not see any of the user of this header file.
Have you checked if these values are even used?
Perhaps we can simply kill all this?

But if Jonathan wants to take this as a quick fix to make less
warnings appear effective immediately I'm fine with the change
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


