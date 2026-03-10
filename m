Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CE026D4CD;
	Tue, 10 Mar 2026 18:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166868; cv=none; b=oBwh8NXrA2QEVtfGhkp8Ytg33h3B89j2Cb+7JoV4F/5kY9vG6RVkefArsQDRDhNj+kCokFQl6BX+d/zeszZUucJ6uCPFB9sQDsAovBSHcUz6DkNDG8j3QwLxpZ/6PX6BXYQHjk3udkBOmS1RMNQQNc18FoKueewzsy9Bwb61AxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166868; c=relaxed/simple;
	bh=q8EMdTShJbbHJNxNPWpbcmHpxdwS+a/PSL5h/ia505M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RezA/ZdcOCqiANFQLGzgZs3jI16Gsg02/ECh/1a67SUsDwvibChk3/z3QQ3o9ELcmWVLUlbjjBkma5UmyA7hjUG8guMbSYF3SbjMA0F8hOHuk+6Nv8i/qIYWbMqN1+iJPFie7EPhHFQMG4C/6D+dKcUdXIigTdul5tCk10f7G90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L+C6Ccil; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L+C6Ccil"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773166863; x=1804702863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q8EMdTShJbbHJNxNPWpbcmHpxdwS+a/PSL5h/ia505M=;
  b=L+C6CcilbqZ1JiUcUlOGMv9RaHGO9c8gUl38XTRXJJxHU6PP0Cl0H8y9
   K2aneA8IrzIe4WuGgNu5zdfc2SetaJNJF6YUhJh+0YZ7nk1q6mrWKHOFf
   0ht/9KHn2OFuJM90C6WTX2GCSipnyC2GyOJWQuAX7eAXz2p3qve/GhcvA
   oVgXhAVPa8WOFmW6epP+Tzs0kpAi1g9wMOhlWPRZ5l+HjDvfj1PHD2Ive
   xYBiddvs1l3CetEEEh6uL6kszQ+vM1EMayQ+4OuJ77R7Nu802o1mSrqdJ
   kWmR0GdDdQE+E7F85UHoYdImqEXOUwRjWXz++yDlW65KBpNPR+vS2YoML
   w==;
X-CSE-ConnectionGUID: Lta6Nxt2TNmacpT1OM00Ig==
X-CSE-MsgGUID: jqMO/PASR724TqG/3XdT6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="91796636"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="91796636"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:21:03 -0700
X-CSE-ConnectionGUID: w7KgPiESTrmKmKDfPBLB/Q==
X-CSE-MsgGUID: 1vdIHF4pQZu2TeW3hPbSSQ==
X-ExtLoop1: 1
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.54])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 11:20:59 -0700
Date: Tue, 10 Mar 2026 20:20:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, me@brighamcampbell.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: dac: ad5504: sort headers alphabetically
Message-ID: <abBhCWVo7ARH33oa@ashevche-desk.local>
References: <20260310174835.24209-1-0rayn.dev@gmail.com>
 <20260310174835.24209-3-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310174835.24209-3-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Mar 10, 2026 at 05:48:32PM +0000, Taha Ed-Dafili wrote:
> Rearrange the include headers in alphabetical order to follow the
> standard kernel coding style. This is a preparatory cleanup with
> no functional changes.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


