Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49076226CFE;
	Sun,  7 Jun 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819693; cv=none; b=qpOr2d+tZZADg2VUffjzvWpFVyJcTJx4BaIfBPawR4O2zDHojWYNR9HE5Ct8tN4En7+ycfayVS8sN0AHMDB34QtkZrBh5BMdv2z9qMH6fcfpVDZBtesoKDAy2a07ZNW4egQAjrKHtRMXpGknXkbbwMpGuAPDj+xT+YmyMV/JRy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819693; c=relaxed/simple;
	bh=v8oCVZ7Fhk20qYPs+YW8p6YF47K47iAvoArMo8RzC/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pIkPIQKBXXLc2JS4sT+ox0cYVytxmkOgllplf30Y3XqyiEd2mAZEjeqttL5L7CSEROjoQQ3DmlUtGk2Cv1LIQhufT/qq1Mxeq//g2HLKcC66052LGyvSLsCAgsg3CZ5wDSdh0kVYwlgHVYVSrsdP1r5X6VdkQRowzOm8wwpShS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VbpmVBIt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VbpmVBIt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780819692; x=1812355692;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v8oCVZ7Fhk20qYPs+YW8p6YF47K47iAvoArMo8RzC/s=;
  b=VbpmVBIt67rDYgGnpg2nWXXYREBNxqnYOQU8bSL2Vr6apSosnPtxzFXS
   WvtWt5FxBqMoUXUIdRU5C79iQWhC/z36qvkBjvWyPrAzYV8LxZ5potPrZ
   Jv4uffBXtLuBqLZEgIIKDKGb2XqXIa+GeakIzJabq6gQgR4jB/ga4KKNY
   iVUsgOCwIMfIHdgoYhkx94yuVqrEwaLFuJgIC/9Ny9WrPhaevYPejpzes
   FQZz4QYj5DxNYT2KQSbJv9t8SFgPksVwcJQjj5Axq4ex3lKqBEpkDOmND
   SlsRMPN1Tcyz+Iy+1fmFuHQ7I95L6mJ/qMXv4ugx44zmJfVE296lqcuEP
   A==;
X-CSE-ConnectionGUID: 657+5xJqQ72MxGzY9Ak/Nw==
X-CSE-MsgGUID: 2t3cZupFQNWru9e/foCoZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11809"; a="92152790"
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="92152790"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 01:08:11 -0700
X-CSE-ConnectionGUID: NDikdfbFThSYLY85Yf7hmg==
X-CSE-MsgGUID: yK6ojSZhRVuPJMbIhwljrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,192,1774335600"; 
   d="scan'208";a="238888155"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.86])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2026 01:08:08 -0700
Date: Sun, 7 Jun 2026 11:08:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salih Erim <salih.erim@amd.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Michal Simek <michal.simek@amd.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: adc: add Versal SysMon driver
Message-ID: <aiUm5vmG7EHmp52x@ashevche-desk.local>
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-3-salih.erim@amd.com>
 <aiUmb0WMPHi0D6GH@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiUmb0WMPHi0D6GH@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 11:06:13AM +0300, Andy Shevchenko wrote:
> On Sat, Jun 06, 2026 at 06:17:04AM +0100, Salih Erim wrote:

Ah, and missed part below.

...

> > +#ifndef _VERSAL_SYSMON_H_
> > +#define _VERSAL_SYSMON_H_
> > +
> > +#include <linux/bits.h>
> > +#include <linux/mutex.h>

> > +#include <linux/types.h>

types.h is not used here.

> > +struct device;

> > +struct iio_dev;

Neither this forward declaration.

> > +struct regmap;

-- 
With Best Regards,
Andy Shevchenko


