Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0897E12AAF1;
	Thu, 10 Sep 2026 08:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789027380; cv=none; b=txUC5S14N0xS6jNovQGrSWaeDVMusOpK7lYLl6SXz4CBupt8GOO2zi7bEQtgP4kqfKWfXeYbSHVfbED2UtityBHnDRXz3BtBtlkwl/X46wh/UHRINLpDu4draTYtV4n1tO/Ww0PEsamyuFNyIgPEUsr54CljmNqeyvJ34uCNgNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789027380; c=relaxed/simple;
	bh=DUdL7aafozd3OwjSV6yBKlXdlSCo4jNsmMWalXGQr0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZDYJn3ehrh3ZEsvcwXeRWarZBMXvsw7a9suxOf3E5Nz3YrYxnFVXdC2gc0OLRMswdi2wlY7alRanML/2EPzdrW9MomjhmJuYGP/abfhMI10xcLmwJ9VsLyJ7OAqG9jjpdGivLg+XJy6Oq4qBUec+Ejl61vYAEeHmwIRwoRsncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcsrEU2t; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcsrEU2t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789027379; x=1820563379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DUdL7aafozd3OwjSV6yBKlXdlSCo4jNsmMWalXGQr0g=;
  b=HcsrEU2trC+vbbD7LZF5yAGWz2RogWME8AAX31kDhr4wIgLKgap1vuR0
   02WO58AVN9aE0zPfgDb+mch0Be2q0N6KG//nFMjhVO6a/MuaNq1MmtamI
   s63qNWXj+lsH6HAoFqCR2tfbMOziXzIlSEyHxUZN/2ofB+T6zs8kZHH8c
   BDXLpXnR9lUiJD7PZ9QffSsCdTm83Ox9QdDN/GTnnK/XeGks3Ra4LGE7K
   UEwP2VBAIdUBn9pcmGCdWG36ylYkZB0CGPEvWSopn2zWH2tvQXk4V1nCo
   /5HUyaEGX9DSfzrj/VPBy/gxAJb3rr9qwyhdW6xjuYYrIwjQbW+JlEUaa
   w==;
X-CSE-ConnectionGUID: +NzTXfSoTnG7uybQNgFNKA==
X-CSE-MsgGUID: c7NMIHSNRvSJmWXp3ShNXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="89508854"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="89508854"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:02:59 -0700
X-CSE-ConnectionGUID: ygNY5EBVTO2bqBVul+tuew==
X-CSE-MsgGUID: FZ0F1+dMQ2Wnu3uFJtVYqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; 
   d="scan'208";a="268295774"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.177])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 01:02:56 -0700
Date: Thu, 10 Sep 2026 11:02:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jinseob Kim <kimjinseob88@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-kernel@vger.kernel.org,
	rdunlap@infradead.org, joshua.crofts1@gmail.com,
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com
Subject: Re: [PATCH v9 5/5] iio: osf: add UART IIO driver
Message-ID: <aqJkLfhV7-tjMeHw@ashevche-desk.local>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
 <CALMSewLVTiFww7hTBBw8jK+YL0ZC-E7wLx1TrBWUW5Ziutw8ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALMSewLVTiFww7hTBBw8jK+YL0ZC-E7wLx1TrBWUW5Ziutw8ww@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 09, 2026 at 10:06:58AM -0500, Jinseob Kim wrote:
> Add the Open Sensor Fusion serdev transport and runtime IIO registration
> from capability reports. Configure UART before enabling vcc, and retain
> early capabilities until the remaining probe setup succeeds.
> 
> Use initialized aligned scan storage, pack active channels, and quiesce
> pushes before buffer reconfiguration. Only accepted samples update the
> latest-sample cache used by direct reads.
> 
> Include KUnit coverage for cache integrity, scan bytes and timestamps,
> buffer lifetime, and early capability ownership.

Too big to review, should be split to at least 3 patches (rule of thumb:
each patch rarely should go above ~750 LoC).

...

> +	baudrate = serdev_device_set_baudrate(serdev, OSF_SERDEV_BAUD);
> +	if (baudrate != OSF_SERDEV_BAUD)
> +		dev_warn(dev, "requested %u baud, controller set %u\n",
> +			 OSF_SERDEV_BAUD, baudrate);

dev_warn_probe()

> +	serdev_device_set_flow_control(serdev, false);
> +
> +	ret = regulator_enable(vcc);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to enable vcc regulator\n");
> +		goto err_close;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, osf_serdev_disable_vcc, vcc);
> +	if (ret)
> +		goto err_close;

Something went wrong. It's supposed to be no goto:s after devm_*().

> +
> +	/* No fallible probe steps remain when IIO children become visible. */
> +	scoped_guard(mutex, &osf_uart->rx_lock)
> +		osf_core_start(&osf_uart->osf);
> +
> +	return 0;
> +
> +err_close:
> +	serdev_device_close(serdev);
> +	osf_stream_reset(&osf_uart->stream);
> +	osf_core_unregister_iio(&osf_uart->osf);
> +
> +	return ret;
> +}

-- 
With Best Regards,
Andy Shevchenko


