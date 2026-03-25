Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0627A3F99FD;
	Wed, 25 Mar 2026 19:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774467815; cv=none; b=GN1wVzBznDUaqdHX1ahgNBvEV5Bd887ryIKtHXIc102J5OknUu5vLHz5nShORGCt/FZyv32FVbfAUukED72MV6vL4pJi9t3xVGb25MpYWtaTvMdSD7JitDbApfGV/45Qv+l6ns5/nEGolYcITAdcfAidLVaS2gy3L91nQwqKJj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774467815; c=relaxed/simple;
	bh=h+2et9AATJvAXKRz1JEaiYX/PdeNyQMAxsAsRq8acjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P31likiVhxoYz0Ls61Vu+1H2kVDqSQqTLfJvPziwcXL9bc+lgvnfDIy8RzNcK5L1M217+eNtGISsVi6ZsgBvtvGDe0mi4o6eIdg/2SF6SiZiSbWWUynXXSOizWSViJ95bAeM8fQEpytjHcG/6FeQt+t7GGIgLii8lN6J2ojUr/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mud1EH0r; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mud1EH0r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774467812; x=1806003812;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h+2et9AATJvAXKRz1JEaiYX/PdeNyQMAxsAsRq8acjA=;
  b=mud1EH0ra36Qh4/DNbJbp2wn7y6JlxCMbfY6HKF3OyMCn7QGH/5vKbGi
   t4Nk7DNQLSwHawCqntrg5NdvXZnSqxZuzJnX6H6/ta9/FPcvg/0LBk5fE
   iNWodP4sy6h2KM19DQhLmMgtzIi3nsSM0NDqH9WJ8d4xuFI/QWnz+t0ae
   YqQIs+trDLRLZZ8rGF3XfBXeWBRbJ4uVOnSHR01HB9qesDiHEkUeP/pv/
   QlaCXyxEqLf7L9fm780PF57nyR+rw3GzH40ZqVGNLp5htmvkEHvlTud9y
   h9S2mzJlHIbxzTXVNi5Sn0r3q44QA0IZ7jsOhMmCU1WZS1/4Ck9kBLuPo
   A==;
X-CSE-ConnectionGUID: C3pUPdq2SuGCMDTObjMiAQ==
X-CSE-MsgGUID: oD2M1UdeSlaufBgiKIV0RQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="86894739"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="86894739"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 12:43:31 -0700
X-CSE-ConnectionGUID: w/GBflgjQe6ihgbKLxjR0Q==
X-CSE-MsgGUID: xuQClG6hSwWUkPukvBv7dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="255275032"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 25 Mar 2026 12:43:29 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5U8U-000000007bl-1CTb;
	Wed, 25 Mar 2026 19:43:26 +0000
Date: Thu, 26 Mar 2026 03:42:49 +0800
From: kernel test robot <lkp@intel.com>
To: Gabriel Rondon <grondon@gmail.com>, Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads8688: use read_avail for available
 attributes
Message-ID: <202603260345.PUPcPFND-lkp@intel.com>
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
config: riscv-randconfig-001-20260326 (https://download.01.org/0day-ci/archive/20260326/202603260345.PUPcPFND-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 10.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260345.PUPcPFND-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260345.PUPcPFND-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/ti-ads8688.c:117:2: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709518848' to '-32768' [-Woverflow]
     117 |  -BIT(ADS8688_REALBITS - 1),
         |  ^


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
