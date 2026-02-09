Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0572222B2;
	Mon,  9 Feb 2026 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770626469; cv=none; b=MSx/Sv3pPvlgzgLfhQYl/BHCXq6o92pNgUys5HSyLT8QJSo0hKUMm6zFpGMrpJgpeoYDv2D/6y8lgZcWANRT/AflaM2NMWe4b+QLgJY2bxYxc5ppmGiNbsf3pLAFC3hLO2DdHCBXt6k+k8q+jP2b4qXqiGRZzTkSWUHW/HMP2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770626469; c=relaxed/simple;
	bh=pFyp17yXtPSDyObN/lEp+8IAFdP/zDTZJJZEAoDReoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MBQmdLRCLLU1zbB+moOIQ1wqNBC9x7Hl9nSSKWTFmR5g2nKJ56CYm9jD8zNRhfLAM4uYH6i1lJUAqWSJQ3GyBhIuvwhNBWt8AFHzDW5R0ZCNtnQTHJVk8I7ppoAmYdtugBu0ApGJ+nqMBiy1ev3Qm+YB/L0DF92uymtW3AtkXjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W87G7rSR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W87G7rSR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770626469; x=1802162469;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pFyp17yXtPSDyObN/lEp+8IAFdP/zDTZJJZEAoDReoE=;
  b=W87G7rSRZGPFBjGJjeX1gnSLJ6YpQfHPQCr6h6Shq5lyfi4FFnL6yUGc
   dHwGcdd0wZ+ZchPp7645znDdvX9jZCulkHc72PV8tKBME8+zOmxy2LbRI
   lZjkuIiEkqYYP/2sNr+t4eEK6kZNbEjEkW+qBFAAwdgoa7lML8wulaHAr
   wz6+cqXCh8HvV6jLJcKNTytNVjMe3IK3ko6iy3Wcve0G/a2IH5huH0Gku
   XDqcnZqt4zmaPvWR/LjMwAayOy86dLplFpzQy7l5GwWBCCx4Ne7qGi0WD
   qHZxsG9bYgUXnaUhXwqM/bUqen8gifOEGZ1t+haoVVjLiXqwVx4a7K3RV
   A==;
X-CSE-ConnectionGUID: uJDGh9q1QJeuqVoD7il3nw==
X-CSE-MsgGUID: ykUwCcCRS5ehT70YnPE4lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11695"; a="75580925"
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="75580925"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:41:09 -0800
X-CSE-ConnectionGUID: KZU0wPHjR2qPu25mQY+H5A==
X-CSE-MsgGUID: Ggh4zDFZTvuHEtlgYz/8cQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,281,1763452800"; 
   d="scan'208";a="211582983"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.128])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2026 00:41:07 -0800
Date: Mon, 9 Feb 2026 10:41:03 +0200
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
Message-ID: <aYmdn4sHxxD1KK0k@smile.fi.intel.com>
References: <20260205-b4-ad9467-optional-backend-v6-0-7ca20c40c59a@vaisala.com>
 <20260205-b4-ad9467-optional-backend-v6-5-7ca20c40c59a@vaisala.com>
 <aYTGkAf7Ue7goDnw@smile.fi.intel.com>
 <56254198-c45d-427b-bcfb-fa9c60f11e71@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56254198-c45d-427b-bcfb-fa9c60f11e71@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 09, 2026 at 09:24:09AM +0200, Tomas Melin wrote:
> On 05/02/2026 18:34, Andy Shevchenko wrote:
> > On Thu, Feb 05, 2026 at 12:24:11PM +0000, Tomas Melin wrote:

...

> >> +	if (iio_backend_has_caps(st->back, IIO_BACKEND_CAP_BUFFER)) {
> >> +		ret = devm_iio_backend_request_buffer(&spi->dev, st->back,
> >> +						      indio_dev);
> > 
> > With
> > 
> > 	struct device *dev = &spi->dev;
> > 
> > at the top, this one becomes exactly a 80 character line.
> > And in general it will help cleaning up the rest afterwards.
> 
> Given it seems it would still be 81 characters long I would like to
> leave this change as it also creates a bit of noise.

		ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);

We have different arithmetics for sure, I have it 80.

"There are *two* problems in programming: naming, cache invalidation,
 and off-by-one error."

> >> +		if (ret)
> >> +			return ret;
> >> +	}

-- 
With Best Regards,
Andy Shevchenko


