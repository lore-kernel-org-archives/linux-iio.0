Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795537804;
	b=DvUOYwcktvu57zDH1YyiYPbgBdTQg2RVnJBA+yq47wCJO3WXgoGvRzWsV9FvyomqAydP
	 RPUNOlOPLfyq8yzB3ThC7UEAAsLcT7EVook3BczNeLEoHAvp8K/9C1qYqo86xbjXQ3S27
	 Zst+5a0Pco/r8Wj9PBwfEs3S/Qg+sXaIG74fv/s3IbiWIPvXDv9rhzqnnlMYoYtxdYICU
	 FnB0y2Dg+ZCdbn9zCeyWpPw4DZcy3pW3BfkhLJYnX1pSVA4nT7tgzclkQfElIdwPMrB+z
	 zJ7ZKdxCvDwGPHR19m/QN836d2U3NomLKCPuy00NSw0w4dCIkuhF785yQVcTDZmuQ1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795537804;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=X/vNezg/LV9JUzYAFJhN0ZdrCxxx3+0MzuLhJR/Rv1Y=;
	b=VLlAP6v5BUNHudGLrcd8Fj5NSnyM8h3v6eJyS47pTaifUghnkdCSFtjemLIb/VoED2bi
	 CIeyRVCcl26DNfZrnr9KvpceiTDdbK9/g5s+HEpFCbe19wuhiEZoMGzNQLguuLP/aGHRB
	 E4THdJJSLgumNzztoBB1u4dlfWFF46ZuYkmQ6omaLacEyUtU0XsSJkA4kFNhMta7fADmj
	 kkfjO0WDYoEjwBTdZgHd69as+Adcg5Rxi8vq2ZYes1ppPQm2oLx/OTwuD+uUq33W7kZGO
	 VLAc1SVRLDsY2NpcQOmM8Tt2+sqejp/D0MDaTq3ioTByT6qTNJW8Kn3k2sOLMKKt9CA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPz1RU6j;
	arc=none smtp.remote-ip=198.175.65.20
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37D0606A323;
	Tue, 24 Nov 2026 16:30:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F37D0606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KPz1RU6j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795537803; x=1827073803;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ehva+mkV70v/sA6TTEZ/xpMHbyfLVmSE6rLtw03CPeg=;
  b=KPz1RU6jhmv3hGVN5Wmajud5iaA++IPrFmDiVfAS26jeAs1cPKAhuWnh
   Dr1rdGtnVRa0QGrO9Oz37VFg41oBv9Dol5+gh3sGxvKAXcubY9kxrFbK4
   eMgPzdNrYkvfj7WmzfYbBUGj41pF3lERuj4AcY5kV0tPMqWvyker3qDk4
   9fSTTtGvfqKpzJeLzKyA29bFqnSEHu03tkGabKS0KMJ2/Ps1YqGhn2oaf
   VsnWnwPmILMgrJyF1pIxMZs2HN9LylgT5VzdxfYd+OhI4sGGKjdePHJpE
   9A+UGUlgDsQhn/kAo/JSI8O5A+TPCEyhp+H7iDvOd+QsiWguS+/9r0zkh
   w==;
X-CSE-ConnectionGUID: Crh/QDM+Qe6dnG+8kHEJJA==
X-CSE-MsgGUID: 01F7n4HjT1CEj8h5dFC4Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4446975"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4446975"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2026 08:30:02 -0800
X-CSE-ConnectionGUID: lGPtBAdCTdmX6Hu+Xr4BvQ==
X-CSE-MsgGUID: 0eWxm+WIQi6lYd4uE4MqKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="11922180"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 24 Nov 2026 08:30:00 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xVtP3-00000001Pio-3nEX;
	Tue, 24 Nov 2026 16:29:57 +0000
Date: Wed, 25 Nov 2026 00:29:22 +0800
From: kernel test robot <lkp@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: Re: [PATCH v1 1/1] iio: core: Split debugfs routines
Message-ID: <20261125002412.n7KFlU4e-lkp@intel.com>
References: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261124094502.557175-1-andriy.shevchenko@linux.intel.com>

Hi Andy,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.4-rc4 next-20261123]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-core-Split-debugfs-routines/20261124-104410
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261124094502.557175-1-andriy.shevchenko%40linux.intel.com
patch subject: [PATCH v1 1/1] iio: core: Split debugfs routines
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20261125/20261125002412.n7KFlU4e-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261125/20261125002412.n7KFlU4e-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261125002412.n7KFlU4e-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

>> drivers/iio/industrialio-debugfs.c:138:13: error: static declaration of 'iio_device_unregister_debugfs' follows non-static declaration
     138 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iio/industrialio-debugfs.c:20:
   drivers/iio/iio_core.h:23:6: note: previous declaration of 'iio_device_unregister_debugfs' with type 'void(struct iio_dev *)'
      23 | void iio_device_unregister_debugfs(struct iio_dev *indio_dev);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/industrialio-debugfs.c:145:13: error: static declaration of 'iio_device_register_debugfs' follows non-static declaration
     145 | static void iio_device_register_debugfs(struct iio_dev *indio_dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iio/iio_core.h:24:6: note: previous declaration of 'iio_device_register_debugfs' with type 'void(struct iio_dev *)'
      24 | void iio_device_register_debugfs(struct iio_dev *indio_dev);
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/industrialio-debugfs.c:145:13: warning: 'iio_device_register_debugfs' defined but not used [-Wunused-function]
     145 | static void iio_device_register_debugfs(struct iio_dev *indio_dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/industrialio-debugfs.c:138:13: warning: 'iio_device_unregister_debugfs' defined but not used [-Wunused-function]
     138 | static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/iio_device_unregister_debugfs +138 drivers/iio/industrialio-debugfs.c

   137	
 > 138	static void iio_device_unregister_debugfs(struct iio_dev *indio_dev)
   139	{
   140		struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
   141	
   142		debugfs_remove_recursive(iio_dev_opaque->debugfs_dentry);
   143	}
   144	
 > 145	static void iio_device_register_debugfs(struct iio_dev *indio_dev)

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
