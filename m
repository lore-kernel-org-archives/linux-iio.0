Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EE63A381F;
	Tue, 12 May 2026 20:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616415; cv=none; b=CjyZOV30cCqObqPGvSBTwImaU0PooDXBNBr9V93ZL7xjVpiAIx++CJbZzf0Mf5ivoFWlNeGubImNPQf3EQOz01VnQi8G6eez6zdvU/y8J/siniBmjEp43ZJlohISkoOYnk1YSTy+0FdoQ9vPI08KW384oKAcjPyRdZMWg3OdDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616415; c=relaxed/simple;
	bh=A3BxN281PT5rUnAJb5+V9/2gOQ2KSzOgieKPmyoh/pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAB9p3i2wubhyYVx4DSuiSdklkzq6fGC0JEiS3i6YjY/ShWFpssRaNsjTG5ZooqF7BtVYmYY4fcwcrP2k/ttvu/xzEAkWLPEloIewoFXKy5SnCm/K0qXBTkVPHN6oFjio7qDeW2Y0kCWJteOXty/10C5Gh3SNhD3TO615xjwZKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WdaV4q2M; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WdaV4q2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778616412; x=1810152412;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3BxN281PT5rUnAJb5+V9/2gOQ2KSzOgieKPmyoh/pY=;
  b=WdaV4q2MYN4LqlrrB2sgKnIUsTaGjB912iDVqhvWHbikYGrv2FwPn2wz
   MZNOwJvnfl6tI60HYA54WUguSwzcEJeuCongLKZjeHpD4MGDYS+X33DyL
   TwK3JaKkPmCs9rPybwpuEGe/45ttfW6aKHJIqqfPsAg4PnXBq5IWYig69
   84visHKtOMvGcuzGXQ2cmD2QUHiNqfuCFrLhB0KMToJ4Eg3gMkvptdTqW
   Ylzs9H86OtSzt6U4LU1ksi8zNxH3kJ0gz/zKJNcNVq65xJC2u93nbChuh
   sNzIHOcNkb5yPmWm/zZ35IT97ao3YpUP+q2bdY6JTowLLAPFcuu//ZrWZ
   w==;
X-CSE-ConnectionGUID: 2oMoXoh1RBmtF5mqlQmi1w==
X-CSE-MsgGUID: 8kcDmVj4TcGrZCPyLapVww==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90235339"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90235339"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:06:51 -0700
X-CSE-ConnectionGUID: fB5s0Bl1Q/yFcyCchVcgug==
X-CSE-MsgGUID: Gu9jvxAHRcGaLxis4W+0Zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="231478266"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:06:48 -0700
Date: Tue, 12 May 2026 23:06:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
	krzk+dt@kernel.org, robh@kernel.org,
	Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V5 04/11] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <agOIVqDOr1LsdSi8@ashevche-desk.local>
References: <20260509191907.24734-1-macroalpha82@gmail.com>
 <20260509191907.24734-5-macroalpha82@gmail.com>
 <20260511184715.241be1f1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511184715.241be1f1@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 06:47:15PM +0100, Jonathan Cameron wrote:
> On Sat,  9 May 2026 14:18:58 -0500
> Chris Morgan <macroalpha82@gmail.com> wrote:

...

> > +static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
> > +	{
> > +		.name = "user bank",

> > +		.range_min = 0x0000,

range_min == 0 is a bug for sure. Yet it may work with current regmap
implementation, it has to be fixed. See, for example, this pending patch:
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/ci.git/commit/?h=regmap-warn-range-overlap&id=062bb97410835055036490c96cf77898f90d34ea

> > +		.range_max = 0x00FF,
> > +		.window_start = 0,
> > +		.window_len = 0x0100,

This makes no sense. If you have a page enabled the range max has to be PAGES *
window_len value. This suggests that we have a single page, means no paging is
used. Very confusing.

...

> > +const struct regmap_config inv_icm42607_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.max_register = 0x00FF,
> > +	.ranges = inv_icm42607_regmap_ranges,
> > +	.num_ranges = ARRAY_SIZE(inv_icm42607_regmap_ranges),

> > +	.cache_type = REGCACHE_NONE,

Why no cache?

> > +};

-- 
With Best Regards,
Andy Shevchenko


