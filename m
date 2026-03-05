Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B195F1531E8;
	Thu,  5 Mar 2026 00:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772671616; cv=none; b=Guyamx8R2X5DD/mnS/qyZ7Gdq+VOf0iqKq23ZmKLjvm6oTwjNq0+pccheTmw6xQTXzfwdwLzreWb1ohRIAEAkYNxm23fmUV54FCN7umUXBZDic8ETV77PVy4G818coVpBId9xuH3n2aU4rqnKNqnoPgMgjyzSdyTH9014DJciuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772671616; c=relaxed/simple;
	bh=fXCeegBbIUBRm4xFMMFUFNRIomWhKFiBfNiUiz7gdzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3NDLdARBUbFuxsOKaOwbRYdl6J6DkKHl0ImbhosgFBo5Yr3z+sINz0alrQUQCoCSR+cPQir3L8as+tqlg+AaWzmEbSYTaIzLdl+dWb+m+W08kH5e8YfM+KO2efB2rAXoiYEOiSySefW4Ryjn+gkvM3cR3xo2yAWlB+1IfnbT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1ri/jRI; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1ri/jRI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772671614; x=1804207614;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXCeegBbIUBRm4xFMMFUFNRIomWhKFiBfNiUiz7gdzg=;
  b=e1ri/jRIqiT36an26Fvx45w+1lHQO1Nk07O7fpfU0WTPacTK9Cs3rSRk
   54TQ82bhT8Dipes7OTcSsHUyhLh3/KUqkyPASMSC0YKVY4MLGQ9HtzemP
   zVPmKPVlRFyxSOl+GswH2KX0hSNgAZrzSjh98Y7n9yKl7lAV7xohACG6z
   kuH7jGuJuJQEVWtTMkIxEVcPmCH4hVOs4/FTlYEwCJE7M4AqRjoQo1Qzl
   D42iJHmd/oPoyFVA6uaJWRr3nWEp9kSwBtB4petnByCHWlwW5MY25UEhL
   dDXZrVU05aPoAjb4jUwxtxpSfW644/Ugn+5fl4+gQDirZ9qmMpPmXpH9r
   w==;
X-CSE-ConnectionGUID: 1wwsarzRRrWV6HZrUOyzXQ==
X-CSE-MsgGUID: hdmn3Kl9TdqNuviSgOlCgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="85219034"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="85219034"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 16:46:54 -0800
X-CSE-ConnectionGUID: AKS7JEquSCG86Vtn73DOfg==
X-CSE-MsgGUID: dB0MQpefRNiAD3gv34EaWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="241519934"
Received: from lkp-server01.sh.intel.com (HELO f27a57aa7a36) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 04 Mar 2026 16:46:52 -0800
Received: from kbuild by f27a57aa7a36 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vxwrZ-000000004s9-2XlC;
	Thu, 05 Mar 2026 00:46:49 +0000
Date: Thu, 5 Mar 2026 08:45:56 +0800
From: kernel test robot <lkp@intel.com>
To: John Erasmus Mari Geronimo <johnerasmusmari.geronimo@analog.com>,
	linux-iio@vger.kernel.org, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: temperature: add support for Analog Devices
 MAX30210
Message-ID: <202603050822.weVzrjhU-lkp@intel.com>
References: <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304122509.67931-3-johnerasmusmari.geronimo@analog.com>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on 70a9ae59c5b1f2f5501e78e2d85bfeefd153f854]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Erasmus-Mari-Geronimo/dt-bindings-iio-temperature-add-ADI-MAX30210/20260304-202920
base:   70a9ae59c5b1f2f5501e78e2d85bfeefd153f854
patch link:    https://lore.kernel.org/r/20260304122509.67931-3-johnerasmusmari.geronimo%40analog.com
patch subject: [PATCH v2 2/2] iio: temperature: add support for Analog Devices MAX30210
config: i386-randconfig-r071-20260305 (https://download.01.org/0day-ci/archive/20260305/202603050822.weVzrjhU-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
smatch: v0.5.0-9004-gb810ac53
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260305/202603050822.weVzrjhU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603050822.weVzrjhU-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/iio/temperature/max30210.c: In function 'max30210_fifo_read':
>> drivers/iio/temperature/max30210.c:136:27: error: implicit declaration of function 'get_unaligned_be24' [-Wimplicit-function-declaration]
     136 |                 u32 raw = get_unaligned_be24(&st->fifo_buf[3 * i]);
         |                           ^~~~~~~~~~~~~~~~~~
   drivers/iio/temperature/max30210.c: In function 'max30210_read_event_config':
>> drivers/iio/temperature/max30210.c:272:32: error: implicit declaration of function 'FIELD_GET' [-Wimplicit-function-declaration]
     272 |                         return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
         |                                ^~~~~~~~~
   drivers/iio/temperature/max30210.c: In function 'max30210_write_raw':
>> drivers/iio/temperature/max30210.c:418:49: error: implicit declaration of function 'FIELD_PREP' [-Wimplicit-function-declaration]
     418 |                                                 FIELD_PREP(MAX30210_TEMPCONF2_TEMP_PERIOD_MASK, i));
         |                                                 ^~~~~~~~~~


