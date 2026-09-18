Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A63A6EED;
	Fri, 18 Sep 2026 06:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789714315; cv=none; b=nP9B1aM+wvocuxC0BP8PxQs3gDk3MvnIVh8pDgenAnFRq4Coh4vhNUFk52OdgChw0Pok559+3EDUcj05rBSvPhBhedZ58OVLkrRqFKsrx+axelLAWfCIskqdLmiLJpRIaAbM+a5cnkKVMycolEdRgPicBMnhWm5lRou1LrWTWPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789714315; c=relaxed/simple;
	bh=+Esa1v80bNh9L5AYsUwyoiVWEaonxfxJsZULaMNZqmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5M2roQwRA4yjF5qkIx++dH3LEdj/NdLdFzG6KqnnGn7K4q6OllHwpqK/8d5pyaeXRWkVNPJVC7ZJb2FcihicffL4C8oVU/PigDGboh0VQXhUSn4ke8sNNMslyjox/YuMYqKezY+tMXMEprmD3uAXhcTv8TSX81Vf7fT5lCqJU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mNarSOq7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mNarSOq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789714313; x=1821250313;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+Esa1v80bNh9L5AYsUwyoiVWEaonxfxJsZULaMNZqmQ=;
  b=mNarSOq7UzbktLaxcarsr25MmFXC/4Eplw8nH3wUbcbyviLdRf7nIlTy
   tnaP+VBnI1hbUN1LLMCFDG8B9vSNDxNSIRWCCBZIDONMJxE/7b8Wr/FyY
   W1Niz1BriEdoKKwxoAI3uh0IyWE3r5PRUSDTOB8cCyKF6EvG3FpCBNd6t
   bHUJBoABunJ++Gx2lcv8n2WVdIPqlErun6FBaJj2xDjamMb8756Qf1qmL
   hIJnHup+PbsmTHCxvzVRjlRUCG4fYwjzlR5bO5qLqk0DzexRWJmcUCPwi
   zyFsN/ehfWwhqpOUFmUHRmGN1GuUiLMUQcZFKG//ymuFTrbvBg//FPTLW
   w==;
X-CSE-ConnectionGUID: vMlzmaodSaGGkzUYgF8bYg==
X-CSE-MsgGUID: WbFDidjvTdmVtX14MuuGMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="90064878"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="90064878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:51:53 -0700
X-CSE-ConnectionGUID: truldI64SEW3PRbD4bB37g==
X-CSE-MsgGUID: 4JggV0bIQ5qZVz9GuGyzZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="299352053"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.170])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 23:51:50 -0700
Date: Fri, 18 Sep 2026 09:51:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kees Cook <kees@kernel.org>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad7173: Remove const from chan_arr allocation
 type
Message-ID: <aqzfhNmU3sazdCTQ@ashevche-desk.local>
References: <20260917211436.i.689-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917211436.i.689-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 17, 2026 at 02:14:37PM -0700, Kees Cook wrote:

> In preparation for making the devm_kmalloc family of allocators type
> aware, we need to make sure that the returned type from the allocation
> matches the type of the variable being assigned. (Before, the allocator
> would always return "void *", which can be implicitly cast to any
> pointer type.)
> 
> The assigned type is "struct iio_chan_spec *", but the converted
> allocation type would be "const struct iio_chan_spec *", as the size was
> taken from "*indio_dev->channels", and "indio_dev->channels" points to
> const. As there is no general way to remove const qualifiers, take the
> size from the assignment target instead. No change in allocation size
> results.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> -	chan_arr = devm_kcalloc(dev, sizeof(*indio_dev->channels),
> +	chan_arr = devm_kcalloc(dev, sizeof(*chan_arr),
>  				st->num_channels, GFP_KERNEL);

I would even dare to put it on a single line now (yes, 86 characters long).
(No need to resend, Jonathan I hope can tweak if he agrees with this.)

-- 
With Best Regards,
Andy Shevchenko


