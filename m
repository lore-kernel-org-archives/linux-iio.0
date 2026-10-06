Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849D136EAB0;
	Tue,  6 Oct 2026 06:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791266582; cv=none; b=nrEb3eVzjGTZgUIYR7trbHgG3zE85rvCrqdX5Apmn7b5Tb6hJQMmNVFM0jvxUAjfZAOYs2RQBuR7+QFRjZm5ixoPjgZftO/YDFshX4icM9xcnb0aEq33NlkXgqcFygawBvvsxuNboKOO7MySWvi65sm/f0eNufYihyjff//WiyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791266582; c=relaxed/simple;
	bh=4RrppC/03roNa+H8YcGtw0/eBWvITbBtHds3QUWqoks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5JyHALNBRL7fo+wB1DzCIxCNqG/mitR5JzWyxgldN16ZNE1a1bDJxI5JD54R/MxuVZnhyB5u0kUWhrxAbw2NxtKP38PQz8G6iO6pe0+Syjnw3//bROgjZ2O0OCnEv6HAd8hFz9WNeQpzkzXpXp792ezFd2uYMY0ov+/nRjDO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZVYLceG; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZVYLceG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791266581; x=1822802581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4RrppC/03roNa+H8YcGtw0/eBWvITbBtHds3QUWqoks=;
  b=MZVYLceGXiF0FbddReTV5BDwgsuFmIAVsBgc2u7xAB5AZUkw9EURGGXp
   oTxXCuKZCvZg2HSyaXYpV43eYcTGy2bcnF3eFk4HxnGUdiu0q5GgzTR6U
   LK2JxTIPQCS9vYxkHe7y16O+eFiT6PVTwqQVmTPo3Uuy7+MDzSCBWIK32
   MWaxSjH8QxlBUFMIzrAi1/mXw/wVr77dcgjrzctjxpP20Ip3Ej+0w0A9A
   f1MX+KS5jLezXIqf8u4D0xhDVekJl9eC2/TpgC9EYC8ACHQQf+GTzn9az
   6+AdkgiDtCMHatYryswJAF5GJjDYtqBExL50awGuzrXRc21gltcY25AZF
   w==;
X-CSE-ConnectionGUID: 7Ht8SClzQ42+jRimMUP6Bw==
X-CSE-MsgGUID: oP+m7+PQRGq2Sdk45oYxsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11926"; a="94434227"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="94434227"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2026 23:03:00 -0700
X-CSE-ConnectionGUID: r57R8brgT1q9IQDJith4fA==
X-CSE-MsgGUID: 2M2cMkSNT6C+eXkret5tuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; 
   d="scan'208";a="276180007"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa008.jf.intel.com with ESMTP; 05 Oct 2026 23:02:57 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xDyGM-000000001DE-11Dp;
	Tue, 06 Oct 2026 06:02:54 +0000
Date: Tue, 6 Oct 2026 14:02:35 +0800
From: kernel test robot <lkp@intel.com>
To: Thomas Bonnefille <thomas.bonnefille@bootlin.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Bonnefille <thomas.bonnefille@bootlin.com>
Subject: Re: [PATCH 2/2] iio: temperature: tmp117: add support for HIGH and
 LOW alerts
Message-ID: <202610061423.9wuPD5b6-lkp@intel.com>
References: <20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005-add-tmp117-notif-v1-2-c6cef6fad64c@bootlin.com>

Hi Thomas,

kernel test robot noticed the following build errors:

[auto build test ERROR on 551c722f40809618230001baccf219193e22fc5a]

url:    https://github.com/intel-lab-lkp/linux/commits/Thomas-Bonnefille/dt-bindings-iio-ti-tmp117-describe-interrupts-for-TMP117/20261005-164419
base:   551c722f40809618230001baccf219193e22fc5a
patch link:    https://lore.kernel.org/r/20261005-add-tmp117-notif-v1-2-c6cef6fad64c%40bootlin.com
patch subject: [PATCH 2/2] iio: temperature: tmp117: add support for HIGH and LOW alerts
config: i386-buildonly-randconfig-1004-20261006 (https://download.01.org/0day-ci/archive/20261006/202610061423.9wuPD5b6-lkp@intel.com/config)
compiler: clang version 22.1.3 (https://github.com/llvm/llvm-project e9846648fd6183ee6d8cbdb4502213fcf902a211)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261006/202610061423.9wuPD5b6-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610061423.9wuPD5b6-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/iio/temperature/tmp117.ko: symbol '__udivdi3' undefined!
ERROR: modpost: drivers/iio/temperature/tmp117.ko: symbol '__divdi3' undefined!

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
