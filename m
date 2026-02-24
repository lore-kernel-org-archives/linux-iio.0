Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33113A0E9C;
	Tue, 24 Feb 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771945107; cv=none; b=GB1cFKzXXfQ+kfkXRBwFJn2qO7mBnPbAPdSiXl7nyQExdxklRz6g5O4UdGW8wPK/sKCdHCp2aTJZxmXBC5KPmuRspYlzDo7JWSc3B0SdWNrZPAeX1rEX+KQjCMMYK+4VXJk+pyhaqlkgNQUExAx9k50p252MQXFHEm8BZEDA4HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771945107; c=relaxed/simple;
	bh=PKdUeSLz9VdUK9WbodDke0oqIOfkeX8DMSGuy+WUuDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HXq/js2o8A6fDy8pgfTtgzUGSZ3/ufEJvOqqOmz56ksmEdMxaNLkdPmqL+751SB7Sb21tUFwiPvvBhyJ0pUA8HV5Ee/ZS3Yyc24BxtI7epf1ZmMqUJ8F6CUTUsr2J1MvexZUXrjFq/w8YV8SNvllOLI10wUgvKLv5QcemVjPnpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lVNuKD52; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lVNuKD52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771945107; x=1803481107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PKdUeSLz9VdUK9WbodDke0oqIOfkeX8DMSGuy+WUuDk=;
  b=lVNuKD521a7VJqfeQ+dfq59q4uTJgkGj2be4mfbacrjmekUUPQrL4oUe
   P5CP+F3EpGCx8cKfNQHfqfZExxaSYrVal1/X2Sg+Jc+BQDQtJq69pZVzp
   V7lCTs0F+w4p2zXlPrR+sMYAnvjv7cRU/ovioc/9Q3zIv8B5+MsWURJoG
   ji3yJwsB1IiyoYPI+j6qdLcQOWYUGmBm6DJrd69DdA+JSyt5QWoD9ETUK
   u8ga4vJm0Fu43GBxn2l5SDQNPhQU4M1bJe3QAAEr5HCtDYj9Hrf+isnTk
   cOsLhS00EqWXDvy4ow/DpfUy3J5GtoATR362ytK36tMnQJ+z3HcmLcIoB
   Q==;
X-CSE-ConnectionGUID: V8+R1gcpTEeJUsavFsozkg==
X-CSE-MsgGUID: jKLPL/tKTsit3qhi2A92KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="90376688"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="90376688"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:58:22 -0800
X-CSE-ConnectionGUID: BHGBPhaLSo6gX43EUq0WxQ==
X-CSE-MsgGUID: ca9HrgjqSueslt5ax2wHTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="214150063"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:58:19 -0800
Date: Tue, 24 Feb 2026 16:58:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	rdunlap@infradead.org, skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/5] iio: accel: adxl345: Implement event scaling for
 ABI compliance
Message-ID: <aZ28iZDC6CPB2cZ4@smile.fi.intel.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
 <20260224140351.27288-5-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224140351.27288-5-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 02:03:47PM +0000, Taha Ed-Dafili wrote:
> The ADXL345 uses a fixed threshold resolution of 62.5 mg/LSB for
> event-related registers. Previously, the driver reported raw
> values without a scale factor.
> 
> Implement IIO_EV_INFO_SCALE for all event types to provide the
> conversion factor (0.612915 m/s^2) as required by the IIO ABI.
> 
> Consequently, remove the obsolete comment in adxl345_read_event_value()
> which stated that the scale factor is not applied.
> 
> Add explicit write rejection for IIO_EV_INFO_SCALE in
> adxl345_write_event_value() returning -EINVAL.

...

>  		.mask_shared_by_type =
>  			BIT(IIO_EV_INFO_ENABLE) |
> -			BIT(IIO_EV_INFO_VALUE),
> +			BIT(IIO_EV_INFO_VALUE)	|
> +			BIT(IIO_EV_INFO_SCALE),

Why SCALE can't be squeezed before VALUE? This change brings unneeded churn.

-- 
With Best Regards,
Andy Shevchenko


