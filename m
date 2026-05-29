Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F51A315D29;
	Fri, 29 May 2026 13:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060224; cv=none; b=PSBT2NNT/MBDFxgr8zOkeyXJLJojWt5s8ufrUzWq/pvmJQMj8ALjlTwI6dQ89q2A6lQMdqT272+s598V+HuBPJVIDhpjlWOzALN9fTgSyOyTMJn8bTWPHKCUeUs/NF6muoNrCfmj77egtuFBUrZPxO8dUsvChI92J5J6IlOgkPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060224; c=relaxed/simple;
	bh=2/Zvl+trlsq8n+1p4UIy0aHBRvg/DchOBD8IeGDpntI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l8gYtwjMuU2o9WQh5y0TbfAhftZDxKHyMdvH6Z2g8/XsGwUSzCXqVuR3uOGJ7SrQH3b0Gb96ywD9TmNXtFvDeOGP8tFNA4oOggf69bDqHerOOGtntQnoZw4BQy3UopUR4AmXS/nc0c8MBO2pDZV9xFH3JZHm8zBMCF3ag9e4SQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OlkK4An9; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OlkK4An9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780060222; x=1811596222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2/Zvl+trlsq8n+1p4UIy0aHBRvg/DchOBD8IeGDpntI=;
  b=OlkK4An9WJ02pFxt4VimK+tLsGJxkuLyKHKAceG3ebaCRds4C8MnaVXD
   Q+Nbl6GwHm9JZyzT7TDAugYkvHxRbFWuAq3Zipi0FdyZNji9+15Qb2AAC
   oFq4Mz+dU74Pxx0tsm+IWf4HmhabTCOi8/X1Xq3LjSD4yA4aOahL+PUmY
   jfHYOwqpOAD5r+3XOWEAChvAa2UKUp7+f3thlAs8sW1pZcWkdssfv2/8g
   kgHcUvpM5/He/Pc8WN2SQqTY5sGWqBy2bl6eglG4STJxn0p7sJQ08NYcN
   aTjNx4Ds9vO9makvha7Amfp+3FjKNGemBwi2lgaKGHii8QTZM2moWiN+i
   Q==;
X-CSE-ConnectionGUID: qgeJNxAUSuufM/pkR27vkQ==
X-CSE-MsgGUID: crdUALXmRgSf4JdmjLUiYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="81094639"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="81094639"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2026 06:10:20 -0700
X-CSE-ConnectionGUID: QwRpYl2bTJ2wv+sHFAmM2g==
X-CSE-MsgGUID: eadYBeMVSeas18DgBDN8Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; 
   d="scan'208";a="239846563"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 29 May 2026 06:10:18 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSwyd-000000007G6-3Add;
	Fri, 29 May 2026 13:10:15 +0000
Date: Fri, 29 May 2026 21:10:08 +0800
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
Message-ID: <202605292103.zH0JgWhp-lkp@intel.com>
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
config: hexagon-randconfig-r073-20260529 (https://download.01.org/0day-ci/archive/20260529/202605292103.zH0JgWhp-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260529/202605292103.zH0JgWhp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605292103.zH0JgWhp-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/chemical/scd30_core.c:617:8: error: call to undeclared function 'scd30_trigger_handler_helper_locked'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     617 |         ret = scd30_trigger_handler_helper_locked(indio_dev, scan.data, sizeof(scan.data));
         |               ^
   drivers/iio/chemical/scd30_core.c:617:8: note: did you mean 'scd30_trigger_handler_helper'?
   drivers/iio/chemical/scd30_core.c:590:12: note: 'scd30_trigger_handler_helper' declared here
     590 | static int scd30_trigger_handler_helper(struct iio_dev *indio_dev, int *scan_data,
         |            ^
   1 error generated.


vim +/scd30_trigger_handler_helper_locked +617 drivers/iio/chemical/scd30_core.c

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
