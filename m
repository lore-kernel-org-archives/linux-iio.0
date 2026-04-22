Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B672D780A;
	Wed, 22 Apr 2026 20:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776889258; cv=none; b=A6oKOFxZEny50ecofJTzOwjBw0fqA7Npla2xX5O+G/vcgSAKW94nKWXzWmLxPsET7DLf+cAAskPS19HDqHOTGvsKEDL2qhppATVG1y0aQy1cZEZqfztlpF4+Fhx1HwrtwZ0wBxZ4Zr09ojviUOQATJe2cvfj+TViVY5yvvUjsxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776889258; c=relaxed/simple;
	bh=XFa90mEOxl+QhKm1hV7oWFrAc3UsoZBsXGcQcysEG28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aeCg+0ONdhHP3ezIONmoVf1k/2CTvFJ7E378qg0/guNuSt6JV14tdym9fLRCrEbpPcCYlQQ3d8m5JSecyJyjvrksx5/oBlUXNPdFdtuA+NnXa5fQr0LvNeeZTvAaLOgIw/+kBdlCY1ryjDKbVEQ9kWK4YICfnqSvhnst7+yf6cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J4Ubox/N; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J4Ubox/N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776889257; x=1808425257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XFa90mEOxl+QhKm1hV7oWFrAc3UsoZBsXGcQcysEG28=;
  b=J4Ubox/NJZkKUcmN/JNsw85yYUU3V4tXmngLOW4RX6Z9REkD9ZBtHmD2
   nXUoHJMGZBKceCY5oP6ZBfx7BHXoxApVYE3TSPFN/KYfe2g6uhDLO7flW
   kQwJWHjtPmy+NFp3Uk+MgmqTocHc3UNljuXW9X9rbsggX+cwjGxgJq34s
   M5p/XJ9+Bza5VreUALGert+gKeII3chcwHX47IM2MSgkIOdzAbM82YjDJ
   +bBSt03iuzsCSy4zssQL/iwjPT1AgXZ8S6rpFinm4LJxLDawP1xVHyeFv
   LrqlvlsHYiDEP45U065l2aP2TRqJhQztT4trD+1LK+gD7aMtyPByk/oXx
   g==;
X-CSE-ConnectionGUID: jbZR8SESTRKK/3MJBBCTCA==
X-CSE-MsgGUID: YpvpY+vYSOK8IGPc7wwIOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="100507960"
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="100507960"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:20:56 -0700
X-CSE-ConnectionGUID: ae2aO24uS4CaX2FAMbeAAA==
X-CSE-MsgGUID: /uVcAYy5RJi9k3F7A9PU/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,193,1770624000"; 
   d="scan'208";a="232354436"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 13:20:54 -0700
Date: Wed, 22 Apr 2026 23:20:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andreas Klinger <ak@it-klinger.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: hx711: add support for HX710B
Message-ID: <aekto_uV5JXkOibo@ashevche-desk.local>
References: <20260422175910.1258579-1-piyushpatle228@gmail.com>
 <20260422175910.1258579-4-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422175910.1258579-4-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:29:10PM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but has a fixed gain of 128 and uses trailing PD_SCK pulses
> to select between the differential input and the DVDD-AVDD supply
> monitor.
> 
> Model the HX710B with its own channel specification and iio_info.
> Store the HX710B trailing pulse counts in chan->address and add
> fixed-gain handling so the HX711 selectable-gain path remains
> separate from the HX710B fixed-gain path.
> 
> The HX710B datasheet documents a single fixed PGA gain of 128 and
> does not provide configurable gain selection like the HX711.
> 
> Order hx711_chip_info as pointers first, then unsigned int fields, then
> bool. pahole then reports no internal holes in the structure; the
> remaining padding is tail padding from 8-byte alignment.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> ---
> Changes in v3:
> - Add HX710B support on top of the separate hx711_chip_info refactor.
> - Update channel_set only after hx711_read() and hx711_wait_for_ready()
>   both succeed.
> - Keep a single HX710B fixed-gain scale based on the datasheet's fixed
>   PGA gain of 128; do not apply the HX711 channel-B gain of 32 to the
>   HX710B supply monitor path.
> - Use unsigned int for channel state and fixed-gain scale storage.
> - Keep HX710B trailing pulse counts in chan->address.
> - Describe HX710B channel 0 as a differential IIO channel.
> - Reorder hx711_chip_info fields based on pahole output so the
>   structure has no internal holes.
> 
> Changes in v2:
> - Fix pulse count bug: HX710B values were {25, 26} total SCK cycles;
>   corrected to {1, 2} trailing pulses because hx711_read() already
>   clocks the 24 data bits.
> - Add .differential = 1 and .channel2 = 1 to HX710B channel 0.
> - Move trailing pulse counts from a separate array to chan->address.
> - Replace chan_pulse_count tests with a dedicated fixed_gain flag.
> - Add fixed_gain_val to hx711_chip_info.
> - Add the iio_info pointer to hx711_chip_info and assign
>   indio_dev->info from chip_info.
> - Remove the NULL check after device_get_match_data().
> - Remove reset_channel from hx711_chip_info.
> - Change hx711_reset_read() and hx710b_set_channel() to take
>   const struct iio_chan_spec *.
> - Revert unrelated hx711_data struct member alignment noise.
> - Sort of_device_id entries alphabetically.
> - Expand the commit message to explain HX711 versus HX710B trailing
>   pulse behaviour.
> - Restore the file header to mention weight sensor modules.

...

>   * struct hx711_chip_info - per-variant static configuration
>   * @name: IIO device name
>   * @channels: channel specification
> - * @num_channels: number of channels
>   * @iio_info: IIO info ops for this variant
> + * @num_channels: number of channels

>  struct hx711_chip_info {

> -	unsigned int			num_channels;
>  	const struct iio_info		*iio_info;
> +	unsigned int			num_channels;

>  };

No ping-pong patches, please. If you know the result, place the field in the
structure and kernel-doc in the place where it will stay during the entire
chain of changes in the same series. I.o.w. ideally you must have no '-' lines
_at all_ in this patch.

...

Also, split to a couple more preparatory patches. Altogether I expect this
series to be ~7 patches or more.

-- 
With Best Regards,
Andy Shevchenko


