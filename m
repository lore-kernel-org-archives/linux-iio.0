Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.7
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903083;
	b=HziGbH9qpq/2zWkF7MVgazfw8D8UGpzV7yDrFS200XvOUI6WL1FdlsILIkeE/5YtrtDa
	 FHYzmPLnc5/rgSJHi/E674i95BtRzydlCrN1selRAO7D+zJdqzw9YB/NY3RLTL1WMaPad
	 Bt8eAb/KcF0azbY5Q1dqxYJ9ugD8RE3lS/c8IYFowp52MzPbkoF1xs4V2F0ZTlrAT4BZL
	 T7RKrY8RgBsZYDSjlt51bsMyYvmdX8i88SqBuSbh6Tp7H+SAqHXs9OaRf/USuC4rWpeTr
	 QGC5fcDNtT1p74nB+5Hf0dU2SDz5ovQuspEguaGEelTJ0orpRL+XqO8lRs8/yWi3u6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903083;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=E6Q8P1340lhjpphLE4vGSu5qYC4hlfkJAY0J5FgHtHo=;
	b=St/DYKpityVrk253ujuRonaJDKP06bmgX0/LyRGPs9KbGf4DLi1Kw1huxytrhKzYYuXj
	 4Tre2gd6Y0lKlE9cmdByA7DXm30DH7hqKg1bXdvcLvpTOR2QmdQH85QUayDqsUvQF/uul
	 dkKtKZO2Y4yb2AHcWSenYxd3vVx06I1MaKOnBh123DYwllJIUOQuuodC8u5gKO1U1knEv
	 6AjWW1f5etiIK4UzyDKs/aZq54zbO9ZYE7yy2EtwMDR4c2N6eH0Zuj8n1oi1Fmljc8YdJ
	 cgNWu42cRD+03Ou35W3+3AKFGADClZ7v7gspKlh8YmNWV9LhO1+3a8YKy6sRdHhYlAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E05Tioe+;
	arc=none smtp.remote-ip=192.198.163.7
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F8B606A31B;
	Thu,  5 Nov 2026 18:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70F8B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=E05Tioe+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793903083; x=1825439083;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GRIUUO0N0cBOPlANN2KKDeJN/d7vjvFPsFxRvjTj6Vo=;
  b=E05Tioe+uLEdhEDatIhTEDqd0ycMRnJdWcEnaIabETxRbGSbCh4dXUaz
   uCa4Sv/5kgTew+ilW8YMjOnnRxmk3N+9WPtOa6IYfmEzoMfjGD/7Bfb0O
   /7hL1vOin/K6Q2DFumd9gIn89GhnvtvD/r4Thc4aYoVrxMmQu5LICSTG5
   CbjYN1vT1Ox75K83qeApeowuQ1AeRJNHBtn9TKCcr3ZEgx70KfUVNdBZI
   JijPz00kwyZJOaFL2E0xLYu3wsbnSEd4r00u0/yWu52UgDSAvtSgokNVi
   xhJ/7tqRO6DgLNXMZLzmvQUuHcDumkn9enAbTlcGN0gngMaA/NzsE8x5X
   Q==;
X-CSE-ConnectionGUID: DxYEiW9jT2OhyU/5LCa6Ww==
X-CSE-MsgGUID: x7oKkk9TSNeLGW5JTg4QTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2576618"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2576618"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 10:24:42 -0800
X-CSE-ConnectionGUID: z4SZqRXTRa2RGIHBG7N8Cw==
X-CSE-MsgGUID: WnIR7PMzQgymMHOCEdnnXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="7395680"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Nov 2026 10:24:39 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xP28a-00000000mfb-3EkY;
	Thu, 05 Nov 2026 18:24:36 +0000
Date: Fri, 6 Nov 2026 02:23:39 +0800
From: kernel test robot <lkp@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, Nikhil Gautam <nikhilgtr@gmail.com>
Subject: Re: [PATCH v5] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <202611060115.RlOXqnls-lkp@intel.com>
References: <20261104151138.9968-1-nikhilgtr@gmail.com>
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
In-Reply-To: <20261104151138.9968-1-nikhilgtr@gmail.com>

Hi Nikhil,

kernel test robot noticed the following build errors:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on linus/master v7.3 next-20261105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Nikhil-Gautam/iio-chemical-ccs811-Make-sampling-frequency-configurable/20261104-204138
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20261104151138.9968-1-nikhilgtr%40gmail.com
patch subject: [PATCH v5] iio: chemical: ccs811: Make sampling frequency configurable
config: arc-randconfig-1000-20261105 (https://download.01.org/0day-ci/archive/20261106/202611060115.RlOXqnls-lkp@intel.com/config)
compiler: arc-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261106/202611060115.RlOXqnls-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611060115.RlOXqnls-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/iio/chemical/ccs811.c:18:
   drivers/iio/chemical/ccs811.c: In function 'ccs811_write_raw':
>> include/linux/cleanup.h:298:2: error: a label can only be part of a statement and a declaration is not a statement
     class_##_name##_t var __cleanup(class_##_name##_destructor) = \
     ^~~~~~
   include/linux/cleanup.h:422:34: note: in expansion of macro 'CLASS'
    #define ACQUIRE(_name, _var)     CLASS(_name, _var)
                                     ^~~~~
   include/linux/iio/iio.h:817:2: note: in expansion of macro 'ACQUIRE'
     ACQUIRE(__priv__iio_dev_mode_lock_try_direct, claim)(dev)
     ^~~~~~~
   drivers/iio/chemical/ccs811.c:354:3: note: in expansion of macro 'IIO_DEV_ACQUIRE_DIRECT_MODE'
      IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
      ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +298 include/linux/cleanup.h

54da6a0924311c7 Peter Zijlstra 2023-05-26  293  
2deccd5c862a033 Peter Zijlstra 2026-03-09  294  #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
2deccd5c862a033 Peter Zijlstra 2026-03-09  295  	EXTEND_CLASS_COND(_name, ext, 0, _init, _init_args)
2deccd5c862a033 Peter Zijlstra 2026-03-09  296  
54da6a0924311c7 Peter Zijlstra 2023-05-26  297  #define CLASS(_name, var)						\
54da6a0924311c7 Peter Zijlstra 2023-05-26 @298  	class_##_name##_t var __cleanup(class_##_name##_destructor) =	\
54da6a0924311c7 Peter Zijlstra 2023-05-26  299  		class_##_name##_constructor
54da6a0924311c7 Peter Zijlstra 2023-05-26  300  

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
