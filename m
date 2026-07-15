Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E483C345C;
	Wed, 15 Jul 2026 08:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104934; cv=none; b=bMToRtGoWJTFXI836MbIN5XbBVlHvM227Bc8eba5HFIrrb07TAYDgWng0dGcHY02taWZ79gN5LNLDOKwCIl+yJswQMEZ/TuLLFm+csOV//ErM/HeTvIisL5c9vs3K38ZPVyHeFjuZiYl+80RDoMRA43DHdQ93hZmvMvKkqtLjVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104934; c=relaxed/simple;
	bh=1btqbG3bYjr6NP7p0mqbUGkyNih4hZFbcjyS0lPCAH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6zt+wzskIi6Zj8ibT0TrnVp6rJ10H/0OewljC5OjkuR/U/HFhn3Kn48DRZlHaaQ1Tqq6eGmIA420lNpKLgCHfKHEJzRtlZ5YUAvAfpHodBFCkMam6gHPZPTJjKlJTzPyJa/RVKfkmh2hQiQtasxw7eDech+uDNkCWx47Ehrhmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PJspQKb4; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PJspQKb4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784104933; x=1815640933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1btqbG3bYjr6NP7p0mqbUGkyNih4hZFbcjyS0lPCAH8=;
  b=PJspQKb42YKqx9d9NPAgwSTRvIqOajZhBrscUcw+Wo3cbEDd9LUSgAp4
   fQvCtV4dyyZVEhH0PdDmk7OfTOqEWWQ4Hv0bTBoxq8fIx0oPs5tdEHFOi
   CAX5ss3ObNJEGNwMc2LbqaW53m7bWnmh2+ExZeoHedBdUFbREe6AeKp4x
   bhMfA/GwoVHwHOsMANUO8+3PDoFnFd1svIdcSL7ctHUU/ycoWXEDgS+if
   aeEzitfLHw1zJsryprV2dKbgRQZy8ne1tRGY9So/sH9qZv+8XpLdvwZpQ
   2h1FhWt2na+LicU3qBj1oE7jtaoboDz2PLRjfbzJFdnZQlgvhSSeumSls
   g==;
X-CSE-ConnectionGUID: nEyLMSNGQoeUXCAOyhgw3Q==
X-CSE-MsgGUID: D0FT5lifQomaLnmOsXwn/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="96250744"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="96250744"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:42:12 -0700
X-CSE-ConnectionGUID: 5P8a8pM1SjeYqWtOBJT1eQ==
X-CSE-MsgGUID: hriWFPqNRUaJ0kH5TMFwOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="279401014"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 01:42:08 -0700
Date: Wed, 15 Jul 2026 11:42:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Message-ID: <aldH3vtk_eKh6oCC@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
 <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:
> When sharing interrupt line with other chips, the interrupt pin most
> likely needs to be configured in open-drain mode instead of push-pull.
> If this is needed, you must add drive-open-drain property to the
> device-tree.

...

>  	if (client->irq) {
>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> +					   data->open_drain ? IRQF_SHARED : 0,
>  					   client->name, indio_dev);

Why do we care? The (hidden) problem this will have in the future is that
the IRQ core will splat a warning in case that other shared IRQs might be
configured with different flags. Putting that flag conditionally makes it
a mine field for the users. Instead just unconditionally add that flag and
we will get reports as soon as there will be a user that shares the same
interrupt pin with some other devices which drivers do not use the same
settings.

Also setting to _LOW in the flags unconditionally is a (historic) bug.
The problem is that we might not fix it without breaking the existing
users which omit that flag in DT.

-- 
With Best Regards,
Andy Shevchenko


