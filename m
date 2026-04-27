Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2679527FD49;
	Mon, 27 Apr 2026 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777300493; cv=none; b=DdYo8FKWqXHFYOYx6C5xh9Ee5n5MunU/itZuvKYSUs6ZKVHSoVHDF+i0/AOhuNdnB/H2TLmFRT+iVSXksVmGzmvB1rLof4kdyPEUmT84+OfjePrnpEbwW6quyTi5fTIWI9rfCTmXI8IbWahDjKajV+1vU3K7xuSkTFZHOWGYzMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777300493; c=relaxed/simple;
	bh=9EA5BQaltMfSm6WKlTqEDSoKvc40GGMtQgJywLfcVmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul0GhWsPgjA2AeO2Vl0J/lAFgEWnzMYh1LcEhcB90aW6D38qLKXE5BhtklFRJFEQn4tjMIqzgTEN+O04OrIN2nq+RUzhhWD6HFHd+oZSPaLtd7CzF9mSsDVZbD5iFpnfXwdIQIXQwzii1K99YGwD2pTrdUXlKKjiKUG6Dv4JBOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j34Tq4Dv; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j34Tq4Dv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777300492; x=1808836492;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9EA5BQaltMfSm6WKlTqEDSoKvc40GGMtQgJywLfcVmo=;
  b=j34Tq4Dv4eUGZC3W31tN9Aydm/SQrfVHJ/M/E/pgDMYAXIT7p5335zGR
   1d/e4Wd5CGDCmxpLp7YFi7ZkUUsjBhKJchtfbKzXi4SAzXqfRQZ01SeK2
   2r7CvbERnJ8BQjVxTg3whwMEefkgbthb0/1iHOP0iZo7jahRv7rRQjH67
   qcDkbM29nI8mSuOOTBc2kstfTO15jGHShXdvifetYiHm/J+hSEY4oSAZQ
   Z83g8dzS+t7QLdXCwnwL6bOEhAst9Dfq79k96n3UUw0e8R24+zKyZCmiS
   QGRabRzjrveax5E2bxKjswv6vc2FV42mttu5htKvMxNd+Q973Cnkx7hCe
   Q==;
X-CSE-ConnectionGUID: wQaqHaUaQrCs6Y5NTwXy1Q==
X-CSE-MsgGUID: UzfCdC20RO6pP3fBqYuACQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="82038722"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="82038722"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:34:51 -0700
X-CSE-ConnectionGUID: HcE8Dt3mTYCCnQRxc3Sp+Q==
X-CSE-MsgGUID: aDT+VsBnQOiOXPvNhu8pQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238643765"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 07:34:48 -0700
Date: Mon, 27 Apr 2026 17:34:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iio: adc: hx711: add support for HX710B
Message-ID: <ae90BqnY6_dhRn1F@ashevche-desk.local>
References: <20260427100950.33936-1-piyushpatle228@gmail.com>
 <20260427100950.33936-8-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427100950.33936-8-piyushpatle228@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 03:39:38PM +0530, Piyush Patle wrote:
> Add support for the AVIA HX710B ADC, which shares the HX711 GPIO
> interface but has a fixed gain of 128 and uses trailing PD_SCK pulses
> to select the active channel rather than the gain.
> 
> The HX710B has three operating modes controlled by the trailing pulse
> count after the 24 data bits (Table 3 in the HX710B datasheet):
>   25 pulses (1 trailing): differential input at 10 SPS
>   26 pulses (2 trailing): DVDD-AVDD supply monitor at 40 SPS
>   27 pulses (3 trailing): differential input at 40 SPS
> 
> Model the HX710B with its own hx710b_chan_spec[] and hx710b_iio_info.
> Store the trailing pulse count in chan->address so hx710b_set_channel()
> can switch channels without a separate lookup table. The supply monitor
> uses .channel = 2 to avoid aliasing the channel2 terminal (index 1) of
> the differential pair.
> 
> The HX710B has a dedicated VREF pin for the ADC reference voltage. The
> driver tries vref-supply first; if absent it falls back to avdd-supply
> (for boards where VREF is tied to AVDD). The HX711 uses AVDD as its
> reference and is unaffected.
> 
> Add fixed_gain and fixed_gain_val fields to hx711_chip_info to carry the
> gain into the scale calculation. Store a per-instance scale in
> hx711_data for HX710B and use it in hx711_read_raw() when fixed_gain is
> set. Update hx711_reset() to reset channel_set on HX710B after a
> power-down cycle.
> 
> Enlarge the trigger buffer from 2 to 3 channels plus a pad word to keep
> the timestamp naturally aligned; HX711 continues to use only the first
> two slots.

So, missed types.h should be in this patch.

...

>  /**
>   * struct hx711_chip_info - per-variant static configuration
> - * @name:         IIO device name
> - * @channels:     channel specification array
> - * @iio_info:     IIO info ops for this variant
> - * @num_channels: number of entries in @channels
> + * @name:          IIO device name
> + * @channels:      channel specification array
> + * @iio_info:      IIO info ops for this variant
> + * @num_channels:  number of entries in @channels
> + * @fixed_gain_val: fixed PGA gain (used when @fixed_gain is true)
> + * @fixed_gain:    true if the variant has a fixed ADC gain (e.g. HX710B)

No, make sure there will be no '-' lines here.

>   */

