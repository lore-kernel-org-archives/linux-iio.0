Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225910;
	b=C8x1yhGd9v7XmeCYkA/q8+nupa6n4a8Ata/yz7WzstSsQfHr4eBYcbvjseW0Qusa0KWk
	 cA/OoTyE2Yhs6Ui8oEYpvtgSWmU3BYNprII21XoIouxvCbAg8AZemR1M8MURLqCywJ7yZ
	 dT5B4NyUQlcpO3RErQVocHz6ClFNMF/JH+PkhEdgYVIeFyIwJ2Jv8VWwr2i+b1COARyy/
	 xYCvCwpaFOhxht4fgHI6EcsxKm3AlDT6RFCVqqUKM0M/mJM9Eu+OuJaUp/Ug03vbuMn15
	 OTbMc8dF6ORj+obwgo2KvxpuyjJU92+PgrWsqBCwkUt0sKSAEo74quAwQi1tQ9VaYUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225910;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=QzIhuJSftvZpgQFLV10hnC6j7UD3FLUoU0pfIWKv3/w=;
	b=wHQGpToHXHIg0bYtSxY0s+xccfWn8NJdvi2WjwpwjuxPiZ/N5CTbUsoqkJdTfN01BJyU
	 chazXh48g703RIXD0sCM29Od4Tj30M9KHoxTCb9Nu3CMZtPbxka8UTUjYJBzaFrK/D+r6
	 9afULHHFBg3MaWE4enTWNbb14BxjtJgGsHLhfwFYWQuksx7IFh1aXzIUjIFlym5hJLBAP
	 Qh6aZKqUCDmpagTc86OYD0lpkjcpUShQp73jK86fjHkxXhKUrUGetgsU3QhhK9XRQpGYg
	 z1qOoJobAhuym/RgEhAxaphHaLcbRDinI4Y00jVGA8xgj3JazncWSS0WoGrAymWFqbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="COia/9Fa";
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66191606A681;
	Sat, 21 Nov 2026 01:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66191606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=COia/9Fa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795225905; x=1826761905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IwahHoB4S9ZhcNncbWPcEfTPsCZcT9vB1MtXpBP03/g=;
  b=COia/9FayfUhZoHlHdDA7chh9woWIpsKfUytj5ByoamJt+IU9+pJTYIw
   EdzwQC75k58UmKbSre01rx9RpPO4VmLI/yMjComA6x1LwJO0pt97GOKxH
   RvQgA7Jy0P/BssQ1WXIgEoszMVD6Gv6899U78cgTe1Yh2IugbQtHmkCYZ
   bdOuET67gvPyGWMLNaGQogoqrQARoLWJqiKwVNyzW/NEdBejvz4HJ8aCv
   AXNurzIhD3U1OA0C6tuGZioLeF/Ou5tMjMKrN/FK1XTPbH6agv4dbBmUz
   hntBeKh9PueulgYE91p1BevW0DeY1+JbrEFQ5Yx802CXi89Y+3nC0yeFB
   A==;
X-CSE-ConnectionGUID: b1zHbiI9SqeIjhhMNxxG2A==
X-CSE-MsgGUID: WLw1KYsDQuaMsHAyO3S8rg==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4154313"
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="4154313"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:51:44 -0800
X-CSE-ConnectionGUID: AAmMxKbUSX+u0wxTw78PUQ==
X-CSE-MsgGUID: NUWuXceNRh+Tm3I+RLBZpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,224,1787036400"; 
   d="scan'208";a="10914179"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 20 Nov 2026 17:51:38 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUaGM-00000001JC7-0LGj;
	Sat, 21 Nov 2026 01:51:34 +0000
Date: Sat, 21 Nov 2026 09:51:21 +0800
From: kernel test robot <lkp@intel.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Philipp Stanner <phasta@kernel.org>,
	Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, linux-sound@vger.kernel.org,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v2 08/11] iio: adc: stm32-mdf: add dma buffered
 acquisition support
Message-ID: <202611210936.q9qVaCjc-lkp@intel.com>
References: <20261118-upstream_mdf_v2-v2-8-7939d3c3720a@foss.st.com>
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
In-Reply-To: <20261118-upstream_mdf_v2-v2-8-7939d3c3720a@foss.st.com>

Hi Olivier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d922ed738439e1d5b4701df7f4cdd49a09925624]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Moysan/dt-bindings-iio-adc-add-stm32mp2-mdf-filter/20261118-161746
base:   d922ed738439e1d5b4701df7f4cdd49a09925624
patch link:    https://lore.kernel.org/r/20261118-upstream_mdf_v2-v2-8-7939d3c3720a%40foss.st.com
patch subject: [PATCH v2 08/11] iio: adc: stm32-mdf: add dma buffered acquisition support
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20261121/202611210936.q9qVaCjc-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210936.q9qVaCjc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210936.q9qVaCjc-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/stm32-mdf-adc.c:1781:12: warning: 'stm32_mdf_adc_resume' defined but not used [-Wunused-function]
    1781 | static int stm32_mdf_adc_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-adc.c:1766:12: warning: 'stm32_mdf_adc_suspend' defined but not used [-Wunused-function]
    1766 | static int stm32_mdf_adc_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/stm32_mdf_adc_resume +1781 drivers/iio/adc/stm32-mdf-adc.c

  1765	
> 1766	static int stm32_mdf_adc_suspend(struct device *dev)
  1767	{
  1768		struct iio_dev *indio_dev = dev_get_drvdata(dev);
  1769		struct stm32_mdf_adc *adc = iio_priv(indio_dev);
  1770		int ret = 0;
  1771	
  1772		if (iio_buffer_enabled(indio_dev))
  1773			ret = stm32_mdf_adc_predisable(indio_dev);
  1774	
  1775		regcache_cache_only(adc->regmap, true);
  1776		regcache_mark_dirty(adc->regmap);
  1777	
  1778		return ret;
  1779	}
  1780	
> 1781	static int stm32_mdf_adc_resume(struct device *dev)
  1782	{
  1783		struct iio_dev *indio_dev = dev_get_drvdata(dev);
  1784		struct stm32_mdf_adc *adc = iio_priv(indio_dev);
  1785		int ret;
  1786	
  1787		regcache_cache_only(adc->regmap, false);
  1788		ret = regcache_sync(adc->regmap);
  1789	
  1790		if (!ret && iio_buffer_enabled(indio_dev))
  1791			ret = stm32_mdf_adc_postenable(indio_dev);
  1792	
  1793		return ret;
  1794	}
  1795	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
