Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5AC39B960;
	Wed, 25 Mar 2026 12:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774441721; cv=none; b=S/gXC6GkZS5ScczZg7qqA8izNJ4FTPo8noYrKEvcqIUcA+1kd/UwZcAtsMAQfI07UEaraGINsjmY+9kMSmiUf6xKTsQdHWa/kyY+Luw6t0oR4l3Nma20DHn9CkTPHFbkj+UzUNjMcdHezGEKHHUrUOfSWJWbxJZ6V1duf7Jii1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774441721; c=relaxed/simple;
	bh=x9W75OMx3VMCa2iBIoMnGp8oa4XqbEihBfKHLjzrg6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEc2rx61PTcXTeeLpiGugZdMBExRO7MJM75tB73SuypeHc3gErogXbZKJ0ya5ELeta7XLHgRNdx8BYCfi01AwSSv1cFpyPawRo4yP1jhsyotG3cVQuUiL2ghQJi995cfZfBBhlJH0DBO1LzxVmwRL80qyTGbLE4NWcpKb+IhMgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=afzNFn5I; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="afzNFn5I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774441721; x=1805977721;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=x9W75OMx3VMCa2iBIoMnGp8oa4XqbEihBfKHLjzrg6I=;
  b=afzNFn5IvwsW5rYTe7NZbBFWlVCrkpkAOLDpikvg5195+f7rG3BQjYrO
   SrrNLhLIZUNdZne8zDrX3RRxo9Xfg2VXjsUG2IDV3HIe449a2DshZPsuR
   Uan2dOqLtrT/7nse8SZZ++e/0OfzXlxBpDRV7LD7YA6t37EJ2we5ZnU9Z
   g2ph3buycvqJsl+mQ5ExJiykOJ8tLl/bqT/bDpvDM1QycY78s5BtSaL5S
   xys4EIYtC26VenUd+Rt2kjanIqJWXUJsdcc4VeRO8Vzptx9+X+bYc7qDI
   a7R9FQv3ph5l+t1oHRQVu9f+OtWlA+MCDCEE1j+eyG6EvpdyU5J7Rqz4S
   w==;
X-CSE-ConnectionGUID: 5oUgDs13QCeLiuCT8qcS7g==
X-CSE-MsgGUID: 9a+eeYubTMGMv8OTzqZK6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75357680"
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="75357680"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:28:40 -0700
X-CSE-ConnectionGUID: sxDfqtuIRDyBkMFxuUmV9w==
X-CSE-MsgGUID: 27DpclqmRrqKU/Xchhi5iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,140,1770624000"; 
   d="scan'208";a="220261894"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.32])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2026 05:28:37 -0700
Date: Wed, 25 Mar 2026 14:28:35 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Milan =?utf-8?B?TWnFoWnEhw==?= <twoexem@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	lorenzo@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Add ACPI ID for SHIFT13mi gyroscope
Message-ID: <acPU86AwRJPUb22L@ashevche-desk.local>
References: <20260324193626.77231-1-twoexem@gmail.com>
 <acPNhGlmTJk4pfRG@ashevche-desk.local>
 <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ac6cca6-a7c5-4892-93d9-49f850953511@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 25, 2026 at 01:23:20PM +0100, Milan Mišić wrote:
> On 3/25/26 12:56, Andy Shevchenko wrote:
> > Please, for the record also reply with the DSDT excerpt of the device in
> > question, so we will see how it's defined in ACPI.
> 
> Hi Andy,
> Here's the device's DSDT excerpt:

Thanks.

Interestingly it has accelerometer and gyroscope described there.
Is the other part already supported?

-- 
With Best Regards,
Andy Shevchenko


