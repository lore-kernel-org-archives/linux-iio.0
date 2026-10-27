Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089649;
	b=vUCZ3JJwakJqyGhn1D0N4beZexNq3qZBt2GXSGsCvk88zKa/adER5fl+OY1xTGCpThW2
	 vsQ9t2zYWzMnbfNscsZmii/GH3fJjY20AaUxYkKu9va0dyJUqk0+jxuIF24cXTdEDhYIZ
	 Di2dHW7rR4R1/Id4XA7+QWgBG+4OrHUUGcCso3QZQaoOBc94RyoAkemx4sWtVHf8p81ZI
	 KzWqfjf0yj3EHZJHt875kmj+AR6RO4YLskAkQCRajo9WLbBkpPPMm/HnqMFPqj3ipd9N4
	 DW8rpD+a6XnJKUDXrjTPqAN29b7GqN33oB+6/dCaEoPwm3NreAIM417CAekIdG9y1uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089649;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=2vZn0vdNM16lPl7QWSIrNuFhMLWS/PrM2Urs5TcXE6g=;
	b=URYOEFqNSFyvzqCRAHWejE2jSW9a1KXCMDUogDJomJA0dHe19xmuqpKASY3OZI+BQjmX
	 tLdInPTx7CQbke97ZaS9NlDFNkv6tCbDY6pU1tbUr8ru2TwhK+qHM+HT4t5wFzM0SOhTr
	 ZeKyfVCAI3KWIUJdW9mdNkXxUYy1q+826ntSY4OnqPnn1vvuSXuSNmQU8U0VJ3rAykqzJ
	 f+lI9epUrHml/EaOrNphC+WX5hS0wGiDGK3pGMBI+yVTcvDarjPck6R4i39PPaI3AIEci
	 KSX/w32BTwX3H0cIthBAMIubr8u6C3Xwnwe47d2YXmCYSzsVhTl4KTrTKCHZ2+91eUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMDCxtN2;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DD2606A31B
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 08:27:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22DD2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=NMDCxtN2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793089649; x=1824625649;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=A3ma3GA/EfNr5gxL4tKtx4asxJ42R0n9sza6P6a+fX8=;
  b=NMDCxtN2W/DsHpU/L3hnDcjzsWq3vJz0xTswKhIlAdZ12SDlCHXnn26o
   8s9I5HlOnwIHHmM1UVwDdOsQSE509gkggg5n3dlYsAPpVVYx4zqa41ogs
   OOL0Y0TlYQyWFAytRPYpcECMdiAZgxfZrxpPrE8Qgz2WOtxZKRFokHXXi
   0RafBLgSxhiuu7w0D85sImqfn/UPPYrZAdDvs9Z4Ksxor99gLzTuJ2zTb
   EBvPn/lc3fpWvW4V5NSVw9LbmscZOVtsyFUai1P0PkrUlqF8ij5Vzf9nc
   FsV/rRGUCHNyMxax27SfHB3P96ioofuo5xV9XKgMNRwRZfupnuhHeHJ6E
   Q==;
X-CSE-ConnectionGUID: pIzfxP7dS662DXFZwnadew==
X-CSE-MsgGUID: Egm2UaxpSFGuxWk/9mPw4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1664793"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1664793"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:27:28 -0700
X-CSE-ConnectionGUID: UgocJJUgTmutmUKOwOC+Mg==
X-CSE-MsgGUID: IkLd8UoNQFqENxsDnUXgeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="4836967"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 01:27:26 -0700
Date: Tue, 27 Oct 2026 10:27:23 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH 18/39] iio: health: afe4404: use
 iio_push_to_buffers_with_ts()
Message-ID: <auBga-hNhlTOSwAG@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-18-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-18-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:36PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer.
> 
> The pushed buffer is never a direct DMA transfer target, so move it
> from the per-device state to the stack. Use
> IIO_DECLARE_BUFFER_WITH_TS() since the timestamp offset depends on the
> number of enabled channels, and zero initialize it.

...

> static irqreturn_t afe4404_trigger_handler(int irq, void *private)

>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct afe4404_data *afe = iio_priv(indio_dev);
>  	int ret, bit, i = 0;
> +	IIO_DECLARE_BUFFER_WITH_TS(s32, scan, 10) = { };

Move it one line up.

...

>  	iio_for_each_active_channel(indio_dev, bit) {
>  		ret = regmap_read(afe->regmap, afe4404_channel_values[bit],
> -				  &afe->buffer[i++]);
> +				  &scan[i++]);

Also possible to have now

	struct regmap *map = afe->regmap;
	...
		ret = regmap_read(map, afe4404_channel_values[bit], &scan[i++]);

(which will have the same amount of LoC).

>  		if (ret)
>  			goto err;
>  	}

...

> -	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
> -					   pf->timestamp);
> +	iio_push_to_buffers_with_ts(indio_dev, scan, sizeof(scan),
> +				    pf->timestamp);

One line?

-- 
With Best Regards,
Andy Shevchenko


