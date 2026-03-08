Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91135893;
	Sun,  8 Mar 2026 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772929234; cv=none; b=gEHyV2hFTyQwrUTZkePLcKNrWyWrxqw6Zz+70NN/VDGqG7nxxLGlVKNYu7n6KYxVgDpQAC/f/l/ZtvxuNn1is4jdFEaEspclROafbrdy4fZaenNJbg0FzHfSOXWEYWbMuAD0YEdIG4KrvhhzPQaW9l7CO7ZTi5E3eZWkvgKaluM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772929234; c=relaxed/simple;
	bh=S+TdmegN6LPmRbLcYD+guAiSDuYAfP/isRPuL+f2XLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOttaU1ff1c7FAvvQMTjIZkzSFjQK0aAygZL1lB1I+bpAXuYYDS4RrGwDlUcC+4xa7VUQrkHzJbwjlG10v+hoWB5DvI9FAs3fgM5dFJ8Ih5IM+GUtq55wrgcPtbOjPrWXmdLkSzuZejaR7AtZLZS+Z/pCbXP6X96CPv2mzRmqVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a95WAGyK; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a95WAGyK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772929234; x=1804465234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S+TdmegN6LPmRbLcYD+guAiSDuYAfP/isRPuL+f2XLI=;
  b=a95WAGyKtKE0PyrCDqJgolaPrA4NFMK819iqrAO4Fmc22pE5zvGjZHFU
   1BUamQoVyonCTSD732PbAUtRYYmWcCsfeRY/XSFUOOya/bWY7Ym5l9OxH
   HFbN9Y8l6DakWDP1pLPLhQ7+RPIbPAAh3U2xGnhe71I9m2jc9NqPZ9uGw
   Wo+ZCJ5HpfqfXP33HHRCRxeQxGSlyoEppRxyvuRipuBRWNoIHKgvYk5lj
   hDskKxlGy7kkSMf0Vx2S85vlFuWPpHaX6nR+MtZa8WPGBOB3Wut7c2yMv
   yPWf+CGTChh1KSgsGJCsQ/DRPaTg2q4sE4ScZsRe77UMNfrZic3Y4PIkN
   Q==;
X-CSE-ConnectionGUID: DMc13xC+SqukopB0Kb2Efw==
X-CSE-MsgGUID: BD7o3ba1SgSWk+ooGC02Cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="74189176"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="74189176"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 16:20:33 -0800
X-CSE-ConnectionGUID: rUSUHO+4QTm7GK+RgPqDEA==
X-CSE-MsgGUID: o6vPGFn9TwqDQJmm+fRLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="245489683"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 07 Mar 2026 16:20:29 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vz1sg-000000002kr-0d2A;
	Sun, 08 Mar 2026 00:20:26 +0000
Date: Sun, 8 Mar 2026 08:19:30 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <202603080827.qjeW4PYt-lkp@intel.com>
References: <20260305113756.47243-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305113756.47243-5-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build errors:

