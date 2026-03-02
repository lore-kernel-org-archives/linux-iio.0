Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B81632C8;
	Mon,  2 Mar 2026 13:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457451; cv=none; b=gWo0HI7tESDmeP8IO0SCL5zQJHVxyvIAbnT+j7Y6fsXXGDeL4zsajcUiLk3B8+R3eZbImQrhfWsFeMJYHNAY68XFdnck+Owe0oVQKhixjxKd6lPB2Ru99UmurOgweVfeTcBDaQMxDrcrDMjv7CUWfrWO0g9VRCZ2qPUWC90O0yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457451; c=relaxed/simple;
	bh=T1hNKIqJI1oqMqIYYWkiCbkrxa90ysqQJEVPRPjJn1w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d9ca6I6hQX/6SwiV0vN9I94iJ/k1ODa4DiguCXhV5cUz4I1xWSkw88mOXvTI/9BPwXTBX3mrSpAm4tsx/ALs1PrOQvKfqMhseAq4J8yy54b3n9HWpGaO/DshhEcjX2Tsfy88HZeZdVapVOMDHHJMFS6ijiGS1m7hm8YiEPbIqfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cpM8It8c; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cpM8It8c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772457450; x=1803993450;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T1hNKIqJI1oqMqIYYWkiCbkrxa90ysqQJEVPRPjJn1w=;
  b=cpM8It8cvCICE6lL8wwv5QbV2xoXKADZkEP47kt2dWGRmAL/GKxphbcB
   aN1Orf0+stQ5SUZzpG6WYR+vl+XtCNSA2yNmTNSPpdbGvW6T8d2lxSE22
   rZn2m9Es1cdtjKHsmHGra8DObDm27XUgZXzNzvls0VRgxh4JFoMjrTf9E
   P+jLquQPXMzXJ34TRRg0sdgAvSS6q4U0d/+fQBYdwpOk5RIaSdYySrM9G
   fdLs8sXCUZM2y8eH/XVdo+IO13IEtc5pmPoONHOlYa8bQcl6nu4xzuDF2
   DkCnH5Xtd6kKdFOAWPyPNMCJbQZtnL1p7vaoAHKVoAKeuBYxB/XvDUgdV
   A==;
X-CSE-ConnectionGUID: z0Nkdo3sREKJz3py9x+Nlg==
X-CSE-MsgGUID: Xeow1v1kQmSpUIz8xKqZqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="91038663"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="91038663"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:17:30 -0800
X-CSE-ConnectionGUID: AQ7whNp1TKuDken6FpnDsA==
X-CSE-MsgGUID: zVOVBer6SXCf/1F9r8eJpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="217677785"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 05:17:27 -0800
Date: Mon, 2 Mar 2026 15:17:25 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: adc: ad799x: use devm_iio_device_register
 and drop remove
Message-ID: <aaWN5U9imwAq4bdy@ashevche-desk.local>
References: <20260302130632.29144-1-architanant5@gmail.com>
 <20260302130632.29144-5-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302130632.29144-5-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 06:36:32PM +0530, Archit Anant wrote:
> Convert the driver to use the device-managed versions of
> iio_device_register() and iio_triggered_buffer_setup().
> 
> Because all resources (buffer, regulators, IRQs, IIO device) are now
> managed by the devm core, the unwinding order is guaranteed to be
> safe and correct. We can safely remove all manual error handling goto
> labels in ad799x_probe() and delete the ad799x_remove() function
> entirely.
> 
> This eliminates boilerplate code and prevents future resource leaks.

...

>  	mutex_init(&st->lock);

Missed devm_mutex_init().

-- 
With Best Regards,
Andy Shevchenko


