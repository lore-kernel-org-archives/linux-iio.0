Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5093537CD;
	Thu, 26 Mar 2026 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774517158; cv=none; b=suqo/m4zOdRkNUWiSK2BSGqvszJARXtqRlSa41VaijA40NBO33Kmt3W3hdaRwPEpAI3TmLllJmhVtZFHBtCOBuQXfI5Dfetncjt8JEq4zjqX8VCHTIfFtvHgyH+7a8ckNmYNBYcbyMoCWFxtOy5v3i5kCt26XJ906XSOTD9kRMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774517158; c=relaxed/simple;
	bh=pPs/7f4zdEjxOHX9OiiOb7oamU4aIRyGZLStI6h5m4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OVtVtJCtJA5PIOWcMl3CPV6cu/ztTF5CzzCqcfGlpi7/NSsy3R6tJfsU5Ilxgf1xBDfX7WlpIT4j4rjDnCykZaxquF8t275X8QCmeYlojB/UKV8rSbOoNvar7cxKcX1CH+vKqEow5PO0RVerrgewarwtrMUQd6m2182P8VcOrXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JhGuPrfk; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JhGuPrfk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774517155; x=1806053155;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pPs/7f4zdEjxOHX9OiiOb7oamU4aIRyGZLStI6h5m4Y=;
  b=JhGuPrfkqB3oYgVB9Ut/DvV41Jpu64FyqtOx5FoXND3yJv51WbCq5tO2
   a5oRvgrnmE0dHF0QBbtCp21oH0b5enZP2cQ4UNnrR0VL4UGPC52iWelW4
   L46eWzMnnFhd+MwgtYEekRTvqKmq2MXcYJjzJIdNbwJzY4Dda8VKF52dY
   U5lFs7HtRwQW7puS2n3k4JFaPMlXy5wJtdS/oPCnVBfEUkpfs2Dd2kuCw
   Jr95qEj4wsGWIrVCGwDeUwUtKRy8YRowyy5V9aAryQK3tz6qheA2mpIlU
   /vjIJidd2xvKbDzek0trRIPtm0BOSOLJWJUwF2Ye8DvsZrt/wvviURY3b
   A==;
X-CSE-ConnectionGUID: OJR+C1TQRGu6A5IPK/mSOg==
X-CSE-MsgGUID: Yiwitok7QEmLI59OdRJufg==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="75532282"
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="75532282"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:25:53 -0700
X-CSE-ConnectionGUID: LBHCVUjFRI+mqAp7IK2hmg==
X-CSE-MsgGUID: cWrFw77sSteDyFcyyAJ1PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,141,1770624000"; 
   d="scan'208";a="248370635"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 02:25:51 -0700
Date: Thu, 26 Mar 2026 11:25:49 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, kees@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: ssp_sensors: reuse preallocated RX buffer
 for SPI transfers
Message-ID: <acT7ndQKmAUajb_b@ashevche-desk.local>
References: <20260326081815.925373-1-sanjayembedded@gmail.com>
 <20260326081815.925373-5-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326081815.925373-5-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 01:48:15PM +0530, Sanjay Chitroda wrote:

> Avoid allocating a temporary DMA buffer in the interrupt context when
> handling hub-to-AP and AP-to-hub SPI write messages.
> 
> Preallocate RX buffer during probe and reuse it for SPI receive
> operations. This removes repeated kzalloc() calls from the IRQ
> path, reduces allocation overhead, and avoids potential allocation
> failures under memory pressure.
> 
> The RX buffer size is tracked and allocated using devm_kzalloc(), ensuring
> proper lifetime management tied to the device.
> 
> No functional change intended; this is an internal optimization and
> robustness improvement.

NAK.

...

> @@ -512,6 +512,17 @@ static int ssp_probe(struct spi_device *spi)
>  
>  	mutex_init(&data->comm_lock);

Pzzz! The wrong use of managed vs. unmanaged resources.

> +	data->rx_buf_size = SSP_DATA_PACKET_SIZE;
> +	data->rx_buf = devm_kzalloc(&spi->dev,
> +				    data->rx_buf_size,
> +				    GFP_KERNEL | GFP_DMA);

There are plenty of room on the previous lines. I think I already commented on
something like this.

> +

This blank line is redundant.

> +	if (!data->rx_buf) {

> +		dev_err(&spi->dev,
> +			"Failed to allocate memory for rx_buf\n");

Pzzz!
Have you read about error messages for -ENOMEM? Please, take your time and
study this case.

> +		return -ENOMEM;
> +	}
> +
>  	for (i = 0; i < SSP_SENSOR_MAX; ++i) {
>  		data->delay_buf[i] = SSP_DEFAULT_POLLING_DELAY;
>  		data->batch_latency_buf[i] = 0;


-- 
With Best Regards,
Andy Shevchenko


