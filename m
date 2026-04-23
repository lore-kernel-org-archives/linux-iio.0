Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254E37B40B;
	Thu, 23 Apr 2026 17:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776966242; cv=none; b=pYCfGu+WVjz4+S/rYq2wOJnBk/9ubpRUK6Rs+mav09PniNo0oGRTT6npfiuXapaQKCT2P6Nre7GYjH3hE3/zQy1LJhlJ40C2snPAWoTw1wVQaNL9oJFhrZs7Yd0ImZNFzMOFzxn+v1UogACu5PhsBI8J7AziOil7fjMqxpJhW1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776966242; c=relaxed/simple;
	bh=ocsNbeFaW0GgirWfhM8Te5nO+LsZcPVWXu2d+81mh9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmUwi4R6LmceW8Rw+CgsS3O/L+w7huHjTDgGALiorYMy2/BI+kYiPw7VmDCKFOC669PyKtjFevK50N1YVbn9veo7IEF6IJ9NOK9LylOu3GXzhREpE6SKdgKrUXNa06TLTeZ4BZiaKccpI/b6ua/aKxfsTO7X/CrUmaSZg1n8PTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P8jAYXYB; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P8jAYXYB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776966241; x=1808502241;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ocsNbeFaW0GgirWfhM8Te5nO+LsZcPVWXu2d+81mh9M=;
  b=P8jAYXYBUouNC4aNSIxCS9TcA805E068Y51cSxKTBa6QEndLxiJdki3q
   mwPjg8bOcI7QL7bTLWo4DKcErxMOYpRmQ4aBTXmdO49nSLT9WKzosTwtO
   cROGT05EnZNz2Mj2YiOV/6seDdwRmGZbDKU1iG+nJzcRIqi29Y4dZoFpU
   s+cXMt6DaSGDn4cktkQc/DPm4AcJAhunxVG2foVhTvXfX48xpUo3KiLPc
   YBXweV7PEz15+3Yl8GkXWbtdlMvteuu6S/dkRJOO+pnVsm5Ryz9eekHAr
   CNV51wnTnKL+p3iHP98KFLZgbkFsNEY7AC3b3HctqHcGLAdH1MoziDNLz
   g==;
X-CSE-ConnectionGUID: MLbMmgTXR2eK6dVjJCuuMw==
X-CSE-MsgGUID: frSRwOOoTlCk00cO/wnAHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81805817"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="81805817"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:44:00 -0700
X-CSE-ConnectionGUID: BLXCJ3D7TLO4o0EVfYBhxw==
X-CSE-MsgGUID: SysfJDlLRoelNomnbzKWwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="228382662"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.163])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 10:43:58 -0700
Date: Thu, 23 Apr 2026 20:43:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC] iio: magnetometer: mlx90393 - regmap vs command-based
 access
Message-ID: <aepaWzVfgRFlau6L@ashevche-desk.local>
References: <20260423121834.4244-1-nikhilgtr@gmail.com>
 <20260423122535.4334-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423122535.4334-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 23, 2026 at 05:55:35PM +0530, Nikhil Gautam wrote:
> 
> Apologies for missing a few details in the previous mail.
> 
> The MLX90393 supports both I2C and SPI interfaces.
> 
> Commands include, for example:
> - SM (Start Measurement)
> - RM (Read Measurement)
> - RR (Read Register)
> 
> Given this command-oriented interface over both I2C and SPI,
> I wanted to confirm whether a custom command abstraction layer
> would still be the preferred approach instead of regmap.

I found only 4 drivers for this vendor in the kernel and they seem
either register based or eeprom based. Perhaps the latter is the
case here? Have you checked existing implementations?

-- 
With Best Regards,
Andy Shevchenko


