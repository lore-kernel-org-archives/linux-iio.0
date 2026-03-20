Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74352DC791;
	Fri, 20 Mar 2026 16:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774025761; cv=none; b=O9fmaw82fw0zUqoqkAw5SkeozWi74xAT7Ts5nNXUWzOH/IdOIKoorVNa3t0mkuT0LRwj0XBdzm34K1RZG20F/P/WXqffYrO8XMRIKbOkP3H8p5cH+pfVZFCwl3nzUpajV16XOrmw4pNhQCbx2UIZA5gp6l9MBC52m6VycnwFlPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774025761; c=relaxed/simple;
	bh=JOsQO3st7WILZVBsC8f9R41Jc6elrwJYkP5l/BvD1+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gu9pf6ngCDGII4jH85Dd9A5kRAQg3lQs/Or9oeMtrEZGzDd662TXQTUO2FIDmo+bg8+GY3hauIpWmUDagy29yQw2GHZ0v78JD3tjk+1g2Kdha99DDncER9ZSn9bXyrdmNx4ND+oiM6t47UYAoeOcDQMFmTeg/Eoz3Qw+LpqCFbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXfzJLw+; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXfzJLw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774025759; x=1805561759;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JOsQO3st7WILZVBsC8f9R41Jc6elrwJYkP5l/BvD1+0=;
  b=LXfzJLw+DbmoIVkJssuGGca+WTGY9J5tbTUn73fJLyUWc1V09J17TxtD
   CVNBiq4UqEAoxppi4izdBXj7ljDYSfCrUoU2RcPWjJ1PitCuKH2Dl8NZi
   O0qlM/dmnz67SxGgguqRlK3T7NKUO5GugpjQZh2m6RgpXxt/mRdmv47Mi
   zdTXY/ddp7G0rCVFl5sz4xDNholIgwZYusQ+pKdmc/Rm/kwYmwH7Of6w6
   WyMLBdNTNUuIe8hkb/4rD3JRFsNt7kJalXbcFaAjSvus4kAPECdP6zSGV
   HRrUS/PCOkGRF2Nd3HG/O1rVzEY1D0hOP1rcSehmhP+yKFQcDKaMN9MwN
   A==;
X-CSE-ConnectionGUID: n8ZnWW3QT/+L8XxEObOLMA==
X-CSE-MsgGUID: pXJMl3njRDCn5pIS8qiirw==
X-IronPort-AV: E=McAfee;i="6800,10657,11735"; a="86590450"
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="86590450"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2026 09:55:54 -0700
X-CSE-ConnectionGUID: yzTcZ5yzTPSLzbwc1yJQiw==
X-CSE-MsgGUID: HN+kDXFUToSBAd28oBPRcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,130,1770624000"; 
   d="scan'208";a="222569042"
Received: from lkp-server01.sh.intel.com (HELO ba623fe84fe1) ([10.239.97.150])
  by orviesa010.jf.intel.com with ESMTP; 20 Mar 2026 09:55:48 -0700
Received: from kbuild by ba623fe84fe1 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w3d8T-000000000Ar-30MX;
	Fri, 20 Mar 2026 16:55:45 +0000
Date: Sat, 21 Mar 2026 00:55:14 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V2 4/5] iio: imu: inv_icm42600: Add support for icm42607
Message-ID: <202603210032.xLBroWQu-lkp@intel.com>
References: <20260319182956.146976-5-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319182956.146976-5-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v7.0-rc4 next-20260320]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-iio-imu-add-icm42607/20260320-061927
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20260319182956.146976-5-macroalpha82%40gmail.com
patch subject: [PATCH V2 4/5] iio: imu: inv_icm42600: Add support for icm42607
config: i386-randconfig-r134-20260320 (https://download.01.org/0day-ci/archive/20260321/202603210032.xLBroWQu-lkp@intel.com/config)
compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
sparse: v0.6.5-rc1
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260321/202603210032.xLBroWQu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202603210032.xLBroWQu-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/inv_icm42600/inv_icm42600_core.c: In function 'inv_icm42607_hw_suspend':
>> drivers/iio/imu/inv_icm42600/inv_icm42600_core.c:1150:13: warning: variable 'accel_conf' set but not used [-Wunused-but-set-variable]
    1150 |         int accel_conf;
         |             ^~~~~~~~~~
--
>> drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c:108:18: warning: 'inv_icm42607_accel_filter_values' defined but not used [-Wunused-const-variable=]
     108 | static const int inv_icm42607_accel_filter_values[] = {
         |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/accel_conf +1150 drivers/iio/imu/inv_icm42600/inv_icm42600_core.c

  1144	
  1145	static int inv_icm42607_hw_suspend(struct device *dev)
  1146	{
  1147		struct inv_icm42600_state *st = dev_get_drvdata(dev);
  1148		struct device *accel_dev;
  1149		bool wakeup;
> 1150		int accel_conf;
  1151		int ret = 0;
  1152	
  1153		guard(mutex)(&st->lock);
  1154	
  1155		st->suspended.gyro = st->conf.gyro.mode;
  1156		st->suspended.accel = st->conf.accel.mode;
  1157		st->suspended.temp = st->conf.temp_en;
  1158		if (pm_runtime_suspended(dev))
  1159			return 0;
  1160	
  1161		if (st->fifo.on) {
  1162			ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
  1163					   INV_ICM42607_FIFO_CONFIG1_BYPASS);
  1164			if (ret)
  1165				return ret;
  1166		}
  1167	
  1168		/* keep chip on and wake-up capable if APEX and wakeup on */
  1169		accel_dev = &st->indio_accel->dev;
  1170		wakeup = st->apex.on && device_may_wakeup(accel_dev);
  1171		if (wakeup) {
  1172			/* keep accel on and setup irq for wakeup */
  1173			accel_conf = st->conf.accel.mode;
  1174			enable_irq_wake(st->irq);
  1175			disable_irq(st->irq);
  1176		} else {
  1177			/* disable APEX features and accel if wakeup disabled */
  1178			if (st->apex.wom.enable) {
  1179				ret = inv_icm42607_disable_wom(st);
  1180				if (ret)
  1181					return ret;
  1182			}
  1183			accel_conf = INV_ICM42600_SENSOR_MODE_OFF;
  1184		}
  1185	
  1186		ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42600_SENSOR_MODE_OFF,
  1187						 INV_ICM42600_SENSOR_MODE_OFF, false,
  1188						 NULL);
  1189		if (ret)
  1190			return ret;
  1191	
  1192		if (!wakeup)
  1193			regulator_disable(st->vddio_supply);
  1194	
  1195		return 0;
  1196	}
  1197	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
