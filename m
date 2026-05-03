Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CCC40DFD0;
	Sun,  3 May 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777766932; cv=none; b=Anr6rsWt1uD7wlMeNIY5SHnQulSvrzxdVceM8ZcjYZN7bxr8t5A9jWJ2XwckHYf1ZkExsUKyw8KN5voyU8CO6K2deXcQwTrCsWo/1VtJUVXyZTKaSsMKBwDsIiBx3WjfSshNAZX+AN6vWvSth0me23LRWPnLU6am700ZRuYveP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777766932; c=relaxed/simple;
	bh=IjDrJBgIvtgpDKQWsJc3zLIPS1UJqwhJeMrBGW5lkfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aQ5Vs3nyLez+yABJJ3n5skEkX28/t+st0eNb7b2QaxOYyuzS8RtjUusBNu+sZprGTen+4M3aBEdnmWcxChvhATh5LOpom4M2WGFRG3WwH2nRzWPrnUdatEQ6/Q8Ml1JwUgcFIjFuGtqvsSx3ev6dict9oZveQEw440puhCLtyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nhyzxj7F; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nhyzxj7F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777766931; x=1809302931;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IjDrJBgIvtgpDKQWsJc3zLIPS1UJqwhJeMrBGW5lkfs=;
  b=nhyzxj7FYjlb0pLLDoLquCJCt/uAVXfegiC22Jzd2C9WCIeHLUfCXQAa
   gcfsmuSnY+h78ye3v6UQIQOQhMY0f3daYC5XXkpkNn5NsJFPfkxvMI2H2
   2BEkDqrkS2xjzU7uFhuwyTs1REvLiinSVvPEPkEqwmgruvcH5jWlFkdoA
   grGAHjJwK77FDL6K3zhrZ51F3yHxFDlB37Sqv2Xvg7JvhG47j3HgYlayh
   YjK2bON8O6yspvonzU4STPy7CTCmmHoO89On7q5sfHkg4uVbNCIV9z26L
   2/zgTB2Uh34WuTg0r7NoOrdxNoS7zhofhk58NZGr9Rj5DGaZsQ2VMYHxw
   A==;
X-CSE-ConnectionGUID: o1ElDlAdQqebn/FwCEYueg==
X-CSE-MsgGUID: tlTMLdFBSLC4ATxsphESew==
X-IronPort-AV: E=McAfee;i="6800,10657,11774"; a="77842293"
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="77842293"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2026 17:08:49 -0700
X-CSE-ConnectionGUID: 1Y/MXHnnSO+9VTsFIAbk3g==
X-CSE-MsgGUID: rBQDWArdTvm0K5YBluUQsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,212,1770624000"; 
   d="scan'208";a="273281121"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 02 May 2026 17:08:47 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wJKO4-000000001vb-1Pxw;
	Sun, 03 May 2026 00:08:44 +0000
Date: Sun, 3 May 2026 08:08:11 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: magnetometer: rm3100: Modernize locking and
 refactor control flow
Message-ID: <202605030817.kUz9B6MC-lkp@intel.com>
References: <20260430021439.67591-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260430021439.67591-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc1 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/iio-magnetometer-rm3100-Modernize-locking-and-refactor-control-flow/20260502-014808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260430021439.67591-1-m32285159%40gmail.com
patch subject: [PATCH v4] iio: magnetometer: rm3100: Modernize locking and refactor control flow
config: s390-randconfig-r071-20260503 (https://download.01.org/0day-ci/archive/20260503/202605030817.kUz9B6MC-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 15.2.0
smatch: v0.5.0-9065-ge9cc34fd
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260503/202605030817.kUz9B6MC-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605030817.kUz9B6MC-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/iio/magnetometer/rm3100-core.c:467 expecting prototype for rm3100_guarded_regmap_bulk_read(). Prototype was for rm3100_regmap_bulk_read_locked() instead

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
