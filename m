Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B940A39D6CB;
	Wed, 25 Mar 2026 11:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774439817; cv=none; b=MsHUxvCnDO1F5scXGqBlUegDyr2hYQt9x0NN2dGRxm19mUd0k8tuDkRFkbR6pON3k/LD+fU6AApUwKboqTwG/laa6u1LhW3cYr/z1vyLUlVwSQt6uZmqt5JsvjUJCVjej/AEfco0EyMeooy0hTJlzfBeohcgQTOyhvskfdxRCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774439817; c=relaxed/simple;
	bh=BHhZGitS/rUItvskOPHK6PN1AeIx8msQQmTceNbpkB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lp3g0X6ybsW8CVjgYUxTkaFPFi3H+GLpEFR8GELsSbtIzzW+9dZLrHG1Sw45TMtJx4jXkJ+IQlsjrsMZrbxi7zYHIsTyJapRpVOZGfrs4kJC3HWYC+APriXHbEArm4rtrgXdIjXG8h6aQJ4KQo290fF5JI1h5GD7bz6wMlofYNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZgEP+Bn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZgEP+Bn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774439816; x=1805975816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BHhZGitS/rUItvskOPHK6PN1AeIx8msQQmTceNbpkB0=;
  b=FZgEP+BnfrTyY3RaAyF+GVEq4ZlfAXZRk1IT2IGOT4AuhgW6knzlR/nv
   4S9nr2pEKLDhcTgoYtyrsdC7QujZrO+sk7pIYW7O3hGgeAQVJ+hTOpUTj
   I67btDOqPZIgq4bwynDaaKlyXUzkyum36C6xlzPvdBheKypO10cuSeF+i
   Y1WAHE9+kR5vSi/N7Jvz7AcCxOgfobTZEKpI3TiHfKH4oCYQFdpGUakSa
   NY3Jctf6SjMxELC/RhOhG09n/sIIA7pjJM0CMO2AxWyjgMbUnS3qfny3o
   twJCojXs8Iwt9nERsEhrAG4eWnOdHvCYJROAE0KRWpz64NXX1nxfkPytS
   A==;
X-CSE-ConnectionGUID: Y2U6gBcbSkOxd4gE9Lh4+g==
X-CSE-MsgGUID: nT9+OCeNQCuRFpDVdP1tNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="98094245"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="98094245"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:56:55 -0700
X-CSE-ConnectionGUID: jZZzdwnqRHuJeOLsD5D0Sw==
X-CSE-MsgGUID: 9qE0YL6WTxGOz4NbIKtrdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="218086431"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 04:56:54 -0700
Date: Wed, 25 Mar 2026 13:56:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Milan Misic <twoexem@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Message-ID: <acPNhGlmTJk4pfRG@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260324193626.77231-1-twoexem@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 24, 2026 at 08:36:26PM +0100, Milan Misic wrote:
> The SHIFT13mi or SHIFTbook tablet device by the German manufacturer
> SHIFT contains an STM LSM6DSO IMU declared in the DSDT with the
> hardware ID SMOCF00. Add this ID to the ACPI match table so that the
> driver binds correctly to this device.
> 
> WHO_AM_I register returns 0x6c, confirming LSM6DSO.

Please, for the record also reply with the DSDT excerpt of the device in
question, so we will see how it's defined in ACPI.

-- 
With Best Regards,
Andy Shevchenko


