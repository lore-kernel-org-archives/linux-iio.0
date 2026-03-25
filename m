Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C87348469;
	Wed, 25 Mar 2026 21:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774475560; cv=none; b=GnN7jOx/VXgu8Ef4Q/o8dQaBtzB2ANELpn2YHWi4VgeUuFkEydH0ImLLjLda8kpzg31RinpOlkH7Hoe0S2oD5yqPt8GySwIdzOvIMndwiYKM7XyHDO41uumU+vLKIv2aajAKPH7V6sWX1bjbXo0eN/hWyAyMj7Dla3091cCrOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774475560; c=relaxed/simple;
	bh=Q7B85Xvgrvo3bG7ajXwbX4TG7TU43r/vTtJVGXACYEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e993rrCVoMsHFjcZxudbNEtZRRFs4JmdztBt+QsjH76vikUkCyzahz3umXle2HPVE+gd47Znd98XAjQTFC3xGdS6TbBOyiVTt6T2K4XG/RhhGvg3ZV30xIdempFOR9M2Z2c9rrckKvxncmY1kglf0svY/84QHlr5QSnSUyyAkJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GQYUiwFa; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GQYUiwFa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774475558; x=1806011558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q7B85Xvgrvo3bG7ajXwbX4TG7TU43r/vTtJVGXACYEY=;
  b=GQYUiwFarfGj1hUWSttF+hemaI9jgH53MaxfSlaOj4hnA1PvFMEzUrGd
   +s8ufamxyadURGsYcCwDVzaCTf/mMWcbivzAgf+ML6VZ4YGM6H6C3rNT6
   oyRneuDzjmWLdtG4fO8K5vEmFxVG2DX+SBeiKYoiYCt9dNjmIdx1U+lIJ
   0lIeml+SHRDNNnAW7fDe3UeZW9M+jMlfoUvXAOgrW03m0nGbGMbTfzkrY
   dm0kDCysUFJXoeoMjRhGZt7joKJX2AX1uRF6iVmRkStLooyS+Dct+QTgt
   QjqvYx30vRbOxhi+bY3VkMBzh0SomT9BlKQGrhVJEWDfHBmr+k+FHgb43
   Q==;
X-CSE-ConnectionGUID: gHbBbhVUSF2zScDTQ+oGXQ==
X-CSE-MsgGUID: c/o+U4avQwW5qP4KXbVFZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="92903530"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="92903530"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 14:52:38 -0700
X-CSE-ConnectionGUID: E57rZIlRSx2HddfN/QdFEg==
X-CSE-MsgGUID: l+vFGtC+T+ufMRZX/FGotw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="221482266"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 25 Mar 2026 14:52:36 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w5W9R-000000007lB-1qTC;
	Wed, 25 Mar 2026 21:52:33 +0000
Date: Thu, 26 Mar 2026 05:52:14 +0800
From: kernel test robot <lkp@intel.com>
To: Francesco Lavra <flavra@baylibre.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <202603260526.WbXSysM8-lkp@intel.com>
References: <20260324084808.654118-1-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324084808.654118-1-flavra@baylibre.com>

Hi Francesco,

kernel test robot noticed the following build warnings:

[auto build test WARNING on next-20260323]
[cannot apply to jic23-iio/togreg linus/master v7.0-rc5 v7.0-rc4 v7.0-rc3 v7.0-rc5]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Francesco-Lavra/iio-imu-st_lsm6dsx-Fix-check-for-invalid-samples-from-FIFO/20260325-021519
base:   next-20260323
patch link:    https://lore.kernel.org/r/20260324084808.654118-1-flavra%40baylibre.com
patch subject: [PATCH v9 6/6] iio: imu: st_lsm6dsx: Add support for rotation sensor
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20260326/202603260526.WbXSysM8-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260326/202603260526.WbXSysM8-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603260526.WbXSysM8-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:138:1: warning: label at end of compound statement is a C2x extension [-Wc2x-extensions]
     138 | }
         | ^
   drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c:137:1: warning: unused label 'out' [-Wunused-label]
     137 | out:
         | ^~~~
   2 warnings generated.


vim +138 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_fusion.c

   117	
   118	int st_lsm6dsx_fusion_set_odr(struct st_lsm6dsx_sensor *sensor, bool enable)
   119	{
   120		struct st_lsm6dsx_hw *hw = sensor->hw;
   121		int err;
   122	
   123		guard(mutex)(&hw->page_lock);
   124	
   125		err = st_lsm6dsx_fusion_page_enable(hw);
   126		if (err)
   127			return err;
   128	
   129		err = st_lsm6dsx_fusion_set_odr_locked(sensor, enable);
   130		if (err) {
   131			st_lsm6dsx_fusion_page_disable(hw);
   132			return err;
   133		}
   134	
   135		return st_lsm6dsx_fusion_page_disable(hw);
   136	
   137	out:
 > 138	}
   139	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
