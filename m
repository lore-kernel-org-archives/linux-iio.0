Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445D930FF1C;
	Thu,  5 Mar 2026 07:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694688; cv=none; b=Ctab/RfoB6aVHJU7ML+2Igb2shzUSWCfDMLQjI48hbO0qwylPLYBD/Nx+/b3vIH+ScSL6591b7IIi9RskRYbaPQIbzkmXVOStfZNSVwK5YLxFbtZLSKPkWQkkDd9n5msULj7F/Qfd2NbVz2qDMxGw0DvB5iQ7wbJZMWmgllF3/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694688; c=relaxed/simple;
	bh=YrghpefAVzvUhvtMqW1qS8G69fAOW9+vaNoRlMTENBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/qmsZ+ztzb/ZwXaERDe2IBlocSinGL7tyvNJ5lCfqM+Pru5VIdjJJtDcKrrvyIuKBClrMLRebOUXSoniiq49jgC1SL0HKrUxFR5FyaZTnHdh59qDGB11jDBu5lYwPvY8eG25/v1DdEkDuKokF5MDvviWZEf1DZwilhSD/ZJYNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gWBvRItV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWBvRItV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772694687; x=1804230687;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YrghpefAVzvUhvtMqW1qS8G69fAOW9+vaNoRlMTENBU=;
  b=gWBvRItVYDL74bfy6BaGJ1o70ZCFpbQRmkaz2lse99nmq6cB0vOqd4ev
   D3nuL8d6H+0kL7SIZihPtlQa0OSmpHFm3no2oGO3RLfkN2g/3+AaxJGtR
   csAabpK2CFrAl7odl/DvopZIRZJsNH3Rso8qkNw1OG1wI6NsVPV/3klT0
   hGNkr7D3EJCT2qScGKM3twRrNkiDGvKqg1hGfovMtP6wFtMRyJskb5swx
   UPqAXBMny7iHomqPw8pqllTdBEymhgysfnSGEnWM+ANtfMJdONAFz6nnu
   zynOH9KPF5ZfwTbaMXclfDPdaGBTKdlaeCIkLhnRV9Qu+fSptuG5sQz/T
   w==;
X-CSE-ConnectionGUID: Cwx+19fqRB+gFT1mi0dT7Q==
X-CSE-MsgGUID: iSewA5lUQ/O25FKOWeXbUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="77643358"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="77643358"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:11:27 -0800
X-CSE-ConnectionGUID: cJBd+nTpQvidc5RSA9ByOw==
X-CSE-MsgGUID: qO1hoR8kQcWH1H3VXCHsHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; 
   d="scan'208";a="215864624"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 23:11:25 -0800
Date: Thu, 5 Mar 2026 09:11:22 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 1/2] iio: light: acpi-als: Register ACPI notify
 handler directly
Message-ID: <aaksmnbDUIfCUTqv@ashevche-desk.local>
References: <6147175.MhkbZ0Pkbq@rafael.j.wysocki>
 <8702898.NyiUUSuA9g@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8702898.NyiUUSuA9g@rafael.j.wysocki>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Mar 04, 2026 at 07:32:26PM +0100, Rafael J. Wysocki wrote:

> To facilitate subsequent conversion of the driver to a platform one,
> make it install an ACPI notify handler directly instead of using
> a .notify() callback in struct acpi_driver.
> 
> No intentional functional impact.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


