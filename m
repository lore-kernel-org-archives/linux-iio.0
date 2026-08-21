Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA562366061;
	Fri, 21 Aug 2026 11:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787310907; cv=none; b=CSoWozPfU8mobgJFSLnSu9nAYDMtXbfJRBhWl6u6cUPv7pu/f8qkzVQn2isgQVNB87t3JY2HTU8UXFE3Kttzy4KMEefXrBZgQohTPyMwd4D2aufwnDBhNxSIRPmbAzD+N5fSuAYdoUMD1bqWslw/VGW/VQ+/MkhXjeefaCGf5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787310907; c=relaxed/simple;
	bh=Jbk3H6AprfRJXcRLMYeislUkk12A7dPXQjqEeDw3Ogo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWAeiKTFwg0bX+7RmkY3DcbQkxyOWsFVDuEtAsiMZy9KUVu4MBFK6VGWns4mc8mYJ9L2UkkbRWPoFgvaOhN30RJ7Eb6GHew5Suw7LTfNC1Li0kZLS3nRkaCSj+Xn+FATjxeAdmne8LL3El2NBz5GEWks+OruHqEGX5RZNncInsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SreETIQa; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SreETIQa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787310906; x=1818846906;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Jbk3H6AprfRJXcRLMYeislUkk12A7dPXQjqEeDw3Ogo=;
  b=SreETIQaj7p12abiGBAnqjRT26Ex1+a09wsq4OE9Ft1XtP2eouMhLlao
   hOAKHJ0NjzmFKJg81dpGpE9aAqRjKa0IDdPzcfD+I0/A5WFKU2wB9miJ+
   7qyG6V2YMkU95cl/1D3+gPtRVfjjuDnGu1guKvqTr671YAoYk7xuqnDsu
   8PfpZnl3jxyaRK4DzsSKq83QVfOEl0ffcUPexrvwT1OzdAwACm9tdgY19
   d1N0EquJp60uCkVXyXB6joxi+1Sp3uZpV8XjATMgXC5aSkjzWagZXo3ai
   HVIi/ObAbv9ebBZC9YHCAPYYIzx3an5JyjJ1s4hcl5pLuSSaxb0AkVeGt
   Q==;
X-CSE-ConnectionGUID: 2C2Bp/c+TMebgAE5M6YHZw==
X-CSE-MsgGUID: zsQh678tRl6s3gktF93McQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="87776718"
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="87776718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 04:15:06 -0700
X-CSE-ConnectionGUID: hCjq5o6RSC2sHlaolrLJ/A==
X-CSE-MsgGUID: xs40E4+RTteTNRZCN/RhTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,235,1779174000"; 
   d="scan'208";a="289847310"
Received: from abityuts-desk1.ger.corp.intel.com (HELO localhost) ([10.245.245.241])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2026 04:15:03 -0700
Date: Fri, 21 Aug 2026 14:15:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: jean-baptiste.maneyrol@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Message-ID: <aogzNOaeOHQ732oP@ashevche-desk.local>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
 <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 20, 2026 at 09:02:37PM +0200, Jean-Baptiste Maneyrol via B4 Relay wrote:

> When turning accel or gyro on, a sleep is required for letting the
> mechanical part stabilize before reporting correct data. Do the sleep
> before enabling FIFO data to prevent push of incorrect data. This is
> required if the FIFO is already on because a sensor is already running.

...

> +	/* sleep maximum required time */
> +	sleep = max(sleep_accel, sleep_temp);
> +	if (sleep) {
> +		mutex_unlock(&st->lock);
> +		msleep(sleep);
> +		mutex_lock(&st->lock);
> +	}

Doesn't sounds correct. Here it breaks the atomicity. Is it a problem?
(Imagine a few CPUs doing something with this driver, is any other thread may
 intervene the flow here?)

...

> +	/* sleep maximum required time */
> +	sleep = max(sleep_gyro, sleep_temp);
> +	if (sleep) {
> +		mutex_unlock(&st->lock);
> +		msleep(sleep);
> +		mutex_lock(&st->lock);
> +	}

Ditto.

-- 
With Best Regards,
Andy Shevchenko


