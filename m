Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6F035AC14;
	Thu,  8 Oct 2026 16:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478018; cv=none; b=FwJkPoqezd0jsInGiLbfEHnORj4/u3P5ReC/M7zPwgNbcakdJFSdxOoZIKDeFpLpAkU/aRJiWAQtHE6S1vSR5y73SFoq2qDqreIMhxIzTzPDVNuw4JaPRNPvcyeAJfzxUVH18wgCP46FA8Ac0MN5zGg6d8t0POvDn+Dl/Nk0KXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478018; c=relaxed/simple;
	bh=y9exSn++eNilrTXWwsY6/at3Kjqr1BXo2+Q4Osb9AgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m79VVKJdbWZyQp5D4l/oQ0jKUaZlErzpR2X9U6GXEdbIuBHXBpDSkkz3Bt7VKPqNn37/fAkQMCDMSm8p6TXee2bhGnXJWzlWMgHA0WBL2XFgbzJzaEvtBHh6kcF3mf6Dwdu2MU8U/ehze67egkl+IOmkhhn6pVGiCT7RAyMM9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIuxar2P; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIuxar2P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791478017; x=1823014017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y9exSn++eNilrTXWwsY6/at3Kjqr1BXo2+Q4Osb9AgA=;
  b=bIuxar2Pt9MqvQ+6b/+NpetNurC1Xw9UQ7XGnaSxCwtrFPEBKiF3rB9C
   63pFqoCYNkPZGIFmoTDNlsIJEBm0BC+foKDxwCuX10ZYV9UVBViBLg87s
   /1EkHc7ACaSDupaOjMYItQ1jUuQ06rD1FL+EAqyjoQc5+RQOse7Uo1ozc
   xiu9pM3P+80XgeuEjVXozad+iqG4tCR8gpurbohpuYWsAbxGB+iUxoOO8
   VHAp10wlcT2zMWFynj63oFxnxmYS3FjZdW4/O9QAgLz4DDFii3chUJ6Up
   yP5bMI1D+7nAp2YBuz78EebuGv1BrBfiFY1rPgHYA2l5OPr2oA0DIYXEj
   Q==;
X-CSE-ConnectionGUID: +ie2uicEQ9WtggpnXbVB1A==
X-CSE-MsgGUID: M3VCrLVSTwm4ZGj8hiMz1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="279753"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="279753"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2026 09:46:57 -0700
X-CSE-ConnectionGUID: GbDOzSzaSVmBlV8f31DQSg==
X-CSE-MsgGUID: uW1pO5uBRBGKnV+PCecRLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1912917"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
  by fmviesa012.fm.intel.com with ESMTP; 08 Oct 2026 09:46:54 -0700
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1xErGc-000000004f0-2yit;
	Thu, 08 Oct 2026 16:46:50 +0000
Date: Fri, 9 Oct 2026 00:46:35 +0800
From: kernel test robot <lkp@intel.com>
To: Ariana Lazar <ariana.lazar@microchip.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	Ariana Lazar <ariana.lazar@microchip.com>
Subject: Re: [PATCH v4 3/3] iio: adc: add support for PAC1711
Message-ID: <202610090029.8WKWgYLF-lkp@intel.com>
References: <20261007-pac1711-v4-3-6ef34d7a7947@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261007-pac1711-v4-3-6ef34d7a7947@microchip.com>

Hi Ariana,

kernel test robot noticed the following build warnings:

[auto build test WARNING on cee9395acd8043be0644b25c34bfa86623f2b935]

url:    https://github.com/intel-lab-lkp/linux/commits/Ariana-Lazar/iio-core-add-IIO_CHARGE-channel-type/20261007-174153
base:   cee9395acd8043be0644b25c34bfa86623f2b935
patch link:    https://lore.kernel.org/r/20261007-pac1711-v4-3-6ef34d7a7947%40microchip.com
patch subject: [PATCH v4 3/3] iio: adc: add support for PAC1711
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20261009/202610090029.8WKWgYLF-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 16.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261009/202610090029.8WKWgYLF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610090029.8WKWgYLF-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/adc/pac1711.c:134:51: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073667551616' to '-42000000' [-Woverflow]
     134 |                 [PAC1711_FULL_RANGE_BIPOLAR]  = { -PAC1711_VBUS_FSR_UV, PAC1711_VBUS_FSR_UV },
         |                                                   ^
   drivers/iio/adc/pac1711.c:135:51: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073688551616' to '-21000000' [-Woverflow]
     135 |                 [PAC1711_HALF_RANGE_BIPOLAR]  = { -PAC1711_VBUS_FSR_HALF_UV,
         |                                                   ^
   drivers/iio/adc/pac1711.c:140:51: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073700551616' to '-9000000' [-Woverflow]
     140 |                 [PAC1711_FULL_RANGE_BIPOLAR]  = { -PAC1721_VBUS_FSR_UV, PAC1721_VBUS_FSR_UV },
         |                                                   ^
   drivers/iio/adc/pac1711.c:141:51: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073705051616' to '-4500000' [-Woverflow]
     141 |                 [PAC1711_HALF_RANGE_BIPOLAR]  = { -PAC1721_VBUS_FSR_HALF_UV,
         |                                                   ^
   drivers/iio/adc/pac1711.c:148:42: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709451616' to '-100000' [-Woverflow]
     148 |         [PAC1711_FULL_RANGE_BIPOLAR] = { -PAC1711_VSENSE_FSR_UV, PAC1711_VSENSE_FSR_UV },
         |                                          ^
   drivers/iio/adc/pac1711.c:149:42: warning: overflow in conversion from 'long unsigned int' to 'int' changes value from '18446744073709501616' to '-50000' [-Woverflow]
     149 |         [PAC1711_HALF_RANGE_BIPOLAR] = { -PAC1711_VSENSE_FSR_HALF_UV, PAC1711_VSENSE_FSR_HALF_UV },
         |                                          ^


vim +134 drivers/iio/adc/pac1711.c

   130	
   131	static const int pac1711_vbus_range_tbl[2][3][2] = {
   132		[PAC1711_VOLTAGE_RANGE_IDX] = {
   133			[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1711_VBUS_FSR_UV },
 > 134			[PAC1711_FULL_RANGE_BIPOLAR]  = { -PAC1711_VBUS_FSR_UV, PAC1711_VBUS_FSR_UV },
   135			[PAC1711_HALF_RANGE_BIPOLAR]  = { -PAC1711_VBUS_FSR_HALF_UV,
   136							  PAC1711_VBUS_FSR_HALF_UV },
   137		},
   138		[PAC1721_VOLTAGE_RANGE_IDX] = {
   139			[PAC1711_FULL_RANGE_UNIPOLAR] = { 0, PAC1721_VBUS_FSR_UV },
   140			[PAC1711_FULL_RANGE_BIPOLAR]  = { -PAC1721_VBUS_FSR_UV, PAC1721_VBUS_FSR_UV },
   141			[PAC1711_HALF_RANGE_BIPOLAR]  = { -PAC1721_VBUS_FSR_HALF_UV,
   142							  PAC1721_VBUS_FSR_HALF_UV },
   143		},
   144	};
   145	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
