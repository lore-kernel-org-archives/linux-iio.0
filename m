Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595624;
	b=SG9GQu8NSWTpNggC2MqSx/b1VhqajIXg3ZSdxZCHiIrmhqdH0JuVsNt0xdLk4gxJV6pB
	 3Syf/HC+SmGzKws5XvSeK0hI1CiLVHMNQIJeznWYhyvLLa+UY+FHURLNb2+tT1F3n/g1I
	 Kx9WhMDdzsxlmLpYPrPMJOdf2sUUVvO9tI9g4ABWF0aplEwEeptU1fEFdwafuq2BIHU74
	 eakdoLGvM60WpdZWWomVtOAHxv+VFIWb1C+S/gM10gaKSDOjCZctGZ9dtBotC7qsg7UBk
	 6GFmQI2l02kydrjuVDoqtngNH6jBjnGC83lpzI0df+sNXGNSr7rc0uMpfGx1Sv8Kl7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595624;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=KxpO86Q0W+aWjReqhlSHVuBksZU+TOD9Uy4JnKjmlfs=;
	b=lzzRQK8CWbMqwUB4Qsv31tsK32jlDYis7RYfxJYa4nqCdVsYyWLlA5icUk/1Cd1r3TAK
	 eazq5WZVLe+LFWhD+tmx9P7qfz53eP9BwkfJNGFQTiTt4uJp7q6J+VKoUrO7bzqzJrjSN
	 mVKYv2wSfc73pbaerVWpf7HTT+cSsGrzdFy1fxh5zJNrYNbhfO0rY/gDYNjG71bV5qRW1
	 1HK1p64eJ3evyAMqV1gquVQSS+i++5wXHgm5w0ZiTgD/3JS0KRW48W9+paxl0/LXc8Ffp
	 KjPkxcs+zPKtSoXLDdzFE/k3QJ1/qhZlBTpqTJvbqlh0kbtj9s12crCCVWP0OBYMRlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eZ32q6fD;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E04606A319;
	Wed, 21 Oct 2026 15:13:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E04606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eZ32q6fD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792595622; x=1824131622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UIFQcVy5Zsmxy4T/q0obmOoralhVzyur/Xc2hxCmnTM=;
  b=eZ32q6fD46OwdSXBdYoUmcjW0t/vP1Dasxa2esK96Wkj8NaIBCYEeTa4
   V1wzf764+JcRkKmy0fnN05Wf+kDWFzeFHldBnI2v+E2P+qYW0VNzbNtMf
   uGZfqH4xK9tn4d5dAMkKUxFW9khn75mE4DS09dlk2XP3OSY+oQP1VsHaZ
   ItfKLAZfRRBfX66k0LLy449u9E1cZt3+CCkPohit6uT22e3+pz/yWaXG6
   oaZ9Uj8UGMGi+yqC+2SolcSeKGaXpHTlVRip25TfVrgzYjD21zZi1TGH3
   HtVpVkygikfeVWBa6/sTXcqHvVOiPabxf9oDDKVHm5j2XRFsaeY8DDVAd
   g==;
X-CSE-ConnectionGUID: bF7/4nVMSRO8Kpj4LZ1Wjg==
X-CSE-MsgGUID: L96qcTiFSi2OR9Te308U5w==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1212278"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1212278"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:13:41 -0700
X-CSE-ConnectionGUID: n2DUfOjvRROA1dh/XPSPRw==
X-CSE-MsgGUID: Iq8tyuFxQVKj66CHfi152g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3038524"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2026 08:13:38 -0700
Date: Wed, 21 Oct 2026 18:13:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux@analog.com, broonie@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org,
	Michael.Hennerich@analog.com, nuno.sa@analog.com, jic23@kernel.org,
	dlechner@baylibre.com
Subject: Re: [PATCH v4 8/9] spi: spi-engine-ex: Add support for multi-CS
 devices
Message-ID: <atjWoMzRHsSbOjbi@ashevche-desk.local>
References: <cover.1792435248.git.Jonathan.Santos@analog.com>
 <183539c950c013d472c6b46e3f1365b022e7c716.1792435248.git.Jonathan.Santos@analog.com>
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
In-Reply-To: <183539c950c013d472c6b46e3f1365b022e7c716.1792435248.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 20, 2026 at 10:58:37PM -0300, Jonathan Santos wrote:
> The SPI Engine controller only handled the first chip select when
> asserting CS lines and configuring CS polarity inversion, ignoring
> additional CS indices present in cs_index_mask.
> 
> Update spi_engine_gen_cs() to iterate over all set bits in
> cs_index_mask and toggle each corresponding CS line in the assert mask.
> Update spi_engine_setup() likewise so that SPI_CS_HIGH polarity is
> applied to every active CS index rather than only index 0.
> 
> Set SPI_CONTROLLER_MULTI_CS in the controller flags to reflect the
> capability to the SPI core.

...

> +static unsigned long spi_engine_get_chipselect_bits(struct spi_device *spi,
> +						    unsigned long index_mask)
> +{
> +	unsigned long bits = 0;
> +	unsigned int idx;
> +
> +	for_each_set_bit(idx, &index_mask, SPI_DEVICE_CS_CNT_MAX)
> +		bits |= BIT(spi_get_chipselect(spi, idx));
> +
> +	return bits;
> +}

Since the chipselects are in a sequential range, wouldn't that repeat one of
bitmap_gather() / bitmap_scatter()?

-- 
With Best Regards,
Andy Shevchenko


