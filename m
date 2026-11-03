Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793720759;
	b=Vn9aaJTGZC4vESq/9/86cfwvcumygmRUbX3/LgfzKOFXcnHRvjozf2THEJnVoMnsJZ24
	 XOKD7ymDTwHqe+VLdkqlRDg/7GnhRpzAEp1FNpXK7gdFcbQq27nhsS62KS6+/mQgbl7l8
	 EDqKi5qsUUCSIm9SsmOfrRQyvR6YWMqJdxX6pdhCwlGbGYxZvzmh4pG/YQwHy0HwknvKh
	 mtlhrbe+BbiSWpAfAIaN9RyylDQvUTtlO0svSpsyNEYSqFYzTRn0as2bB/EP2UcyU1UGQ
	 uj6Yn0akbdmiwDJu7ybvjt6C/voOz5vLzOBHRvBoq2SQa97h5MWcdufefwmEMMK/kRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793720759;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=f7Pn46So8jQHSwB+62GBHRAlUQBXhNesp3S3EaLzuus=;
	b=HwNHX1EMkFRew4yoepHGX6SYzXISc+OI4j1MTR0RbxCgw2F7/qjvUb/AjPZ6/a+l7H6m
	 8HgZtSdRQ7HqY3Onw3rh4ZNtK/3+ORbNllkW5bq13uY7rsa8dZcXv569mUMQJB35ZKBYa
	 mS9h0WuPCqyAwnIkHg3NQ93Zlxh8GirlMYShtcyEspO2ypCuV34xwMnuFe2NwMvWMMKU0
	 Mm/6sABybkMGXvor17DTB9Kg+qeXIQASKdj/hSubPRw9X5K7C4KtJ1b4p7pGRykbD6m+H
	 AefTf6PokoKR4maGO/zGwNTQ5PjI21aaCTEiFX+CUJVKQAl453dij5+tjeA3EDx+sdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2b1F9NO;
	arc=none smtp.remote-ip=192.198.163.12
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2DE8606A328;
	Tue,  3 Nov 2026 15:45:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2DE8606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=m2b1F9NO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793720758; x=1825256758;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/hWz6No+TOy+Nqs6e3zuOEJoXU4KQWjUPwFN3ClO4YI=;
  b=m2b1F9NO8SXz5vtWyaCB4S8GHXZVe/06CXxfc8tC4LWVb7tnL1wMU8Ix
   QZIg51V2WTgQUJxqhFp55rBwgD9pgLLM8c7TtiS9mg7maisD2qLtIBS3a
   iswwuHdXJQV7SlgSTTSHVdNnXPIBPJvFwQz1t2dcv3/HIiqxAWu/5uI0l
   U7Q0BALyrxmCxMDa+hReeh0LJTHZYV4cPei5WaPTMxDZjzk2gwpTb1tP6
   kOyEODhg0TSU52q706qEhyhYXYAq/DKCQz/3I8v/5rNWRcG6BC4lEZk9M
   bZV50IBQ3SSKF1zH3wubXWYemDCjZBT6ODwDmHQMRNPxMJXRoIfULEM5S
   Q==;
X-CSE-ConnectionGUID: ke0dN1xsRGiWNOpQ6iQh7A==
X-CSE-MsgGUID: MHZ9D4YMTFe4dDm1y8NROQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2345498"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2345498"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 07:45:57 -0800
X-CSE-ConnectionGUID: o1ORyvq0Rp+i08G3uu5p/g==
X-CSE-MsgGUID: WATM+HGzT0a73yy/LSr3UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6568401"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 03 Nov 2026 07:45:55 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xOGhs-00000000iu7-3RMG;
	Tue, 03 Nov 2026 15:45:52 +0000
Date: Tue, 3 Nov 2026 23:45:02 +0800
From: kernel test robot <lkp@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v4 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <202611032339.9VCI3mxZ-lkp@intel.com>
References: <SN1PR12MB25281F8D83D65C87BF4B6A43A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25281F8D83D65C87BF4B6A43A56C2@SN1PR12MB2528.namprd12.prod.outlook.com>

Hi Victor,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3 next-20261030]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Chernyakin/iio-prepare-iio_format_value-to-handle-higher-precision-IIO_VAL_DECIMAL64_-formats/20261031-101327
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN1PR12MB25281F8D83D65C87BF4B6A43A56C2%40SN1PR12MB2528.namprd12.prod.outlook.com
patch subject: [PATCH v4 4/4] iio: cdc: add Texas Instruments FDC1004 driver
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20261103/202611032339.9VCI3mxZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611032339.9VCI3mxZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611032339.9VCI3mxZ-lkp@intel.com/

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: drivers/iio/cdc/fdc1004.o: in function `fdc1004_write_raw':
>> fdc1004.c:(.text.fdc1004_write_raw+0x344): undefined reference to `__aeabi_ldivmod'

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
