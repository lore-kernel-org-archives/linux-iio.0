Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33C92EE5F5;
	Fri, 23 Jan 2026 14:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769179744; cv=none; b=oDEEuLNoJPnDyNLgLOVdYN0G+CSkrf/UiArBpS8IAd2BNSri9gY+oFBIndrOz3ardT639mTPqQskZtKvp2QzJPtWl76WiqNAgUv61kmoUTH06QyVo6lLlubRlu8oV0c1pVwNR+vKpmmk41UoZRvQuNRs7kq9yQA5irHEGIeOTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769179744; c=relaxed/simple;
	bh=8s68nxykpQZwaLDXgQ7HCKrI+rWybcyYPE4d28q06ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JFHfGdHIRqsMkphfOJudFC4rqxn0UvcKbvcTCnV9Hl23Gr2NWkxINtnV+eFHwLuoLnRJGSBM3DAgPsXR2qmnnQFrdRt8CuMxSZeGQJ3CO/Z08WhPEwFg4uFSfFqkK7O5H8aLyVXfjTy2W49Po31DKGvegnngtSHMsYWmQqzh9yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dEuj2pZL; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dEuj2pZL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769179742; x=1800715742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8s68nxykpQZwaLDXgQ7HCKrI+rWybcyYPE4d28q06ns=;
  b=dEuj2pZLCwjswjjMpz2FHqXrosSFOQiNyZVC0pMzL0HZH9PjnfM7N5a0
   fv7hik868w9IlWUHiNP606v3p4iQQgjI+DzXhfBYzHtXHVedI6+0ZA7IP
   mB/dDzZKRYT2JZwm/+phVq/RpkMX2bJH6fNMHBmc97EQPbqbQxQModcZ7
   nfO5JvpAtvdDKS7VZY9nsYaWfAyDuaVprRevIbdulk9UEwTovgSrxEQBf
   mQKhcguj/1QCiadhXZySkPjJJViEthvV4BQic5OSnuGFLdXXqpW1VPOjp
   fCi6uEML/rjnPRlpueo8a64s/TYYGwfO1LXFTpS9K6fgTGUaQtjcVd+Fd
   A==;
X-CSE-ConnectionGUID: DsAMKaedRaGKAATAdLsX8Q==
X-CSE-MsgGUID: C7+60eZSRH61OXz0foROog==
X-IronPort-AV: E=McAfee;i="6800,10657,11680"; a="87850961"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="87850961"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:49:02 -0800
X-CSE-ConnectionGUID: MPPVZafcS5eEYG/7JSHgoQ==
X-CSE-MsgGUID: L7usaN1gQDC6fNFgqjSHkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="211544589"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 06:48:58 -0800
Date: Fri, 23 Jan 2026 16:48:54 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260123113708.416727-19-bigeasy@linutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 23, 2026 at 12:37:04PM +0100, Sebastian Andrzej Siewior wrote:
> Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> the secondary (threaded) handler is done. If only a primary handler is
> used then the flag makes no sense because the interrupt can not fire
> (again) while its handler is running.
> The flag also disallows force-threading of the primary handler and the
> irq-core will warn about this.
> 
> The intention here was probably not allowing forced-threading for
> handlers such as iio_trigger_generic_data_rdy_poll() will intends to
> invoke hard-interrupt handlers.
> 
> Replace IRQF_ONESHOT with IRQF_NO_THREAD.

Code wise LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

There is a few nit-picks regarding style below.

...

> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> Cc: Puranjay Mohan <puranjay@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: David Lechner <dlechner@baylibre.com>
> Cc: "Nuno Sá" <nuno.sa@analog.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> Cc: Kent Gustavsson <kent@minoris.se>
> Cc: Gustavo Silva <gustavograzs@gmail.com>
> Cc: Nishant Malpani <nish.malpani25@gmail.com>
> Cc: linux-iio@vger.kernel.org

Move these...

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

...to be here. This will drastically reduce the unneeded noise in the commit
message. The email will have (if using git format-patch and git send-email)
them.

...

> --- a/drivers/iio/accel/adxl355_core.c
> +++ b/drivers/iio/accel/adxl355_core.c
> @@ -770,7 +770,8 @@ static int adxl355_probe_trigger(struct iio_dev *indio_dev, int irq)
>  
>  	ret = devm_request_irq(data->dev, irq,
>  			       &iio_trigger_generic_data_rdy_poll,
> -			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> +			       IRQF_NO_THREAD,
> +			       "adxl355_irq", data->dready_trig);

Leave it on a single line. It's only 81 characters and it's fine to be like
this.

>  	if (ret)
>  		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
>  				     irq);

...

> +++ b/drivers/iio/accel/adxl372.c

> +		ret = devm_request_irq(dev, st->irq,
> +				       iio_trigger_generic_data_rdy_poll,
> +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +				       indio_dev->name, st->dready_trig);
>  		if (ret < 0)
>  			return ret;

Interestingly that this driver ignores the flags from firmware... Seems to me
like a bug (not in your patch, obviously). Ditto for other drivers doing similar
things.

...

> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -306,9 +306,9 @@ static int dlh_probe(struct i2c_client *client)
>  	indio_dev->num_channels = ARRAY_SIZE(dlh_channels);
>  
>  	if (client->irq > 0) {
> -		ret = devm_request_threaded_irq(&client->dev, client->irq,
> -			dlh_interrupt, NULL,
> -			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       dlh_interrupt,

Joined to the previous line it gives exactly 80 characters, which is allowed.

> +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
>  			st->info->name, indio_dev);

Forgot to indent.

...

> +		ret = devm_request_irq(&client->dev, client->irq,
> +				       iio_trigger_generic_data_rdy_poll,
> +				       IRQF_NO_THREAD, "tmp006_irq",
> +				       data->drdy_trig);
>  		if (ret < 0)
>  			return ret;

Jonathan et al., this seems to me like a duplication from one to another
driver. Can't we do like a helper for it, so we don't change it each time
the IRQ core or other things got changed?

-- 
With Best Regards,
Andy Shevchenko


