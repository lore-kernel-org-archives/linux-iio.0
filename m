Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2856310777;
	Fri, 29 May 2026 13:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060883; cv=none; b=GWlgJMu0VEeKonP4/8Q8o1ML3VtMNd+UrSXbZcF8Gz/ddBZLC0aqYO0yp2LWUskmL4uxM/GKKg9QHKNm1NDE9NQKtayeackc3oCO8Ad0H4VBPzmYsBkkU41/HFpkO+LS2UDv34M0dO8mdSaC5BdDS+um2aRaYWP+pT+38ZVTUsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060883; c=relaxed/simple;
	bh=QXHe7Y80Ef6SPjsVdvvfFb4iXJ7YQ6COIbiIjU4EeNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jS+7OfbFoLWS34wLt2j47VyCRkbrcKhsZLIidyK8BHQT0yqEznuQehIymZMIvpH2GmCMytopSeu9TVuZgnoGBE4jTf+uwxioFJqaLPs2vP1uB5NLYgk1Xg84/+CvbGnoorAzxthXfhNS/MCqxj9MzST5U5fqQByUoG/Wh9dXNRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MkY2qHzo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MkY2qHzo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780060882; x=1811596882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QXHe7Y80Ef6SPjsVdvvfFb4iXJ7YQ6COIbiIjU4EeNw=;
  b=MkY2qHzoxRz6FP8M71pKT3murVuHW3dTv7fv2lhYX/cBsajwQ7Qp35lw
   dxSuo27Jv+YaCLUUO1B4sWN6Nek6ZPDcGloRyO4Q4u4VhwY9T2CIkOcOB
   R1e/kFmQmSNr3YN2Oh16dDYQxf1tkBbiS0IWTIrPQFAIy14RdIrLfvwA8
   9Q2x7VNFT4msoY/OXvwstJLF0N7XudZXdUy+kUCMt5sLUo6BdDuTBYwKg
   HCTKYcPEaoFmgzvXpMEFMknpbQCHfNe2KF+X38bhpauZ+IK3LQJtZWKo/
   tfeHecfbkA1cfU6eR3ANC5rGROD8yJDp0S91cLlUvxqRa0R2uocYUpQh8
   w==;
X-CSE-ConnectionGUID: T2+I8xWCQLKLNQPZAjYYhw==
X-CSE-MsgGUID: XQjcKKAWQduIFgw6yuKeBg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84771319"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="84771319"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 06:21:21 -0700
X-CSE-ConnectionGUID: 2+ul1wFsRPuGscIyU8JRpw==
X-CSE-MsgGUID: Osp5F0jRSmqAALARiPnwuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="244673822"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 29 May 2026 06:21:19 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSx9I-000000007HC-1qBy;
	Fri, 29 May 2026 13:21:16 +0000
Date: Fri, 29 May 2026 21:20:41 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Tomasz Duszynski <tomasz.duszynski@octakon.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: chemical: scd30: Replace manual locking with
 RAII locking
Message-ID: <202605292101.GTdtBJA1-lkp@intel.com>
References: <20260528222906.61561-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528222906.61561-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.1-rc5 next-20260528]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/iio-chemical-scd30-Replace-manual-locking-with-RAII-locking/20260529-063551
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260528222906.61561-1-m32285159%40gmail.com
patch subject: [PATCH v5] iio: chemical: scd30: Replace manual locking with RAII locking
config: loongarch-randconfig-r071-20260529 (https://download.01.org/0day-ci/archive/20260529/202605292101.GTdtBJA1-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605292101.GTdtBJA1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605292101.GTdtBJA1-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/iio/chemical/scd30_core.c: In function 'scd30_trigger_handler':
>> drivers/iio/chemical/scd30_core.c:617:15: error: implicit declaration of function 'scd30_trigger_handler_helper_locked'; did you mean 'scd30_trigger_handler_helper'? [-Wimplicit-function-declaration]
     617 |         ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |               scd30_trigger_handler_helper
   drivers/iio/chemical/scd30_core.c: At top level:
>> drivers/iio/chemical/scd30_core.c:590:12: warning: 'scd30_trigger_handler_helper' defined but not used [-Wunused-function]
     590 | static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int *scan_data,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +617 drivers/iio/chemical/scd30_core.c

   589	
 > 590	static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int *scan_data,
   591						size_t scan_data_size)
   592	{
   593		struct scd30_state *state = iio_priv(indio_dev);
   594		int ret;
   595	
   596		guard(mutex)(&state->lock);
   597	
   598		if (!iio_trigger_using_own(indio_dev))
   599			ret = scd30_read_poll(state);
   600		else
   601			ret = scd30_read_meas(state);
   602		memcpy(scan_data, state->meas, scan_data_size);
   603	
   604		return ret;
   605	}
   606	
   607	static irqreturn_t scd30_trigger_handler(int irq, void *p)
   608	{
   609		struct iio_poll_func *pf = p;
   610		struct iio_dev *indio_dev = pf->indio_dev;
   611		struct {
   612			int data[SCD30_MEAS_COUNT];
   613			aligned_s64 ts;
   614		} scan = { };
   615		int ret;
   616	
 > 617		ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
   618		if (ret)
   619			goto out;
   620	
   621		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
   622					    iio_get_time_ns(indio_dev));
   623	out:
   624		iio_trigger_notify_done(indio_dev->trig);
   625		return IRQ_HANDLED;
   626	}
   627	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
