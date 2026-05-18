Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E7DC370D44;
	Mon, 18 May 2026 18:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128266; cv=none; b=X4iZLkWu0qpgD4dXZl8zwKFMC3UJ0a1wrMKsocI3SBCfOxzKYrsEyvCalXBGygAlVgZQUcgwSzmLhlyehBnLbI/UTANH8Bk2MvMe5tSUcwo99U5Ehu4npOW5Z5wULIxPtZkbW8InRu+DKASliyNAq8MDhAumICWyW4yuEoQnDPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128266; c=relaxed/simple;
	bh=pcmJn69RbLvbSk47qbYfZm+DmmsPrsWdrmhdQxKr1PE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jd7ekTIdtE1D1Os3rleRR1UiUkx/s6LMpIEDEvrGCs3bJON5iJurDvuoIFqgYup9uVxw542vm6R6dSo/Hr8fEBQZxKTxX0x+lk6IK4etUomKp/kWFwK8bDE9ZHByEF+Xm19GbH8RyWzP7bUe2Fza92u1brEYssFikUMVASFW+4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eJRSiJBy; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eJRSiJBy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779128264; x=1810664264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pcmJn69RbLvbSk47qbYfZm+DmmsPrsWdrmhdQxKr1PE=;
  b=eJRSiJByMLtKosrqNO0bb7VgczjnJz7CEWMZuuUvDzr0I6A5hBkR6PQ1
   r7UqBWD3+I6QUrg5lfOvNXpm0FBeZx+SsY2M7Y6A77c8BjHoy8ra3LT1z
   64bdZyrro/OW6KKcMPET3BJdvkhfgZAYZ0UDMDf6eAunREgFiogdLsroU
   CWxB3jWbwgARTX0iGJg68tANeuee+cWEw3uqkMYDv6tZvWcYR9yksfBk5
   W3P225tXx7KWWfUDrPC7i0LsUf7yoloD0pVPcjxT3/2nzAr8QKUyHu2F/
   uiftkrmSt/u013luTILbeHWnEevS6LEh/qIgODUWFJwWuqDL2vJfhGl5e
   w==;
X-CSE-ConnectionGUID: lOq/Nmx+Smycw+1RoIISkQ==
X-CSE-MsgGUID: R7tEr6wAT5q3Vs3VZfOMyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="90574566"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="90574566"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:17:43 -0700
X-CSE-ConnectionGUID: +5HqOXcFSa6MY0/078grhQ==
X-CSE-MsgGUID: m0Qmm47LRBODBd/plzbVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="235056247"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 11:17:40 -0700
Date: Mon, 18 May 2026 21:17:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Message-ID: <agtXwmSPs8iARJ_e@ashevche-desk.local>
References: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
 <202605190130.oWitiRzG-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202605190130.oWitiRzG-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 19, 2026 at 01:32:51AM +0800, kernel test robot wrote:

> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on jic23-iio/togreg]
> [also build test WARNING on linus/master v7.1-rc4 next-20260518]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-Convert-IIO_CHAN_SOFT_TIMESTAMP-to-be-compound-literal/20260518-151541
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
> patch link:    https://lore.kernel.org/r/20260518071349.469748-1-andriy.shevchenko%40linux.intel.com
> patch subject: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal
> config: sparc64-randconfig-r132-20260518 (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/config)
> compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202605190130.oWitiRzG-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast to non-scalar
> >> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast from non-scalar

Thanks, the sparks were expected exactly in this and one more driver.
I mentioned that in my reply to my own patch already.

-- 
With Best Regards,
Andy Shevchenko


