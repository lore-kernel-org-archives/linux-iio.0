Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9A5385515;
	Mon, 10 Aug 2026 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786381329; cv=none; b=VltsinA/AdnXfPPhunN9w4rSkiTvJq0Q12WJNR7bCj/fgpX5/VrR85uSidPy1XRBM4HC4qOuLoGHspRs+HNUPmOmrtaBn8zzuqAvBz25H45BRUFP7CgnEdGv4vDO3RI2GJBNMznrXLwNLwBuwagA4owf8bGEkTbRK2D5D0BP3IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786381329; c=relaxed/simple;
	bh=qbKkS7s39tO59YnnxrXHo4fczdU9CTqXcTNa80t2qLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BT1Lr7lo5J18+bAyplrbj2oyTXKvk5lJphTj0kRRrqfiCooNcBmu1kUEjT3x7q2jpPh9DJjUJi0JmZkr6VpSESAP2KIG3XlTJAg+b71vOZNJoV3TTNpJn7muFSDTLak5WtSbvkISC6yeQgRVjuX8WwWt/JKa00y0g3rdpiEkGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HUxNcv/k; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HUxNcv/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786381328; x=1817917328;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qbKkS7s39tO59YnnxrXHo4fczdU9CTqXcTNa80t2qLk=;
  b=HUxNcv/kSuoCIDVmHLJ16WWiZr+UkxSncIcoWhJ8qbkXf394uOkXeYhh
   j8VyhmJx6kK67TlvWM7/B3qGeTvRhp+e3PIuGyR1SIU0/J+ttbGmLM5C8
   M+q4nXeJro0jwOyFFGgtLFqLc7WV5zGsRWNEX3BZOM/N3HoPPeTvbnHgk
   O/B5YAxSjfS9LBkfk094fDzgTEztTvCA+RhW4JCp0hxHuel7/MgXrF0rm
   ZrOO3wacF2h8MlVFK5p2gX5fjHxy52BQQeHol3jokSG2yMQ6UE8RFPEPA
   vgkntqVb2jTuIu9a7Sd34M8qftzupPczTJNQbs/vT5hoPqj0eQfS4xZIe
   g==;
X-CSE-ConnectionGUID: bm9s+EB6QLOZ/y0tmsdIew==
X-CSE-MsgGUID: ynD+ia8VRKShOWUs14zMeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="86662011"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="86662011"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:02:00 -0700
X-CSE-ConnectionGUID: cpMx6TNJRXC4FhCJULRi1A==
X-CSE-MsgGUID: CFlvzCKzQDCHpJv+DMym8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="256868218"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 10:01:57 -0700
Date: Mon, 10 Aug 2026 20:01:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: adc: ti-ads112c14: add DRDY interrupt support
Message-ID: <anoEA4ekSph93vU8@ashevche-desk.local>
References: <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-0-76e0d30e6c6b@baylibre.com>
 <20260807-iio-adc-ti-ads112c14-continuous-mode-v3-1-76e0d30e6c6b@baylibre.com>
 <anmQw2X2-CjzSMko@ashevche-desk.local>
 <9caea0d2-3fad-4a47-a437-096c269938d5@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9caea0d2-3fad-4a47-a437-096c269938d5@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 10:59:20AM -0500, David Lechner wrote:
> On 8/10/26 3:50 AM, Andy Shevchenko wrote:
> > On Fri, Aug 07, 2026 at 04:19:46PM -0500, David Lechner (TI) wrote:

...

> >> +	if (device_property_present(dev, "interrupts")) {
> > 
> > Unfortunately this is no-go for ACPI-enabled systems.
> > On ACPI we expect to have 'interrupt-names' but 'interrupts' is OF-only.
> 
> So device_property_present(dev, "interrupt-names") is OK?

As long as we use _irq_get_byname(), yes. Because the below call relies on that
property to be present in any supported FW description.

> >> +		data->drdy_irq = fwnode_irq_get_byname(dev_fwnode(dev), "drdy");

OTOH, you may also introduce _optional() variant for this to avoid layering
violation (why should driver know about that property at all?). But I haven't
checked how many existing users (if any) we have. If none, perhaps also a
TODO/FIXME/et cetera here to point out on this.

-- 
With Best Regards,
Andy Shevchenko


