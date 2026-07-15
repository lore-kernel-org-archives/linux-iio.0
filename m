Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730F360EFF
	for <linux-iio@vger.kernel.org>; Wed, 15 Jul 2026 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125399; cv=none; b=K+6TzcWUUbIa+arIkoWS5q/ZE4iqoN68irRMOcKFSbyYhrvkG94qzXCh4yS1phOIfghdAFfm2pZa93+0RN5wc+Vy8uL8ADk5V3G86s0whYVitosM0nxcjiRxxTGuOlup3bn9J1mwpzUXBwY0UaehAx3qT5m0zWe/amakjX8A6E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125399; c=relaxed/simple;
	bh=GhjEJLSpPpvdk/BGkE+jWIJyJW4M47/8JpR3bFefLCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajLXW+TjTmSUKB6xzGXkipm9bUDYfhmzZUPhdJoaKJ3jJa+sDo8U26cSaHAuIooHdphWR3DWPaSvWTf38hKdRVw7+ovI5Nyo2GiKTUrzRLb98djTJvHCBmHLCr65ZaTpBWHRYyto8vxwhHy5G1M2OI3JxxEvkvlu8AKpIrX+25Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lba5MhIf; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lba5MhIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784125398; x=1815661398;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GhjEJLSpPpvdk/BGkE+jWIJyJW4M47/8JpR3bFefLCk=;
  b=lba5MhIfcFhvIXazHDZYO2z0cxLnJvU3Au2m2X/GO22cUnIT9mMnQVrc
   eUYCYpR5TIZW30M/6GCTPaxmAGm8BAMCC+7o4PZBcv4rJE/m4Xo2HB56f
   GISP41H7afoQ4d0XuOE7IWd6RuUjSS2LCMvVha0wvsEorxMM5RJRZuM6U
   /9Y7GPNURGz9upZpf1yNoEvnfis+zJ043IQnnCBcTX7zJ6kz1S7aFiQsM
   Iv6w+38Y1Y2oVVXkWrlaCJ6U9tiho2zollUjC8+YaRUQ6xdDa1Pc6I2Km
   SPfalW6HgvPk18vshlF6qqzKYX2dz52Exc/eeS7vqmbR/DQ5oz27Qc8du
   g==;
X-CSE-ConnectionGUID: 0EemhcowSPaMCUZozOB52g==
X-CSE-MsgGUID: jGCykMQMTKy5lvLrmQy9jQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96278066"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96278066"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:23:17 -0700
X-CSE-ConnectionGUID: 2D/6uB4WQV2ozvoGt4WS8A==
X-CSE-MsgGUID: rsjQcbjbRtWbCl+DHv6VUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="253582612"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 07:23:16 -0700
Date: Wed, 15 Jul 2026 17:23:13 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v2] iio: buffer-dmaengine: Add support for cyclic DMA
 transfers
Message-ID: <aleX0UD96t12s44k@ashevche-desk.local>
References: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260715-iio-dma-cyclic-v2-1-268a3a28ff84@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 01:24:53PM +0200, Nuno Sá via B4 Relay wrote:

> Allow buffer blocks flagged as cyclic to be submitted as repeating DMA
> transfers. For cyclic blocks, use DMA_PREP_REPEAT so the engine keeps
> replaying the descriptor.
> 
> This is useful for output buffers where the same data should be driven
> continuously without userspace having to requeue it. Examples include
> continuous RF transmit paths replaying a calibration, test or beacon
> pattern.
> 
> Skip installing the completion callback for cyclic blocks. Since the
> transfer is continuously replayed, the callback would fire on every
> period, throwing off the block refcount.
> 
> Because nothing prevents a new cyclic transfer from replacing an
> already active cyclic one, always set DMA_PREP_LOAD_EOT so the engine
> correctly terminates the active transfer before loading the new
> descriptor.
> 
> Limit the DMA buffer queue to one cyclic DMABUF at a time. There is
> currently no known use case for queueing multiple cyclic blocks, and
> cyclic blocks stay referenced until the buffer is disabled.

...

>  static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
>  					     struct iio_dma_buffer_block *block)

> +		if (block->cyclic)
> +			flags = DMA_PREP_REPEAT;
> +		else
> +			flags = DMA_PREP_INTERRUPT;
> +
> +		/*
> +		 * A new transfer may need to end an already active cyclic transfer
> +		 * before it can run, so always set the EOT flag.
> +		 */
>  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
>  							 vecs, nents, dma_dir,
> -							 DMA_PREP_INTERRUPT);
> +							 flags | DMA_PREP_LOAD_EOT);

Logically I would expect this to be a separate line with the above comment.

		/*
		 * ...comment...
		 */
		flags |= DMA_PREP_LOAD_EOT;
		...
							flags);

>  		kfree(vecs);

-- 
With Best Regards,
Andy Shevchenko


