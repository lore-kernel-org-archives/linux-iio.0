Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D097E2E62AC;
	Mon, 11 May 2026 13:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506721; cv=none; b=tR6stWn2pv8KemcIWJiafI5mjaNKe9Wgs6nJ1DLIMIIRXHFCcmWyW/fLB3boxlEVcP3MvqSsntyYDvXJqWxwEbSnDAYL5JrcbaFhANP7wnNB4MFhhaXZu1wuJH/kC/qITstZDTSoS/PrdU33I6M6uQfhkzCrZbIN4JhIBpRzV7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506721; c=relaxed/simple;
	bh=MiHt1FsBexre8oCF1n0qIYUIrV/0UYSw434haykTcHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBMs4TEwnU4EaPQG9b7rEAuB1vzZJfxzskWyvBPjhXMCUr2YbQfmgkvtlX31Pfd+pcYpwvFzzn8+JVVrFyU5qDrtB1GlYT/tXPTtDgohc+yScu8IjOYMBlsC/hUXBUyrBf6j/HHtqJxVCc0NNIhE4R8ZEIenhlZUJLClfZybjSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KvNj+I6E; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KvNj+I6E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778506720; x=1810042720;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MiHt1FsBexre8oCF1n0qIYUIrV/0UYSw434haykTcHw=;
  b=KvNj+I6EWHkprhkxokmF4jc9rClZSLhEphpg5eyA1SQ8CEVNcA6VwKCi
   Y/HLfryG0WKSX2cAgIgshMdDStT/InCvEyKUiglPaZ+Pmr0AfAHu8Vfxk
   Jhx79E0lMdDyILQQGvRZvh6RlAlMHrBoOXv5r+4xbaeyFj+yfn/F25Xgf
   W+guteGNxGPvNIpbZ64NakrOjBvf+LQUh0rbHEssvvhDVMwn1P09UjNRE
   AAJSSSvClKQ5wxhTekUGroBJlLKYKLy0K2kz7rWI6A+3dbLB5V7zj3Efx
   RKxCfsKRXx5lIRyxTwrfOk0fDhk7VZflJa/9pTLGUXQAutvRqQbywpdh1
   w==;
X-CSE-ConnectionGUID: dyyrY6IeTZGHZupA5mOByA==
X-CSE-MsgGUID: TTijZtGLTsqsZSuT0j3tyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="81956360"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="81956360"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:38:39 -0700
X-CSE-ConnectionGUID: cUzF/WJ2R96wLbuXg4z0Wg==
X-CSE-MsgGUID: colv4BX5QOq5joHiSZqikQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="231063080"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:38:36 -0700
Date: Mon, 11 May 2026 16:38:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, gregkh@linuxfoundation.org, hcazarim@yahoo.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: trigger: iio-trig-interrupt: use devm_* helpers
Message-ID: <agHb2vOFiwUX6diI@ashevche-desk.local>
References: <20260511060732.7728-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511060732.7728-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 11:07:32AM +0500, Stepan Ionichev wrote:
> Convert to devm_iio_trigger_alloc(), devm_request_irq() and
> devm_iio_trigger_register(). The driver-managed lifecycle removes
> the manual error-cleanup ladder in probe and the entire .remove

.remove()

> callback.
> 
> Drop the now-unused iio_interrupt_trigger_info structure: its
> only purpose was to hold the IRQ number for the manual free_irq()
> call in .remove, which is no longer needed. The matching

.remove()

> linux/slab.h include is also dropped.
> 
> No functional change.

...

> +	ret = devm_request_irq(&pdev->dev, irq, iio_interrupt_trigger_poll,
> +			       irqflags, trig->name, trig);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> -			"request IRQ-%d failed", irq);
> -		goto error_free_trig_info;

> +		dev_err(&pdev->dev, "request IRQ-%d failed", irq);

No, drop this now duplicate message.

> +		return ret;
>  	}

-- 
With Best Regards,
Andy Shevchenko


