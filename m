Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09592DB7AE;
	Tue,  3 Feb 2026 15:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770133131; cv=none; b=qKoMN9WlI3oasBbTiawSWLqplVd5pCGlDk23cm3SSlY4tzTXG8Faxd0d+9KQsyrda6XHMYZTioKJV75mSyscR5SNANNrWlUyzcJzj0TNVEHo/7iCskbGUF/gH1rHLrsRcsp7MWJWzI0CmCPOSG6Ld5P48HlzRG9ZWb3FO7Mb7OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770133131; c=relaxed/simple;
	bh=v6A3tzQV+HRR60fcN7UvQte2RTaFoOhouiuZBmHlwUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uf0baLj1lngT5gahCD8VCsnfw1cCYoiw6jZcAOhSbMTnxpIeH+lMHVmvu4Po4s0PE8DANXEJPcPCbpG3keIbsKLmWQsRzXmBbj5Cdsk0WpR1QBUElzEk+Jb4jIcwrJUK5sK/8EkNAZeLC4YFt88mw/h5NbvAEat1K3Bl2BSQIqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBgssIku; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBgssIku"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770133130; x=1801669130;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v6A3tzQV+HRR60fcN7UvQte2RTaFoOhouiuZBmHlwUo=;
  b=GBgssIkuRYWfph58V7hnrhv+X0rmhuJsKvawXsoO39lllLvg1t3wi1mD
   vDIsuqGWsZ8Fy2MPfz9YgqH7trUd0+ygkiIfZ2RNg23V2tlZDpa03srXA
   whMDi8uyzDjvbl/vp72wWA+oHwf7fX3Y/h5BZCvpjZh35/h2WYiIfpiRz
   Q6W8TMb6sMVRZM4QSYvMxMePq5VmLl33PJ5BNr340ZDZ4hDP37GCVPbB5
   zedo+/sH+YGAUFGVEk29JRrTk66HW4OMOcQ7PlYkmGv/GXs0MmdOlAZp8
   zlodwqaW2DBbUjqIcelEIw8qYaf6qLX35Y5fie/dt6wsTPIYDU9nRwG5T
   g==;
X-CSE-ConnectionGUID: LiiJYJOYTROV4Ie8kuAjqw==
X-CSE-MsgGUID: pPogL6ENSY6/Y40CxG6Xwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="71206993"
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="71206993"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:38:49 -0800
X-CSE-ConnectionGUID: qzRzXXumTp+KWyAZ51XLRg==
X-CSE-MsgGUID: hbMs+Fx2QKOAknzldq2Rbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,270,1763452800"; 
   d="scan'208";a="209914900"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 07:38:45 -0800
Date: Tue, 3 Feb 2026 17:38:43 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 3/8] iio: test: add kunit test for fixed-point parsing
Message-ID: <aYIWg9874VmIdJnA@smile.fi.intel.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
 <20260130-adf41513-iio-driver-v6-3-cf46239026bc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260130-adf41513-iio-driver-v6-3-cf46239026bc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 30, 2026 at 10:06:44AM +0000, Rodrigo Alencar via B4 Relay wrote:

> Add kunit test cases that aims to verify expected behavior for
> iio_str_to_fixpoint() and iio_str_to_fixpoint64().
> To run the test, create a .kunitconfig file with:
> 
> CONFIG_KUNIT=y
> CONFIG_IIO=y
> CONFIG_IIO_FIXPOINT_PARSE_KUNIT_TEST=y
> 
> and run the command:
> ./tools/testing/kunit/kunit.py run --kunitconfig=.kunitconfig

Thanks for the test cases!
There are some nit-picks, otherwise
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +#include <kunit/test.h>

+ errno.h // -ERANGE

> +#include <linux/iio/iio.h>

+ limits.h // S32_MIN

> +#include <linux/math.h>

+ types.h // s32

...

> +static struct kunit_suite iio_fixpoint_parse_test_suite = {
> +	.name = "iio-fixpoint-parse",
> +	.test_cases = iio_fixpoint_parse_test_cases,
> +};

> +

Unneeded blank line.

> +kunit_test_suite(iio_fixpoint_parse_test_suite);

-- 
With Best Regards,
Andy Shevchenko


