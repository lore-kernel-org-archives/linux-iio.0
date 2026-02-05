Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27E355043;
	Thu,  5 Feb 2026 06:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770273896; cv=none; b=YgBGU8AVNwJoFCXyp1BpMwAaXgPQAOdvRhpty//s8NiiOMM1TY2q7+SHtVYH6ZUTSfa8mROvD6TNxZjg9LT2k92awPbAqIjjJxwAtdwmikNb8BdonFskbE9tgPeP8gcMY4zlYU64ZiUX9NfMmaebbnZgAg98C80J/0VppZ11IEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770273896; c=relaxed/simple;
	bh=XGiKe0dJ3H2pbegt/Z9JDgLtcCYuEXGwYwRo8rRf2Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZj1vaMLVPD8wzne/oG/CIk5iCK4QhQUzQyktDTy4lsqQHENjovncs/LgOHqfgEu9v6WrDP72qwe6uctsexRTXDFRUhJ+WaeDeTbrg0F2g3s4/YYE8ebFhcKFmI5qw0+xoh47dcj/bEym4EfaBeo7Y1yx/Fsw8q0Ihvt7C3ILSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRU0nFBY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRU0nFBY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770273896; x=1801809896;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XGiKe0dJ3H2pbegt/Z9JDgLtcCYuEXGwYwRo8rRf2Ss=;
  b=lRU0nFBYW7saDlCMozH5BEbCsnsZksZ9Io/2eXiC/1gt8PTDf1yK7wRn
   lTTtDYnovksfrvRYsyyn3nWslIpQevQ5fP/pFoEafdg/rwwS/GlZ97RvD
   2cMn5IvSOpHfP/NJliFXzGM6FskyrPT62kFSdGYaY9sJVZzcvVNvtddij
   X7BEW5GlsN5HJPsYcrDUqPP2G7rt7HHext9t2QSyOQRMevctqVGPBfRhW
   gk5s3kJ84fi2UlfsvfGKff3WLQhuxXK6XCCKOyxlYPu+3r7L+f5tMhaA8
   bvYfigjYTy2tZGKx1J7tcaz+K7mV9jtTGKQhLJg44TPbJG232Zy57/l2a
   g==;
X-CSE-ConnectionGUID: zWQsUhdGSFOhLpHhs4Ep/Q==
X-CSE-MsgGUID: 3Sgm8fL0ReS8EtxrZPm8qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="71563010"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="71563010"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 22:44:55 -0800
X-CSE-ConnectionGUID: /SycwwG9StOfVQqEhnT5Wg==
X-CSE-MsgGUID: S3InMRNfQ6iA08iuhxsDSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="215383903"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 04 Feb 2026 22:44:53 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vnt6g-00000000jVu-1Qux;
	Thu, 05 Feb 2026 06:44:50 +0000
Date: Thu, 5 Feb 2026 14:44:32 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <202602051436.PfHU6nPa-lkp@intel.com>
References: <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos@analog.com>

Hi Jonathan,

kernel test robot noticed the following build errors:

[auto build test ERROR on d820183f371d9aa8517a1cd21fe6edacf0f94b7f]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Santos/iio-adc-ad7768-1-fix-one-shot-mode-data-acquisition/20260204-203950
base:   d820183f371d9aa8517a1cd21fe6edacf0f94b7f
patch link:    https://lore.kernel.org/r/9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos%40analog.com
patch subject: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
config: i386-randconfig-054-20260205 (https://download.01.org/0day-ci/archive/20260205/202602051436.PfHU6nPa-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602051436.PfHU6nPa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051436.PfHU6nPa-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: module ad7768-1 uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
