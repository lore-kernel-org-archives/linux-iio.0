Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795209504;
	b=jjs0JKs68Dvz1VM2qADB3k8AU7vXqH8FbvQo6RITbskNrs5OfPwhaAyFOUbJLVvtGY1r
	 PET9ox9yYUA7uPEx/4ubQHhTWaBMs6S4wtEoFGJVWvXpNzFn7rIRdoYWh4JpJxef/K27h
	 enx8zI0EjsNRPdKfVsy/EF5x+85O8syHgV3iXH4F7kj1l0JDEDhIIB0tVye7LJ3h/T7Ma
	 scMP3p9umkgxnTHGwqzH8Ecn7Ig5kHSZJprFu3voobzD9deatuTbQh4u9DtgKXAlUF7OU
	 JXSA367FCLQJwNFXvhLxRGmACrp8cNHmuQ28nKIEDrCt8neqtve9/admBmPq7nWrcLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209504;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=wjd64Or23nw/KUsVntyuyIfn77R+aFtaF7PwFr5d/Ws=;
	b=BrRlPukrs+OAJKj70ABYix4Fm2ZH7rZAzq+PLm2zvfwpSUYzUS+DlAyUULAgnvebvZfE
	 IbVvKbTPY02TepfZMF5nf8MZGeoy73W5vM5wAq+O6xRw5hb8fCwtXH+UhRDK7YzzZH3OL
	 vSg09OOlNO6oxbN/t2HL0ZEL/dFpt2A9evYI82NSombVq655Ydv4hS9z99SXAdfOy47M2
	 jGzQtxhJXmBgZBuSSSEQgiWELatKd7gWNPTR9f6fXZSq1YxlmAkXS7i73nQXiKCYqdiTv
	 ncLJotXuQvE9SWnZ2No0i03T/ooyJ5k8FdmdHpWazgJ4jrdklgLWoahbt3bvxRci5qQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiHbLGgf;
	arc=none smtp.remote-ip=192.198.163.13
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258B606A689;
	Fri, 20 Nov 2026 21:18:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F258B606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hiHbLGgf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795209497; x=1826745497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VayXO2obERxLTh/FIisCjx2Bi3BpVJ+zEUoxkoWvpiw=;
  b=hiHbLGgfAwCaRmh097WBjq/Av4qWMW7l8E7mN/mnxu4JnpXwGlAY3IWN
   1UDSXVsRi4t4tJgX0oBAFGOVX15nmkewy7d3iG7zHpNi88R0pVXA9Mylh
   q3ZhsFZUpk4jds0POfnGbNWITBKSiOXtQ/fTZEF5rpa5Cl89RSpc/xVsb
   zNz77CmRcpo0WvoeKgJBVcoirroco7CRhiIKSmaktb9XEe3PMgb2Aq8NQ
   fQ5+AZUuETPA9xJorBe+dzbUkvx21OAZJBcoO9bcAvw3Ba4y1sYtQ10SF
   VAfAMPv8GU6i6bPeffqGUF2XluboQs2E5iO/8aNCLQA0zvzEU+52uaRBZ
   g==;
X-CSE-ConnectionGUID: bUXx0zq6Tb6hhX24DCMeBw==
X-CSE-MsgGUID: N31w90kJR+CFzNJBqYyKTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="4084722"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="4084722"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 13:18:16 -0800
X-CSE-ConnectionGUID: BMjj23xJQqSojMr33lja1A==
X-CSE-MsgGUID: 4yEJNJXHQJ+q7NJzFHpFnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="11364362"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa010.fm.intel.com with ESMTP; 20 Nov 2026 13:18:10 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xUVzi-00000001Iah-0bcq;
	Fri, 20 Nov 2026 21:18:06 +0000
Date: Sat, 21 Nov 2026 05:17:29 +0800
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
Subject: Re: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
Message-ID: <202611210514.27XNsKFF-lkp@intel.com>
References: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
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
In-Reply-To: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>

Hi Olivier,

kernel test robot noticed the following build warnings:

[auto build test WARNING on d922ed738439e1d5b4701df7f4cdd49a09925624]

url:    https://github.com/intel-lab-lkp/linux/commits/Olivier-Moysan/dt-bindings-iio-adc-add-stm32mp2-mdf-filter/20261118-161746
base:   d922ed738439e1d5b4701df7f4cdd49a09925624
patch link:    https://lore.kernel.org/r/20261118-upstream_mdf_v2-v2-2-7939d3c3720a%40foss.st.com
patch subject: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20261121/202611210514.27XNsKFF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261121/202611210514.27XNsKFF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611210514.27XNsKFF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/stm32-mdf-core.c:447:12: warning: 'stm32_mdf_core_runtime_resume' defined but not used [-Wunused-function]
     447 | static int stm32_mdf_core_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:442:12: warning: 'stm32_mdf_core_runtime_suspend' defined but not used [-Wunused-function]
     442 | static int stm32_mdf_core_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:407:12: warning: 'stm32_mdf_core_resume' defined but not used [-Wunused-function]
     407 | static int stm32_mdf_core_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/stm32-mdf-core.c:388:12: warning: 'stm32_mdf_core_suspend' defined but not used [-Wunused-function]
     388 | static int stm32_mdf_core_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~


vim +/stm32_mdf_core_runtime_resume +447 drivers/iio/adc/stm32-mdf-core.c

   387	
 > 388	static int stm32_mdf_core_suspend(struct device *dev)
   389	{
   390		struct stm32_mdf *mdf = dev_get_drvdata(dev);
   391		struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
   392		int ret;
   393	
   394		ret = pm_runtime_force_suspend(dev);
   395		if (ret)
   396			return ret;
   397	
   398		regcache_cache_only(priv->regmap, true);
   399		regcache_mark_dirty(priv->regmap);
   400	
   401		/* Balance regmap_mmio_attach_clk() clk_prepare() */
   402		clk_unprepare(priv->kclk);
   403	
   404		return pinctrl_pm_select_sleep_state(dev);
   405	}
   406	
 > 407	static int stm32_mdf_core_resume(struct device *dev)
   408	{
   409		struct stm32_mdf *mdf = dev_get_drvdata(dev);
   410		struct stm32_mdf_priv *priv = to_stm32_mdf_priv(mdf);
   411		int ret;
   412	
   413		ret = pinctrl_pm_select_default_state(dev);
   414		if (ret) {
   415			dev_err(dev, "Failed to set pins default state: %d\n", ret);
   416			return ret;
   417		}
   418	
   419		ret = clk_prepare(priv->kclk);
   420		if (ret) {
   421			dev_err(dev, "Failed to prepare kernel clock: %d\n", ret);
   422			goto err_clk;
   423		}
   424	
   425		regcache_cache_only(priv->regmap, false);
   426		ret = regcache_sync(priv->regmap);
   427		if (ret) {
   428			dev_err(dev, "Failed to sync cache: %d\n", ret);
   429			goto err_cache;
   430		}
   431	
   432		return pm_runtime_force_resume(dev);
   433	
   434	err_cache:
   435		clk_unprepare(priv->kclk);
   436	err_clk:
   437		pinctrl_pm_select_sleep_state(dev);
   438	
   439		return ret;
   440	}
   441	
 > 442	static int stm32_mdf_core_runtime_suspend(struct device *dev)
   443	{
   444		return 0;
   445	}
   446	
 > 447	static int stm32_mdf_core_runtime_resume(struct device *dev)
   448	{
   449		return 0;
   450	}
   451	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
