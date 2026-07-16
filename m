Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269F73A48E6;
	Thu, 16 Jul 2026 18:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784227337; cv=none; b=DrJ5oHsKcry+qL/s4VHrfR2dgCu/Mjl91d+1syIGpX1lqH+gXY+a+eE1YZ/8sFFWwgDQI3ziVgXIW6rp2i4mnYR9akDy4le/l4/RrosjNsidIPy+XTwJDDderCwGfIn2DDqAtPhYRtTNYEJIGe1XwAoEtHlqI2RL7jib8m2EiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784227337; c=relaxed/simple;
	bh=+ND4h5RXK6bV1IObtBmOFgCVGZ+P6XcGLdHVq8NJt4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq4Ia05h2an5m0fFdiBsYGAWRRwZklLNn+17f+TR9x9Ompakl++BREz3JOOPOwoxcjhlBgL/NerLz/K+cArKZgl6O4lZyunxBrM9HCFdIgoGSF//pexms4Q1BNxHZx15cd9qRC0oPNe/c4WFlLo5NW1gO1gtYD2FetUWO1YaM80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BW5/HR4S; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BW5/HR4S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784227336; x=1815763336;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ND4h5RXK6bV1IObtBmOFgCVGZ+P6XcGLdHVq8NJt4U=;
  b=BW5/HR4SMC3zbGLfoHPTqDtv9gia6rgreppjRllofhdYeQ2297THMHNJ
   fDNttbZA3LWD+01SnvoGp+oqh3JioBQ2gGV72U6bNHDf0ZqxWgl2FQwNy
   F85tmlGDnXp8q3VZ5VtTmafRXjaZ7SiXciuztjnisbQhobwfshZKlOrZ9
   DhkXpHSJoVgXJC5t8toydNYySWEA5jMrRixkqd7YF5/SXl8JKtzDkY84k
   kYKAh68N4H7vhAZvK6G3VwcXk7/ZV7V1rqCMxTf2ih+peCVZBZvVDPEht
   ywpCI55qBq8wH1XpHNmuUCaIuTWEMzolKKBLF1gtGquExfIIESoK2QhJu
   g==;
X-CSE-ConnectionGUID: cBo9xEM0QomQkjd7/2IBTQ==
X-CSE-MsgGUID: EnluN+sjQ1KD2tkM9uaAwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11848"; a="96266162"
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="96266162"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:42:16 -0700
X-CSE-ConnectionGUID: 7JwlDBH9QnawpT2Phb0qsg==
X-CSE-MsgGUID: izCDovysRXqbZFBxGO8jyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,167,1779174000"; 
   d="scan'208";a="258565482"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.26])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2026 11:42:12 -0700
Date: Thu, 16 Jul 2026 21:42:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: Michael Auchter <michael.auchter@ni.com>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	sashiko-bot@kernel.org
Subject: Re: [PATCH v8 2/8] iio: dac: ad5686: missing NULL check on match data
Message-ID: <alkmAcDvSXr_COc_@ashevche-desk.local>
References: <20260716-ad5686-new-features-v8-0-ebb0051af5e5@analog.com>
 <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716-ad5686-new-features-v8-2-ebb0051af5e5@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 16, 2026 at 01:14:18PM +0100, Rodrigo Alencar via B4 Relay wrote:

> Verify that chip_info pointer is not NULL. If a user binds the driver
> using driver_override via sysfs with a device name not present in the
> id_table or of_match_table, match data will be NULL.

...

>  	struct iio_dev *indio_dev;
>  	int ret, i;


Move an assignment here as well.

	chip_info = ...

> +	if (!chip_info)
> +		return -ENODEV;

-- 
With Best Regards,
Andy Shevchenko


