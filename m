Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF4424D59;
	Wed, 26 Aug 2026 14:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787752862; cv=none; b=slNXav1ISAg1hpjeZJ2hnpRpztS07sGYhqNKAkXlkoxP0scqtFowene3wKOV5npDsw/sZBaGKNHNTF5gHCDRBqp3a+C243wma3/w369aARGeJ4SQ23+46ZZXJRWh1h+Pk/RyzNkNagNk1KtIblGZYBeXk6uNxdirTP2y2YNga0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787752862; c=relaxed/simple;
	bh=RmSqYGcCkVZh0oyZgUCy/sFaIbGqOzQ/+nAczFm2m40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJ+45wMwBByOn0FZbBjOREDY00UNdi6IEJWlGeXvr/BP2HADMHBgVqAOY15tDjdaUYBv35jx1mq1aEY9XCV0uPBsC5RwUmzGMCC3wgw4FbwOOrmVWrDyI8639X2R7Fk0awCxW48i3thjG/Tt/mbuOeHJe5TKMl6VShmI+y+r2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OXOI+Tkr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OXOI+Tkr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787752859; x=1819288859;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=RmSqYGcCkVZh0oyZgUCy/sFaIbGqOzQ/+nAczFm2m40=;
  b=OXOI+Tkrop5TP6p8ylmOVVipq0W0nA3IE1MqUfQc6J+gPI0GuWnLfyzC
   u4/PcphJtfXSP7vNQIi2dXof5igfW64zk+BdQDpJWMouvVRyCUpAGTsd/
   HtTKr0UtNY4xq+JlUVDGwCtOxHo21Zwdrw1LzMbfr/CvHio8srjMiuQBY
   nhYSgwp8c/1rtmUK0puAIR/g3HKatT/WijYRm/EMFKAnwbcw7wOLLVvWb
   QLS7y90AkT6fSw0wX9vD04FxY7VC3SY0jUHzz090pnH4UOJA5g2WqdvJB
   tBYmlZhgWCQ9Q0rttBR0ne5IDXXhk6eFA+qxF4WgkSZCfIyo2wmFJjSKz
   Q==;
X-CSE-ConnectionGUID: umeKwYYzSue7rgsxTyhOaQ==
X-CSE-MsgGUID: qlgEkAguTsq2sjbfXHzfjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="91914607"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="91914607"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:00:58 -0700
X-CSE-ConnectionGUID: PZqHYbaNTGi0K81e7sGKjA==
X-CSE-MsgGUID: 8V3AkstvTvmU9rGSF50dOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="267599536"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 07:00:54 -0700
Date: Wed, 26 Aug 2026 17:00:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Yang Zi <2959243019@qq.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, u.kleine-koenig@baylibre.com,
	dakr@kernel.org, o-takashi@sakamocchi.jp, email@sirat.me,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: sx9310: fix NULL pointer dereference in
 sx9310_check_whoami
Message-ID: <ao7xlDTRF8693n5z@ashevche-desk.local>
References: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_1936AF0C31F45000EFB7B38019EFD4A06C07@qq.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 05:18:01PM +0800, Yang Zi wrote:
> device_get_match_data() can return NULL, e.g. when the device is matched
> through the I2C device ID table rather than the OF/ACPI match tables. In
> that case sx9310_check_whoami() dereferences a NULL pointer when reading
> ddata->whoami.
> 
> Return -ENODEV if no match data is found to avoid the NULL pointer
> dereference.

-ENODATA, please.

...

>      ddata = device_get_match_data(dev);
> +    if (!ddata)
> +        return -ENODEV;

+ blank line.

>      if (ddata->whoami != whoami)
>          return -ENODEV;
>  

-- 
With Best Regards,
Andy Shevchenko


