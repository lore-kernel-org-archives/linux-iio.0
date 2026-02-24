Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1A7336EDE;
	Tue, 24 Feb 2026 20:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771963611; cv=none; b=Who11J6sczXjjF3jIExBVvG7GHRVPl7gjRONc6UOlIZvMRsKpJEIFevzNKpk6RYlY4rUrK17IOXEQ4Iru39hvIcsFHpBfMCsiM6xShdAw7hNhRifiI1PrMrTGWY340N0/+fT5DTRJFpvqaV7OsT/0m8rUgVpslzm2qlCn4YGZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771963611; c=relaxed/simple;
	bh=JnvyvrTWhs4gFCNCDWjVlJ4krK6pLc/diQs0NadNI9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOtYW1qLqlPb1GYmp8XBgSEtu19Bb+MOrpgNyAJFxpZKpGRynOFhx7uwwkrmdAShon2R0FLjqhWAjyKOwxemgmp49R1U5UJuL8naS+QIAQKqrvS+/Qojg4/365TvkbKRLIeyenWqGLVit/haacSR4jAzpzkNmtwH37xiSi3dz6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDXmZm3f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDXmZm3f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771963608; x=1803499608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JnvyvrTWhs4gFCNCDWjVlJ4krK6pLc/diQs0NadNI9s=;
  b=NDXmZm3fdxKJ1qYWueWhzOWNsiD/wrQvIstDRkGI1Fdm+FpxlKR/K1Ke
   zrT4glL2JgMaMFT8woucXx5WOu/dJCnRd3s8MqpULLTEP0UZO81CW5FKC
   ePXD8XRhk0JzvQH5gjvgAObzrt+4z2lD7UA0J+Knl+tfhdYJM0OFFOMgE
   N0m7NPA/yiOjkAZ8yum/MKBzWRTjRFNOIWZ6ao3jmLENyU3Oafmeqvff+
   i1b3mR/2wftZ5+GL3VW1ci0Zu0VXeJNQ+rylf5I7xwaJxm1U40gI8iANM
   VW/7CP4VMvi6FkStMEFwVkLFG10gL8gTu+toF/sykR8jLMaDKc/lKISnM
   w==;
X-CSE-ConnectionGUID: 9RdfOZ/ySZKpvn7ZX5q1WA==
X-CSE-MsgGUID: GXdoFIa4T7GF5F7V/zuIEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="84358370"
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="84358370"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 12:06:48 -0800
X-CSE-ConnectionGUID: bK9mMWaGTraCoEuV+coDig==
X-CSE-MsgGUID: MZ747D+jSy2qFNh4LBrWrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,309,1763452800"; 
   d="scan'208";a="214347483"
Received: from lkp-server02.sh.intel.com (HELO a3936d6a266d) ([10.239.97.151])
  by fmviesa007.fm.intel.com with ESMTP; 24 Feb 2026 12:06:44 -0800
Received: from kbuild by a3936d6a266d with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vuyfo-000000002P3-1Mez;
	Tue, 24 Feb 2026 20:06:30 +0000
Date: Wed, 25 Feb 2026 04:05:37 +0800
From: kernel test robot <lkp@intel.com>
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, andy@kernel.org, nuno.sa@analog.com,
	dlechner@baylibre.com, jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 2/3] iio: imu: inv_icm42607: add new inv_icm42607 driver
Message-ID: <202602250331.RTQ00zxY-lkp@intel.com>
References: <20260224163109.370930-3-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224163109.370930-3-macroalpha82@gmail.com>

Hi Chris,

kernel test robot noticed the following build warnings:

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on linus/master v7.0-rc1 next-20260224]
[cannot apply to jic23-iio/togreg]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Chris-Morgan/dt-bindings-iio-imu-icm42607-Add-devicetree-binding/20260225-003610
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
patch link:    https://lore.kernel.org/r/20260224163109.370930-3-macroalpha82%40gmail.com
patch subject: [PATCH 2/3] iio: imu: inv_icm42607: add new inv_icm42607 driver
config: sh-allyesconfig (https://download.01.org/0day-ci/archive/20260225/202602250331.RTQ00zxY-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260225/202602250331.RTQ00zxY-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202602250331.RTQ00zxY-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/iio/imu/inv_icm42607/inv_icm42607_core.c: In function 'inv_icm42607_suspend':
>> drivers/iio/imu/inv_icm42607/inv_icm42607_core.c:670:13: warning: variable 'accel_conf' set but not used [-Wunused-but-set-variable]
     670 |         int accel_conf;
         |             ^~~~~~~~~~
--
>> drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c:200:36: warning: 'inv_icm42607_motion_events' defined but not used [-Wunused-const-variable=]
     200 | static const struct iio_event_spec inv_icm42607_motion_events[] = {
         |                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/accel_conf +670 drivers/iio/imu/inv_icm42607/inv_icm42607_core.c

   660	
   661	/*
   662	 * Suspend saves sensors state and turns everything off.
   663	 * Check first if runtime suspend has not already done the job.
   664	 */
   665	static int inv_icm42607_suspend(struct device *dev)
   666	{
   667		struct inv_icm42607_state *st = dev_get_drvdata(dev);
   668		struct device *accel_dev;
   669		bool wakeup;
 > 670		int accel_conf;
   671		int ret = 0;
   672	
   673		guard(mutex)(&st->lock);
   674	
   675		st->suspended.gyro = st->conf.gyro.mode;
   676		st->suspended.accel = st->conf.accel.mode;
   677		st->suspended.temp = st->conf.temp_en;
   678		if (pm_runtime_suspended(dev))
   679			return 0;
   680	
   681		if (st->fifo.on) {
   682			ret = regmap_write(st->map, INV_ICM42607_REG_FIFO_CONFIG1,
   683					   INV_ICM42607_FIFO_CONFIG1_BYPASS);
   684			if (ret)
   685				return ret;
   686		}
   687	
   688		/* keep chip on and wake-up capable if APEX and wakeup on */
   689		accel_dev = &st->indio_accel->dev;
   690		wakeup = st->apex.on && device_may_wakeup(accel_dev);
   691		if (wakeup) {
   692			/* keep accel on and setup irq for wakeup */
   693			accel_conf = st->conf.accel.mode;
   694			enable_irq_wake(st->irq);
   695			disable_irq(st->irq);
   696		} else {
   697			/* disable APEX features and accel if wakeup disabled */
   698			if (st->apex.wom.enable) {
   699				ret = inv_icm42607_disable_wom(st);
   700				if (ret)
   701					return ret;
   702			}
   703			accel_conf = INV_ICM42607_SENSOR_MODE_OFF;
   704		}
   705	
   706		ret = inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF,
   707						 INV_ICM42607_SENSOR_MODE_OFF, false,
   708						 NULL);
   709		if (ret)
   710			return ret;
   711	
   712		if (!wakeup)
   713			regulator_disable(st->vddio_supply);
   714	
   715		return 0;
   716	}
   717	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
