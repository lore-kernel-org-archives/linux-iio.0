Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F4B3B9D94;
	Tue,  5 May 2026 04:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777955931; cv=none; b=qP+0fzyrNoqZ99kCAfm7dWfIxgvyW/3QtEW+Ws1c4ZbpsDyJCY8qa/xPuvnhjz8az287Tak7R3Ekuzmhf7QjPMj4Ii2clvETkoy/Ni2hZQgAmbKGmn71y4vDthe25cY9FFezeHi9fVRiFLzllgxWA3GCAJYjyNNfw4QR8zfZrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777955931; c=relaxed/simple;
	bh=GAIsBwZBBghfY+lcPD2OyM3OFTEm3qTq325FxrjGZro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DgG1OvlxncVWS1g867oe6GI7CyatKkU6pOmISNzxXcJaqz075Q4LpxN0guT2NJPpiRWs7gTgLRiGXdMDbhyHPs+uQJCmmBCRq5MZNZH77Pgkm0jYQWqLBQrAOyq4dxIO+2ktEEPnxXVE0jikwqguKGjJj0MGTv0tLS6RAzflP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKuLc51H; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKuLc51H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777955929; x=1809491929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GAIsBwZBBghfY+lcPD2OyM3OFTEm3qTq325FxrjGZro=;
  b=UKuLc51H7DIKq7f96MPexYw+fVbtm2+qIL0yd34wWT9jUVI0yEV7Iohw
   raHj7Jy4xerck0XLA6fouUsR5chmJ4c/XotQVJCuggXWkjPtpjayniYoV
   K1AYhgADHs64PEDe97Gp2b6WVDMkpL6YnLKAQe45Zl89gY6Z12oTaRzIa
   nPw635vbN979r1CngY+kmtjHK8pQvY01WTF0v8g8kQo7ZtybndAC4E05k
   lNQegfowsavMSNcXs0SwRyogfCk3hFSUB2cd0+CMzHnm+XkONXUwVoXun
   g3x0YyEvbynwAi2qSIYR3209g93OXVWIULBCe3eP5KvoXtM05qWTpia4U
   g==;
X-CSE-ConnectionGUID: G0eMwff8QY2JunQTGv+gfw==
X-CSE-MsgGUID: kY2kA1bVQFiu0raGKtYLTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="89124528"
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="89124528"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 21:38:48 -0700
X-CSE-ConnectionGUID: JXBbV3cCTeaBycKjHZF4BA==
X-CSE-MsgGUID: NQ+T53G+Q6uBQAwRTUq/jA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,216,1770624000"; 
   d="scan'208";a="259369947"
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 04 May 2026 21:38:45 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wK7Xx-000000004Fp-1nW1;
	Tue, 05 May 2026 04:38:22 +0000
Date: Tue, 5 May 2026 12:38:07 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual
 locking
Message-ID: <202605051218.kuLCMDTO-lkp@intel.com>
References: <20260502032455.76107-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502032455.76107-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.1-rc2 next-20260430]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/iio-imu-kmx61-Use-guard-mutex-family-over-manual-locking/20260504-212159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260502032455.76107-1-m32285159%40gmail.com
patch subject: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual locking
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260505/202605051218.kuLCMDTO-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260505/202605051218.kuLCMDTO-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605051218.kuLCMDTO-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/imu/kmx61.c:830:2: error: cannot jump from switch statement to this case label
     830 |         case IIO_CHAN_INFO_SAMP_FREQ:
         |         ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     798 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:9:1: note: expanded from here
       9 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:15:1: note: expanded from here
      15 | __UNIQUE_ID_unlock_468
         | ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
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
   <scratch space>:3:1: note: expanded from here
       3 | __UNIQUE_ID_guard_467
         | ^
   drivers/iio/imu/kmx61.c:816:2: error: cannot jump from switch statement to this case label
     816 |         case IIO_CHAN_INFO_SCALE:
         |         ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     798 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:9:1: note: expanded from here
       9 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:15:1: note: expanded from here
      15 | __UNIQUE_ID_unlock_468
         | ^
   drivers/iio/imu/kmx61.c:798:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
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
   <scratch space>:3:1: note: expanded from here
       3 | __UNIQUE_ID_guard_467
         | ^
   drivers/iio/imu/kmx61.c:847:6: warning: unused variable 'ret' [-Wunused-variable]
     847 |         int ret;
         |             ^~~
   drivers/iio/imu/kmx61.c:864:3: error: cannot jump from switch statement to this case label
     864 |                 default:
         |                 ^
   drivers/iio/imu/kmx61.c:862:4: note: jump bypasses initialization of variable with __attribute__((cleanup))
     862 |                         guard(mutex)(&data->lock);
         |                         ^
   include/linux/cleanup.h:419:2: note: expanded from macro 'guard'
     419 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:300:3: note: expanded from macro 'CLASS'
     300 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:67:1: note: expanded from here
      67 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)


