Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A008933D4E4;
	Sat,  8 Aug 2026 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786184837; cv=none; b=fPWrkaqKkHaf0tGQu+oupWUqGo8VQkT9+clHt/WDQpJbTPx3xZP9q9IGo2nJT06Om5C/AEIo+N6u2qJS5L5aUGyQIz6dNeqwuO7QrwIkXRp7AFyOh0oIWVSZ9D/rzpXR26mNKwba2a2WFgBl/G9IwmIu6sgqP/9PBRFP4j37Tro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786184837; c=relaxed/simple;
	bh=7sYX9tqbyD0jbd/vwwHPiwfeqU+jQ3LaziNeCL02SkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJwORZySmkKf9I3kUzVatsU9Co+9meyYcwFqPadVU0h7PmZHdhSDKy2S+L9Yc67+2yCgClKL5B3rX6ZXSIDbOwU/9j6Zpw8f7OmWEQYzQAn+PaItumOqNYr6PB1C1ziti72Tcmcm0R8D4IHOQGHR6FpRTs6+igoKRrfzqpt/iSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTYGsF2w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTYGsF2w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786184834; x=1817720834;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7sYX9tqbyD0jbd/vwwHPiwfeqU+jQ3LaziNeCL02SkQ=;
  b=bTYGsF2wvU03FGT+30nkXIMgDWcZ/M7grfm5t94r9zKUsAwPSelnVOxI
   xewPFj/+9NcT67RO9tTiB/O/UVl4/SCXWkHpKnY09l7YibfconCb3r4I1
   9PTqn+8TbB7G/F/YtErgQTEsL5ODzcpXl1r4DNWWEK6SoaTPVSWers4Y3
   F+t7ToPoqSEAQ8+V1HZQasYPCOzDK1RsGveALTx+ykcM2YuxiaTp7ADvc
   RssmZKo/1BN8wLxqLeL8sKxJ4jC4EYc8ppjF7qkzSTjMMcHwez/pEbrSb
   XWulVat5rDiwxJFFNbcT0y5fNQ7EXIuNQOYT1hL/j5gUSQ4n0YkA7b8eS
   g==;
X-CSE-ConnectionGUID: rMsUKotQSaKH5DoOTxyt6A==
X-CSE-MsgGUID: InPxloshQ32zRXDexkfA5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="86804807"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="86804807"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 03:27:13 -0700
X-CSE-ConnectionGUID: fOfsIfiPSNCoBnhv66K+uw==
X-CSE-MsgGUID: QlshT/uDQ4S23eBRVrLrPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="262655520"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2026 03:27:11 -0700
Date: Sat, 8 Aug 2026 13:27:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: ABI: add sinc4+sinc1+pf1 filter_type
Message-ID: <ancEfS1iqZqfiks8@ashevche-desk.local>
References: <20260807-iio-adc-ti-ads112c14-filter-support-v1-0-4d3ba00caf18@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-filter-support-v1-3-4d3ba00caf18@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-iio-adc-ti-ads112c14-filter-support-v1-3-4d3ba00caf18@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Aug 07, 2026 at 07:19:48PM -0500, David Lechner (TI) wrote:
> Document "sinc4+sinc1+pf1" as a valid value for the filter_type
> attributes (used by the ti-ads112c14 driver).

This patch does much more than that. And I can't easily see what, so many lines
shuffled. Seems like two patches were squashed indeliberately?

...

> +static int ads112c14_set_filter_type(struct iio_dev *indio_dev,
> +				     struct iio_chan_spec const *chan,
> +				     unsigned int val)
> +{
> +	struct ads112c14_data *data = iio_priv(indio_dev);
> +	struct ads112c14_channel_state *channel_state;
> +	int ret;
> +
> +	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +	if (IIO_DEV_ACQUIRE_FAILED(claim))
> +		return -EBUSY;
> +
> +	guard(mutex)(&data->lock);
> +
> +	channel_state = &data->channel_states[chan->scan_index];
> +
> +	ret = ads112c14_get_filter_type_from_state(channel_state);
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * channel_state->filter_osr affects multiple attributes, so don't modify
> +	 * it if the filter type is already set to the requested value.
> +	 */
> +	if (ret == val)
> +		return 0;
> +
> +	/* Otherwise, pick an arbitrary default for each type. */
> +	switch (val) {

I'm wondering if the above can be written as

	case ret:
		/* ...comment... */
		break;

(it is more of the curiosity about C rather than practical suggestion, as I
 understand the cons of this).

> +	case ADS112C14_FILTER_TYPE_SINC4:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_16;
> +		break;
> +	case ADS112C14_FILTER_TYPE_SINC4_SINC1:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_128;
> +		break;
> +	case ADS112C14_FILTER_TYPE_SINC4_SINC1_PF1:
> +		channel_state->filter_osr = ADS112C14_DATA_RATE_CFG_FLTR_OSR_25SPS;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko


