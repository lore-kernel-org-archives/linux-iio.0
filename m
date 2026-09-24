Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FEF33F58B;
	Thu, 24 Sep 2026 14:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259682; cv=none; b=meOz5dV/sWwN0Yfssy7udTz+sELM54VltmsJPIbbLc0gUAauEU5SbE1Otemc95gUZbfZ98Oj32aQvm8g1Oa1ywl1Vn1A3WleV+IGXkznNVYcnQTRFwoO3Tn9r8O0Laf3B6rJwRNs4OR5n/J747jV0V+sWUDaZDZcu07lT32bfsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259682; c=relaxed/simple;
	bh=N6srY4tvep9PzCj7VVWtMGXcgA0WZ4BmNejD5Y2NvlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GQY/vrZvoH0Tdn7xwMqXTJ2mAZZTRda8GiR1PhSePlnP/YLg0mC5JYRzpXtM89D98VpqXXU7KyJAeC8QXXC67gVeetMGXVltEnpnM9Z2LOLMuG422MPkH7WbLe5ibV3Kh0oFGNds0Mhc0MkHXJjG+ANELlOaHW04+H/bwLP6elc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hGKA4T90; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGKA4T90"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790259679; x=1821795679;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N6srY4tvep9PzCj7VVWtMGXcgA0WZ4BmNejD5Y2NvlU=;
  b=hGKA4T90Y0OiWTaQcVHGmLXtJFyd1jknSqr8Dus/RvIfRCxEQTL/taX6
   YAxGUZir4kuoxv3nu+B+KoCaJO9JAkUzGMWSoUkySoZFnWRJDtdzpuumw
   M07AM+fxbpNEQsrc1J9quXMgB+FTc7biOVcmyKculABDinrMhkyDOXkcr
   4clmV4YwfuldkvSfV9evLzR+SBzTbiwhf7NZYHn2MDPG71mJRrV9K/Kv6
   o9UU2ekfiMoJuj0W7oyI28EjG2NmEAARH4CGkgruC7Slz+HBjtEA+nqp1
   uqS3NjUI2N8lnQDIrFJX8U0V6nv6A3rh/zMNNzSkfBVkX6ya+JrErOgGP
   A==;
X-CSE-ConnectionGUID: vw0HE0vdRhyKIw2U6d2McQ==
X-CSE-MsgGUID: QeTXgOkPSVi17rhEv4yHfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="108526079"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="108526079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:21:19 -0700
X-CSE-ConnectionGUID: BTmVa5GqQ6GTPSvZqY2qPw==
X-CSE-MsgGUID: Stit2HCYQbibEfdyMATYOA==
X-ExtLoop1: 1
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.199])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 07:21:16 -0700
Date: Thu, 24 Sep 2026 17:21:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Gustavo Silva <gustavograzs@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: chemical: ens160: use regmap_assign_bits() for
 conditional set/clear
Message-ID: <arUx2r3swu5512Bd@ashevche-desk.local>
References: <20260924083527.461864-1-peng.fan@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924083527.461864-1-peng.fan@oss.nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 24, 2026 at 04:35:26PM +0800, Peng Fan (OSS) wrote:

> Replace if/else block using regmap_set_bits()/regmap_clear_bits() with
> the simpler regmap_assign_bits() call.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