vim +830 drivers/iio/imu/kmx61.c

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
84cb5906c7fb44 Maxwell Doose 2026-05-01  798  		guard(mutex)(&data->lock);
20ffac278ebd64 Daniel Baluta 2014-12-03  799  
a3da4fa301ae60 Daniel Baluta 2014-12-23  800  		ret = kmx61_set_power_state(data, true, chan->address);
84cb5906c7fb44 Maxwell Doose 2026-05-01  801  		if (ret)
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
20ffac278ebd64 Daniel Baluta 2014-12-03  812  
a3da4fa301ae60 Daniel Baluta 2014-12-23  813  		if (ret)
a3da4fa301ae60 Daniel Baluta 2014-12-23  814  			return ret;
20ffac278ebd64 Daniel Baluta 2014-12-03  815  		return IIO_VAL_INT;
20ffac278ebd64 Daniel Baluta 2014-12-03  816  	case IIO_CHAN_INFO_SCALE:
20ffac278ebd64 Daniel Baluta 2014-12-03  817  		switch (chan->type) {
20ffac278ebd64 Daniel Baluta 2014-12-03  818  		case IIO_ACCEL:
20ffac278ebd64 Daniel Baluta 2014-12-03  819  			*val = 0;
20ffac278ebd64 Daniel Baluta 2014-12-03  820  			*val2 = kmx61_uscale_table[data->range];
20ffac278ebd64 Daniel Baluta 2014-12-03  821  			return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  822  		case IIO_MAGN:
20ffac278ebd64 Daniel Baluta 2014-12-03  823  			/* 14 bits res, 1465 microGauss per magn count */
20ffac278ebd64 Daniel Baluta 2014-12-03  824  			*val = 0;
20ffac278ebd64 Daniel Baluta 2014-12-03  825  			*val2 = 1465;
20ffac278ebd64 Daniel Baluta 2014-12-03  826  			return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  827  		default:
20ffac278ebd64 Daniel Baluta 2014-12-03  828  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  829  		}
20ffac278ebd64 Daniel Baluta 2014-12-03 @830  	case IIO_CHAN_INFO_SAMP_FREQ:
20ffac278ebd64 Daniel Baluta 2014-12-03  831  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
20ffac278ebd64 Daniel Baluta 2014-12-03  832  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  833  
84cb5906c7fb44 Maxwell Doose 2026-05-01  834  		scoped_guard(mutex, &data->lock)
20ffac278ebd64 Daniel Baluta 2014-12-03  835  			ret = kmx61_get_odr(data, val, val2, chan->address);
20ffac278ebd64 Daniel Baluta 2014-12-03  836  		if (ret)
20ffac278ebd64 Daniel Baluta 2014-12-03  837  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  838  		return IIO_VAL_INT_PLUS_MICRO;
20ffac278ebd64 Daniel Baluta 2014-12-03  839  	}
20ffac278ebd64 Daniel Baluta 2014-12-03  840  	return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  841  }
20ffac278ebd64 Daniel Baluta 2014-12-03  842  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
