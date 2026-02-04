Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF8827466A;
	Wed,  4 Feb 2026 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170024; cv=none; b=P4MPB1t+xg1VU314IIjKb4CfLTdA/7W1lQhbNb1lxi3nkaheONQcZBzh7bSQNcFsjRk/4NimnNnF5G5/2XcBB2SgIdUig8oUm/Xv/WIxrXIgea6ycE+H0gtheO4W7h9IiKHuy6Y+UZHeyTPq1vZi1XibZp1lbK5BT3zjB7viTaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170024; c=relaxed/simple;
	bh=Iua2EW2rZMgcqfVIwqgvYH/vE0LE1BI0SakI4zEtrLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJGOEWJwE/Q0cEKAxjFBipkb0xUWL36fGze/6oWJwGHlAx//WEWut4UWhbttX/aX/HkvGkt577scZ3Hx91n8qRn7xSnCvb8qc+gDVbUBL23dOFxnPIUy2ONqy248mo6Ww/e6WrY3UlY8a4X6bRhxm6FY7MadPf4Nfw66FhW4/J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUTLzOKs; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUTLzOKs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770170022; x=1801706022;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Iua2EW2rZMgcqfVIwqgvYH/vE0LE1BI0SakI4zEtrLw=;
  b=QUTLzOKsLHpKixzyhOInejfvH87FU4OdNq32hB6Ov68fDFEeUnCQsYUz
   zc4U4XNZ2PdsIf9K3r8vFj+uuME6GvN1RgChPyG+/BqgBEDhmcdPozqKh
   V525WGkInME8XITEgWk1NJW7U8mA0KNaZ3wLxvzzedpRqkPDKcdvYGKDf
   EX+1Qfn8K7UUMvFHMU0a/JYvBX+a8ROesQUgGSklutYF17oz+Cj47g1Km
   +zuE4FQYg5JfIXfInGGOIbh8oaYfwsBvqANJz/SwwhjmUYkEG3epXEpDj
   Iesutr2IJvUGIpqXXlMIOaVkeMvrgdXfJb3nqhGmuIRBKaoA4a/pzG64n
   w==;
X-CSE-ConnectionGUID: QUkZUjiXRCSjuIFK3UVSXw==
X-CSE-MsgGUID: FfihBIBBRv6h1thQvsaUag==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="94003896"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="94003896"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:53:42 -0800
X-CSE-ConnectionGUID: gPj2QvfwTh2uugEc89XFrA==
X-CSE-MsgGUID: ZQpO3zJnQzy40vr1i6cXKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="210051538"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.168])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 17:53:39 -0800
Date: Wed, 4 Feb 2026 03:53:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3 3/9] iio: amplifiers: ad8366: use devm_mutex_init()
 and drop mutex_init()
Message-ID: <aYKmoIe4sXNcMEYa@smile.fi.intel.com>
References: <20260203-iio-ad8366-update-v3-0-5d5636b5181a@analog.com>
 <20260203-iio-ad8366-update-v3-3-5d5636b5181a@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203-iio-ad8366-update-v3-3-5d5636b5181a@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 11:24:09AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Adopt proper mutex lifecycle with devm_mutex_init(),
> replacing mutex_init().

...

It's better to add here

	struct device *dev = &spi->dev;

and (re-)use it in all followup patches. This will make the code easier
to read.

> +	ret = devm_mutex_init(&spi->dev, &st->lock);
> +	if (ret)
> +		return ret;

-- 
With Best Regards,
Andy Shevchenko


