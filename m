Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDFE3A7852;
	Mon,  4 May 2026 11:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777893228; cv=none; b=WyZ3OAvSyI9LW0mOggUBDhY9tnceG5ditYR42IyfeICNdsPs807V4/BdkobE/uLHlaywSlnZ6UjEsGO0H6lqAEyVfswtZeUSHCnd7rKImHxdl3pn683DOL94CvGcyALCBq1d+ynMDhhZZFx1BCYKs5R/D/+U42DQOmEU2usGlr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777893228; c=relaxed/simple;
	bh=hc54X3smZuXCVG2YlZFhfj+XA4dIFyiz5YdzhUpWp7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKiySpIG/g8Z9AvnZ4LhqkB3Pkawllh4cEAKDyPbONLRGmGJ3ApmVAe1MRAZsTGKG2JFZG2rAY0oIv81liVW7yfWrjJ3o2J0NtUH1AlaeHp+KsDGvMQ0YgPchfkQ54SSk6RZag4kVH4aYwo2SRIY40fM22h0+MLM94N3x8TAznw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KEX3YOaZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KEX3YOaZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777893226; x=1809429226;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hc54X3smZuXCVG2YlZFhfj+XA4dIFyiz5YdzhUpWp7Q=;
  b=KEX3YOaZqd/IMCCKp9RDK61D1wkwWEvWRpPxq/Mx7g6RtwADTVWDO2zC
   OSwh4jgCoqWhYPkilHihTA6VqnNUMP+xpVUVz0hzV7rjYoEG7haPxmgam
   Or2gTJQZ3J5y0JKTDtx9TGXl6yF9/zA2AD0w/A12fbwAAro9c2BmE8FIN
   P4KygOZRHlQEd9oaBelKYd6JNE6MTRfhVeCaykz49M3SO1+Rc9KhZaflr
   pOR/KULk7bciru3WHGWCYxZKr65VQLMkTCr3ksNX7nKlS2bnD6ti058FE
   xohb0XqKVAwgaXICo8nB7ULBay+j3azrOTnLZ5bHHhliVmluPrsfGk5PG
   g==;
X-CSE-ConnectionGUID: lQcx6n5rREy2fziowZcM0A==
X-CSE-MsgGUID: PKxLIvxITrS+Wl0ZwScCzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="90124436"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="90124436"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:13:45 -0700
X-CSE-ConnectionGUID: sbnAaSoLT4WwtJiWS6cFpw==
X-CSE-MsgGUID: oVal1XmVQT65k3kIpoMXVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="265836347"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 04:13:44 -0700
Date: Mon, 4 May 2026 14:13:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/17] iio: magnetometer: ak8975: switch to using
 managed resources
Message-ID: <afh_ZUFWc4bRT4zs@ashevche-desk.local>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
 <20260504-magnetometer-fixes-v4-13-a291c2a7c71a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504-magnetometer-fixes-v4-13-a291c2a7c71a@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 11:48:25AM +0200, Joshua Crofts via B4 Relay wrote:

> Switch the driver to use managed resources (devm_*) which simplifier
> error handling and allows removing ak8975_remove() method from
> the driver.
> 
> Note, on error path we now also set mode to POWER_DOWN state which is
> fine. Even if the device is in that mode, there is no problem to set
> that mode again, it should be no-op.

...

> +static void devm_ak8975_power_off(void *data)
> +{
> +	struct ak8975_data *ak = data;
> +	struct device *dev = &ak->client->dev;
> +
> +	/* Only power down if currently active */
> +	if (!pm_runtime_status_suspended(dev)) {

	if (pm_runtime_status_suspended(dev))
		return;

?

> +		/*
> +		 * The device may not be runtime suspended when the driver is
> +		 * removed, so we soft-stop the chip before hard-stopping the
> +		 * regulators.
> +		 */
> +		ak8975_set_mode(data, POWER_DOWN);
> +		ak8975_power_off(data);
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


