Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8694E3A1E6C;
	Thu, 26 Mar 2026 05:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774503620; cv=none; b=qpFpUnO5jGJpa7idczTtzJGwCvgodsAjWfjysP4Gqgkc1TjPwiOyP4/5J4R7K5jAEfym/hZXd3T/kDK3lj+02N+H1y8nOK6CsHrrPU7H2Svgio+lTF4Eg5vPS00bJqoGIkJz9DrsUPSG8hPlwUFg8Jk2QrRjg3DVpf84d/I6HaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774503620; c=relaxed/simple;
	bh=oW8AKHaKiPRcfFyQaL9/PspJoWCGfB/4eBYkak3V3MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pI0YfsMr8Qw8aw03F8I5JV4HseJmvN6OxebjLUDup86kLkdQsaI/cBMs0czbQ/9oaUJyyoEyqc+WY9zY5ZKl1I92AZqOU8EZxeDrprg/rw9xZHxV6oSnnOVZ0X1wGmaefY/7tdxAbszl3rpaOoooJajCN6LEdOcTO2xlboRARDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OG5TCqfU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OG5TCqfU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774503618; x=1806039618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oW8AKHaKiPRcfFyQaL9/PspJoWCGfB/4eBYkak3V3MM=;
  b=OG5TCqfU7uK5dgKpKuSLUEpKWoUBpdhQUNFZt1o9AlzcGPzKx/GFvo17
   DYy99DuzPNvZJgr9jqHhaTRzJl+V142TO7Qm78rVvahigtaw2PeiAYfGM
   XapG6j4WFkZNx7ZpHD676e1ZHA+Cgdm15qnkFw1JpSn9un/Zv44Rftx1C
   H+82JWawCy8dFhGOavUmtSm+AUDbzYYaLh5bX033LgFOeT1r0lQJ2TdXb
   C/epRmWTt6qe4yNNP3t2nvyiJ/3Y/wWOcewC77upC5TM20el5XBqbzZPq
   Fj/VT1v80L90xtk9ixNdm5S9TOdAxHPUIjWU6vutd9Qoi5E2tajPQguyh
   g==;
X-CSE-ConnectionGUID: TfrBtHHcRqGZnCKYiLKX4g==
X-CSE-MsgGUID: 0QeqdN06RfqoW8flLowP0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75515684"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75515684"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 22:40:18 -0700
X-CSE-ConnectionGUID: +dW/4zaXRVG098+Ti0BcDw==
X-CSE-MsgGUID: 6hzwvHHSS6qUEOtenFr0qA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="224835758"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 25 Mar 2026 22:40:13 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5dRy-000000008I5-3jeB;
	Thu, 26 Mar 2026 05:40:10 +0000
Date: Thu, 26 Mar 2026 13:39:16 +0800
From: kernel test robot <lkp@intel.com>
To: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <monstr@monstr.eu>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	saikrishna12468@gmail.com, git@amd.com,
	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: Re: [PATCH v2 1/4] iio: adc: xilinx-xadc: Split driver into core and
 platform files
Message-ID: <202603261323.1EonYM3W-lkp@intel.com>
References: <20260323074505.3853353-2-sai.krishna.potthuri@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260323074505.3853353-2-sai.krishna.potthuri@amd.com>

Hi Sai,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v7.0-rc5 next-20260325]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sai-Krishna-Potthuri/iio-adc-xilinx-xadc-Split-driver-into-core-and-platform-files/20260326-024045
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260323074505.3853353-2-sai.krishna.potthuri%40amd.com
patch subject: [PATCH v2 1/4] iio: adc: xilinx-xadc: Split driver into core and platform files
config: i386-buildonly-randconfig-002-20260326 (https://download.01.org/0day-ci/archive/20260326/202603261323.1EonYM3W-lkp@intel.com/config)
compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603261323.1EonYM3W-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603261323.1EonYM3W-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "xadc_handle_events" [drivers/iio/adc/xilinx-xadc-platform.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
