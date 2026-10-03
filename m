Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7DB47ACD4;
	Sat,  3 Oct 2026 19:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791055818; cv=none; b=frVfii+vQ6qf4mBSAf1uN3nHsEWc/JKLzWhhQrT15xl1/mTfRzffU9+As+BfBjW9fgvoU4yGy4joqIP5wasWrq7w2K/B4DO2hZFeNnqo4WK+wjilUjiN6T+J4cyRsIQmEQEW+vQ9/fsYw94fCAq26r5pxOYWUGzY/+BEYF5RJ+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791055818; c=relaxed/simple;
	bh=uvpJlSrvxjMLXJZ4rMO4aH4lLgLNiPrB60z0pK5/RZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1Ki/O1xMdSW8QNbvaX1pXiZ2SagSHx7KCBDTOmJPeG9xqebVG5xAmlhtU7GxtD5dEBrZW7/m/M5p03yI5iGRnIoeD3K2/OSiL97g13A9ifMA86fHyKxYYKGB/nlneZ2Q2J2EQUBQ5Yw3LdAB7N2+rnw3wwU44vHlHCWDLd25WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FIq6nINg; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FIq6nINg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791055816; x=1822591816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uvpJlSrvxjMLXJZ4rMO4aH4lLgLNiPrB60z0pK5/RZY=;
  b=FIq6nINge2LeeAqIRvGRAO7UsHLWQFhzM63kgLIAEnc8mQUqQiWrG1ng
   CcRr8gAMh1jrlYKZ+Q8KsDKZbiXa2MlX5EYbJ/ry56eC//YH1rg5nle+b
   gMGiA6Npx6GqJfR4JWSurI5iMeGxwUZdmckTPofeAAWbXFF6YWddLs1kL
   QUt4Gvddl/nrglFMn2kq8F9cth0/79UULZhsA5nvHE/DQkXzI7U4FGw1j
   GtL2QTjTAxQoVOmCX3LJxMx5NvqwbF5C8TPCVrBXIJfILu4vNT9D4FL+n
   fxDyZtxw2aXZ+GRSwHGMGHvhXDaqcmocR8r3PUG1+WHXdEfrFGARUVgvN
   A==;
X-CSE-ConnectionGUID: ynDYh0voS8CNltC/2w6lWQ==
X-CSE-MsgGUID: DJf+a5oMSZev23zcSfWLRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="95599219"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="95599219"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:30:15 -0700
X-CSE-ConnectionGUID: g+d6nrGaRhOR+2emudTg6A==
X-CSE-MsgGUID: cy6aSjipRl2iI2x7tdJkAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="304449492"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 12:30:12 -0700
Date: Sat, 3 Oct 2026 22:30:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v11 5/5] iio: pressure: dps310: assert the lock at
 runtime too
Message-ID: <asFXwlAOVq1klYL8@ashevche-desk.local>
References: <20261002072526.250081-1-zoone.rupert@gmail.com>
 <20261002072526.250081-6-zoone.rupert@gmail.com>
 <ar9j0O7DdJ7O1DVk@ashevche-desk.local>
 <20261003191058.35287-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003191058.35287-1-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 03, 2026 at 10:09:26PM +0300, Rupesh Majhi wrote:
> On Fri, Oct 02, 2026 at 10:57:04AM +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 10:25:26AM +0300, Rupesh Majhi wrote:
> > > __must_hold() is clang only and does nothing in GCC builds. Add
> > > lockdep_assert_held() next to each, so lockdep catches a missing lock
> > > too.
> >
> > Suggested-by?
> 
> On v10 you said it wasn't really your suggestion, so I dropped it.
> Happy to add it back if you prefer.

Ah, yeah, I assumed that this will be folded in the original patch that adds
__must_hold(). In such a case the Suggested-by would be confusing. Since it's
a separate change (and we have no response from Jonathan on this) the Suggested-by
is fine. Hope that this clarifies why opposite signals were given. But this is
not really anyhow critical. Feel free not to add it at all.

> > But we need to hear from Jonathan and others if they like these annotations in
> > a mere IIO driver.
> 
> Agreed. It stays the last patch in v12, so it can be dropped on its own.

Yep.

-- 
With Best Regards,
Andy Shevchenko


