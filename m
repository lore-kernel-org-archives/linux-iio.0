Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7CE334C08;
	Mon, 20 Apr 2026 17:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776705177; cv=none; b=Fs0nklWwRLZN3PXmQ9lv/RNvBaeNPzIfw9+3dY5Da/Rrj7JCDeEOUOxoU1HEBe1SKU168Tgzed3Qtr7X+zhKcp2uN+VT1m4GxUKvHCeyYJIOaH/YVc862WqJimqKclbVMGsEn8bqPrxXmNhp5Y50mOkSR0wU7cogsVqep5ubD0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776705177; c=relaxed/simple;
	bh=nhrGh3dJagirjQfPINGOHFAqybAs6Q9rz6P8d4R6Ayk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BQvQZOWHjI4PIrgsjH7b7Qejv69eCf62fQ/B1qrszlfbVUdfUUIWL5xih8xLMmC/zgM29PwA1y/tpGeC8btcXac6irow6L/eiJtaUG2dD63UTczJF8l+OVeWd23bJQ9xz5EFDj0BGpVE7oNd4Hdumi5B+0bKMsX9J6QH4OSbz2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BM0UiJ7t; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BM0UiJ7t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776705175; x=1808241175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nhrGh3dJagirjQfPINGOHFAqybAs6Q9rz6P8d4R6Ayk=;
  b=BM0UiJ7tEHFONAd2iJl3fOw208xkqtrq4a07AYiW46BDiHI/yCgQxLrv
   4UxiY9vBRm+WDv+fov+3RS7YnMxXFuTxz+ZAqMsZLqRhYDD1uBKqqDMaQ
   wivUvPQnO5rr8IcLjZdC9JxbGxsNoo6LP/EJMHBgRNVsIgq63AjJ1tROk
   Blh21Y+SV0CvIz/X6QiPdzXb/l0yG2mR0votJNbek/2708tw7JKtwm6nb
   sk1l2TYT0YhWvEangM3Tdaz+cUP8RU0MAKh130W+awD9PZNeUqRs7AasP
   aN1EnE+7JfMw6cDikyeK8K9GHTJMwEaBhEwoSTW9P2nedEekhb0cFv3RM
   Q==;
X-CSE-ConnectionGUID: H4oVleMxSYKE+nBz3HPRVg==
X-CSE-MsgGUID: vAvi3dV/TRiX0FOb+VV6tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11762"; a="77607413"
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="77607413"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:12:55 -0700
X-CSE-ConnectionGUID: EKnreEpARMqcYsPXOWnFwA==
X-CSE-MsgGUID: 3J9AHL8nTDWov/Kh5HwPRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,190,1770624000"; 
   d="scan'208";a="227139963"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.90])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2026 10:12:52 -0700
Date: Mon, 20 Apr 2026 20:12:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kevin Tung <kevin.tung.openbmc@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kevin Tung <Kevin.Tung@quantatw.com>
Subject: Re: [PATCH] iio: adc: rtq6056: add i2c_device_id support
Message-ID: <aeZekWfdcsSkm4SE@ashevche-desk.local>
References: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420-rtq6056_support_sysfs_instantiation-v1-1-483ccee27b63@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 20, 2026 at 08:52:52PM +0800, Kevin Tung wrote:
> Add i2c_device_id table to support legacy I2C instantiation.
> Update probe to use i2c_get_match_data() so device data can be
> retrieved consistently for both OF and legacy I2C instantiation.

Maybe someone finds this useful...
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


