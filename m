Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D12371D07;
	Wed, 25 Mar 2026 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470399; cv=none; b=fUkvPokFcJxiT4RjQYOja+9Y4uCflSrdLtZC/iLzJkHykkmaXaZQdxPD+eW23U9dyMZMlytr6DH/bBwgi7pA6JwaHge3QuCOdmHHxDG5rmHHIlrSk56o6nwbMoLN8BIHPFoLf7zAeGV2RCFyliJF49fkQDDP6oegjLAAfRKER6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470399; c=relaxed/simple;
	bh=slXWIoKoRaY5w1vNrhs58BF51BbfKTdoGAsPVpe34Qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UdnJQX6XA5d8uTJgb6POygbPjeRkkPY4Tbw1sKvRHlFTFXQSQxCelyfRdDx4ZpRzK71m3obKzB21KabfMgA4ezRrsXr2YSu74SGqjIviyincQfu2ICnsHiPOb1hihPl652y7oFXPfGULlByZz+EBK+nTeCjoxkljkKRSR8UFI+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cptRYVSF; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cptRYVSF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774470396; x=1806006396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=slXWIoKoRaY5w1vNrhs58BF51BbfKTdoGAsPVpe34Qo=;
  b=cptRYVSFkrNmEt47zL/YRvncPYGfXHXaCtJVEAumSPlMAQPJTO7qgVuv
   IMNUoNovGJbdOL7kqjovkXsmY5dpSKx0QxqlohplYinRSgTBGSujjqZgB
   LWhtEeaRovI5BuM38AkVEox01JvWuTYOiMseF25XqAdsIOYd0g8kr0t0s
   mubzPeyus6rV/ZqVknXaLzDOHeUQuIXjoFUbLqpZC5SKFIRmpaBz9vXh0
   n/XoQgc5Tij3kiN5jX4iav9GbKQc1MBeaKrcY5j28e+QBnovJ+X1dn8pb
   fokLaN4UIZxBiyn/itnOq6AL5CyBE7Vz0hh0CXJe6lSdcT4h8xNT40Ig5
   Q==;
X-CSE-ConnectionGUID: lGXdV8gZQjyK6+gwAYQJRw==
X-CSE-MsgGUID: KpuR+E/NQ1OcAepYElJ7jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86213514"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86213514"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:26:36 -0700
X-CSE-ConnectionGUID: yIhT0x4GQGqsM/lplnN5Yg==
X-CSE-MsgGUID: XyRSoRoHQJKh4SIsU++rSA==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 25 Mar 2026 13:26:33 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5UoB-000000007h3-0GWK;
	Wed, 25 Mar 2026 20:26:31 +0000
Date: Thu, 26 Mar 2026 04:25:45 +0800
From: kernel test robot <lkp@intel.com>
To: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <202603260457.MZI9sXnu-lkp@intel.com>
References: <20260324084808.654118-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324084808.654118-1-flavra@baylibre.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260323]
[cannot apply to jic23-iio/togreg linus/master v7.0-rc5 v7.0-rc4 v7.0-rc3 v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Lavra/iio-imu-st_lsm6dsx-Fix-check-for-invalid-samples-from-FIFO/20260325-021519
base:   next-20260323
patch link:    https://lore.kernel.org/r/20260324084808.654118-1-flavra%40baylibre.com
patch subject: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
config: arm-randconfig-001-20260326 (https://download.01.org/0day-ci/archive/20260326/202603260457.MZI9sXnu-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 054e11d1a17e5ba88bb1a8ef32fad3346e80b186)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260457.MZI9sXnu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260457.MZI9sXnu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:138:1: warning: label at end of compound statement is a C23 extension [-Wc23-extensions]
     138 | }
         | ^
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:137:1: warning: unused label 'out' [-Wunused-label]
     137 | out:
         | ^~~~
   2 warnings generated.


vim +138 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

   117	
   118	int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
   119	{
   120		struct st_lsm6dsx_hw *hw = sensor->hw;
   121		int err;
   122	
   123		guard(mutex)(&hw->page_lock);
   124	
   125		err = st_lsm6dsx_fusion_page_enable(hw);
   126		if (err)
   127			return err;
   128	
   129		err = st_lsm6dsx_fusion_set_odr_locked(sensor, enable);
   130		if (err) {
   131			st_lsm6dsx_fusion_page_disable(hw);
   132			return err;
   133		}
   134	
   135		return st_lsm6dsx_fusion_page_disable(hw);
   136	
 > 137	out:
 > 138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
