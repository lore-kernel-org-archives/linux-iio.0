Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C793C944F;
	Fri, 27 Mar 2026 09:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774602862; cv=none; b=jvg2x+cJvEjmguOv9H5GP5Df9Rnal4LaV6kR9stgBTc67zz7/1dgOx6c5ipreVMDKcbbTn7AUmS8GU4n8r/yCkWVEyGowOQrqFXNEFqcFl6w+xpGts3J8Sfa8f2GvpLodG9acPVxgtAR0ZOSSkZDH75NxnOFushrGGROeukq3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774602862; c=relaxed/simple;
	bh=tcEHF6ZmG+i3/sYhYQxaSi2YTNbDHBsiC+5pE7pekMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ow/7KN3HUuNW194lfF4T4CyqT4d7sGNElC66XPE1p+UPi34OizUWSZG8x115ObbPJlxqIMzJ2Z4wov0UA6PZ5KLXvfh1wlfJa2aK/Ox7TMPYNSe4zPOr5YtHBG1wkHvhtdn0OcMHKjRFD8S4IF0iS4RDmXc4j2/CK2tXgWSKMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZD0l9JUF; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZD0l9JUF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774602861; x=1806138861;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tcEHF6ZmG+i3/sYhYQxaSi2YTNbDHBsiC+5pE7pekMM=;
  b=ZD0l9JUFHpafqmUuXShRghjfH3JnHRMiCe4EQr/i4/luLCNo9gO0nd64
   clJkrAwU3Nb7lH8l0rr6TxOkzNDCAj3qFwTXXSByPS/1ZsmSgRJ/ElrhT
   cRdeeGJ0C94XCAR2YDX1+3dbYq3y2MEGNUP72aB1aAUovG9PPjad0rFhG
   t6t3CTlfZ2oEBLXOA+iTpfaEXnjkmgHgZNSuZLC3bkLQ9ERiEyAhT1wUn
   iHsDCKSwQTQ5ngrNzR43Gg5NDU18UTRbbBplfFgVayy2x4RbFGWk+1dXj
   N1ilAyeGPoye5ci0fLv1a5//t3IbrrrkO9wH8OfPq1hX+WUQL12XlmvVl
   A==;
X-CSE-ConnectionGUID: BgosLMoGRn6xyRdZZUSM4g==
X-CSE-MsgGUID: bI1nPGrtTvioaQHOWwEJbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="79274907"
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="79274907"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 02:14:21 -0700
X-CSE-ConnectionGUID: 4X9xTXyeSaWOXDWm0e9Npg==
X-CSE-MsgGUID: KuEW1thcQyeui24AduETKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,143,1770624000"; 
   d="scan'208";a="263203659"
Received: from lkp-server01.sh.intel.com (HELO 3905d212be1b) ([10.239.97.150])
  by orviesa001.jf.intel.com with ESMTP; 27 Mar 2026 02:14:19 -0700
Received: from kbuild by 3905d212be1b with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w63Gi-00000000A6n-0hsi;
	Fri, 27 Mar 2026 09:14:16 +0000
Date: Fri, 27 Mar 2026 17:13:16 +0800
From: kernel test robot <lkp@intel.com>
To: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matt Ranostay <mranostay@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for
 spi_read()
Message-ID: <202603271734.pnWuSmNr-lkp@intel.com>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b@baylibre.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Lechner/iio-adc-ti-adc161s626-fix-buffer-read-on-big-endian/20260315-092711
base:   ff0843ceb1fb11a6b73e0e77b932ef7967aecd4b
patch link:    https://lore.kernel.org/r/20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-2-56243b11e87b%40baylibre.com
patch subject: [PATCH 2/2] iio: adc: ti-adc161s626: use DMA-safe memory for spi_read()
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260327/202603271734.pnWuSmNr-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260327/202603271734.pnWuSmNr-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603271734.pnWuSmNr-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/adc/ti-adc161s626.c: In function 'ti_adc_read_measurement':
>> drivers/iio/adc/ti-adc161s626.c:87:24: error: implicit declaration of function 'get_unaligned_be16' [-Wimplicit-function-declaration]
      87 |                 *val = get_unaligned_be16(data->buf);
         |                        ^~~~~~~~~~~~~~~~~~
>> drivers/iio/adc/ti-adc161s626.c:94:24: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
      94 |                 *val = get_unaligned_be24(data->buf);
         |                        ^~~~~~~~~~~~~~~~~~


vim +/get_unaligned_be16 +87 drivers/iio/adc/ti-adc161s626.c

    75	
    76	static int ti_adc_read_measurement(struct ti_adc_data *data,
    77					   struct iio_chan_spec const *chan, int *val)
    78	{
    79		int ret;
    80	
    81		switch (data->read_size) {
    82		case 2:
    83			ret = spi_read(data->spi, data->buf, 2);
    84			if (ret)
    85				return ret;
    86	
  > 87			*val = get_unaligned_be16(data->buf);
    88			break;
    89		case 3:
    90			ret = spi_read(data->spi, data->buf, 3);
    91			if (ret)
    92				return ret;
    93	
  > 94			*val = get_unaligned_be24(data->buf);
    95			break;
    96		default:
    97			return -EINVAL;
    98		}
    99	
   100		*val = sign_extend32(*val >> data->shift, chan->scan_type.realbits - 1);
   101	
   102		return 0;
   103	}
   104	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
