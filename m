Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CD540B398;
	Tue, 16 Jun 2026 07:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781595793; cv=none; b=US1Tj5rca2W9JVK8soYb+w9Oyc1G+EU7VUUoJM8rrqQZTaJimvswyACzCzM+tLEzrERfzbwUjnC0apfF7uLydVBXICap/2c/ZUOAfulazMXL+O2akK/sKvE6i2oGVTQpLo4fYvWwaZe5HzA9SKfa9uFaYXdAQx3gwdg6ZZPj7G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781595793; c=relaxed/simple;
	bh=GJtFDRilXTuZRcJctFaE5YyUlDIoJGp0D9pkihkxevU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WqHWodBG+XYm0DICNwMEfZTgWwoLa/cJbacoTvHBoAZuLzT9qfy/XPPVjCTJbQizNOOo2hYP3C8Ggmc0Vd/tbISYdS5kwtY/rq0hoBiHTvJhV+OH5+YIL5fQ/pVrw0RmKlb5Bu46JlP9SOfYLMhHa6SB9QPV4v00KMeIXfbrsHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AffMyYVU; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AffMyYVU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781595792; x=1813131792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GJtFDRilXTuZRcJctFaE5YyUlDIoJGp0D9pkihkxevU=;
  b=AffMyYVUenyYAZLHpEnOBDtjvBtyxF17t9FVB5mNj2VhHjpeC+l+M4c8
   EjjBfzgfS05uhhseq+n6WO1wR2SCl9fp55EchRXsDGUrwYbHqIlzrw4sP
   F+xNcStuyUw3ZFiRkJ+ioVDiafvNaec9ZJeEwlJsq+FVLObGSXXXwTnEW
   UoDL3ELIp9GwPSPC2E4EqgjOKviEVEcvthta9MwgJvPj0ZIhMqltL5TdR
   CO/nbnasuxxEnLf8i5Nh9SwGW/Uo3o0E3R5i65FPzL+mOfC6Uh7YDG9Ri
   h8DKeN6gVVx8OyQHIb/F1n8s93eqw4ZoQuMBGl12/d0gz71I3LqmocTUD
   w==;
X-CSE-ConnectionGUID: zPffoZE+SG+ZK7Vw/hWWrQ==
X-CSE-MsgGUID: bhT6ARI6RhmAmUcbiqRznw==
X-IronPort-AV: E=McAfee;i="6800,10657,11818"; a="82395845"
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="82395845"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:43:11 -0700
X-CSE-ConnectionGUID: JGqqX0CQTxitv246kc/ang==
X-CSE-MsgGUID: uv8xi63kRma/+gD3t+egQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,207,1774335600"; 
   d="scan'208";a="277892646"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.153])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2026 00:43:07 -0700
Date: Tue, 16 Jun 2026 10:43:05 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "Erim, Salih" <salih.erim@amd.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
	linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/5] iio: adc: add Versal SysMon driver
Message-ID: <ajD-iS3nANaXOZty@ashevche-desk.local>
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-3-salih.erim@amd.com>
 <ajAKkqMO5jdQjKgS@ashevche-desk.local>
 <2998a9fc-4b9f-49bd-8020-697081401f85@amd.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2998a9fc-4b9f-49bd-8020-697081401f85@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 15, 2026 at 04:41:12PM +0100, Erim, Salih wrote:
> On 15/06/2026 15:22, Andy Shevchenko wrote:
> > On Mon, Jun 15, 2026 at 12:37:19AM +0100, Salih Erim wrote:

...

> > > +/**
> > > + * sysmon_core_probe() - Initialize Versal SysMon core
> > 
> > It is managed, please name it accordingly: devm_sysmon_core_probe().
> 
> Will rename to devm_sysmon_core_probe() and update callers.

I believe you also want to have a proper namespace. The sysmon is to broad.

The easiest solution is to name it as devm_versal_sysmon_core_probe().

> > > + * @dev: Parent device
> > > + * @regmap: Register map for hardware access
> > > + *
> > > + * Return: 0 on success, negative errno on failure.
> > > + */

-- 
With Best Regards,
Andy Shevchenko


