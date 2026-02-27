Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FA42B73B;
	Fri, 27 Feb 2026 15:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772204631; cv=none; b=vGB/eGd07AnBuVh08jphCx1ARYz56OZMrAAaq0rtc2R59J8Q+/LdKfCoIK9VTo9Yv7Vy8y4NmMPutooJhwyGToktbDW1XzQ9dedjpZzJxASEjDj1fUqCcJxP+5fguj/Y3QbK6ZLR770CR6/21womztdrV0UN3h3zRrDmukEidNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772204631; c=relaxed/simple;
	bh=rq2obwdI7/jsEctM5gZZEqelmZRNfLw+bax6Trctn2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S+D1GYYLoiBkmlEG/rJDN8qF5cy+L3va9a8zjzuTDLTyPWGsRON6ZmSQQDILC2GprXg7yV15Wroj46s/pVQYiw9ftvrQTdrEZt3HeZY8p2qHISpPVbPrnSABKN2nuVtWBXzdz+KhNnNl0BKkeN6bCUw1tI5ubh/nqJAs7Z3lVxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WUkaveMF; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUkaveMF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772204630; x=1803740630;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rq2obwdI7/jsEctM5gZZEqelmZRNfLw+bax6Trctn2w=;
  b=WUkaveMFeYASrNDuYAHLoGUu6D2J6cTUjBosFZ1Q3HeNAcV4zRn01LRi
   2XkcYcEw81kTgVl7zf9FbfZbYfNEYhRz8tTit62bmqQ1Q9qQWa+XkZIJ0
   khfJHz3pqRmgrkynY8p91sDvNrsWuuH1D+6/FvN2EqdA14XI6c5zlSkI3
   muM+ZkOJxJeoZuNs6yAcBDBfc7pOcDn69a67ghDIEbHJYJoiPPpVi1ab8
   vUReLefTc3UpcL9l6Zp+GN4W5qJCf9/nUnzGU7wxSidDlta59Jz6CrVrR
   5YRtWc0NqZ+4e0koJoh8+xeModYeQUH5oSpQIYki/UG7W1yk95OSB11NB
   Q==;
X-CSE-ConnectionGUID: v88l+xcKT8OtF7qDh5uJRg==
X-CSE-MsgGUID: Okf55rc9RruvXBGKecg84A==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="83619323"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="83619323"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:03:50 -0800
X-CSE-ConnectionGUID: XxdpY/19R8CHwX91nBzIFQ==
X-CSE-MsgGUID: 53+qA7KvR+aKkZh/PCSSqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="239906473"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.180])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 07:03:47 -0800
Date: Fri, 27 Feb 2026 17:03:44 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/12] iio: use dev_err_probe in probe path for ADI
 drivers
Message-ID: <aaGyUMNzk9cNC5LG@ashevche-desk.local>
References: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227140152.77529-1-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 27, 2026 at 04:01:29PM +0200, Antoniu Miclaus wrote:
> Use dev_err_probe() consistently in the probe path of several ADI IIO
> drivers. This simplifies error handling and ensures proper logging of
> deferred probes.
> 
> Each driver is updated in two patches: first introducing a local
> struct device *dev variable alongside the existing spi variable to
> replace &spi->dev references in non-error paths, then converting
> dev_err() error paths to use dev_err_probe().
> 
> Drivers updated:
>  - adrf6780
>  - admv1014
>  - admv1013
>  - adf4377
>  - ad7293
>  - admv8818

> Changes in v4:
>  - Split each driver update back into two separate patches: one for
>    introducing the struct device variable and one for the dev_err_probe()
>    conversion. No lines are edited twice cross patch pairs, error-only
>    functions get dev introduced in the "use dev_err_probe" commit.

Thanks, I briefly looked and it looks fine to me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


