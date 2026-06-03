Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9C51A6822;
	Wed,  3 Jun 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780448520; cv=none; b=FgS///pNaYaN+le5WCoSIfIV3xfOsOqQPoe/JSM2sPQAT8TrzNDYLk1CUQZP9IDci1yN7dSU9CgVimD/JnyFqknwBeaF7QkpbGnWSNdOHnAveiCGEWwbCpXqElN2BlaClTMXanLq9iqcT7oy/hrmRTUkxkCCMQOiyuV41aBrxNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780448520; c=relaxed/simple;
	bh=BaMuKgQuHOQXQE1823ObJVDq2yz+aYzz4c4+I0oLe44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mX+7p+GxY1NQPBZLSEV2O5sNNhAbbY5PWQkysqSqGxb4UVVFLeyx0qaFsX1udku6nMCfqi2uRnP8qquNNFqqnw9F54Q8vCJhrcJFHaY1urvPA2YJ+uYSpwxCwMgWxAZDgVLOtPob8eI9pdTpc3CpoOLjhn58OFLMGkK+qdCtIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=brejS7K9; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brejS7K9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780448520; x=1811984520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BaMuKgQuHOQXQE1823ObJVDq2yz+aYzz4c4+I0oLe44=;
  b=brejS7K9bQeQPvSJFb6N9tgXnfr1nR/Vri/EWHqH4znfOvgJ+Nay51xE
   IrrMio+9kNyZ/w78Z7ozrtU5k6t46kRX3Gu/XQjuG8p+0biG+4gWQQqwv
   NPDG06miupbSlj5w89Wv6DXVzfaScQBOZe9gAdNmDzNyfioRFTO53dDrQ
   LhgrYfUSHmX8BY3jgv+fWUdRYp5arbVCnBE6Crgj4hN8OI9LTnyNF6C/J
   2+GARNnhanVLAskNhVCWKV+Khi5oaSf7kI69oeh87xwa6xT0fKV7E3c26
   Blo81nR0/K2CoTzmRMndGhKhGsW0hr+o/29vRIBNCKjpneGFS2QXNhLcJ
   A==;
X-CSE-ConnectionGUID: MxdA1AL8Sc+C6wdXY6xEuQ==
X-CSE-MsgGUID: /O4GgRYrQ6K2FQbo4XwMug==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="85133307"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="85133307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:01:59 -0700
X-CSE-ConnectionGUID: sDBKx6rsQYqwMB1Y7lDwgA==
X-CSE-MsgGUID: ZOcy3iQ8SQinMVqfB05u8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249147258"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 18:01:56 -0700
Date: Wed, 3 Jun 2026 04:01:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iio: accel: mma8452: use guard() to release
 mutexes
Message-ID: <ah99Ats9FLVgpjNZ@ashevche-desk.local>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
 <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-5-26d6dff8fc55@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-5-26d6dff8fc55@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 02, 2026 at 06:59:26PM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() and
> scoped_guard() macro for cleaner and safer mutex handling.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


