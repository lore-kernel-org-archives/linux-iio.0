Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F57151B195;
	Wed, 23 Sep 2026 12:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167539; cv=none; b=XFWV1PzldQveMqaw/mBV694a6EUh9FPt6f+ND7gIQ+mv3cFPPm155DkulzQbcLUqtcuxoi3SxV5L6K91MmLJb+Z9hEj/6hR9eMMg8pC+LESqf7mB+6Z/0drYShWpUw3YYxuMVKaNW/Kgrqjy1raG/YJurW+syX3Jc29Ihy1jncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167539; c=relaxed/simple;
	bh=srCTUfGk224K2epI4LhecoseeQTZJt7xRLCenRtI98c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnhIe0pFLkvtP7K6Fw74likGcmTIaiQDJujVwfNQ3uzVEl4YpyzQD39H2Dq0CTu9YwLTyB7HoGOQbbdqf7oJKG1yaIy1oXhSsf4PsosNqFUYf7DPQ/fnxrG7jolA2wjx8LXSWJXWKtr9ebWDWGRmDtYyXX70gJw3GnwxRXEBPmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RYFmIeTk; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RYFmIeTk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790167537; x=1821703537;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=srCTUfGk224K2epI4LhecoseeQTZJt7xRLCenRtI98c=;
  b=RYFmIeTkEB7lpf4D5RYumJnSuFj7+ZhwNbvN4leZBCSM4u4VpZTaSaSs
   nHHryf1wS+dpUcsFzR0jpsVCXJwPaNhmt9uf5VUG9+QVCuEuSZPYNCBPb
   w99sVBUuBrDzUz2qxIiiehnlPayllOLvqZEKhY5X927MFk/JabpaXf+Cn
   JtuiNy4jI4dBmN1QoA2+ThZWA4yZ3Tw/ZdBHIKTWRHZ57IAb6vD28r23V
   nFHw7g0oLettAp8On1bpQXzLCl+g9+42YrhmtLdkLrmE/n3O/lAEEom03
   p8otoUcuIdpTcxcI7NmDchVDQcQvOK4qf5pOP2CFMrIrdhuTcJDRnOAv1
   g==;
X-CSE-ConnectionGUID: /N9jods/TcuNap+r2G0iGA==
X-CSE-MsgGUID: J34et4ZeSPOK46vywlCQpA==
X-IronPort-AV: E=McAfee;i="6800,10657,11913"; a="90881973"
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="90881973"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2026 05:45:36 -0700
X-CSE-ConnectionGUID: Yu5aMw31QG+JaBjiPlYb+g==
X-CSE-MsgGUID: albm4oKHT2uyANLH+mKeKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,118,1787036400"; 
   d="scan'208";a="281671148"
Received: from igk-lkp-server01.igk.intel.com (HELO 1bbc298b9a73) ([10.211.93.152])
  by fmviesa005.fm.intel.com with ESMTP; 23 Sep 2026 05:45:33 -0700
Received: from kbuild by 1bbc298b9a73 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1x9MLr-000000000g7-2OUk;
	Wed, 23 Sep 2026 12:45:31 +0000
Date: Wed, 23 Sep 2026 14:44:35 +0200
From: kernel test robot <lkp@intel.com>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>, jic23@kernel.org,
	gregkh@linuxfoundation.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com, andy@kernel.org,
	linux@analog.com, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com, error27@gmail.com,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <202609231453.RPvUxbGl-lkp@intel.com>
References: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>

Hi Abdelnasser,

kernel test robot noticed the following build errors:

[auto build test ERROR on staging/staging-testing]

url:    https://github.com/intel-lab-lkp/linux/commits/Abdelnasser-Hussein/staging-iio-adc-ad7816-Protect-sysfs-attributes-with-mutex/20260920-121522
base:   staging/staging-testing
patch link:    https://lore.kernel.org/r/20260920091522.15507-1-abdelnasserhussein11%40gmail.com
patch subject: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes with mutex
config: i386-randconfig-2102-20260923 (https://download.01.org/0day-ci/archive/20260923/202609231453.RPvUxbGl-lkp@intel.com/config)
compiler: clang version 22.1.8 (https://github.com/llvm/llvm-project ca7933e47d3a3451d81e72ac174dcb5aa28b59d1)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260923/202609231453.RPvUxbGl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609231453.RPvUxbGl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/staging/iio/adc/ad7816.c:139:22: error: no member named 'lock' in 'struct ad7816_chip_info'
     139 |         guard(mutex)(&chip->lock);
         |                       ~~~~  ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:67:1: note: expanded from here
      67 | class_mutex_constructor
         | ^
>> drivers/staging/iio/adc/ad7816.c:139:22: error: no member named 'lock' in 'struct ad7816_chip_info'
     139 |         guard(mutex)(&chip->lock);
         |                       ~~~~  ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:67:1: note: expanded from here
      67 | class_mutex_constructor
         | ^
   drivers/staging/iio/adc/ad7816.c:205:22: error: no member named 'lock' in 'struct ad7816_chip_info'
     205 |         guard(mutex)(&chip->lock);
         |                       ~~~~  ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:107:1: note: expanded from here
     107 | class_mutex_constructor
         | ^
   drivers/staging/iio/adc/ad7816.c:205:22: error: no member named 'lock' in 'struct ad7816_chip_info'
     205 |         guard(mutex)(&chip->lock);
         |                       ~~~~  ^
   include/linux/cleanup.h:423:2: note: expanded from macro 'guard'
     423 |         CLASS(_name, __UNIQUE_ID(guard))
         |         ^
   include/linux/cleanup.h:303:3: note: expanded from macro 'CLASS'
     303 |                 class_##_name##_constructor
         |                 ^
   <scratch space>:107:1: note: expanded from here
     107 | class_mutex_constructor
         | ^
   4 errors generated.


vim +139 drivers/staging/iio/adc/ad7816.c

   130	
   131	static ssize_t ad7816_store_mode(struct device *dev,
   132					 struct device_attribute *attr,
   133					 const char *buf,
   134					 size_t len)
   135	{
   136		struct iio_dev *indio_dev = dev_to_iio_dev(dev);
   137		struct ad7816_chip_info *chip = iio_priv(indio_dev);
   138	
 > 139		guard(mutex)(&chip->lock);
   140	
   141		if (strcmp(buf, "full") == 0) {
   142			gpiod_set_value(chip->rdwr_pin, 1);
   143			chip->mode = AD7816_FULL;
   144		} else {
   145			gpiod_set_value(chip->rdwr_pin, 0);
   146			chip->mode = AD7816_PD;
   147		}
   148	
   149		return len;
   150	}
   151	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
