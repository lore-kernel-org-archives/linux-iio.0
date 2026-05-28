Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F2F31A807;
	Thu, 28 May 2026 06:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779950465; cv=none; b=EB2+XL7nwIDfJhI+oE3w8oSPO7Px5uRrnKyBtqXqTyPL3Zd1k+5owfCx6bIhNNEizm5+hFkWayVCEU3joqfIW9xKB3BGYeVSy1bVyamXDCsN+CqU8xb8mFYBVUfhubPjQzYJprbpwqJiOtnltdUY5g4L7V1D/jysx+UBlEhnd2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779950465; c=relaxed/simple;
	bh=SioP6jDgWCwXbGQVSvOG90A2ONx8D8JxSS4hvLLdlx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k54D01Q6l7a978zyGX9ULCDjZIV6QbHXTcQBzjYG5dOSZ4UxWoc/36yTxwYm5jiw8Q3kpUN2d8IlhvyReKV/6IocDqJ25DA8/bOa2Fbuq5elc+y2Svq64svwlMJsY6OT7tIW6QSHrzKFWUNTnDiiroxQ/dOcEfh/zLU+xXB0w64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YxRZbt4z; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YxRZbt4z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779950463; x=1811486463;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SioP6jDgWCwXbGQVSvOG90A2ONx8D8JxSS4hvLLdlx8=;
  b=YxRZbt4zrpjHYSMq94PCJYaOeufPTmR7FHfPMi6wbqx2p8ZnB09P6p/C
   MNlkksZRsN+jQXwJa8dBMTAvoSS469qDS8rrQnwTGhIamGG3+cHJ8hjO7
   skEffHJejIYEu2O7y/VzvcbHn/Uynuow+1+AY+rUYRnqAAPMSOvzjmAej
   1fxUeWze7fCbuI7ijvcZZBQFQvELJ0olVwbKSTp14zeI9gEvRHrXoj8nX
   0GqY42xmUk/WNruwK+LjtbQnO1b34yjpw57vtJd2KuhijIIYLvKnvaDHy
   kc0d6MEOe1CuqH/vWeDgpggOgyKqodSOxFc8ms/DMFco7/fVIH6FS8QtN
   g==;
X-CSE-ConnectionGUID: xX0LUeaxQ9aT92weX3ILaw==
X-CSE-MsgGUID: 3BfrMRflTiCaFX3saqP/bg==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="92263278"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="92263278"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 23:41:03 -0700
X-CSE-ConnectionGUID: AD0JX70CQtC2uKqoWuRP1w==
X-CSE-MsgGUID: xnwTCWx8SKiOK0BVLFC32w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="239892506"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 27 May 2026 23:40:58 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wSUQJ-000000005dK-33pH;
	Thu, 28 May 2026 06:40:55 +0000
Date: Thu, 28 May 2026 14:40:51 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel
 definition
Message-ID: <202605281432.a64fe4iY-lkp@intel.com>
References: <20260525014654.2399354-1-dlechner@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260525014654.2399354-1-dlechner@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.1-rc5 next-20260527]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-pressure-cros_ec_baro-simplify-timestamp-channel-definition/20260525-134550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260525014654.2399354-1-dlechner%40baylibre.com
patch subject: [PATCH] iio: pressure: cros_ec_baro: simplify timestamp channel definition
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260528/202605281432.a64fe4iY-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260528/202605281432.a64fe4iY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605281432.a64fe4iY-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from include/linux/iio/buffer.h:10,
                    from drivers/iio/pressure/cros_ec_baro.c:9:
   drivers/iio/pressure/cros_ec_baro.c: In function 'cros_ec_baro_probe':
>> include/linux/iio/iio.h:356:38: error: expected expression before '{' token
     356 | #define IIO_CHAN_SOFT_TIMESTAMP(_si) {                                  \
         |                                      ^
   drivers/iio/pressure/cros_ec_baro.c:174:20: note: in expansion of macro 'IIO_CHAN_SOFT_TIMESTAMP'
     174 |         *channel = IIO_CHAN_SOFT_TIMESTAMP(1);
         |                    ^~~~~~~~~~~~~~~~~~~~~~~


vim +356 include/linux/iio/iio.h

00c5f80c2fad53 include/linux/iio/iio.h   Peter Rosin      2016-11-08  355  
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12 @356  #define IIO_CHAN_SOFT_TIMESTAMP(_si) {					\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  357  	.type = IIO_TIMESTAMP,						\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  358  	.channel = -1,							\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  359  	.scan_index = _si,						\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  360  	.scan_type = {							\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  361  		.sign = 's',						\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  362  		.realbits = 64,					\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  363  		.storagebits = 64,					\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  364  		},							\
07d4655b410a4d include/linux/iio/iio.h   Jonathan Cameron 2013-11-12  365  }
1d892719e70e47 drivers/staging/iio/iio.h Jonathan Cameron 2011-05-18  366  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
