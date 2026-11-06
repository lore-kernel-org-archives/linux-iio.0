Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794001706;
	b=2RiHKaTbweKNKZlP5ZYZkgONdqTz7KLwWsvM/jLo3B3xK2ybhbuaZpjZ+moR/4DArvhF
	 5oqHl/FEKhLLGCZW+UQorVRlRdIFczdeqCEv07Y04aIkyVMdBVkAjQrhsVMPleemK1OxH
	 CE8XezhoG8yYPIbJ152+17lrWKwFG61whnbqIzaiJd6+Uz/SnJCEJlWSmBbHHMT7MNeQW
	 LAGYBAyTaB4cfgQdNk9YTPCzKmnxT/bYHdKCRp1vcCNSPUa7t6g9jXR215N1HBBy/75ha
	 4n/98cdxNOMlY13Js2+wFsANlSgwWjRUOD7PA959/Tt6o7NVrMeZ/ZjFt+KuDGg60BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794001706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2HoSPxi/LKdkm47Df3tPYzsKHjifKjuEh/WGLdhSzqQ=;
	b=WLOyozDtA4CT3a6h9ENJPbBNIytdCexEjTP0qimjobqsH+G1X4IFJN4YK45980sGF6Bs
	 tEAcqudZoO+SwbhntgBGiY5Eqosp6MTTkdTTTsahEFhtXpNK/Qn/fQpcJrN+/wVYHdhLt
	 96mIbE080MrHOfvhxjKNJkX63u5m5GyWgF1tr+85jQpYYbZfdCcMgzXwhmRylL0aWODMR
	 ukSSBTTLDiYwv+jb3kmVnvj32UJrbfnDWdkLXHFIZIg4++ssLZjMoDfUIpKrXpE9RgAr1
	 m5uyLQfOO1FBb4BjD70dlfVUvg+oinznclO9MOIQo+7rQ904SFcjU/KVxHvV5iclx2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QBrb4ZoX;
	arc=none smtp.remote-ip=192.198.163.16
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B02606A329;
	Fri,  6 Nov 2026 21:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47B02606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=QBrb4ZoX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794001706; x=1825537706;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSs1l8nhYrpwzkpHVGWh8LOwtOJ0/LXns2Bi/tCifvw=;
  b=QBrb4ZoXN+q5l7oFKFFD2meW03Od90pOPcjZQFmeELSLG5aEpgdRYihP
   mN0NLbnMY4GRnfg83Hu2r8PYv8kulatra16kF/YMx8EPhbG19Zy7aVwI+
   Qj6lT+NGIdo5U1UQKH85dH2kU7Da/Kmfb96eQCANIH9Mu/feQM+xOOxFK
   dgxuOkPV2Mw3JMmtQIkOp+Cfjx4YLcgsClqsO/ovZiY9S6hSfHtT8pABh
   XSMFYu2YXOSpZpvyUN1wkFId2AZieJOUhGV9O/RBD2dPAqvttix68JzN9
   6vR+HfUf/tQFkL01Htg7M6bkMcCnlZ0bB+7fm08AL/lgTwCSsIXKvj9vA
   A==;
X-CSE-ConnectionGUID: Dhoga47ZSACQbntO3rovLg==
X-CSE-MsgGUID: 7qflis1HQaO40lH+/aPAsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2844968"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2844968"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 13:48:25 -0800
X-CSE-ConnectionGUID: BE2AOsrZS7K6OrFTOVvLVw==
X-CSE-MsgGUID: i6pRJuJ3Rw6w+3hwoPPrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7401217"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 06 Nov 2026 13:48:23 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPRnI-00000000pyV-1QGT;
	Fri, 06 Nov 2026 21:48:20 +0000
Date: Sat, 7 Nov 2026 05:47:38 +0800
From: kernel test robot <lkp@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <202611070503.6fdgeWCZ-lkp@intel.com>
References: <SN1PR12MB2528BA7C696815089DCAD02FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528BA7C696815089DCAD02FA5762@SN1PR12MB2528.namprd12.prod.outlook.com>

Hi Victor,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.4-rc1 next-20261105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Victor-Chernyakin/iio-prepare-iio_format_value-to-handle-higher-precision-IIO_VAL_DECIMAL64_-formats/20261106-094026
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/SN1PR12MB2528BA7C696815089DCAD02FA5762%40SN1PR12MB2528.namprd12.prod.outlook.com
patch subject: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
config: nios2-randconfig-1000-20261107 (https://download.01.org/0day-ci/archive/20261107/202611070503.6fdgeWCZ-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611070503.6fdgeWCZ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611070503.6fdgeWCZ-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/cdc/fdc1004.c:67:10: warning: integer overflow in expression of type 'long int' results in '-1246822400' [-Woverflow]
     -0x8000 * 488281250L, /* min */
             ^
   drivers/iio/cdc/fdc1004.c:69:10: warning: integer overflow in expression of type 'long int' results in '758541150' [-Woverflow]
     +0x7FFF * 488281250L, /* max */
             ^


vim +67 drivers/iio/cdc/fdc1004.c

    59	
    60	/*
    61	 * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
    62	 * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
    63	 * Negative values are used to cancel out any parasitic capacitance
    64	 * of the sensor's external circuitry.
    65	 */
    66	static const s64 fdc1004_calibbias[] = {
  > 67		-0x8000 * 488281250L, /* min */
    68		+0x0001 * 488281250L, /* step */
    69		+0x7FFF * 488281250L, /* max */
    70	};
    71	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
