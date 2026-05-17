Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02662F7EF9;
	Sun, 17 May 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779013890; cv=none; b=F2btyliGd5znEPmI+YXo1OPVuRnrOAlEzHr8S2hLVqLo7nM8DEGwwozSTRFs8TPlKRe8IFKyvGrWRsOEd5f9ct62cSwYJE5Rss1bYIkV/EWnuc7G9jxQ+HywsOpaggsFfSn+20PkevAaUjPFftYPBXbZbVvS2l0cNPIiJ1Zihz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779013890; c=relaxed/simple;
	bh=LfjH/eYVEzcPggH25+3rLRhyZoP4iEt32pTkWq7+qLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F29DzO+7ET/P/iJXd5I2nOcwdanJq7ZNsn8FRgO+AZfe5t/ZMkYQg7FH90sd1dMzcg/9EpIAMHMu/rACQeFGP3UdEdvt/EnGpXaViBgWdcXiuJdXwflaT6ZV4/3iRnT3+tjybYtBgpavpwTiHsZbDNb22joYBIcX3NF2hv7G5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWI9dMDl; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWI9dMDl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779013889; x=1810549889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LfjH/eYVEzcPggH25+3rLRhyZoP4iEt32pTkWq7+qLc=;
  b=AWI9dMDl4R7eISHs/7YlprMTYWct7VOOhsHgBhgXV/GtS2mQTL7255Hu
   TdYZ6PygwJRmrNo65MxEI08CLsPdKv30uQP38AXvaNBCoB+vfUR9JD/9c
   oLJxT0BifBg2+9KmrJGVWI8vQUrAwTbdRrAiMJZARHKJocYFSBs9HLBfj
   BbLweT5Gv6IvuFeACYPpGpaB/gIhCbQlKQfnF3ECCnFUesPxv90CMK9yK
   MyaNPtB0GnpK5Lqehr7DPoiXX76Vcfc3VGDVl+J5MdRPhM0kO48poYsOU
   oP8gQfZdbVwUtGKucYPVi22AYq9kWb9Hpw6jbENCPBl3krtOzUT4oD/ZH
   w==;
X-CSE-ConnectionGUID: QKjar6xHRymuGQpJwnIIzw==
X-CSE-MsgGUID: L9yaYDsHSrS2+IYBPsdANg==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="90474891"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="90474891"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:31:28 -0700
X-CSE-ConnectionGUID: 9vthxbC/T2ix1VQ5Rfalrg==
X-CSE-MsgGUID: tKkl2KbLTnC/Y/6w0Ysr4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="239245796"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 03:31:25 -0700
Date: Sun, 17 May 2026 13:31:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, tglx@kernel.org, christophe.jaillet@wanadoo.fr,
	mingo@kernel.org, kees@kernel.org,
	nabijaczleweli@nabijaczleweli.xyz, kyungmin.park@samsung.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/12] iio: ssp_sensors: cancel delayed work_refresh
 on remove
Message-ID: <agmY-jPxZvopmfuq@ashevche-desk.local>
References: <20260515174017.3962168-1-sanjayembedded@gmail.com>
 <20260515174017.3962168-2-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515174017.3962168-2-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 11:10:06PM +0530, Sanjay Chitroda wrote:

> The work_refresh may still be pending or running when the device is
> removed, cancel the delayed work_refresh in remove path.

...

>  	free_irq(data->spi->irq, data);
> +	cancel_delayed_work_sync(&data->work_refresh);

In another thread it was (is) a discussion about cancel_ vs. disable_.
I.o.w. the Q is can anything trigger (schedule) a new work after this point?
For example, some user space sysfs node or other means of ABI.

>  	timer_delete_sync(&data->wdt_timer);
>  	cancel_work_sync(&data->work_wdt);

-- 
With Best Regards,
Andy Shevchenko


