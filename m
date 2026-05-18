Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DF382F28;
	Mon, 18 May 2026 17:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779125620; cv=none; b=ZKARDL65gtsvdgyhqmNXvV6TZTpSi9oKk368Oi8Lu4B25dZ/g5UiDZHodh0wWsRYDKQY5jAJZdEOTk9lLozXvTbRI4gs/2rdjCidPGqkqeFp79CmgZhGBNhfhPSKqFjmBdfEQzqgCt//REXGMiOuaJJJiOT9dTGHKrZuGqKQRNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779125620; c=relaxed/simple;
	bh=nwPhWtIYvt7ryci+ZT8rsl3D60a6eQSqiJtKQJJRfME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0osMgDrMG82NdjDFaWQRdAXBidscrtb2VCK4CIV6Rch7tnEUrB5ugYznxUZIF61v9/05Uw1GbLG0JSBuBUJntwKURGWcrs7f/mt+4+EksL9bhe0J2cEkhYgURUqvfw9UyJ3XYwE6U693JRGiK1Km8v5kkta/PRex2WS8jEiIBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XU5uIigR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XU5uIigR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779125618; x=1810661618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nwPhWtIYvt7ryci+ZT8rsl3D60a6eQSqiJtKQJJRfME=;
  b=XU5uIigRcnuAT8NcnEgnuTDc4077+3sagjC0trffoiEgvS2wB5lFxJp+
   xxzdNhQyBQ4a2dK3Miljfot1Y7eAjyz5zlCnce5R6VV+s2Dbr1PvYFMzO
   ZkpKXElaWd3cOwEgCcn260epHXhx8Asu0eqlG1hN9kCZtT5UrC49qoCvn
   FcCRQ3Jv3m9kfN9QFPD1LbElIVgkVyyww+vfEhDJaUmMfjzYS/NsJc6k8
   qCdozbkUh1GiCpOup9y2gsQRn7IJq8sfo4kJfq2NUXZA8V4qbex4bimjN
   mpAuNE07jkkJbRxO3SAp1iHsFpIOkE495ZyzT9vN+nwRUIX5ZdMxyCTFp
   w==;
X-CSE-ConnectionGUID: vKKuZTA9TfO9Fqetwjq0Og==
X-CSE-MsgGUID: AFaHbDzrSgWFxVfwIjyQCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11790"; a="80161633"
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="80161633"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 10:33:37 -0700
X-CSE-ConnectionGUID: iIjs296QS9qacwzqPsI8ag==
X-CSE-MsgGUID: wQF1wL6KQZORbViEQP3bKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,242,1770624000"; 
   d="scan'208";a="239752549"
Received: from lkp-server01.sh.intel.com (HELO d94e5e629b2d) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 18 May 2026 10:33:35 -0700
Received: from kbuild by d94e5e629b2d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wP1qO-000000003CA-07v3;
	Mon, 18 May 2026 17:33:32 +0000
Date: Tue, 19 May 2026 01:32:51 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be
 compound literal
Message-ID: <202605190130.oWitiRzG-lkp@intel.com>
References: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260518071349.469748-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc4 next-20260518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-Convert-IIO_CHAN_SOFT_TIMESTAMP-to-be-compound-literal/20260518-151541
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260518071349.469748-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v0 1/1] iio: Convert IIO_CHAN_SOFT_TIMESTAMP() to be compound literal
config: sparc64-randconfig-r132-20260518 (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 5bac06718f502014fade905512f1d26d578a18f3)
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260519/202605190130.oWitiRzG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605190130.oWitiRzG-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast to non-scalar
>> drivers/iio/adc/max11410.c:807:31: sparse: sparse: cast from non-scalar

vim +807 drivers/iio/adc/max11410.c

