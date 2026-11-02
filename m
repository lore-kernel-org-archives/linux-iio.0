Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588316;
	b=iEnXjrJ6qtYpJIXmQNz1KNMa5zH/Wt11e3m1hJmycYKYe2xUXCINjJnH22LkZi1cIazl
	 X1nDrl5JAF7fDPfzqKACrs95BAstikCSDPDtEwYB8ByaQxYCDbbxFM8yVB7aJf1rxjjsc
	 5YUhw7Lh3TueWyXMTH0L4nIsjIQEp7qESz8RIzbDoF4Q7jO3MueEBIovLAKOKeEe3XSU4
	 1WrevkAggmxXcgZ6ZJoqcbbUbEnJfKy0yvygQwvD+TlRt5v/hcNH8xtUN2zhTpplGd4xa
	 vMCdqBuH/yGyFMd3sxDLwhM+G/HK1+yEOHyXxbh998lTjM1xDYHvzF5jvUFKYjTm05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588316;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=2z0oS7F5pneXEoOQ3bAfKWU7aXi5FlDjEbNB+9qE6ek=;
	b=ZWZGYYyt4WKY9jhbGFXToy3hKE+TWqfZAoOseMlxEjxWURObeZH01KfpZXneZZd6gYMn
	 tahDGplg2nl3x9K8qqp74wyDpuN0s+a5CzxJv0c+XuXr5Qnkn50/ZitbfEgoEA95RhIGE
	 1VRgJgypLroNf5n25p4Ed6gAu5QkH1MSWfeYojUcDRGOu/oXRGfqqSkW6k3GpyOz4p5r0
	 o+yGjncAFuZghSsZr6vWNluQEBYreLF8qlTfDG2Cocmsr5exAsZbfPoHB9qVEfK1qm9dO
	 8cWipjdaXMLPskXzlU5Qhd8vLfYwUWlOlO1MqATHRNYb7eaAqyW25pt22vlfZqEgeBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EtdvKxzJ;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AC3606A329;
	Mon,  2 Nov 2026 02:58:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9AC3606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EtdvKxzJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793588315; x=1825124315;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YJJe20M6aCN7M8p+TymRl22D3Rh1go93dltt38eLOfI=;
  b=EtdvKxzJq96ebHEQlBT27gl+48gcrPfA1ewithnVx1PXDSwSLCE14SeW
   us17BCLrqLYnE61aqanRDa8sOP/H8KWQ92JR8NZKza95TtKTs0MCCgG6t
   4GeQdwO07N9E/zjDaXP00gpyb0nfAUGael3jEq1FL7GMlIQh3vToA8crG
   OKKCUGBdBdVzU5qMlXKhihiNr0ZPLwDnG1WHdkMH7Sg13q/9bsZbdl1Th
   pnpyHnr/r5d4DMJUF9YABOhpqXm9DDGKVyY/3WNeuYgvj4pdK8C7hAzAI
   L+IlXuSg0p6+DQbpnmSy3wbtzmjXPSLaGBVyQsRtFQDx91P2eZvSAqR8u
   g==;
X-CSE-ConnectionGUID: fhMyQhhcT8mQKJB0ksh3FQ==
X-CSE-MsgGUID: greFNm8jTUKjy0C+aGAkBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2283494"
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="2283494"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2026 18:58:34 -0800
X-CSE-ConnectionGUID: TBvLHBEOQVurgNblHWwW/A==
X-CSE-MsgGUID: nwZL1J13TvOh3hozCa3zGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,190,1787036400"; 
   d="scan'208";a="6322501"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 01 Nov 2026 18:58:32 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xNiFh-00000000gHo-2bs0;
	Mon, 02 Nov 2026 02:58:29 +0000
Date: Mon, 2 Nov 2026 10:57:44 +0800
From: kernel test robot <lkp@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Victor Chernyakin <chernyakin.victor.j@outlook.com>
Subject: Re: [PATCH v4 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <202611021049.CWQj3jvL-lkp@intel.com>
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
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20261102/202611021049.CWQj3jvL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261102/202611021049.CWQj3jvL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611021049.CWQj3jvL-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/iio/cdc/fdc1004.ko: symbol '__udivdi3' undefined!
>> ERROR: modpost: drivers/iio/cdc/fdc1004.ko: symbol '__divdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
