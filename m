Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60EAC2FF;
	Thu, 11 Jun 2026 00:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138089; cv=none; b=DXS2JezROVMj54h5pELWTvGYOOYLZrYAxXFT9LUG5yyUdHRojo3sxz10/eXw3sQd9p1PjA2aFTj6D9GX/llboMDa+3aW4SryY1wzcswQeto/r5A5EYsDMwsy9qjneVYa9O3m64y6OtEFlmeqY7rDqxX/0cXTRngjUfej/P5MzxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138089; c=relaxed/simple;
	bh=aI/ROZWRw0NskZne5k3CKLPIBd0Bp8HOR6STgPUTeWk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=igWYG5a+ggmtYIJM7fQaA0P6nleFY1kI152UlBWPPmfBepUgAqIqH6iH5fMAl8h19CpKS/NIMpFDOzQ5RLQiCl8Aoqj46yp2kxPNirbquClJl9bxhF9zwdXzC/woPpfwkcf9JpTZlbaJnmPWXeQQ5f2CgM/A9xMJhBtDzzPcjJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iY1/EHno; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iY1/EHno"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781138088; x=1812674088;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aI/ROZWRw0NskZne5k3CKLPIBd0Bp8HOR6STgPUTeWk=;
  b=iY1/EHnoWad3LG50CJcicpJKFZJ9Fb7bCVOz/fBCppJbmGWVGAz0utRA
   VEWPfHNBn5Dq8BS6FPPB8elGJc0dxewtL58/DZvmeC5mGSB9qA4YFACMb
   Y9pVu62VmdLcs63cQF5pcKrMA0eSWfuOpMxvclJMAo3DkfJzHMt4vwyBD
   2EYgVVd+faeoEJjuXM7ZGpzEOi9ho0f5dEYTKTldmzsj0BKSwZrpUzTtk
   gyQU7p7E+LD4/RwygEH7ak4mpkZJkJlHaBAPLXIcE1odLfqDNd3rWTFPF
   0tNX5U7Q9JLHP+T9JMpOCLpq27KhFq/W2Ws1YbUgCpG8TVPcvNDYX20X8
   g==;
X-CSE-ConnectionGUID: NZj+zYLoTM6vjJXp5tNqog==
X-CSE-MsgGUID: ysnsnaQjS1ulrXGxYj4Jcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="82055048"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="82055048"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 17:34:47 -0700
X-CSE-ConnectionGUID: WiLCKv0jS3O69icKjPZ5cA==
X-CSE-MsgGUID: WomR+WCwQda5b8/OsTl+sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="270001861"
Received: from igk-lkp-server01.igk.intel.com (HELO 892db79562d4) ([10.211.93.152])
  by fmviesa002.fm.intel.com with ESMTP; 10 Jun 2026 17:34:45 -0700
Received: from kbuild by 892db79562d4 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wXTNa-000000003tl-1Zud;
	Thu, 11 Jun 2026 00:34:42 +0000
Date: Thu, 11 Jun 2026 02:33:45 +0200
From: kernel test robot <lkp@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, krzk@kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: Re: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML
 schema
Message-ID: <202606110223.IxhtwJBI-lkp@intel.com>
References: <20260610110051.1228-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610110051.1228-1-shofiqtest@gmail.com>

Hi Md,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc7 next-20260610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Md-Shofiqul-Islam/dt-bindings-iio-accel-Convert-lis302-binding-to-YAML-schema/20260610-191419
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260610110051.1228-1-shofiqtest%40gmail.com
patch subject: [PATCH] dt-bindings: iio: accel: Convert lis302 binding to YAML schema
config: microblaze-randconfig-2052-20260610 (https://download.01.org/0day-ci/archive/20260611/202606110223.IxhtwJBI-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 15.2.0
dtschema: 2026.5.dev10+g5d839523d
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260611/202606110223.IxhtwJBI-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202606110223.IxhtwJBI-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: Duplicate compatible "st,lis302dl-spi" found in schemas matching "$id":
   	http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml
   	http://devicetree.org/schemas/iio/st,st-sensors.yaml#
>> Warning: Duplicate compatible "st,lis3lv02d" found in schemas matching "$id":
   	http://devicetree.org/schemas/iio/accel/st,lis302dl.yaml
   	http://devicetree.org/schemas/iio/st,st-sensors.yaml#

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
