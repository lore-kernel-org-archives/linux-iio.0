Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6351630DEA5;
	Thu, 16 Apr 2026 08:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327736; cv=none; b=mhWr+4pCIJbcH89B2Z8bM3OKW44HDcgMo76Clpnca/r9I0I44Z10IWjfs22TSUTBf9c0AVMhxTJ9LQ2PrzfinawKiBAnefLuNOZTlLDr/FrsBDn7WZJAtiejiXTXmMDvqfFf7RswWrFYBgimLdbhhu7WJSGx+nf5nCQ64q/cP8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327736; c=relaxed/simple;
	bh=vSdgNPNv+1Wxh6+w67cWfYidQtbtgxryhVtax9sviks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqGctAhbzS8dp5ajsJtTF16DIVW/gRkPqAqW4f/ZajAmDtd76A8oRnnMHW21XWnNQzW44ZEs4yh3NgSUnaK9BSefOvWXqkf+XfwcpOu3/Lkbr4OpvZyj3L3RVMxF3tI1EeNASrgei6e1bxY4yVBwdbNvAdbvo3HwGKlHBd8O7nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DmpQZAZ2; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmpQZAZ2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776327735; x=1807863735;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vSdgNPNv+1Wxh6+w67cWfYidQtbtgxryhVtax9sviks=;
  b=DmpQZAZ2DeDIN9PBS6MIqKeBRXdfwj1CN7n/Pq+rtRmSUnAFGbRhwcU8
   TXXnIT6kq9NzzrJiqo0D6rWJFXzke+rqyrcbGuBiVmP0TWVblKQurOUM+
   5wsNt4FGIOWrTS5nGhK09PYibpIMkwofh0yORcX/RKPBoBuOsu64DP5U5
   NusqbJhqEVBkX7VutY32BOnyiQuot0mf0XIeYfp+56u+Fe7qcTMRda7ZG
   UEmd9YsbtT1+r8YkksDazdfQcZDrn2XiV3hHdaC4/9bPQDwZ6jVLenOsB
   Q9d3+kMhrrqtOpl2yzcAFYCoy2lb719gIpDnzLUDCR2yPa7P4mia3OofM
   g==;
X-CSE-ConnectionGUID: YcvS0Y87S0iT3bf42r23dw==
X-CSE-MsgGUID: 1+XD43zZTBG3n0il3k4AcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="77436262"
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="77436262"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:22:14 -0700
X-CSE-ConnectionGUID: kTzx6srmT/KyS3mCSgv5WA==
X-CSE-MsgGUID: f3TGciPnSfy75RxNy+vC2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,181,1770624000"; 
   d="scan'208";a="261093628"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.173])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 01:22:12 -0700
Date: Thu, 16 Apr 2026 11:22:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: lucas.p.stankus@gmail.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: adxl313_core: use guard() to release
 mutex
Message-ID: <aeCcMWmLF2UMfZHa@ashevche-desk.local>
References: <20260416051631.551250-1-sanjayembedded@gmail.com>
 <20260416051631.551250-3-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416051631.551250-3-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Apr 16, 2026 at 10:46:30AM +0530, Sanjay Chitroda wrote:

> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.

You missed two things:
- cleanup.h
- the patch is already in tree

Please, always use the tip of the respective subsystem treer
(it's usually iio/testing for IIO).

-- 
With Best Regards,
Andy Shevchenko