vim +/get_unaligned_be24 +136 drivers/iio/temperature/max30210.c

   122	
   123	static void max30210_fifo_read(struct iio_dev *indio_dev)
   124	{
   125		struct max30210_state *st = iio_priv(indio_dev);
   126		int ret;
   127	
   128		ret = regmap_bulk_read(st->regmap, MAX30210_FIFO_DATA_REG,
   129				       st->fifo_buf, 3 * st->watermark);
   130		if (ret) {
   131			dev_err(&indio_dev->dev, "Failed to read from fifo.\n");
   132			return;
   133		}
   134	
   135		for (unsigned int i = 0; i < st->watermark; i++) {
 > 136			u32 raw = get_unaligned_be24(&st->fifo_buf[3 * i]);
   137	
   138			if (raw == MAX30210_FIFO_INVAL_DATA) {
   139				dev_err_ratelimited(&indio_dev->dev, "Invalid data\n");
   140				continue;
   141			}
   142	
   143			s16 temp = (s16)(raw & 0xFFFF);
   144	
   145			iio_push_to_buffers(indio_dev, &temp);
   146		}
   147	}
   148	
   149	static irqreturn_t max30210_irq_handler(int irq, void *dev_id)
   150	{
   151		struct iio_dev *indio_dev = dev_id;
   152		struct max30210_state *st = iio_priv(indio_dev);
   153		unsigned int status;
   154		int ret;
   155	
   156		ret = regmap_read(st->regmap, MAX30210_STATUS_REG, &status);
   157		if (ret) {
   158			dev_err(&indio_dev->dev, "Status read failed\n");
   159			return IRQ_NONE;
   160		}
   161	
   162		if (status & MAX30210_STATUS_A_FULL_MASK)
   163			max30210_fifo_read(indio_dev);
   164	
   165		if (status & MAX30210_STATUS_TEMP_HI_MASK)
   166			iio_push_event(indio_dev,
   167				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
   168							    IIO_EV_TYPE_THRESH,
   169							    IIO_EV_DIR_RISING),
   170				       iio_get_time_ns(indio_dev));
   171	
   172		if (status & MAX30210_STATUS_TEMP_LO_MASK)
   173			iio_push_event(indio_dev,
   174				       IIO_UNMOD_EVENT_CODE(IIO_TEMP, 0,
   175							    IIO_EV_TYPE_THRESH,
   176							    IIO_EV_DIR_FALLING),
   177				       iio_get_time_ns(indio_dev));
   178	
   179		return IRQ_HANDLED;
   180	}
   181	
   182	static int max30210_reg_access(struct iio_dev *indio_dev, unsigned int reg,
   183				       unsigned int writeval, unsigned int *readval)
   184	{
   185		struct max30210_state *st = iio_priv(indio_dev);
   186	
   187		if (!readval)
   188			return regmap_write(st->regmap, reg, writeval);
   189	
   190		return regmap_read(st->regmap, reg, readval);
   191	}
   192	
   193	static int max30210_read_event(struct iio_dev *indio_dev,
   194				       const struct iio_chan_spec *chan,
   195				       enum iio_event_type type,
   196				       enum iio_event_direction dir,
   197				       enum iio_event_info info, int *val, int *val2)
   198	{
   199		struct max30210_state *st = iio_priv(indio_dev);
   200	
   201		if (info != IIO_EV_INFO_VALUE)
   202			return -EINVAL;
   203	
   204		switch (dir) {
   205		case IIO_EV_DIR_RISING:
   206			switch (type) {
   207			case IIO_EV_TYPE_THRESH:
   208				return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
   209			default:
   210				return -EINVAL;
   211			}
   212		case IIO_EV_DIR_FALLING:
   213			switch (type) {
   214			case IIO_EV_TYPE_THRESH:
   215				return max30210_read_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
   216			default:
   217				return -EINVAL;
   218			}
   219		default:
   220			return -EINVAL;
   221		}
   222	}
   223	
   224	static int max30210_write_event(struct iio_dev *indio_dev,
   225					const struct iio_chan_spec *chan,
   226					enum iio_event_type type,
   227					enum iio_event_direction dir,
   228					enum iio_event_info info, int val, int val2)
   229	{
   230		struct max30210_state *st = iio_priv(indio_dev);
   231	
   232		if (info != IIO_EV_INFO_VALUE)
   233			return -EINVAL;
   234	
   235		switch (dir) {
   236		case IIO_EV_DIR_RISING:
   237			switch (type) {
   238			case IIO_EV_TYPE_THRESH:
   239				return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_HI_REG, val);
   240			default:
   241				return -EINVAL;
   242			}
   243		case IIO_EV_DIR_FALLING:
   244			switch (type) {
   245			case IIO_EV_TYPE_THRESH:
   246				return max30210_write_temp(st->regmap, MAX30210_TEMP_ALM_LO_REG, val);
   247			default:
   248				return -EINVAL;
   249			}
   250		default:
   251			return -EINVAL;
   252		}
   253	}
   254	
   255	static int max30210_read_event_config(struct iio_dev *indio_dev,
   256					      const struct iio_chan_spec *chan,
   257					      enum iio_event_type type,
   258					      enum iio_event_direction dir)
   259	{
   260		struct max30210_state *st = iio_priv(indio_dev);
   261		unsigned int val;
   262		int ret;
   263	
   264		ret = regmap_read(st->regmap, MAX30210_INT_EN_REG, &val);
   265		if (ret)
   266			return ret;
   267	
   268		switch (dir) {
   269		case IIO_EV_DIR_RISING:
   270			switch (type) {
   271			case IIO_EV_TYPE_THRESH:
 > 272				return FIELD_GET(MAX30210_STATUS_TEMP_HI_MASK, val);
   273			default:
   274				return -EINVAL;
   275			}
   276		case IIO_EV_DIR_FALLING:
   277			switch (type) {
   278			case IIO_EV_TYPE_THRESH:
   279				return FIELD_GET(MAX30210_STATUS_TEMP_LO_MASK, val);
   280			default:
   281				return -EINVAL;
   282			}
   283		default:
   284			return -EINVAL;
   285		}
   286	}
   287	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
