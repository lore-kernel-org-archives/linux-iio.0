Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C357202963;
	Wed, 25 Mar 2026 19:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774466433; cv=none; b=dPI4BmJCXsRHkaNIA9YgoCfYUtx9ZtEnNRN+kj9mMoS9V1aMRKiY0oZRVaY4kS0lC9C1VQOrYnndTpk71AWx5DUAIWWQrhekKPXK2eS8CZac9nkfnn94aIcjDbYWSrHbQyTGuKPzCoZtOc4XK5uoIlIAjKW1dL8lVD+02oZZUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774466433; c=relaxed/simple;
	bh=dzrmiDrpjwtz7HrFYySUYf9NMlZDdBeWMFnfWDj3RAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HSKDsWeDpez8RiOeL+xn00U+Goe2JOpqcQL6lQTZveEOYHKauIuZYrhYTU2RmHLybqDAT5fYGhZ+w4oRY0nJV+yx6tyD071V9Kjxk9TdAuOOSykUXY2+xOhbXdNm+CnTCE8rvP3Hng8NYn/N6iD/nn9N2BnaN8Ha0xjVGRjbuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PIZJt5X9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PIZJt5X9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774466430; x=1806002430;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dzrmiDrpjwtz7HrFYySUYf9NMlZDdBeWMFnfWDj3RAg=;
  b=PIZJt5X9+dHZ717aeIIEh+C24zisRAgmuInXofWywrALPmepg9EP3pGd
   FHZb+6QsDgX8U8D5+6VRdXLrtK+AlS49rsj3HQocuXbKbJEwit/eH+zJA
   2ZJfF8hC/WHS4HW3ufrSYAOFaz5n2fAQVYHGo6MkTW1VniEjXRfVooZjp
   KjFqTdiT1iKHYGVYdZM8VLmQBxdRyvEKXnfqm/lp8z1WxtuNFMpP8f+9u
   +uMVIvfOpXrhcgZzjDsw3mA6LRUG+dZwdtQT24tmvgizALSHcSgsyCXJL
   XIKQL0MG5BIReIJeqNe9S0AcL9ea9m9AEaps+dCVl981ABGd/K8omcEj8
   g==;
X-CSE-ConnectionGUID: Klecg9nATbGLpZVXsDAuxg==
X-CSE-MsgGUID: 7/nT3hpjTSWP7XPdCuEixw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="79422209"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="79422209"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:20:30 -0700
X-CSE-ConnectionGUID: 6Yd1g75vRnqfwEGqqvMsnA==
X-CSE-MsgGUID: pkwabnNUTMmK1Y1+i1ycCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="229235211"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 25 Mar 2026 12:20:28 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5TmC-000000007ZZ-2XWC;
	Wed, 25 Mar 2026 19:20:24 +0000
Date: Thu, 26 Mar 2026 03:20:21 +0800
From: kernel test robot <lkp@intel.com>
To: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <202603260349.g0aoRPw8-lkp@intel.com>
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

kernel test robot noticed the following build errors:

[auto build test ERROR on next-20260323]
[cannot apply to jic23-iio/togreg linus/master v7.0-rc5 v7.0-rc4 v7.0-rc3 v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Lavra/iio-imu-st_lsm6dsx-Fix-check-for-invalid-samples-from-FIFO/20260325-021519
base:   next-20260323
patch link:    https://lore.kernel.org/r/20260324084808.654118-1-flavra%40baylibre.com
patch subject: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
config: parisc-randconfig-r072-20260326 (https://download.01.org/0day-ci/archive/20260326/202603260349.g0aoRPw8-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260349.g0aoRPw8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260349.g0aoRPw8-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c: In function 'st_lsm6dsx_fusion_set_odr':
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:137:1: error: label at end of compound statement
    out:
    ^~~
>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:137:1: warning: label 'out' defined but not used [-Wunused-label]


vim +137 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

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
   138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
