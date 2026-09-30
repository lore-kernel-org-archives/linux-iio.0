Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3324C6517;
	Wed, 30 Sep 2026 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770087; cv=none; b=tABbv9uQJ/otmY9cqVpiZuttjACDH3vOj7NlZKrPQetZtQNA3cn+0pCivlyfRTIhQm00qx0j5wfIydgEwXtv+k2kfkHtT1GuFWKTg2eOlLsS6TQ7jNoG8+2lu560gkpqQ2fFkfyFpXLKQ68Uw89/x6aBleJg5mWO7xvNmrksbEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770087; c=relaxed/simple;
	bh=s3veLkw15cvhUhnEBJXJZXwWg8VpGlLtppPFAMhlK34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uSnvS/ZqbIJzw8i8syYpkfk88tJR60NsfcJI4cyncUJD+gUqQTGVRzv0hIBm41O/uAtyUmmmU3Ij7IunAaGmJSNndQ8Cxh6fTlak6hkAUIOarU7t66IsnX8Vyngt42Yu/lRZZ4CzBRMdIrqDP5wXGQ8YlJssCACFhBlTaMHCPR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HYpZrWKe; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HYpZrWKe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790770086; x=1822306086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s3veLkw15cvhUhnEBJXJZXwWg8VpGlLtppPFAMhlK34=;
  b=HYpZrWKeEezWglwm9NKqg8IF/DkXbzw4vE46V4u0COwfGH7CyjiZCFpe
   siDwOPSjj4KQIIPA2hD2OxpnQYcdZ+Ku5fI4JGeTLX6CRmDbt07j002QE
   e3t97iyBzyhCY8BouqxsYN31xyUaaep/KRJ9YRidLXa343Bg4Pmx4qKTw
   N1aLJyFOcQI1lznSgevOaQIz3h8ATgYucobQ7pIsJbyEH+9hsB+kdi8fp
   H/bAQ0Xrier0O8YnMLLQSy38YNLa8O5BCUiw90XSe6LGhir5AqrIpD+Cp
   MR8cQiAXTp3RACaQ3v615BNPpe/wtr2i9ujP7wUb1/452LMzTGk/hZ5Ej
   A==;
X-CSE-ConnectionGUID: YPdAit9+SzaBymt4weKTwg==
X-CSE-MsgGUID: Si7AqTqgSYaZNvwNhVoCUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="108993522"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="108993522"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 05:08:05 -0700
X-CSE-ConnectionGUID: dOC47gNyTP6W6exbk0t4mA==
X-CSE-MsgGUID: YSr0FDtPTheWLXoo0Qsj5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275805043"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 05:08:02 -0700
Date: Wed, 30 Sep 2026 15:08:00 +0300
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
Subject: Re: [PATCH v10 4/4] iio: pressure: dps310: assert the lock at
 runtime too
Message-ID: <arz7oHYIFJ7IUeO8@ashevche-desk.local>
References: <20260930100158.957977-1-zoone.rupert@gmail.com>
 <20260930100158.957977-5-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930100158.957977-5-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 01:01:58PM +0300, Rupesh Majhi wrote:
> __must_hold() is clang only and does nothing in GCC builds. Add
> lockdep_assert_held() next to each, so lockdep catches a missing lock
> too.

> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Not really, I just explained the difference and asked if lockdep annotations
would be also good to have. Otherwise if Jonathan thinks it's fine, I have
no objections (and also have no objections on not taking this change).

-- 
With Best Regards,
Andy Shevchenko


