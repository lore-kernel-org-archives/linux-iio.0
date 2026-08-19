Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FB03C988E;
	Wed, 19 Aug 2026 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123861; cv=none; b=DuYWS1gWsdVJPvVC6C0MDLNUYecyfaTuoDgdxay0Fh/a3mr8O8vPH1eI2me0YHu/zbuiSXse5wE8ZEtDAmrB87NHtDZueo2KslTxFarld0jkcwVtvmAjWNrqE0W3CQFP2/Th+zO0hgvoFcCWCzzhnntVRxxeHcSfJrGeM2vkSDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123861; c=relaxed/simple;
	bh=EvexI16MC86FdiTScYMs/Pc3+JYGqctJY+Rc3l9hyJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WS5mIRlNtKeZqLFxhv3GgPg0NGerIsIjwXTGkPsf8iHBYmhELGO9A6MqngWEAfnnCrcYUS/75gOSoW8Lspn3fde2EA6eRyylqGSzcGIscFuh6d8YCCQp2vFZyzzYIVZClQqFpj3AVrQNIibgK0296ictgNtKIfJegJHZdGqu6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XRCZ2mNf; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XRCZ2mNf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787123858; x=1818659858;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EvexI16MC86FdiTScYMs/Pc3+JYGqctJY+Rc3l9hyJo=;
  b=XRCZ2mNfRum7A1LTRHdIXF9foOO4sX7H5SYwdNTB8n5FFdLtEjBNPgQe
   7lheerHeymDN0FAbl/pGG+sJPHEqM2W9QSPq6xI2qdA0O8ymjnL+ViQ43
   iMakPxfziQBmwwfxl6jKbxUju88i7j4ZU1QdWE4R9osuzXeON+WVAmXyb
   UwuqIKIKBB4Duj1/FP7ptBorPoWvuCDIR/9/kpzQZOxLlEPwvNg05804D
   6qBdgRg/xXsXwQ3t4MgTPcYWEcdTzgtiE3cmQhmZmDoh4QkIm0JQH+wJQ
   jks15pPM6Yx2XPOvYEGlCHzlU0bFAq7vAjiGbnKqH4Tskl7xI55VXjrT8
   g==;
X-CSE-ConnectionGUID: GAbB5pz3S6Wc7CEnF22+JA==
X-CSE-MsgGUID: 91f3/pGYQ02auF+U1Zfy9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="98987453"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="98987453"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:17:37 -0700
X-CSE-ConnectionGUID: D+NYrBpCTUqd2abGjqGlVg==
X-CSE-MsgGUID: +RaaCnOOR7ik72Md1mzy/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="261702471"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:17:35 -0700
Date: Wed, 19 Aug 2026 10:17:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gabriel Rondon <grondon@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: accel: kionix-kx022a: use scan struct for
 one-shot and trigger reads
Message-ID: <aoVYjc1ZRTj0OvTc@ashevche-desk.local>
References: <20260818215122.52715-1-grondon@gmail.com>
 <20260818215122.52715-2-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818215122.52715-2-grondon@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 10:51:21PM +0100, Gabriel Rondon wrote:
> The driver kept two separate staging areas that hold the same thing:
> buffer[8], a DMA-aligned area used by the one-shot read in
> kx022a_get_axis() and by the triggered handler, and the scan struct,
> used by the FIFO flush path. Both are three __le16 channels plus room
> for the timestamp.
> 
> Drop buffer and route the one-shot read and the triggered handler
> through scan.channels, so the driver has a single staging area. Move the
> IIO_DMA_MINALIGN alignment onto scan, since it now backs the regmap bulk
> reads that buffer used to.
> 
> No functional change. get_axis() only runs via read_raw() under
> iio_device_claim_direct(), so it cannot run while the triggered buffer is
> active, and the triggered handler only runs while it is; the two never
> touch scan concurrently, exactly as they previously shared buffer.

...

> static int kx022a_get_axis(struct kx022a_data *data,

>  {

I would rather do this

	__le16 *buf = &data->scan.channels[0];

>  	int ret;
>  
> -	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer[0],
> -			       sizeof(__le16));
> +	ret = regmap_bulk_read(data->regmap, chan->address,
> +			       &data->scan.channels[0], sizeof(__le16));

	ret = regmap_bulk_read(data->regmap, chan->address, buf, sizeof(*buf));

>  	if (ret)
>  		return ret;
>  
> -	*val = (s16)le16_to_cpu(data->buffer[0]);
> +	*val = (s16)le16_to_cpu(data->scan.channels[0]);

	*val = (s16)le16_to_cpup(buf);

-- 
With Best Regards,
Andy Shevchenko


