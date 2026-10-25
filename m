Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792961871;
	b=fxbHs14mLK3TT1nDGWhN8Eot1qg7pdVhaMhCC0cT7bw0vVHlavJwOQyU/hzNYoClB3zm
	 NToEJCrGPTzoZQda9N+5nFBx8f1mBNXrVnvebTP+9jRZXREXrViQc4+c5WiSALQO9gAV3
	 3iWwtU+7lawiR5X6MqhNfyONQsURID9WN5STwl2XQcynRBeUXDtVHLdviRQZ94VCicYSU
	 PF6vgfCKKENJk0au5WyNdkN1S0AKBK+EdANE57f50LEFqWLkCEKGuQMcE+92qQChJc7ZQ
	 W1rHOFTgKoODAOZwumCFueaoWjoYtV/9Bo59Ewm7Sicc+d6HW3RCHQ1+fBBFwUPHMlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792961871;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=QAXEM1kJABr/KHXXWMKlEWCf2TuONV1Q5agh0PimqQM=;
	b=h4R/fdhILowxdGtB9t9yRuWm3nAp6akiP2efxEPI3vEokXVGLjlhXxLL8Byoaz6R20wr
	 7uUSRtU24j9PShpWwyOW2SZuxby6lJSEP/ApX+R1OMbxx5RLJuTOWx9BzQWH60/ysxvq/
	 8ElfAo9kDJ+HJgjdvVUm68wHoLupxZayb8rIKhSVkSKxFailTAQapU831VkBMRcEH7l2a
	 8FA+VL+2vcjsYRsrwQtjp0FD2C2ZRW3/MtUuL5miAefNhzDa9pmRIq9JKZAuoJptrFnC/
	 ER2MizLxmsvOhqB8tCKhcQ1ar0HLcHQVVPF2wgaoXhrns4US6c0tEv4I3ysJDs7Pfyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AlbMI1nt;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63E1606A31A;
	Sun, 25 Oct 2026 20:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E63E1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=AlbMI1nt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792961870; x=1824497870;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9AAJhXNHx3ESPj7PlObNmBSgCivu5Ykw9p8YJxMatWU=;
  b=AlbMI1ntbG42oHGxyMGCrpEquSFAusGrjND0TqqXOFHsuiLQc15wnmTv
   yzi5GWklri/p/3qOFNU/pEydvkRDQ+Yuwz2J8H7qrBCxBl1WdCVXUjF0D
   WZMB9sin/mCD7KsC024l2F/L+5E/5bgLWzwl38AgSMlX5HYWS/QyHZ2yL
   Ec6HJkz2uiAyaOZE8/TP1GR+oxzSj2tPHym0TIkb/MCM6vHKqrFJ8L2Qu
   7o5HYTDL15KFhzJRJ+R4Uaqk7CPnmS0MjSVR+5p3nL10HnZEPxv1AA+1O
   PNSo3Bexl45sBY6o7elcizBMfkq8ugIIX1bkg6hmE2lGuvMCONH6rAji+
   Q==;
X-CSE-ConnectionGUID: MM+87LnTQ06dOkPI2Zalog==
X-CSE-MsgGUID: 9QY2UJcQR6e6gERZZ2tLMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1618098"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1618098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:57:49 -0700
X-CSE-ConnectionGUID: kk/x6vcDQcWKDUbqOR+0ZQ==
X-CSE-MsgGUID: izZ+UF99QkuRIaaIDNOZLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4482922"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:57:47 -0700
Date: Sun, 25 Oct 2026 22:57:45 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH v3] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <at5tSSk_Hr5MzOZ8@ashevche-desk.local>
References: <20261025173545.6892-1-nikhilgtr@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261025173545.6892-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Oct 25, 2026 at 11:05:45PM +0530, Nikhil Gautam wrote:
> Allow userspace to configure the CCS811 IAQ measurement rate through
> the IIO sampling_frequency attribute.
> 
> Support the three IAQ measurement modes with sampling frequencies of
> 1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
> measurement intervals of 1, 10, and 60 seconds.
> 
> Preserve unrelated bits in the MEAS_MODE register when updating the
> drive mode, and cache the selected mode after a successful register
> write. Expose the supported frequencies through
> sampling_frequency_available.
> 
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

The cutter is missing here, we don't want to see changelog in the commit
messages and moreover this contribution is not strictly signed-off, as the tag
block is the last in the commit message. This is a show-stopper to take
the patch, even if it's desired and correct.

> 
> Changes in v3:
> - Reuse the sampling frequency array instead of duplicating frequency values.
> - Separate register updates from locking and wakeup handling.
> - Use a separate variable for the updated MEAS_MODE register value.
> - Simplify the sampling frequency getter.
> - Mark the completed drive-mode configuration TODO as done.
> 
> Changes in v2:
> - Fix the Clang build error caused by guard() in the switch statement.
> ---

...

> +static const int ccs811_samp_freq[] = {
> +	1, 0,
> +	0, 100000,
> +	0, 16667,
> +};

Make it double dimension array instead. Each index can be named as
CCS811_MODE_IAQ_1SEC and so on, while the shift is applied later on.

With the above being done, the code can use either a for-loop or
simple indexing.

*Yes, I see that the value(s) can be used directly in the code, but try to
explore an approach that can improve robustness and readability of the code.

...

> +{
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;

Can we use IIO_DEV_ACQUIRE_DIRECT_MODE() here?

> +		ret = ccs811_set_sampling_freq(data, val, val2);
> +
> +		iio_device_release_direct(indio_dev);
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


