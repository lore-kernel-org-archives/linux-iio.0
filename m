Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C253D283FDB;
	Thu,  5 Feb 2026 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770308772; cv=none; b=HrpmhSatYccyhwvUFoGkEBfZNKiMjcKf9InDTzg9V2qKLNycccMfJ7ICI7nYLj1CO0O+wkoBwnHIkCZ/IubSq2C12K2H9cS6oNkgZOlwk4mTRBAibQ847+lqr2dRQhKh/6i7BjgeIEmEC8IhMONMJlyanKb3aC30aWAXvufyxHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770308772; c=relaxed/simple;
	bh=WvpEvksRa1T3eGeCOef1b2+OJM4qaETdNgxPbH//Mm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJVfvt8/xo5tTs4uFaPoSoL6I70A6J8aL7bYHRb01ibM8WwkmkHvREp4v4NlD/7ON8DtGjjqICvFie5Z8JxPM76v3c5reaqwfmGT6JfXu7C9EeSQ5IHZtTWFKGLeSN1mtilZRDa1egeZEeWStTZrsG6mDZb0H6fapg+SgfYNcQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KdhugdRO; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KdhugdRO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770308772; x=1801844772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WvpEvksRa1T3eGeCOef1b2+OJM4qaETdNgxPbH//Mm4=;
  b=KdhugdRODfHeiHKYqU3NSC8GNFn5orIRkVyL7qXI35Xj1wUpIeCM3k0x
   emNn3+vSVZkHE2frEB3y4CiZoNc2MPH+yGIlZO+ZHcTjDNN6VWoKtJE0N
   1lKjwuik+OjcRX0bed9u1g6aAZtdxGY9I/omUXwZohfj33cX+MiqSqHnL
   XnSiKW4FNkcZ4WRovqfN/MDi+GJR75V/ijTR2duXs+H3Dio66aANg56+W
   YO4t2YbDVg2uSYH2A+wRpa6933/s8FVkDmP7ewypbze0672uT6aLxKrV7
   S3oyJwfZJYKitXNJfkVGRxkeWXgIt4VNlzOU81IsL04Mbs3xxQ1yef6sP
   g==;
X-CSE-ConnectionGUID: FjPGCHIARyCsYL20ykCZ8g==
X-CSE-MsgGUID: 3TXDnUHGRumLKv0VMaNRdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="96966222"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="96966222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:26:11 -0800
X-CSE-ConnectionGUID: WAmnt0XJSUyeYe7fmCBWTw==
X-CSE-MsgGUID: g/0QT8eJRfmg168mdDAlEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="210487505"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:26:08 -0800
Date: Thu, 5 Feb 2026 18:26:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v5 next 5/7] iio: sca3000: use guard(mutex) to simplify
 return paths
Message-ID: <aYTEnvrd6pZ9Lqda@smile.fi.intel.com>
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-6-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205131234.3244467-6-harshit.m.mogalapalli@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 05:12:11AM -0800, Harshit Mogalapalli wrote:
> Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
> error paths without needing a goto.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

> ---
> v4->v5: rebase it accordingly as we didn't change label "error_ret" in
> the previous patch.

I hope you see the difference and how the whole series gets better.

> ---

-- 
With Best Regards,
Andy Shevchenko


