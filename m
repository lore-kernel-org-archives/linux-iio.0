Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C843009E2;
	Fri, 20 Mar 2026 19:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036554; cv=none; b=nI2id4ZdBT3JmEwRDgOZ5VQ4/+xc8YSv8SZnwbZZd/mnpUtDyEdP+nQB8leP25Zm76PdnQgSyYcSYrlzGoi7YS/fqoVjhuYF084OhK5jUwttAg3NQkF9lz1aqrYWx039s7iTifpFS9HxJctkLeHxT9jYNjXPKlzZx7JTSbGpq80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036554; c=relaxed/simple;
	bh=cs/PyF7z0Anztg60JHDfGKN777e6PS9ueo05ULJLfwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N5AwVGOEwbsBhFhsgMMkoNs+dRwSc+KEwO3Bj3YN6HagPPm8SonJRXwcn9ZEPSfeV+7GswkHbxldxf9l4dtYzpEYNZEiDm6uLvz5mcavO4kERXsPGPTl34x6J9twZRwdrdatwcz+iI3hvC3Bz0ITCmWAqBxv3LS8TTmJDUR6E4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TrzxEQ5F; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TrzxEQ5F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774036553; x=1805572553;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cs/PyF7z0Anztg60JHDfGKN777e6PS9ueo05ULJLfwM=;
  b=TrzxEQ5FenW9IqKpO8Op6hs2yDuo/eJejkKk96TQ7G8XRUcXdE5e+Ck0
   YZQEne/ZwxGvhAeA9FZ12OQ3exPBSBslEh1igVMT5ew/ZsStyKWwo0+8h
   BKseNvqVxDGXGMJZ9+bQr+oend+va1Lp1AwYuydp85y1Yhw9UU9pJuSuR
   /x9EujUzL2efN4xiVTgaLurhiYA6bJT65AXQjIFq3AsNdXYP7Rz1Rw3rd
   5W+6qma7WgtTAhT3T8yVsIbLyRzikhfve7OshrDYqFlwBMXv1DwZmts2E
   KOjdRb/Z4+Uvgl3F9XsC3RMrAss9kqIV4tsl2HCAjT1/1SOa3O0BMCOE0
   w==;
X-CSE-ConnectionGUID: n9id4nXeQfmllUFUnim1BQ==
X-CSE-MsgGUID: AT2Ax1ToRUKT1wkNKUTIUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86204377"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86204377"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 12:55:53 -0700
X-CSE-ConnectionGUID: DLdHbX8mTf+bkUIaSC62EQ==
X-CSE-MsgGUID: lBMe7Cw+Sf+GGG0s/MtTzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="223414492"
Received: from lkp-server02.sh.intel.com (HELO ef9b23065726) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 20 Mar 2026 12:55:49 -0700
Received: from kbuild by ef9b23065726 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3fwg-0000000009D-0aWg;
	Fri, 20 Mar 2026 19:55:46 +0000
Date: Sat, 21 Mar 2026 03:53:51 +0800
From: kernel test robot <lkp@intel.com>
To: Matheus Giarola <matheustpgiarola@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, matheusgiarola@usp.br,
	arthurpilone@usp.br, davidbtadokoro@ime.usp.br
Subject: Re: [PATCH] iio: adc: ad7280a: replace mutex_lock() with guard(mutex)
Message-ID: <202603210357.KTWqlL36-lkp@intel.com>
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
config: parisc-randconfig-002-20260321 (https://download.01.org/0day-ci/archive/20260321/202603210357.KTWqlL36-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 9.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603210357.KTWqlL36-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603210357.KTWqlL36-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/adc/ad7280a.c:10:
   drivers/iio/adc/ad7280a.c: In function 'ad7280_read_raw':
>> include/linux/cleanup.h:299:2: error: a label can only be part of a statement and a declaration is not a statement
     299 |  class_##_name##_t var __cleanup(class_##_name##_destructor) = \
         |  ^~~~~~
   include/linux/cleanup.h:419:2: note: in expansion of macro 'CLASS'
     419 |  CLASS(_name, __UNIQUE_ID(guard))
         |  ^~~~~
   drivers/iio/adc/ad7280a.c:878:3: note: in expansion of macro 'guard'
     878 |   guard(mutex)(&st->lock);
         |   ^~~~~
--
   In file included from ad7280a.c:10:
   ad7280a.c: In function 'ad7280_read_raw':
>> include/linux/cleanup.h:299:2: error: a label can only be part of a statement and a declaration is not a statement
     299 |  class_##_name##_t var __cleanup(class_##_name##_destructor) = \
         |  ^~~~~~
   include/linux/cleanup.h:419:2: note: in expansion of macro 'CLASS'
     419 |  CLASS(_name, __UNIQUE_ID(guard))
         |  ^~~~~
   ad7280a.c:878:3: note: in expansion of macro 'guard'
     878 |   guard(mutex)(&st->lock);
         |   ^~~~~


vim +299 include/linux/cleanup.h

54da6a0924311c Peter Zijlstra 2023-05-26  297  
54da6a0924311c Peter Zijlstra 2023-05-26  298  #define CLASS(_name, var)						\
54da6a0924311c Peter Zijlstra 2023-05-26 @299  	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
54da6a0924311c Peter Zijlstra 2023-05-26  300  		class_##_name##_constructor
54da6a0924311c Peter Zijlstra 2023-05-26  301  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
