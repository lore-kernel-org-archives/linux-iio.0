Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428A3BB9E4;
	Wed, 29 Apr 2026 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777488578; cv=none; b=Bhn0e5vlaXESLfgkMGKyE4ObRarCBlNTrSlI5cbjnDLS3tqaDq+y7DJCXBOuwvzX4hJsa/RJkr7UOqBwvaEJVjfOvmM1Zp3bEXP0mimDYji/3fKUAU7107VtN47jNYFIdaSOcO4bcYHSYkwGY38Gp5ouxRJMS0ernO6OVlpytUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777488578; c=relaxed/simple;
	bh=WnLYOACUjtaK5n3MgY1yIetQs3I59sfWjGjjqjxJg+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0n9ObCOtewZWkMN8jnAZYuDyxDJoRrWiaF2uPQJKbFRDlTaQiNMRhf+EHJEzLWa6A3qyyIsUN+eG5oak2+RoN3ydT0IXfvyMAgbnAxs5XfDLXi6FRry3vTJgFqLGMAikw+leS5otHlJfOh+xThupmLOsEWZTcC/HDQCm8rYHfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K28e2LpG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K28e2LpG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777488574; x=1809024574;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WnLYOACUjtaK5n3MgY1yIetQs3I59sfWjGjjqjxJg+g=;
  b=K28e2LpGnuuxg2/3foA4BNNQaKmPYrpQFrtN418HE/crVgx39lth0WqU
   LZ57sW+V6z3L9TlaycgGkq5WJQrSeZu0vPrfU/og4beCcyYgMpwd0RPVl
   WDuaWw88YCi+ljDAWi8xIX8Q67wUwOIJrzYMzN/nKMI8G73jQvs/0+1qQ
   K73Z02sFcaTJXVsNA7U02LeaZ+ux2Ry4Jf1vGwltZ/zj5IGopWCrIQvhs
   sVPp9cyBxTqgpA9p7YI6Ena8bwxKk5T85+ff88TFNJ6dWXx8la1268olp
   iRdoyCTq215l9ApLDfSugL7c8AUlhkkBbWIwDY9vu2hyIs+aShKtCIeXy
   A==;
X-CSE-ConnectionGUID: wbsuCpV0SziU953FUGgI+w==
X-CSE-MsgGUID: 78xg14N4RVWpHq7Y8s3ffQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78322611"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78322611"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:49:28 -0700
X-CSE-ConnectionGUID: 074RzClnST2/pYcStRKTKw==
X-CSE-MsgGUID: o9umrVM5QSCWWLEvFb0s/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="229750727"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 11:49:25 -0700
Date: Wed, 29 Apr 2026 21:49:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/11] iio: adc: hx711: localize loop iterators in
 hx711_read
Message-ID: <afJSsrKPn3v3fXrp@ashevche-desk.local>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
 <20260429054544.123862-9-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429054544.123862-9-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 11:15:41AM +0530, Piyush Patle wrote:
> Tighten the scope of the loop variables in hx711_read() now that the
> trailing-pulse refactor is in place.
> 
> No functional change.

Suggested-by:?

...

>  static int hx711_read(struct hx711_data *hx711_data, int trailing_pulses)
>  {
> -	int i, ret;
> +	int ret;
>  	int value = 0;
>  	int val = gpiod_get_value(hx711_data->gpiod_dout);

Try to place it to follow reversed xmas tree order (yes, it doesn't and won't
fully be, but it will be step closer).

	int value = 0;
	int val = gpiod_get_value(hx711_data->gpiod_dout);
	int ret;

But as you see, this needs to be coupled with splitting definition and
assignment of val, hence

	int value = 0;
	int val;
	int ret;

	val = gpiod_get_value(hx711_data->gpiod_dout);

This part should be in a separate change before you are doing the loop
iterators.

TL;DR: Should be two patches here: 1) split val assignment; 2) this patch with
proper location of int ret.

-- 
With Best Regards,
Andy Shevchenko


