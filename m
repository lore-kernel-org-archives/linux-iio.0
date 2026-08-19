Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81AD825C804;
	Wed, 19 Aug 2026 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787147696; cv=none; b=HzHOAb2zDc2MoLQuh+BW+VJv6t9yx+cvLrJ30fUwf/HbNsGTTsODwfzugVoSID+WdW6O+rPhBtBEzZBZhd0xASaG1OBmHm8HSf+3j7NYGc51i/WkZq0/rRMle60IbDF9WToalOtGf9YGVIyb5n1H8cyn0SP4vZOxpWzGi+l7YZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787147696; c=relaxed/simple;
	bh=sAtBqCgxzctag6RCtveNWvQ+EXfNNYR9+eREaPoPIv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5IOKhLoWjkFopBrkAwvxs/ZYzwS8qzYd+2l6lnxpNJik6tnD5q3HhLEN9ETOGpKU34QLKvyKFYdb3bjvUXYz6nFaOP1dv0GH2jWZAD/KpEWpumuTrycpm6FQcuyXn8LAWTBOhJUJGgAK9rbikC4y6TLOL4JKe22JHqhxx6gSNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hxabYPc7; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hxabYPc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787147694; x=1818683694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sAtBqCgxzctag6RCtveNWvQ+EXfNNYR9+eREaPoPIv4=;
  b=hxabYPc7gidxXCXFSHt0udSnSWq7l6A0kIubCvTXMNk/q8ynYwfsXANH
   TONLNJBrZpUqGBsz+JMHyE8qBk5U9RRvY4wh5xnJJS/F32kV4kN3mjQSb
   Q2q3k8O4q9EZ9lIhHjX7UFj4jeHbqmS5wy7BLuB59qGhGEd73oorY4cm6
   y8LCO2IKWoDUaxpwxQUc7Nyg4Y54De4NmhnN6ItpFM1DrVYG9SVvA1rVC
   wm2yEOwdcgjp809V4W8U5VqfIwrVSiUPOjV2jO9NugC3/iwE/SDyXH0n6
   fohvEN/CLWwOYtCypdzQH3VgP846sw5i8G1bCC0sK2bN6uxUlTh849f7v
   Q==;
X-CSE-ConnectionGUID: YlyGNDfZQ2e18v6Mt7JUOQ==
X-CSE-MsgGUID: /CJyNINgRl6gqve0gjU4ZA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99023216"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="99023216"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:54:53 -0700
X-CSE-ConnectionGUID: 80mdCHshT0Kn1ncl9N0mXA==
X-CSE-MsgGUID: 46wk2ksVQ2iY7W0ioyzU9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="265103967"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 06:54:50 -0700
Date: Wed, 19 Aug 2026 16:54:46 +0300
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
Subject: Re: [PATCH RESEND v5 4/6] iio: accel: mma8452: Support interrupt
 sharing
Message-ID: <aoW1phh-elFZ5lU-@ashevche-desk.local>
References: <20260819-mma8452-open-drain-v5-0-d8aa590d7c36@geanix.com>
 <20260819-mma8452-open-drain-v5-4-d8aa590d7c36@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819-mma8452-open-drain-v5-4-d8aa590d7c36@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 10:15:31AM +0200, Esben Haabendal wrote:
> Adding handling of rutnime PM suspension in the interrupt handler allows
> sharing interrupt with other devices.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.
> 
> The suspended flag is added together with synchronize_irq() in order to
> protect against race conditions when doing runtime suspend and device
> removal. This way we ensure that interrupt handler does not try to access
> the device while regulators are disabled.

...

> +	pm_status = pm_runtime_get_if_active(&data->client->dev);
> +	if (pm_status == 0 || READ_ONCE(data->suspended))
> +		return IRQ_NONE; /* device is powered down or being removed */

This way it won't work (if pm_status != 0, you need to act accordingly).
You need to split this:

	if (READ_ONCE(data->suspended))
		return IRQ_NONE; /* device is being removed */

	pm_status = pm_runtime_get_if_active(&data->client->dev);
	if (pm_status == 0)
		return IRQ_NONE; /* device is powered down */

But I'm not sure this will work as expected.

...

> +out:

out_runtime_put:

Hint: Always name labels as an answer to the Q:
'What will happen if I goto $LABEL?'.

> +	if (pm_status > 0)
> +		pm_runtime_put_autosuspend(&data->client->dev);

-- 
With Best Regards,
Andy Shevchenko


