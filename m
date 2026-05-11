Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412B136EA9A;
	Mon, 11 May 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498385; cv=none; b=YCr2TH+RsWpPvIyI+sKyq+erofvDp7pq4D26c+zDigJ0pRNmy7zlBPLjkzjtk6wfhCEMaglPn3odcOEB3iEGsMuCPmbubnJMUR4yYR8pgM7WzTncBk8PYX+Qt/MBfzhRP1DECDdez4Q+fTANSZviAc+5Yzzr7eabh5eNB381P1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498385; c=relaxed/simple;
	bh=TtvyUl/c+6FE1gfOnpwrGMZMFPGUWC6uAnEyT7o1q6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bFNTKtJmJyS/gUtcVN+CudA6LksIXnE+fu4HA+L9oJOvNLPx4Y2lZJbavx0p24eTY/QkQd82hoFb13A2ixzTqMCV0ea1cWWAULhEi5ozW6y9g6mKcya9v4mlR0QfOquXe7TMgMMxwLJJEdq/DEtVA1Zm0mmRMZdS0wwnTwVnoIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bVjTmwxY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bVjTmwxY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778498384; x=1810034384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TtvyUl/c+6FE1gfOnpwrGMZMFPGUWC6uAnEyT7o1q6U=;
  b=bVjTmwxYacHQpfcP3z822GBDMP1b8MbGX5swRs6fSchO73qUrN7/wPH9
   0R0rUHlzmDowYo3xVfZC2HDFoW8mIEAfAXyh8HQlAtcqY4p32GGPASs7+
   979TE9MXJkBiddhn5nbvS3cxUqCXnGgFUpBUAohafzoDXDwz2IO4ue7XV
   0Q4GCwLOcfC2o6vXGyCgCph3PMO/6fAO2VkHsUHGIooTcgIHehEqJC9vo
   qjo8jfqndKLckPjmbtOp6XUqmwRdXOIAvOH0z9c80NgkAnZgFycT9XMCo
   W74qNXIqIZp8Llvq3dFtDyqV+e6tZTyV7by9FFFRWjhiLcNDWMQd0g6wc
   A==;
X-CSE-ConnectionGUID: IBH/RJjESv+HaYLJoOmc9Q==
X-CSE-MsgGUID: kQpBvafPRba3shxRdnNicg==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79483342"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79483342"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:19:43 -0700
X-CSE-ConnectionGUID: uNr8O5ppR0+qGwVsL1417g==
X-CSE-MsgGUID: bnDcKcudTEuxo8PKGIiYXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="241401560"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:19:41 -0700
Date: Mon, 11 May 2026 14:19:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 05/11] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <agG7SvqOB8fRM0mA@ashevche-desk.local>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510194947.31997-6-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510194947.31997-6-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:19:27AM +0530, Piyush Patle wrote:
> The gain-to-scale table is global today, so probe-time scale updates for
> one device overwrite the values used by any earlier device instance.
> 
> Fix this by making the gain table const and storing the computed scale
> values per device in hx711_data.
> 
> No functional change for single-sensor configurations.

...

>  	for (i = 0; i < HX711_GAIN_MAX; i++)
>  		if (hx711_gain_to_scale[i].channel == channel)
>  			len += sprintf(buf + len, "0.%09d ",
> -					hx711_gain_to_scale[i].scale);
> +					hx711_data->gain_scale[i]);

Since you touch the only line of continuation, fix indentation at the same
time. No need to resend for this only, hopefully Jonathan tweaks this.

-- 
With Best Regards,
Andy Shevchenko