a44ef7c4609724e Ibrahim Tilki    2022-10-03  691  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  692  static int max11410_parse_channels(struct max11410_state *st,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  693  				   struct iio_dev *indio_dev)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  694  {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  695  	struct iio_chan_spec chanspec = chanspec_template;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  696  	struct device *dev = &st->spi_dev->dev;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  697  	struct max11410_channel_config *cfg;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  698  	struct iio_chan_spec *channels;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  699  	u32 reference, sig_path;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  700  	const char *node_name;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  701  	u32 inputs[2], scale;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  702  	unsigned int num_ch;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  703  	int chan_idx = 0;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  704  	int ret, i;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  705  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  706  	num_ch = device_get_child_node_count(dev);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  707  	if (num_ch == 0)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  708  		return dev_err_probe(&indio_dev->dev, -ENODEV,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  709  				     "FW has no channels defined\n");
a44ef7c4609724e Ibrahim Tilki    2022-10-03  710  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  711  	/* Reserve space for soft timestamp channel */
a44ef7c4609724e Ibrahim Tilki    2022-10-03  712  	num_ch++;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  713  	channels = devm_kcalloc(dev, num_ch, sizeof(*channels), GFP_KERNEL);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  714  	if (!channels)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  715  		return -ENOMEM;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  716  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  717  	st->channels = devm_kcalloc(dev, num_ch, sizeof(*st->channels),
a44ef7c4609724e Ibrahim Tilki    2022-10-03  718  				    GFP_KERNEL);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  719  	if (!st->channels)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  720  		return -ENOMEM;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  721  
1693d2a7459183d Jonathan Cameron 2024-02-17  722  	device_for_each_child_node_scoped(dev, child) {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  723  		node_name = fwnode_get_name(child);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  724  		if (fwnode_property_present(child, "diff-channels")) {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  725  			ret = fwnode_property_read_u32_array(child,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  726  							     "diff-channels",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  727  							     inputs,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  728  							     ARRAY_SIZE(inputs));
a44ef7c4609724e Ibrahim Tilki    2022-10-03  729  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  730  			chanspec.differential = 1;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  731  		} else {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  732  			ret = fwnode_property_read_u32(child, "reg", &inputs[0]);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  733  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  734  			inputs[1] = 0;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  735  			chanspec.differential = 0;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  736  		}
1693d2a7459183d Jonathan Cameron 2024-02-17  737  		if (ret)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  738  			return ret;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  739  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  740  		if (inputs[0] > MAX11410_CHANNEL_INDEX_MAX ||
1693d2a7459183d Jonathan Cameron 2024-02-17  741  		    inputs[1] > MAX11410_CHANNEL_INDEX_MAX)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  742  			return dev_err_probe(&indio_dev->dev, -EINVAL,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  743  					     "Invalid channel index for %s, should be less than %d\n",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  744  					     node_name,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  745  					     MAX11410_CHANNEL_INDEX_MAX + 1);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  746  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  747  		cfg = &st->channels[chan_idx];
a44ef7c4609724e Ibrahim Tilki    2022-10-03  748  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  749  		reference = MAX11410_REFSEL_AVDD_AGND;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  750  		fwnode_property_read_u32(child, "adi,reference", &reference);
1693d2a7459183d Jonathan Cameron 2024-02-17  751  		if (reference > MAX11410_REFSEL_MAX)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  752  			return dev_err_probe(&indio_dev->dev, -EINVAL,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  753  					     "Invalid adi,reference value for %s, should be less than %d.\n",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  754  					     node_name, MAX11410_REFSEL_MAX + 1);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  755  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  756  		if (!max11410_get_vrefp(st, reference) ||
1693d2a7459183d Jonathan Cameron 2024-02-17  757  		    (!max11410_get_vrefn(st, reference) && reference <= 2))
a44ef7c4609724e Ibrahim Tilki    2022-10-03  758  			return dev_err_probe(&indio_dev->dev, -EINVAL,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  759  					     "Invalid VREF configuration for %s, either specify corresponding VREF regulators or change adi,reference property.\n",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  760  					     node_name);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  761  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  762  		sig_path = MAX11410_PGA_SIG_PATH_BUFFERED;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  763  		fwnode_property_read_u32(child, "adi,input-mode", &sig_path);
1693d2a7459183d Jonathan Cameron 2024-02-17  764  		if (sig_path > MAX11410_SIG_PATH_MAX)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  765  			return dev_err_probe(&indio_dev->dev, -EINVAL,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  766  					     "Invalid adi,input-mode value for %s, should be less than %d.\n",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  767  					     node_name, MAX11410_SIG_PATH_MAX + 1);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  768  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  769  		fwnode_property_read_u32(child, "settling-time-us",
a44ef7c4609724e Ibrahim Tilki    2022-10-03  770  					 &cfg->settling_time_us);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  771  		cfg->bipolar = fwnode_property_read_bool(child, "bipolar");
a44ef7c4609724e Ibrahim Tilki    2022-10-03  772  		cfg->buffered_vrefp = fwnode_property_read_bool(child, "adi,buffered-vrefp");
a44ef7c4609724e Ibrahim Tilki    2022-10-03  773  		cfg->buffered_vrefn = fwnode_property_read_bool(child, "adi,buffered-vrefn");
a44ef7c4609724e Ibrahim Tilki    2022-10-03  774  		cfg->refsel = reference;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  775  		cfg->sig_path = sig_path;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  776  		cfg->gain = 0;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  777  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  778  		/* Enable scale_available property if input mode is PGA */
a44ef7c4609724e Ibrahim Tilki    2022-10-03  779  		if (sig_path == MAX11410_PGA_SIG_PATH_PGA) {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  780  			__set_bit(IIO_CHAN_INFO_SCALE,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  781  				  &chanspec.info_mask_separate_available);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  782  			cfg->scale_avail = devm_kcalloc(dev, MAX11410_SCALE_AVAIL_SIZE * 2,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  783  							sizeof(*cfg->scale_avail),
a44ef7c4609724e Ibrahim Tilki    2022-10-03  784  							GFP_KERNEL);
1693d2a7459183d Jonathan Cameron 2024-02-17  785  			if (!cfg->scale_avail)
a44ef7c4609724e Ibrahim Tilki    2022-10-03  786  				return -ENOMEM;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  787  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  788  			scale = max11410_get_scale(st, *cfg);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  789  			for (i = 0; i < MAX11410_SCALE_AVAIL_SIZE; i++) {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  790  				cfg->scale_avail[2 * i] = scale >> i;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  791  				cfg->scale_avail[2 * i + 1] = chanspec.scan_type.realbits;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  792  			}
a44ef7c4609724e Ibrahim Tilki    2022-10-03  793  		} else {
a44ef7c4609724e Ibrahim Tilki    2022-10-03  794  			__clear_bit(IIO_CHAN_INFO_SCALE,
a44ef7c4609724e Ibrahim Tilki    2022-10-03  795  				    &chanspec.info_mask_separate_available);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  796  		}
a44ef7c4609724e Ibrahim Tilki    2022-10-03  797  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  798  		chanspec.address = chan_idx;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  799  		chanspec.scan_index = chan_idx;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  800  		chanspec.channel = inputs[0];
a44ef7c4609724e Ibrahim Tilki    2022-10-03  801  		chanspec.channel2 = inputs[1];
a44ef7c4609724e Ibrahim Tilki    2022-10-03  802  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  803  		channels[chan_idx] = chanspec;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  804  		chan_idx++;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  805  	}
a44ef7c4609724e Ibrahim Tilki    2022-10-03  806  
a44ef7c4609724e Ibrahim Tilki    2022-10-03 @807  	channels[chan_idx] = (struct iio_chan_spec)IIO_CHAN_SOFT_TIMESTAMP(chan_idx);
a44ef7c4609724e Ibrahim Tilki    2022-10-03  808  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  809  	indio_dev->num_channels = chan_idx + 1;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  810  	indio_dev->channels = channels;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  811  
a44ef7c4609724e Ibrahim Tilki    2022-10-03  812  	return 0;
a44ef7c4609724e Ibrahim Tilki    2022-10-03  813  }
a44ef7c4609724e Ibrahim Tilki    2022-10-03  814  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
