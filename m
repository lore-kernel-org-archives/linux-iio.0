Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1888B3246EF;
	Wed, 22 Apr 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776848335; cv=none; b=bEn6Mc/yonuYZinH4zvQQr5l9PQ2bsKoRL1zRqV8epo4OXeC6A7RhakWwJOcJuXKf7AIVJcrAiwwfEfIntyuVr0KSK3vG9bHxFwS94OlO70axnhBO+g/VcJkPaTWTSZtyvylLEaS3rLPl9eqf8kDLs2s5fzZKnASDBHoBAw+JLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776848335; c=relaxed/simple;
	bh=p2BT164cxnMMi9xbLOyc046XkleqcwxOJ7E0pmaNVgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QzJx17HJET0G0bTu4JCjoZQ3BhMf5Xa/M8enw1H98EtQmBN+61VugkZaTon7Izi94qIKQzirDeICAPTa4OIiUq+jsMrBt3jtgg18Q+HeVyuyXEpqY/IvJWkQ2tEJ2K4MSLNpXAfFucQYdAXHa2Xh/vhwANhQSuGpJ/w2BxifhPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=etR2jp9Y; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="etR2jp9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776848335; x=1808384335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p2BT164cxnMMi9xbLOyc046XkleqcwxOJ7E0pmaNVgE=;
  b=etR2jp9YTEae/mRTVO19EL4JIPXuCBOdUcOYinibvw5n/CRHckWzlW27
   Gl1jETNzQTG7aNoT8PY38Gl9K2Pl+NHqFo+mh4KrlcJDma38zxrGKSNE/
   rT7zFk0uWv0rUAjO+UpF0vI70pB8knULM4Tdcs7QNZMKEIRUS8j+utEcj
   hPXz3/BmeRq5dWXyTLd+NRRWRUIqcGGwtW/vOv/skbTdx1s1OOOFrFuET
   lazxxMYFsyVDajriVu+hzHacR31mERAawxExaHbYxZslI0ihC94NmS6Yq
   /Y6Ymi9d6UlRmgu2YgmCLVOQ3GDe+GM7EiEfFpDkj6r91llZTDPnwyZYN
   g==;
X-CSE-ConnectionGUID: 7xzh0SOVQaSlaPlDr4vJdg==
X-CSE-MsgGUID: RoJEyRyMQiOBtTWa824/4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77500377"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77500377"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:58:54 -0700
X-CSE-ConnectionGUID: UziRFz+ASrO1SuvT1S4Pmw==
X-CSE-MsgGUID: +X/PCSfOQ1Gqv6hk9claug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="262687169"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:58:52 -0700
Date: Wed, 22 Apr 2026 11:58:49 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <aeiNyWX6m6wiYWM8@ashevche-desk.local>
References: <20260421100722.1296-1-joshua.crofts1@gmail.com>
 <20260421100722.1296-5-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421100722.1296-5-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 10:07:22AM +0000, Joshua Crofts wrote:
> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour.

...

>  static int wait_conversion_complete_gpio(struct ak8975_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
>  	int ret;
> +	int val;
>  
>  	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		if (gpiod_get_value(data->eoc_gpiod))
> -			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> -	}
> -	if (!timeout_ms) {
> +	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val,
> +				 val != 0,
> +				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> +				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> +	if (ret) {
>  		dev_err(&client->dev, "Conversion timeout happened\n");
>  		return -EINVAL;

Side note: I would drop this message and return the correct error code
(in a separate patch):
	if (ret)
		return ret;

>  	}

...

>  static int wait_conversion_complete_polled(struct ak8975_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u8 read_status;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
>  	int ret;
> +	int val;
>  
>  	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		ret = i2c_smbus_read_byte_data(client,
> -					       data->def->ctrl_regs[ST1]);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "Error in reading ST1\n");
> -			return ret;
> -		}
> -		read_status = ret;
> -		if (read_status)
> -			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> +	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> +				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> +				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> +				true,
> +				client, data->def->ctrl_regs[ST1]);
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading ST1\n");
> +		return val;
>  	}
> -	if (!timeout_ms) {

> +

This blank line is not needed as the check coupled with the call
(yes, I understand the need to check the val first).

> +	if (ret == -ETIMEDOUT) {
>  		dev_err(&client->dev, "Conversion timeout happened\n");
>  		return -EINVAL;
>  	}

This is ugly error code shadowing. See above. Preparatory patch, please,
to avoid need of this piece of code altogether.

> -	return read_status;
> +	return val;
>  }
> 

-- 
With Best Regards,
Andy Shevchenko


