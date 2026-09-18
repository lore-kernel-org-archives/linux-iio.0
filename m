Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8E14AB3DA;
	Fri, 18 Sep 2026 12:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789733736; cv=none; b=TRbHEkZUm9lRj/qS6RgJj4LWGbzb6vcixCwDmQ4UWrTYkAjxqg3ApfaWeOVtmqSK/CW14bfRMxM7BoXMIWS+5Aw4Qib/aJQA4Re+baTVlFvHnMtovtMb7OUVGkNpQHpqmbmNYC1fNtP7anZkxyoVzVFLYiXHhXFJV67ENx9w19I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789733736; c=relaxed/simple;
	bh=T/apRxOiS6EEfsFUMJh7FJWp82q3VzXDa8jFlGB6dos=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hn6y8d0etBmjrgAJCxmRtEfCQub05wkAK3/x3D7g/J+lxBV6RRxIBsj5W3rtSbqgJ9YGJ5mnsbnIDBR+/EkzALea6MdW1tw2QS9RLReesPTx61M7NNdVah3mwph4UGvM0xhr8tyMbswyeJUuZqbbc7Uep4Wq8Z3xiuqSuWM6K7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZlXuPLpW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZlXuPLpW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789733735; x=1821269735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T/apRxOiS6EEfsFUMJh7FJWp82q3VzXDa8jFlGB6dos=;
  b=ZlXuPLpWcnGP9rPUfelThyUuMhTFpLqiKAAvd/lm30uru+vHQp4zpMuk
   2B7CwwjxgY+W2Na0uIuH+Fir/XZFgsLb9Dl/YbGwnQC8p9kU+NvZIfu0V
   ZjSDBwjAYdAqxxTU3KqoT15hP69xED0GTCP3Hs4620vj5bQOatdzqpyAH
   l6KdbXxVk9Iy+7Y9SdgJRWb/zae3RGg6S70QeLFC6CuZnhjnVREnBsMEF
   TMtPr5h2Ph9pqjLKBuYrJE8RDEryp6rVj/nyGgSAYV/VdyHp7doCRRfel
   5dxX0l2n6mU2uwjkATAvjbsn26yQhqFONo18XXUMOuwxuc8En0KkCTOIC
   Q==;
X-CSE-ConnectionGUID: RMvnY9D2SWmXsH000GPcDA==
X-CSE-MsgGUID: 94/XXiaWQAKvucHFv+vcNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="90368237"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="90368237"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2026 05:15:34 -0700
X-CSE-ConnectionGUID: SKLexVT8TM23bbjGa8ylxw==
X-CSE-MsgGUID: 0OkvWzxQT3G71Y4F2x0OjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2565023"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 18 Sep 2026 05:15:32 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x7XV3-000000009ll-0fqn;
	Fri, 18 Sep 2026 12:15:29 +0000
Date: Fri, 18 Sep 2026 20:14:46 +0800
From: kernel test robot <lkp@intel.com>
To: Salah Triki <salah.triki@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Salah Triki <salah.triki@gmail.com>
Subject: Re: [PATCH v2] iio: temperature: tsys02d: Fix state
 desynchronization on resolution write error
Message-ID: <202609182052.HpuVt6ba-lkp@intel.com>
References: <20260917091609.626043-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917091609.626043-1-salah.triki@gmail.com>

Hi Salah,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Salah-Triki/iio-temperature-tsys02d-Fix-state-desynchronization-on-resolution-write-error/20260917-101608
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260917091609.626043-1-salah.triki%40gmail.com
patch subject: [PATCH v2] iio: temperature: tsys02d: Fix state desynchronization on resolution write error
config: riscv-randconfig-1000-20260918 (https://download.01.org/0day-ci/archive/20260918/202609182052.HpuVt6ba-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609182052.HpuVt6ba-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609182052.HpuVt6ba-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/temperature/tsys02d.c:89:2: error: cannot jump from switch statement to this case label
      89 |         default:
         |         ^
   drivers/iio/temperature/tsys02d.c:82:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
      82 |                 guard(mutex)(&dev_data->lock);
         |                 ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:93:1: note: expanded from here
      93 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:99:1: note: expanded from here
      99 | __UNIQUE_ID_unlock_472
         | ^
   drivers/iio/temperature/tsys02d.c:82:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:423:15: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:165:2: note: expanded from macro '__UNIQUE_ID'
     165 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:87:1: note: expanded from here
      87 | __UNIQUE_ID_guard_471
         | ^
   1 error generated.


vim +89 drivers/iio/temperature/tsys02d.c

53bf4d067d5115 Ludovic Tancerel 2015-10-01  65  
53bf4d067d5115 Ludovic Tancerel 2015-10-01  66  static int tsys02d_write_raw(struct iio_dev *indio_dev,
53bf4d067d5115 Ludovic Tancerel 2015-10-01  67  			     struct iio_chan_spec const *chan,
53bf4d067d5115 Ludovic Tancerel 2015-10-01  68  			     int val, int val2, long mask)
53bf4d067d5115 Ludovic Tancerel 2015-10-01  69  {
53bf4d067d5115 Ludovic Tancerel 2015-10-01  70  	struct ms_ht_dev *dev_data = iio_priv(indio_dev);
53bf4d067d5115 Ludovic Tancerel 2015-10-01  71  	int i, ret;
53bf4d067d5115 Ludovic Tancerel 2015-10-01  72  
53bf4d067d5115 Ludovic Tancerel 2015-10-01  73  	switch (mask) {
53bf4d067d5115 Ludovic Tancerel 2015-10-01  74  	case IIO_CHAN_INFO_SAMP_FREQ:
53bf4d067d5115 Ludovic Tancerel 2015-10-01  75  		i = ARRAY_SIZE(tsys02d_samp_freq);
53bf4d067d5115 Ludovic Tancerel 2015-10-01  76  		while (i-- > 0)
53bf4d067d5115 Ludovic Tancerel 2015-10-01  77  			if (val == tsys02d_samp_freq[i])
53bf4d067d5115 Ludovic Tancerel 2015-10-01  78  				break;
53bf4d067d5115 Ludovic Tancerel 2015-10-01  79  		if (i < 0)
53bf4d067d5115 Ludovic Tancerel 2015-10-01  80  			return -EINVAL;
53bf4d067d5115 Ludovic Tancerel 2015-10-01  81  
3c8dd88f5e71a2 Salah Triki      2026-09-17  82  		guard(mutex)(&dev_data->lock);
3c8dd88f5e71a2 Salah Triki      2026-09-17  83  
3c8dd88f5e71a2 Salah Triki      2026-09-17  84  		ret = ms_sensors_write_resolution(dev_data, i);
3c8dd88f5e71a2 Salah Triki      2026-09-17  85  		if (ret)
53bf4d067d5115 Ludovic Tancerel 2015-10-01  86  			return ret;
3c8dd88f5e71a2 Salah Triki      2026-09-17  87  
3c8dd88f5e71a2 Salah Triki      2026-09-17  88  		dev_data->res_index = i;
53bf4d067d5115 Ludovic Tancerel 2015-10-01 @89  	default:
53bf4d067d5115 Ludovic Tancerel 2015-10-01  90  		return -EINVAL;
53bf4d067d5115 Ludovic Tancerel 2015-10-01  91  	}
53bf4d067d5115 Ludovic Tancerel 2015-10-01  92  }
53bf4d067d5115 Ludovic Tancerel 2015-10-01  93  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
