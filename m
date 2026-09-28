Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0493930FF36;
	Mon, 28 Sep 2026 09:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587580; cv=none; b=s1qAwUi1LXQYUJiVkS+EXXTLdKlOM+uxSsdQqW89LtDADB3Zf3bG8it2crwd+JnwaWPO1EVv7G/jXWYYcT6kgPq+kmHZYoc6Ql+ApHuevwRnaZ1UMR9YPjbyXP24EIgrbyRCq7vdPr7Vnkz2X5nMhLjqTp61RwT7KTxM/T6JGkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587580; c=relaxed/simple;
	bh=BqXixSJM2wxVIE8VLmqDLfVq25fTtS+NGlMKrjAztIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMRANMIGGyUDnt/4jKBhQRZqhdxe25FXZs7mTjXVA2qhg3L3/2HT7ppyDr386HEO3EZ1HVAMLIeo45zK71bfH7izixUHoH/WMOabFzagTHRhM3dqpdnxjKx6+QxOhM2yQT4wKaXwj79vYQkaz/jC/Eo4FuUEFWN7x09oo02x7WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OivBuJr6; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OivBuJr6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790587580; x=1822123580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BqXixSJM2wxVIE8VLmqDLfVq25fTtS+NGlMKrjAztIc=;
  b=OivBuJr6DqES6TLRF9+vrxU/i1f6UOAD1vSp2Gp21Dd6BY+FmHSl2s3s
   hXsaUmdtcZAjJpPisqcozFy/Z9mYnOUAANNnnLONXHkeWQzUO6wNt/Kgb
   e8+8y5RZxK/EWHdA2T3kQQVmEimNTx5Y+OYzkfPu5OjEPPk3agJpL1PIQ
   IHP3YD8bhX/xELJagLr82ib4lYFdT1yqjQhoshkbHy+BPI4KuxO2LAtAh
   oeDbLixFuf2dTEw0DB6gauDlk7U0kvXuFJIQ1LNS3FerZsaCAzIePNHG9
   tcKS5yBI7jkvoNKQuL7TWdhCFFNICK3p3lSx2tWWwavFRtFXjVuZTLo1W
   g==;
X-CSE-ConnectionGUID: P/4lCNdgTS2Z5qAFhnAsvA==
X-CSE-MsgGUID: mK2AgWmhQJGzz1LU0u6WEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11918"; a="90325204"
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="90325204"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:26:19 -0700
X-CSE-ConnectionGUID: IH7GfTYzQfqWd07e9NVZ8A==
X-CSE-MsgGUID: +ztMo0lMRG6XmY91CGeTcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,128,1787036400"; 
   d="scan'208";a="304491448"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.42])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 02:26:16 -0700
Date: Mon, 28 Sep 2026 12:26:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 10/10] iio: accel: mma8452: Support interrupt sharing
Message-ID: <aroytGH8u-gGFYvq@ashevche-desk.local>
References: <20260928-mma8452-open-drain-v10-0-b906fb408386@geanix.com>
 <20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260928-mma8452-open-drain-v10-10-b906fb408386@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 28, 2026 at 10:26:26AM +0200, Esben Haabendal wrote:
> Adding support for sharing interrupt line with other device requires the
> interrupt handler to handle runtime PM suspension properly, ignoring the
> irq if the device is suspended (maybe even off). And while at it, we use
> the PM reference to ensure we do not get suspended while processing an irq.
> 
> In order to prevent the chip from raising irq while suspended (that is when
> using fixed regulator, where suspend just means setting the device in
> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> then restores the value again when resuming.
> 
> The scoped_guard in mma8452_runtime_suspend() is changed to a plain
> mutex_lock() instead, both to prevent mixing guards and goto, but also to
> ensure that we stay in STANDBY mode while writing to CTRL_REG4 and all the
> way up to disabling the device as much as possible.
> 
> With that in place, it is safe to add the IRQF_SHARED flag.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.

...

> +	pm_status = pm_runtime_get_if_active(dev);
> +	if (pm_status == 0)
> +		/* device is powered down */
> +		return IRQ_NONE;

> +	if (IS_ENABLED(CONFIG_PM) && pm_status < 0)
> +		/* runtime PM was disabled, possibly suspending */
> +		return IRQ_HANDLED;

This is very interesting part. I bet this will be the first driver using this.
A big question "why?"

> +	/*
> +	 * pm_status is now 1 or -EINVAL (with CONFIG_PM not enabled). If
> +	 * pm_status==1, runtime PM is enabled and device is RPM_ACTIVE. If
> +	 * pm_status==-EINVAL, runtime PM is build-time disabled (i.e. CONFIG_PM
> +	 * not enabled), and we can/must assume device is active.
> +	 */
> +
>  	src = i2c_smbus_read_byte_data(data->client, MMA8452_INT_SRC);
>  	if (src < 0)
> -		return IRQ_NONE;
> +		goto out_runtime_put;
>  
>  	if (!(src & (data->chip_info->enabled_events | MMA8452_INT_DRDY)))
> -		return IRQ_NONE;
> +		goto out_runtime_put;
>  
>  	if (src & MMA8452_INT_DRDY) {
>  		iio_trigger_poll_nested(indio_dev->trig);
> @@ -1120,6 +1139,10 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  		ret = IRQ_HANDLED;
>  	}
>  
> +out_runtime_put:
> +	if (pm_status > 0)
> +		pm_runtime_put_autosuspend(dev);
> +
>  	return ret;
>  }

...

> +	pm_runtime_enable(dev);
> +	pm_runtime_set_autosuspend_delay(dev, MMA8452_AUTO_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);

I don't see the respective _dont_use_autosuspend() call anywhere.

...

I am wondering how many of the above possible scenarios you were able to test.

...

P.S.  I bet you can now make a presentation "PM runtime in Linux and
why it is so hard."

-- 
With Best Regards,
Andy Shevchenko


