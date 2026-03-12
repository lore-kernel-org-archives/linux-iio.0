Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF082ED17B;
	Thu, 12 Mar 2026 10:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773311631; cv=none; b=foRe2q84v67MpQDACchQCVRnlzhbsyzQafFPsolE2ycJYGJgMNIObnimGgk2yyM6jxmPjEdMet9re8HPRWb5A49wA/NAaZZOLwJwbQZZ42diE7/bbZeO0ojEGqZCGbqAOxlkeis1ZeRbQE68+LTRWXbujjQkAS2o3BUwxfAY/Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773311631; c=relaxed/simple;
	bh=3KpvAXpeJPWsqPRCeJHW5Vw6LfZFOwJwVnd5HxIyanI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh6/zLMN7wai2gOKSXodEjbHZcxlXCMFXPEhR5j8YaZsVzrKZNuefPvQoN4MmVDTTkhKhWpvuuZ+c0ybcxtNqDhJa3UyL4fa0V4al2XbPS/x6SUAmBMqmJE3opH1VlnoLZFey+W6kQVTO/DXBYY4Qk/izUUOV7YuUmNJbuOsQVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EZ4BgFm5; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EZ4BgFm5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773311630; x=1804847630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3KpvAXpeJPWsqPRCeJHW5Vw6LfZFOwJwVnd5HxIyanI=;
  b=EZ4BgFm5LYof/NnKowkD53TbXTm/gyFyF328+ZofSRm/8JkJjJAhG+PC
   1sxINPrPPgc3p3ZvIuGJyuM+YCjkCEmMkXwfo3FqtFclL3+P9kF6Rqzjp
   vnOIIxl4oX69hgllJZMvow2RzToVApj2noMxGIHGUoPzh98KpnvV/dylU
   dpiVubSDOzwMk5q4F8bFwGtMF2ijPBm9VlkcotJO7AvMLfvO5xGsMBNvL
   DR0Nw48DHpBKjF/GFVC4uJjkr25VgJ4xb6scCDm8sQadW+pWH0TebV3Nh
   6vEoZCbI8X/cojlmon2iZdalyR0NDGnVGE4IFvvNbxLpbJ2Egnn6y90k8
   g==;
X-CSE-ConnectionGUID: 5ryLe5ciRaWTpm8B7nTVRg==
X-CSE-MsgGUID: JjCo7mOHRdaJBlnSUVcRJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11726"; a="85875262"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85875262"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:33:49 -0700
X-CSE-ConnectionGUID: jGEwWJIHTIu3URx9PPU2WQ==
X-CSE-MsgGUID: 2p8/WmRSR7y3c2VTu7wO1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="220976616"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 03:33:47 -0700
Date: Thu, 12 Mar 2026 12:33:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: st_sensors: correct kernel-doc issues
Message-ID: <abKWh4ACsYzTI9fr@ashevche-desk.local>
References: <20260312051347.681042-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312051347.681042-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 11, 2026 at 10:13:45PM -0700, Randy Dunlap wrote:
> Use the proper kernel-doc format and struct member names to avoid
> kernel-doc warnings:
> 
> Warning: include/linux/iio/common/st_sensors.h:184 struct member 'int1'
>  not described in 'st_sensor_data_ready_irq'
> Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'int2'
>  not described in 'st_sensor_data_ready_irq'
> Warning: ../include/linux/iio/common/st_sensors.h:184 struct member
>  'stat_drdy' not described in 'st_sensor_data_ready_irq'
> Warning: ../include/linux/iio/common/st_sensors.h:184 struct member 'ig1'
>  not described in 'st_sensor_data_ready_irq'
> Warning: ../include/linux/iio/common/st_sensors.h:219 struct member
>  'num_ch' not described in 'st_sensor_settings'
> Warning: ../include/linux/iio/common/st_sensors.h:263 struct member
>  'num_data_channels' not described in 'st_sensor_data'

Thanks, it's a good patch for this driver!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


