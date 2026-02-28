Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329AB186284;
	Sat, 28 Feb 2026 16:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772295392; cv=none; b=XM72y4sP127YKJ/45lWRtMgYmEM/4wZtmg5yDjl3TkiD7YujrjcElEBr4vJX6LfSBKfJD/EPec6+fE4IPu1SLy1qeppndowhXONoYFGaQIJL6v3R3/pgCFVuKVh/jRXYibA1hV+39RP1XVfQ5FLV0SEu49ftazdU9Gvi9fFrDuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772295392; c=relaxed/simple;
	bh=FTMVrcjVBVArTF9gUzreKVm48y2lSWx3trNzODOS+/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yk2J3j0SIZdgbwwsmEnfY5XBHLI1QIV4B9d1/hcdoQBIHezJs57gLDDReUyANomJWjGNWzls7ZGY7zpEKU4d+uB6RlxmN7ilI754o3PQHitB1pO4YGroqGDXRz1hRbXl1kZpiy8o2qViuTblR8QJCtofloABBJlWlB7InXjZL0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mhza6X3p; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mhza6X3p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772295391; x=1803831391;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FTMVrcjVBVArTF9gUzreKVm48y2lSWx3trNzODOS+/Q=;
  b=mhza6X3p+e2OnCVIxG5Y5/ahkBnVaKDJ1Gfaa58Mq/qkXwQP8hxmoHIH
   2XeNoq+6Ma3OUNb6l3FqU69VzEVGb1ewA66embHiMisijMJq8c6tFWocs
   I9dR4U5s4gScQoouusi9U+dG0ma9LWaaIXUu89gpMwwaYd8lFyOWi7uyZ
   5d2lvR4yjC4+wNIA3PPh8hHQEn8hLdPqk8xqViPaIAASDEqz+xIhR3BvA
   H8EHL8ttUgTdsxnuynKELjD/laLfyymH9bzpGiK6pdX6WL7k7HkH8wEta
   A5W95Sk9QmHXDjNXGfF+CYRD3E8P6H5yanf/uDJWiHHtumRnZChQKjUMr
   w==;
X-CSE-ConnectionGUID: UUwKOgdJSBee7wiPUyjsSA==
X-CSE-MsgGUID: F6lzLFOcSQazQNRDqWF/Mg==
X-IronPort-AV: E=McAfee;i="6800,10657,11715"; a="84064522"
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="84064522"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2026 08:16:30 -0800
X-CSE-ConnectionGUID: Q2razoWDShi+2QE15EYlog==
X-CSE-MsgGUID: gR/OaD3BQ4q9j8d6rlim0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,316,1763452800"; 
   d="scan'208";a="214521553"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa006.fm.intel.com with ESMTP; 28 Feb 2026 08:16:26 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vwMyl-00000000BgN-3jwt;
	Sat, 28 Feb 2026 16:15:54 +0000
Date: Sun, 1 Mar 2026 00:14:15 +0800
From: kernel test robot <lkp@intel.com>
To: Nick Xie <nick@khadas.com>, neil.armstrong@linaro.org,
	khilman@baylibre.com, martin.blumenstingl@googlemail.com,
	jbrunet@baylibre.com, krzk+dt@kernel.org, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, xieqinick@gmail.com,
	Nick Xie <nick@khadas.com>
Subject: Re: [PATCH v1 4/4] arm64: dts: amlogic:
 meson-s4-s905y4-khadas-vim1s: add Function key support
Message-ID: <202603010009.VfPuPoeI-lkp@intel.com>
References: <20260228065840.702651-5-nick@khadas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228065840.702651-5-nick@khadas.com>

Hi Nick,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on robh/for-next linus/master v7.0-rc1 next-20260227]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nick-Xie/dt-bindings-iio-adc-amlogic-meson-saradc-add-S4-compatible/20260228-150346
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260228065840.702651-5-nick%40khadas.com
patch subject: [PATCH v1 4/4] arm64: dts: amlogic: meson-s4-s905y4-khadas-vim1s: add Function key support
config: arm64-randconfig-001-20260228 (https://download.01.org/0day-ci/archive/20260301/202603010009.VfPuPoeI-lkp@intel.com/config)
compiler: clang version 23.0.0git (https://github.com/llvm/llvm-project 9a109fbb6e184ec9bcce10615949f598f4c974a9)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260301/202603010009.VfPuPoeI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603010009.VfPuPoeI-lkp@intel.com/

All errors (new ones prefixed by >>):

   Lexical error: arch/arm64/boot/dts/amlogic/meson-s4-s905y4-khadas-vim1s.dts:50.18-24 Unexpected 'KEY_FN'
>> FATAL ERROR: Syntax error parsing input tree

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
