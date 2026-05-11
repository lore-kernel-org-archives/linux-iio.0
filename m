Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC0D370D6C;
	Mon, 11 May 2026 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778498843; cv=none; b=XmZR31++xC2gku1utMrx9NaKbIhGsbLxXLGTUtZ73nJPURI6S5BC1pbzfvEZmSEyW8G8Gv8OaBMRWuR3cN3Mjxch2QaKvarWru4fxoGpb/gHLa4uxh3DJH0gR7Lf+5pK6Rr9E5yLdBwvdQrcW22Py+hEDU8eNJJNiKQbU8EkRD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778498843; c=relaxed/simple;
	bh=S2n25drV7o+i0GWQBkS5bwkU3nNipLDZ3PSumJWDLKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BgqGIfbYYYreBFCoaxLQxB4K3K1K/0cxAhb6vxFdG6CSX4IcRvZysvhAmJpLV5WGHfuw2VR2oWWqXh/oA7qEER/Kxtz9l/rI5NdA1ZkqfNulMh/QVBIPtl4axBx0btRRQTuOs5afCzChur3qjRi5kYYs/wyF+/UL4pBw6Eqq4oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nx3beeKk; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nx3beeKk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778498842; x=1810034842;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S2n25drV7o+i0GWQBkS5bwkU3nNipLDZ3PSumJWDLKc=;
  b=Nx3beeKk5BIJaal6XPTEOnI6LoKrcChwampyQEbtudTSs9ImcDhTEmGp
   PDWUfAsqGDl7rMoJxdyA9+82spzvnSoKfOnvPbsCQTBhcvZuvia6MPkcl
   hJjZbWnHdobl8KYiFECmQynj5J+O7HKl11HN2o6MsTAyK9LkMUo6vyvB0
   JHrrzDwQeanr1zO58tCx69eC3d5NxTXDcXMjugfU9yeSr2rgYqI0hYJuC
   /2eVuFBA19AtcCq5+ZEe9vNaq2edKwiSekDiI3mJHDiur60fKZvcNGO6U
   R1YfRnWSIVCOnucY0+9YrRL+1K4MFlVxbxQHTmFFqVm6CbbzJlTbfBUmN
   w==;
X-CSE-ConnectionGUID: BCHEdPRWRn6TKx5sxmDy1w==
X-CSE-MsgGUID: UDTk7dMsQb2+trMKbkRN3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11782"; a="79563615"
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="79563615"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:27:21 -0700
X-CSE-ConnectionGUID: JMn5JZlNS5Wy68eyb0mObA==
X-CSE-MsgGUID: oHfiZRgLSaud5h7O0argEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,228,1770624000"; 
   d="scan'208";a="231037044"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 04:27:18 -0700
Date: Mon, 11 May 2026 14:27:16 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 11/11] iio: adc: hx711: add support for HX710B
Message-ID: <agG9FAXXiTKDIEDf@ashevche-desk.local>
References: <20260510194947.31997-1-piyushpatle228@gmail.com>
 <20260510202657.38326-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510202657.38326-1-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:56:55AM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but uses trailing PD_SCK pulses to select the active mode.
> 
> Model the HX710B with variant-specific channel tables and IIO info,
> track the active channel across conversions, and use the fixed gain
> value when computing scale.
> 
> Also update the adjacent Kconfig text, file header, and module
> description so the driver text matches the newly supported variant.

...

>  #include <linux/slab.h>
>  #include <linux/sched.h>

>  #include <linux/delay.h>
> +#include <linux/types.h>

Seems wrong order.

And here + blank line to make linux/iio/* to be a separate group.

>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/buffer.h>

...

>  	/*
>  	 * triggered buffer
> -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> +	 * up to 3x32-bit channels + 64-bit naturally aligned timestamp
> +	 *
> +	 * aligned_s64 satisfies the 8-byte alignment requirement for the
> +	 * timestamp. For HX711 (at most 2 active channels), iio_push_to_
> +	 * buffers_with_timestamp() places the timestamp at offset 8
> +	 * (scan_bytes=8, already 8-byte aligned), identical to the original
> +	 * 2-channel layout. The extra channel slot for HX710B does not affect
> +	 * the HX711 ABI.
>  	 */
>  	struct {
> -		u32 channel[2];
> +		u32 channel[3];
>  		aligned_s64 timestamp;
>  	} buffer;

Why can't we used a recently introduced macro for this?
IIO_DECLARE_BUFFER_WITH_TS().

-- 
With Best Regards,
Andy Shevchenko


