Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BEE3A7849;
	Thu, 26 Feb 2026 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772145010; cv=none; b=X+XZ35IvyvSu1VamEzQCp59ZNY+RuqHG1b94c4vD4uw5S59MLKkS20EvupTKKWkZjN/C/Tae3KISHteAhPMGuDtUbujDX6sSAh7i6QpWClvKADxoHLPWtLZROrnBMV960G4nKlcXqnCBP0CHiEl8ixhbHK3iX/awJt1KaKDRSEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772145010; c=relaxed/simple;
	bh=5NoVu2ddQdpfTQQFpzAgks/PPSwBXcNrZeg+fGubMLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I05zT70kKNKMFobPyB5SkocYJdTCQMH8ludY4waNUi+SViSDxqkdud11bMXG93pKFHJYn93ykejn/gfG+ZC648LmgaR91NEOzKfihOdIR37X+KS9usbiTymzVX5/z82anrAr/upox7xyGrpTIjKCEu9DyMuFzDW2JBm0gvTestk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CG8UG2lA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CG8UG2lA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772145008; x=1803681008;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5NoVu2ddQdpfTQQFpzAgks/PPSwBXcNrZeg+fGubMLs=;
  b=CG8UG2lAvDBu2e1SMr3yBMp000DVz0Z6qoxrP3CJjlp0XLgzK1J2uay9
   WaS0ChfBumaqFn2pXL9NvgA7ZXb5caBHRJj7Ca1YAXv3w96GsIHlG/oOP
   e1nH+cpIkmOgPRWQL66KOWqxPi56Bm0ZUY8JDyWN9HrsBCegyswOY2ClM
   cKwnVrHsT8YMeHdXEEJA96zlV8DR/XLJts24ZVbLM04omQgjgLNBCne52
   W3+E3ARJMeF2gvaFNGdok5jlguGLNdCXROo8fjcymc+H2Zt1Qh1LCW5hQ
   9/uzACUxSQBeCLj4SW+wGyBNlf8wWFTzMMtThmtF7DJpYRr1EpT9PDCan
   A==;
X-CSE-ConnectionGUID: uBmFLKN1SAO28uhbZeg3cA==
X-CSE-MsgGUID: 79e7lJ3vTsmQLOceouRr1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="84683374"
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="84683374"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2026 14:30:05 -0800
X-CSE-ConnectionGUID: JbQP4YDhRZeHtBsrTHzH1A==
X-CSE-MsgGUID: HkTLpZ+FT1unUkjWJRdVXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,313,1763452800"; 
   d="scan'208";a="216830194"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa007.jf.intel.com with ESMTP; 26 Feb 2026 14:29:59 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vvjro-000000009wl-0d2w;
	Thu, 26 Feb 2026 22:29:56 +0000
Date: Fri, 27 Feb 2026 06:29:54 +0800
From: kernel test robot <lkp@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
	linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: add ADI MAX30210 driver
Message-ID: <202602270610.Batqc2is-lkp@intel.com>
References: <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226163041.169786-3-johnerasmusmari.geronimo@analog.com>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.0-rc1 next-20260226]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Erasmus-Mari-Geronimo/dt-bindings-iio-temperature-add-ADI-MAX30210/20260227-013306
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260226163041.169786-3-johnerasmusmari.geronimo%40analog.com
patch subject: [PATCH 2/2] iio: temperature: add ADI MAX30210 driver
config: sparc64-allmodconfig (https://download.01.org/0day-ci/archive/20260227/202602270610.Batqc2is-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260227/202602270610.Batqc2is-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602270610.Batqc2is-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/iio/temperature/max30210.c:412:9: error: call to undeclared function 'iio_device_claim_direct_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     412 |                 ret = iio_device_claim_direct_mode(indio_dev);
         |                       ^
   drivers/iio/temperature/max30210.c:412:9: note: did you mean 'iio_device_claim_direct'?
   include/linux/iio/iio.h:687:20: note: 'iio_device_claim_direct' declared here
     687 | static inline bool iio_device_claim_direct(struct iio_dev *indio_dev)
         |                    ^
>> drivers/iio/temperature/max30210.c:426:3: error: call to undeclared function 'iio_device_release_direct_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     426 |                 iio_device_release_direct_mode(indio_dev);
         |                 ^
   drivers/iio/temperature/max30210.c:460:9: error: call to undeclared function 'iio_device_claim_direct_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     460 |                 ret = iio_device_claim_direct_mode(indio_dev);
         |                       ^
   drivers/iio/temperature/max30210.c:478:3: error: call to undeclared function 'iio_device_release_direct_mode'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     478 |                 iio_device_release_direct_mode(indio_dev);
         |                 ^
>> drivers/iio/temperature/max30210.c:604:24: error: incompatible function pointer types initializing 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, bool)' (aka 'int (*)(struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, _Bool)') with an expression of type 'int (struct iio_dev *, const struct iio_chan_spec *, enum iio_event_type, enum iio_event_direction, int)' [-Wincompatible-function-pointer-types]
     604 |         .write_event_config = max30210_write_event_config,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   5 errors generated.


