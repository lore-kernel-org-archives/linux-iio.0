Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795588174;
	b=YGQCMc6fXJHXIHtpoSCma+OtNixCZcOK+l7ZvzI9N0xhYa2+tlkkg0gtBquSCOulvQWA
	 x1Sx7fIiyHYiZpzQhyZsoCKz1TNrsrlsxJdNdRfECBmNJFYNI/LrE95SUJ4kZX1akSm8J
	 t2qNNHLa54plUgN0ccMjcfmkQXt9gVVGL7lsEONZnuRxBQqRX8aZptTl6qyL1FqZCZCTh
	 IpAMz5QE0HfbqUC0A11jGGTeeTSn/fwR681w2f2iy2r3E4oA2foMXvkSUPInU8kdQnX5D
	 q+aOkSTBZDNRNguCmqrH/WqN3RnXKY4aTZxZ78c3vqK3xnERBHG7/pl1OlcMb4I5mNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795588174;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=fUGmkZ5pnD7Ji+vwezUPcu5hIMdhnLtQNfaT/AXBEjw=;
	b=iNBVPxaAn+dkh/ty3b6WakhDl7nBNGR8kyaeUqRCh4S7g897XgwSB4hdiGJ49mkASDtT
	 YYFjXMWDSOH2rlabqBm4XK5vb9KOgmEGiJjTCSrQxqZzXMrjZ2p/t+VnPWTaglclNzaFr
	 GS4efodULP67Np9vo6Ls8fPTagMA8gsX98++ROS1yWrAC3EWCC2Tq33s+sNClH7hpqx5p
	 H/cc/poPrbbwM5AXwnDXwKYEEzVzCFodwmb2yPPOf51sVcyOkgp3uPVWjxcHSCx5KB3P0
	 JxkydI8Q7YOTbgiHCWDar6DcJY2aTFFi20xBcn2uRZh7XZp20riqQ3+WI00+aC7ednQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QWCJMN0G;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E6C606A31E;
	Wed, 25 Nov 2026 06:29:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E6C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QWCJMN0G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795588173; x=1827124173;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zbfSXjIyKSD5Zk3TOvJSq6/F/aAsespPwza+20D7QQc=;
  b=QWCJMN0GGnZNj0/toHQaOglw3+Fh46UhlhLoJncF7dpgPXkBRtFbSXO2
   XlTlg+nEJViRgdIWuR+MELw/Bs6754WvuOA2Wju/rwutbKkwurBKrQ8kf
   c46Yn+vHZ4API8g30cENTJRUVkpB1bSQ3tjF1Mw47OCg15H0o6oKbbQRK
   TDRIBm8GuxWNHyEKV7YNr2ap0EH2rPZlu3ZboZ9i/FQRFTTcMWbErpraJ
   SghGefEnykmpFUsmDTRAqvSaACtucxTAdENwtaRpGRH+zmkeK5ymiv7Lq
   9Y572YUESA32z/+kZ2z405ipMdilNavArW+QwZvOR7FWw2cxd4mBCP3K3
   w==;
X-CSE-ConnectionGUID: sl+g9t7LT3SVWctPqLdB3Q==
X-CSE-MsgGUID: B7GLqjYgRqeBO/GJZUr0/Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4327641"
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="4327641"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 22:29:32 -0800
X-CSE-ConnectionGUID: U2iK7523Q6OhqPtrIr3ZOw==
X-CSE-MsgGUID: oWoe1juLSb2zHvTRnd4GDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,232,1787036400"; 
   d="scan'208";a="11764984"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 24 Nov 2026 22:29:28 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xW6VS-00000001Qyu-0xCE;
	Wed, 25 Nov 2026 06:29:26 +0000
