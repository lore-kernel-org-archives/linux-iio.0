Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3C1311C1D;
	Fri, 13 Feb 2026 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770974584; cv=none; b=ZyDg9R3TyDW0RgUiHMCEM2tJD+FffGOQ8GqNJDLHLPWI/JF4X01H3qdoOHXYr75It/JUzl8piug+nCPeV6Wg9G50ZBWN62C780mHOoKlSXSDE1NbgIFAV9kUJvXzdWD1uTu3nHqYoiyqJ0s1eWqYwUcn0tiQ8rdWZMhorrEyEb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770974584; c=relaxed/simple;
	bh=R+RihjX3TwF01rDPqAHaWeYwL4pyAXoQ3mBbopxHGMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOEbPYgkMs5s051wTGZUScpgKsc9qhg1sfeOUx0KkQaTIM6zK6SqRHexYvx+CGscLubM650iCcpyVbW6rmHX+SAmWLF5c23N/BOD5OSCo4+ALoo28G9xWjYYOrG9Irh0irE85Inn9wcNKveZNzfz1V55de88M+iuMEinHMJOFDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kT5CIwJ5; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kT5CIwJ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770974583; x=1802510583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R+RihjX3TwF01rDPqAHaWeYwL4pyAXoQ3mBbopxHGMo=;
  b=kT5CIwJ59VCNvxb6IKpHGDrp0wKy50gl4musV4+B/pR1qPkodbomm1DL
   YAu7gobJ9H/CDxUdSmlAJ/6vCoVhYHnCNVgyMaPmBUkx6rc8d5zntfrm7
   29KiQoSrvGGwdq0lb+keyTAbWoIY8A8Z0rCaWKKd4GKFZfAalEd1pKEBl
   I+I9el7ENdBu1TpAk38zaib2Jc1V8eLfQ/lQFi/tP1Mginnj5Gh5JzHCZ
   XFgYCOnshUSoMAqJ4JFRZhZ8EBPi3xTfWIhNLgEWKyNRzYAFziBjIR+1O
   S9DuJrxunQZdmJGohb+7PsTw1S7ziiVzVPwHKiA0epphGYFI1KsaYeAY2
   A==;
X-CSE-ConnectionGUID: PRqvP2WjS3O8HC7HBJznFg==
X-CSE-MsgGUID: Z1HHWVNvS2uhWwKVY6IoHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11699"; a="75998611"
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="75998611"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:23:03 -0800
X-CSE-ConnectionGUID: IXsd5GyRT9G+26PyajEqNg==
X-CSE-MsgGUID: 1wv7HSnvRlSQ3nW+vfCBDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,288,1763452800"; 
   d="scan'208";a="217346776"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.242])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2026 01:23:01 -0800
Date: Fri, 13 Feb 2026 11:22:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7768-1: Fix ERR_PTR dereference in
 ad7768_fill_scale_tbl
Message-ID: <aY7tc6UTJ5CuoZ9_@smile.fi.intel.com>
References: <20260213031207.21291-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213031207.21291-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 12, 2026 at 09:12:07PM -0600, Ethan Tidmore wrote:
> The function iio_get_current_scan_type() can return ERR_PTR, the return

ERR_PTR --> error pointer

> value scan_type is not checked for this and immediately dereferenced
> which can cause a kernel panic.
> 
> Add check for IS_ERR() and return early to avoid crash.

Also check lore.kernel.org archive, I believe there were reports from CI and
bots on this issue already (hence might need Reported-by & Closed-by tags).

-- 
With Best Regards,
Andy Shevchenko


