Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CF93E411C;
	Mon, 19 Oct 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394789; cv=none; b=Y+W0zLhLTIcjZWZ6Qz7aFgsl4bmlYmYqc5hq2osGL2uP/7c94xGA0u7I+jfBAjkzBmE6sMDnh1QOm2KpOKEiQkrug9CLvFTcjuCWX3+PYulgF/lNek+yd5ILXSn3U2Ieq9+sEWDD8TTNLySPmMVJZi1vfxOTI6RDSmTmumFFMzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394789; c=relaxed/simple;
	bh=ojUZFWP2DlWCiuh9pouK9Gk6Nx7A2KYd43EqxPlj7Ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GK58EidOKHV3rtEqPNr6iWqjUeny2YM3sIhZ9gO22ivuWk01MkFIvFE9Jq/mDU7xz7E/XYeXX1o2j5ITObCry1B3CjFVWhLdZMNITG/0vuUtOfpy9SlmLq2fOq3FlCzkrFM8CHFCZ6n3TzoFU6UqyNmY3djBsneCHA8qJuU5QQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NggmA4Qo; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NggmA4Qo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792394788; x=1823930788;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ojUZFWP2DlWCiuh9pouK9Gk6Nx7A2KYd43EqxPlj7Ic=;
  b=NggmA4QoCwLUe2h6h9hoAZ3c/ERkzbv7wlNuigRqOksWj0E0/6NYmA4P
   XNnP3qHmRMPPhHAmlxG9gaoWGg+o4fleJN6WX7+2Mt5FCjAJHgInAn84k
   dh54PR1rRdiV/R4Y8T/1k+fYcJr/uCHuzM20fOPLaAuGHnG0XnOChQb4M
   zbQU1B6zGBzjSD4zMHd/joIoY2ynQ26+/77eWWN9jnDpic0HOoeQFzZmk
   klc8Tk6NqWpKH3zwAJ6iVJYDuriD20NiRS0TOMpf2l/15Mz7yi+33C4Uk
   IWVGP3Low2POG4hENLNsZ/4318ayl/2XtqsY5pr0f1mDaeSV0k6BZbPj2
   Q==;
X-CSE-ConnectionGUID: 6+2MOuQcTeKigiWptAtT2w==
X-CSE-MsgGUID: IVtKDymjRZ2DeIuxNQZakg==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="969292"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="969292"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2026 00:26:27 -0700
X-CSE-ConnectionGUID: Z48lC4aNQkO/puS+wgDuUQ==
X-CSE-MsgGUID: ZBn93RzTQtKRXTscKLBrvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="2525540"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 19 Oct 2026 00:26:24 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xIhlF-00000000LNe-2kmD;
	Mon, 19 Oct 2026 07:26:21 +0000
Date: Mon, 19 Oct 2026 15:26:00 +0800
From: kernel test robot <lkp@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org, Nikhil Gautam <nikhilgtr@gmail.com>
Subject: Re: [PATCH] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <202610191533.IG7DYuci-lkp@intel.com>
References: <20261018170013.79443-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261018170013.79443-1-nikhilgtr@gmail.com>

