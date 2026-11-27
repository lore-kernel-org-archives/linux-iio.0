Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795768411;
	b=SSAM3tRbjHd+/sml5MCdc1WYrqL9EEw2rZH0E5zpUIkwD0t3JJYTwBe2Pn4MwMXkskey
	 XtTPvJtCUqPXbzwHmPNU3VwFXkj1icXZJDkZqi0gwUX+MMkWFp658dDeyfidCcn1UIDDF
	 csuwNsqWOFXHWUL38LpSuTmqcze/83yESqdve3jxKycKxL38hA2Z4tXroGFkSvgnOi9D2
	 nETqrIyrU/S0P/qG4sUU98PGKz/H/UDUNiDxmarOoDaQN1D+6YsgVww2mhWkQSoEb8nU5
	 k7Pu5vja7GLNFFptfbfsaM+3hryXSiGCKRWL8pEzQXIAcjM1mdzMsbTzgdmkETQxY4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795768411;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=/h6ivogR65iO+inwU9QCiWi1gvByiI97sc5h6yHKLMM=;
	b=5Jt1tQ0EuyhuRYsuXh6X3qQ5yPe0C3OQjCpKwiU+A5kU4vsw1l08U81UA/g07Qb75AfP
	 wnMedUl2aIDnwA7qMEVcrIeZ3qiHyrKS+ONXEAPBy1IcVXH5jxvNmgNNU3LTAvNQHeSUn
	 EIjz5Tl4W8Z/dUblY4EWP+XBOzn4JCoJXl8DELg86D50rDs1NNei0gqIufnV3V946NhzA
	 03xZqgCcNio1aPTEP2ZUqJhYoFBEoS9GvoTZEuhjc0o9r03QbqlMcb8G/kr9eNlUfJIUm
	 1791/NAZ2q9nHW7Fwsq9PH6kr4ioS+ysYNCw90oKqhjBU4LvyOcr1/dPKKrDT/PcIJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fzx9f9eS;
	arc=none smtp.remote-ip=198.175.65.12
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE98606A31C;
	Fri, 27 Nov 2026 08:33:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9AE98606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=fzx9f9eS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795768411; x=1827304411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3GpE+F+q7kE86t8MgkNfa5zzEw9Mo11gooWpH2jqaUU=;
  b=fzx9f9eSmry8mnRAeFsIHVGDw0UC1U54sXgQ4ePV8ULPs5x+a/bGElx2
   6/uEl06oZC1y60r3dOorTh0eP+n5TFIJm7yDv64gaxH8jZVExs2xF5zV3
   E5O4dFATjACb4hktiZ+6es3k1bvhy5J5rIqZQYd0YCjpiD+Bm0Y8GotR3
   KKhczQsH6Xka0a18x+P1FaS5KemT04gcfYVWr9ZLzciiQMcmrU+mFFOCH
   eF4oYIUsu3LjT6IdU8Z2tmUHRv8pA9zcjDsrXehre+0TeyUwltKcbEmgc
   +HyKysqdmC72pS0ROUzViItCmOG2ZGHe4eVnWAYFCnksE0kDo8eJlt+db
   A==;
X-CSE-ConnectionGUID: POdSmR41Rom5ykHIRZ2cww==
X-CSE-MsgGUID: FMIH1xLqQsat2FiJ+UEnzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4583061"
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="4583061"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2026 00:33:30 -0800
X-CSE-ConnectionGUID: ubG+/dVMQfmbcUC6lqY/Eg==
X-CSE-MsgGUID: oqVoqhsbQCiER1kAgiDQvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,236,1787036400"; 
   d="scan'208";a="12237506"
Received: from igk-lkp-server01.igk.intel.com (HELO e79648c3b81b) ([10.211.93.152])
  by orviesa005.jf.intel.com with ESMTP; 27 Nov 2026 00:33:18 -0800
Received: from kbuild by e79648c3b81b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWrO4-0000000000p-1PQJ;
	Fri, 27 Nov 2026 08:33:00 +0000
Date: Fri, 27 Nov 2026 09:32:14 +0100
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v2 1/1] iio: core: Split debugfs routines
Message-ID: <20261127090758.cpRe3Nuo-lkp@intel.com>
References: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>
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
In-Reply-To: <20261125140251.384361-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.4-rc4 next-20261126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-core-Split-debugfs-routines/20261125-145940
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261125140251.384361-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v2 1/1] iio: core: Split debugfs routines
config: powerpc-randconfig-r2309-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127090758.cpRe3Nuo-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 3a9f981aab0cc32f74ffac36a87891cda8889c37)
sparse: v0.6.5-rc1-21-g84ec0658
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127090758.cpRe3Nuo-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127090758.cpRe3Nuo-lkp@intel.com/

All errors (new ones prefixed by >>):

>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against local symbol; recompile with -fPIC
   >>> defined in vmlinux.a(arch/powerpc/kernel/head_85xx.o)
   >>> referenced by arch/powerpc/kernel/head_85xx.o:(.head.text+0x3ca) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_task'; recompile with -fPIC
   >>> defined in vmlinux.a(init/init_task.o)
   >>> referenced by arch/powerpc/kernel/head_85xx.o:(.head.text+0x3ee) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_LO cannot be used against symbol 'init_task'; recompile with -fPIC
   >>> defined in vmlinux.a(init/init_task.o)
   >>> referenced by arch/powerpc/kernel/head_85xx.o:(.head.text+0x3f2) in archive vmlinux.a
--
>> ld.lld: error: relocation R_PPC_ADDR16_HI cannot be used against symbol 'init_thread_union'; recompile with -fPIC
   >>> defined in ./arch/powerpc/kernel/vmlinux.lds:145
   >>> referenced by arch/powerpc/kernel/head_85xx.o:(.head.text+0x3fe) in archive vmlinux.a

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