vim +/iio_device_claim_direct_mode +412 drivers/iio/temperature/max30210.c

   381	
   382	static int max30210_read_raw(struct iio_dev *indio_dev,
   383				     struct iio_chan_spec const *chan, int *val,
   384				     int *val2, long mask)
   385	{
   386		struct max30210_state *st = iio_priv(indio_dev);
   387		unsigned int uval;
   388		int ret;
   389	
   390		switch (mask) {
   391		case IIO_CHAN_INFO_SCALE:
   392			*val = 5;
   393	
   394			return IIO_VAL_INT;
   395		case IIO_CHAN_INFO_SAMP_FREQ:
   396			ret = regmap_read(st->regmap, MAX30210_TEMP_CONF_2_REG, &uval);
   397			if (ret)
   398				return ret;
   399	
   400			uval = FIELD_GET(MAX30210_TEMP_PERIOD_MASK, uval);
   401	
   402			*val = 8;
   403	
   404			/**
   405			 * register values 0x9 or above have the same sample
   406			 * rate of 8Hz
   407			 */
   408			*val2 = uval >= 0x9 ? 1 : BIT(0x9 - uval);
   409	
   410			return IIO_VAL_FRACTIONAL;
   411		case IIO_CHAN_INFO_RAW:
 > 412			ret = iio_device_claim_direct_mode(indio_dev);
   413			if (ret)
   414				return ret;
   415	
   416			ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
   417					   MAX30210_CONV_T_MASK);
   418			if (ret)
   419				goto release_dmode;
   420	
   421			fsleep(8000);
   422	
   423			ret = max30210_read_temp(st->regmap, MAX30210_TEMP_DATA_REG, val);
   424	
   425	release_dmode:
 > 426			iio_device_release_direct_mode(indio_dev);
   427			return ret;
   428		default:
   429			return -EINVAL;
   430		}
   431	}
   432	
   433	static int max30210_read_avail(struct iio_dev *indio_dev,
   434				       struct iio_chan_spec const *chan,
   435				       const int **vals, int *type, int *length,
   436				       long mask)
   437	{
   438		switch (mask) {
   439		case IIO_CHAN_INFO_SAMP_FREQ:
   440			*vals = samp_freq_avail;
   441			*type = IIO_VAL_INT_PLUS_MICRO;
   442			*length = ARRAY_SIZE(samp_freq_avail);
   443	
   444			return IIO_AVAIL_LIST;
   445		default:
   446			return -EINVAL;
   447		}
   448	}
   449	
   450	static int max30210_write_raw(struct iio_dev *indio_dev,
   451				      struct iio_chan_spec const *chan, int val,
   452				      int val2, long mask)
   453	{
   454		struct max30210_state *st = iio_priv(indio_dev);
   455		u64 data;
   456		int ret;
   457	
   458		switch (mask) {
   459		case IIO_CHAN_INFO_SAMP_FREQ:
   460			ret = iio_device_claim_direct_mode(indio_dev);
   461			if (ret)
   462				return ret;
   463	
   464			/**
   465			 * micro_value = val * 1000000 + val2
   466			 * reg_value = ((micro_value * 64) / 1000000) - 1
   467			 */
   468			data = (val * MICRO + val2) << 6;
   469			do_div(data, MICRO);
   470	
   471			data = fls_long(data - 1);
   472			data = FIELD_PREP(MAX30210_TEMP_PERIOD_MASK, data);
   473	
   474			ret = regmap_update_bits(st->regmap, MAX30210_TEMP_CONF_2_REG,
   475						 MAX30210_TEMP_PERIOD_MASK,
   476						 (unsigned int)data);
   477	
   478			iio_device_release_direct_mode(indio_dev);
   479			return ret;
   480		default:
   481			return -EINVAL;
   482		}
   483	}
   484	
   485	static int max30210_write_raw_get_fmt(struct iio_dev *indio_dev,
   486					      struct iio_chan_spec const *chan,
   487					      long mask)
   488	{
   489		switch (mask) {
   490		case IIO_CHAN_INFO_SAMP_FREQ:
   491			return IIO_VAL_INT_PLUS_MICRO;
   492		default:
   493			return -EINVAL;
   494		}
   495	}
   496	
   497	static const struct iio_trigger_ops max30210_trigger_ops = {
   498		.validate_device = &iio_trigger_validate_own_device,
   499	};
   500	
   501	static int max30210_set_watermark(struct iio_dev *indio_dev, unsigned int val)
   502	{
   503		struct max30210_state *st = iio_priv(indio_dev);
   504		unsigned int reg;
   505		int ret;
   506	
   507		if (val < 1 || val > MAX30210_FIFO_SIZE)
   508			return -EINVAL;
   509	
   510		reg = MAX30210_FIFO_SIZE - val;
   511	
   512		ret = regmap_write(st->regmap, MAX30210_FIFO_CONF_1_REG, reg);
   513		if (ret)
   514			return ret;
   515	
   516		st->watermark = val;
   517	
   518		return 0;
   519	}
   520	
   521	static ssize_t hwfifo_watermark_show(struct device *dev,
   522					     struct device_attribute *devattr,
   523					     char *buf)
   524	{
   525		struct max30210_state *st = iio_priv(dev_to_iio_dev(dev));
   526	
   527		return sysfs_emit(buf, "%d\n", st->watermark);
   528	}
   529	
   530	IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_min, "1");
   531	IIO_STATIC_CONST_DEVICE_ATTR(hwfifo_watermark_max,
   532				     __stringify(MAX30210_FIFO_SIZE));
   533	static IIO_DEVICE_ATTR_RO(hwfifo_watermark, 0);
   534	
   535	static const struct iio_dev_attr *max30210_fifo_attributes[] = {
   536		&iio_dev_attr_hwfifo_watermark_min,
   537		&iio_dev_attr_hwfifo_watermark_max,
   538		&iio_dev_attr_hwfifo_watermark,
   539		NULL,
   540	};
   541	
   542	static int max30210_buffer_preenable(struct iio_dev *indio_dev)
   543	{
   544		struct max30210_state *st = iio_priv(indio_dev);
   545		int ret;
   546	
   547		ret = regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
   548					 MAX30210_A_FULL_MASK, MAX30210_A_FULL_MASK);
   549		if (ret)
   550			return ret;
   551	
   552		ret = regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
   553					 MAX30210_FLUSH_FIFO_MASK,
   554					 MAX30210_FLUSH_FIFO_MASK);
   555		if (ret)
   556			return ret;
   557	
   558		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG,
   559				   MAX30210_AUTO_MASK | MAX30210_CONV_T_MASK);
   560		if (ret)
   561			return ret;
   562	
   563		return 0;
   564	}
   565	
   566	static int max30210_buffer_postdisable(struct iio_dev *indio_dev)
   567	{
   568		struct max30210_state *st = iio_priv(indio_dev);
   569		int ret;
   570	
   571		ret = regmap_update_bits(st->regmap, MAX30210_INT_EN_REG,
   572					 MAX30210_A_FULL_MASK, 0x0);
   573		if (ret)
   574			return ret;
   575	
   576		ret = regmap_update_bits(st->regmap, MAX30210_FIFO_CONF_2_REG,
   577					 MAX30210_FLUSH_FIFO_MASK,
   578					 MAX30210_FLUSH_FIFO_MASK);
   579		if (ret)
   580			return ret;
   581	
   582		ret = regmap_write(st->regmap, MAX30210_TEMP_CONV_REG, 0x0);
   583		if (ret)
   584			return ret;
   585	
   586		return 0;
   587	}
   588	
   589	static const struct iio_buffer_setup_ops max30210_buffer_ops = {
   590		.preenable = max30210_buffer_preenable,
   591		.postdisable = max30210_buffer_postdisable,
   592	};
   593	
   594	static const struct iio_info max30210_info = {
   595		.read_raw = max30210_read_raw,
   596		.read_avail = max30210_read_avail,
   597		.write_raw = max30210_write_raw,
   598		.write_raw_get_fmt = max30210_write_raw_get_fmt,
   599		.hwfifo_set_watermark = max30210_set_watermark,
   600		.debugfs_reg_access = &max30210_reg_access,
   601		.validate_trigger = &max30210_validate_trigger,
   602		.read_event_value = max30210_read_event,
   603		.write_event_value = max30210_write_event,
 > 604		.write_event_config = max30210_write_event_config,
   605		.read_event_config = max30210_read_event_config,
   606	};
   607	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
