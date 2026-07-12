Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E619305699;
	Sun, 12 Jul 2026 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864742; cv=none; b=PB0dcGhi+IGWue9ucC9sHode+rKRjP+M28yEOzxMFSB+CpJmurgtjWoqHFJpVtNidtoRx9MnUEa2zdjFRODLyWBtYXwCjpGkllwHmsDagvRKJvo1vJrHLPt7QDyqnc1vgm2N4CwuORheo/umnDSQimJUmMYNowCIO2qqFeUd5Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864742; c=relaxed/simple;
	bh=lb/ojCwXb2cNhoqSUu0sl+qway4b5clii1Pxn47Ct2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UT4k0GQjiSHN0E5BeFk2TonJCmssk2g3xO8NCtVY3j5YwxHuqzp3FKxZzT4VKzIq9m2OiXbbXr0AYRumQdOTXAEEMFBJZ1aiYeYLzSi0H+xzOaP65cZiY98em61aofUiPRM/kr5GK32JDsYWG+ytON4CGgOD4zZamFN9HY4tUE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gr2nLrtw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gr2nLrtw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783864741; x=1815400741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lb/ojCwXb2cNhoqSUu0sl+qway4b5clii1Pxn47Ct2U=;
  b=gr2nLrtwbkw1zjnZ9f+39qBO885O3fGO0HSv9N1yga2U2uxo7qA6RSou
   k5RNO29jYUqJ6HhNSJzwb9XgfrQCIIyy2Q6FOheIUCOSmKnJ4YO6hdnig
   B7ViUKmxnb5wfQxbkSF013d0f+zUQ7OxgCIXm4pVLIgThV4Qq0xeth0im
   kABwotQCkdtzIIWX1vL+VcQ7EI33aIbYtU2ZE24DefP5PXe+cEufyU3UY
   M6QKwpcg7L3gX+4sBTFE1RFDnb7ZvpIfMvVjfsA1MeZg8Z1Uf94lffb18
   C/LF0RNov5lxsePL5P6xHmmeE0/oyDlNdxLlWKV3F6jS9FCphkxZMCwpN
   g==;
X-CSE-ConnectionGUID: URi2l4TmSMaRcap4tpydKw==
X-CSE-MsgGUID: Wii9oUvuTTOnuB9UxR85sg==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="107294209"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="107294209"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 06:59:00 -0700
X-CSE-ConnectionGUID: oRjwQH9BSvygauzVS43c8w==
X-CSE-MsgGUID: eusNqyj+RWWZQWiWyjJMyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="285407892"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2026 06:58:58 -0700
Date: Sun, 12 Jul 2026 16:58:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <alOdn0m3fbznqqDm@ashevche-desk.local>
References: <20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260712-opt3001-unwind-cleanup-v3-1-5fa336876b08@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jul 12, 2026 at 12:32:49PM +0200, Joshua Crofts wrote:
> Split the logic inside the opt3001_get_processed() function, as the
> current flow is hard to read, mixing IRQ and non-IRQ code blocks.
> 
> Separate the IRQ code path into its own function, same for the
> non-IRQ path.

...

> static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)

>  	if (ret < 0) {
>  		dev_err(dev, "failed to write register %02x\n",
>  			OPT3001_CONFIGURATION);
> +		return ret;
> +	}
> +
> +	return 0;

Now it can be simply

	if (ret < 0)
		dev_err(dev, "failed to write register %02x\n",
			OPT3001_CONFIGURATION);

	return ret;

...

> +	ret = wait_event_timeout(opt->result_ready_queue,
> +				 opt->result_ready,
> +				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;

ret is int and for holding an error code, with the above ret is rewritten
with positive number and might lead to subtle issues. The recommended way
to handle is

	if (wait_event_timeout(opt->result_ready_queue, opt->result_ready,
			       msecs_to_jiffies(OPT3001_RESULT_READY_LONG)))
		ret = 0;
	else
		ret = -ETIMEDOUT;

or something like that.

...

> +	/*
> +	 * Disable the end-of-conversion interrupt mechanism by restoring the
> +	 * low-level limit value (clearing OPT3001_LOW_LIMIT_EOC_ENABLE). Note
> +	 * that selectively clearing those enable bits would affect the actual
> +	 * limit value due to bit-overlap and therefore can't be done.
> +	 */
> +	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> +	ret = i2c_smbus_write_word_swapped(client, OPT3001_LOW_LIMIT, value);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_LOW_LIMIT);
> +		return ret;
>  	}
>  
> +	return 0;

Also can be simply

	return ret;

in both branches.

-- 
With Best Regards,
Andy Shevchenko


