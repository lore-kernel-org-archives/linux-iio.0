Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459DB35949;
	Mon, 23 Feb 2026 09:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771837278; cv=none; b=PUuWnFx2+6QfRwaf9G6buaARtKfFVy/5uHXAnsP8gkAB6KY8AiY9zPeXqgsgAnVEE6390skO9gF8oHShQIUH/m6cJzFmeg43QyLCy5FKPWvAvoA60Z5U4vCR5Y7PSBFpu1Ym/FABMJuy0XBmc8zyHKCQHDaX3GAU9yfrZt2YIKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771837278; c=relaxed/simple;
	bh=5FN1e40lDSoiIRK7AQ41FGbo2Spk5yMwgh5W8zpq7eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex2xxkXxr65iKT4oPUqOR2mUWXv/n2pAgLuseUFiOGnVkW+Ww+HWlVSiRIvyg8l09fOeSEnuBY9BmI8fv7AxoO4gppw8EjViNm5zBWAGFHAcuygZf0IxaTtcLXgdxhyx1lNZaavn2lb8jV9xQnUQ5nese+s7D8qNuw2ocTukz88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LAg3rq7L; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LAg3rq7L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771837277; x=1803373277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5FN1e40lDSoiIRK7AQ41FGbo2Spk5yMwgh5W8zpq7eA=;
  b=LAg3rq7LMGBRBP4NDNCpY1NTU+A7/Hnis2TnpOGcYgoQGVK5eN4YRmAS
   Run1ZezJQG12LmM5WfM62A1uzSTYWz5ltcuDA0jlX78Q63tb5b5ujfCQi
   084a6dE9mD+OQjUeL19g67Cm3tFLsn+h1LR4xd2KJJQ9pbjy3ROH1y9q3
   CwGgT9Ziq2EN9DA1xCQ65qpbJjOA58A9UraIXIQW7URntMnUak36HR6cd
   hm+PZL6e6d1LPwGOTEJLOpsBEIPSbBIYUvMbA227Qj8qn3E4OAKiOgPWK
   1zbbWg0SrQ6pZsa//MRgjAbkkOwnJ5YOymn0j+kWI2F4XNf/fNGVBtrm6
   Q==;
X-CSE-ConnectionGUID: RWR2+bzqTT+CSyc5fzZ4CA==
X-CSE-MsgGUID: 7eYlRk6SR2OCQYDRlPAUXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="83539795"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="83539795"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:01:16 -0800
X-CSE-ConnectionGUID: 06ZpR117RpanHM1IoW6pbQ==
X-CSE-MsgGUID: bP47vWtETSOwlOc7MwC/tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="246093975"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 01:01:12 -0800
Date: Mon, 23 Feb 2026 11:01:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Felix Gu <ustc.gu@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Jorge Marques <jorge.marques@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4062: Replace IRQF_ONESHOT with
 IRQF_NO_THREAD
Message-ID: <aZwXVZ-eq3OULitA@smile.fi.intel.com>
References: <20260223-ad4062-v1-1-8ee93ea173a6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-ad4062-v1-1-8ee93ea173a6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 02:45:13PM +0800, Felix Gu wrote:
> In ad4062_request_irq(), when request irq for "gp1", the code uses
> IRQF_ONESHOT flag, which is not appropriate for a primary handler
> that does not have a secondary threaded handler.
> 
> And since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler"), the IRQ core checks IRQF_ONESHOT flag
> in IRQ request and gives a warning if there is no threaded handler.
> 
> Since there is no threaded handler, replace devm_request_threaded_irq
> with devm_request_irq, and replace IRQF_ONESHOT with IRQF_NO_THREAD.
> 
> Also remove an extraneous semicolon at the end of
> ad4062_write_raw_dispatch().
> 
> Found by code review, compile pass.

Wondering if @bigeasy already sent a patch for this.

-- 
With Best Regards,
Andy Shevchenko


