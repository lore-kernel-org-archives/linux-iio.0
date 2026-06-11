Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA4A347515
	for <linux-iio@vger.kernel.org>; Thu, 11 Jun 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161495; cv=none; b=T67CpB6OdV3lxOfb8sQeFDuQ2YNp9V6zb0K2ONbukT/ZNc8HOfNBwcDQEkRyLAFYEkyHusCtIvZn9M3TvMktnIhRbu/+mTGXr7ewt49xI2NWzFhXJVJ9ZLZh2fkMGTEDKmGu7EncEpM97trTtYxwMC0HCavRz1xgSQWEwak+C6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161495; c=relaxed/simple;
	bh=IW8V2ms/8bhLGgs2ZDNghko+DbeKdxtmI2MdTtMcbNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VFnVc+ej3zwvfAHKMDLloimSj1i/PdyHQxdpVe1aolWuMsjfiTEDsqSqD2KpenIcBxeJ3r4l41yxQxmqpkil161/BHB0aBgy329E4M5M3FrxNg+L62zezi4AmacQIJOFUUfo/VI3Zl1yybA/7bPVNak5aYwzzTULvMvm/1QAkEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R7gYRKHx; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R7gYRKHx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781161494; x=1812697494;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IW8V2ms/8bhLGgs2ZDNghko+DbeKdxtmI2MdTtMcbNM=;
  b=R7gYRKHxui8hpMXCU7g/j8ORhKnbZ3BlHCMK81binBWt5t/m35FHvfOB
   2ghNPorYpY/exOw8w5iUEBjl/WNjTn8F0Mg8sK8H/kl0g1aey929R+lEp
   HVMLMiomXjSSBlPeY1OgBcPJh/5AgDjGf9yz0SOM5MauSHjyq9gBYzHSj
   5lYGG6j9yFzQU1QmVV9/eaNTuVM191xr89DdXIVa+2P7EEzCWVuJHONvn
   uADMdOh1GgQoBgT1/Vqcnlw4/XhaeqBFg8j2YP1SOA7X82MrJ3//4P6OO
   pgC80DOT6v+4PUDPaCeZ8rgvbGPWmqKtEk80KFNTzJMZXcONk2J2UpBnU
   w==;
X-CSE-ConnectionGUID: yMEAImFhSSmIDzN3YMEmMQ==
X-CSE-MsgGUID: mvREasWzSIW/wGDQJi8nfA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="107405897"
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="107405897"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:04:53 -0700
X-CSE-ConnectionGUID: HX1RTsihS6CBY6+pwDJvHQ==
X-CSE-MsgGUID: NH7TIqioQGGAwbG7lNwGsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,198,1774335600"; 
   d="scan'208";a="245277702"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 00:04:51 -0700
Date: Thu, 11 Jun 2026 10:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Educg550 <educg550@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
	antoniu.miclaus@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	Lucca Ciriac <luccaciriac@usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: frequency: adf4377: replace mutex_lock/unlock
 with guard(mutex)()
Message-ID: <aipeEEERBMljxQcN@ashevche-desk.local>
References: <20260610132337.229687-1-educg550@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610132337.229687-1-educg550@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 10:23:37AM -0300, Educg550 wrote:

> Replace manual mutex_lock()/mutex_unlock() calls with guard(mutex)() from
> cleanup.h.
> 
> Using guard(mutex)() from cleanup.h allows the compiler to enforce lock
> release on every exit path, eliminating the error-prone manual lock/unlock
> pattern and the goto-based exit labels that existed in adf4377_get_freq()
> and adf4377_set_freq(). This reduces the chance of lock imbalance bugs.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


