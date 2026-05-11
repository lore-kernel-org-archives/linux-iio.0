Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4423029C328;
	Mon, 11 May 2026 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778505821; cv=none; b=m5FrWu2Ijgr4VxaPJ5Nt3l3BxPnP7ssedSBlHhZdw0kelz7R6S9TyokROgT9zOC7dEa4B76mgU/zHogurPx8V6xnVanIHmraKqyoFEwY4Ift56CaJfSZkCDuy42cwYkL7YAF8ccoGRHLAwcbgUCvPkHf2A7WiylAag7k+b0OZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778505821; c=relaxed/simple;
	bh=xEqLPQVY3OdExRLGBBRfr7eX/EsUjFIbnWKcS5G4GJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd9YV30vzmYCi7y+lEF+sqA8wJytUgADqgriCDdccyhCY7IvM1119cMNQiCAu3mpPkGIUesfJj/Mu87fjf8D1enrvHFQ8IMs8YtfN+spf+Bw9Xaau4i4iS2DzklIZh/Fy7oTQ+YTxfLAc0SwXETApDNNrVOmcoqQJ1s+W3GAJ0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIXos+kI; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIXos+kI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778505820; x=1810041820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xEqLPQVY3OdExRLGBBRfr7eX/EsUjFIbnWKcS5G4GJo=;
  b=FIXos+kIWfGlyL1NNDyJSCIlQdmzuMl68IOWZdCNc8kvWl8iCFLHkfUL
   FH65k++iXLF39yWES4LhiBlSq9ZFWpAy73MbniUQUzebmWKJVzZw7vbm7
   AsJIikUCZ4koG/k1aHwIxYtC3cbNE4vwML9D+qZ0Rkehp2RabRCxLJ6zd
   yl0E5qo2Vl4cp0MVmHaTaXTBKZuQ3nSm/DkuGc8PwPXnN73b30c7uHm+C
   Q85P7CkOO7INitmoQcUsfLVsygXIYE1vR63+Jg/4aqeIw+ZjuQzynDGXi
   +Xn6VE1oh0U3dG5+ioVaPBevP1AXfcrIQ/yVkO8QS3zn4qZbnzpbwhXon
   A==;
X-CSE-ConnectionGUID: b9HoocCETxi2u0tdVr673w==
X-CSE-MsgGUID: xqa/zfYNQeytOmSTDP8txw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79572528"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79572528"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:23:31 -0700
X-CSE-ConnectionGUID: B84ACLHzTYWAkW3zbxXS4g==
X-CSE-MsgGUID: PT9mKmUiRMmIrZcVf8NoVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="234785014"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:23:28 -0700
Date: Mon, 11 May 2026 16:23:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: frequency: adrf6780: replace usleep_range() with
 fsleep()
Message-ID: <agHYTpgmec5nDosZ@ashevche-desk.local>
References: <20260511054441.2980-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511054441.2980-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 10:44:41AM +0500, Stepan Ionichev wrote:
> The ADRF6780 datasheet (Rev. D, page 23, ADC section) says:
> "Wait approximately 200 us for the ADC to be ready."
> 
> fsleep(200) expands to the same usleep_range(200, 250). Use the
> flexible sleep helper, which picks the right primitive for the
> given microsecond delay.
> 
> Replace the generic "Recommended delay for the ADC to be ready"
> comment with the datasheet reference so the "why" of the wait is
> visible at the call site.
> 
> No functional change.

In this case the commit message is fine.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


