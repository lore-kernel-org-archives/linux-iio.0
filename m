Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97FF13D3312;
	Fri, 20 Mar 2026 16:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025094; cv=none; b=U2T+BRwLajDoUDDEjzhoKRV9ezzQd9tWbuQP6+jggDlr5B1jPPR9hZ/BEpUU5wSDvZVaazQ/ayl9CmMHcSwoCwqiMD6Ps22yk7PVFrrAvR3sNUJhKSp3N7nBS2ivKZeamI8oCZ8/pdnatQs0Uy4PjEZBTIdZDvc7H6Tft42HqUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025094; c=relaxed/simple;
	bh=8o7EUfcliJ4m23BIGd721lVDYs7l78dCV1WdklpKn3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vFPFnK4OT1Ykj82k9GQr1T8j6va3JEtotyu/BfJnv702UveQdLWED8laJHRgB4fm+1t1NACluVumpNiShWFimB+47v2AqZSyT3o1A5AamjBPjZ2cfuO0EpAzDELJIxCTAsGOM6Hq1g9yE4DU39OgCP77zLZdngmkTJxAZVPUCaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IXyIuBH+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IXyIuBH+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774025093; x=1805561093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8o7EUfcliJ4m23BIGd721lVDYs7l78dCV1WdklpKn3c=;
  b=IXyIuBH+A8oou4bXGydZzzx8nDt1p7vQ3VbYI90I8jk8RltGUe1q5YVN
   Vf1Ph6W+hdAnE2mRsTDWAOP1Sq/y0J07XGAIEWIJjXodDb50WPU7jKOlg
   dwBiN456AwnzhYMPzOsG55s/QTbU77xad9LLSL9+8PwyWmjS9q5uHSxo/
   fz6gIIe4Y/h6fdzV1FUOWUAYwdqo+EqoBEUqD0cfajsOMW5JAgHZrM9Mv
   7Tpzj6zy8ckHDbWvMUSx2ZsluObTofEz1iUIXxYsTdWB78YJnErKe6eoO
   iAculf0F6qLyUZyedVaXCw3oVj5kYrcHj/mhX4+EvxKy9sh+NXnzRJFbM
   g==;
X-CSE-ConnectionGUID: RvTp6dK0QWqbNpxrnH8d7Q==
X-CSE-MsgGUID: a7dugNtOSeKiazdQDcgNkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="78971783"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="78971783"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 09:44:52 -0700
X-CSE-ConnectionGUID: nL0+5e5cSUahrq/spq4G0w==
X-CSE-MsgGUID: 1WJN9SWqTsGWbXmsk1lN7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="253837263"
Received: from lkp-server01.sh.intel.com (HELO ba623fe84fe1) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 20 Mar 2026 09:44:47 -0700
Received: from kbuild by ba623fe84fe1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3cxo-0000000009p-212j;
	Fri, 20 Mar 2026 16:44:44 +0000
Date: Sat, 21 Mar 2026 00:44:01 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andy@kernel.org,
	nuno.sa@analog.com, dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 4/5] iio: imu: inv_icm42600: Add support for icm42607
Message-ID: <202603210243.jegPzaTL-lkp@intel.com>
References: <20260319182956.146976-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319182956.146976-5-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v7.0-rc4 next-20260320]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-iio-imu-add-icm42607/20260320-061927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20260319182956.146976-5-macroalpha82%40gmail.com
patch subject: [PATCH V2 4/5] iio: imu: inv_icm42600: Add support for icm42607
config: i386-buildonly-randconfig-003-20260320 (https://download.01.org/0day-ci/archive/20260321/202603210243.jegPzaTL-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603210243.jegPzaTL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603210243.jegPzaTL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:108:18: warning: unused variable 'inv_icm42607_accel_filter_values' [-Wunused-const-variable]
     108 | static const int inv_icm42607_accel_filter_values[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/inv_icm42607_accel_filter_values +108 drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c

    95	
    96	static const char * const inv_icm42600_accel_power_mode_items[] = {
    97		"low-noise",
    98		"low-power",
    99	};
   100	static const int inv_icm42600_accel_power_mode_values[] = {
   101		INV_ICM42600_SENSOR_MODE_LOW_NOISE,
   102		INV_ICM42600_SENSOR_MODE_LOW_POWER,
   103	};
   104	static const int inv_icm42600_accel_filter_values[] = {
   105		INV_ICM42600_FILTER_BW_ODR_DIV_2,
   106		INV_ICM42600_FILTER_AVG_16X,
   107	};
 > 108	static const int inv_icm42607_accel_filter_values[] = {
   109		INV_ICM42607_FILTER_BW_25HZ,
   110		INV_ICM42607_FILTER_AVG_16X,
   111	};
   112	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
