Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B061392822;
	Mon, 23 Mar 2026 11:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774263610; cv=none; b=Ho7wKm2Vw4ExTM7l3hzU6X6b0lXOPoj3miSpo8Fk8YNewtPSgo+03hQCCCp9rIrAHSHMCrDsRM39ajElNZLY64LSZXxBZJQXX+T0DffbFln1NIM2lJjO1KgXDddAoJvpNEjwhBI1EgXQmOleE5y2Ul0jZ0CNmjyluvhJnX25Qpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774263610; c=relaxed/simple;
	bh=gX2dHFjzfzHKBq3hfIJ2ob3m5zNT57N8lbE2MIAM6A8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTEa/lUVEr663LDSUFYsZKM9vHqi/d5cwHzij/Fmybev8hmaYfmPAJNi28ZgOj8WQWv6GMSI/+cKGdQqpgv8Sq7NIygn9RBa2znXPHMEiucxa1+RrKANCa4QdkG8KJ085KLXf5mrK9zRw6v+dIAzfOWDcNGxYrtcUDlf68mhnAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gO4i1rWO; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gO4i1rWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774263609; x=1805799609;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gX2dHFjzfzHKBq3hfIJ2ob3m5zNT57N8lbE2MIAM6A8=;
  b=gO4i1rWOx2UGgLUA+R9Pw534q5de/BspoHQGWQadwUD25x8rucKFhXHz
   Z0iP/lM6OEcdvJt/EJbztRTHBbAuVUiBeiNVuHnYWM/8NXhTEj2wNfxus
   uR3rW8UBl/ZWllpkFY5c8+uLcghK2g+4NC+DRaMtN5W6lyKyAr0+4kepJ
   yX1DaOlKgYjRgfdDbEen0Wbft2RVDE3zAYXZxqzIfTvRnDzMoiaaKoYjJ
   JzI2kFjOEziXJvWHZgPlNCGS8k5C5swjJUrmDT8Rt16zK22oNZKnZp0Oo
   IMPad9JoDXFvgYgb/CxZhmr07WGKk+TX/dCSkSFeweOiln68GG3xfwnOi
   g==;
X-CSE-ConnectionGUID: U5czERWxSOatlWJiUxjREA==
X-CSE-MsgGUID: J88AphfXS32h6DKmApX+4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11737"; a="74966755"
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="74966755"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:00:09 -0700
X-CSE-ConnectionGUID: KfLTq6lqRz+TGK+7a+q5Jw==
X-CSE-MsgGUID: f7mN7XvXSbS3brSipejrfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,137,1770624000"; 
   d="scan'208";a="223064608"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.22])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2026 04:00:04 -0700
Date: Mon, 23 Mar 2026 13:00:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 2/9] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <acEdMhIenzbMqEyx@ashevche-desk.local>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-2-e79f93becf11@analog.com>
 <20260322165058.6c4b193e@jic23-huawei>
 <grjlyz76cmjy7t3ytwycaklauipbqcj7adjr2t7k3axwlayowr@4zbuzehcrpvs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <grjlyz76cmjy7t3ytwycaklauipbqcj7adjr2t7k3axwlayowr@4zbuzehcrpvs>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Mar 23, 2026 at 10:34:37AM +0000, Rodrigo Alencar wrote:
> On 26/03/22 04:50PM, Jonathan Cameron wrote:
> > On Wed, 18 Mar 2026 17:56:02 +0000
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

...

> > > +#include <linux/array_size.h>
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/device.h>
> > 
> > Generally can avoid including device.h in favour of more specific
> > headers.  There are a few exceptions where we can't such as actual
> > dereferencing of struct device, but I don't recall seeing a case in here.
> 
> I understood that the usage of devm_add_action_or_reset() would justify
> the header.

It's in the device/devres.h.

...

> > > +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> > > +	if (st->data.pll_enabled) {
> > > +		tmp = AD9910_ICP_MAX_uA;
> > 
> > Defaulting to max current seems unusual.

Agree.

> >  What's the motivation? Normal instinct is go minimum if no other info.
> 
> ICP_MAX_uA leads to 111 in the CFR3_ICP field, which is the default value
> when the device resets or when it powers on. I suppose that if we are not
> touching that property, there would be no reason to change that.

I believe we should think different, id est about potential damages or
current drain. I would expect a minimum or hi-impedance (power off) state
of the related part of the device.

-- 
With Best Regards,
Andy Shevchenko


