Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B233E0C73;
	Thu, 16 Apr 2026 15:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353651; cv=none; b=NHSdLdjDscvIETF4ePQJuP4LV4iUysKOPmVCHjrZUMsUT3jElHQh0Wax2sjXdRsbejQ+7Fiu4nBwDp9bNQR7KuuPxKiHU/7VnWIXpDkhYQH8FohwttpDO4CfNQ1SQNMx+5m/lVFBI+Jo7WsMr1HN4Hxh+L6Qn0m0M0CCWgX5un0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353651; c=relaxed/simple;
	bh=bKhpoctZ+cnz2//l4tn7baT/QuY1alwN7dsWjpTbWeM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lx0228lSAgbY4BFtnWRX1BUxZxnuCJRFJ0TxguNJW8t1Ds8WbY8EomzoypLK2iY2hVslEGXjs/x3UmhB2F0EF6e2V0x6HXBItznOIHHbVvV5azEJpVzebVSEmWrZgnDgi34+rbmFpgDZyV7arxi1wynvffPrXEG6fGwnhK6l5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BngMx7wn; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BngMx7wn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776353640; x=1807889640;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bKhpoctZ+cnz2//l4tn7baT/QuY1alwN7dsWjpTbWeM=;
  b=BngMx7wn8LsVSBYmOgn+5egCkl9uqdoqdR/Co3YqeInSQpy0PvTe95wo
   cnGVrEdo/PWN4e1TWUJgwlVJRKqVGtx8b+IbmgVaMcqPxE5UjoHUCBRX1
   GrgwIM/HplL27ch9UY3TdtHr2sAZuVofkApLt5W64vRqojiYYqk9mj9Gr
   W6ZoTee9uC1aBVA0ap4X0C3EXgS22YZ01z/7GbpQcr5JNPZ0Z65jnD79k
   juH4z8FwN3/2C1KQqfVg0jXQilnGnuDgyXYK0iEc8PhJkv86ogctxilYP
   Hm8DUAGlORofALhcaW1gLLEdt99cB5hRCnGE87nVGCtKq7mvzoHMGlr08
   g==;
X-CSE-ConnectionGUID: +gGudi58TGa6kfBaX5rg7Q==
X-CSE-MsgGUID: eBdKcK4tToa9DmIfXXm7Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="88741639"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="88741639"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 08:33:59 -0700
X-CSE-ConnectionGUID: KfJxxmkZQKqQPhX/9mCByw==
X-CSE-MsgGUID: G4D8kRuKSP+TDijrmDZrdQ==
X-ExtLoop1: 1
Received: from lkp-server01.sh.intel.com (HELO 7f3b36e5d6a5) ([10.239.97.150])
  by fmviesa003.fm.intel.com with ESMTP; 16 Apr 2026 08:33:57 -0700
Received: from kbuild by 7f3b36e5d6a5 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1wDOj4-000000001hK-3glL;
	Thu, 16 Apr 2026 15:33:54 +0000
Date: Thu, 16 Apr 2026 23:33:35 +0800
From: kernel test robot <lkp@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org
Cc: oe-kbuild-all@lists.linux.dev, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Message-ID: <202604162323.4pYsEj7A-lkp@intel.com>
References: <20260414192045.3598010-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414192045.3598010-1-sanjayembedded@gmail.com>

Hi Sanjay,

kernel test robot noticed the following build warnings:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v7.0 next-20260415]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Sanjay-Chitroda/iio-accel-mma8452-use-pm_ptr-for-dev_pm_ops/20260416-061819
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
patch link:    https://lore.kernel.org/r/20260414192045.3598010-1-sanjayembedded%40gmail.com
patch subject: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20260416/202604162323.4pYsEj7A-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260416/202604162323.4pYsEj7A-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604162323.4pYsEj7A-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/iio/accel/mma8452.c:1776:12: warning: 'mma8452_runtime_resume' defined but not used [-Wunused-function]
    1776 | static int mma8452_runtime_resume(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/iio/accel/mma8452.c:1747:12: warning: 'mma8452_runtime_suspend' defined but not used [-Wunused-function]
    1747 | static int mma8452_runtime_suspend(struct device *dev)
         |            ^~~~~~~~~~~~~~~~~~~~~~~


vim +/mma8452_runtime_resume +1776 drivers/iio/accel/mma8452.c

c7eeea93ac60ab Peter Meerwald    2014-02-05  1746  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03 @1747  static int mma8452_runtime_suspend(struct device *dev)
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1748  {
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1749  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1750  	struct mma8452_data *data = iio_priv(indio_dev);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1751  	int ret;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1752  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1753  	mutex_lock(&data->lock);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1754  	ret = mma8452_standby(data);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1755  	mutex_unlock(&data->lock);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1756  	if (ret < 0) {
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1757  		dev_err(&data->client->dev, "powering off device failed\n");
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1758  		return -EAGAIN;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1759  	}
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1760  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1761  	ret = regulator_disable(data->vddio_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1762  	if (ret) {
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1763  		dev_err(dev, "failed to disable VDDIO regulator\n");
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1764  		return ret;
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1765  	}
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1766  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1767  	ret = regulator_disable(data->vdd_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1768  	if (ret) {
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1769  		dev_err(dev, "failed to disable VDD regulator\n");
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1770  		return ret;
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1771  	}
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1772  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1773  	return 0;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1774  }
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1775  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03 @1776  static int mma8452_runtime_resume(struct device *dev)
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1777  {
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1778  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1779  	struct mma8452_data *data = iio_priv(indio_dev);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1780  	int ret, sleep_val;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1781  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1782  	ret = regulator_enable(data->vdd_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1783  	if (ret) {
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1784  		dev_err(dev, "failed to enable VDD regulator\n");
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1785  		return ret;
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1786  	}
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1787  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1788  	ret = regulator_enable(data->vddio_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1789  	if (ret) {
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1790  		dev_err(dev, "failed to enable VDDIO regulator\n");
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1791  		regulator_disable(data->vdd_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1792  		return ret;
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1793  	}
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1794  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1795  	ret = mma8452_active(data);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1796  	if (ret < 0)
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1797  		goto runtime_resume_failed;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1798  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1799  	ret = mma8452_get_odr_index(data);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1800  	sleep_val = 1000 / mma8452_samp_freq[ret][0];
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1801  	if (sleep_val < 20)
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1802  		usleep_range(sleep_val * 1000, 20000);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1803  	else
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1804  		msleep_interruptible(sleep_val);
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1805  
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1806  	return 0;
96c0cb2bbfe0a5 Martin Kepplinger 2016-03-03  1807  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1808  runtime_resume_failed:
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1809  	regulator_disable(data->vddio_reg);
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1810  	regulator_disable(data->vdd_reg);
c7eeea93ac60ab Peter Meerwald    2014-02-05  1811  
f6ff49b8a3b6f7 Anson Huang       2019-01-08  1812  	return ret;
c7eeea93ac60ab Peter Meerwald    2014-02-05  1813  }
c7eeea93ac60ab Peter Meerwald    2014-02-05  1814  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