[auto build test ERROR on v7.0-rc2]
[also build test ERROR on linus/master]
[cannot apply to jic23-iio/togreg next-20260306]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-use-__free-fwnode_handle-for-automatic-cleanup/20260305-194647
base:   v7.0-rc2
patch link:    https://lore.kernel.org/r/20260305113756.47243-5-antoniu.miclaus%40analog.com
patch subject: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
config: riscv-allyesconfig (https://download.01.org/0day-ci/archive/20260308/202603080827.qjeW4PYt-lkp@intel.com/config)
compiler: clang version 16.0.6 (https://github.com/llvm/llvm-project 7cbf1a2591520c2491aa35339f227775f4d3adf6)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080827.qjeW4PYt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080827.qjeW4PYt-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/adc/ad4080.c:739:17: error: call to undeclared function 'devm_spi_new_ancillary_device'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   st->spi[ch] = devm_spi_new_ancillary_device(spi,
                                 ^
   drivers/iio/adc/ad4080.c:739:17: note: did you mean 'spi_new_ancillary_device'?
   include/linux/spi/spi.h:389:27: note: 'spi_new_ancillary_device' declared here
   extern struct spi_device *spi_new_ancillary_device(struct spi_device *spi, u8 chip_select);
                             ^
>> drivers/iio/adc/ad4080.c:739:15: error: incompatible integer to pointer conversion assigning to 'struct spi_device *' from 'int' [-Wint-conversion]
                   st->spi[ch] = devm_spi_new_ancillary_device(spi,
                               ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 errors generated.


vim +/devm_spi_new_ancillary_device +739 drivers/iio/adc/ad4080.c

   705	
   706	static int ad4080_probe(struct spi_device *spi)
   707	{
   708		struct iio_dev *indio_dev;
   709		struct device *dev = &spi->dev;
   710		struct ad4080_state *st;
   711		struct clk *clk;
   712		int ret;
   713	
   714		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   715		if (!indio_dev)
   716			return -ENOMEM;
   717	
   718		st = iio_priv(indio_dev);
   719	
   720		ret = devm_regulator_bulk_get_enable(dev,
   721						     ARRAY_SIZE(ad4080_power_supplies),
   722						     ad4080_power_supplies);
   723		if (ret)
   724			return dev_err_probe(dev, ret,
   725					     "failed to get and enable supplies\n");
   726	
   727		/* Setup primary SPI device (channel 0) */
   728		st->spi[0] = spi;
   729		st->regmap[0] = devm_regmap_init_spi(spi, &ad4080_regmap_config);
   730		if (IS_ERR(st->regmap[0]))
   731			return PTR_ERR(st->regmap[0]);
   732	
   733		st->info = spi_get_device_match_data(spi);
   734		if (!st->info)
   735			return -ENODEV;
   736	
   737		/* Setup ancillary SPI devices for additional channels */
   738		for (unsigned int ch = 1; ch < st->info->num_channels; ch++) {
 > 739			st->spi[ch] = devm_spi_new_ancillary_device(spi,
   740								    spi_get_chipselect(spi, ch));
   741			if (IS_ERR(st->spi[ch]))
   742				return dev_err_probe(dev, PTR_ERR(st->spi[ch]),
   743						     "failed to register ancillary device\n");
   744	
   745			st->regmap[ch] = devm_regmap_init_spi(st->spi[ch],
   746							      &ad4080_regmap_config);
   747			if (IS_ERR(st->regmap[ch]))
   748				return PTR_ERR(st->regmap[ch]);
   749		}
   750	
   751		ret = devm_mutex_init(dev, &st->lock);
   752		if (ret)
   753			return ret;
   754	
   755		indio_dev->name = st->info->name;
   756		indio_dev->channels = st->info->channels;
   757		indio_dev->num_channels = st->info->num_channels;
   758		indio_dev->info = st->info->num_channels > 1 ?
   759				  &ad4880_iio_info : &ad4080_iio_info;
   760	
   761		ret = ad4080_properties_parse(st);
   762		if (ret)
   763			return ret;
   764	
   765		clk = devm_clk_get_enabled(&spi->dev, "cnv");
   766		if (IS_ERR(clk))
   767			return PTR_ERR(clk);
   768	
   769		st->clk_rate = clk_get_rate(clk);
   770	
   771		/* Get backends for all channels */
   772		for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {
   773			st->back[ch] = devm_iio_backend_get_by_index(dev, ch);
   774			if (IS_ERR(st->back[ch]))
   775				return PTR_ERR(st->back[ch]);
   776	
   777			ret = devm_iio_backend_enable(dev, st->back[ch]);
   778			if (ret)
   779				return ret;
   780		}
   781	
   782		/*
   783		 * Request buffer from the first backend only. For multi-channel
   784		 * devices (e.g., AD4880), all backends share a single IIO buffer
   785		 * as data from all ADC channels is interleaved into one stream.
   786		 */
   787		ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
   788		if (ret)
   789			return ret;
   790	
   791		ret = ad4080_setup(indio_dev);
   792		if (ret)
   793			return ret;
   794	
   795		return devm_iio_device_register(&spi->dev, indio_dev);
   796	}
   797	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
