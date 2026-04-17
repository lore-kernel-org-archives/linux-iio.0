Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764D4364042
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776414583; cv=none; b=hRmmxU3wZaIV2IaZelRneBO6WV6K0Eskmne+c1IGPZ+GOg7jKn9lHqFMuzyV/hme/YHQfcWxBrynlwcFlG0bm23oZDrG7fvRM5SABG8bAfauVOeKBrqsD89m+FZ0Y0Y3HPjDR4lgWTSC+FEpmEFPEnwNMcYdNZlnkN0zAZ0pzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776414583; c=relaxed/simple;
	bh=hbJ4gpkQ2I/Fh/0bjFBbOiqINz+Yt3eLQ5ANjDNha1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0NWL38vC5FPjqEn1ALa1YV2zZpN9ijsDL90NxFAL7QR40pl/KtjjxfyICCfJlt7LrL+DtTrsi/7q4yfS5OsRSM4wKp+7iKfji0L7Fn+BjzMbbvJMIKuqME1co6cjfQyJAaZivGuMVAq1wUcaFrIqKXMJMorjx8f8o/DaJ0wsm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aFzgN+zL; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aFzgN+zL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776414583; x=1807950583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hbJ4gpkQ2I/Fh/0bjFBbOiqINz+Yt3eLQ5ANjDNha1I=;
  b=aFzgN+zLyGnNfl8o5g45YdbcgZQagHWseivN9u5ZeE723kPWPVRcaHbV
   KVK1rImJYaDAlSNgDwS/NtdG6ryCTVjUK6vwrOxuVFqUvVw1OLcHNVBTR
   D9O2ja1SYcPlGV8xhyHAb92n7omBV/0OyQvmNJVuMsxlvntTFDBV6xocq
   RcOcJAgl/AgovAyRO5oqdWrbTPk9dec5UWAjGXGQZYqKhnRUjW7wwG1q5
   kTUv+IwAYMBgJu/KARohtdZCvmD6RfZmm4YzFk8+ntSA4vbfhb47rIN6u
   LC01lIxZu/9h+25PKtwIBW74rC/UHS5DBTSCaUAWEjWzI1ZKEGUHc87R6
   Q==;
X-CSE-ConnectionGUID: QDLyqB5fQTyNy8aCruvrOg==
X-CSE-MsgGUID: d/WtH4nZT0C032WWLfx20w==
X-IronPort-AV: E=McAfee;i="6800,10657,11761"; a="88880869"
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="88880869"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:29:42 -0700
X-CSE-ConnectionGUID: xnKefiXVS3y6r7VhC2rd7A==
X-CSE-MsgGUID: mgvGKEQ5S7KT/YJ0xhwgEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,183,1770624000"; 
   d="scan'208";a="227852543"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2026 01:29:38 -0700
Date: Fri, 17 Apr 2026 11:29:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Machado Lage <marcelomlage@usp.br>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Vinicius Lira <vinilira@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp3422: write bit operations with bitfield
 macros
Message-ID: <aeHvcCcQ1Xv5PuiC@ashevche-desk.local>
References: <20260417005041.484742-1-marcelomlage@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260417005041.484742-1-marcelomlage@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 09:50:40PM -0300, Marcelo Machado Lage wrote:
> Replace manual bit manipulations with GENMASK(), FIELD_GET(),
> FIELD_PREP() and FIELD_MODIFY() calls. The resulting code is more
> readable and maintainable, and some macros previously defined in the
> header are not needed anymore.

...

> -#define MCP3422_CHANNEL_MASK	0x60
> -#define MCP3422_PGA_MASK	0x03
> -#define MCP3422_SRATE_MASK	0x0C
> +#define MCP3422_CHANNEL_MASK	GENMASK(6, 5)
> +#define MCP3422_PGA_MASK	GENMASK(1, 0)
> +#define MCP3422_SRATE_MASK	GENMASK(3, 2)

Please, split this change and also add now missing bits.h
(bitfield.h doesn't cover it).

While doing that, convert all eligible constants.

-- 
With Best Regards,
Andy Shevchenko


