Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A113B278156;
	Tue, 10 Feb 2026 03:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770694103; cv=none; b=aWvzT0HSH88jwaVgsS9DyP3f++xse0mxuBTvv2k55h+vae4Ol+zWWokiCRngUMXQ6UH08Mwq3dbomyIm/7uIXmDAh7wF3+U3OOUN3ojC5jJXuyT7WhCo2pIjtAXZFPR7dVH4MgnmgwmLyL/1kNlz/IG0jSSSNdrcKiIMnJYC1QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770694103; c=relaxed/simple;
	bh=mquBsZD8rCNGgxPFuHH5PojnzCDvHIkOFFRMWAQGkAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTnioc6o6PBD1U5zEjjL5LVM4hO/CG5eaYdP+rHmNK336BHFdzv0fJ6iF0pb/DNbtdSmlRKpTAgEYuHZjuSqvzkipxolHpgIMP9198RvHae09bxNGmRTAEKafG2FceR70crav9B+PG+PlEeFVaB1N+v5S4SEEiUgIHQnLEbUQ4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eXeufYPG; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eXeufYPG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770694102; x=1802230102;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mquBsZD8rCNGgxPFuHH5PojnzCDvHIkOFFRMWAQGkAs=;
  b=eXeufYPGyxqwaIRpLKdonrjp1/E2dcU7k3FAsu88OLeEKr96rBhLM8DU
   kCSjQavq7Rwk/0jyCWf1u6GnyUAJvzmRlLhkdN0PNUdplMcOlNauRjARz
   y8SZsTdcnJOKogxmLlQEYh52/YnYjiwYY3FwyNNCexdJs7TTkdyzDBZPv
   3kqHvv4/hyDZrwWin6g2RxsECDd0g/vvqi0oTzirHEkQf42ntTKfxC8cA
   TuRx/fqD3wLYjbNYHbh5aDu6sc4ghSg3YeA4qGYTVhUaKGM00FkYTCjK7
   vyT0KUyBabU67y2SPDcxL0TUyP9u+mWrZJ542mqCzpGHzfIUm3uYeII4q
   Q==;
X-CSE-ConnectionGUID: wjHRq1nKRVSvYw36ntO/2w==
X-CSE-MsgGUID: e+K8b4RZT1eX02ajsMkykA==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="70828377"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="70828377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 19:28:21 -0800
X-CSE-ConnectionGUID: hqEMkMWSRuq3GXKgeNTe+w==
X-CSE-MsgGUID: 9LQAcO8lSIqg/G4tGiSpqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; 
   d="scan'208";a="210891204"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 09 Feb 2026 19:28:17 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vpeQB-00000000oa0-0V7E;
	Tue, 10 Feb 2026 03:28:15 +0000
Date: Tue, 10 Feb 2026 11:27:23 +0800
From: kernel test robot <lkp@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
	Erikas Bitovtas <xerikasxx@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: Add support for Capella cm36686 and
 cm36672p sensors
Message-ID: <202602101105.uyNRag1Y-lkp@intel.com>
References: <20260209-cm36686-v2-2-a48126d2b124@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260209-cm36686-v2-2-a48126d2b124@gmail.com>

Hi Erikas,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 9845cf73f7db6094c0d8419d6adb848028f4a921]

url:    https://github.com/intel-lab-lkp/linux/commits/Erikas-Bitovtas/dt-bindings-Add-binding-document-for-cm36686/20260209-222640
base:   9845cf73f7db6094c0d8419d6adb848028f4a921
patch link:    https://lore.kernel.org/r/20260209-cm36686-v2-2-a48126d2b124%40gmail.com
patch subject: [PATCH v2 2/2] iio: light: Add support for Capella cm36686 and cm36672p sensors
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20260210/202602101105.uyNRag1Y-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260210/202602101105.uyNRag1Y-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602101105.uyNRag1Y-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: drivers/iio/light/cm36686.c:2 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * Copyright (C) 2026 Erikas Bitovtas <xerikasxx@gmail.com>
   Warning: drivers/iio/light/cm36686.c:299 This comment starts with '/**', but isn't a kernel-doc comment. Refer to Documentation/doc-guide/kernel-doc.rst
    * This is taken from Xiaomi's driver for cm36686. The device tree for cm36686

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
