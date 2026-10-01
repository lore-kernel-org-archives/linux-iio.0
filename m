Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78523BE14A;
	Thu,  1 Oct 2026 17:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790876857; cv=none; b=WtmNPsxkT5miVWluyHdPunKpk+QtHhPtx+9pI20UZWtM2pCik6BQreNv2aelPseh3N4nfj29CyU59+KOcjFEZCzkUKm316StgmRlgQB4yGaqBv+nEG6E87iyWX1gt/M8EG9xzZnp88jG2XpVZugUAyxRkWweJHcFttY1oHEf5gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790876857; c=relaxed/simple;
	bh=7voojWOMzczVI2BSIIUP5OhPO3p1coMAM8Ssv2dHW5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iz3iVGFVddGSrhy/bah2WwaDlyIPr2zqldmUNl7BFdIXVg3m6W0qJIN2CMe4lnAwoL3cE6YviDldq5NdPUyk89jXi/JUwo3Y+NcAodmfdSrLFj4b+FpGowJUCDf7yKjEFSjOT7cv9hNytul/xjhggj+x3sPwM/OOiFWHQTNwVqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AL0rU+dM; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AL0rU+dM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790876854; x=1822412854;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7voojWOMzczVI2BSIIUP5OhPO3p1coMAM8Ssv2dHW5I=;
  b=AL0rU+dMHxe1AJ+Ky14kg1zoR4//7bQ3efTex8kEoZN4PJ5L+TiPxB3G
   hexLN+hy8fEhDR1QJdaJiarqzVvvg6BTSCdwHLI7F31d36sQ2AOZaI7nq
   sqSga9jxgGouLdmahuIpmBkrM9cZrI/Bv/UFSqEX8TgANVw0jpLOjw6Be
   CTTDOs0zoPRXE2ldSlRR7hs62YFStBCm6trONb5/DtjuBsY904agqIigg
   O0u3KkWupdNKdCGThK0IKafUR4cVgSBw4ZsC4PWbS16OzSQyc9Eb33VRO
   KKpStY6/79ud/pCq2QxrBMABiXt5yGOUxW8+kyl9Z+4+sxxf2bL82Jt3B
   A==;
X-CSE-ConnectionGUID: TgQYkOFFSdGs9i0t/wITGw==
X-CSE-MsgGUID: Oqliq2ZlRXWCqdjG127CxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91743839"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="91743839"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:47:31 -0700
X-CSE-ConnectionGUID: ylsKbScuRQimhot5MgXtZA==
X-CSE-MsgGUID: KssXjwJjQLm7dI3/6nJaXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="272475602"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.244.27])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 10:47:29 -0700
Date: Thu, 1 Oct 2026 20:47:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 03/10] iio: adc: ti-ads1015: return -ENODATA when
 match data is missing
Message-ID: <ar6crrfViwIIMB-u@ashevche-desk.local>
References: <20260930171204.12863-1-architanant5@gmail.com>
 <20260930171204.12863-4-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930171204.12863-4-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 10:41:57PM +0530, Archit Anant wrote:
> When i2c_get_match_data() returns NULL, it indicates that driver match
> data is absent rather than an invalid argument being provided.
> 
> Return -ENODATA instead of -EINVAL to more accurately reflect the failure.

If you arrange this patch after the next one, you may reduce the churn by
switching to local 'dev' variable at the same time. It might be even not
needed to describe as it's just a small detail that doesn't change anything
in the behaviour of the code.

But no need to resend just for that.

-- 
With Best Regards,
Andy Shevchenko


