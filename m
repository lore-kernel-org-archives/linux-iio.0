Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA3013D3488;
	Thu,  5 Feb 2026 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309270; cv=none; b=SW7JQUdBtjKtMb2vdoeszq73t4Ru2okyLT8wMCCx4Te3k1DCE6xb6wo7hzyd3B1ONBxef3xmk5g4P3cBiXAMJD/BBQtlmxJqvjYstSkj8P0FQh1oWnB05u4FP1jhlAAXvVN5thmMee39JdhV28GzLmliBiP62ZQhG229D6IXj4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309270; c=relaxed/simple;
	bh=LWnnECeP3tvpcBTKAiohhDhDfchHPoYxdJgj1zdGgXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HleqO6+9fMEXWofk/y/Q9WMKhbw203EWzc840mnpQS2wVdmG1pmVldOCvxBKOsD+ivseMIku7fFw+3S1eaiGURHoMtpglLjPbJOWoqVlUIxWLeSr8278OdnN7EUtKA1Hs9zqo3m3hf17uO63oGlnbgCfoDTXxAmq6lHD/7DV9co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GP01h2Gx; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GP01h2Gx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770309270; x=1801845270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LWnnECeP3tvpcBTKAiohhDhDfchHPoYxdJgj1zdGgXE=;
  b=GP01h2Gx/OAqrnANfl55auYOeFpWO7W6rgHzUiQv04hsB0TbH1FVB5zm
   hgn9ol0CLOWXX2qzgqStRbhDT3fbenHQ3Zj3x34J/v51PcNhdZojrG4iv
   mUJSaerdLo7ATtbXGDN4n/TO/4WHcKYOFKU7AjRnbqZ+KBmkayUFqqI/f
   tXT80IPhyduNDY8EjhSA3H1KDv4/d7H2vcX86GGPutyXC2D+4mX7+7O7G
   NknDmfh8yfe0xW5WvMX8N+taQVa/Gxp0COpj/W/dlemhxfB+ypgmKZHfV
   wA/Q+rDJAqus66kgjCERvTMP6KVTG/BVNmXAf/XwEq+Prigy0LNH+GrF2
   A==;
X-CSE-ConnectionGUID: Zmy0fLBrQIy7aaTZxA5UZA==
X-CSE-MsgGUID: gNG5NfXoTPO42/Hd7HTu9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11692"; a="82145336"
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="82145336"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:34:29 -0800
X-CSE-ConnectionGUID: ZIK8daLHSjO03UVWTgmsTw==
X-CSE-MsgGUID: Sq0l2t3gQcaNhxloE36JXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,274,1763452800"; 
   d="scan'208";a="209863252"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.142])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2026 08:34:27 -0800
Date: Thu, 5 Feb 2026 18:34:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 5/5] iio: adc: ad9467: check for backend capabilities
Message-ID: <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Feb 05, 2026 at 12:24:11PM +0000, Tomas Melin wrote:
> Add capability checks for operation with backends that do not necessarily
> support full set of features, but are otherwise compatible with the device.
> This ensures a fully functional device, but with limited capabilities.

...

> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
> +						      indio_dev);

With

	struct device *dev = &spi->dev;

at the top, this one becomes exactly a 80 character line.
And in general it will help cleaning up the rest afterwards.

> +		if (ret)
> +			return ret;
> +	}

-- 
With Best Regards,
Andy Shevchenko


