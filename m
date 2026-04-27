Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF62E3CEB9D;
	Mon, 27 Apr 2026 14:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298542; cv=none; b=rWr4k8cHYF/nIhU1+C9WoIiXNQDGYfTQKrqxMCNjBTZiv4ToKGYnIyZExNL0Ex4p9h00ZPVG9WP451/3Qz0x8O7eFTrHEU46VS/9YpZXHg+7DGsqs/klv8b7MJEAHR8jFknrPjJGoLnqbSd8hBAeOdcO5YbNjLOtbojupdUXDnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298542; c=relaxed/simple;
	bh=7Gra0MesnEZXHUo+I08l87jSn9s/OjE9JOQI03sCmbo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fbGaizlbvlCBwJRdtG6VsASdCc5NXp6BYZHYOFDz1ulQl9TCvdISq+eQ5MeYtiWqiErMTO46Drj72ezqYVQy9H/zA9BW1QvSBZICltyq8vrDGQLQXO8A9OiWJEaY+g0rl3f2PlIqwkT4ZJDoYMgRmLZ1XvQeDMHyP2HcQsaSZI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bRb2aTuv; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bRb2aTuv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777298540; x=1808834540;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Gra0MesnEZXHUo+I08l87jSn9s/OjE9JOQI03sCmbo=;
  b=bRb2aTuvtO4B5iwy6cJB/+VZAD5IMNNzgL+n7HIVyye3qbxUo1+1gohP
   zbYioIKEtRlx8MvDmS4MXc4Pef5jhmupf8Z4sHJE8bCNPdH4Ancqs/rnT
   sKI64drwiHQIcYBKrw2AhLutR7eDfmRG61GSiBmNAmUrfF4K3dLE8I0U8
   8rMFTJyGIUc3zDbom4ds4oeUpHAcYN9xfPwUD76uu5ZJpcaP2A94lVk2E
   +LWvR0s5nddo0XOzUwsRGiC+UkvqbS9ZyZQuD4RFJ2U0jBOTxqbZcVCea
   N9te5ObpO9iiExYtMfoskdoG6TVI4fO6eDsGhcwWXSxyshWKcE4vmzXUd
   g==;
X-CSE-ConnectionGUID: s3sKbw0ZTqKRLw/Q0EIqbw==
X-CSE-MsgGUID: 4yY4Ge9dQ1e0zk830PrH/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78204155"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78204155"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:02:20 -0700
X-CSE-ConnectionGUID: M1CIRg62TOO2fpCSn0FjYw==
X-CSE-MsgGUID: DnQdcdrQTOuXudMt1gVjGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="231012157"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:02:16 -0700
Date: Mon, 27 Apr 2026 17:02:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/7] iio: adc: hx711: move scale computation to
 per-device storage
Message-ID: <ae9sZonxK7HTXsUT@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-3-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427100950.33936-3-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 03:39:33PM +0530, Piyush Patle wrote:
> The gain-to-scale table hx711_gain_to_scale[] is a global array whose
> .scale fields are overwritten in hx711_probe() using the AVDD voltage
> read at probe time. When two HX711 sensors are connected to supplies at
> different voltages, the second probe call overwrites the scale values
> computed for the first sensor, silently corrupting its readings.
> 
> Fix this by removing the .scale field from the global table, making the
> table const, and adding a per-instance gain_scale[] array to hx711_data.
> Populate gain_scale[] in hx711_probe() using the device's own AVDD
> regulator voltage. Update hx711_get_gain_to_scale() and
> hx711_get_scale_to_gain() to take the per-instance array as a parameter,
> and update hx711_scale_available_show() to retrieve it via iio_priv().
> 
> No functional change for single-sensor configurations.

...

>  /*
>   * .scale depends on AVDD which in turn is known as soon as the regulator
> - * is available
> - * therefore we set .scale in hx711_probe()
> + * is available; it is stored per device in hx711_data.gain_scale[]
>   *
>   * channel A in documentation is channel 0 in source code
>   * channel B in documentation is channel 1 in source code
>   */
> -static struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
> -	{ 128, 1, 0, 0 },
> -	{  32, 2, 0, 1 },
> -	{  64, 3, 0, 0 }
> +static const struct hx711_gain_to_scale hx711_gain_to_scale[HX711_GAIN_MAX] = {
> +	{ 128, 1, 0 },
> +	{  32, 2, 1 },
> +	{  64, 3, 0 }

I would leave trailing comma, as it is semantically is not the terminator entry.

>  };

...

>  {
>  	struct iio_dev_attr *iio_attr = to_iio_dev_attr(attr);
>  	int channel = iio_attr->address;
> +	struct hx711_data *hx711_data =
> +				iio_priv(dev_to_iio_dev(dev));

First of all, please preserve the reversed xmas tree order.
Second, it's more than enough room to have it a single line.

	struct hx711_data *hx711_data = iio_priv(dev_to_iio_dev(dev));

>  	int i, len = 0;

-- 
With Best Regards,
Andy Shevchenko


