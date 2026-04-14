Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C41FC8;
	Tue, 14 Apr 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776168613; cv=none; b=H8KLVn6KYCoQV2EPlmRskUBYT1x0NDCVQt/5HICUyFgT966iPk9zfPB7lUyyZ+hL29OMdr/L4u3tbB1Vfveeppm3R/fLIoOIy3z/9QdkmsdICIhP9RPhLbyG+hLbj+djtQIuDbZiMuuZmt0hT9ib+L0x6GWu+r0rx9Z33i24Rw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776168613; c=relaxed/simple;
	bh=u5kb03nvZ48mxdSo6PxIOY6V9LAhwq9og0vesRHxseU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fd8fZ065Ivmk9XJlIV4IrlcRlYOCzXqIH2PWWaJYulGMib7jce/RWn+8FSP9Fjil0n2GmDWPlzajmMRd4crMoWOnr4/PP2HVLJJUZm61MFJBR8EEvK6WtQZfK3ompOFFBwbx/STXWg0ceryInuXsdt8d1EhnLAGHD0NvaBKMWI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hg9L3a/g; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hg9L3a/g"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776168612; x=1807704612;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5kb03nvZ48mxdSo6PxIOY6V9LAhwq9og0vesRHxseU=;
  b=hg9L3a/gNXQuXCIPN5cY971IRM3xm56SbTN9KEyh4V8ycaPKFzUm4OgB
   2GnvF92hrBBmnBnPTVl/Z7MWCLEOdL9O7qF1TtsKOM3Wg7jpVRsqKWsn0
   yl6pqFVryxZD+1q1p1YkPbPaRVZTuJl4TNOmM8zo8GHtQyAlCpUNWRMQU
   2+Y1nzkvUHVEy5fX7kFhaFrHpZ9SLt6y61n7hjWqZfO6x5DPIz82LSW3C
   gS8yzI4LEZmDKmPOliiWmD3oU945duvBqEwfs7gCehBzJcHNqcvxJfPQw
   EPeQxRHcySciehGaO9gSyy5f74l5m5NHrnPQjSKhWSQcRjFq/MjP5C1da
   Q==;
X-CSE-ConnectionGUID: 2i5lwK9HT4aNBxSOtVgOSw==
X-CSE-MsgGUID: oOFzAX3CTg2GC9Y8d9+pxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77194667"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77194667"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:10:11 -0700
X-CSE-ConnectionGUID: 6tYP6XptRzKG2BhUPwDnUw==
X-CSE-MsgGUID: 8InQsNzPTPOZgxiqmMsucA==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 05:10:08 -0700
Date: Tue, 14 Apr 2026 15:10:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Carlier <devnexen@gmail.com>
Cc: Tomer Maimon <tmaimon77@gmail.com>, Andy Shevchenko <andy@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Avi Fishman <avifishman70@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Patrick Venture <venture@google.com>, Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>, openbmc@lists.ozlabs.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: npcm: fix unbalanced clk_disable_unprepare()
Message-ID: <ad4unjKuC6Ff_yse@ashevche-desk.local>
References: <20260414095929.11257-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414095929.11257-1-devnexen@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 10:59:29AM +0100, David Carlier wrote:
> The driver acquired the ADC clock with devm_clk_get() and read its
> rate, but never called clk_prepare_enable(). The probe error path and
> npcm_adc_remove() both called clk_disable_unprepare() unconditionally,
> causing the clk framework's enable/prepare counts to underflow on
> probe failure or module unbind.
> 
> The issue went unnoticed because NPCM BMC firmware leaves the ADC
> clock enabled at boot, so the driver happened to work in practice.
> 
> Switch to devm_clk_get_enabled() so the clock is properly enabled
> during probe and automatically released by the device-managed
> cleanup, and drop the now-redundant clk_disable_unprepare() from
> both the probe error path and remove().

Also need to mention the message drop here.

"While at it, drop the duplicate error message on ..."

> Fixes: 9bf85fbc9d8f ("iio: adc: add NPCM ADC driver")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> v2: drop redundant dev_err() on devm_request_irq() failure since the
>     IRQ core already logs it, and remove the now-single-statement
>     braces (Andy Shevchenko).

...

>  		if (PTR_ERR(info->vref) != -ENODEV) {
>  			ret = PTR_ERR(info->vref);
> -			goto err_disable_clk;
> +			return ret;

Now it's simply

			return PTR_ERR(info->vref);

>  		}

...

With those two being addressed, feel free to add
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


