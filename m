Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94CAC7404E;
	Mon, 23 Mar 2026 07:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774252794; cv=none; b=pq9y+DTcAYm9AaIK1lIfLFQTVMULTmd/aV8Rq5c7laSpPHkPG/uyZoTXd5KEc1R1tRlQotSDoyChdfvjAbr7O3UFmn9YpsNDr2Pz0pJ7RvGDPHlH7Vo8zV8qPYI+8/TsCqsEW2MzCSfAVwv3mRpvF0uXW+ca7iwPTEj+hG+6lnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774252794; c=relaxed/simple;
	bh=vfhi3Ps1xybQUpsOUq/HS63EJdP2HKdHdNqKWN2eqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecf4h0Bo/etLXDqBavkVIiF+Q+vqOBa8si3newdxSbhPFWvsP/kJ1QLG1hxv4vNMNXaND++LJKpmxZB/ZoJek2GVKBJkyaX0DYWUM+fANe1x/aYLQu0CXiSC/mJvLhU4zm/dfjNNWFgTlJz+TsaI83j5mzRfwyhI/ET8VB4E3qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUmBMpBn; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUmBMpBn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774252793; x=1805788793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vfhi3Ps1xybQUpsOUq/HS63EJdP2HKdHdNqKWN2eqRY=;
  b=kUmBMpBn5FH5sgRD/CS30si6FIlW9lMYwbFn6+5k1oQFg9xP5+sNjc5a
   1Bi56EqofsEBfXIO/VAQF0VDi259wEaFOj5GUAnYfDs/zbmgtVwu+U/5o
   06DIpK6ULcafCR5pkxtk59eDUTxCRX9qkIQ//YMQyYcX/qb75xpvYgNLh
   LT3ABKtaHyYknrQ70ZgbHsBZNBqqQz/xgTH6joTxa+lrKAAx9+1UcNQx9
   CiPfwXQ51NPbvLyP+lYVraEsgvhcsp3+pMXzQl9tO+/sKnbBUAsx3enJz
   jEVS2hggLQx0XHSZlh3Gfyrps6VvnbKie7uwAZLy5yRACCWrAKRKAvIld
   A==;
X-CSE-ConnectionGUID: V8JroaQuTS6enmHUIrPMPg==
X-CSE-MsgGUID: psxym6a1S5CfvuiGhPZlAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="75271003"
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="75271003"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 00:59:52 -0700
X-CSE-ConnectionGUID: aZB7OY2PSqmJgeSeENoYoA==
X-CSE-MsgGUID: I02FwbN8RcSBxMVoOTIq2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,136,1770624000"; 
   d="scan'208";a="225684844"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa004.fm.intel.com with ESMTP; 23 Mar 2026 00:59:48 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w4aCQ-000000000BZ-0Fgi;
	Mon, 23 Mar 2026 07:59:46 +0000
Date: Mon, 23 Mar 2026 15:59:23 +0800
From: kernel test robot <lkp@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <202603231533.tcfdLyO9-lkp@intel.com>
References: <20260321100154.1258-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321100154.1258-5-antoniu.miclaus@analog.com>

Hi Antoniu,

kernel test robot noticed the following build warnings:

[auto build test WARNING on v7.0-rc4]
[also build test WARNING on linus/master]
[cannot apply to jic23-iio/togreg next-20260320]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Antoniu-Miclaus/iio-backend-use-__free-fwnode_handle-for-automatic-cleanup/20260322-200018
base:   v7.0-rc4
patch link:    https://lore.kernel.org/r/20260321100154.1258-5-antoniu.miclaus%40analog.com
patch subject: [PATCH v7 4/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260323/202603231533.tcfdLyO9-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260323/202603231533.tcfdLyO9-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603231533.tcfdLyO9-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/adc/ad4080.c: In function 'ad4080_probe':
   drivers/iio/adc/ad4080.c:738:31: error: implicit declaration of function 'devm_spi_new_ancillary_device'; did you mean 'spi_new_ancillary_device'? [-Werror=implicit-function-declaration]
     738 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi, spi_get_chipselect(spi, ch));
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                               spi_new_ancillary_device
>> drivers/iio/adc/ad4080.c:738:29: warning: assignment to 'struct spi_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     738 |                 st->spi[ch] = devm_spi_new_ancillary_device(spi, spi_get_chipselect(spi, ch));
         |                             ^
   cc1: some warnings being treated as errors


