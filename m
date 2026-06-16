Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525CF314B72;
	Tue, 16 Jun 2026 06:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781592348; cv=none; b=ipPB4rIKuef1daGshotFEUnixZI2WITJ91BHLYn3klh2KZ3b1Q5ooqERiDVf6ptl3TnqeHwwdkzqXI4avkrsYJWvnoTYYLiKLqokcCMq7gIDcyD7Tpnf+Ax5x+m79l5OA6oWkwSvDvY9F+d8ki4p6vK5EKYqyu7ivJB0dLvRpps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781592348; c=relaxed/simple;
	bh=CCh0ba3licijLznpToBRF/VhtqH9uOpQx+TyumsRKwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3TXi8hDOs7pKfxSjhtnnAfdkCHFTv1NAepZXUBK25kYzPCUULdrWo0flI4xKGKS0N526Wi4EhSeMGEmsCz4EJdEd7TiJNXGHfjny4tI5O3N4mmqxqnB1803tuD0y33V9BmtNyAmoGEmD5ciWKcE9qvXum2PmYY1vooGhd27fjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P/mEJHC/; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P/mEJHC/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781592346; x=1813128346;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CCh0ba3licijLznpToBRF/VhtqH9uOpQx+TyumsRKwE=;
  b=P/mEJHC/Auqk8oKVjYUyXqcV5BkSL1aPAr8VlKBwsxr6GB+QNvWGubtm
   x6OfH0aBbz04c5t+oi9aUrS8Nip2YJwRXYlilfKDdhK4SVDBN3EdFAvsQ
   9/nhmoTdFRF7EFBsyw4EnSXcpIUIzGZWA1lwFb994BS+kHT8szDQb1khW
   59ngJZNeD85oan3puHUNVe3NnHppKZT7DxXtHga8JvdXlQDU+yTx/2p3q
   LpIYt3oV2zBObDYuv/5LlKn16wFAwmNdXnBN4k0hMkuu5jq+3atHBSAJ+
   9HWmttm85WQqm6gmbr6VQAhcbTmt79fsdPUcHp76nKrDpH1ZsliYBC+Ol
   Q==;
X-CSE-ConnectionGUID: dEHuQP9hTNqfoZEw7XiB4Q==
X-CSE-MsgGUID: LaQyGZ0PRD+K1F2lrACEwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="99921273"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="99921273"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2026 23:45:46 -0700
X-CSE-ConnectionGUID: sKOjKscBT8+Lf9shcPTZEQ==
X-CSE-MsgGUID: /B2Yx7BFRzCp2336jJ5O/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="252811134"
Received: from lkp-server01.sh.intel.com (HELO f0d55cb201f0) ([10.239.97.150])
  by fmviesa005.fm.intel.com with ESMTP; 15 Jun 2026 23:45:44 -0700
Received: from kbuild by f0d55cb201f0 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wZNYL-00000000SoU-06am;
	Tue, 16 Jun 2026 06:45:41 +0000
Date: Tue, 16 Jun 2026 14:44:55 +0800
From: kernel test robot <lkp@intel.com>
To: Biren Pandya <birenpandya@gmail.com>, Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Biren Pandya <birenpandya@gmail.com>
Subject: Re: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak and refactor
 trigger state
Message-ID: <202606161405.AQgTPZlw-lkp@intel.com>
References: <20260615214504.38979-1-birenpandya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615214504.38979-1-birenpandya@gmail.com>

Hi Biren,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1 next-20260615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Biren-Pandya/iio-gyro-mpu3050-Fix-runtime-PM-leak-and-refactor-trigger-state/20260616-054636
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260615214504.38979-1-birenpandya%40gmail.com
patch subject: [PATCH v2] iio: gyro: mpu3050: Fix runtime PM leak and refactor trigger state
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260616/202606161405.AQgTPZlw-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260616/202606161405.AQgTPZlw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606161405.AQgTPZlw-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/iio/gyro/mpu3050-core.c:953 expecting prototype for mpu3050_drdy_trigger_set_state(). Prototype was for mpu3050_drdy_trigger_disable() instead

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
