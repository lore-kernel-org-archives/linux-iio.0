Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF001E8337;
	Sun,  8 Feb 2026 14:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770559380; cv=none; b=Ce0VRSKquAp/fx8UJzVdkXV8yx1VmU3wNeATja2V2cmWqsgkhHGGT+wL45ocvHI7+uYjQjoH3sHlU7pRwOq9UYXceDzf+Vn3YIDjdKmNgPGQIa3+pGwtm3Raps3hFHOFkohEXSNWRrYc1c/rkznVyJr86obHHg7WqrPLfhC8pIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770559380; c=relaxed/simple;
	bh=nMGK0BP6OuOVOKaBgR69rVIqcHG7H2GkskKr9RXV4Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fq0CklFwsMzqjw9/1zWCY1wAW1aP+dZzErOE7n7rvqxXbWGN81IKJwb/U3oYNU5tBaiwvHf1Q38MbUG9UAxhg7WQ7W22d2LhNJMpxWptaayHby2Y6YJlEQOSfhkFaEIs7BusyyI+p3jmnWGATNk3oItAefS9s2chMA0/VJ7LwHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0b2r4fl; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0b2r4fl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770559379; x=1802095379;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nMGK0BP6OuOVOKaBgR69rVIqcHG7H2GkskKr9RXV4Oc=;
  b=k0b2r4fl5zpZKn1aw5kb/mKKsQ9iZzcownfBZntMJ8X0BcXMafcraqGT
   DUa5+ovAvFGYWyb3kWpH3atksmFaOmDYEN5VZoYm9hHsqg+SpWXiQlcrY
   sLaPbyksIInYpJG0dASgTjJ9kWFJ0OrwabrOctRElrSXegA6e5jnbzJOu
   tgwNYOWiRQMCC7oCiiPIcXvzQt3xwIaXyzI1JZcWs0kQEb/bb8eBbw7UY
   BXMHxj+DdklA95Jf6KR+z53OPG+aZS6OORjHg7uLmZo5hQPVYAVly6iEo
   iHZhtjpIaD1Jk+0l774HF4hUY8LGc9/ZuNxV2tyD8lvFe3WFXj5j0X7Wl
   A==;
X-CSE-ConnectionGUID: hFrywRTWQ5GuYymcznCkeQ==
X-CSE-MsgGUID: 7PTNbqyAQfKGNGL7cfyecw==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="83066187"
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="83066187"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 06:02:59 -0800
X-CSE-ConnectionGUID: YlsWcOOaQc2zJnmi4ZFP4A==
X-CSE-MsgGUID: RlvpBCsHTzWaXv4afxqvOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,280,1763452800"; 
   d="scan'208";a="215848786"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.100])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2026 06:02:55 -0800
Date: Sun, 8 Feb 2026 16:02:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, michael.hennerich@analog.com, nuno.sa@analog.com,
	eblanc@baylibre.com, dlechner@baylibre.com, andy@kernel.org,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	corbet@lwn.net, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v8 8/8] iio: adc: ad4030: Support common-mode channels
 with SPI offloading
Message-ID: <aYiXjCpiMQ_h9Ao4@smile.fi.intel.com>
References: <cover.1770403407.git.marcelo.schmitt@analog.com>
 <1f05069e25e9ea28db2cef9fa3856456be3c2614.1770403407.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f05069e25e9ea28db2cef9fa3856456be3c2614.1770403407.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 04:02:42PM -0300, Marcelo Schmitt wrote:
> AD4030 and similar devices can read common-mode voltage together with
> ADC sample data. When enabled, common-mode voltage data is provided in a
> separate IIO channel since it measures something other than the primary
> ADC input signal and requires separate scaling to convert to voltage
> units. The initial SPI offload support patch for AD4030 only provided
> differential channels. Now, extend the AD4030 driver to also provide
> common-mode IIO channels when setup with SPI offloading capability.

...

> -#define AD4030_CHAN_CMO(_idx, _ch)  {					\
> +#define __AD4030_CHAN_CMO(_idx, _ch, _offload)  {			\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
>  		BIT(IIO_CHAN_INFO_SCALE),				\
>  	.type = IIO_VOLTAGE,						\

>  	.scan_index = (_idx),						\
>  	.scan_type = {							\
>  		.sign = 'u',						\
> -		.storagebits = 8,					\
> +		.storagebits = (_offload ? 32 : 8),			\
>  		.realbits = 8,						\
> -		.endianness = IIO_BE,					\
> +		.endianness = (_offload ? IIO_CPU : IIO_BE),		\

Hmm... This is interesting. Does it mean it's designed like this for any
offloaded SPI case? Wouldn't be better to follow the same endianess in both?

>  	},								\
>  }


-- 
With Best Regards,
Andy Shevchenko


