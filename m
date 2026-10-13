Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC42F37A83D;
	Tue, 13 Oct 2026 06:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791874101; cv=none; b=R8iAw9tjjP8IvLKEuyyMCLcz6Rrewf3x50wHPqUDmAonGIZKH/KD+2vJx12P21YF/Txi+Th+AevJtWaZPdpcZAEd8TeRQU9KsULsVVixlMgGpPZd7gsyY5bfZtNLrfNNzoau5cCxzKkiPt+kE1jSyrIlf+HFcac8gfEaKfUaFFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791874101; c=relaxed/simple;
	bh=TlOXs4Lxgq/Cj0Jw93YV8G4gkK/yMhf01kSDNvYKG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FaW1MPe09LyUTN4+Ah5Xj6xkOBOXMBNYta5+xtsSsU7ZAcVzSaxhPRk0A7SUe9nFItW9X269CtEKKmI/QeMxhr/twjx708Y5PhDwJEhLNl5a5rhrt6nPJnCQgDvc114vgywK7Kq7x/B/g+Yha3Xghe9TZdcHk2eKw/BU0sRE1EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CkB+X5Ef; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CkB+X5Ef"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791874098; x=1823410098;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TlOXs4Lxgq/Cj0Jw93YV8G4gkK/yMhf01kSDNvYKG6Q=;
  b=CkB+X5EfOMG2m6Gng3kMPp3R/jwk9qtML9/jq98OAawrmmcO0DiB0A6y
   L5w0PwxLYycg1DMUw0r05Hxgyt6KBDKtfTLvNpwhSDtI1ccl8PXmTMUP9
   OsZR2gO8F+FnPaDcCNFB/TPsi2D1mKSbJBga/fx1sO4Aye6hzJkIpehmM
   h4A1RnB8qP9Ji1w7Jv4UsxNPTsd/w5W5pWdIr50lrOoeU1AF6W4+bPMkc
   4kSuQEulXNQkROZb7UgbXanrVSYyNYAv4KseaMKeMghruC1ZVNpChZj3h
   LiZ0swjB5Zma/7qfoDcKHHAs+bt8FjZBzOyTiR8lpCaq7natSwVKS1n9V
   g==;
X-CSE-ConnectionGUID: TXdh7Jg2Sh6iJJlBzxAODQ==
X-CSE-MsgGUID: oeQAiV/gQyG/vJ03u1n/+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="686128"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="686128"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:48:18 -0700
X-CSE-ConnectionGUID: p5hP06jETS2cw3U0feJu3g==
X-CSE-MsgGUID: 1rxr2WtQRWGZNgaXqTkZew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1014797"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 23:48:14 -0700
Date: Tue, 13 Oct 2026 09:48:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/6] iio: imu: inv_icm42607: Initialize gyro based on
 chip_info
Message-ID: <as3UKwy03vG3u9d9@ashevche-desk.local>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
 <20261009-b4-inv_icm42370p-v6-3-e53884f185ff@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-b4-inv_icm42370p-v6-3-e53884f185ff@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 09, 2026 at 04:12:08PM +0200, Kanak Shilledar wrote:
> Update the chip_info struct with a new `has_gyro` property to support,
> devices which do not have gyro functionality. This is a precursor for
> adding support for the Invensense, ICM-42370-P. It is similar to the
> existing device except it only has accelerometer. Check all operations
> related to gyro with the boolean.

...

> static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,

>  	s64 disable_wait;
>  	int ret;
>  
> +	/* Disable gyro if has_gyro is not set */
> +	if (!st->hw->has_gyro)
> +		gyro = INV_ICM42607_SENSOR_MODE_OFF;

This doesn't sound as a good style. Instead, I would see the wrapper that calls
this with different settings depending on the has_gyro:


	if (st->hw->has_gyro)
		return inv_icm42607_set_pwr_mgmt0(st, gyro, accel);

	return inv_icm42607_set_pwr_mgmt0(st, INV_ICM42607_SENSOR_MODE_OFF, accel);

...

Side note.

In this function and maybe somewhere else the all *implicit* checks against 0
has to be made explicit, for instance

	if (!gyro && oldgyro) {

has to be

	if (gyro == INV_ICM42607_SENSOR_MODE_OFF && oldgyro != gyro) {

otherwise the choice of the enum type makes less sense.

...

All the same for the 'accel'.

-- 
With Best Regards,
Andy Shevchenko


