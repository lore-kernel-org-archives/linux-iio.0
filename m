Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD158B67A;
	Sun, 22 Feb 2026 19:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771787236; cv=none; b=ZLN3HyBwLFzdzJt0aZGPSLRkGk9ukiCXM/novEsiMPsix9wXiAC6aZRp6kAhoZ7wdIWPwXLmScxcgeihPFEMQyePUybDNCck69KoxVy2PuxSgp4A5rMYCQv2SiGSAk6AyUszAl5jhyDOqPgH8zvix99dhgwO3UecvuXF0ZymIU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771787236; c=relaxed/simple;
	bh=GIcyxd12EPmrgd4WiuBKngaOZtiVXYNloCriw7mYZyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DcE1t0Dlb9Y9TK+s1YjPrIaqi9156c8qcBfcvaGZObW8DZuIrgb3ybhLuBbFGexJIbHmb1OT5MJJ/k6/3G2JAZ13CrdquRgMkim6GrlzGSYM75lTg8zpRYUCFleggY5uqFGQUuIHRDHBo7yujlb1Po0qNMdVOloLAlpP4f6Pl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MuUXd+Lc; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MuUXd+Lc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771787235; x=1803323235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GIcyxd12EPmrgd4WiuBKngaOZtiVXYNloCriw7mYZyA=;
  b=MuUXd+LcxIMQw3pLiO8qWNa/C0CMGw2X8+kh1BBHapGu6yKuNEcCaBKk
   RFf1YcLoxVjvrCqqq7W8c31LZ2ggM0l8Nawl1B7eA69xmm0fkAXUlJykO
   1zqBpagTQhnjpFikZYkrwr+9uAhH18Cpsl9gZ7bhBbMSZI7ztznM3P4ik
   P46PMvqyGEc+O6KSlEW/7N9qHdhBqP0O9Hw/3gu3PdiwnzRANdsDZq4Nl
   pNDhtF5rE6hZwpowdiyAZP4eyHlOgdQ15H8w92CHV+YmphE4Ky2ZQXsln
   /9uRmu8tSnNOkqlFSex8acyLtrWGDRSYg3HH1qNKr1Hfewy/wiaKzMEAl
   w==;
X-CSE-ConnectionGUID: IHi6DnSiTXKyuLwOnuUJtw==
X-CSE-MsgGUID: sfkIlHn3Q5SXXQkMxWTx2w==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="98254181"
X-IronPort-AV: E=Sophos;i="6.21,305,1763452800"; 
   d="scan'208";a="98254181"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 11:07:14 -0800
X-CSE-ConnectionGUID: paco3JdpRNiHea9wjzG4wg==
X-CSE-MsgGUID: 8QJBAGA0TaaMHxE84w3xxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,305,1763452800"; 
   d="scan'208";a="213777483"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.171])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 11:07:12 -0800
Date: Sun, 22 Feb 2026 21:07:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2 1/1] iio: core: Simplify IIO core managed APIs
Message-ID: <aZtT3pDS9X6pGVnT@smile.fi.intel.com>
References: <20260220132912.2392102-1-andriy.shevchenko@linux.intel.com>
 <20260222165411.427e6a9c@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260222165411.427e6a9c@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 04:54:11PM +0000, Jonathan Cameron wrote:
> On Fri, 20 Feb 2026 14:25:19 +0100
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > Use devm_add_action_or_reset() instead of devres_alloc() and
> > devres_add(), which works the same. This will simplify the
> > code. There is no functional changes.
> > 
> > While at it, inline devm_iio_kfifo_allocate() into its only user.
> > 
> > Reviewed-by: Nuno Sá <nuno.sa@analog.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Nice.  Applied

Thanks!

One minor thing though. The iio_kfifo_alloc()/free() uses variable name 'r'
while devm_iio_kfifo_alloc() uses 'buffer'. I was thinking again and now
I probably would go with 'buffer' in devm_iio_kfifo_release() as well
to have a symmetry with the devm_*_alloc(). If you think it worth changing,
may you fold it? (AFAIU the applied patch is still in the pending/testing
queue that is okay for rebase, squash, et cetera.)

-- 
With Best Regards,
Andy Shevchenko


