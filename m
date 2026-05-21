Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57910347537;
	Thu, 21 May 2026 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779334685; cv=none; b=eXHZoFR0WartA2nJO6An4ywau6BZE9ffdpsXuyiMDauVqvSXNtDOWeKxlBvcGdNTMvw8Us3uet7OE79OUHgpq9KAHxWMcTsuzRsluPjMQVMOz+pnQoxVrfPzBhe/H5O+LN7stbQ5UrpJ/F3rjWVeyoCaWVSoWnfTdy5gfkHRDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779334685; c=relaxed/simple;
	bh=dpteIV5u8Ka//7sxzVrWClp6oaVFdbRQXCHjQ+ht1vw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7agC7jAt/4pjBunJjnQCrWpZPa2pOpJBt9Jp9kraisNVy2h0IET20uXVsetQoOFSaS/n+IOVZi9fPuxOv33t4JbWO7t28a/G9VqAuOtKxVlDkDFhyVMY8UZzMOCB6EO8Z5xklbL/DGF/eBhGVI+OsJ1IAzwkezkc+80zl21bjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ObDc/O1v; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ObDc/O1v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779334685; x=1810870685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dpteIV5u8Ka//7sxzVrWClp6oaVFdbRQXCHjQ+ht1vw=;
  b=ObDc/O1vOjzdrjrPRFORvQa07RsHsHra1+NLiRa9niJOWzqYVt940Qgn
   bWUY8t3Zs/uQWCShI0XU9QKk0VCEqdT4ONWip7bUBy7Vg6rR+br1aezRm
   wZzoIBfqwY3p5b5nDv8llmRM2Tc18En/S7kTCtxT/N0eRpXspQhi+4IDV
   dCbiH5yGBI+0NXX4mJcZnfV+YkSraS/ozsSKbOukkYhfl4B+5RSI/xxDl
   QLvCO/grOqhHOlhlEI++HP0c3qkfof7z+bnCPl8YDuYDum+newtoQFU0S
   UqGnnhefBgmoDPYY/3pA1+u/HbI0GzOVKHuyhUltm+dix469m2enHRFcH
   A==;
X-CSE-ConnectionGUID: Gt5YkcQoQVWpCPA+OHXAcA==
X-CSE-MsgGUID: EC88Ej3OTfeqAAqUs9le4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80214897"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="80214897"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 20:38:04 -0700
X-CSE-ConnectionGUID: mZCB5cYpTO63b8c6SF65Sg==
X-CSE-MsgGUID: /a7uBY0PTWmBjhQysn5Tmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; 
   d="scan'208";a="242204941"
Received: from lkp-server02.sh.intel.com (HELO 30e86e9c1927) ([10.239.97.151])
  by fmviesa004.fm.intel.com with ESMTP; 20 May 2026 20:38:02 -0700
Received: from kbuild by 30e86e9c1927 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wPuE2-000000004Iz-2m2Q;
	Thu, 21 May 2026 03:37:48 +0000
Date: Thu, 21 May 2026 11:33:28 +0800
From: kernel test robot <lkp@intel.com>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] iio: light: al3010: read both ALS ADC registers again
Message-ID: <202605211105.cR7k7vyR-lkp@intel.com>
References: <20260520175855.538098-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520175855.538098-1-grandmaster@al2klimov.de>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc4 next-20260520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-A-Klimov/iio-light-al3010-read-both-ALS-ADC-registers-again/20260521-024036
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260520175855.538098-1-grandmaster%40al2klimov.de
patch subject: [PATCH] iio: light: al3010: read both ALS ADC registers again
config: sh-randconfig-r111-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211105.cR7k7vyR-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 13.4.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211105.cR7k7vyR-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211105.cR7k7vyR-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/al3010.c:129:24: sparse: sparse: cast to restricted __le16

vim +129 drivers/iio/light/al3010.c

   108	
   109	static int al3010_read_raw(struct iio_dev *indio_dev,
   110				   struct iio_chan_spec const *chan, int *val,
   111				   int *val2, long mask)
   112	{
   113		struct al3010_data *data = iio_priv(indio_dev);
   114		int ret, gain;
   115		uint16_t raw;
   116	
   117		switch (mask) {
   118		case IIO_CHAN_INFO_RAW:
   119			/*
   120			 * ALS ADC value is stored in two adjacent registers:
   121			 * - low byte of output is stored at AL3010_REG_DATA_LOW
   122			 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
   123			 */
   124			ret = regmap_bulk_read(data->regmap, AL3010_REG_DATA_LOW,
   125					       &raw, sizeof(raw));
   126			if (ret)
   127				return ret;
   128	
 > 129			*val = le16_to_cpu(raw);
   130	
   131			return IIO_VAL_INT;
   132		case IIO_CHAN_INFO_SCALE:
   133			ret = regmap_read(data->regmap, AL3010_REG_CONFIG, &gain);
   134			if (ret)
   135				return ret;
   136	
   137			gain = FIELD_GET(AL3010_GAIN_MASK, gain);
   138			*val = al3010_scales[gain][0];
   139			*val2 = al3010_scales[gain][1];
   140	
   141			return IIO_VAL_INT_PLUS_MICRO;
   142		}
   143		return -EINVAL;
   144	}
   145	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
