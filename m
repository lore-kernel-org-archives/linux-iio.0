Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A9126FA5A;
	Mon, 26 Jan 2026 06:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408587; cv=none; b=UZzHNVIaNL/OwJzybZD1pE+fdLR79ztbllpGNHZTGqBvJ9yXY+PoZi3nGrIBMo1KfemY9f6uFDsxDxRbBFHqFl83hx+6mnEnvsKCUW4H4K+3fycYgwGb5da2QJeIj1nKKu0VNT7ADHzIqRZQOULb5icjbb/mt8Njx/iqfECNW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408587; c=relaxed/simple;
	bh=YsXx1MoHLIz7jzQAiJhBrQUFvFX/e6YQld0DsR1WATo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fHARhLfaqIiGIscFv4oa4elYRXdHU7MvFgvtp2Oc09P1oPpZChAr42NuRKUlSEkEuKFqdHeJQfUWuy9SZ/kZG2HVEOo57uFFzyKEPGvax/ovfdy5bun3MiqhF0xsr3oAgOdPqS71/a0Q/GK87zz7EabictJZcJUsfOd19g0OXtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baZ6cTh6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baZ6cTh6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769408586; x=1800944586;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YsXx1MoHLIz7jzQAiJhBrQUFvFX/e6YQld0DsR1WATo=;
  b=baZ6cTh6J5Mnpsvbi2NUN0BubheLhm3aN4wdaKJINw3kiHpl/IA6TZAs
   6CXjsU9OFG0dyq2l1qAgdMOf22oprV7zU4yN8jTKRD57IC1OxODJ2qv1t
   sK0v+k7neJ7Sg2Uu3WaynXbWTNk+S75ScqQ22OqGxhI7YHQ6q/S3DTOf7
   07I5b8duYl2wFy3K6Cg16t6aQo6fBdrlKANF2rx80+NxfpP9lC48/JIvR
   ZkfDyh+d7gZswFbmUNqq5D1Xh89xo3v4x7xnyaHHeGE0qdr9pmZTN8vNw
   mfatZdYGKwOi7A7R6Yg8K6V9dK2ciyhKW805dBml/4YRUQuK6hJzbL/1F
   g==;
X-CSE-ConnectionGUID: 6JSAjr15RP2PUt2+qY8SOA==
X-CSE-MsgGUID: DiSBW4DHRra0g2HN2Uxk2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11682"; a="58158201"
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="58158201"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2026 22:23:05 -0800
X-CSE-ConnectionGUID: u4qiLRv2TbGKtlwNgiNogA==
X-CSE-MsgGUID: bfxaqDnrS3a/xUWWplBWVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,254,1763452800"; 
   d="scan'208";a="207406796"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Jan 2026 22:23:02 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vkG02-00000000X02-3aRH;
	Mon, 26 Jan 2026 06:22:58 +0000
Date: Mon, 26 Jan 2026 14:22:21 +0800
From: kernel test robot <lkp@intel.com>
To: Kyle Hsieh <kylehsieh1995@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Beguin <liambeguin@gmail.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle Hsieh <kylehsieh1995@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: adc: ltc2309: add support for ltc2305
Message-ID: <202601261441.M4qQzY72-lkp@intel.com>
References: <20260126-add_ltc2305_driver-v3-2-951349a87f97@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126-add_ltc2305_driver-v3-2-951349a87f97@gmail.com>

Hi Kyle,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9448598b22c50c8a5bb77a9103e2d49f134c9578]

url:    https://github.com/intel-lab-lkp/linux/commits/Kyle-Hsieh/dt-bindings-adc-ltc2497-add-support-for-ltc2305/20260126-093339
base:   9448598b22c50c8a5bb77a9103e2d49f134c9578
patch link:    https://lore.kernel.org/r/20260126-add_ltc2305_driver-v3-2-951349a87f97%40gmail.com
patch subject: [PATCH v3 2/2] iio: adc: ltc2309: add support for ltc2305
config: i386-buildonly-randconfig-006-20260126 (https://download.01.org/0day-ci/archive/20260126/202601261441.M4qQzY72-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260126/202601261441.M4qQzY72-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601261441.M4qQzY72-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ltc2309.c:209:20: warning: variable 'chip_info' is uninitialized when used here [-Wuninitialized]
     209 |         indio_dev->name = chip_info->name;
         |                           ^~~~~~~~~
   drivers/iio/adc/ltc2309.c:195:43: note: initialize the variable 'chip_info' to silence this warning
     195 |         const struct ltc2309_chip_info *chip_info;
         |                                                  ^
         |                                                   = NULL
   1 warning generated.


vim +/chip_info +209 drivers/iio/adc/ltc2309.c

   192	
   193	static int ltc2309_probe(struct i2c_client *client)
   194	{
   195		const struct ltc2309_chip_info *chip_info;
   196		struct iio_dev *indio_dev;
   197		struct ltc2309 *ltc2309;
   198		int ret;
   199	
   200		indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*ltc2309));
   201		if (!indio_dev)
   202			return -ENOMEM;
   203	
   204		ltc2309 = iio_priv(indio_dev);
   205	
   206		ltc2309->dev = &indio_dev->dev;
   207		ltc2309->client = client;
   208	
 > 209		indio_dev->name = chip_info->name;
   210		indio_dev->modes = INDIO_DIRECT_MODE;
   211		indio_dev->channels = chip_info->channels;
   212		indio_dev->num_channels = chip_info->num_channels;
   213		indio_dev->info = &ltc2309_info;
   214	
   215		ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
   216		if (ret < 0 && ret != -ENODEV)
   217			return dev_err_probe(ltc2309->dev, ret,
   218					     "failed to get vref voltage\n");
   219	
   220		ltc2309->vref_mv = ret == -ENODEV ? LTC2309_INTERNAL_REF_MV : ret / 1000;
   221	
   222		mutex_init(&ltc2309->lock);
   223	
   224		return devm_iio_device_register(&client->dev, indio_dev);
   225	}
   226	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
