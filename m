Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8583A1695;
	Thu, 21 May 2026 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779359660; cv=none; b=fdOVI634sUsJREimrktJy6PXM8RCYp39j+yPnbVuE7nbE70U+swA+w7qKjvwlRpNcEbZG60KUK64sbmg/z6WtBRHyRkqTD9pX3h/34KbPn4p1CzIhHajEtWVEMhD43cFyCPPjkwz7Us6zqWS/oR3kEcUO5XBIZivOxif/GsTo4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779359660; c=relaxed/simple;
	bh=/wcFPQ6xwY56biMvbixvgexBzo/UAOwrTYwoAkjU6eQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V74eDF5kkVJTWSA2gQvM/SM3/gzss+z9TqjXc0cFXE1MCAuIBhdLMa6gZ42RU0cv7350S576PG52nLgE/4Zkflokmygqodo1woNNXkuvcd4CT4xnIZ2QSaGbc79yQsUP193BB4yshaM6ws77hRuYCOxqQvtiFjO6ONWTe69KTV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a7dBeZdt; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a7dBeZdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779359657; x=1810895657;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/wcFPQ6xwY56biMvbixvgexBzo/UAOwrTYwoAkjU6eQ=;
  b=a7dBeZdtjRn9D0vXBYFrzsBLgBCL1s6WkZip9HrJ1U6wioaMtTGtp9mL
   Rnx84Ha5jurJqeATIu/3fUp6f4iiqJMAtzyygvs2c9T3vlgOLlYwWt/js
   ISGnvt4KIYl+8aTonisITNxbL5EMblPu9KoSY+9LYzXepP0VFKtFvhm2t
   O/ptwTMLMA1y4UD9P03suVxNwnABh1EWAge/DkbMpOvAfuk3yE2NSBraX
   BkNXeYPFY1qfXVraGNqpSycyKkVxAXP+ujTpauz+J8l5ayYK1PRq6KmO7
   bVsg5R5Cm3ODFLrUd3qxYtVdg7QogQqLfaCp7pUd6B+2765obEYz8dZnP
   g==;
X-CSE-ConnectionGUID: BY12bYU8TqSjcCcINAKy3g==
X-CSE-MsgGUID: ctA02Zv3RnyZxIXQ3uUmFA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80256460"
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="80256460"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 03:34:17 -0700
X-CSE-ConnectionGUID: NK2SNsHDSlSqcNMYQBh7iA==
X-CSE-MsgGUID: MqHpp86PSNmCh79yTFuJ+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,246,1770624000"; 
   d="scan'208";a="270845138"
Received: from lkp-server01.sh.intel.com (HELO fdb68b0ce653) ([10.239.97.150])
  by orviesa002.jf.intel.com with ESMTP; 21 May 2026 03:34:15 -0700
Received: from kbuild by fdb68b0ce653 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wQ0jD-0000000007t-47a4;
	Thu, 21 May 2026 10:34:11 +0000
Date: Thu, 21 May 2026 18:33:44 +0800
From: kernel test robot <lkp@intel.com>
To: "Alexander A. Klimov" <grandmaster@al2klimov.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH] iio: light: al3320a: read both ALS ADC registers again
Message-ID: <202605211815.ZBkYyHp5-lkp@intel.com>
References: <20260521041041.542095-1-grandmaster@al2klimov.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521041041.542095-1-grandmaster@al2klimov.de>

Hi Alexander,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.1-rc4 next-20260520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Alexander-A-Klimov/iio-light-al3320a-read-both-ALS-ADC-registers-again/20260521-121359
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260521041041.542095-1-grandmaster%40al2klimov.de
patch subject: [PATCH] iio: light: al3320a: read both ALS ADC registers again
config: csky-randconfig-r133-20260521 (https://download.01.org/0day-ci/archive/20260521/202605211815.ZBkYyHp5-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 15.2.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260521/202605211815.ZBkYyHp5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202605211815.ZBkYyHp5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/iio/light/al3320a.c:153:24: sparse: sparse: cast to restricted __le16

vim +153 drivers/iio/light/al3320a.c

   132	
   133	static int al3320a_read_raw(struct iio_dev *indio_dev,
   134				    struct iio_chan_spec const *chan, int *val,
   135				    int *val2, long mask)
   136	{
   137		struct al3320a_data *data = iio_priv(indio_dev);
   138		int ret, gain;
   139		uint16_t raw;
   140	
   141		switch (mask) {
   142		case IIO_CHAN_INFO_RAW:
   143			/*
   144			 * ALS ADC value is stored in two adjacent registers:
   145			 * - low byte of output is stored at AL3320A_REG_DATA_LOW
   146			 * - high byte of output is stored at AL3320A_REG_DATA_LOW + 1
   147			 */
   148			ret = regmap_bulk_read(data->regmap, AL3320A_REG_DATA_LOW,
   149					       &raw, sizeof(raw));
   150			if (ret)
   151				return ret;
   152	
 > 153			*val = le16_to_cpu(raw);
   154	
   155			return IIO_VAL_INT;
   156		case IIO_CHAN_INFO_SCALE:
   157			ret = regmap_read(data->regmap, AL3320A_REG_CONFIG_RANGE, &gain);
   158			if (ret)
   159				return ret;
   160	
   161			gain = FIELD_GET(AL3320A_GAIN_MASK, gain);
   162			*val = al3320a_scales[gain][0];
   163			*val2 = al3320a_scales[gain][1];
   164	
   165			return IIO_VAL_INT_PLUS_MICRO;
   166		}
   167		return -EINVAL;
   168	}
   169	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
