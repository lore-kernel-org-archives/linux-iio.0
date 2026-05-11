Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2E13DC4C4;
	Mon, 11 May 2026 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778496185; cv=none; b=MLaH5B6s9xkTnDkRFGRG/bhkxaoGXcWAWQhGX83WVbUbDlkAzezF4LisCgRA62dh5/GmSGfWnPJ8riMFEBdQP5yTNXJxOGiKjxFnhNB7/IJicaZtMENvq97uAQRI1/OObqlW5CpagQGDZBl09/ppPcO0f+2iXfOv+uV1bBAt20s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778496185; c=relaxed/simple;
	bh=PPWmXuxLfvkzylWOidYsCx+Ejj3WtlcW+Ea5uAkiRgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuJv3Q8cJkBkNxMTbX5FO8bvc31oBqwLpumUAGvn8/p9tf28515A36sGeqTlFQCM2AVWNyujP2VXycnmd6Z1ApQ9smhY2FTMsA/Yxei60HL2RhKMGN810qrrSSIxI6iCD+oXB7O35hxuLQI1w6LoHyn2X4QiXYNu/NzcUokNnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aLdUSYDQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aLdUSYDQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778496184; x=1810032184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PPWmXuxLfvkzylWOidYsCx+Ejj3WtlcW+Ea5uAkiRgY=;
  b=aLdUSYDQfZGMaIaa6bM4386p8QUJNOg9CryBWF/q2kjiiTRlF4Vtcyy8
   zxTFRHS2rVNEy+Iqi4/JrdL6W5lUB3PZFa/OmmWHVLuxuUkHX3LliR5+N
   H9NT+VKKtBE3YqAc8cE/lRCk70yHRw3XaFGFq2jT4vNu5sZ4hftb5c2Te
   acp8/iJBTpSbwxnnCmGTfVLNjtOfc6x9UjRTjTxqPKXueSfaY4V0Jz85I
   neic4XGlKAu6AhOpIS4JwEsoQON0LtX0p2Aqdp+DnyxK0MurCjyufJaxm
   gc+WeLmxChn3iu49qEeqzArKQf4ttRcHFN0haoll56jxHn8/pk4o2XEdZ
   Q==;
X-CSE-ConnectionGUID: qxyL+nbSQYmihz+AX+OfNw==
X-CSE-MsgGUID: 1pqTgPQDQLGOdTuhUmMI1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="96803367"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="96803367"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:43:03 -0700
X-CSE-ConnectionGUID: IlU4ztZDQzSShdUiQhXWTg==
X-CSE-MsgGUID: AdqqPlVvQWCDqUz6DQbi8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="260892909"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 03:43:01 -0700
Date: Mon, 11 May 2026 13:42:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd30: Prevent potential
 divide-by-zero errors
Message-ID: <agGysjQvYZlq0abw@ashevche-desk.local>
References: <20260510202154.319585-3-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510202154.319585-3-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 03:21:56PM -0500, Maxwell Doose wrote:
> In scd30_read_raw, the current value of tmp in the

We refer to the functions as func().

> IIO_CHAN_INFO_SAMP_FREQ case is unchecked. Add checking to see if the
> value we got was 0 to prevent a divide-by-zero error.
> 
> A similar case has also been found in scd30_write_raw(), also in the
> IIO_CHAN_INFO_SAMP_FREQ case, where the value of val2 was unchecked.
> Add checking for that variable as well and return -EINVAL if it's 0.

...

> +		/*
> +		 * Value of 0 is unexpected but possible if hardware is failing
> +		 * or noise on data bus

Respect English punctuation. Here the period at the end is missing.

> +		 */

> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "Invalid measurement interval 0 received\n");

I believe here is missing colon.

					    "Invalid measurement: interval 0 received\n");

> +			return -EIO;
> +		}

-- 
With Best Regards,
Andy Shevchenko


