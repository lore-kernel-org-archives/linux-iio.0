Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5463839A9;
	Wed,  3 Jun 2026 05:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780465359; cv=none; b=MA28VGi0c6sD1IzmpLNL1mw/nR53yzbm5kfvdOEMqF39IcosWc/K5/yUhw0iRf0eHM/cV/iXaCLHEolF1ImwBxmKbDaxol5byvaAKd+FhgMu6Z/Um1AftB5Y+YKuAARExNYka8/rpkl+RBtjUTMdTicD0jhM6m4smx9VFcR7xu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780465359; c=relaxed/simple;
	bh=feSJtcv1sqVh9H+Eb+01wqliGMMW6flhikku7H4e6Uc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJ8q6c2DsHPcqpQ0q4DK/j40w9432bmXUWwmQFeg1MbjmHHhEkm6GrSgO/+zbKoJl0E1j54PvxMEanfCLGVKmX48SsiUowjOsvE3FtzwP8+C/Vb/HOLeC8LrzqiCvzsQATRDHdJ6ckcEn8TYiR/aGzfLFRBkczbi/mAGLbU5p5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gRrseuMF; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gRrseuMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780465357; x=1812001357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=feSJtcv1sqVh9H+Eb+01wqliGMMW6flhikku7H4e6Uc=;
  b=gRrseuMF0o9arFiFydS5twMhx53zC8OL/sg8m+QnGnxajtB93lkWxjV+
   CZ8tYKtKP0ffaMq2J7q3Obr+GlJHrpNfdu83R+l89yn7WDSUZ1mULhpPs
   65digwj9N9SOl8tlMSdcHvRipmnapPXYWpd881O0swJPhz5V4Eg9KQAUN
   y1uGKe7asagVDvYrZSezNq/vccIaDyBb/s94jf8BczeIg2njuhzX8dA/J
   Tc24tHReGLTzgimZ3nUxkuQOE4t2Oeq1P93rzgwOyWkE0bcK2/7lnpAuB
   nPgoOEg4PtCm/YIRnRd5UQyu8mmDDopghmsZGmcsFTF3bZLSLq9OYA/HK
   w==;
X-CSE-ConnectionGUID: eOywBCVuQBGIdrdo5Rlx8A==
X-CSE-MsgGUID: RJuVtadHT1+fEJlRTCpWCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11805"; a="81119165"
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="81119165"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:42:36 -0700
X-CSE-ConnectionGUID: RVZTZQw5Ru+gikx511p5yw==
X-CSE-MsgGUID: JijXSK6GT7eU8nqH5iLDRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,184,1774335600"; 
   d="scan'208";a="249192565"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.116])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 22:42:34 -0700
Date: Wed, 3 Jun 2026 08:42:32 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: wbg@kernel.org, m32285159@gmail.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] counter: ti-eqep: use devm for runtime PM to fix
 probe error path
Message-ID: <ah--yK0SXW4TC2xC@ashevche-desk.local>
References: <20260529095834.2561-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529095834.2561-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 29, 2026 at 02:58:34PM +0500, Stepan Ionichev wrote:
> ti_eqep_probe() enables runtime PM and takes a reference manually,
> then returns directly via dev_err_probe() if devm_clk_get_enabled()
> fails, leaking the runtime PM enable and usage count.

> v2 tried to
> route that error through a manual cleanup label, but mixing a
> devm-managed resource (the clock) with a manual pm_runtime unwind
> is itself wrong: the devm clock release runs after the manual
> unwind, in the wrong order.

It sounds like unneeded detail (because started with what v2 did, which
is part of rather changelog or cover letter). Perhaps we may rephrase
that in a way that "Manual cleanup via goto will mix the managed resource
allocations and unmanaged that leads to a wrong order on the release."

Also note devm-managed is tautology since 'm' is for managed.

> Manage the runtime PM with devm instead: devm_pm_runtime_enable()
> for the enable, pm_runtime_resume_and_get() with a devm action for
> the get/put. Every probe error path then unwinds through devm in
> the correct reverse order, and ti_eqep_remove() no longer has to
> touch runtime PM.

-- 
With Best Regards,
Andy Shevchenko


