Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0165456289;
	Thu,  3 Sep 2026 13:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442557; cv=none; b=E7aRR10TdFVNBNkmxu0W6ifStiENnlcNl4y4cf+Z8mP1qhVOkP6WeUlJl+/vSKEKFSQnoGH81c8WpN0uZDnDeZFzxsShvXHcw4KxYWeNpnCJj836jOBq3tyg6JsLasHy3ktpJDkHxHKF1Y0WUwn5vfbyti7vNXJVvIukeiA2iio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442557; c=relaxed/simple;
	bh=rhOffO1bVCcEa1FV3z3bp/CQb48USNZyIWker+Tfp68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VG+1QQDHZNEZ121ma2Pkb1bx9qMwRfQADwCVmUa3B/REV+uRIQsHmSYMjZ9fSi+qKYOPQpv4a4mf0RUYeVzoz8UAB7V9M06L67LN2WS/2HHBKYVJY82GA9L1Xl+/PRafhDlvO0RBQd4QcLTiXPlr6WdNepT1YW5zHc7g1ngqpPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SpSXOLD6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SpSXOLD6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788442551; x=1819978551;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rhOffO1bVCcEa1FV3z3bp/CQb48USNZyIWker+Tfp68=;
  b=SpSXOLD6XSYe65BarXN/4N3EofMLwi3P3CCRQ7ZKySIjBJqo21+nkBE4
   K1OXm3uoQ2Uw8sHwk/mHcZIiDKbVjCWVtp3f49mUbkc1NbgMmot0+zgJH
   byUu69N7P/M26CK80k10aYo+wo8hnnAIf62iSb+ROOoYxYwGMhSNs/YUd
   qkSb88xn/wIin/SPzrmyVJDMQOmmi6H6PJeQY0y+S1LqHm59cd/AV3J3q
   p9iPEXvZy3dXUKtYvmPhjB4uh8gQ9gcHYoW95kmAEVV5fmyaPajEvK0FN
   7HjDR+gjaeWgv8t1ntPnKaLRzaCJyPGZyMGix0f+DwC0vSP/HDblbL6Az
   A==;
X-CSE-ConnectionGUID: eTpgFO8IRueyglfec80BLA==
X-CSE-MsgGUID: iePpGXxsSZKZgs0DYqKzXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11894"; a="88849003"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="88849003"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:35:38 -0700
X-CSE-ConnectionGUID: lA7W566MRomsA8PEJEwP6w==
X-CSE-MsgGUID: koMxRUv8S8Sh9iPrq8A8Bg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="294601955"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.28])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 06:35:37 -0700
Date: Thu, 3 Sep 2026 16:35:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis16400: Check return value of spi_setup()
Message-ID: <apl3pwAZezUgEs0e@ashevche-desk.local>
References: <20260903122733.67109-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903122733.67109-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 03, 2026 at 01:27:33PM +0100, Salah Triki wrote:
> In adis16400_initial_setup(), the return value of spi_setup() was ignored.
> If SPI configuration fails, the driver would proceed with the
> initialization anyway, leading to undefined behavior or silent failures
> during device setup.
> 
> Check the return value of spi_setup() and return the error code immediately
> if it fails.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


