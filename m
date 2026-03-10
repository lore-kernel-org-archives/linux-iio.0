Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EC12FDC3C
	for <linux-iio@vger.kernel.org>; Tue, 10 Mar 2026 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161857; cv=none; b=Xsea93qVBfcQU270b/+hr5MsBGgLPIXBlAXfT7leCmX6A4RURVB4bXc5WqQWxg+PrPeUoS+lLVuQH8Fv/Y1UKbBEag6iQq4LDAvFeX2IjXjXiE96OBf/HVXdMzbMncudeRO++s299gX9v9aL/bnIJ2ce2hkb83JgNWChHMAnPIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161857; c=relaxed/simple;
	bh=xDUExWp03wR0FVg4y550ggo87KqYyVfJ+zsBIX/aWkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eME6oxTo8InsvMkyM5gQ1v0xjt61fB+VswzofqsyGTjWWgSGSncTQi9r8BfNkV/D6gKBcGV4WIjcyLNcFIP3ZMQpo+JH6V21gqxTxblLqh9gLMRBLaAO/XS8DamIJZbjKbfBHNJBrbd1y0JcMt6TAj6WGLy7UHd7QTVNVjDm6Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y6I98xIE; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y6I98xIE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773161856; x=1804697856;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xDUExWp03wR0FVg4y550ggo87KqYyVfJ+zsBIX/aWkc=;
  b=Y6I98xIEMErXI6FnyArHmJ0SR9jkFtlgel56NdYbIu1zS/DgMltLkGA3
   tKfEBJ2U1d9ij6J7hAnTvlqzruTVqWOn2s5BL24mgoSHDcoSOBDRyIvNf
   ARFDL9jzvK58UMeIGbpMDOhteqR9rEhYbL7ynlWu8uTnair6lPCIQqYAV
   5sf+hv5rRHIs1zhlMXb7dptbWmXFgNT1TGl5qz7ljfc3JY91qjym+RT9G
   wQFFyj+PBFO+2bK6k84QoTMVxxP7G73RnS4JFCPLAT38NrnLHXIaCXOcN
   Awg/YwqAy0jM3cm83snpYKdMENE5LPUkjAkusfnhWWKXbgoUsuAB4fQYz
   A==;
X-CSE-ConnectionGUID: ciVG5AUGTVqu5Wka54lZkQ==
X-CSE-MsgGUID: EyLz8CX1Twa4wDnUR84o8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="78072454"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="78072454"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:57:35 -0700
X-CSE-ConnectionGUID: 3XMdzzIQQJeA7chhGBzkiQ==
X-CSE-MsgGUID: h5BfoBxiQx6zQousgoJQJA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="219308609"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 09:57:33 -0700
Date: Tue, 10 Mar 2026 18:57:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mt6359-auxadc: Fix comma spacing
Message-ID: <abBNesBmxjJfCx2J@ashevche-desk.local>
References: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310143809.83126-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 06:38:10PM +0400, Giorgi Tchankvetadze wrote:
> Fix incorrect whitespace around comma on line 325 to comply with
> kernel coding style. This silences checkpatch errors "ERROR: space
> prohibited before that ','" and "ERROR: space required after that ','".
> No functional change.

Is this the only issue (of a kind) in the whole drivers/iio/adc/ ?

The change LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
in case Jonathan wants to apply it independently to the answer.

-- 
With Best Regards,
Andy Shevchenko


