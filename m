Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D3362157;
	Tue, 14 Jul 2026 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784026088; cv=none; b=HqD+DAvh1v5wx/91TYjIJT1uCMNa20g2sQLvkPH0pIxOecoakc5K7X/aQaBpUGqJ1iysDyQBo+8K0OpF912LgNi637RA63svdCh+BUb4ZH05KHlLrlducqLtFT6hjq/uXrAz+1iSKZhtSooA1qo61uYm0GYBr3JB2n5Bp7snSOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784026088; c=relaxed/simple;
	bh=mqtnxXfhqmFfY74wQ7jDNamg3l+k7teJBMf5sl48a8Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da9yN7/W96aR+sNTPm9lUdkcYlQQK37GTkd0Vjda2VwENs0knr4pwTN6CQJVMp0kE8gchcm0q/P41RONhpusXbzRnkW+FsFsQrA547k4cPCxALXTFqD6y4dC+JF6OXa6m9m019+QoqKLqa8ECOXsfPoX3mlMsZIncC4Q2hbLBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUVMrHxL; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUVMrHxL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784026086; x=1815562086;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mqtnxXfhqmFfY74wQ7jDNamg3l+k7teJBMf5sl48a8Y=;
  b=HUVMrHxLc3NgeleIHERNnvtuAjvn3FJiLr4124F50E16L2Qxr1y+vSBy
   Qvk5LvK6DYHoBViHlCGRvu8WPzvMzYASpm4Jhu5mqX70MRWBSG9FQ2dVc
   FPZfbXm2dbVWlUTn76ZrWAkva1glIjg2Ysi0VKxx5sjyQlrMTyKI1fOk2
   187keOAPdWotMndODKUhy2F9Szfm9zbwmIpBuszBa3u69DIX6nM72BVhF
   alFmZXuqrplLBn74ZsxIHMlr/wTcvIePBixnlyoI69j5LP7Ylh7xome8E
   I5Gmrl+2IW3sMnv9q0am6QuG/dEhu1o8ymBtx77ON9DFaZwwqSKQ7UsfS
   Q==;
X-CSE-ConnectionGUID: 3rWGMY7ORKydHM9548FjcA==
X-CSE-MsgGUID: KWlutrN1RjSQ08tcZIxf5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95290519"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95290519"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:48:04 -0700
X-CSE-ConnectionGUID: CC2QOze0ReWJc1Cwr6uevw==
X-CSE-MsgGUID: ucqagJ9HQEuqgJe5WinFyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="285897909"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 03:48:02 -0700
Date: Tue, 14 Jul 2026 13:47:59 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Can Peng <pengcan@kylinos.cn>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dac: ad5446: fix OF module device table
Message-ID: <alYT34Imd3jCoYWa@ashevche-desk.local>
References: <20260714091846.136278-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714091846.136278-1-pengcan@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 05:18:45PM +0800, Can Peng wrote:
> The ad5446 I2C driver exports its OF match table with
> MODULE_DEVICE_TABLE(OF, ...).
> 
> The device table type is used by modpost when generating module aliases,
> and scripts/mod/file2alias.c matches the lowercase "of" type.  Using
> "OF" prevents the OF table from being recognized, so no OF module alias is
> generated for the I2C driver.
> 
> Use the lowercase "of" type so OF-based module autoloading works.

Good catch!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


