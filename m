Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1EC401A26;
	Wed,  6 May 2026 10:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778061653; cv=none; b=fwdf+J29LxAYsEpOSmGnq/uv28LzpPQ1GZzDBkNokwiI+ivIwgpOl/DERMEMlv/NHP1OUIud44G1lWDc4f20noLzSV9JaVQm1yHu1DhI22icM+UOEg6sBhIRjRV8G3KV2zFwRz/J6njD8WmGNQDiyNcRLcoPYcjrj5VOmUsTNy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778061653; c=relaxed/simple;
	bh=1W/BA8E7Tc+s3/QPYj/D/YebMJWl5cmUW5+ER9qqBd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=USIHsFJo6isfeLN5xvgaWGXfgfBDY10SL7dObW0VaB3dnKaYLcs9JCBjS4/8dP7vQFsoZOAw/D5C38vpZc92kA9I38UOSZ6Vv1Auuuzb+yFblulv9v2VHeCVIIhtREuPPxvGFQg3c7crF7XZ8yeAoL0Noq1hSrjt4N8kds5LFwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kv90xUSs; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kv90xUSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778061646; x=1809597646;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1W/BA8E7Tc+s3/QPYj/D/YebMJWl5cmUW5+ER9qqBd4=;
  b=kv90xUSsBa6yio5cQBwQjQ3tUo/pjKPR0MVMJo5hO14ij0TpV0cpfdWj
   bkK4vgHhUqjVx/GFEEDT6K8JsLu1r2VZTwJBzM/NTNk9eSRcyLjjX5u3v
   wWsZ9JIclb1jRA+MvWuC5RCdKtK7PY/xpqzIG3JqIdG5/5Kyzr0d1L3ww
   YsknkriOS/oBLsCtnsypLksVKdWzX4+PO5e/OTnpRZqPpHmr1kMcfMi+S
   SX3HM5DCrfPWfOIKUsMhOT+LVKSolFUm10v1voha1+PyvjLoYy++QkeXV
   cK+dDusIFoJrHIo7JH4ndVtkC7R+EV6lrLThEGIrDo6Ez2/8VQ9zZf8Us
   Q==;
X-CSE-ConnectionGUID: eGytmWmySUa1DARLRJha9A==
X-CSE-MsgGUID: gBAWl/W0QgaccsBEUtPV7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82593700"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82593700"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:00:43 -0700
X-CSE-ConnectionGUID: RJp/NdmDQ4WZ4I+tOpjWiA==
X-CSE-MsgGUID: Hf0YuDApRbSad0nSyYcATQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="233440569"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 03:00:40 -0700
Date: Wed, 6 May 2026 13:00:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 1/3] iio: light: tcs3472: use devm for resource management
Message-ID: <afsRRf7-IA3X4YOo@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <20260506094311.222500-2-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506094311.222500-2-aldocontelk@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 11:43:09AM +0200, Aldo Conte wrote:

> Found by code inspection.

It's unusual to start a commit message with this...
Move it to the end of the commit message (before tag block).

> Convert the driver to use device-managed resource allocation:
> - Add tcs3472_powerdown_action() and register it with
>   devm_add_action_or_reset() to ensure the device is powered down on
>   cleanup. Before this patch, the chip remained powered if probe
>   failed after enabling it.
> - Replace iio_triggered_buffer_setup() with
>   devm_iio_triggered_buffer_setup().
> - Replace request_threaded_irq() with devm_request_threaded_irq().
> - Replace iio_device_register() with devm_iio_device_register().
> - Remove tcs3472_remove() as all cleanup is now handled by devm.

> Compiled with `make drivers/iio/light/tcs3472.o W=1`.

Unneeded detail, move to the comments / cover letter.

> Tested on Raspberry Pi 3B with TCS3472 (Adafruit breakout):
> Verified that RGBC channel reads return valid data and that ENABLE
> register is cleared to 0x00 on device removal.

Ditto.

> Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
> ---

FYI: Here is the location for the comments / changelog / et cetera.

>  drivers/iio/light/tcs3472.c | 85 ++++++++++++++++---------------------

...

> +static int tcs3472_powerdown(struct tcs3472_data *data)
> +{
> +	int ret;
> +	u8 enable_mask = TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON;
> +
> +	mutex_lock(&data->lock);
> +
> +	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE,
> +					data->enable & ~enable_mask);
> +	if (!ret)
> +		data->enable &= ~enable_mask;

This patter is discouraged.

> +	mutex_unlock(&data->lock);
> +
> +	return ret;
> +}

Make the guard()() patch to be first in the series. With that being done and
taking the above this becomes as simple as

static int tcs3472_powerdown(struct tcs3472_data *data)
{
	u8 value = data->enable & ~(TCS3472_ENABLE_AEN | TCS3472_ENABLE_PON);
	int ret;

	guard(mutex)(&data->lock);

	ret = i2c_smbus_write_byte_data(data->client, TCS3472_ENABLE, value);
	if (ret)
		return ret;

	data->enable = value;
	return 0;
}

...

> +	ret = devm_add_action_or_reset(&client->dev,

With temporary

	struct device *dev = &cliend->dev;

at the top of the function this and others become easier to read.

> +				       tcs3472_powerdown_action, data);
> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


