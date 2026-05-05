Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984A3E7145;
	Tue,  5 May 2026 08:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777969493; cv=none; b=q74mcENj2Lo14LdpLKjMe71umag7nzmjOna7yCSZSv2hyvT16aX/kGq32DK1YjrPmCRT8Ikkr0P5TcE9PuBxraJ8tvaC8S1qL6mAfw8g+YxmbVRs4wNS+PPJz2InmImY7TgL8mBdtWBfcicLEclvOUhYw2LqxshE+2Qyx+ER9f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777969493; c=relaxed/simple;
	bh=O3ZmG89DitAEKY/iF5Gt3ix7LcbgSHs20XfEf4y2VaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf33oQUiYfmFvf/zT/D54IXDsQIgMQYvW0QriUdLaLpkmCtF2/WfLiifhxw+fwUP9HVDUVFAt1BWsbAE7qgfnYVnll0DiyuSbP+flA2ISK8qhlcyyVZNijjGmJDGCQKsv1TaPVg7d86uGJFUsDZBeLXSUNiQeIyY9lXg64W4ae4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cce5lFds; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cce5lFds"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777969491; x=1809505491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O3ZmG89DitAEKY/iF5Gt3ix7LcbgSHs20XfEf4y2VaA=;
  b=Cce5lFdsQ4jSAX/44Dt6gsFWj7u0pAsEKImk8MR268Obtvs3q6AZTtRN
   KHO2bhq0KgftWxWNDzpMODAKYM7BJ7AnQFxRPn6QbSvrRu38GJFxTvESw
   wckWOLvzle/SnKrVen/ofOCWMfYNDIIK5bofNfQqwa1OHllu6J3dphx0N
   CERsU2egPM6cDrYQp4tDPn6h0UegMYhWK8ib7/X+f+dc6X025qXaYA8gb
   MDhAW5mGSbaH3TdiM/Tz3KOn43VJbk+iE8c83od53tQDunkf88ON8U6JM
   NCzH/uOhSF8dW3KJALRaxY7iOCJ+QFAk0pd7eZuFDZIhpmvda9r3A0js1
   Q==;
X-CSE-ConnectionGUID: KiitVxudTwCCiZzcZ1wlvw==
X-CSE-MsgGUID: L0ekgV/1SPeScNdPLoIxyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11776"; a="78540713"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78540713"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 01:24:50 -0700
X-CSE-ConnectionGUID: 6Pu6BJFmTx20TRccBApyzg==
X-CSE-MsgGUID: Cg0GHZhdSG2QkVlrkTHhfg==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 781826d00641) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 05 May 2026 01:24:48 -0700
Received: from kbuild by 781826d00641 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wKB5B-000000004Nl-2Inm;
	Tue, 05 May 2026 08:24:45 +0000
Date: Tue, 5 May 2026 16:23:48 +0800
From: kernel test robot <lkp@intel.com>
To: Maxwell Doose <m32285159@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual
 locking
Message-ID: <202605051637.8LggoiJY-lkp@intel.com>
References: <20260502032455.76107-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260502032455.76107-1-m32285159@gmail.com>

Hi Maxwell,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc2 next-20260504]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Maxwell-Doose/iio-imu-kmx61-Use-guard-mutex-family-over-manual-locking/20260504-212159
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260502032455.76107-1-m32285159%40gmail.com
patch subject: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual locking
config: i386-buildonly-randconfig-006-20260504 (https://download.01.org/0day-ci/archive/20260505/202605051637.8LggoiJY-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260505/202605051637.8LggoiJY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605051637.8LggoiJY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/kmx61.c: In function 'kmx61_write_raw':
>> drivers/iio/imu/kmx61.c:847:13: warning: unused variable 'ret' [-Wunused-variable]
     847 |         int ret;
         |             ^~~


vim +/ret +847 drivers/iio/imu/kmx61.c

20ffac278ebd64 Daniel Baluta 2014-12-03  842  
20ffac278ebd64 Daniel Baluta 2014-12-03  843  static int kmx61_write_raw(struct iio_dev *indio_dev,
20ffac278ebd64 Daniel Baluta 2014-12-03  844  			   struct iio_chan_spec const *chan, int val,
20ffac278ebd64 Daniel Baluta 2014-12-03  845  			   int val2, long mask)
20ffac278ebd64 Daniel Baluta 2014-12-03  846  {
20ffac278ebd64 Daniel Baluta 2014-12-03 @847  	int ret;
20ffac278ebd64 Daniel Baluta 2014-12-03  848  	struct kmx61_data *data = kmx61_get_data(indio_dev);
20ffac278ebd64 Daniel Baluta 2014-12-03  849  
20ffac278ebd64 Daniel Baluta 2014-12-03  850  	switch (mask) {
20ffac278ebd64 Daniel Baluta 2014-12-03  851  	case IIO_CHAN_INFO_SAMP_FREQ:
20ffac278ebd64 Daniel Baluta 2014-12-03  852  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
20ffac278ebd64 Daniel Baluta 2014-12-03  853  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  854  
84cb5906c7fb44 Maxwell Doose 2026-05-01  855  		guard(mutex)(&data->lock);
84cb5906c7fb44 Maxwell Doose 2026-05-01  856  		return kmx61_set_odr(data, val, val2, chan->address);
20ffac278ebd64 Daniel Baluta 2014-12-03  857  	case IIO_CHAN_INFO_SCALE:
20ffac278ebd64 Daniel Baluta 2014-12-03  858  		switch (chan->type) {
20ffac278ebd64 Daniel Baluta 2014-12-03  859  		case IIO_ACCEL:
20ffac278ebd64 Daniel Baluta 2014-12-03  860  			if (val != 0)
20ffac278ebd64 Daniel Baluta 2014-12-03  861  				return -EINVAL;
84cb5906c7fb44 Maxwell Doose 2026-05-01  862  			guard(mutex)(&data->lock);
84cb5906c7fb44 Maxwell Doose 2026-05-01  863  			return kmx61_set_scale(data, val2);
20ffac278ebd64 Daniel Baluta 2014-12-03  864  		default:
20ffac278ebd64 Daniel Baluta 2014-12-03  865  			return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  866  		}
20ffac278ebd64 Daniel Baluta 2014-12-03  867  	default:
20ffac278ebd64 Daniel Baluta 2014-12-03  868  		return -EINVAL;
20ffac278ebd64 Daniel Baluta 2014-12-03  869  	}
20ffac278ebd64 Daniel Baluta 2014-12-03  870  }
20ffac278ebd64 Daniel Baluta 2014-12-03  871  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
