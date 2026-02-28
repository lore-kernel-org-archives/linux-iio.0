Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E1C350295;
	Sat, 28 Feb 2026 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772276724; cv=none; b=YhAVW/BVCuCBbwLlthsnxMGsQ2XgjeA6ogWncdiaCjNxNKf7Q46pDxdEaAAkCJf94KlEAyCsDHG22oEqo721L/bLtaxLcRRxRjBPzpG1k0vS/egK5XIXnzKtJlvbOgnzo8OuBg3t5gYOr+B8lTaiJjTKGocfgElJky9x99+arKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772276724; c=relaxed/simple;
	bh=rq0ph85dWcyWbSi+4Qp4VTvQwLfqWLHi7KeqN0ZQwtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oxpI8YzhXgbm770dSQ1dYTxbYez1t/t19sF95Dyj9FmmoWgAnmw8KDN2GY7cGb2VX3BijiprNyGbhDM0sPTnANFOnencmh+NpKT48yoM7P13cAfdY/Vng5ByEdOawfe8QGHA/2sBdMxm3rqHLkpFjo5uNW2UKRg2mg/rz7y+t+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i3wiRyz+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i3wiRyz+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772276723; x=1803812723;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rq0ph85dWcyWbSi+4Qp4VTvQwLfqWLHi7KeqN0ZQwtk=;
  b=i3wiRyz+fvypeAlHYZI/XuarQ/A1g6Dsltby8o8XDreI0NMxjwJLSZKb
   p94xwebgY153ueWlv9R+t5Mr3aA6F3KH06zgFP8wQK9JmDCqiD7ABi/9n
   BLcMdW/Syo5cAdUQGfnkBlvMoEFRuLXxVIaVTth91yHnR59JsYksQ7R47
   /sjnmXSkm/kRu/sjGDKPJEHjwIyIWKB5ripbOt5J0Zoo9nRkPtr8m4u7w
   xkDijgn5SRJwzTm1/+TsvhLgNoYgBEDNY+oevqkv2AaOxgvZhHFW6bJN8
   jSbyXuoppAF2zJZ6jV0/xilSfl/sUiiAL8ilPBi/sJr2G6WkY6ZUgJfc3
   A==;
X-CSE-ConnectionGUID: +k/YNr70SxG2IXcC3AACgQ==
X-CSE-MsgGUID: cF2jHkUYSpSbM74rlR9BVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="75953678"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="75953678"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:05:23 -0800
X-CSE-ConnectionGUID: 5MgPh792Q3q4ykHn7Dwv2A==
X-CSE-MsgGUID: SsyBO0nPSgyPsOJ7pIdDWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="214489971"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.224])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 03:05:21 -0800
Date: Sat, 28 Feb 2026 13:05:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: move mutex init before IRQ
 registration
Message-ID: <aaLL7qHSQWMzwadp@ashevche-desk.local>
References: <20260227133331.66968-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227133331.66968-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 03:33:30PM +0200, Antoniu Miclaus wrote:
> Move devm_mutex_init() before ade9000_request_irq() calls so that
> st->lock is initialized before any handler that depends on it can run.

Sounds good. The technique to reproduce this (in case you have a HWr
to make sure probe runs) the kernel configuration should have
CONFIG_DEBUG_SHIRQ=y (and in some cases a tweak in the code to flag
IRQ as shared).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


