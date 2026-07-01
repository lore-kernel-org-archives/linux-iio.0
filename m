Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BE48C3E7;
	Wed,  1 Jul 2026 15:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782920966; cv=none; b=js80X8+DSVSFohOoPX/Hp+UhjpFxu9fujMar+/haopS+9f6lUHeT6NhJt9aV0/tF/0ZJwMVylE2T5IDNJARJS2qB4DEH0mQqROqrHqgxEBzC3jub4U0y7kARFPH3sTVCtyio4hWLgcgxPb7UbaqLvq6Ar6szRD7bIt/uYyox39g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782920966; c=relaxed/simple;
	bh=SDhdOJeQfRLBBdch4f9AnnYErCAOaW7j8D/RgPnxgEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDJSfKSU4A0ede85ZKFQxlBgF8OK2/krjFKJvn7hSapemraRdIhQuN71cUG6eT0UDKatMEksG5ZK0qRmD4IdisQFUwVIZC6HQGfaQEC3k5nACgTt5fjaLeSay8GFDvHOGC1Hv61+hnL9OYihPqoFMv5wqLBokx/LAmYKDQ1ZJRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xwz2w+dX; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xwz2w+dX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782920964; x=1814456964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SDhdOJeQfRLBBdch4f9AnnYErCAOaW7j8D/RgPnxgEw=;
  b=Xwz2w+dXnuVMlH82EMDeHgWclBGmdiUcFwfvzqcOe0Yb1XabS1gFeR4r
   npOUi+kEMKihlfYI4DgK2D4zDqoQMHTxKIE6MKqnveo8b3xWqHlDENz46
   e76NVxxCRwU/pFBI9B0Gz4/m5WiI8MloXT+zqO9+kic4qDwjyd3Jvu1nv
   3ZKrgy8BBaIswNWeJYXDuJfxQymOabTGUHSggjpQpaRh4AWZ4cB2BuW0O
   EKjpuZsAURg7dIzBg34+f22Ri1vT/GP1SD0SThStcAIRqhPqZcrkReDZO
   UanJoQ8Cm+umYkJfCvmwtZNlpsa+8DlWyXbfMMqhPYPmmVY3grXQJVSXX
   g==;
X-CSE-ConnectionGUID: TV7siaQpR/GPQAK2c2mhzA==
X-CSE-MsgGUID: MZoZnuVWTYKakJ41pLKORw==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83532383"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83532383"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:49:18 -0700
X-CSE-ConnectionGUID: E0e4KZvyTGC+V8Sg3WmsHA==
X-CSE-MsgGUID: 8Jzd0g/FR3SNOfEyI6UrOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="246234901"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 08:49:16 -0700
Date: Wed, 1 Jul 2026 18:49:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kittisak Boonmapa <goorock.goopop@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org,
	srinivas.pandruvada@linux.intel.com, sakari.ailus@linux.intel.com,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH] iio: hid-sensors: Fix poll_value sign check before
 msleep_interruptible
Message-ID: <akU2-c370kPmrzX2@ashevche-desk.local>
References: <20260701154319.23497-1-goorock.goopop@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701154319.23497-1-goorock.goopop@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 01, 2026 at 10:43:19PM +0700, Kittisak Boonmapa wrote:
> hid_sensor_read_poll_value() returns -EINVAL when the HID descriptor
> does not contain a Report Interval feature field.
> 
> _hid_sensor_power_state() currently treats any non-zero value as a
> valid delay and passes it to msleep_interruptible(). Since
> msleep_interruptible() takes an unsigned int, negative values are
> converted into very large delays.
> 
> Only sleep when poll_value is positive.

Makes sense.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


