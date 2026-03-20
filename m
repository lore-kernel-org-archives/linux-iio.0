Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79F823E35F;
	Fri, 20 Mar 2026 20:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774038145; cv=none; b=Qqcx1UbsJTQJ3QhM0UIw7PxQJs8g1G6QNJc275Asip4Npe2sColmX2Mr3+WVQLCxjXQeo2BiXvBjWSPXjyMTmGTkb6n/xNfKtP60Tf89FT7dyeQyB6z4DAKupinmzA3/naowwTjtWELkRJHOjy6Xzzzxwrq+ejSP5+1pdYJOlcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774038145; c=relaxed/simple;
	bh=n2l65V527Eau2vdGUiD28sG9Dh+TiRpLL5+N4dmLSg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYm971hqNwKTlpaGYo/ZApY0HjjR1iVj04lu2rbOuNpFE+KPLuKh5ixiIPsoqXHHf5xlLLT9vHlyEdocve8aMKQIGz0x+XDPjxZMFiu+I+rTE7+pwosWUWtrXEFpOJ4mpZTYUGr5kKCOzb+G4AC0neo4yCtR62dq+kTJllD/AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NLn5RRVI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NLn5RRVI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774038144; x=1805574144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=n2l65V527Eau2vdGUiD28sG9Dh+TiRpLL5+N4dmLSg0=;
  b=NLn5RRVI+9lnMx/Yi9BN5JtfKRB1BR6DFo+IdqA0UxXapRAxhQtInPTQ
   zY7QrYk2UHCwmZT2ouocKbUXFGaibbj4h5UviStRU8JYsd7w+nBHsPkOO
   MEn5lm2vonxaTuST+NzY1Dos3JiPT8BplJwxTwb1+B3EXD5orxb6dyNrz
   QlvjdIuFYtGcaDVCSVUWjszG6N/6ZLNBTGR7w4hyjih+I6YeDeBVfRVf1
   vzEJGKmFNupS/kZHh9SswLNIK0M/Iz6Io7cxKMS7Qj62dygtSS0Tawg/y
   Ahlb+7BNT0oElbAI8zIlAc41FpDiwUcxYAZ48rUdExmbOuoeDC8Fn4R+B
   w==;
X-CSE-ConnectionGUID: NuWgWmlSROuOnxK43fjPVQ==
X-CSE-MsgGUID: MNbRoym2Rvm4sU+rv8s3Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="92707764"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="92707764"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 13:22:23 -0700
X-CSE-ConnectionGUID: qmWb/r3jTGiKAi5V8+u5Bg==
X-CSE-MsgGUID: cINMvrv3QKSJ7r2hNSA3Fw==
X-ExtLoop1: 1
Received: from lkp-server02.sh.intel.com (HELO ef9b23065726) ([10.239.97.151])
  by fmviesa003.fm.intel.com with ESMTP; 20 Mar 2026 13:22:19 -0700
Received: from kbuild by ef9b23065726 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3gKm-000000000BJ-43SO;
	Fri, 20 Mar 2026 20:21:03 +0000
Date: Sat, 21 Mar 2026 04:16:11 +0800
From: kernel test robot <lkp@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	matheusgiarola@usp.br, arthurpilone@usp.br,
	davidbtadokoro@ime.usp.br
Subject: Re: [PATCH] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Message-ID: <202603210411.t4KwH3aX-lkp@intel.com>
References: <20260319184615.10970-1-matheusgiarola@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319184615.10970-1-matheusgiarola@usp.br>

