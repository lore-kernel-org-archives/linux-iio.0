Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1EA3254AE;
	Mon,  4 May 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777883402; cv=none; b=Gm1vng5/TvHpLKgNIsX6ShEhOn9MuEy8RlrQL7dCoUMJGb9b/xr5a4p+FupgrQh3MiaGV2fJ6RSkWAQa8yRXl8oO+kK8d5njCLSGzVax8xkEEyba/3ntwMysWxw/E5rP8NsFef9h/fftm3ktHDIKp0BvmR/DswIYWsroQID7sQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777883402; c=relaxed/simple;
	bh=GWdlIqmvRKpNmbhtAM6K1POoedcZfAlTfAXARnTcaII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqCDTgA9Mm/KdyPRGvtUJ2Q/a5INLQvOJ64m/UQ28v5jNRxrQcjwZRI6QBDXLFFYuHZbWC/hD25btpu1gKko/SHHk1oxKLuGOzZ1pnkYyQs2VNfPHier7Np0uSSBFh9rj8KE08ivrtR/JcwRGGgCZnv8ktaPHMIbm/a3jmngzpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SbQm2XUq; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SbQm2XUq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777883400; x=1809419400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GWdlIqmvRKpNmbhtAM6K1POoedcZfAlTfAXARnTcaII=;
  b=SbQm2XUqQ9dWbFXbKCGt89dAuH1NAHtlKqWHnsBWnD0SHgMfitwHarKb
   ZL2kPOT2xXlnZn9/a8+tm/HzHRQkuwd349UDGs9npaE4s8HjSILdGVUQG
   zhq0mZ6dcOhxWSpwwGnEvYKlPpzKExeeLTV8LITrnPxEC78y70GpaJtDQ
   wXVYYALCGUiSfOEwxHkwKpmZKkmhK5CwnnH4BMW5MH5MtusKsgXoJ1X7r
   zqQzpnxWgomuraz1t5LChHozLGEYOxMMbjEIt3fEI1Eb9em7VgiIm0Qxf
   E04uIown4qxPmSq5v9riqa5ShTwDosPemuQ9Bn6WY5L4MTGTXRD4Mlzoa
   g==;
X-CSE-ConnectionGUID: g8zJG62IQliiKnKIXzkgHw==
X-CSE-MsgGUID: 3JF5tsGBRGG/7F70z4VkFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78837300"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78837300"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:29:59 -0700
X-CSE-ConnectionGUID: rNTbIhIlRQCYt7jmSD++ag==
X-CSE-MsgGUID: V+YZxrvZRvSpn42vdtICLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="232301898"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 01:29:56 -0700
Date: Mon, 4 May 2026 11:29:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v5 10/12] iio: dac: ad5686: add control_sync() for
 single-channel devices
Message-ID: <afhZAl3JLwgzfFsD@ashevche-desk.local>
References: <20260501-ad5686-fixes-v5-0-0b2f45488418@analog.com>
 <20260501-ad5686-fixes-v5-10-0b2f45488418@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260501-ad5686-fixes-v5-10-0b2f45488418@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 10:15:03AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Create ad5310_control_sync() and ad5683_control_sync() functions that
> properly consume the mask definitions with FIELD_PREP(). This allows to
> reuse a function that updates the control register with cached values,
> without relying on confusing logic that depends on st->use_internal_vref,
> which is initialized earlier in ad5686_probe() because it is also
> applicable to the AD5686_REGMAP case, removing the need for the
> has_external_vref. Powerdown masks initialization is simplified as
> *_control_sync() masks outs any unused bits for the single-channel case.
> The change cleans up ad5686_write_dac_powerdown() and ad5686_probe(),
> organizing the code for feature extension, e.g. gain control support for
> single-channel devices.

...

> +	/* Initialize masks to all ones */
> +	st->pwr_down_mask = ~0U;
> +	st->pwr_down_mode = ~0U;

Thanks for this change, but be careful of what is done here. If ever the
pwr_down_* become longer than 32-bit value, this will set a wrong data.
The rule of thumb: If we want to set *all* bits to one, use ~0, the compiler
will take care of the rest.

-- 
With Best Regards,
Andy Shevchenko


