Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EC635C6A7;
	Mon, 24 Aug 2026 06:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787553018; cv=none; b=WRM0spGaWK0Ue6niPAoK9N7U8GbaEna2fyC/KEfMrk5qIeIOTyZHCXNJ2L3dpMn3ZwKQfgcfdNG3UCrCBeHWwR/slGv1FW8kX1Z74+omZOqA9irey9KjUj8dqmXGd92TIKPAuQ5jUGlLNP7zPGHRsrv+kOc+qQ0cDIeJk1KmoB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787553018; c=relaxed/simple;
	bh=bP8NJ/BJFvMF1GkE6Laf1gvc0VmiSRPouP8h58M+mAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qg1VRk0EL6wqiScXTab14F3rr+0Qt7uNDSjnVrDrahnPh0uyw7l3O+ge+o+WWSrbJczPEYo4KUOWU/mz1p43xg0JXbsAulDbUxAvYfTa6cpmIrLy+f5hPE4DFVaf7frbz+0VD7yEPfmMVJ9nDAlVHGTaUlp1m3sncoBafXNia2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPUjiRa0; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPUjiRa0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787553014; x=1819089014;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bP8NJ/BJFvMF1GkE6Laf1gvc0VmiSRPouP8h58M+mAM=;
  b=cPUjiRa0arNh2QmDp2EEwrYCCj1eMYHCre+3X2BIi+yuOwt34M/o4LYc
   9OThisqGoc1n9yIHY71iIjriSHWuGKAXSuZ1xNzkirZyyK8TK6NSGZE85
   F+hMrVxKvpWO9g9ezWkUwoAZNR3RlpgNgH4Cus6DeTjP/+sF0p/Y+4jiA
   U4Z09NoS+mFYPSPbJ/Ral+HuHEzomNyYGQK+iRkqSNiWQo1Gx81uM67u7
   B7D/tPo+fHKnrJalrVfgx+1iMZkTd1rlfgs4iadPxiGp/AfUGUmvG3NtU
   VJgbH4CFOpWauJ4wGhBrCgH13ZHihJsqkg5DK+qUK6HjXKVG4ZNi0X+DB
   Q==;
X-CSE-ConnectionGUID: Io8zEUVzRgyuKZf2v1w/Pw==
X-CSE-MsgGUID: J+R1t5HIQzmVrMSoqlkCkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88196116"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88196116"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:30:13 -0700
X-CSE-ConnectionGUID: pHCl4aMJR061RFxZt6aAcQ==
X-CSE-MsgGUID: qWmBMFvdRyGaXAjtkSK6JA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="291758509"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2026 23:30:12 -0700
Date: Mon, 24 Aug 2026 09:30:10 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Fan Wu <fanwu01@zju.edu.cn>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: gp2ap020a00f: use iio_trigger_poll_nested()
Message-ID: <aovk8rAfrsvbfOJG@ashevche-desk.local>
References: <20260816184602.2dd023f6@jic23-huawei>
 <20260817024023.291319-1-fanwu01@zju.edu.cn>
 <20260822005639.539ccf9f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822005639.539ccf9f@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 22, 2026 at 12:56:39AM +0100, Jonathan Cameron wrote:
> On Mon, 17 Aug 2026 02:40:23 +0000
> Fan Wu <fanwu01@zju.edu.cn> wrote:
> 
> > The threaded IRQ handler queues an irq_work only so that
> > iio_trigger_poll() can run from a hardirq-like context.  The driver's
> 
> A lot of spaces before that The!

You mean two? This is an (old) standard. See also '  For' below
or '  Something'. I haven't commented on this, because it's consistent
over the text.

> > own buffer consumer does not need that context:

-- 
With Best Regards,
Andy Shevchenko