vim +738 drivers/iio/adc/ad4080.c

   704	
   705	static int ad4080_probe(struct spi_device *spi)
   706	{
   707		struct iio_dev *indio_dev;
   708		struct device *dev = &spi->dev;
   709		struct ad4080_state *st;
   710		struct clk *clk;
   711		int ret;
   712	
   713		indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
   714		if (!indio_dev)
   715			return -ENOMEM;
   716	
   717		st = iio_priv(indio_dev);
   718	
   719		ret = devm_regulator_bulk_get_enable(dev,
   720						     ARRAY_SIZE(ad4080_power_supplies),
   721						     ad4080_power_supplies);
   722		if (ret)
   723			return dev_err_probe(dev, ret,
   724					     "failed to get and enable supplies\n");
   725	
   726		/* Setup primary SPI device (channel 0) */
   727		st->spi[0] = spi;
   728		st->regmap[0] = devm_regmap_init_spi(spi, &ad4080_regmap_config);
   729		if (IS_ERR(st->regmap[0]))
   730			return PTR_ERR(st->regmap[0]);
   731	
   732		st->info = spi_get_device_match_data(spi);
   733		if (!st->info)
   734			return -ENODEV;
   735	
   736		/* Setup ancillary SPI devices for additional channels */
   737		for (unsigned int ch = 1; ch < st->info->num_channels; ch++) {
 > 738			st->spi[ch] = devm_spi_new_ancillary_device(spi, spi_get_chipselect(spi, ch));
   739			if (IS_ERR(st->spi[ch]))
   740				return dev_err_probe(dev, PTR_ERR(st->spi[ch]),
   741						     "failed to register ancillary device\n");
   742	
   743			st->regmap[ch] = devm_regmap_init_spi(st->spi[ch], &ad4080_regmap_config);
   744			if (IS_ERR(st->regmap[ch]))
   745				return PTR_ERR(st->regmap[ch]);
   746		}
   747	
   748		ret = devm_mutex_init(dev, &st->lock);
   749		if (ret)
   750			return ret;
   751	
   752		indio_dev->name = st->info->name;
   753		indio_dev->channels = st->info->channels;
   754		indio_dev->num_channels = st->info->num_channels;
   755		indio_dev->info = st->info->num_channels > 1 ?
   756				  &ad4880_iio_info : &ad4080_iio_info;
   757	
   758		ret = ad4080_properties_parse(st, dev);
   759		if (ret)
   760			return ret;
   761	
   762		clk = devm_clk_get_enabled(&spi->dev, "cnv");
   763		if (IS_ERR(clk))
   764			return PTR_ERR(clk);
   765	
   766		st->clk_rate = clk_get_rate(clk);
   767	
   768		/* Get backends for all channels */
   769		for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {
   770			st->back[ch] = devm_iio_backend_get_by_index(dev, ch);
   771			if (IS_ERR(st->back[ch]))
   772				return PTR_ERR(st->back[ch]);
   773	
   774			ret = devm_iio_backend_enable(dev, st->back[ch]);
   775			if (ret)
   776				return ret;
   777		}
   778	
   779		/*
   780		 * Request buffer from the first backend only. For multi-channel
   781		 * devices (e.g., AD4880), all backends share a single IIO buffer
   782		 * as data from all ADC channels is interleaved into one stream.
   783		 */
   784		ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
   785		if (ret)
   786			return ret;
   787	
   788		ret = ad4080_setup(indio_dev);
   789		if (ret)
   790			return ret;
   791	
   792		return devm_iio_device_register(&spi->dev, indio_dev);
   793	}
   794	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
