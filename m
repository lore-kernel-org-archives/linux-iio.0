Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795730984;
	b=kdbzxGip1PiWHuUzmDjviWQumgYA8sqHbTKLTsvVEhNeQo0cYhy7pMzoMZzdm5jHcdpz
	 riYhOdBPuLhAawmqfL46l6uYjkncvyeBNOntoo6RZr6V8Fexia4loi6BleSLK0f6QPuHq
	 s4CzNmHIS0BSTVfmQH974UmSRoyX5/DRFr2LgZ50AWA93g20T6bjbYA562M/532tAN02p
	 JUrm0APd9c82CqJfDWx7ha1qtxHJpRkb/XjhJHQagnJ87liNiJc+gZ8Hb072nJfYk7DyD
	 44Af2it5uiiK1J9y0ZARSj9usvHV6Yzolmrz/e0uP3pOhOItGJapr1QgjGOtIhRSTWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795730984;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
	 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=I5v0JsGqp24CAKR03vUd6KOc5z/kIg6y/48uz5hFCgs=;
	b=anRsTgKIQKNTQulmrj3Oy5BqB2klejc3T9u8UxPX03TRevfPBkYls3/R7as5DJP/78BR
	 /qkowazPzrTomk+KU+0R9UvZ6uoi3vFYe3uia0X1zfNiywz3XNtyBtX2/o3xvKMQ7ow0W
	 CE+Nxf6h4N4S6Oz58jhxp+Q/EGNRki4VDMSrtSfgIEI5CTeLYzgr0iitmYkwn6dkGB4w8
	 v87P4VNFVHDN1kWGqu23bwyND8qa6bbAg7zJN9KWkOSHZbjv6gaevcXnaNd7cKtO1WJGV
	 pSUaRlD37yd11sQB+15uAmlaR6RTxV7MoETQpBrqsgzuEAeK7SgKizGOWJTd2Ef187A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mDBf9rXU;
	arc=none smtp.remote-ip=198.175.65.17
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2E7606A330;
	Thu, 26 Nov 2026 22:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0B2E7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mDBf9rXU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795730984; x=1827266984;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jQl5SVALAIeS7jawC6ZuFNJD8KZfNc2rVFnNHxmKSqw=;
  b=mDBf9rXUz669IUFOC11lIzF+yfczNujhem5S3ebe/I9HSFs+/leEE2Ep
   dOdfGtm5CQS5d02d0jbE2qyJMIzqV8xL+AJZgeh4GNYnOxDF6RwVhdNEj
   lRdkE/6P6A+MMkHTPVzITwC1Ml1MvWTojPErI0XoKdsT9o5CeSoz1gGOt
   iKqZOgx8pafZXcXC6WGC6DRbuItMOUM5ZVa070BBfqu5vqXIy3VBE05J0
   I90sh3YaBCvkKyIPhnmdAcLMWpA1ra/nlBf9gpVtCkY1jMKxFsTueZgqe
   ItxSd4XuBofI5JBeHCUHK6P5YYt8C1vI7kiy2NGIXureLRHpigGE+fGLw
   w==;
X-CSE-ConnectionGUID: 4vKqu+/wRc2cjqCYwXK8/g==
X-CSE-MsgGUID: TKf5b03BTPW4tstKxmwAdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4643536"
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="4643536"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2026 14:09:41 -0800
X-CSE-ConnectionGUID: JHDpbERWRmOf+i8ETjP+FA==
X-CSE-MsgGUID: HgcEE5u1RNiFVWBKYbeDxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,235,1787036400"; 
   d="scan'208";a="13939775"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 26 Nov 2026 14:09:36 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xWheo-00000001Uxa-109p;
	Thu, 26 Nov 2026 22:09:34 +0000
Date: Fri, 27 Nov 2026 06:09:17 +0800
From: kernel test robot <lkp@intel.com>
To: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Robert Ijtsma <robertijtsma@gmail.com>
Subject: Re: [PATCH v2 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient
 light sensor driver
Message-ID: <20261127060159.FSKHGwvz-lkp@intel.com>
References: <20261126-iio-tcs3430-v2-2-6c5329d20919@gmail.com>
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
In-Reply-To: <20261126-iio-tcs3430-v2-2-6c5329d20919@gmail.com>

Hi Robert,

kernel test robot noticed the following build errors:

[auto build test ERROR on 4843f6873f7c4835e62f2c73ba0fd538e57a2f22]

url:    https://github.com/intel-lab-lkp/linux/commits/Robert-Ijtsma-via-B4-Relay/dt-bindings-iio-light-add-ams-OSRAM-TCS3430/20261126-091147
base:   4843f6873f7c4835e62f2c73ba0fd538e57a2f22
patch link:    https://lore.kernel.org/r/20261126-iio-tcs3430-v2-2-6c5329d20919%40gmail.com
patch subject: [PATCH v2 2/2] iio: light: add ams OSRAM TCS3430 XYZ and ambient light sensor driver
config: riscv-randconfig-1000-20261127 (https://download.01.org/0day-ci/archive/20261127/20261127060159.FSKHGwvz-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261127/20261127060159.FSKHGwvz-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/20261127060159.FSKHGwvz-lkp@intel.com/

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'devm_iio_init_iio_gts' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_find_gain_by_sel' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_get_scale' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_all_avail_scales' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_avail_times' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_find_gain_sel_for_scale_using_time' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_find_gain_time_sel_for_scale' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_find_new_gain_by_gain_time_min' from namespace 'IIO_GTS_HELPER', but does not import it.
>> ERROR: modpost: drivers/iio/light/tcs3430.ko: module uses symbol 'iio_gts_find_sel_by_gain' from namespace 'IIO_GTS_HELPER', but does not import it.

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
