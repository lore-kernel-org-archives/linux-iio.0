Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C793A4414;
	Sun,  8 Feb 2026 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770557574; cv=none; b=H4cAeNMJ+NM5ov/K+t6K+w4vlZ/G9j509OA77Es8jjistm4cq0wVQCirZ+VwpoUF+kplxcJT7OQxgN8jnZ5156XM66sOXaCZUu6kXpJWE170f3P/VattoY97186bOi/n3d1SMGQrodLATFancKT7NMiuU3fEXvRKvgE5T4WzNuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770557574; c=relaxed/simple;
	bh=W9D++7GScuh3RcofqIf6HS8Cxewd3Tl7YIqQUsCHV3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMjKxeQvfKLPtVc25R+Eo4Ddi9UrCJrVp0YcUJqBTeSXnDnqjwKfcl01tzckyjoQ0MV9hSoNNMQ7+vQHETjc4JgFNG5w10LU+0eJXGdpUWvKxJ/YoCgN142m0Hf8P1DsjRk838BJuNYiRX+T8KaFpHW6E+QdEvGUm70JCA4qm0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hLpjP2vZ; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hLpjP2vZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770557574; x=1802093574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W9D++7GScuh3RcofqIf6HS8Cxewd3Tl7YIqQUsCHV3Y=;
  b=hLpjP2vZ+ibdlDtptTdWBknGjVkFIG9fkZk+Psu8TMU/FKtca9cE3/dG
   cGXTKydKEcAvGFC4iNRqSQNkrZSjCo8YBBuC8OGu9dgxs38aIi++6yxG6
   plvhPKx6a+WkSjClnkJmZj0YEsjkyROnLU8QTMyGiV+Og67Q+l85dvFZf
   PLRYTvIG1CC+u0LCkv07MavimpH9OCQsYLxGGDyNhJsbK8jjdteqfXQB3
   U0JNnnsv0KlkDM8QHPwNmiE6Iz1cKcjvSEcFrz3JaF3XxqXo3A1AFfOWk
   2hL5TeuK5wlZM84/p+ZJsl4RHQ6vwtKn46kWI51Z7M8j1rbTNooWioVUB
   A==;
X-CSE-ConnectionGUID: 8jXf7AVZSQmXt82VKmdWqQ==
X-CSE-MsgGUID: E/McVdVrS4SVjFn8xEaKrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75310926"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="75310926"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:32:54 -0800
X-CSE-ConnectionGUID: EWrzgYceQ+KMuxVAUBQq4Q==
X-CSE-MsgGUID: GvH8VyicQS+fIny2pleEbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="241974892"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 05:32:52 -0800
Date: Sun, 8 Feb 2026 15:32:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Neel Bullywon <neelb2403@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <aYiQgW1F6jRSoGuh@smile.fi.intel.com>
References: <20260208011659.53722-1-neelb2403@gmail.com>
 <20260208011659.53722-2-neelb2403@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208011659.53722-2-neelb2403@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 07, 2026 at 08:16:58PM -0500, Neel Bullywon wrote:
> Use guard() and scoped_guard() to replace manual mutex lock/unlock
> calls. This simplifies error handling and ensures RAII-style cleanup.
> 
> Additionally, replace msleep(5) with fsleep(5000) to allow the kernel
> to select the most appropriate delay mechanism based on duration.

Also, if you can fix checkpatch to make a suggesting for fsleep() it
would be even better, so we stop the flow of this checkpatch outdated
recommendations.

> guard() is used in read_raw, write_raw, trig_reen, trigger_set_state,
> and resume. Case blocks in read_raw and write_raw are wrapped in braces
> to ensure clear scope for the cleanup guards.
> 
> scoped_guard() is used in remove, runtime_suspend, and suspend where a
> short mutex-protected scope is needed for a single function call.
> 
> The trigger_handler function is left unchanged as mixing guard() with
> goto error paths can be fragile.

...

> +		{
> +			guard(mutex)(&data->mutex);

Hmm... This looks ugly, why not scoped_guard() to begin with?

> +			ret = bmc150_magn_set_power_state(data, true);
> +			if (ret < 0)
> +				return ret;
>  
> +			ret = bmc150_magn_read_xyz(data, values);
> +			if (ret < 0) {
> +				bmc150_magn_set_power_state(data, false);
> +				return ret;
> +			}
> +			*val = values[chan->scan_index];
>  
> +			ret = bmc150_magn_set_power_state(data, false);
> +			if (ret < 0)
> +				return ret;
>  		}
>  		return IIO_VAL_INT;

...

> -	msleep(5);
> +	fsleep(5000);

5 * USEC_PER_MSEC will tell the reader about the time and units used for
the API.

Should be in a separate change.

-- 
With Best Regards,
Andy Shevchenko


