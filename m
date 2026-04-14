Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9809C220F3E;
	Tue, 14 Apr 2026 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776170712; cv=none; b=ozwt10YhomcQI+FGAyMLxLIcmhO5FwSwCHtJk9yixgetYzea3HoVjsY9bSARcTiWhMxndcsGHl7gDs6EQaUYDH15PAc6iWYLdcwWV2ir/33c2JQ20JmR819vj59Xhwt9tIm7hqagz4R5LeSXeT0OnTOklZ6STzZoitCJyUqKgvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776170712; c=relaxed/simple;
	bh=CcIMJD6sLl1/EPCixhM0nM8FyNqc0um9cIMwcaIZQ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KwDNEfhdKsVWO1jhPp4VSkrknDbukjwt6/g79sEuYaD2D8ElSkN90hW3RNQE0CKf6zL8i1bccF3GVI7kRcAMBxRTPVEtf1+zoKmcKkyOXi+Rx0ADanPZALN+w+Wj3dyZdqFf9xgfWSDKVONIoawaOPHzecwj7aVsQIrTwBP/POY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KDEwwTcG; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KDEwwTcG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776170711; x=1807706711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CcIMJD6sLl1/EPCixhM0nM8FyNqc0um9cIMwcaIZQ24=;
  b=KDEwwTcGOb6A395Heis5H6cWk7m9ywnqBx83eVbPBI1u1U9zQlO4PtqN
   3EPDnj7plGS724iC4qd+g+BIUt031e9NQgFVbZT0Yp0pbYKi+zeIuo5Xc
   N0obPI+Yqa7ieu5KHsOqw4hIJ/u2gTV8qiI9Kyyli6WgwW/3Z2UJjA8RN
   bxjJs7/97c/9Bbi0kdsKoRrH+jm1bYBeP4Q2wwpD2vtJ5pvrgS2nX2B8w
   abwrPUxRqFSryo5aocitM8+KUneqQeXwax7lLY764qeuDY1AL4bB9gIdR
   hxY0w4p2yakMlJq5xHjVkyfcqadRkxULH4QNl09tCtmzS2THdJYm3BtfU
   Q==;
X-CSE-ConnectionGUID: QN26l9u8S6WA/iE/65UkKw==
X-CSE-MsgGUID: DM5CsJ31R/eLHxA+8zirbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="102582882"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="102582882"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:45:10 -0700
X-CSE-ConnectionGUID: TyKmtm9mR7CBjRisFg3ZZA==
X-CSE-MsgGUID: M65VFgk0RNmYE1ok9zetXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229059392"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:45:09 -0700
Date: Tue, 14 Apr 2026 15:45:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/6] iio: light: vcnl4000: move device tree entries
 into one line
Message-ID: <ad420nromgISFml_@ashevche-desk.local>
References: <20260414-vcnl4000-drop-enum-v4-0-59fde2932a0f@gmail.com>
 <20260414-vcnl4000-drop-enum-v4-3-59fde2932a0f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414-vcnl4000-drop-enum-v4-3-59fde2932a0f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 03:37:19PM +0300, Erikas Bitovtas wrote:
> Make device tree entries one line each to save space and LOC.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>


-- 
With Best Regards,
Andy Shevchenko


