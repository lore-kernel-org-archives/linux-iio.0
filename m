Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2A2F6920;
	Fri, 13 Feb 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771025515; cv=none; b=Uiq1CXIUe67s7ZegRTeIqlQdaU+vRSANHMswKxeuECxdQhnbES0nwxogIgPVZgYmFSY9Nx7WPnnx0jjMYHJFT+H9D4Nc7cmVj4A/xUPGX+DPgbcP+FW+C9mclxJhP7HrssXVFQ1Dyyexyup+KJFyaQd+34Ipe9pgDngyCreMg9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771025515; c=relaxed/simple;
	bh=HSbf+/cy/4jgfShi+cCubgYFZ3TTqSU11pCFA+cMaWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PIWeGPecYgCMXj/03YMXmFq7kAvqXchM1M9sY2DY1DWZCp1Sw/W+4b2s/u+4lLsVEFJJnBDhDfg6/J0po01nBn+Bg1MQBwL63jNSY1EgYzdqyADcbNEfpbOnC+nENfK6jTQETih/jWLzxlf57bl9M9ic0gDpS4SDNB1uyoHQ2mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nk8DjXn0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nk8DjXn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771025513; x=1802561513;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HSbf+/cy/4jgfShi+cCubgYFZ3TTqSU11pCFA+cMaWw=;
  b=nk8DjXn050aWl2aJe8/LyfYCX6NqLBuU7FY6leXYqLFEV89d+hVaJelH
   jkohXUCF3VOOQcrY3NZsqNpX4yuBS47LGKyz85ktdtMyhHPoZEgwDMh/s
   eUdL9mRRMNXVzJWxV0gkeOf51GL2grlO+9CMWAaRKQlMONXDMiGIgo1Lp
   sFiwUn/PCdR9ao+UgVxDFlgJQDVOyxgxkWkQYpdBHs5pjFxxqda2jHUl8
   uDW1AeyoQM8nxeEJeG9V++Y/mnWBP9zNaKlN0lCJnYIUtyoHEcto4jSeU
   R/W1WCdmQK/juG3Ey11xZSEUvhAu4DIX3pBdA4OvQ0J+Clb8ZaqOOhZJ0
   g==;
X-CSE-ConnectionGUID: UeWcEWG6TraGSZZl2rlFxA==
X-CSE-MsgGUID: cfMHJZ1+Ta686Q+3CLwC8A==
X-IronPort-AV: E=McAfee;i="6800,10657,11700"; a="82940727"
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="82940727"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 15:31:53 -0800
X-CSE-ConnectionGUID: AW1+DrwuQvCrzLSC77wnJw==
X-CSE-MsgGUID: xo6uZ1VeTr2n/uHN8Av49w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,289,1763452800"; 
   d="scan'208";a="218023499"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 13 Feb 2026 15:31:50 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vr2dY-00000000vu8-1eXZ;
	Fri, 13 Feb 2026 23:31:48 +0000
Date: Sat, 14 Feb 2026 07:31:03 +0800
From: kernel test robot <lkp@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>, jic23@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Neel Bullywon <neelb2403@gmail.com>
Subject: Re: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <202602140708.3KGC8ZJJ-lkp@intel.com>
References: <20260210233945.40975-2-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210233945.40975-2-neelb2403@gmail.com>

Hi Neel,

kernel test robot noticed the following build errors:

[auto build test ERROR on e7aa57247700733e52a8e2e4dee6a52c2a76de02]

