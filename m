Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C048489F;
	Wed, 30 Sep 2026 10:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790764523; cv=none; b=IoIwnNta+m/qY1kxqtXYkAm/H1Qk8pZzl2R92l+y3wuRe2Ced6BUWqSywytQG1sB80MfH7FnUPBsk/GCmrRlFsOyScAwU8SVXY6mrFHGQHIMkYhjTejEp7dcuWnwrXV1CrPL/LXhBGmxiSi8vzc+m3xmSIwv4InnZruIgECtfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790764523; c=relaxed/simple;
	bh=hv0C92Rh1ksdG89sw30/t5qoFJ2gTwBipcVvty9eSFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DuJnd75tboJODA1/E220mMfcNVF0DvJDcW/Lotu3l76UcBfzdNQhG8fbwqFTYLhGkgffS95NIB9Sf6NCNlgHX2H/JgkCplia717qsMbiK9Zg6tD+dFmgfSeT6DNby/dTbgWdwjsSCsfwbsx6Ru554SY3xWTtiY3AOaa9xGGn5mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S9PXmf+v; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S9PXmf+v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790764519; x=1822300519;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hv0C92Rh1ksdG89sw30/t5qoFJ2gTwBipcVvty9eSFg=;
  b=S9PXmf+vp9G/hXEjeqgfvgU0hZMP4m178kJHAjDGPJ/djKrdisHPINjV
   bVMKqU1lXFi9nTYL9wgb5/DeFUpPK68bKWrvxVhCSrvB0YqlKP0WK/put
   6M9O+etdrJsqkAXVrsYoKFMXsXvMS5ZKyqtaJwGVlttQbOe5hrOf11r5c
   PHkIBAmMe6Thc+3rDTRSOI+5p0t6KlIY+8DthVNmCzVTQEx+knORmSa2+
   dOWeXzpIatm5y+xHxz7c4XMVZJ7Wc4JGOL/iaZWY5s6uEB5ig5U1yKtRt
   U2hxpEapGmZphbN8f/oP853FlsC4RJV3VbVCGGNTAOl5YttpPWZNzAXkB
   Q==;
X-CSE-ConnectionGUID: praScGxoSTiX7jd4/S1ecQ==
X-CSE-MsgGUID: 84HyqWL6SVK9JNoQSuXbDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91517107"
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="91517107"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:35:18 -0700
X-CSE-ConnectionGUID: zNPcY9sJTDSddwirHiwkPA==
X-CSE-MsgGUID: yapkq3TbRJ+ofQAaztaWfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,132,1787036400"; 
   d="scan'208";a="275697169"
Received: from spandruv-desk1.amr.corp.intel.com (HELO localhost) ([10.245.245.137])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2026 03:35:14 -0700
Date: Wed, 30 Sep 2026 13:35:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v10 1/4] iio: pressure: dps310: read buffered samples
 from the hardware FIFO
Message-ID: <arzl4DK8vhP0g8Hg@ashevche-desk.local>
References: <20260930100158.957977-1-zoone.rupert@gmail.com>
 <20260930100158.957977-2-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930100158.957977-2-zoone.rupert@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Sep 30, 2026 at 01:01:55PM +0300, Rupesh Majhi wrote:
> DPS310 has a 32-entry FIFO shared by both measurements. Drain it from a
> work item and push what it held, so buffered capture needs no trigger.
> Nothing in tree wires the interrupt pin, so the work rearms itself at
> half the FIFO fill time.
> 
> Each entry carries one measurement, so a pressure entry is compensated
> with the temperature ahead of it. Pressure read before a session's first
> temperature is held until one arrives rather than dropped, so the first
> push can wait a temperature period.
> 
> FIFO entries are not timestamped, so postenable refuses the timestamp
> channel unless a trigger is attached.
> 
> Tested on a DPS310 on a BeagleBone Black.

...

> +/* The drain rearms itself, so stop it even if the buffer never disabled */
> +static void dps310_cancel_fifo_work(void *action_data)
> +{
> +	struct dps310_data *data = action_data;
> +
> +	cancel_delayed_work_sync(&data->fifo_work);
> +}

...

>  	mutex_init(&data->lock);

This has to be devm_mutex_init().

...

> +	INIT_DELAYED_WORK(&data->fifo_work, dps310_fifo_work);

Can't we use devm-helpers.h for this?

...

> +	/*
> +	 * Both modes advertised: the core picks TRIGGERED with a trigger
> +	 * attached and falls back to SOFTWARE, which the FIFO path uses.
> +	 */
> +	iio->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED |
> +		     INDIO_BUFFER_SOFTWARE;

I would rearrange this as

	iio->modes = INDIO_BUFFER_TRIGGERED | INDIO_BUFFER_SOFTWARE |
		     INDIO_DIRECT_MODE;

...

>  	/*
> -	 * The device measures continuously in background mode, so a capture is
> -	 * just a read of the latest results. The trigger is not aligned with
> -	 * the measurements, so the timestamp is taken in the handler.
> +	 * The device measures continuously in background mode, so a triggered
> +	 * capture is just a read of the latest results. The setup ops run the
> +	 * FIFO drain when no trigger is attached. The trigger is not aligned
> +	 * with the measurements, so the timestamp is taken in the handler.
>  	 */
>  	rc = devm_iio_triggered_buffer_setup(dev, iio, NULL,
> -					     dps310_trigger_handler, NULL);
> +					     dps310_trigger_handler,
> +					     &dps310_buffer_setup_ops);
> +	if (rc)
> +		return rc;

> +	rc = devm_add_action_or_reset(dev, dps310_cancel_fifo_work, data);
>  	if (rc)
>  		return rc;

Are you sure it's in the correct location?

-- 
With Best Regards,
Andy Shevchenko