Hi Matheus,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.0-rc4 next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Matheus-Giarola/iio-adc-ad7280a-replace-mutex_lock-with-guard-mutex/20260320-142509
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260319184615.10970-1-matheusgiarola%40usp.br
patch subject: [PATCH] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
config: arm-randconfig-004-20260321 (https://download.01.org/0day-ci/archive/20260321/202603210411.t4KwH3aX-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 4abb927bacf37f18f6359a41639a6d1b3bffffb5)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603210411.t4KwH3aX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603210411.t4KwH3aX-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad7280a.c:899:2: error: cannot jump from switch statement to this case label
     899 |         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
         |         ^
   drivers/iio/adc/ad7280a.c:878:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     878 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:15:1: note: expanded from here
      15 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:21:1: note: expanded from here
      21 | __UNIQUE_ID_unlock_538
         | ^
   drivers/iio/adc/ad7280a.c:878:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:419:15: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:9:1: note: expanded from here
       9 | __UNIQUE_ID_guard_537
         | ^
   drivers/iio/adc/ad7280a.c:891:2: error: cannot jump from switch statement to this case label
     891 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/adc/ad7280a.c:878:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     878 |                 guard(mutex)(&st->lock);
         |                 ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:15:1: note: expanded from here
      15 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:21:1: note: expanded from here
      21 | __UNIQUE_ID_unlock_538
         | ^
   drivers/iio/adc/ad7280a.c:878:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:419:15: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |                      ^
   include/linux/compiler.h:168:2: note: expanded from macro '__UNIQUE_ID'
     168 |         __PASTE(__UNIQUE_ID_,                                   \
         |         ^
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:9:1: note: expanded from here
       9 | __UNIQUE_ID_guard_537
         | ^
   2 errors generated.


vim +899 drivers/iio/adc/ad7280a.c

c5fe2f537b91e17 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2022-02-06  866  
84f79ecb0c1f393 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2011-10-06  867  static int ad7280_read_raw(struct iio_dev *indio_dev,
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  868  			   struct iio_chan_spec const *chan,
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  869  			   int *val,
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  870  			   int *val2,
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  871  			   long m)
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  872  {
84f79ecb0c1f393 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2011-10-06  873  	struct ad7280_state *st = iio_priv(indio_dev);
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  874  	int ret;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  875  
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  876  	switch (m) {
b11f98ff8c35d62 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2012-04-15  877  	case IIO_CHAN_INFO_RAW:
801020aafb667e4 drivers/iio/adc/ad7280a.c         Matheus Giarola    2026-03-19  878  		guard(mutex)(&st->lock);
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  879  		if (chan->address == AD7280A_ALL_CELLS)
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  880  			ret = ad7280_read_all_channels(st, st->scan_cnt, NULL);
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  881  		else
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  882  			ret = ad7280_read_channel(st, chan->address >> 8,
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  883  						  chan->address & 0xFF);
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  884  
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  885  		if (ret < 0)
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  886  			return ret;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  887  
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  888  		*val = ret;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  889  
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  890  		return IIO_VAL_INT;
c8a9f8056f40f62 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2011-10-26  891  	case IIO_CHAN_INFO_SCALE:
4c59aabd9a93d8f drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2022-02-06  892  		if ((chan->address & 0xFF) <= AD7280A_CELL_VOLTAGE_6_REG)
d6570b33a1c0620 drivers/staging/iio/adc/ad7280a.c Lars-Peter Clausen 2013-09-28  893  			*val = 4000;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  894  		else
d6570b33a1c0620 drivers/staging/iio/adc/ad7280a.c Lars-Peter Clausen 2013-09-28  895  			*val = 5000;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  896  
d6570b33a1c0620 drivers/staging/iio/adc/ad7280a.c Lars-Peter Clausen 2013-09-28  897  		*val2 = AD7280A_BITS;
d6570b33a1c0620 drivers/staging/iio/adc/ad7280a.c Lars-Peter Clausen 2013-09-28  898  		return IIO_VAL_FRACTIONAL_LOG2;
c5fe2f537b91e17 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2022-02-06 @899  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
c5fe2f537b91e17 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2022-02-06  900  		*val = ad7280a_n_avg[st->oversampling_ratio];
c5fe2f537b91e17 drivers/staging/iio/adc/ad7280a.c Jonathan Cameron   2022-02-06  901  		return IIO_VAL_INT;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  902  	}
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  903  	return -EINVAL;
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  904  }
2051f25d2a26573 drivers/staging/iio/adc/ad7280a.c Michael Hennerich  2011-07-20  905  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
