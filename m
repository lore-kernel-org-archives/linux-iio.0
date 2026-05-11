Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAFD37C914;
	Mon, 11 May 2026 07:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484468; cv=none; b=sZzVFZUrsZNRwLNX4xWcOkyor5Zqe0BiFWH5HK3RuK3/oFYM23VPV4JfHBF+TN1otscK+wezrTOzysdB+8EnOlsdwfX1UrkA/cYVCLlLljx5EE5aCR8dnuWVqcVUWcS6imGp1ljKjCQGr2666wiPk/Y28KwmuR+Mee+620Huezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484468; c=relaxed/simple;
	bh=7LIFC7xL0p/bvkvxu7hyqAg2yAYsJR2/Qt+cmDA8eFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5UUpidj29y5Y7XKXEy3sSUB7dfhUtk/DETTBY12sV5jcVwleh/nYtkxDvQOwiuCbPGIi76jjCNWTMiDYV2VxDCSvVArjOXOBJaI9R09IXdXAR8XFzuaHIpbT55GtVZIcKwfNZ+GACXtjsmZ0REQGdbNBshg/Syzc+K4X4zoryo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lKHNbuij; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lKHNbuij"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778484466; x=1810020466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7LIFC7xL0p/bvkvxu7hyqAg2yAYsJR2/Qt+cmDA8eFQ=;
  b=lKHNbuijbaEJDPNhwTutvLXE9SPSeWfRxwPBknszuB4HVhDlSS+KwFye
   9gX13AToTQQqARscd9IVoUuXt5V0hOblkFRl292uHaFqqycPBu36amk7f
   oGeSE1Jlqi0mS5wu8ZviwEG+jOjQgxCI5SfdMmG795//p6M58SwWM3RUm
   PJsNXA96dU+aEviNva38yLcdE7K6d3rDBHCH/rHX/KWbozoMKj8VL5Y+M
   ksOj5yjNUiKZ5bqqGtyc8bHdGeF+osaOLwDVcdne5yVleIuns5lyBCI4o
   ExomNIomeZ7FupaKgawJNY0iOa5QG42WiFt9hXHyqArQ9VOHjjJ94OndG
   w==;
X-CSE-ConnectionGUID: BdtEW5YzQnuzmojgLGoGyQ==
X-CSE-MsgGUID: RH/pcZsJS5GZzQe7oBrEvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81928822"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="81928822"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:27:45 -0700
X-CSE-ConnectionGUID: bBinn1iZSNaKZY9AAZ7etg==
X-CSE-MsgGUID: ufyV+0I7TLCdc4H3eDFxIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="230989065"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 00:27:43 -0700
Date: Mon, 11 May 2026 10:27:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	puranjay@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl355: replace usleep_range() with
 fsleep()
Message-ID: <agGE7F5zm2pN_dBk@ashevche-desk.local>
References: <20260510113853.50019-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510113853.50019-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 04:38:52PM +0500, Stepan Ionichev wrote:
> The "at least 5ms" wait after software reset has no specific upper
> bound. Use fsleep() with 5 * USEC_PER_MSEC to make the unit
> explicit at the call site.

> No functional change.

Strictly speaking the upper limit is not set as 10 milliseconds now,
but defined by the internals of fsleep(), usually +25%.

Perhaps Jonathan can just drop this sentence from the commit message
whilst applying.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


