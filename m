Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792959287;
	b=y+31rwBJv9y73oTrZU3fCnkPINTkG5/fGm9/mojmY4oyxRbMVZuu1H/GiIOhHgSnnz32
	 4LfIPzmxaxkHa4js/ZLHJViGExIsDbt6Ppn0qix+CDZV/GN2qG9UUtKUPuni5uGCBo9v9
	 EQrQPcgEqxY8VypMfhWneeFL9wEE3zPGeg4AzmjMEByujIXQ6cayBOwAU9tia+l7Ae/Ip
	 TJKlwqeZRPJg8mrW4VKq3nY1QnzpdWDf+bzcZOMCVhqnbpg6X7C3fIUXsYQuco6oFOrkY
	 49yjyZsoCRKnVODVBPEWSVZYKvHqTGGjiwNemtTwj0qxBd0g41ZfaL/YHL0ygPWJJjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792959287;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=nGJHavF6dSjRKsxaMbsvbObMuN/1FJT3WyyQ9KeYG14=;
	b=OOjvJGMWwlZxXTvpoYTdg8r21JhEbmrOZFqr9m3KL7yhv8X4cL03EcWiqCeseuqJxosd
	 2EGFv9KheC9NidDm9ZXFcd5w1qVIlllIdRgC9lknamxm/GL5B79zkpn6sjS0i8FdHuQBv
	 1AyZ3PedARNkgSyDZNV8luOgKTD+s0XGdGQFagkYhX/TFasE61rOyKLt9qMfntKrL5c2+
	 DcxTxp4iRvryi2BKIGxWL5tAX1bzQ/cycC+5+flNmXN3+x6FthPF0hfgzimQHZzbtNk/q
	 ssT7VSJnBf3F3tYL9xERQRVMPkgR1dx++1+BdrIQ7bGa5MDSlg7qrH5p1GlLBEggSDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RhGP+OHz;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962AC606A31A;
	Sun, 25 Oct 2026 20:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 962AC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RhGP+OHz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792959285; x=1824495285;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9GKkWz1dS8PrpKepJfMr9pKKIngX8+cFO3s2cipkbo8=;
  b=RhGP+OHz1IVu8HJdFb6mDqgNPr5+wLXFBuiixfc5QiH24zZQaAfTjC1g
   YkuDgNrn3sdAPAVHMcT7u93o9zqiSa8dzUHP0Z6+f5bQkSHPnu/XWciVn
   LhQkltKAhfjBWpIFodDvxAFp4cdJsqt2jAYz3V3i17fyXHuauL1/XUs77
   Lp6cRNYpcXXjLcLWBBICbAeyZiX0f69RaygM9U8KIMX4pY0LegjHJsF5O
   YwQzTXrs31bo0PdlgDiTmLwds++U7MtcxmZylOk812UleUlgGx92Nxsne
   bkd+3Oyy2EPsdl+dVs2miJtbluWxKI02qxmxK9fLTes4JcJ3TTJGNIbty
   A==;
X-CSE-ConnectionGUID: LQQs0V6NSDy/mVdcnQhnNg==
X-CSE-MsgGUID: 5QhiAhhUT82g0SoGY3v9ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11946"; a="1517950"
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="1517950"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:14:45 -0700
X-CSE-ConnectionGUID: XymywbSuQaiqi2CTwJ07hA==
X-CSE-MsgGUID: uQIrykXUQguTpx5uGdlWbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,178,1787036400"; 
   d="scan'208";a="4045131"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.10])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2026 13:14:42 -0700
