Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D4363C72;
	Mon, 11 May 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498566; cv=none; b=ohSWbqnH/hHdyttSyk0mjifb2uJrDU0AZJz0AVWtHk5wNzf5G1pc4D7SlfvpEKCr+WzlPEVfctvrqdHqKa/q7Ssjd4QSf80IIrzwO2omuRxxqK7ac33DE9kKThqNwnS40MZkzj8Fv8reEl7xw1INi/7h2bt2OujRyRRBLPZqlE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498566; c=relaxed/simple;
	bh=gP7NwIAZkF4aHsqDll6WB11/xH23xQWfuHD0CymWor0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FS1WyxQmlNN3rMr2/SDa4bM+sDNbG5YUqvHGk7KsdszZa2E5PR/+dE/bXXf3NflWP7aOd0aRgp6dHQcm9GPCM6OnNXOeMX2q4okBPpHWxHy5jr7QJqdMd46Nfo5iiEafHl1TUx+6DgCcexZVYiBZtKOusQJR6NFyINJcO3opNj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J8PyY0Yk; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J8PyY0Yk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778498565; x=1810034565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gP7NwIAZkF4aHsqDll6WB11/xH23xQWfuHD0CymWor0=;
  b=J8PyY0Ykyc8RhFtx+4yrCOEuebruQwV/Wit3EKYU3nvHTwUmpUv/tNGr
   GVhdD4tOhlCbn51Jyt/T+3xVFw900BhP6hn1UagEjefMM6tR3wc6bIUeh
   8U96Wpro1IMFbjdTZL84g3DxsncD/QwKmnVQrr2S0599CKwErFMARED/e
   t2vrKB3kHII/OMyurNvnldD6eDKdmUfaITICBIig9dgIxLuI3JWK0wz6x
   7Ymx/zHDgzeCstjXmVK5UQQxE4VtpRazSMjIEIV96148nxMmqvoEuRXmQ
   8+8fT6VLHwSLSWgMFuE5x8EhWx0qYlIt/3Q9RZ9E8ELMxndPPMIvYSmYD
   Q==;
X-CSE-ConnectionGUID: isPuqcmJQL26OXjg8FMQxA==
X-CSE-MsgGUID: VeJFiRfEQ9qY9Wt5UsV6nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="81946015"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="81946015"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:22:45 -0700
X-CSE-ConnectionGUID: GvSa8h+kTlKuiZ3CT9W5FA==
X-CSE-MsgGUID: fhMAe9uqRpuWyp49sYswMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="233097187"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:22:42 -0700
Date: Mon, 11 May 2026 14:22:40 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/11] iio: adc: hx711: split variable assignments in
 hx711_read and hx711_reset
Message-ID: <agG8AG1srKZ4oWp6@ashevche-desk.local>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510194947.31997-9-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510194947.31997-9-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:19:30AM +0530, Piyush Patle wrote:
> Separate the initial value assignments from the declarations in
> hx711_read() and hx711_reset().
> 
> This is a small preparatory cleanup before the later loop-iterator and
> variant-specific changes adjust the local variable layout in these
> functions.

...

>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> -	int val = hx711_wait_for_ready(hx711_data);
> +	int val;
> +	val = hx711_wait_for_ready(hx711_data);
>  
>  	if (val) {

No, blank line should divide the definitions and code, and should not be in
semantically coupled places.

...

Again, no need to resend, but keep in mind if you need a v8, this and other
comments needs to be addressed.

-- 
With Best Regards,
Andy Shevchenko


