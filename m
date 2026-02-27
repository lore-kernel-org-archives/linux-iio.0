Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C211541C2EA;
	Fri, 27 Feb 2026 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772203494; cv=none; b=Dgr0pOB8JgKYTw9hCp7lGvMTu38t0VMdjI284HwIAWGfpxxJfVq5hUwLXQ99owBVbBY4HY8O3Grl2o1TKe5zTKHU7ijhNzeuwqlzFpXwgNwDzZGIvU76J5mSXUzOX5NMAjtDgSMsjfgECoV1kBSmSCygoR9EumXe7i2TdE7asKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772203494; c=relaxed/simple;
	bh=OtxS+BrneApqDYHQ0KWKcypKu5W/9u55okuK6IdjjgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2iakmXWr9GLN3ydCmuxfcHpwkSRpO6GYgkZbl9R6Vc0GNne+ks705q2kkug5NIlgKoljOxFjaYOHASXzCyCB3h33hjnF8z1WE9SjEeAqIEqLeAF8qxhI4fMivuXn3ZiWPDywFZkQWnaOsi8h4t0WHZMMLdz1oP4GZj7Cm3QOE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EJdpOElZ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EJdpOElZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772203493; x=1803739493;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=OtxS+BrneApqDYHQ0KWKcypKu5W/9u55okuK6IdjjgI=;
  b=EJdpOElZ56WL78cPPtSCTGDWLqLm4hUovtA1BEHn+IY/S4IsHbI8RZXn
   ZjqZTLNsWuBLVspmAHH9t8IKxgMrOci5o3I93fa5blV7e3BYp9sDjd6/G
   E3/IjnTYLVv0whPlCAgqyHkml2UmbhEk71An2GsWyzkDbrmPGvaTkSLaM
   kr3IF90LYkEBkfTyxFVuE645QYOaRPzWoeoA4pBID4jWWkew6krcShvRB
   NW4QbewlRwU5vkVeWoi6sQYwIsyeFCAzEq0XOHOkk5ZTScUBPvrKiFS8U
   sIOk56Jy995OF9OqR/+QUY0lWzQ3oyMOHv+IEj/D3kfD1KMCd8ybV7TUQ
   A==;
X-CSE-ConnectionGUID: qqf0ZulMRP+HTlordvLSlw==
X-CSE-MsgGUID: /L4ZTmjsTh+7jeMk0XJxfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="75888563"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="75888563"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:44:52 -0800
X-CSE-ConnectionGUID: bdp6MRE2T0md9BdWXY6iZw==
X-CSE-MsgGUID: 8DhqWY6lQ/y7BfVhSF7MVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="216926587"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 06:44:49 -0800
Date: Fri, 27 Feb 2026 16:44:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ade9000: fix wrong macro names in
 ADE9000_ST_ERROR
Message-ID: <aaGt38ePGhonQRmd@ashevche-desk.local>
References: <20260227100900.72980-2-giorgitchankvetadze1997@gmail.com>
 <aaFy3JVVL_nvSGsZ@smile.fi.intel.com>
 <CAE7dp2qN4mxJfSYXxFQY9sdLR3eQemwDOEur3QxcMU2TNBZTig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE7dp2qN4mxJfSYXxFQY9sdLR3eQemwDOEur3QxcMU2TNBZTig@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 02:52:45PM +0400, Giorgi Tchankvetadze wrote:
> On Fri, Feb 27, 2026 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> 
> > What about the current code that uses it? Is it even in use currently?
> >Please, elaborate more in the commit message that we clearly understand
> >that you spent time and investigated code and/or datasheet before crafting
> >this change.
> 
> Hi Andy. Thanks for the feedback !
> The macro is currently unused in the driver, so this does not cause
> a build failure.

Drop it then?

> Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register (0x403),
> bits 28-31 define ERROR0 through ERROR3 status flags.

Yes, good, this should be in the commit message.

-- 
With Best Regards,
Andy Shevchenko


