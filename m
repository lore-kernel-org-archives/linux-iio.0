Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A7364925;
	Wed, 24 Jun 2026 11:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301083; cv=none; b=ern0Ohy1fSX9Z4NSww8d2O6QB96n5ky99trjcp08rJZKfaNjjUFuyntNYqOzZy9OD/xn7A4MdaH4C1H3cYsDfskXn12tjOMG3DxpnQv8+Cz0XrE/eqI47Co/b6MeiV9fHCV9bQ8k5A8y/XMrtkxA0UJQ+sfZAnDzYu9F6bhpqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301083; c=relaxed/simple;
	bh=3GSHxeyT9112m6bK0WlZR3PJhHo19/qNalU73sKaeaU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD4aYwC3DxUCA2OLiYOQHGvp4vUFwgIwaRhCSVMj65EMjnPtaNC9Xo7kOjE+VXU4i83bpN+9eeLbCiDWKZFBkblME51jdwaMlfdTLp1Jd2JfPLemSy2dRMhXYYpZDo4+dEqxQRH1ZgAZaNefcoYCzWeJUzhzylJtdpPbnNzMXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CExy3swe; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CExy3swe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782301082; x=1813837082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3GSHxeyT9112m6bK0WlZR3PJhHo19/qNalU73sKaeaU=;
  b=CExy3swexoGZozC6srRLbYuXqfVy5nmTAO1xkYw+P6z6we/M3FRJauvN
   Oyyemt114pAeOcBnK2JecZ1VbEgqymFFQ9Vo5Rlk219KZGpOoAGfbnDuo
   CowkqxgHPA/hJIz+E0X2tbD9ISB+Xc3jBXwtoX6YUvD+WVnt+/ALKIXoN
   tcN4y3fiXz54SbsGXnbbcoN8GbcqJjyQsEq0UJ118JCrXy3/ATly3pJHe
   QzKzE1pavVIEe+Ju4Zvj0TQL+5mU+lyS+/SszUCkc6VS/pCpP90hLVSJf
   QlKNb9JWnjkBzP0nsI8hUplv8Pb6qRWp3ZLeR4Qp5IyXR9a7TPLxG8tgq
   Q==;
X-CSE-ConnectionGUID: B3nXrlqmTrK3vABsxl4LoQ==
X-CSE-MsgGUID: Cj4SdtZGTqKQl/VG7F224A==
X-IronPort-AV: E=McAfee;i="6800,10657,11826"; a="82173079"
X-IronPort-AV: E=Sophos;i="6.24,222,1774335600"; 
   d="scan'208";a="82173079"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:38:00 -0700
X-CSE-ConnectionGUID: F7kbfVG+Rje15kanj0Bhxw==
X-CSE-MsgGUID: T9ycpteGSpGWUGGDxPY2pA==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.156])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 04:37:58 -0700
Date: Wed, 24 Jun 2026 14:37:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, tobias.sperling@softing.com
Subject: Re: [PATCH v3] iio: ti-ads7138: Disable STATS_EN bit while reading
 conversion results
Message-ID: <ajvBlBValiK4VY2p@ashevche-desk.local>
References: <20260624080131.3669357-1-paul.geurts@prodrive-technologies.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624080131.3669357-1-paul.geurts@prodrive-technologies.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 24, 2026 at 10:01:31AM +0200, Paul Geurts wrote:
> There is a data race in reading the STATS registers, resulting in wrong
> data being read. When the data in the RECENT register switches between
> 0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
> happens when the value is updated inbetween reading MSB and LSB.
> 
> Disable the update of the channel stats before reading the values, for
> registers MIN, MAX and RECENT.

It seems the commit message still needs some elaboration as you explained in
the previous version thread.

> Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
> Fixes: 93a39542d3c3 ("iio: adc: Add driver for ADS7128 / ADS7138")

...

>  	case IIO_CHAN_INFO_RAW:
> +		/* Disable statistics update so the value is not updated mid read */
> +		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					    ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  		ret = ads7138_i2c_read_block(data->client,
>  					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
>  					     values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
> +		/* Enable statistics update after read */
> +		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					  ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_PEAK:
> +		/* Disable statistics update so the value is not updated mid read */
> +		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					    ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  		ret = ads7138_i2c_read_block(data->client,
>  					     ADS7138_REG_MAX_LSB_CH(chan->channel),
>  					     values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
> +		/* Enable statistics update after read */
> +		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					  ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_TROUGH:
> +		/* Disable statistics update so the value is not updated mid read */
> +		ret = ads7138_i2c_clear_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					    ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  		ret = ads7138_i2c_read_block(data->client,
>  					     ADS7138_REG_MIN_LSB_CH(chan->channel),
>  					     values, ARRAY_SIZE(values));
>  		if (ret)
>  			return ret;
> +		/* Enable statistics update after read */
> +		ret = ads7138_i2c_set_bit(data->client, ADS7138_REG_GENERAL_CFG,
> +					  ADS7138_GENERAL_CFG_STATS_EN);
> +		if (ret)
> +			return ret;
>  
>  		*val = get_unaligned_le16(values);
>  		return IIO_VAL_INT;

This adds a lot of duplication? Can we have a wrapper on top of
_i2c_read_block()?

_i2c_read_statistics(client, reg, values, values_len)

-- 
With Best Regards,
Andy Shevchenko


