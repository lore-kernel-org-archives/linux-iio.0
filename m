Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A6C2329C48;
	Fri, 13 Mar 2026 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773410604; cv=none; b=rPm5BhndfpZF+DHcW6ipzOvQ/GRL2a0UZOhkJOEuqG/q8JxEo32QfcX5uGwXuUMgUfcq5cTjDcr4eBF30sD6Utc+1uj8nHbJxkAWWjTy1AGq1cmVOc+6TOTum9UuW1j2OryTjpjfz5EKLtmNYO/H7tET9Tcpaq7+q1SsGSwZrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773410604; c=relaxed/simple;
	bh=2n3BFb/AaSKZh3Nx+wgcz17IN325ciZ03DJLWlEZ2nM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR3do3iktzulliot0Hhub6jFajERjg9R0QkyddstVuBnPLFZM5c58CK0rklTkC1QqTXb6KxFXx4fosvdXcuK+q1qWPElD5Z6oiyKwuOwC/oUrLr4PsXT3sRhab4NkNwPD3zTxl9CM+DzNfIU1KSUNFA3KqlF2wayUSfalNONXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DntC7D5C; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DntC7D5C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773410603; x=1804946603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2n3BFb/AaSKZh3Nx+wgcz17IN325ciZ03DJLWlEZ2nM=;
  b=DntC7D5Ci1KFZcTdDq5ckCvGuJcerB9tQgEQG3bgYnXOjFmB56y/4yOY
   jdtusmMpabCqEKcGMYkM35Scz0esI7fxcEcuuxUmPaHlsEk/u1XcwPx7U
   uthkce894MfsrSgrvjbHiyjFT+J0L9c+glbQ4LOtxKhlxdulgOpusGzHH
   hwA5niYiAyqYkQic/DNg8M8vKgzCJ4lKEtjjYD8ikMaOHsTY6Z87sVB2G
   y0AIkHa459gsK00e9hAHVVextAesPeanbpAzfyxKMu26YNIg6esfgL4Tu
   tY7mR2PRX1RU/bALELzfWEQn+9Cfne7U3IzL5vgRRt8GzKvDnkkg2CUDc
   A==;
X-CSE-ConnectionGUID: VvvcvFK2SdejhVLFMxpiuw==
X-CSE-MsgGUID: jJSJEFThTaeqLig/+elMOQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="73703245"
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="73703245"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:03:22 -0700
X-CSE-ConnectionGUID: YrGfMucTTHivKnNykmKOcw==
X-CSE-MsgGUID: hVPVQoBpTnyBi3qC4+TsyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,118,1770624000"; 
   d="scan'208";a="225857838"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 07:03:18 -0700
Date: Fri, 13 Mar 2026 16:03:16 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Jorge Marques <jorge.marques@analog.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] iio: accel: adxl372: factor out buffer and
 trigger setup
Message-ID: <abQZJEfdRMzcGZGi@ashevche-desk.local>
References: <20260313115525.85435-1-antoniu.miclaus@analog.com>
 <20260313115525.85435-4-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313115525.85435-4-antoniu.miclaus@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Mar 13, 2026 at 01:54:56PM +0200, Antoniu Miclaus wrote:
> Extract the triggered buffer, trigger allocation, and IRQ request
> logic from adxl372_probe() into a dedicated adxl372_buffer_setup()
> helper. This reduces the probe function complexity and prepares for
> conditionally disabling buffer support on device variants with
> known FIFO issues.
> 
> No functional change intended.

...

> +	ret = devm_iio_trigger_register(dev, st->dready_trig);
> +	if (ret < 0)

Consider dropping ' < 0' parts where they are not required.

> +		return ret;
> +
> +	ret = devm_iio_trigger_register(dev, st->peak_datardy_trig);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->dready_trig);

> +	return devm_request_irq(dev, st->irq,
> +				iio_trigger_generic_data_rdy_poll,
> +				IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> +				indio_dev->name, st->dready_trig);

This left for the context as the last one doesn't have such a check.

-- 
With Best Regards,
Andy Shevchenko