Date: Wed, 25 Nov 2026 14:28:49 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Ijtsma <robertijtsma@gmail.com>
Subject: Re: [PATCH 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
Message-ID: <20261125142230.FjfgcgpD-lkp@intel.com>
References: <20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124-iio-tcs3430-v1-2-0f2a38a6a4c1@gmail.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4843f6873f7c4835e62f2c73ba0fd538e57a2f22]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Ijtsma-via-B4-Relay/dt-bindings-iio-light-add-ams-OSRAM-TCS3430/20261124-234657
base:   4843f6873f7c4835e62f2c73ba0fd538e57a2f22
patch link:    https://lore.kernel.org/r/20261124-iio-tcs3430-v1-2-0f2a38a6a4c1%40gmail.com
patch subject: [PATCH 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient light sensor driver
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20261125/20261125142230.FjfgcgpD-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125142230.FjfgcgpD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125142230.FjfgcgpD-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/light/tcs3430.c:175:2: error: cannot jump from switch statement to this case label
     175 |         default:
         |         ^
   drivers/iio/light/tcs3430.c:166:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     166 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:416:2: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:299:3: note: expanded from macro 'CLASS'
     299 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:22:1: note: expanded from here
      22 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:28:1: note: expanded from here
      28 | __UNIQUE_ID_unlock_541
         | ^
   drivers/iio/light/tcs3430.c:166:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:416:15: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:16:1: note: expanded from here
      16 | __UNIQUE_ID_guard_540
         | ^
   drivers/iio/light/tcs3430.c:142:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     142 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:416:2: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:299:3: note: expanded from macro 'CLASS'
     299 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:17:1: note: expanded from here
      17 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^
   <scratch space>:23:1: note: expanded from here
      23 | __UNIQUE_ID_unlock_537
         | ^
   drivers/iio/light/tcs3430.c:142:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
   include/linux/cleanup.h:416:15: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
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
   <scratch space>:11:1: note: expanded from here
      11 | __UNIQUE_ID_guard_536
         | ^
   drivers/iio/light/tcs3430.c:170:2: error: cannot jump from switch statement to this case label
     170 |         case IIO_CHAN_INFO_INT_TIME:
         |         ^
   drivers/iio/light/tcs3430.c:166:3: note: jump bypasses initialization of variable with __attribute__((cleanup))
     166 |                 guard(mutex)(&data->lock);
         |                 ^
   include/linux/cleanup.h:416:2: note: expanded from macro 'guard'
     416 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:299:3: note: expanded from macro 'CLASS'
     299 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:22:1: note: expanded from here
      22 | class_mutex_constructor
         | ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:16:23: note: expanded from macro '__PASTE'
      16 | #define __PASTE(a, b) ___PASTE(a, b)
         |                       ^
   include/linux/compiler_types.h:15:24: note: expanded from macro '___PASTE'
      15 | #define ___PASTE(a, b) a##b
         |                        ^


vim +175 drivers/iio/light/tcs3430.c

   132	
   133	static int tcs3430_read_raw(struct iio_dev *indio_dev,
   134				    const struct iio_chan_spec *chan,
   135				    int *val, int *val2, long mask)
   136	{
   137		struct tcs3430_data *data = iio_priv(indio_dev);
   138		int ret;
   139	
   140		switch (mask) {
   141		case IIO_CHAN_INFO_RAW:
   142			guard(mutex)(&data->lock);
   143			ret = i2c_smbus_read_word_data(data->client, chan->address);
   144			if (ret < 0)
   145				return ret;
   146			*val = ret;
   147			return IIO_VAL_INT;
   148	
   149		case IIO_CHAN_INFO_SCALE: {
   150			u32 itime_us = TCS3430_DEFAULT_ATIME_CYCLES * TCS3430_ATIME_STEP_US;
   151			u64 scale_nano;
   152			u32 rem;
   153			int gain;
   154	
   155			scoped_guard(mutex, &data->lock)
   156				gain = tcs3430_gains[data->gain_idx];
   157	
   158			scale_nano = div_u64(TCS3430_LUX_FACTOR * NSEC_PER_SEC * USEC_PER_MSEC,
   159					     (u32)gain * itime_us);
   160			*val = div_u64_rem(scale_nano, NSEC_PER_SEC, &rem);
   161			*val2 = rem;
   162			return IIO_VAL_INT_PLUS_NANO;
   163		}
   164	
   165		case IIO_CHAN_INFO_HARDWAREGAIN:
   166			guard(mutex)(&data->lock);
   167			*val = tcs3430_gains[data->gain_idx];
   168			return IIO_VAL_INT;
   169	
   170		case IIO_CHAN_INFO_INT_TIME:
   171			*val = 0;
   172			*val2 = TCS3430_DEFAULT_ATIME_CYCLES * TCS3430_ATIME_STEP_US;
   173			return IIO_VAL_INT_PLUS_MICRO;
   174	
 > 175		default:
   176			return -EINVAL;
   177		}
   178	}
   179	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
