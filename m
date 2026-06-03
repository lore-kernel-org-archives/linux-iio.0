Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D7A29D26C;
	Wed,  3 Jun 2026 01:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448549; cv=none; b=DxbkHH4sq3o0Mar0+c1kw8jUKR1J7coJ2Glh7l2ORZ8HEKgII4SSY/2pgADa5WctT9uw0Jq3gkiW9wae6DQQMFc0GCe30ugHjuktO4GfjbujpyEoJNJWFD4Qn7GhtP97T9odlbB4WHu8kdAq40UuyjYeS6BEsu/F11fh1JL8cG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448549; c=relaxed/simple;
	bh=gaL5LnqdqltFiFL1hYew/94+ObchGLz/u8EMfG3sPxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aIT7tm8YFrtHheya6SbuOuOlMAtxssWwfqjYy4RhHNWxWELy3AWR3RkNLbJQ4IChEtBGS2SqjndB4VQ8itUEmRBlnF9Qddk4K/7g4AgxWZXCRzaMakcANwt4YwzaXw5rFUwN0DkCxcQgGCXfU2ASM2VQSryQHwp/qY1UsUrDvkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zi/yA2mk; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zi/yA2mk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448549; x=1811984549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gaL5LnqdqltFiFL1hYew/94+ObchGLz/u8EMfG3sPxw=;
  b=Zi/yA2mkebC0ElHDsXuke+5OqMhr5y1PmzsF+FqnL1G4dji9Q3flATRD
   ydNvyDTBQqDvtVCTdEJ825IWEVCQCR8k2GX9WnApPhF9yhL+fvQkyedTu
   Bq3PJpTzHjhoVZN9OmgQyXbeWvY15orb52k0LzHJFqGJs4g1utvYrnDYE
   l84XUXQg3aLe+WMFvEfXtO3mgf7xCUyvmX6vAVv3HyzOuP9xv+8Xmzpbf
   OilZCIlczztz/AGhFHXMztbJddLv4iUhwrw3MSGddD/kzqnNm6i5QmLa2
   1+AxQpWjgeRYl9AqJu15JMw6K2NJc7tpEIA/Jxf4WNZhWUXI0o4CWCDcx
   g==;
X-CSE-ConnectionGUID: 8E4EsWA4SjOssrEg/NufNA==
X-CSE-MsgGUID: MnkG5ZvETTaIauODNcZthA==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85133342"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="85133342"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:02:28 -0700
X-CSE-ConnectionGUID: EgYEW5ubQB2roj0qISK0eQ==
X-CSE-MsgGUID: YopRD5ynTMOx1AmPvfgdug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249147312"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:02:25 -0700
Date: Wed, 3 Jun 2026 04:02:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/5] iio: accel: mma8452: Use IIO cleanup helpers
Message-ID: <ah99H-abnmoHRQQk@ashevche-desk.local>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
 <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-4-26d6dff8fc55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-4-26d6dff8fc55@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 06:59:25PM +0530, Sanjay Chitroda wrote:

> Use IIO_DEV_ACQUIRE_DIRECT_MODE() helper to automatically release
> direct mode.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


