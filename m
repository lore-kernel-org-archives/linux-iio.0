Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBAA3B3BF7;
	Mon, 13 Apr 2026 10:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776074942; cv=none; b=rtZPk1cx/OIMSJa2R7ygLgZrJwnyozBDZ+QXOlLrmukuxuPFp+0GL/8NS9ViBl/n6Z3nkkuJ4HNcktKn8YF1NfyRuADmJFFB3i4Hxj6kNB9rAcNE0PPlTzOW+SqXU2b4kp19xz7z2CjKl59Xl4g0Ou/gRWNXIXCY2u/vZx6zx6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776074942; c=relaxed/simple;
	bh=iwYe8eat3GLGXFNbOKn9TvhtSDNPsiFO820XhrBHdf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=csRMWy4tYPGQiAG99eSIZl4mo6sQ6iy0ws/4+V43jJZEIG+tyCLADZQXlpr/96f8odeCX9qzS0cX5NxI5WtwZWSL5EG+b6SbqtAw3dUNOZ67pNx58aNPnl8hzv97E55EW5HDJsoOmTAa+8z36w4vxvsH44wBO3R08xl0oSiDjIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ViMuzud5; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ViMuzud5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776074940; x=1807610940;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iwYe8eat3GLGXFNbOKn9TvhtSDNPsiFO820XhrBHdf0=;
  b=ViMuzud5NAdJHZ1TSIyP+MebVW5zM+AL6WiyIrSGNSJyjIJviEeRML+b
   J2TVFSc299SHczyzjrTKiI6U0rA/7xXS60q0z5RomxKBBo7EBBi/CAW+H
   KBaWBThCDiH108E3ji8sB75OwRq1L4DKi8WdY/hwqzyMhjVkjD4zwqiH1
   OWtz3GMcxnL9NjnxWM1fSgWNInsiB0GPWaF+1GjXWOjGYPPeuWZHEyUVd
   hlrP6SvXfYHGZ4R23vEtG7TDmFDYhsA7pLDuRd2pKwqSebMbfjYzO2glp
   rczB9BDW1y8Byh+NZcN8IRr+aIUCmyJDE3l6qiX85yAo06doGUrzQWDmH
   Q==;
X-CSE-ConnectionGUID: 7sKP/ATBQSKLp0ZPxr4f8w==
X-CSE-MsgGUID: SwjG854IQmib4ys4OEXUmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94395568"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94395568"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:09:00 -0700
X-CSE-ConnectionGUID: sNP26N0VTrG8gQRQdFSkeQ==
X-CSE-MsgGUID: y9UsGGedQK+BI6rnDrDVZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="229616717"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:08:58 -0700
Date: Mon, 13 Apr 2026 13:08:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/6] iio: light: vcnl4000: drop enum id table in favor
 of chip structs
Message-ID: <adzAt-qK5toxz-Jg@ashevche-desk.local>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
 <20260410-vcnl4000-drop-enum-v3-2-2ea2bc6f5dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-2-2ea2bc6f5dfb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 10, 2026 at 07:11:18PM +0300, Erikas Bitovtas wrote:
> Instead of creating an enum table with chip IDs, store pointers to
> structs directly. This drops the association between chip structs and
> enum IDs and allows for easier addition or removal of new devices.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


