Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06F18B0F;
	Sun, 10 May 2026 18:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778436571; cv=none; b=Un7NkELQYDY7dRi0XXwGM3OeLle+oCjMBVe2uSLdmIT0SYM3p4DCsw92IlKjKalcqX2VsUepVOtfeUm8RExkVyx+oP+f+4RwwzGSAM4Ez92EWVqMDDfWglx5tYPeYoH0ABaS5DpjJ3n6uDNAHABiWuRApWaEibCgfjTkEpjgJM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778436571; c=relaxed/simple;
	bh=XyMZSDpfWKuOveIviT2U+sf8J5uKR7RDZMDAEWQMlI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aBrwHQBjAH8iR7OrkayNWWrAxC3ANVSpOFeSC4ZCwy+BGcsku6u0M4RTjYE4RO0ltszyZt/DKRP3M28VPpWEOYjKYgNgFCIVbeeFE+nohGJujp/VA2NQ/6QdXljSmnfsFzW+tk3VOmjnNPZd9efiV/2QRq6xzC1t4aqHH4eFRbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CUz3p4iX; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CUz3p4iX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778436568; x=1809972568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XyMZSDpfWKuOveIviT2U+sf8J5uKR7RDZMDAEWQMlI0=;
  b=CUz3p4iXkBZZNrdKjeiYTlKIp+70IdlOa8hbnvuMIFJYB9s1SJfxJAx+
   LdkAEUSDu8CvRBaL2+KZTl5xxSCXJk+guTEkoJSN2BR0kUkDtCM+t9t3r
   8Jg9mzC2F3xm1GmmA3VXCIFVg2PtZX8w57Hw5LV2d3LpEyRAdGpz4eQtD
   +q8yjD6LCZgpoIk8rZU3LOphFYo4RkbhSY64IoK0Ecgdtf70i9+5VfX/Y
   C+Zw/w6SWp/0CWzTEDg58JfKcPq3Dd0gUFKoP+87nat1RgTEAYhS/QlM/
   TYETbEv7txmNqB4f8sVf53M/ceuBFgJJSMtCKEZ41mODvyU1MEBFw29fC
   g==;
X-CSE-ConnectionGUID: CgvI9dRcToOBs8FVY7UeoQ==
X-CSE-MsgGUID: Jy1WJN9ISAi5lgxhzgP1Qg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79060461"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79060461"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:09:28 -0700
X-CSE-ConnectionGUID: X2d+ZZi2TXmhirp1kgGq8g==
X-CSE-MsgGUID: qUzlI1xTTWq5N9PpRiQFWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="260726486"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 11:09:25 -0700
Date: Sun, 10 May 2026 21:09:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	puranjay@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: adxl355: replace usleep_range() with
 fsleep()
Message-ID: <agDJ0yn31C3RenHp@ashevche-desk.local>
References: <20260510050820.27748-1-sozdayvek@gmail.com>
 <20260510055303.37221-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510055303.37221-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 10:53:03AM +0500, Stepan Ionichev wrote:
> The "at least 5ms" wait after software reset has no specific upper
> bound. Use fsleep() with 5 * USEC_PER_MSEC to make the unit
> explicit at the call site.
> 
> No functional change.
> 
> Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
> ---

You missed a changelog here.

-- 
With Best Regards,
Andy Shevchenko


