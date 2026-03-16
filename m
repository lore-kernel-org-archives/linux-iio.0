Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149B3385506;
	Mon, 16 Mar 2026 10:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656194; cv=none; b=bNtPBcj21aImY7HSvY/BEk8bJBlRJit2OUd3wCqUrYj9QHYK6YoNqB4r1dx4fKNj4P9L5oZnXrdjxIyFT7VXrdGXbgkKWsX7cjisNKEjwVRtPP8vA9CMYPLKnGykGw5G1PuEdn4fep1oxGXDKAzw68hu1bcm8qcOUOrMXl5rvQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656194; c=relaxed/simple;
	bh=hxmthuqqvIJq1/wdOTG+HdngKYym+K2CIuLTdSoWNbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGgJFuPURCEAgrWVFVTnbnsxYVatC8PxLFCFCB59eFKmUkIwXA/ZSLqlJB0gAzLihzxpzlACM+ieYIxfEwEAzk0zP76V2RboTxXH70FizH4HUvhzs8GStA6gh37MmQZXXNztZKZb0ah4DhMocc8qSO6HTW7vxdO+KZRp5hFKH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BADUfPc8; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BADUfPc8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656192; x=1805192192;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hxmthuqqvIJq1/wdOTG+HdngKYym+K2CIuLTdSoWNbs=;
  b=BADUfPc84Ri4/6Npz5BoGn2L/rEeC4IE4uhYMDoHaWo5HVIKT14vwdqR
   nyYGYXTMSy5x9ENS4LEPMR75nmyL+a7jqTB6G2qALGZcOLE2FY2M+vES2
   7Fonjmsoy4/y2RsKi2KKCviWEjGq7YiGqFF31sRkhawCHI7VfMJuzykDV
   C0haQAGQ8RU+cAjOcd1ZQhNWGBA/WcIPQwfz7QudjpfmJXaO/QW9qyvlN
   M17NBR/erk0+zz2/MLGW4WnLKCJA30oCzeG8HHVuzM+x/O/4eLCI8cKKB
   3KfA4dVvfy9iL12w9H1f0Me7AkkpNC0skIZ5cvRmj2FzxpAdFntLEBcSv
   g==;
X-CSE-ConnectionGUID: kx6EJruqSjqoEIGPIwKZ3Q==
X-CSE-MsgGUID: 2ZuOwnkGRIyM5Jt5q2agGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="73682807"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="73682807"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:16:31 -0700
X-CSE-ConnectionGUID: zo+StE+ETomXZftMwMK5Mw==
X-CSE-MsgGUID: EMYVzMuJR/a3rfqDnB+s6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="259771841"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:16:29 -0700
Date: Mon, 16 Mar 2026 12:16:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	shuaijie wang <wangshuaijie@awinic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: fix firmware read on big-endian
Message-ID: <abfYem6tDkkIttsj@ashevche-desk.local>
References: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:20:12PM -0500, David Lechner wrote:
> Use get_unaligned_le32() instead of casting to int * to make sure that
> reading a 32-bit int value from the firmware binary works correctly on
> big-endian architectures.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


