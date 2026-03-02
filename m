Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870A2387342;
	Mon,  2 Mar 2026 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772437816; cv=none; b=kPDbfQw5WeZPT93+e/BFp0R4u/XB8HAFfKTHxuqNKy+Xl93ZJt/kj5TI4VE+9y7C75BFRd5iybbACjTY6Om1emQEtLRB+zrKWTK4lHUuBggBAIQn0rc8vSg9KYnazHBWlcgWdoGn239/GSgN1orvFBYiWviloEdkR0hd+d2QVQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772437816; c=relaxed/simple;
	bh=l+19X3mSzhsmsxH05NHeg9r3eWFTaHt67t8gqN6yfcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UgWQTP/WFaXfLWpnmXRfew91t6NbAFXKgeLtc8/gCxfTAxOiAmE0Rc5Xl77cOToKLVb6wMPwfxIIDn+WLUvRVnY3Xr6pYfw/aS9xegBatIJQvfLYxzb2KmfzW9E05JRJqIxxouJ1Hfkk/CB+Ppsl0xTqNx9VK1J1Y4h6Oupr/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JjL/4cn6; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JjL/4cn6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772437816; x=1803973816;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l+19X3mSzhsmsxH05NHeg9r3eWFTaHt67t8gqN6yfcY=;
  b=JjL/4cn6KuQwTIrDlFPyFmN/OJcQ08M0Ru5Y86oTwpgcYqkd6qnYef3e
   EmeODJ3ZmxTUqVz8YyZxz1AXz3keAiMbvvnhEtLMpV3z9VSGGYim5BbmP
   CYs2V4o6EZIr6+QPm3Kev/uNw831KxMi+RZ8hzH6VqUvjYXxy+P9Pso+x
   Uohwq/vdjjs8I7aDVUiNif6U0f49fhhBR5YqlO4L0JBBfBCMjNBtrDNYd
   KrJzfcvoZEEwG0OWQCCqbE55sAv56OFbr2FkmnvFtlTB04d77ZDTDOr6o
   VpY/DBx6fjya5mOhOSv0yM/AGFIGqwibqdrq+NKWn6tUVk6d+XgKsWo6t
   g==;
X-CSE-ConnectionGUID: ogWTg7zOQw2BT2Hj4/Msrw==
X-CSE-MsgGUID: wDkiH98dQIiGNYD1SLxPmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="73503792"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="73503792"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:50:14 -0800
X-CSE-ConnectionGUID: dVN0cgNfT/6ODKBnMOw4YQ==
X-CSE-MsgGUID: Fl0Cc58dQaSBEnY2y4rCug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="217684382"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2026 23:50:11 -0800
Date: Mon, 2 Mar 2026 09:50:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: antoniu.miclaus@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: remove unused ADE9000_ST_ERROR
 macro
Message-ID: <aaVBMRU9wd6s4Nu0@ashevche-desk.local>
References: <20260302055035.36363-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302055035.36363-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 02, 2026 at 09:50:36AM +0400, Giorgi Tchankvetadze wrote:
> The ADE9000_ST_ERROR macro references ADE9000_ST1_ERROR0
> through ADE9000_ST1_ERROR3, but the actual defined symbols
> use the BIT suffix. Since this macro is currently unused
> in the driver, remove it entirely rather than fixing the names.
> It can be reintroduced in a future patch when it is actually needed.
> 
> The individual error bit definitions (bits 28-31 of the STATUS1
> register at 0x403) are retained as they follow the convention of
> defining all register fields.
> 
> Reference: ADE9000 datasheet (Rev. B, Page 61), STATUS1 register
> (0x403), bits 28-31 define ERROR0 through ERROR3 status flags.

> v2:
>  - Drop the unused macro entirely instead of fixing the references,
>    as suggested by Andy Shevchenko and Jonathan Cameron.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


