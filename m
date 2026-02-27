Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C56355F46;
	Fri, 27 Feb 2026 10:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772188389; cv=none; b=fsRFWUNm2F/e/qiC0cdtAG7+/jejbwVpSSyKrTet7GhJVXTrbTKB+1J+FZ8gZAp3MYPbY8+PTfPgfgRLHBq67yv1+ZXbG6tPAiG3wXDGvc072LwcfK7wjbK/8/huAbqkCHGd9tQPfze9IpUdfKO6dwYq1t08vV70WIFdOHVp4M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772188389; c=relaxed/simple;
	bh=r1nAFa4uMTlZRZogYX1fbskF53ZnDVkqbe3krBL8V0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+eYQgRP0mSMjHSrc1c60j3XXzzKooD5yR+mppt/QYJi9ltG9UrXIzh21dWSQVEqu7K3ExA6oxyOs1fYfBZ6z9dcwv/wK7XniDVv06Py7kekZZuWcfSxnhNpNvV7TbKnK/sBgpYAgFngvyPEXIA8toqLnv36l3qQXfVtsybaWEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XVUT5CjI; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XVUT5CjI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772188386; x=1803724386;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r1nAFa4uMTlZRZogYX1fbskF53ZnDVkqbe3krBL8V0U=;
  b=XVUT5CjIUWL6lNMk51Iwb3oTAq94gcz7JR8NaOFXQ29BACZu8V6j0c1r
   tr8mDcQFJrQlYsJ1yO0PwirbMXYKmwl4Xz9fsSmLgzAegGGZH55F4X7h4
   HolnNvVsqn9mwHXIgqnhlWOWtw1Z5G0Mh83OVwAWg5g5VJuVvfRa6pZUM
   05zC1n00B8d4jR2L+wRm8mjJNxO4ydNU7NuaprNW3NZ3m7Ub376lyP2yR
   /heGB2g5mxFlsNyS+qrC6RWF3EWWj9UvgzEq0ciaGwVB75mwd+i6cI/U4
   FqVbkZnsy2eUws2NMkwgHO0Dx14b9LNCFj0HwqBjSFeZAe1XDyCeEMBLA
   w==;
X-CSE-ConnectionGUID: ubOJLYV/TgGpZ6FwHwIuTQ==
X-CSE-MsgGUID: icmLVQ62RtG8368ykvhLAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11713"; a="83904185"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="83904185"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 02:33:05 -0800
X-CSE-ConnectionGUID: YAzKPmgpRQ2kKIJI3f417Q==
X-CSE-MsgGUID: 2nV2DiGFRTmae1TJUciW2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="214297762"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 02:33:02 -0800
Date: Fri, 27 Feb 2026 12:33:00 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong macro names in
 ADE9000_ST_ERROR
Message-ID: <aaFy3JVVL_nvSGsZ@smile.fi.intel.com>
References: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 02:09:01PM +0400, Giorgi Tchankvetadze wrote:
> The ADE9000_ST_ERROR macro references ADE9000_ST1_ERROR0 through
> ADE9000_ST1_ERROR3, but the actual defined symbols use the _BIT

BIT

(It's okay to drop "_" as "suffix" implies the position of the "BIT".)

> suffix. Fix the references to use the correct macro names.

What about the current code that uses it? Is it even in use currently?

Please, elaborate more in the commit message that we clearly understand
that you spent time and investigated code and/or datasheet before crafting
this change.

-- 
With Best Regards,
Andy Shevchenko


