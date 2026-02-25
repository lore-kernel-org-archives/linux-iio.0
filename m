Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD87B2AE68;
	Wed, 25 Feb 2026 03:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771989754; cv=none; b=toNzHllYf76CiJm97GWM3hqc+09k8kHkIOEvNVIvDLFQWhx6OONqA630iMut04xQQGuWcNj4i3Fxz5gBaGr10UmwXOcWwQcw7wkkIQwsCmVP97FpIiNVEtiOktqSJ+1WkKCAsPpYIOmU+zO27Te4HhF4npc47/2AcIez9aryfwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771989754; c=relaxed/simple;
	bh=fQ3abqpA4UQHDQ+kifybYdmRSEbqygRuEteuB89GWmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0OiqVYRw5TTJ6OO2bxC8qRzQtDu5sBgt18BUbDw+DwlnJou6DVximZozJ7HSuOIBlZHhejoQ5ydMVegjDEmdrcSFJU6o5i0L+pmnXKtTihsdrEmNKKvKsSU3SEBZpRcrx9/hcgQI4yP9f6tTHrY66/UqpoDPmOcDXXMIZKCa2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PwOgPzYH; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PwOgPzYH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771989753; x=1803525753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQ3abqpA4UQHDQ+kifybYdmRSEbqygRuEteuB89GWmM=;
  b=PwOgPzYHtILZcPd6UwzU+kiMWqGiCH8fLX+LWhEXxx+Je6p6zQf4sJj0
   6kH4VDvmBlOZ8mEzFr+/rzknS9JJm+tEwSD0L40u3EKkl8qnTsw5jCSX1
   YX4yKVfrlU0+VpI1Uuq+c+O6Mj9JGeprSZmpY0b72fHB5IvqzM7TiDb0C
   WkjFPOcrKM6I+/zvKfNNJLW0DM6hcW2sDK2z209My24Wo5h4mxsO2IAoP
   J2L/SideOSvqdFLakaNS6vaKAUat9lndqAn0FbXF9rbev3Ne443f7u7L4
   yNQqOOLh9Nf3QByyyaB9C1HexzUs3R5bQgF6CF1Od5TKZktmSjYQswW78
   g==;
X-CSE-ConnectionGUID: hvgIAahhTx6K0xpDRXc8Qw==
X-CSE-MsgGUID: hFYWOrLxTHmtpUtlOHHWqA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72721886"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="72721886"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 19:22:32 -0800
X-CSE-ConnectionGUID: M6CAOsi7Ru6o9asTZTCQaQ==
X-CSE-MsgGUID: M56VrZNnTFubwVE0KvtjMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="216112635"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by orviesa008.jf.intel.com with ESMTP; 24 Feb 2026 19:22:29 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vv5TE-000000003s5-0XDm;
	Wed, 25 Feb 2026 03:22:05 +0000
Date: Wed, 25 Feb 2026 11:21:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] iio: imu: inv_icm42607: add new inv_icm42607 driver
Message-ID: <202602251146.f80QkdrL-lkp@intel.com>
References: <20260224163109.370930-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224163109.370930-3-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build errors:

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on linus/master v7.0-rc1 next-20260224]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-iio-imu-icm42607-Add-devicetree-binding/20260225-003610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20260224163109.370930-3-macroalpha82%40gmail.com
patch subject: [PATCH 2/3] iio: imu: inv_icm42607: add new inv_icm42607 driver
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20260225/202602251146.f80QkdrL-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260225/202602251146.f80QkdrL-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602251146.f80QkdrL-lkp@intel.com/

All errors (new ones prefixed by >>):

>> hppa-linux-ld: drivers/iio/imu/inv_icm42607/inv_icm42607_spi.o:(.data+0x50): undefined reference to `inv_icm42607_pm_ops'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
