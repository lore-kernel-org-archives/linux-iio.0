Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF78933343C;
	Sat,  7 Mar 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772903510; cv=none; b=ePpnRVi7IrlVUu8vWgJdyMlmkolUsO/8Vz9sbmAh7WOuLpa/V7c2ap0kr/ixOHeJqgHMx47Lk4T7Bx0AtYMT+SbxYMNdFcbMFdEnskJ0IrXg8v3Ye7i0JyHD3LnKvHcTAjmHdTvqmYmf6hH85dZudDF0ql4kymx5RRA9RqhxvcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772903510; c=relaxed/simple;
	bh=1Upl/vSZXikmLvrf8euL0M4KnEULXG3M021PnJOqZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jKUyRM6Za/WW3SXDjihtE4smBJQ2HYYKlTM3gr2qjOPllywmPBGJW8nDPAK5qdGsfsxz+K32v6PizuolW6g+Blwxuz78vX1E2/y210dCwbilxCj7Jo5C+sNY1vWhWLXvdZ7kdHc1xHq7N37MDyvtbeHxiIoxB8ijjrcL5L5Ug10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m4DTktsw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m4DTktsw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772903509; x=1804439509;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1Upl/vSZXikmLvrf8euL0M4KnEULXG3M021PnJOqZK4=;
  b=m4DTktsw745e76VGP6S5vdS9JhZryFMFsetkEBJRDNOXwzFGYF/qtF38
   VUdaI6+NjMXVljlNPge7591x/RqUKHUWhmoXlbcIU4x1eskarnQWiOO2Z
   uF7e5zL0+juhFivvlDdaqYvPjBN7AtQfVTZRrycmSGcYffTVLzlgRI6Jr
   P0ka8KekGrg9e2GiFtA5ThKt3oA4MI81OM0JD5RXmKyobH3IgsmWzssIh
   VjztnjYjtWktbWgA5idaBhWHsg3nPUmyA//XhDM49JrYcCNyeOP0Cn6of
   umjsGVzQQmfskskvlelVvLFvPpP2pit5wpzmvFKadBc3JZUInx9REPobK
   w==;
X-CSE-ConnectionGUID: smUWIupVQoeq6seMptqrnw==
X-CSE-MsgGUID: i1OZg8DxRRSJxN8Iju3hxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11722"; a="85461580"
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="85461580"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2026 09:11:48 -0800
X-CSE-ConnectionGUID: oVZq2jZ0QEyEh51POX8f0A==
X-CSE-MsgGUID: XAAjmCEJRHSLi859DC3Dtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,107,1770624000"; 
   d="scan'208";a="222070478"
Received: from lkp-server01.sh.intel.com (HELO 058beb05654c) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 07 Mar 2026 09:11:44 -0800
Received: from kbuild by 058beb05654c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vyvBm-000000002Mz-17Bz;
	Sat, 07 Mar 2026 17:11:42 +0000
Date: Sun, 8 Mar 2026 01:11:04 +0800
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
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <202603080146.6a7IzS7i-lkp@intel.com>
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
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260308/202603080146.6a7IzS7i-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260308/202603080146.6a7IzS7i-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603080146.6a7IzS7i-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ad4080.c: In function 'ad4080_probe':
>> drivers/iio/adc/ad4080.c:739:31: error: implicit declaration of function 'devm_spi_new_ancillary_device'; did you mean 'spi_new_ancillary_device'? [-Wimplicit-function-declaration]
     739 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               spi_new_ancillary_device
>> drivers/iio/adc/ad4080.c:739:29: error: assignment to 'struct spi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     739 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi,
         |                             ^


vim +739 drivers/iio/adc/ad4080.c

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
