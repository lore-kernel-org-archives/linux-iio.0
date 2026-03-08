Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A345F1531C1;
	Sun,  8 Mar 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773002402; cv=none; b=juJOSUkSCdHd1goIpiUzRBIoNfW3dB2JeYvVabt9oyuURb+r3i6Q/TBGjtZo/B0Qlt8R1oFrVA7RaONQdBaRsWxLcAR1dygcNIVAOw0LG2i+yh68AlRoDsJW2siQlXnBlgbRrKUUu4upFf7clvts/WX9PIXrWuTcXDW6rxYwfYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773002402; c=relaxed/simple;
	bh=jZbOX2F0jIunrTD2MjJUxOMDSxQG60+rvIEQYd6Iyn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYXsvmNIuNOf/kW3HhKiEiqEvtLfI4naypMyLw5jIwVioHtVKg7s/MjggGaXf4vGUhhDrDa0g8/0QpU0BXMNPS3WngheMfiPZY7rkMoMiqcIgOTQGU1nhtEoqd3CCHpV9S/FZwe+t6tzECEqbP6BDxRIpZfEM7GdQRI/UJIOIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ONgeTqX3; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ONgeTqX3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773002401; x=1804538401;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jZbOX2F0jIunrTD2MjJUxOMDSxQG60+rvIEQYd6Iyn0=;
  b=ONgeTqX3/2Xta2cG0RVb2AhL71Bhq/J2pAGmMhfNhY7HOa3NzXnYXkwv
   7uJvR2++W658yj6rgdqSLwF4jE4zTqB+TfWHhb9pIKZlQcZN+XC85uykY
   tTBDtZC3b3mDERB82tym3zpbwMaFfZgUVYwoO0RY8sor/7xr5rBEj7m0+
   ppk40DS0KHgBV0CZrrmPxwY4rY2hRV8Val8PycG1Pvfjgy6oT0pAvPtgX
   svHROYsFTjrHOGE2shQOL1Ow+bY9lqaAk0jLLLIGP88mdoRSMLYpciPQB
   IXrxDaRh47t+SHWwlqKC6sjngxhbHQCM6qX6yuqsbvs7av5xgwTYyt7fU
   Q==;
X-CSE-ConnectionGUID: 4QL7JfswRUSzVuKKBfWOkg==
X-CSE-MsgGUID: aP5lhAp5S4683ThKuXfx9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11723"; a="77632798"
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="77632798"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:40:00 -0700
X-CSE-ConnectionGUID: 4Kyr+68ETBS/6wLFl0kroA==
X-CSE-MsgGUID: jjEMC7jhS6SYTtbKogULrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,109,1770624000"; 
   d="scan'208";a="242580468"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.83])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2026 13:39:58 -0700
Date: Sun, 8 Mar 2026 22:39:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Cc: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: fix unbalanced regulator_disable calls, when
 probe fails
Message-ID: <aa3enGhPrKG7WUUO@ashevche-desk.local>
References: <20260308110328.2859831-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260308110328.2859831-1-andrej.skvortzov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 08, 2026 at 02:03:28PM +0300, Andrey Skvortsov wrote:
> During a probe functions after all regulators are enabled, runtime pm
> is enabled. Before probe function finishes, runtime pm triggers and
> disables vddio regulator. When probe function fails after that,
> inv_mpu_core_disable_regulator_action tries to disable already
> disabled by runtime pm vddio regulator causing following backtrace:
> 
>  inv-mpu6050-i2c 1-0068: trigger probe fail -19
>  ------------[ cut here ]------------

Read Submitting Patches documentation (the section about backtraces
in the commit messages) and act accordingly in the next version.

>  unbalanced disables a for vcc-dsi-sensor
>  WARNING: drivers/regulator/core.c:3244 at _regulator_disable+0x118/0x260, CPU#3: (udev-worker)/357

-- 
With Best Regards,
Andy Shevchenko