url:    https://github.com/intel-lab-lkp/linux/commits/Neel-Bullywon/iio-magnetometer-bmc150_magn-use-automated-cleanup-for-mutex/20260211-074324
base:   e7aa57247700733e52a8e2e4dee6a52c2a76de02
patch link:    https://lore.kernel.org/r/20260210233945.40975-2-neelb2403%40gmail.com
patch subject: [PATCH v6 1/3] iio: magnetometer: bmc150_magn: use automated cleanup for mutex
config: loongarch-allmodconfig (https://download.01.org/0day-ci/archive/20260214/202602140708.3KGC8ZJJ-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260214/202602140708.3KGC8ZJJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602140708.3KGC8ZJJ-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/magnetometer/bmc150_magn.c:561:2: error: cannot jump from switch statement to this case label
     561 |         default:
         |         ^
   drivers/iio/magnetometer/bmc150_magn.c:527:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     527 |                 guard(mutex)(&data->mutex);
         |                 ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:122:1: note: expanded from here
     122 | __UNIQUE_ID_guard_677
         | ^
   drivers/iio/magnetometer/bmc150_magn.c:529:2: error: cannot jump from switch statement to this case label
     529 |         case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
         |         ^
   drivers/iio/magnetometer/bmc150_magn.c:527:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     527 |                 guard(mutex)(&data->mutex);
         |                 ^
   include/linux/cleanup.h:414:15: note: expanded from macro 'guard'
     414 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:122:1: note: expanded from here
     122 | __UNIQUE_ID_guard_677
         | ^
   2 errors generated.


vim +561 drivers/iio/magnetometer/bmc150_magn.c

c91746a2361d75 Irina Tirdea   2015-04-29  515  
c91746a2361d75 Irina Tirdea   2015-04-29  516  static int bmc150_magn_write_raw(struct iio_dev *indio_dev,
c91746a2361d75 Irina Tirdea   2015-04-29  517  				 struct iio_chan_spec const *chan,
c91746a2361d75 Irina Tirdea   2015-04-29  518  				 int val, int val2, long mask)
c91746a2361d75 Irina Tirdea   2015-04-29  519  {
c91746a2361d75 Irina Tirdea   2015-04-29  520  	struct bmc150_magn_data *data = iio_priv(indio_dev);
c91746a2361d75 Irina Tirdea   2015-04-29  521  	int ret;
c91746a2361d75 Irina Tirdea   2015-04-29  522  
c91746a2361d75 Irina Tirdea   2015-04-29  523  	switch (mask) {
c91746a2361d75 Irina Tirdea   2015-04-29  524  	case IIO_CHAN_INFO_SAMP_FREQ:
5990dc9703679a Irina Tirdea   2015-04-29  525  		if (val > data->max_odr)
5990dc9703679a Irina Tirdea   2015-04-29  526  			return -EINVAL;
d65a37daae6aa8 Neel Bullywon  2026-02-10  527  		guard(mutex)(&data->mutex);
d65a37daae6aa8 Neel Bullywon  2026-02-10  528  		return bmc150_magn_set_odr(data, val);
5990dc9703679a Irina Tirdea   2015-04-29  529  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
5990dc9703679a Irina Tirdea   2015-04-29  530  		switch (chan->channel2) {
5990dc9703679a Irina Tirdea   2015-04-29  531  		case IIO_MOD_X:
5990dc9703679a Irina Tirdea   2015-04-29  532  		case IIO_MOD_Y:
5990dc9703679a Irina Tirdea   2015-04-29  533  			if (val < 1 || val > 511)
5990dc9703679a Irina Tirdea   2015-04-29  534  				return -EINVAL;
d65a37daae6aa8 Neel Bullywon  2026-02-10  535  			{
d65a37daae6aa8 Neel Bullywon  2026-02-10  536  				guard(mutex)(&data->mutex);
5990dc9703679a Irina Tirdea   2015-04-29  537  				ret = bmc150_magn_set_max_odr(data, val, 0, 0);
d65a37daae6aa8 Neel Bullywon  2026-02-10  538  				if (ret < 0)
5990dc9703679a Irina Tirdea   2015-04-29  539  					return ret;
d65a37daae6aa8 Neel Bullywon  2026-02-10  540  				return regmap_update_bits(data->regmap,
5990dc9703679a Irina Tirdea   2015-04-29  541  							 BMC150_MAGN_REG_REP_XY,
1506f3cd0b8169 Hartmut Knaack 2015-07-17  542  							 BMC150_MAGN_REG_REP_DATAMASK,
d65a37daae6aa8 Neel Bullywon  2026-02-10  543  							 BMC150_MAGN_REPXY_TO_REGVAL(val));
d65a37daae6aa8 Neel Bullywon  2026-02-10  544  			}
5990dc9703679a Irina Tirdea   2015-04-29  545  		case IIO_MOD_Z:
5990dc9703679a Irina Tirdea   2015-04-29  546  			if (val < 1 || val > 256)
5990dc9703679a Irina Tirdea   2015-04-29  547  				return -EINVAL;
d65a37daae6aa8 Neel Bullywon  2026-02-10  548  			{
d65a37daae6aa8 Neel Bullywon  2026-02-10  549  				guard(mutex)(&data->mutex);
5990dc9703679a Irina Tirdea   2015-04-29  550  				ret = bmc150_magn_set_max_odr(data, 0, val, 0);
d65a37daae6aa8 Neel Bullywon  2026-02-10  551  				if (ret < 0)
5990dc9703679a Irina Tirdea   2015-04-29  552  					return ret;
d65a37daae6aa8 Neel Bullywon  2026-02-10  553  				return regmap_update_bits(data->regmap,
5990dc9703679a Irina Tirdea   2015-04-29  554  							 BMC150_MAGN_REG_REP_Z,
1506f3cd0b8169 Hartmut Knaack 2015-07-17  555  							 BMC150_MAGN_REG_REP_DATAMASK,
d65a37daae6aa8 Neel Bullywon  2026-02-10  556  							 BMC150_MAGN_REPZ_TO_REGVAL(val));
d65a37daae6aa8 Neel Bullywon  2026-02-10  557  			}
5990dc9703679a Irina Tirdea   2015-04-29  558  		default:
5990dc9703679a Irina Tirdea   2015-04-29  559  			return -EINVAL;
5990dc9703679a Irina Tirdea   2015-04-29  560  		}
c91746a2361d75 Irina Tirdea   2015-04-29 @561  	default:
c91746a2361d75 Irina Tirdea   2015-04-29  562  		return -EINVAL;
c91746a2361d75 Irina Tirdea   2015-04-29  563  	}
c91746a2361d75 Irina Tirdea   2015-04-29  564  }
c91746a2361d75 Irina Tirdea   2015-04-29  565  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
