Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C723E6DEB;
	Wed, 17 Jun 2026 10:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781691378; cv=none; b=NT56Nye0qScKm1pC2AyknrsEAgphGvpBmlKsVUNoap5jhh5pHHp4xjbhv8ccTyuTKKEjuKBw6voTV0AFnKHhaf2Itcoz6I3xZHLrYd/V1g04exI4WjOrxz4L6JGmyDF4O8cDhm/MRMbvFKirgPdjccikt/edsGPhE6diRQlcmqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781691378; c=relaxed/simple;
	bh=/Du7xSBZ9Xrv0FfRmXbt7uxO0SSdIh3ccn6AXcwcxzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TDb8ah8PglEEkHxV0K42Oa76K/YMPMz8bAd7BKxYeZlYN7X/8SPxnskzgPIa1O5Zd66D/LFDlJ4akKTi+evFJs/j7LpsJ8aW28+Wr3LIbFdxoE2pttMEiCQ85fIpaNa5yzmQFpNfaplBt1LtX4zgtCAJ4/euS3W5vTwVI3UFt9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ad1H0kwE; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ad1H0kwE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781691377; x=1813227377;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/Du7xSBZ9Xrv0FfRmXbt7uxO0SSdIh3ccn6AXcwcxzw=;
  b=ad1H0kwEhp2/NyzZLS7Q8P2HO+mrXgbyFBZzEhsdl9jJDPT8SdQc2BS8
   2ZGqwOvNLTkMJFd60VyN/UWU1qcafaPRayDCOYVBjQLid1TdB2fpaqCko
   CH0CtUuXof9U37tggyE3lkXG5tD4ENlI5wba15XoqDTkmd4LGgyiO8Uvs
   R548P85ckysjXGdz4A2Or7lvLYrQcoX4FHh13qCDqAQLoRx0fbs47Aet6
   7xsLvir15AbNaENt9LA/SKvva81YA+OC2xMCUETLpGQsGPF7Z2XQ8fus6
   LeWQmhDhfde88EXzizRerNWdY5JUUXXLxmpxZnmRii7N7Ho0H5Obgctgx
   Q==;
X-CSE-ConnectionGUID: ggMkvxawTsSdb7HBkIdFSA==
X-CSE-MsgGUID: N/Qfw4QzRvGbeQq528a9Ew==
X-IronPort-AV: E=McAfee;i="6800,10657,11819"; a="82487799"
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="82487799"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:16:17 -0700
X-CSE-ConnectionGUID: +iRU2SCKS5GjpWI609Y8eQ==
X-CSE-MsgGUID: FlcaSxNhQCaoEFLMPAY0rQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,209,1774335600"; 
   d="scan'208";a="252981480"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.69])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2026 03:16:14 -0700
Date: Wed, 17 Jun 2026 13:16:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: ti-ads112c14: add measurement channel
 support
Message-ID: <ajJz7LZGLhZcVN7i@ashevche-desk.local>
References: <20260615-iio-adc-ti-ads122c14-v1-0-e6bdadf7cb2b@baylibre.com>
 <20260615-iio-adc-ti-ads122c14-v1-4-e6bdadf7cb2b@baylibre.com>
 <ajELGxonxsQp-Ut2@ashevche-desk.local>
 <e1e6a5f3-4cf3-4454-ab73-a45ae7b77116@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1e6a5f3-4cf3-4454-ab73-a45ae7b77116@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 16, 2026 at 10:55:34AM -0500, David Lechner wrote:
> On 6/16/26 3:36 AM, Andy Shevchenko wrote:
> > On Mon, Jun 15, 2026 at 05:00:02PM -0500, David Lechner (TI) wrote:

...

> >> +		if (fwnode_property_present(child, "single-channel")) {
> >> +			ret = fwnode_property_read_u32(child, "single-channel", &spec->channel);
> >> +			if (ret)
> >> +				return dev_err_probe(dev, ret,
> >> +						     "failed to read single-channel property\n");
> >> +
> >> +			if (spec->channel >= 8)
> >> +				return dev_err_probe(dev, -EINVAL,
> >> +						     "single-channel value must be between 0 and 7\n");
> >> +		} else if (fwnode_property_present(child, "diff-channels")) {
> >> +			ret = fwnode_property_read_u32_array(child, "diff-channels", pair, ARRAY_SIZE(pair));
> >> +			if (ret)
> >> +				return dev_err_probe(dev, ret,
> >> +						     "failed to read diff-channels property\n");
> >> +
> >> +			if (pair[0] >= 8 || pair[1] >= 8)
> >> +				return dev_err_probe(dev, -EINVAL,
> >> +						     "diff-channels values must be between 0 and 7\n");
> >> +
> >> +			spec->channel = pair[0];
> >> +			spec->channel2 = pair[1];
> >> +			spec->differential = 1;
> >> +		} else {
> >> +			return dev_err_probe(dev, -EINVAL,
> >> +					     "channel node missing channel type property\n");
> >> +		}
> > 
> > Looking how it's going to spread (I mean the above pattern), perhaps it's a time to introduce bunch of
> > 
> > 	fwnode_property_read_*_optional()
> > 
> > and the respective device_property_read_*_optional()?
> > 
> > Let's start from u32 case only, as it will be most used anyway.
> 
> I don't think that would be really any different from device_property_read_*
> and checking for -EINVAL or ignoring the error completely. TBH, I really like
> it this way with fwnode_property_present().

Yeah, it's explicit, but with _optional() we may simply have

		propname = "single-channel";
		ret = fwnode_property_read_u32_optional(child, propname, &spec->channel, 0);
		if (ret)
			return dev_err_probe(dev, ret, "failed to read %s property\n", propname);
		if (spec->channel >= 8)
			return dev_err_probe(dev, -EINVAL, "%s value must be between 0 and 7\n", propname);

However I admit that in the above case you also want to distinguish the cases.

-- 
With Best Regards,
Andy Shevchenko


