Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E570034F46F;
	Mon, 16 Mar 2026 10:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773656528; cv=none; b=kjrvcmpjIM3Ygw1ohWonj9KYqRVgBc1p+8Xl4HObkIIURUROrYlbsqvJMY/7MjDRBYM38C2uBqPkUza+FNiEaRt/trH3N6z0vmART6OuQ9ikZoJydsaDdcWaJBIbXMgb/piEnNAiHJwjsxokVFCNRMPTVy+FtpYKspHiOorhwxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773656528; c=relaxed/simple;
	bh=kuslnc7iTFJ6Nzj1M+D5QTahd0hfqdxKeq86aYI/KU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=akWe4pga2xGmydq+l9owBIYMgIA6zPkpdKHviZuHDX9B8xDP1VZNpOWiihmIJ+sj0YpYyuiTzjACWAE43wQgqmuswNX8zDFc0hLDvix8KanoK/7k89qah2ENdylD2kRm5+Zu4DLagTTBx3uFczL67rgj0O/aPIm4tTBCB3ULzTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af/Q/lYC; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af/Q/lYC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773656527; x=1805192527;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kuslnc7iTFJ6Nzj1M+D5QTahd0hfqdxKeq86aYI/KU4=;
  b=af/Q/lYCS2PpwFKRwrH0oQ3McdQfDcIFYOS9yf8BTfj+YL52G6dsXFCC
   RN7m7cx3FeHvJYMDpweEP/5kOD0r3aTbD7lz36b8TtkslprYhURA2zeNy
   EeqhLfl7UQGhycMHCZ26yJnaQdc3YJ7Om3b4o2tcj/VzOU3HIFctws3pH
   TKmh2M6jkvMxhsrBDxeA9Bt/aPk0cXx3Y688+/+9TLcTf3cm6AroHn184
   RQ6mjJy7MvdJ2fNwX1/EBG94XqNY4ZAwyyRi/k2YTQmQZnc8zMPYJsw5+
   a790mSv2cRBwft1MLu4FTkTrtTYB+cc1tVfi5dpfyRe4WlxU1cre7Idf+
   w==;
X-CSE-ConnectionGUID: enDnrn9MT4e+DIS9KcwpLg==
X-CSE-MsgGUID: gk8jYsUoTlWW9m8KbswVcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="100126401"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="100126401"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:22:06 -0700
X-CSE-ConnectionGUID: 0Qf4D96iQ+GjVGog4HTelw==
X-CSE-MsgGUID: gKiJCdN/QSaPMJjNb+2Ucw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="217716947"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 03:22:04 -0700
Date: Mon, 16 Mar 2026 12:22:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	shuaijie wang <wangshuaijie@awinic.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: aw96103: fix firmware read on big-endian
Message-ID: <abfZyvsfzjPv08QM@ashevche-desk.local>
References: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-proximity-aw96103-fix-firmware-read-v1-1-c74fe9ccd82b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 06:20:12PM -0500, David Lechner wrote:
> Use get_unaligned_le32() instead of casting to int * to make sure that
> reading a 32-bit int value from the firmware binary works correctly on
> big-endian architectures.

...

>  	bin->valid_data_addr = AW96103_BIN_VALID_DATA_OFFSET;
>  	bin->valid_data_len =
> -		*(unsigned int *)(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
> +		get_unaligned_le32(bin->data + AW96103_BIN_DATA_LEN_OFFSET) -
>  		AW96103_BIN_DATA_REG_NUM_SIZE;
>  	memcpy(bin->chip_type, bin->data + AW96103_BIN_CHIP_TYPE_OFFSET,
>  	       AW96103_BIN_CHIP_TYPE_SIZE);

I gave you a tag, but I have a question here:
Hmm... memcpy() happens to work probably due to keeping LE as LE and chip_type
being a byte stream itself, if AW96103_BIN_CHIP_TYPE_SIZE is bigger than a
byte. Otherwise it may suffer from the same issue, no?

-- 
With Best Regards,
Andy Shevchenko


