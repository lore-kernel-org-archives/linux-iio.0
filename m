Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F3931F9B3
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 19:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777492774; cv=none; b=OS3n4UhbYUFC1Lj6XbEX3r+CXRERgv0i5TCe/vZ9HoOdmb8QLELWl8dgrGPV7QwEV7rtO1Dj+edBXa2MZSF5LK7rSDt9t/Y4WcIhgZWINW2xxDVxXDGrEXhdngO6t1gwCdgmsNkFxOC/FjUbtYGxJ0U4OQ+t+Nr/wnBB38tb2SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777492774; c=relaxed/simple;
	bh=iigyI2HcYwNuD3Ws0jcmoqEAo5/u50TPnbLQrotVHLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZotTAjcHfwr/x8UySNRdAubZwaasyCJxp/m5j5QSms+JpXMeK/79mBG4RYvZTSpacX83Vzb9mEzLdcjLGVmecGPit6g1cUwZsEEeNUaCk37lnouWjGmyH6bTC8hgAoCTla/wtRLG5e95R90NwQ8SIKBN3Zy/02kvkMkXRfjom4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1MIoNPr; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1MIoNPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777492774; x=1809028774;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iigyI2HcYwNuD3Ws0jcmoqEAo5/u50TPnbLQrotVHLw=;
  b=C1MIoNPrMDKnBV082r9wx/5q0guVh+AICEZtY9SuPwVlYkTtPknYGH/M
   6mJg58F3sugkuImzwU2QLygAAJiJb0KaYLW0qR5vlNkqGtUO0Doyr5Cv/
   bheF7yof5JalMoSQFHU+nlVatsk4zGj8ytXX5bt67yVaqo15bRLGtFmNz
   ntRtD5uY31e4SEVOje20Sjyqf7Rp4is/QQ1Nqz59gyN5CYrBA9kH0dheW
   lpjM5Fl87P/H8FvgBNdjCFB4yzLq2loKZWDyBWsZq/DwxXyPrlILI44bc
   SzyPhYtPzY70RSEOKWViiSnGKXQ0uURe57HtIvZU7dBXRwrJUyPbPrQx8
   w==;
X-CSE-ConnectionGUID: yf5pmG5ZSQOp66DdmHv52w==
X-CSE-MsgGUID: jmVZ+723T0K/ZZ/eLw8pZw==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78622667"
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="78622667"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:59:33 -0700
X-CSE-ConnectionGUID: Ag6fvBqXQtSz97TOnbo19g==
X-CSE-MsgGUID: hzQ7Dr7MTP2nRIfWcgoW8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,206,1770624000"; 
   d="scan'208";a="230010555"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2026 12:59:30 -0700
Date: Wed, 29 Apr 2026 22:59:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Dias <guilhermeabreu200105@usp.br>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, nish.malpani25@gmail.com,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org,
	=?iso-8859-1?Q?Jo=E3o?= Paulo Menezes Linaris <jplinaris@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: gyro: adxrs290: Use guard(mutex) in lieu of
 manual lock+unlock
Message-ID: <afJjH1Mn_ZqKWN7L@ashevche-desk.local>
References: <20260429195214.22374-1-guilhermeabreu200105@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260429195214.22374-1-guilhermeabreu200105@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 29, 2026 at 04:51:05PM -0300, Guilherme Dias wrote:
> Use guard(mutex) to automatically release the lock on scope exit,
> simplifying the error handling path and removing the need for
> explicit unlock and goto-based cleanup.

...

> +	do {
> +		guard(mutex)(&st->lock);
>  
> -	/* exercise a bulk data capture starting from reg DATAX0... */
> -	ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> -				  sizeof(st->buffer.channels));
> -	if (ret < 0)
> -		goto out_unlock_notify;
> +		/* exercise a bulk data capture starting from reg DATAX0... */
> +		ret = spi_write_then_read(st->spi, &tx, sizeof(tx), st->buffer.channels,
> +						sizeof(st->buffer.channels));

Fix the indentation. The (starting) column for the parameters should be
the same. Also the first one goes over 80 limit, wrap that and it's actually
gets better as the split will become more logical.

		ret = spi_write_then_read(st->spi, &tx, sizeof(tx),
					  st->buffer.channels,
					  sizeof(st->buffer.channels));

> +		if (ret < 0)
> +			break;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> -					   pf->timestamp);
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> +						pf->timestamp);
> +	} while (0);

-- 
With Best Regards,
Andy Shevchenko


