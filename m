Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE33328FA;
	Sun, 10 May 2026 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778417903; cv=none; b=X/yubX6BI3yd2RbBRcg1xQo+brMk8YaMKtTPVbMbPSI2eBdXkm7omYjpsKyY9oA6MfsVZaufZzUH3XdBPm4WvCaZABZJJecxhSS2ZQVcBYwla5+LUTIl6C0dyJ7fQnaLhgiZHuA2XmRi+VaVf4Xr94W/5LgcjdCSSQ8kGgbPvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778417903; c=relaxed/simple;
	bh=3W4SKDbAvQSacrvzmbfbOoKaoXeEybXxmrWP+EvJOV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5LhRHqOa4pxKzYS82hPfu22BNWG8NBXmDl3k34iSwjSRBu+NbrvYRMxmFn+beI/8Gcz1J8+AtfOR2Y7xLJcUW+HIY0Q9lPI5UukHIYgENSCuyyUKCh7KeWqpTxZtLvbKibGx8oebaCaS/JZOTAdvIA3eIb9tw30DqBW8R46G4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iYdzmH4j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iYdzmH4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778417902; x=1809953902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3W4SKDbAvQSacrvzmbfbOoKaoXeEybXxmrWP+EvJOV0=;
  b=iYdzmH4juXOz71RIFEj3xyCNlz+mCVfIsAfu/sv5ncvgOsHjgcdLUcMI
   kgdEcwF0Llmj22j1Y+NTxavQ0owXTjkR2OLMMyhHI4mDlfObvWVbMXDvU
   Fzelvqp1ChC6jBltN+j6jMNQzw2Qv3cfUsVTCg08M7W9KpOVlj9WN6nmk
   9LyARvyxZj/ciDU63ZADHQ0tNBz00nsvPxAymRHdZ799TkU2aeG6DxjEj
   Ur5ynuCOV8Pv8qe/K8NhV6ODEWmYwf1gMDC2v5U3UF1c5xe74ivxnqrIj
   MCk08H4yf13Chmf3dkN5BSjmZPliv9N1/F14siNw6arBCf3TABrwh+5iU
   A==;
X-CSE-ConnectionGUID: sPpBoO4iTNGpMT/ZNGanhw==
X-CSE-MsgGUID: nC4Hqx5KRZOjqJwqscBNAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="90027161"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="90027161"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:58:21 -0700
X-CSE-ConnectionGUID: txTi6CZBTXSuvriRFkdbLw==
X-CSE-MsgGUID: Pf/JsO2GQzq7q6WpGHLVRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="242205570"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 05:58:19 -0700
Date: Sun, 10 May 2026 15:58:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Md Shofiqul Islam <shofiqtest@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] iio: accel: adxl3xx: Add timestamps to FIFO data
Message-ID: <agCA6HUnN5KMXj8J@ashevche-desk.local>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510082556.3867-1-shofiqtest@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 11:25:51AM +0300, Md Shofiqul Islam wrote:
> Five ADXL-family accelerometer drivers (ADXL313, ADXL345, ADXL367,
> ADXL372, ADXL380) push buffered samples using iio_push_to_buffers(),
> which does not attach a hardware timestamp to the scan data.
> Userspace consumers therefore receive samples with no timing
> information.
> 
> This series adds timestamp support uniformly across the family:
> 
>   - A scan buffer struct with an aligned_s64 ts field is added to each
>     driver's state struct.  The struct layout ensures the timestamp
>     field sits at an 8-byte aligned offset as required by
>     iio_push_to_buffers_with_timestamp().
> 
>   - In the FIFO push loop, FIFO data is copied into scan.channels via
>     memcpy(), then iio_push_to_buffers_with_timestamp() is called with
>     a single timestamp captured once per interrupt with
>     iio_get_time_ns().  Using one timestamp per IRQ is consistent with
>     the existing approach in the same handlers for event timestamps.
> 
>   - For ADXL367, the helper adxl367_push_fifo_data() gains a s64 ts
>     parameter so the timestamp captured in the IRQ handler is passed
>     through instead of calling iio_get_time_ns() a second time.
> 
>   - For ADXL372 and ADXL380, where the IRQ handler already called
>     iio_get_time_ns() for the event push, the same captured timestamp
>     is now also passed to the FIFO push, removing the duplicate call.
> 
> The ADXL313 and ADXL345 drivers always scan all three axes together
> (available_scan_masks contains only the full X|Y|Z mask), so their
> scan buffer layout is fixed.  The ADXL367, ADXL372, and ADXL380
> drivers support variable scan masks; fifo_set_size tracks the number
> of enabled channels per sample set and is used as the memcpy length.

This is sensitive change. Do we have any confirmation that this
- does work as expected on real HW and platforms that use these devices
- does not break any ABI

-- 
With Best Regards,
Andy Shevchenko


