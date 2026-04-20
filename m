Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797713859FF;
	Mon, 20 Apr 2026 09:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776675904; cv=none; b=l07JB6XjL8vUSsodZYODeCR6uKy+TEvIkxIW0VmX6DRrcZThtrKTcCX75pmpj9AK4U1MiJ7cO7JYGQZ/5KV7/jC9dQyyVkGANBWJlK9EvgWk53bmgTxn7IK/gCVKeD/92HRr1LJJvbBx1g4idn9hfBDgt2yRsnJEYP1G8MGRWU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776675904; c=relaxed/simple;
	bh=29B1jJP8BhlorUv7+Y5pQoeL8Zh8Udruw5oc3TDwfUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ka6QbVM3l7f3tzVouToTtuMZ/UtHEzta6DaFWoOe44+l6JI3xctwsZ4gEdKRbk78D63XfPe8BU6x1rOr/Z87unMj3zt3wt5Pny+KTqyrUlhq9zFqR/vywLuUigWLk6H2+k7zE7ZyAwHC7mTEW6tBM5BXKPyXSqhzgAAJ3RVh2Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LrDa9Cos; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LrDa9Cos"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776675903; x=1808211903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=29B1jJP8BhlorUv7+Y5pQoeL8Zh8Udruw5oc3TDwfUo=;
  b=LrDa9CosFZeBru/zRx6vjFmwB2tOOAkgipRwE/tLvxDkUKyXEHff8boP
   P4foMr2rYwX8n8OWLrcAuIVkTplPLv8NCBgU5jkFExhiFu7DzBmlhxHh5
   7uhgNSvcdUIm2DKY/c8f8RzreQ4dwH0va7MOn2FpMVBmtN8iB4T0OkoIq
   6k9Chxa03WbgeE7nGqFm/ULXkAELkdJ6XIFD8Sd7mAGmE5AhWlwhIunJA
   VI/mhPmdlEADUrW3wlTLLSecllgDGmvZ962c6yqpcRNaZ9RAKIOv5mSJA
   RBNUGCHsD0TsLsxQI7Dw3WfXrRxZw+Xvq2ahmznRWmv7V9Um5zk5RLoOg
   Q==;
X-CSE-ConnectionGUID: ehHvhgDSSmO7/X2eFriX0A==
X-CSE-MsgGUID: y1/c1d9NSlaGzzDCVvYVFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="88660541"
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="88660541"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:05:03 -0700
X-CSE-ConnectionGUID: xaW4I/KfQIm3c092zLMlJA==
X-CSE-MsgGUID: UaDVW5L0QkyDYbDYVvOXtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,189,1770624000"; 
   d="scan'208";a="233437304"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 02:04:59 -0700
Date: Mon, 20 Apr 2026 12:04:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: srf08: replace sprintf with sysfs_emit
Message-ID: <aeXsOU8H_lSKHgB-@ashevche-desk.local>
References: <20260419155806.208741-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419155806.208741-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Apr 19, 2026 at 10:58:06AM -0500, Maxwell Doose wrote:
> This patch replaces sprintf function calls with sysfs_emit and
> sysfs_emit_at. This removes unsafe functions and makes the driver more
> stable and modern, by ensuring that boundary checks take place.

Have you read my other reply?
Please, follow the comments I gave there and update the commit message,
Subject, and the code accordingly.

-- 
With Best Regards,
Andy Shevchenko


