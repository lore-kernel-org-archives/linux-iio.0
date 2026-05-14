Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399653A5454;
	Thu, 14 May 2026 03:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778730276; cv=none; b=SuYmemKzWxRUWt8nvI8ytkA11ouaynlIvnkp6dyB1WfDrjoUAZ7E5xJFDwBByB+WCFMyieVTPASc57YNhm7UfdDBObvZGyIa/w5BgTNUMB8b8HOAX1EZK2uE74ZgzTlxLsVYvqW/phCTWjMtU30AREYyuT7Khm7WABNWPGGZVJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778730276; c=relaxed/simple;
	bh=OhusdIRBSzKE3zu9awhoEso+g4pOdJcckTOwwW7CJBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KLPr0z6DyBayY8Rn/JMLgzllkVZrpQ6ZLj9+8WnQ0n8z7GKTmUiaZXhnuObFqKqyhS3TE70+/2J2EO6mEx8tYYhD1Uzwp4XdZP7RWQalXD+wIJDX5FHL2a67hdM5kKgZiaXiNvhrOtdDz09wmLSEKSeF5bZOJ5A3ubpIAAkObFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jT1F+zPL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jT1F+zPL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778730275; x=1810266275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OhusdIRBSzKE3zu9awhoEso+g4pOdJcckTOwwW7CJBQ=;
  b=jT1F+zPLzr4XW75PcknTwh5rEPcyqEKBwnMeFoKHkyJPUZmhPpPt+Pq7
   8wka3rTQ8VcHMC4DOriQuC2EbALPNc4QN45dpjdbto6a76UuTjc4UggKN
   GkiJkWe4/tT9vHI/+3YVGEioxM2NHuSomgCx2kHVg5gDTjOxmf8m5tnHd
   mrDzr5k38rNWfZ/IOCBcXpE5Ex1jZ8ncLaag/I4f/7M879mJg7CfIk4h8
   ll188FpEGaTy3L/xg6xgpEbS6u0IRcNp7JnL5blfDr6JpRRQF9iUUUMUB
   O4OUEjlh1V+PrX4oxOdKSIQr/LIQJqXWfFoejUfFx2J9+CjZMkamG7SSI
   Q==;
X-CSE-ConnectionGUID: j0mm40WSQcqIofCel4PWsQ==
X-CSE-MsgGUID: PWB53zsSR96Jbwwx/fq+sQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79620944"
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="79620944"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 20:44:34 -0700
X-CSE-ConnectionGUID: oMsC692KTASdNRi2SXEzVg==
X-CSE-MsgGUID: aIT4bIdYRiSQSLx54JQ8/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,234,1770624000"; 
   d="scan'208";a="237407967"
Received: from lkp-server01.sh.intel.com (HELO dca79079c3eb) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 13 May 2026 20:44:31 -0700
Received: from kbuild by dca79079c3eb with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wNMzt-000000005lf-0DkE;
	Thu, 14 May 2026 03:44:29 +0000
Date: Thu, 14 May 2026 11:44:10 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over
 manual locking
Message-ID: <202605141121.82vp1RMY-lkp@intel.com>
References: <20260505005506.160891-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505005506.160891-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on 7fd2df204f342fc17d1a0bfcd474b24232fb0f32]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/iio-imu-kmx61-Use-guard-mutex-family-over-manual-locking/20260514-043249
base:   7fd2df204f342fc17d1a0bfcd474b24232fb0f32
patch link:    https://lore.kernel.org/r/20260505005506.160891-1-m32285159%40gmail.com
patch subject: [PATCH v2] iio: imu: kmx61: Use guard(mutex)() family over manual locking
config: i386-randconfig-141-20260514 (https://download.01.org/0day-ci/archive/20260514/202605141121.82vp1RMY-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
smatch: v0.5.0-9185-gbcc58b9c
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260514/202605141121.82vp1RMY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605141121.82vp1RMY-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/kmx61.c:829:2: error: cannot jump from switch statement to this case label
     829 |         case IIO_CHAN_INFO_SAMP_FREQ:
         |         ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     798 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:422:2: note: expanded from macro 'guard'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:112:1: note: expanded from here
     112 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:118:1: note: expanded from here
     118 | __UNIQUE_ID_unlock_385
         | ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:422:15: note: expanded from macro 'guard'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:106:1: note: expanded from here
     106 | __UNIQUE_ID_guard_384
         | ^
   drivers/iio/imu/kmx61.c:815:2: error: cannot jump from switch statement to this case label
     815 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     798 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:422:2: note: expanded from macro 'guard'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:112:1: note: expanded from here
     112 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:118:1: note: expanded from here
     118 | __UNIQUE_ID_unlock_385
         | ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:422:15: note: expanded from macro 'guard'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:106:1: note: expanded from here
     106 | __UNIQUE_ID_guard_384
         | ^
   drivers/iio/imu/kmx61.c:846:6: warning: unused variable 'ret' [-Wunused-variable]
     846 |         int ret;
         |             ^~~
   drivers/iio/imu/kmx61.c:863:3: error: cannot jump from switch statement to this case label
     863 |                 default:
         |                 ^
   drivers/iio/imu/kmx61.c:861:4: note: jump bypasses initialization of variable with __attribute__((cleanup))
     861 |                         guard(mutex)(&data->lock);
         |                         ^
   include/linux/cleanup.h:422:2: note: expanded from macro 'guard'
     422 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:170:1: note: expanded from here
     170 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)


vim +829 drivers/iio/imu/kmx61.c

