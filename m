Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F2C3090D4;
	Mon, 10 Aug 2026 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388722; cv=none; b=nQREm351jobVcRx/sXaI7oANTm51+ZYW7WCqNcKVgdjKR+cvk+JGNAA0rcbKF9eZ/LN65Utt5ThTGcaI79EtFVPk6K94tPVTsKTTGmc30ILLvit6wUdwt3xZAZd1vP2jrDiCGfRuda846Bfm0r+s8LhwWx6NyPwm8+9m5n+HH+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388722; c=relaxed/simple;
	bh=XY5UUFT2TlhYjiXeoS7JFGPvLcLz9sEhprKQAkhVlSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMZVRL0OoC/mTrC5z1mYYfmgu17wpSrfhZEjbx77hxHBukdCc//GOl7Z4OSE14ROYdCLN4oWXeLYZ9+P98FOYYXMDoxWHmclkFPA3RgipoXQypTZdqGaEWenj+WgV/o2T3KcuAwvYrdveP9bqIXZNQnDpkLpIT9PayE3yRR2aQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C83pAoqv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C83pAoqv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786388721; x=1817924721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XY5UUFT2TlhYjiXeoS7JFGPvLcLz9sEhprKQAkhVlSw=;
  b=C83pAoqvAM9DYr3p/YvYo5jZ+ynzjACdQhx5R2Ggk+CM5Oy5V9JqAmkx
   iUkC5Fjc26uX9KBeHvGCTtbW2UIRSrZuT9fd3UbNrcla1Rw3dGTjOcjFp
   SFJXcc1EoYv6M9Xv57lr+A5JkB3Mc7RI8dlnYxHQJcD7aFtVmELxvMQXi
   InEaAEmuIJQZKZMf6ZwHswn/Y0vkpaVQtUsFpH2YM5Ufj1S+cx2cMbA18
   5gy5k9Are5nXfZ3BmwLoJ1ZUmFypgsq5ujXTJlwRtlw23Y+YQo3bfq+RF
   SA7OjaK0VihwYlbUV9Ve5Dj6L00aFcW5aTNNBsePE88YZopzQoUJvYUeJ
   Q==;
X-CSE-ConnectionGUID: mY3dKZOqTGiCbiUeSm7aJQ==
X-CSE-MsgGUID: L7mNk5J/SS+DZiCMgGeqhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86846544"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86846544"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:05:14 -0700
X-CSE-ConnectionGUID: ZMNFdt1mSfmBbwALAnzaHw==
X-CSE-MsgGUID: 7YpdHooZSy2/i4jdKEjxkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259274059"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 12:05:06 -0700
Date: Mon, 10 Aug 2026 22:05:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Philip Mueller <philm@manjaro.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: imu: bmi270: add BOSC0160 PNP ID for gaming
 handhelds
Message-ID: <anog3cV9JvSxZU0Y@ashevche-desk.local>
References: <20260731195325.44453-1-philm@manjaro.org>
 <20260731195325.44453-4-philm@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731195325.44453-4-philm@manjaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 31, 2026 at 09:53:24PM +0200, Philip Mueller wrote:
> Adding BOSC0160 as PNP ID will enable more gaming
> handhelds using a BMI260 sensor with this PNP ID
> to properly use the bmi270 driver.

...

>  	/* GPD Win Mini, Aya Neo AIR Pro, OXP Mini Pro, etc. */
>  	{ "BMI0160",  (kernel_ulong_t)&bmi260_chip_info },
> +	{ "BOSC0160", (kernel_ulong_t)&bmi260_chip_info },

Keep it ordered by HID.

>  	/* GPD Win Max 2 2023(sincice BIOS v0.40), etc. */
>  	{ "BMI0260",  (kernel_ulong_t)&bmi260_chip_info },

-- 
With Best Regards,
Andy Shevchenko


