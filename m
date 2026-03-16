Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FFE228B4FD;
	Mon, 16 Mar 2026 11:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660423; cv=none; b=PRiBOMFJb2Ct6tc1kOBqvfTtzwpwzNZf0iEN9Se6pYgAhorEPAMLEQSMQvG24Mr3YXGJTK6UCJbVCP1htEZR3EA0K76GUHIsI+VQtAqnfWxkPIFQyUU7iuuXkJBFzioABUWvub6RItV+O8ZG6M0w6H5CHvbI15m5q+8foNQ0sOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660423; c=relaxed/simple;
	bh=eJjTVDDPV3wfEwUW6pl59/ZcHzHS9NvGmYYZZMKjlJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFCfbBHFVba8d3Z6/FnLAyzmvMs8tSdaBfYyM+KQC366D9nbEJ690gOZRWhTZlJJ0WBmc/8UKTMB+u+0GKNWktVrLYN1KNW8l2xtiCHrPKcV9hjmsuTolAJG6xU56OQQRmgSnOs3ba7wQpxG+AuFwh+B/cLErg6K3xqKB91tjgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R5xsUMOc; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R5xsUMOc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773660422; x=1805196422;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eJjTVDDPV3wfEwUW6pl59/ZcHzHS9NvGmYYZZMKjlJE=;
  b=R5xsUMOchq9C3nYV5U7YQivkV6FSNNv9XE9ZqEROYWwUUPplVtxBzWVs
   KK5KQ3KYAHa270t7dgdOcFdoCA6lvP/0HFZJBf5W5PpyPs9WH6r3APb/l
   Sb3tCA+dPGIR5Vr1vDyRL9bFk5AiLsoP7XThwj7gbATWfBu/QYO7JRzvF
   kRfMwL3DsPHUyVVb4f6KzxAxhDbzKGtkncw8mHGQhyfU8b73NdEbLlqKZ
   NSYrhoOUnP6HJ/bfqA0nlNPcU4ILG86Q/fHPVnNdeiCVo6cQSV2T0RBtz
   ZQTYtgTAkWdceESwicY3IVjHpttuPEoGqlaRSK0NcMlDjqCjzhhMG8BFM
   g==;
X-CSE-ConnectionGUID: Txz6QXLjTo2Hc0StAS3bag==
X-CSE-MsgGUID: fAhSWQp1RXeAitoSeMdmdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="74860130"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74860130"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:27:02 -0700
X-CSE-ConnectionGUID: nxD/Hv3jR3egORR3uPQ+PA==
X-CSE-MsgGUID: fGEcmMpOS7yCLMg5wlZy3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="222089825"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 04:27:00 -0700
Date: Mon, 16 Mar 2026 13:26:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ti-ads7950: use
 iio_push_to_buffers_with_ts_unaligned()
Message-ID: <abfpAcN3qDKe4zdd@ashevche-desk.local>
References: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314-iio-adc-ti-ads7950-declare-dma-buffer-v2-1-2087fc18b077@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 04:12:24PM -0500, David Lechner wrote:
> Use iio_push_to_buffers_with_ts_unaligned() to avoid unaligned access
> when writing the timestamp in the rx_buf.
> 
> The previous implementation would have been fine on architectures that
> support 4-byte alignment of 64-bit integers but could cause issues on
> architectures that require 8-byte alignment.

...

> +	u16 rx_buf[TI_ADS7950_MAX_CHAN + 2] __aligned(IIO_DMA_MINALIGN);
>  	u16 tx_buf[TI_ADS7950_MAX_CHAN + 2];

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf[2],
> -					   iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_ts_unaligned(indio_dev, &st->rx_buf[2],
> +					      sizeof(*st->rx_buf) *
> +					      TI_ADS7950_MAX_CHAN,

Hmm... Wouldn't this benefit from array_size() macro?

> +					      iio_get_time_ns(indio_dev));

-- 
With Best Regards,
Andy Shevchenko


