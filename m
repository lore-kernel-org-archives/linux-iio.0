Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75363242B1;
	Thu,  5 Feb 2026 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770270173; cv=none; b=OLR9SOChGeM6hcRDYxqNS9Y9egDLHLOcSHAbLiwim4VzaULBUX4gkSL9p1PDw+qPRyPktxid9xRCrj1WqVCqRuqNKqWBUlsWMGfcsKdoz641Av62RJsAfp2wrkvbNumifugpiLVlYrlHJj52h/H7eOdC7PQsXAOAFAwnlt/Qqpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770270173; c=relaxed/simple;
	bh=E0b6d04eQN9Bs7RlGW5plZPXqmdKSUphUWpnAR+jmOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/jfp2gzik/2NJ5e/Gi4gCgwcry8AS4ASnTCInkMLa/y7KQse8MPJvjH2/YnCB6R5v0QqQQcqT9srtP/ciXq4KHUzD5f1YMxH/U5cP1RSKteuzf5npesIpD1u/P7H79+1nsTW6xRYQWYk0BAb8rGd0nHRFEfCig8ayIhqzAWoEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tjwz231z; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tjwz231z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770270172; x=1801806172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E0b6d04eQN9Bs7RlGW5plZPXqmdKSUphUWpnAR+jmOg=;
  b=Tjwz231ze4Ytjm8HlLN+97QSvpgUBRnpKtnwJ5mP3+n7SQ7FjgTKvg1J
   pyXlDDSCzMZhHbU4oCS7Xptn1h7POHbbSiDd2Oum6MFzv2itItDGw2N5F
   U+V83JgSxkfUPkSKFaWkOTvYvFfOPkogUEKY18u7ism8x94BIQHA3/fdp
   wmX7W0KSzSOJCQWqeSqvkLv9DKSzhvAwrs1J0G7wrY6p5GuzC9cFGA+ws
   DBmuuTMt2SdU/hX3wK2rQg6aIDsj3FAC+oTLD3t/hGxni7jDnJmNolf6p
   RoRHSgeLRuTduB/yxsaBcqW/goS0H9lsw1Fgkb9ZUMHVrvyVAXMXpHjxP
   w==;
X-CSE-ConnectionGUID: cqwUFL5rRcWkNn6tfqOKAg==
X-CSE-MsgGUID: YWan7JE3TEOVMpoHe98wQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94113414"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="94113414"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2026 21:42:52 -0800
X-CSE-ConnectionGUID: 3X3TaCTKSTmovQzqn84I8Q==
X-CSE-MsgGUID: +u9Lr1EWROCLdt0ZKDXeZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210478187"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 04 Feb 2026 21:42:51 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vns8d-00000000jRw-33Cb;
	Thu, 05 Feb 2026 05:42:47 +0000
Date: Thu, 5 Feb 2026 13:42:16 +0800
From: kernel test robot <lkp@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Michael.Hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
Message-ID: <202602051328.Qsu5tg2C-lkp@intel.com>
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

kernel test robot noticed the following build warnings:

[auto build test WARNING on d820183f371d9aa8517a1cd21fe6edacf0f94b7f]

url:    https://github.com/intel-lab-lkp/linux/commits/Jonathan-Santos/iio-adc-ad7768-1-fix-one-shot-mode-data-acquisition/20260204-203950
base:   d820183f371d9aa8517a1cd21fe6edacf0f94b7f
patch link:    https://lore.kernel.org/r/9f9aedbe374461e48f1f1e64d5487b5b6c1fc992.1769889074.git.Jonathan.Santos%40analog.com
patch subject: [PATCH 3/3] iio: adc: ad7768-1: add support for SPI offload
config: x86_64-randconfig-001-20260205 (https://download.01.org/0day-ci/archive/20260205/202602051328.Qsu5tg2C-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.4.0-5) 12.4.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260205/202602051328.Qsu5tg2C-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602051328.Qsu5tg2C-lkp@intel.com/

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: module ad7768-1 uses symbol devm_iio_dmaengine_buffer_setup_with_handle from namespace IIO_DMAENGINE_BUFFER, but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
