Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794017651;
	b=QxMnvmaqoEehlIr09CpmLw85QtdAkLDYeqnIPIGb+er81loCHmcwcr6aV89EWwegKBrg
	 Wy30Q5BAdTHCxbNSCQAx0wvJ4DZ/Bdqnmo8FdTwhYMLqUuaVWlCYngsVa2Cafnncx+boA
	 RHo9ScM5FUUAWZ8eGC7pxEowZvkqw4NKG2bezmdJVGUEY3oKLS2AF6AXgHNBbrPLu5s6S
	 MMqzdiVfV7K306MShRiAyVFlR64ndcoI26AI426mwzXJVB3WQdOnNF5iHYwpu584r+Yr1
	 1xh1YkzbFvG9DLRslikd6AzT0DajsyG64hqqxYfoOJxmt6R6tYrMi13yEFCzq5MovTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794017651;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=BX7THsmosjCKccT+25A6DC5CxzkdJXQF4Pn0GPYFDes=;
	b=GtfwOSrTQZ2AhBqC/0IA8YxO5NF1k2jIungPg8nldKATDmjKuzdRg0HIZi1kZXFQZ4kN
	 /JnJPQi5XBMdWPD576gr0pdZVz9vgHTz48gn2igpcHY46gp5KwfY9VjlEuPYeN7eJZmxl
	 Fkw/7jzGYrQG/lS/s+dzhTEpw/MorxoEEwCthPLJ8xpHJc34jKCuSdabCyxulTpbS5M4k
	 UuMqGK77DbFXqJpF3yqCHloTj2gDw2zApXi4hKCk4RXj1eWQfs5wKMYSG035Mh25slTTR
	 t8BQYZJmShPNrDUfFHlRj4/9826qIEZ7nAcZQAV7QBCrlLF288qDzaWr4MTg/McI3kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJPWXvf9;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEA1606A32D;
	Sat,  7 Nov 2026 02:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FEA1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RJPWXvf9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794017650; x=1825553650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k+Jp0wNiYpjW9kANomoHZViOrgIyHRcD6+ATfOSXlMA=;
  b=RJPWXvf9mu8Xp6GBy8Ec/MDPm6KkREuHBtUV4sXx9TbMHF53Edqg1kE1
   EL2YwziAxKQ59k1HhQ7Iq8RgAfyydWKcyXE66+FRRfSnOlK9/n0HeCnJw
   tY11ghfJbAlAeAScG0FpEVANkbsreBvEb2KDBvjtvmTUwSNs9zhzNJs9m
   SliBVMrWV9QGY6SNfC1nz+CvqLWOvBc8RV67eLhXOyQIJij+29t1QEZY/
   4+6DRhMFR6DI96TgSdKGvDvOz9tQh4u3JNNNAj6Wxau//5cyHNZbxGrDW
   Vcy03Gd8ZMmr4pX0/r3PBovRwcYP5ydK8Mv66OUeQoT0doR5mqr1bUpAx
   g==;
X-CSE-ConnectionGUID: V6mPkg82QMyk06RaMzCbJA==
X-CSE-MsgGUID: JXsWBeTgQL+CFDsiMAvIxQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2936279"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2936279"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2026 18:14:09 -0800
X-CSE-ConnectionGUID: dtk/InDfQyyPzBIT86xgiA==
X-CSE-MsgGUID: Jf4NbIBNQVKBFdjaqR2nNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7468960"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa006.jf.intel.com with ESMTP; 06 Nov 2026 18:14:07 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xPVwS-00000000qEJ-1oEy;
	Sat, 07 Nov 2026 02:14:04 +0000
Date: Sat, 7 Nov 2026 10:13:18 +0800
From: kernel test robot <lkp@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <202611071039.px4NasIH-lkp@intel.com>
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
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20261107/202611071039.px4NasIH-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 812626a41399a1d464a0d69627ab45c83b8ebfb9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261107/202611071039.px4NasIH-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611071039.px4NasIH-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/cdc/fdc1004.c:69:10: warning: overflow in expression; result is 758'541'150 with type 'long' [-Winteger-overflow]
      69 |         +0x7FFF * 488281250L, /* max */
         |         ~~~~~~~~^~~~~~~~~~~~
   drivers/iio/cdc/fdc1004.c:67:10: warning: overflow in expression; result is -1'246'822'400 with type 'long' [-Winteger-overflow]
      67 |         -0x8000 * 488281250L, /* min */
         |         ~~~~~~~~^~~~~~~~~~~~
   2 warnings generated.


vim +69 drivers/iio/cdc/fdc1004.c

    59	
    60	/*
    61	 * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
    62	 * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
    63	 * Negative values are used to cancel out any parasitic capacitance
    64	 * of the sensor's external circuitry.
    65	 */
    66	static const s64 fdc1004_calibbias[] = {
    67		-0x8000 * 488281250L, /* min */
    68		+0x0001 * 488281250L, /* step */
  > 69		+0x7FFF * 488281250L, /* max */
    70	};
    71	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
