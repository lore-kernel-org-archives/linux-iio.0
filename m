Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8462D476076;
	Wed, 19 Aug 2026 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787146696; cv=none; b=eVfP9Dx6lLZtkHbBxuHwsjOOGqrMXvihwx4nJvtEbW4eFOQDXGF+66sOG9I0o5CZvry+NPQM3J9z+J3ZLCH7/8x9Ok3BXrH47MI46N8a7ID9RCpwsqB05ftfVZ1WXXifm1YetoGo4RceMIuJ5h5SbW5tOW4M+klpZkeesttpyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787146696; c=relaxed/simple;
	bh=qy5vjG//VXOr9r1CK5Ci5xH/MM7eROHDKx/qY+47GV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxAgTZWX4Y5VqwjL9UahFTB+YrG2cu8KqhK0o6Pax9XsaKdRBDuxpdKQvL2qj1ukIMWdijqBTB9D6N+JECS9PTbk3HlXnL6YsayXh3KROVXjMlsiDOs5x+JXRRCUxGRjA/JkUGuw1Qk9R2xHPFzV5eazqyejdk7oKO6I5THUZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oCRGSdqQ; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oCRGSdqQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787146694; x=1818682694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qy5vjG//VXOr9r1CK5Ci5xH/MM7eROHDKx/qY+47GV8=;
  b=oCRGSdqQ6mF01LVmq0D2AdQdI+p5B4NgnQKVpUlJ24FEi5i7qsFK+sm9
   BaEFoNqOYDI8bdRWOUfkWwDEzbjY3xJvDTkVOm9Ync46l60cWrX6lLZXv
   QljEvdJIBZGsE+TyRWDMxhHSQS66nJtXRQQzv0YCXKiXfHV7qxxCtzTMz
   xSRX/1kvLXau5GClifa4mpWSaVuVWpx5xGBEJocva+7M48gcKGpKeOSlH
   kNneV8uvniMdWascCy3z12IRKRw5XpG3J+IEa8NIFk4V3qepXrPrYmNdJ
   NXye6PuA/gcS3kFvYKnpi6KKDleoXpbaPUBPzPFpCBQc5bFdgVtRimyiS
   Q==;
X-CSE-ConnectionGUID: CjXQRuUrTbm7yrofUgMr7w==
X-CSE-MsgGUID: Q/CeCAcYS2W/B0obNUEjNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="86617220"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="86617220"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:38:13 -0700
X-CSE-ConnectionGUID: r9WbVosUT7eN0ZsU3LitEQ==
X-CSE-MsgGUID: Oqe2onFUSNO9AJDkTp/qXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303771603"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:38:12 -0700
Date: Wed, 19 Aug 2026 16:38:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: sca3000: fix frequency divider condition
 check
Message-ID: <aoWxwTHUqIsXT4tK@ashevche-desk.local>
References: <20260819114101.28232-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819114101.28232-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 12:41:01PM +0100, Salah Triki wrote:
> When setting the sampling frequency, the check for `base_freq / 2` is
> followed by an independent `if` statement for `base_freq / 4`. If `val`
> equals `base_freq / 2`, the second check fails and falls through to the
> `else if (val != base_freq)` branch, returning `-EINVAL` erroneously.
> 
> Fix this by chaining the checks with `else if`.

This needs a Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


