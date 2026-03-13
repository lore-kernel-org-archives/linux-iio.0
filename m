Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8BA37DEB7;
	Fri, 13 Mar 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411029; cv=none; b=cR/LBKS7wQJIl0eT3zBAP20P87g/BCUEm+MMsbxdYeBkn9kduzAT8zbHrRgYU1Z+WdW2VcnehZyckc2fU/1jAGTapSV423q/+vwKqNzSRwlc9N8hu0xXTeV4DrPY7t7kVjiX0ijRlVvtKzXlAq1u0Vs3oizIc7+5QZASq0YMv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411029; c=relaxed/simple;
	bh=TI5YMxA6UVnAAEga3OffZ4CyC/gFnl6pPFrn96v1Hxg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YaLJdIlUYSjuVh4dQLDWHDCa1ZeB91hDwDeGPDL8pVBQDA/uPtrSnbXRhf9uEhhHmfJ2xk1aM8qetkFl9Y060oq//XXG4uNFbNvpfK6w66JrVn3dPqTTzzlSp/EY2rS4iK7H5X9kgQpMEI0aCoVk6nj2fGcpKt3AEPvNAwu6XFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZhdaZvvh; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZhdaZvvh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773411029; x=1804947029;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TI5YMxA6UVnAAEga3OffZ4CyC/gFnl6pPFrn96v1Hxg=;
  b=ZhdaZvvh0EgsUg4t2a36/qXBCK+Bcyg6Y10pfEwOQ+b0Q/ccBr+mydZk
   GIfuFQifsCu6rYpIsYXT2cjpGtfIlKujnNZNG8tNn17lTAJ40a1Ck2/pS
   eChu1CKcUnHPsxKi+GnPS74BHUnwTRKR2qKIJPBNeMQ9L2AkOP0ffmpD4
   AmxiHH5xkxITXoduBKD3vrbz0GFkNW5J6VjDfVFhrMej04ctJ2JpQZUp3
   TsYvAFCP4/LNsyHo96r1n6b1PxJ0GIVGBDqGifhR5mFAtNxxD9ovKYhfb
   GyXen8vNiZnl0WA0K5IRnYoO3tjBvYgBeO3mXovJ49Q54cBimWF1s7dW8
   A==;
X-CSE-ConnectionGUID: fDw+kN5cSmysRRu8ILt0MQ==
X-CSE-MsgGUID: x6Vwkhb9RN2tucvCz9arPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="74486978"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="74486978"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:10:28 -0700
X-CSE-ConnectionGUID: 47mp7NbERfamLNJRKvSA/Q==
X-CSE-MsgGUID: cDOjZ576SJmFbbSXP/jYCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="217178736"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:10:25 -0700
Date: Fri, 13 Mar 2026 16:10:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iio: frequency: ad9523: add dev variable
Message-ID: <abQaz0P4CLpFtFbq@ashevche-desk.local>
References: <cover.1773050333.git.antoniu.miclaus@analog.com>
 <cdb7e229a137c24727bbf201a725f5634a34bfe0.1773050333.git.antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb7e229a137c24727bbf201a725f5634a34bfe0.1773050333.git.antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:57:43PM +0200, Antoniu Miclaus wrote:
> Introduce a local struct device variable in ad9523_probe() to simplify
> subsequent conversions and improve code readability.
> 
> Split pdata declaration and assignment since the result is validated
> immediately after.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