Hi Nikhil,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3 next-20261016]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikhil-Gautam/iio-chemical-ccs811-Make-sampling-frequency-configurable/20261018-223013
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261018170013.79443-1-nikhilgtr%40gmail.com
patch subject: [PATCH] iio: chemical: ccs811: Make sampling frequency configurable
config: i386-buildonly-randconfig-1003-20261019 (https://download.01.org/0day-ci/archive/20261019/202610191533.IG7DYuci-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261019/202610191533.IG7DYuci-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610191533.IG7DYuci-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/chemical/ccs811.c:389:2: error: cannot jump from switch statement to this case label
     389 |         default:
         |         ^
   drivers/iio/chemical/ccs811.c:371:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     371 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:136:1: note: expanded from here
     136 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:142:1: note: expanded from here
     142 | __UNIQUE_ID_unlock_406
         | ^
   drivers/iio/chemical/ccs811.c:371:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
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
   <scratch space>:130:1: note: expanded from here
     130 | __UNIQUE_ID_guard_405
         | ^
   1 error generated.


vim +389 drivers/iio/chemical/ccs811.c

1a2cae129fb93c Nikhil Gautam            2026-10-18  325  
fef6da136ef283 Jonathan Cameron         2025-03-31  326  static int ccs811_read_raw(struct iio_dev *indio_dev,
fef6da136ef283 Jonathan Cameron         2025-03-31  327  			   struct iio_chan_spec const *chan,
fef6da136ef283 Jonathan Cameron         2025-03-31  328  			   int *val, int *val2, long mask)
fef6da136ef283 Jonathan Cameron         2025-03-31  329  {
fef6da136ef283 Jonathan Cameron         2025-03-31  330  	struct ccs811_data *data = iio_priv(indio_dev);
fef6da136ef283 Jonathan Cameron         2025-03-31  331  	int ret;
fef6da136ef283 Jonathan Cameron         2025-03-31  332  
fef6da136ef283 Jonathan Cameron         2025-03-31  333  	switch (mask) {
fef6da136ef283 Jonathan Cameron         2025-03-31  334  	case IIO_CHAN_INFO_RAW:
e9786c540804c3 Jonathan Cameron         2025-03-31  335  		if (!iio_device_claim_direct(indio_dev))
e9786c540804c3 Jonathan Cameron         2025-03-31  336  			return -EBUSY;
fef6da136ef283 Jonathan Cameron         2025-03-31  337  
fef6da136ef283 Jonathan Cameron         2025-03-31  338  		ret = ccs811_read_info_raw(data, chan, val, mask);
fef6da136ef283 Jonathan Cameron         2025-03-31  339  
e9786c540804c3 Jonathan Cameron         2025-03-31  340  		iio_device_release_direct(indio_dev);
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  341  
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  342  		return ret;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  343  
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  344  	case IIO_CHAN_INFO_SCALE:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  345  		switch (chan->type) {
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  346  		case IIO_VOLTAGE:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  347  			*val = 1;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  348  			*val2 = 612903;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  349  			return IIO_VAL_INT_PLUS_MICRO;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  350  		case IIO_CURRENT:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  351  			*val = 0;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  352  			*val2 = 1000;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  353  			return IIO_VAL_INT_PLUS_MICRO;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  354  		case IIO_CONCENTRATION:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  355  			switch (chan->channel2) {
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  356  			case IIO_MOD_CO2:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  357  				*val = 0;
8f114acd4e1a9c Narcisa Ana Maria Vasile 2017-12-06  358  				*val2 = 100;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  359  				return IIO_VAL_INT_PLUS_MICRO;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  360  			case IIO_MOD_VOC:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  361  				*val = 0;
8f114acd4e1a9c Narcisa Ana Maria Vasile 2017-12-06  362  				*val2 = 100;
8f114acd4e1a9c Narcisa Ana Maria Vasile 2017-12-06  363  				return IIO_VAL_INT_PLUS_NANO;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  364  			default:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  365  				return -EINVAL;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  366  			}
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  367  		default:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  368  			return -EINVAL;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  369  		}
1a2cae129fb93c Nikhil Gautam            2026-10-18  370  	case IIO_CHAN_INFO_SAMP_FREQ:
1a2cae129fb93c Nikhil Gautam            2026-10-18  371  		guard(mutex)(&data->lock);
1a2cae129fb93c Nikhil Gautam            2026-10-18  372  		switch (data->drive_mode) {
1a2cae129fb93c Nikhil Gautam            2026-10-18  373  		case CCS811_MODE_IAQ_1SEC:
1a2cae129fb93c Nikhil Gautam            2026-10-18  374  			*val = 1;
1a2cae129fb93c Nikhil Gautam            2026-10-18  375  			*val2 = 0;
1a2cae129fb93c Nikhil Gautam            2026-10-18  376  			return IIO_VAL_INT_PLUS_MICRO;
1a2cae129fb93c Nikhil Gautam            2026-10-18  377  		case CCS811_MODE_IAQ_10SEC:
1a2cae129fb93c Nikhil Gautam            2026-10-18  378  			*val = 0;
1a2cae129fb93c Nikhil Gautam            2026-10-18  379  			*val2 = 100000;
1a2cae129fb93c Nikhil Gautam            2026-10-18  380  			return IIO_VAL_INT_PLUS_MICRO;
1a2cae129fb93c Nikhil Gautam            2026-10-18  381  		case CCS811_MODE_IAQ_60SEC:
1a2cae129fb93c Nikhil Gautam            2026-10-18  382  			*val = 0;
1a2cae129fb93c Nikhil Gautam            2026-10-18  383  			*val2 = 16667;
1a2cae129fb93c Nikhil Gautam            2026-10-18  384  			return IIO_VAL_INT_PLUS_MICRO;
1a2cae129fb93c Nikhil Gautam            2026-10-18  385  		default:
1a2cae129fb93c Nikhil Gautam            2026-10-18  386  			return -EINVAL;
1a2cae129fb93c Nikhil Gautam            2026-10-18  387  		}
1a2cae129fb93c Nikhil Gautam            2026-10-18  388  
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17 @389  	default:
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  390  		return -EINVAL;
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  391  	}
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  392  }
a94c24a712acb2 Narcisa Ana Maria Vasile 2017-07-17  393  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
