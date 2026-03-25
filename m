Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9049F286881;
	Wed, 25 Mar 2026 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774471599; cv=none; b=kNxgdXSuHk/RvoQASzW4Mrzaz9Z0q3uq8PnSJKXDxp030pjILXvWix8Ap0Y4PMdC9IPbMJsb/lwi02oB+WY88PtcwE65Z6/gEoFGSIg1bTjRhP6T6mWaRgasqmYgTMCdpAiXl4wt5jp/6mi0F18n2yMnHZ8k+yMLnXTZYxiVsTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774471599; c=relaxed/simple;
	bh=ESfw6dxTCsicaJGE5YT4ygR3J83yYbYKDVrzpvPTkpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAld3qXi1gqHUruNhjv2xRHshr1dLteDDfndt6Uu7LtUW/n2diuQ8Wb6MRFrQrMGE6AUacyEc2dCjlWIrzBAJoJv6XpaXh950QRgGPMCL+6/0PXIpC7kbcvxdSlXSzTk+9xisxhX5oASiM5gV0dg9DDD7ILAdHhAp80WVq2aP4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBFfveeC; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBFfveeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774471597; x=1806007597;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ESfw6dxTCsicaJGE5YT4ygR3J83yYbYKDVrzpvPTkpg=;
  b=hBFfveeCZJUdezkrICk+tyPbtfUqtftwMp40rebpNUhJcuBsHskVt5cQ
   +MUh/7kjMPr5B6uaC1S/WIS4NVkRBN243o4D5RRZJuj7bcFvdkYgseH2/
   8YOET5Wu2WwDz+jiMgx0ldqvtEwWJ6lfXiJaIGsYDQ8KGa/OpxzXvAeOw
   J7zCkEO3IqtFIw+HbAKnHQ6UoKoGsV4b6i0pdGVRakc8To6Dxh6tsxV/j
   plEHWVZGpQL0j+K+GuV0Qyi8LCEsvgt7B62NHpjPiBjUZ9KlDZqlP1jqN
   o17NX6r9dSKBIBytfpp/1n7O+FSAcuuRLIyWLncnJ/S8lFDnUHKxsESqj
   Q==;
X-CSE-ConnectionGUID: dRsmEFB3RtiSVzcqg//zHQ==
X-CSE-MsgGUID: fXaDyzhfT1yXJHqNOzooTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74701281"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="74701281"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 13:46:37 -0700
X-CSE-ConnectionGUID: YC5nO0R4TVCXj0vXWaiMgA==
X-CSE-MsgGUID: ucf2/eJBR9iCnzxF94wvKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="262716939"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 25 Mar 2026 13:46:35 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5V7X-000000007i1-2bWR;
	Wed, 25 Mar 2026 20:46:31 +0000
Date: Thu, 26 Mar 2026 04:46:21 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <202603260401.2g0RDxuL-lkp@intel.com>
References: <20260325110942.65337-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260325110942.65337-1-grondon@gmail.com>

Hi Gabriel,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.0-rc5 next-20260325]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Gabriel-Rondon/iio-adc-ti-ads8688-use-read_avail-for-available-attributes/20260325-195933
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260325110942.65337-1-grondon%40gmail.com
patch subject: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available attributes
config: s390-allmodconfig (https://download.01.org/0day-ci/archive/20260326/202603260401.2g0RDxuL-lkp@intel.com/config)
compiler: clang version 18.1.8 (https://github.com/llvm/llvm-project 3b5b5c1ec4a3095ab096dd780e84d7ab81f3d7ff)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260401.2g0RDxuL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260401.2g0RDxuL-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads8688.c:117:2: warning: implicit conversion from 'unsigned long' to 'int' changes value from 18446744073709518848 to -32768 [-Wconstant-conversion]
     116 | static const int ads8688_offset_avail[] = {
         |                                           ~
     117 |         -BIT(ADS8688_REALBITS - 1),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +117 drivers/iio/adc/ti-ads8688.c

   115	
   116	static const int ads8688_offset_avail[] = {
 > 117		-BIT(ADS8688_REALBITS - 1),
   118		0
   119	};
   120	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