...

>  struct hx711_data {

>  	int			gain_set;	/* gain set on device */
>  	int			gain_chan_a;	/* gain for channel A */
>  	int			gain_scale[HX711_GAIN_MAX];

> +	unsigned int		channel_set;	/* HX710B active channel */
>  	const struct hx711_chip_info	*chip_info;
> +	unsigned int		scale;		/* HX710B fixed-gain scale */

Semantically the scale is closer to the above gain_* ones AFAICS.

>  	struct mutex		lock;
>  	/*
>  	 * triggered buffer
> -	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> +	 * up to 3x32-bit channels + pad + 64-bit naturally aligned timestamp
>  	 */
>  	struct {
> -		u32 channel[2];
> +		u32 channel[3];
> +		u32 pad;
>  		aligned_s64 timestamp;
>  	} buffer;
>  	/*

...

>  static int hx711_reset(struct hx711_data *hx711_data)
>  {
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
>  	int val = hx711_wait_for_ready(hx711_data);
>  
>  	if (val) {

The rule of thumb is to split definition and assignment for the variables that
are going to be validated.

Here I expect to see

	int val;

	val = hx711_wait_for_ready(hx711_data);
	if (val) {

But since it's not related directly to this change, make a preparatory patch.
Because now with two variables this looks worse and adds more potential to be
mistaken in the future.


> +static int hx710b_set_channel(struct hx711_data *hx711_data,
> +			      const struct iio_chan_spec *chan)
> +{
> +	int ret;
> +
> +	if (hx711_data->channel_set == (unsigned int)chan->channel)
> +		return 0;
> +
> +	ret = hx711_read(hx711_data, chan->address);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = hx711_wait_for_ready(hx711_data);
> +	if (ret)
> +		return ret;
> +
> +	hx711_data->channel_set = chan->channel;
> +
> +	return 0;
> +}

...

> -	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
> -	if (ret < 0)
> -		return ret;

> +		ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
> +		if (ret < 0)
> +			return ret;
> +		trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
> +	}
>  
> -	trailing_pulses = hx711_get_gain_to_pulse(hx711_data->gain_set);
>  	return hx711_read(hx711_data, trailing_pulses);

Instead of the above, first split these lines to a helper

static int hx711_set_hx711_channel(..., *tp)
{
	int ret;

	ret = hx711_set_gain_for_channel(hx711_data, chan->channel);
	if (ret < 0)
		return ret;

	*tp = hx711_get_gain_to_pulse(hx711_data->gain_set);
	return 0;
}

And name your new function something like

hx711_set_hx710b_channel()

...

> +	/*
> +	 * The HX710B uses the VREF pin as the ADC reference; try vref-supply
> +	 * first and fall back to avdd-supply when VREF is tied to AVDD on the
> +	 * board.  The HX711 uses AVDD as its reference.

I think we use a single space in the comment, but double check that.
The rule of thumb is to keep the original driver style and change it
separately if required.

> +	 */

...

>  	/*
>  	 * with

While at it, with --> With.

> -	 * full scale differential input range: AVDD / GAIN
> +	 * full scale differential input range: VREF / GAIN
>  	 * full scale output data: 2^24
>  	 * we can say:
> -	 *     AVDD / GAIN = 2^24
> +	 *     VREF / GAIN = 2^24
>  	 * therefore:
> -	 *     1 LSB = AVDD / GAIN / 2^24
> -	 * AVDD is in uV, but we need 10^-9 mV
> +	 *     1 LSB = VREF / GAIN / 2^24
> +	 * VREF is in uV, but we need 10^-9 mV
>  	 * approximately to fit into a 32 bit number:
> -	 * 1 LSB = (AVDD * 100) / GAIN / 1678 [10^-9 mV]
> +	 * 1 LSB = (VREF * 100) / GAIN / 1678 [10^-9 mV]
>  	 */

...

> -	for (i = 0; i < HX711_GAIN_MAX; i++)
> -		hx711_data->gain_scale[i] =
> -			ret / hx711_gain_to_scale[i].gain / 1678;
> +	if (chip_info->fixed_gain) {
> +		hx711_data->scale = ret / chip_info->fixed_gain_val / 1678;
> +	} else {
> +		for (i = 0; i < HX711_GAIN_MAX; i++)
> +			hx711_data->gain_scale[i] =
> +				ret / hx711_gain_to_scale[i].gain / 1678;
>  
> -	hx711_data->gain_set = 128;
> -	hx711_data->gain_chan_a = 128;
> +		hx711_data->gain_set = 128;
> +		hx711_data->gain_chan_a = 128;
> +	}

Looking at this I'm wondering wouldn't be easier just to have the array, but
feel it with the same data.

...

> -	{ .compatible = "avia,hx711", .data = &hx711_chip },

> +	{ .compatible = "avia,hx711",  .data = &hx711_chip  },

Why?! This is stray change.


-- 
With Best Regards,
Andy Shevchenko