Date: Sun, 25 Oct 2026 22:14:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephan Costa Barros <stephanbrrs8@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Krzysztof Kozlowski <krzk@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] iio: adc: ti-ads1298: fix the data read path
Message-ID: <at5jL47A-6vQJYOX@ashevche-desk.local>
References: <20261024231335.280955-1-stephanbrrs8@gmail.com>
 <20261024231335.280955-2-stephanbrrs8@gmail.com>
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
In-Reply-To: <20261024231335.280955-2-stephanbrrs8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 24, 2026 at 08:13:30PM -0300, Stephan Costa Barros wrote:
> Fix five issues in how the driver reads samples:
> 
> - cmd_buffer serves both the register accessors, under the regmap lock,
>   and the commands, under the IIO device lock, and shares a cacheline
>   with rx_buffer and tx_buffer. A register access can then rewrite a
>   command on the bus, or corrupt an RDATA transfer in flight on a
>   platform without coherent DMA. Give each path its own buffer, each on
>   its own cacheline.
> 
> - After STOP, the conversion in progress still raises DRDY, so an RDATA
>   transfer can be in flight when the core frees the active scan mask.
>   Track in the driver whether samples go to the buffer, wait in
>   predisable for the last DRDY and its transfer, and push the sample
>   before marking the transfer done. update_scan_mode reset the transfer
>   counter, which let a new transfer be queued over one in flight; wait
>   for it instead.
> 
> - When a single-shot read times out, its transfer may still be in
>   flight, and the next read then wakes up with the old sample. On
>   unbind, nothing waits for the DRDY interrupt or its transfer. Wait for
>   the transfer before a single-shot read, and on teardown disable the
>   interrupt and wait for the last transfer.
> 
> - The return value of spi_async() and the status of the RDATA message
>   are ignored: a failure leaves the transfer counter stuck, and a failed
>   transfer is reported as a sample. Handle both.
> 
> - read_raw takes the sample out of rx_buffer after releasing direct
>   mode, so a buffer enabled in between can overwrite it. Take it while
>   direct mode is still held.
> 
> The first, second and last were found by review and not reproduced.
> The third and fourth were found by review and reproduced on an emulated
> device only.

...

> static void ads1298_rdata_complete(void *context)
>  {
>  	struct iio_dev *indio_dev = context;
>  	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int status = priv->rdata_msg.status;
>  	int scan_index;
>  	u32 *bounce = priv->bounce_buffer;
> +	bool buffered;
>  
> -	if (!iio_buffer_enabled(indio_dev)) {

> +	/* Only changes while no transfer is in flight */
> +	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
> +		buffered = priv->buffered;
> +
> +	if (!buffered) {

Strictly speaking you need to assign buffered to make any compiler not being
confused by the scoped_guard(), which cases IIRC we used to have the past.

...

> static int ads1298_buffer_postenable(struct iio_dev *indio_dev)

> -	return ads1298_write_cmd(priv, ADS1298_CMD_START);
> +	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
> +		priv->buffered = true;
> +
> +	ret = ads1298_write_cmd(priv, ADS1298_CMD_START);
> +	if (ret) {
> +		scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
> +			priv->buffered = false;
> +	}
> +
> +	return ret;

Before write_cmd is called the buffered might have been triggered. Is it okay?

...

>  static int ads1298_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int ret, ret2;
> +	int rate;
> +
> +	ret = ads1298_write_cmd(priv, ADS1298_CMD_STOP);
> +
> +	/*
> +	 * The conversion in progress completes and raises DRDY once more.
> +	 * Wait for it and for its transfer before the core tears down the
> +	 * scan.
> +	 */
> +	if (ads1298_get_samp_freq(priv, &rate) >= 0 && rate > 0)
> +		fsleep(2 * DIV_ROUND_UP(USEC_PER_SEC, rate));
> +	ret2 = ads1298_wait_rdata_idle(priv);
>  
> -	return ads1298_write_cmd(priv, ADS1298_CMD_STOP);
> +	scoped_guard(spinlock_irqsave, &priv->irq_busy_lock)
> +		priv->buffered = false;
> +
> +	return ret ?: ret2;
>  }

The code lacks of comments on why in all error cases (either first one, or
second, or both are triggered) it's fine to continue. And what will be the
meaning of the returned value in all three cases?

-- 
With Best Regards,
Andy Shevchenko