20ffac278ebd64 Daniel Baluta 2014-12-03  777  
20ffac278ebd64 Daniel Baluta 2014-12-03  778  static int kmx61_read_raw(struct iio_dev *indio_dev,
20ffac278ebd64 Daniel Baluta 2014-12-03  779  			  struct iio_chan_spec const *chan, int *val,
20ffac278ebd64 Daniel Baluta 2014-12-03  780  			  int *val2, long mask)
20ffac278ebd64 Daniel Baluta 2014-12-03  781  {
20ffac278ebd64 Daniel Baluta 2014-12-03  782  	int ret;
20ffac278ebd64 Daniel Baluta 2014-12-03  783  	u8 base_reg;
20ffac278ebd64 Daniel Baluta 2014-12-03  784  	struct kmx61_data *data = kmx61_get_data(indio_dev);
20ffac278ebd64 Daniel Baluta 2014-12-03  785  
20ffac278ebd64 Daniel Baluta 2014-12-03  786  	switch (mask) {
20ffac278ebd64 Daniel Baluta 2014-12-03  787  	case IIO_CHAN_INFO_RAW:
20ffac278ebd64 Daniel Baluta 2014-12-03  788  		switch (chan->type) {
20ffac278ebd64 Daniel Baluta 2014-12-03  789  		case IIO_ACCEL:
20ffac278ebd64 Daniel Baluta 2014-12-03  790  			base_reg = KMX61_ACC_XOUT_L;
20ffac278ebd64 Daniel Baluta 2014-12-03  791  			break;
20ffac278ebd64 Daniel Baluta 2014-12-03  792  		case IIO_MAGN:
20ffac278ebd64 Daniel Baluta 2014-12-03  793  			base_reg = KMX61_MAG_XOUT_L;
20ffac278ebd64 Daniel Baluta 2014-12-03  794  			break;
20ffac278ebd64 Daniel Baluta 2014-12-03  795  		default:
20ffac278ebd64 Daniel Baluta 2014-12-03  796  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  797  		}
45e0524c69702c Maxwell Doose 2026-05-04  798  		guard(mutex)(&data->lock);
20ffac278ebd64 Daniel Baluta 2014-12-03  799  
a3da4fa301ae60 Daniel Baluta 2014-12-23  800  		ret = kmx61_set_power_state(data, true, chan->address);
45e0524c69702c Maxwell Doose 2026-05-04  801  		if (ret)
a3da4fa301ae60 Daniel Baluta 2014-12-23  802  			return ret;
a3da4fa301ae60 Daniel Baluta 2014-12-23  803  
20ffac278ebd64 Daniel Baluta 2014-12-03  804  		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
20ffac278ebd64 Daniel Baluta 2014-12-03  805  		if (ret < 0) {
aff8609addd00e Daniel Baluta 2014-12-03  806  			kmx61_set_power_state(data, false, chan->address);
20ffac278ebd64 Daniel Baluta 2014-12-03  807  			return ret;
20ffac278ebd64 Daniel Baluta 2014-12-03  808  		}
20ffac278ebd64 Daniel Baluta 2014-12-03  809  		*val = sign_extend32(ret >> chan->scan_type.shift,
20ffac278ebd64 Daniel Baluta 2014-12-03  810  				     chan->scan_type.realbits - 1);
a3da4fa301ae60 Daniel Baluta 2014-12-23  811  		ret = kmx61_set_power_state(data, false, chan->address);
a3da4fa301ae60 Daniel Baluta 2014-12-23  812  		if (ret)
a3da4fa301ae60 Daniel Baluta 2014-12-23  813  			return ret;
20ffac278ebd64 Daniel Baluta 2014-12-03  814  		return IIO_VAL_INT;
20ffac278ebd64 Daniel Baluta 2014-12-03  815  	case IIO_CHAN_INFO_SCALE:
20ffac278ebd64 Daniel Baluta 2014-12-03  816  		switch (chan->type) {
20ffac278ebd64 Daniel Baluta 2014-12-03  817  		case IIO_ACCEL:
20ffac278ebd64 Daniel Baluta 2014-12-03  818  			*val = 0;
20ffac278ebd64 Daniel Baluta 2014-12-03  819  			*val2 = kmx61_uscale_table[data->range];
20ffac278ebd64 Daniel Baluta 2014-12-03  820  			return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  821  		case IIO_MAGN:
20ffac278ebd64 Daniel Baluta 2014-12-03  822  			/* 14 bits res, 1465 microGauss per magn count */
20ffac278ebd64 Daniel Baluta 2014-12-03  823  			*val = 0;
20ffac278ebd64 Daniel Baluta 2014-12-03  824  			*val2 = 1465;
20ffac278ebd64 Daniel Baluta 2014-12-03  825  			return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  826  		default:
20ffac278ebd64 Daniel Baluta 2014-12-03  827  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  828  		}
20ffac278ebd64 Daniel Baluta 2014-12-03 @829  	case IIO_CHAN_INFO_SAMP_FREQ:
20ffac278ebd64 Daniel Baluta 2014-12-03  830  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
20ffac278ebd64 Daniel Baluta 2014-12-03  831  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  832  
45e0524c69702c Maxwell Doose 2026-05-04  833  		scoped_guard(mutex, &data->lock)
20ffac278ebd64 Daniel Baluta 2014-12-03  834  			ret = kmx61_get_odr(data, val, val2, chan->address);
20ffac278ebd64 Daniel Baluta 2014-12-03  835  		if (ret)
20ffac278ebd64 Daniel Baluta 2014-12-03  836  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  837  		return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  838  	}
20ffac278ebd64 Daniel Baluta 2014-12-03  839  	return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  840  }
20ffac278ebd64 Daniel Baluta 2014-12-03  841  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
