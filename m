Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02236213E89;
	Sun, 10 May 2026 06:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778396040; cv=none; b=qvZl6CXoswKecLEcmnFQK1ZTqPetB2DoepqdXJzIl3b5bWpw3iMfzBGC6Livc39wmCJ3VKYfjLMXbGKHK1Rr8p7U6bH6LZ0o2WEj/oBuY4/JBoAjE4W1m570s28KMrRbPRCh4SKWaMgCR/7LG03ng29pQ8CoOCSq6lkuOX1eXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778396040; c=relaxed/simple;
	bh=NemeDP2fAnASZDKF7UG2r/tIoZY1kv4ype1PWFiRi3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mcxF++/KIsQVn7/GtRtDvBYoL+u67f6ylzlZ6RjTrxVjkT6ifsU9Y77Zk+mBO666J8dVZoLPIi6xhYpL/pdTeSaCSmFkgUdY4AMhMongNVOOjBUAfCeLAcs+Z/KT8qRUG7gqvTfH5SK86uw2eMPEuyu/3LcozY0NggRaazVgAO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l3LPVVpl; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l3LPVVpl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778396039; x=1809932039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NemeDP2fAnASZDKF7UG2r/tIoZY1kv4ype1PWFiRi3E=;
  b=l3LPVVplVzj+F1Qe6eKWIkt+Qb0ecmfQI1BSBT81ELA0flKH1XW8QAmY
   nvcZOE6NSO7Co/arOb+lxqiWDVmle5zlZOD3GsqWR3eEhYwhnvaI+puN/
   xn8Zvs+KFQAXl1DmegDMMMpKEZHzyz41c7owDgJv3nHEP2M8MZhx7xSnr
   70WA7Zxb9wT1Y5fvRLDLZRUQgUYEInDWJfNZnlcM5YluMoxxUVLfgefU4
   OId+retwjnIhMtORot6chnrDIgLWlCNm4pQSGVuMgT1DASJN7Qdr0yMzk
   mrqgls0olrb42uv36VxM7xUFSsyG5SejbU+vDx1JIK69BsrV9HNTGnDDA
   w==;
X-CSE-ConnectionGUID: SdKsUC1MSxaZ/4lYBSRpMw==
X-CSE-MsgGUID: 56yCT5ugS5GfkoOkio8wqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="79256928"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="79256928"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:53:58 -0700
X-CSE-ConnectionGUID: Mei6WgOVRyCqy9ulePFDCw==
X-CSE-MsgGUID: Jmzvh56+SmOdl1fNQ2/uCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="241510864"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2026 23:53:55 -0700
Date: Sun, 10 May 2026 09:53:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: tduszyns@gmail.com, jic23@kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: chemical: sps30: Replace manual locking with RAII
 locking
Message-ID: <agArgcwufi288K2l@ashevche-desk.local>
References: <20260509125201.29872-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509125201.29872-1-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 09, 2026 at 07:52:00AM -0500, Maxwell Doose wrote:
> Replace manual mutex_lock() and mutex_unlock() calls with the much newer
> guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> modernize the driver, and to increase readability.

...

> -	mutex_lock(&state->lock);
> -	ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> -	mutex_unlock(&state->lock);
> +	scoped_guard(mutex, &state->lock)
> +		ret = sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));

> +

It's the same mistake already had been told many times, do not add blank line
to the coupled statements (usually assignment followed by a check).

>  	if (ret)
>  		goto err;

And looking at the code, it's rather better to have this lock inside
sps30_do_meas() (it might require to create a locked wrapper as
sps30_do_meas() while renaming the current one to __sps30_do_meas()
to clarify locking rules).

-- 
With Best Regards,
Andy Shevchenko


