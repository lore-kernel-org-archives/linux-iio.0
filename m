Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F6D379C33;
	Wed, 13 May 2026 20:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778704816; cv=none; b=a8jIQiHxfNbpm+4Yui3kZCHpqi/CC/JuUVG2krdBgMH2R+PqoCIUWFofbBe9CLCkvXykn7JwMSmwWpSfuAbUsDwat6DtA5V5SZ4VgvZ87xPavx8SUl6pApq+TLVXA73zZmYgJFS92s06JZ807WRoyw7QK01Pm2HHFA/kUNg8Cpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778704816; c=relaxed/simple;
	bh=EBrzMv0Pel7XG8dHJ2OKfiwyhRi0/nkRY4T0ljgMPPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oOqjWoXUys/MfDCjyO583NG75fdtNlbbvsNwkKmiicCoF0IR2pvVkBVxCUGq6cA9Vs+aNs9Y1aGjkn6pFvn93KjdaMgWp3gCdSFNTC7sZcG3L9wpkYUeDdMM6q0x44TdLDW1Tp0Iye7piSGTYRB+ZWtNgOFh8MrZGFjDvDyWmqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WXPg5pfy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WXPg5pfy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778704815; x=1810240815;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EBrzMv0Pel7XG8dHJ2OKfiwyhRi0/nkRY4T0ljgMPPo=;
  b=WXPg5pfyjUh7xoCIzJhp/oiGeAVuzmwcOQBziYR0s5QQIGKdDjU6NbTE
   U/fRyn+mpE4LHA0U0QvCpkLb4qWYGrnkqTc23Tp7p3BCQahvLDdyJQ6l4
   6pnE1ltDDBcfUrBPvnQ0Y5XF4uTEOr8JAId2V8MuZmTmB15c91HwyFdlK
   mYkBdjozYr1xIf59zgX+LtiiX0rzbQc52TezR5nim0ha9kJqO3KBNAK5J
   rQYT8j1hd2xenYjWABSfoxZGfIoGHVqAS2ntcwoEpuH5aDux6xfcpUzFj
   MRjI9jcj8cyjnWkq508JWq+0lEaGjss2DbgwrPYpVTHmD3Gf5l1Y31to8
   w==;
X-CSE-ConnectionGUID: ylstnX1iRdib4Hn3nnmnNQ==
X-CSE-MsgGUID: xMWYKebeQ9aH1UrzK7VCjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="79672650"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="79672650"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:40:14 -0700
X-CSE-ConnectionGUID: cVGAbjp9RyiYwShKd4APHQ==
X-CSE-MsgGUID: m+wfPr5KQTaSngJrvc0Jmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237324790"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:40:11 -0700
Date: Wed, 13 May 2026 23:40:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gregor Boirie <gregor.boirie@parrot.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] iio: magnetometer: ak8975: ensure device is awake for
 buffered capture
Message-ID: <agThqGpaYk7KNCv7@ashevche-desk.local>
References: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-ak8975-fix-v1-1-104ea605dd54@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:
> Currently, the ak8975_start_read_axis() can be called while the device
> is autosuspended, causing two issues:
> 
> 1. I2C transfers in the aforementioned function will fail or timeout
> because ak8975_runtime_suspend() disables the device regulators.
> 2. Since ak8975_fill_buffer() does not hold runtime references,
> ak8975_runtime_suspend() can run concurrently, and since PM callbacks
> do not use a locking mechanism, it may cause a race accessing the
> control register via the I2C bus.
> 
> Fix this issue by adding struct iio_buffer_setup_ops that contains
> preenable and postdisable functions to ensure correct that device is
> powered on when running a buffered capture.

I think Suggested-by: Jonathan is appropriate here.

...

> +static int ak8975_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ak8975_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;

Not sure if actually may use indio_dev->dev.parent here instead of this, but at
least this one is robust against changing parent-child relations).

> +	return pm_runtime_resume_and_get(dev);
> +}

-- 
With Best Regards,
Andy Shevchenko


