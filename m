Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25ABA336885;
	Mon, 13 Apr 2026 10:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075007; cv=none; b=RZ6cvYCmB+jmaXSi1e3VcbqzI5dOgKzYS9oBGSX9Qg/Z+MGHlw941Din/ILD9BGWB4NzcmuU4rIBXsiIMtQyATyQSH8tNTRHem/ac2JaQfnBpGfWY5CDFSY5gTvs5Q1SWHL7AQm7miIgCPygdruMbRq6gW8c0BwT7hdjbgVYryI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075007; c=relaxed/simple;
	bh=MunRqkn4p7wYJ2grRDP6fEpEoiNp2qBDJy/mwuOi9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=giRhHbC40sU3IUuTGEOztLYrPnxDtVPsnLIYoSHvf8nqRcrG6vPH0Sj7/WpGOn2K3TjZ6YMfPITlopAsvbGnKfkdHRIQCYE4yZiXLVAY2+ZiZWH9eGFktSc8Gp50sY2HT8nZvbWxAZeE9mpZ3UXboE7iodx9EMM1m6VlP8M1K1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T5w/+pzu; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T5w/+pzu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776075006; x=1807611006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MunRqkn4p7wYJ2grRDP6fEpEoiNp2qBDJy/mwuOi9vU=;
  b=T5w/+pzu8x+mY0QD4KGrie3+sPN3iruUWLWz7oj/QgflcVfm4lxp/ntJ
   uKCSVEJdC6ZLqDf+DId5jCJHQ4uyakFX8EzSyv0OjfBhsB6q9prUtMmJv
   0N2vRI/ERY1ZMAmXUM7T4xzfKxFrCH5Bot/ntR93+R4ze6pvWk2yAohXz
   Uz0RK1anxZS2g47Cde4c8QQRPVBQYTzfhDfDd+UChDI+lj/sNklLQ57VP
   jvHBBzh2iqJ00YQAdTAYfVsVu9ejD+uWC0cWaBVR2XkYSngW6Dus2K789
   CtG+WGQTUQiFMzzcqc5vt1HUfRYcIfC4Te/L7gJPERUrJhOIrS4cacizi
   g==;
X-CSE-ConnectionGUID: 5f++7s+TQmO6SZJI62kxgA==
X-CSE-MsgGUID: nI0PhRF/R/CxMCjudHzrQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11757"; a="94579520"
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="94579520"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:10:05 -0700
X-CSE-ConnectionGUID: xCp6xpkRRRa/5u6jQM3B5w==
X-CSE-MsgGUID: /9j0eRrRQyCNyaNK1Ark9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,177,1770624000"; 
   d="scan'208";a="233778803"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.7])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2026 03:10:03 -0700
Date: Mon, 13 Apr 2026 13:10:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Erikas Bitovtas <xerikasxx@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/6] iio: light: vcnl4000: move device tree entries
 into one line
Message-ID: <adzA-BThGOquTf57@ashevche-desk.local>
References: <20260410-vcnl4000-drop-enum-v3-0-2ea2bc6f5dfb@gmail.com>
 <20260410-vcnl4000-drop-enum-v3-3-2ea2bc6f5dfb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410-vcnl4000-drop-enum-v3-3-2ea2bc6f5dfb@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 10, 2026 at 07:11:19PM +0300, Erikas Bitovtas wrote:
> Make device tree entries one line each to save space and LOC.

...

> +	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec, },

When it's a single line the inner comma(s) is not needed

	{ .compatible = "capella,cm36672p", .data = &cm36672p_spec },

-- 
With Best Regards,
Andy Shevchenko


