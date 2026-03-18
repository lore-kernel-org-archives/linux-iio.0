Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8653037BE6C
	for <linux-iio@vger.kernel.org>; Wed, 18 Mar 2026 08:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773821415; cv=none; b=qmJCTHc7cwZnTZVwbx2OIfd7ajd93GmB/0T6TEVfg8KngMoahOM7hSk/8kHbvOciZk7LJAzCDfMa28f3+P90vM2y4x87ju6hCIhcWY1uqz6CaL0ZTZkqJHEFuvNh+XR/wu3/k1u2Jp50se/uxnE3SxqbIH0SdoLL8QE8b2csvG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773821415; c=relaxed/simple;
	bh=/89UglCQEFsNMkKCX4a2maiifcZ+Tudeezt9sHARHYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSwWQEYYHx4M43o+rCtGiV53oBXaVt/4TSCKEUv2z+CCq8+yfSr+YHeDanaVWdJdntLYkRCD21SR6EDQZTxa1XNH/lslLotTuI950nBduSa4X615PprbqkUVl8jTXFQSkixR3GkpgYEzwZlLOyLe96kQmm9NYjhE7fLs1298OEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ePYGq10d; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ePYGq10d"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773821415; x=1805357415;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/89UglCQEFsNMkKCX4a2maiifcZ+Tudeezt9sHARHYA=;
  b=ePYGq10dLVwmSfGSMo25juy6p/kV+8OIu+zCPcCGMFbFs+rgBg1sCCwd
   +/57LdVbPQA7ewtp4zGHFbvv/miIsnGU/kM5mCRa4yg+hyMq/RIW9yjJq
   hUiRKBBySDSLZd0rRdbgW7c3aAsb1SiSZ4RDMiOphrxxDad8BaPvsEjtk
   QEKtWkBrraZHfH9MxQaF8CsK2rg+C9L3ezayU4arzOofHwc2vMFEymNFD
   DjhgpqHP4X/Kg+S1xfHGzUNnRMwYriO0FYp6mwaGwWy17wue4ZgdklLbj
   Q7DzvBMrqk69zNzHxOlQrU2JWcJT7konnpKdiU4Bw2VLrJX1WgbgOM8fO
   g==;
X-CSE-ConnectionGUID: 8VxsAxQaSkuHgeBvCSL4BA==
X-CSE-MsgGUID: e0vQG/8GSeyUooDkOfh5QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11732"; a="74049863"
X-IronPort-AV: E=Sophos;i="6.23,127,1770624000"; 
   d="scan'208";a="74049863"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:10:14 -0700
X-CSE-ConnectionGUID: qNrR/lepSHaFH5eilXz4OQ==
X-CSE-MsgGUID: y5GPu7EzSD2ZMD+g66Bt4A==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.240])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2026 01:10:11 -0700
Date: Wed, 18 Mar 2026 10:10:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bhargav Joshi <rougueprince47@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Subject: Re: [PATCH] iio: frequency: ad9523: check return value of
 ad9523_io_update()
Message-ID: <abpd4Y88DhBlr0Cj@ashevche-desk.local>
References: <20260317232552.28485-1-rougueprince47@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317232552.28485-1-rougueprince47@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 18, 2026 at 04:55:52AM +0530, Bhargav Joshi wrote:
> Several functions in ad9523 driver calls ad9523_io_update() to apply
> register changes but fail to check its return value.
> 
> If the function fails, driver silently ignore the error and returns
> success. This results in user-space assuming register changes even if
> they are failed.
> 
> Fix this by properly catching and returning the error code from
> ad9523_io_update() in ad9523_sync(), ad9523_write_raw(), and
> ad9523_reg_access()

Missing period at the end.

...

So, now the errors that were non-fatal become fatal. Is it a problem from
functional behaviour point of view? How did you test this?

-- 
With Best Regards,
Andy Shevchenko


