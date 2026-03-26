Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82B1312815;
	Thu, 26 Mar 2026 19:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551867; cv=none; b=L7XkQf1Mq+nxGpMH2mh/TF0ogsxJZKSl521jZOXYqlpHhcSQZGFvbCGkutatiHVJkAbbARNMWBnqHWu1sHkS8fATCnjhQpH9gZuujhzqSjRyRLaRyOmySAlhB2UVtRsJivMynn1uIU95cc9s2FtLfwXcU+ZPMhVbu19reUb5KkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551867; c=relaxed/simple;
	bh=2GdEkka0Rx1k7PnbHtzzL6iWygOPHt0EXermV7BBad8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G2+my6Kg8bw5ysT3eqpqDwsBVyWAXhtTbUGAqp6IH5CUw8ixb997dMBvDcjY63BLPgjThoQoMXHcfPXwEtarn6TTQnf/WaB0bXDMWhc19OkDeWbCQssfFxQ3xRfOuAQW06++Cp7+uz5BWehh31u0KmFxnlIddJxvnWdgavrXXt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U6ExEklm; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U6ExEklm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774551866; x=1806087866;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2GdEkka0Rx1k7PnbHtzzL6iWygOPHt0EXermV7BBad8=;
  b=U6ExEklmbFeKybEin0xG7zKvQ13SNE+6WoFFy4MoczUqJ6iEPlb06MQG
   OLOTyFUrRay5/mGYDal185MHCWmEg2OZGNERju76VBmr6xcEHQKSAnnlb
   9ave1+qAdl5JiOANgdjaYEs2vHEUEVveu5tZoUbT6EvolLxSamIJTK9lh
   rU/aBKcQCDylQgHP6lXcKsXk8FE8R+uWQXuCVgu4uv6iFZS44NgKJ1EaO
   J+nMdShRv/PVH1u1EZ9V3Roq+hVmXt9jIKvA0ZlgJ8njOdpGiiSZS+cGw
   AXWclUGfAEjpWXTj7B3EniQWcQ7LrAmREzU5Ut7Wl8/AZUg6fLWy9JZYt
   w==;
X-CSE-ConnectionGUID: tPfG/najRjypQ7j62Ra8vA==
X-CSE-MsgGUID: o5kvUWc2QZ++FHA80pihSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="74805631"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="74805631"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:04:25 -0700
X-CSE-ConnectionGUID: dJEwYd7UR4OOE4MUQB2E2A==
X-CSE-MsgGUID: V/RzEx+QQMm69OICDPV8uQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="225092187"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.216])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 12:04:21 -0700
Date: Thu, 26 Mar 2026 21:04:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Antony Kurniawan Soemardi <linux@smankusors.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: qcom-pm8xxx-xoadc: add support for reading
 channel labels
Message-ID: <acWDMg58qxyeM5Eq@ashevche-desk.local>
References: <20260326-pm8xxx-xoadc-label-v1-0-027805dad4db@smankusors.com>
 <20260326-pm8xxx-xoadc-label-v1-2-027805dad4db@smankusors.com>
 <acUIAh_r7mSfIiEB@ashevche-desk.local>
 <0b85a229-219f-4457-8fe4-bd4b3545684f@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b85a229-219f-4457-8fe4-bd4b3545684f@smankusors.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 26, 2026 at 12:00:52PM +0000, Antony Kurniawan Soemardi wrote:
> On 3/26/2026 5:18 PM, Andy Shevchenko wrote:

...

> >> Tested-on: Sony Xperia SP (PM8921)
> >
> > Interesting, never saw this tag before.
> 
> Oh, I just realized I misremember Tested-by tag as Tested-on... Let me
> know if it's not acceptable.

You can just put it in a free text:

  "The change has been tested on ..."

...


> >> +	if (!ch) {
> >> +		dev_err(adc->dev, "no such channel %lu\n", chan->address);
> >> +		return -EINVAL;
> >> +	}
> >
> > Isn't it a dead code? Also poisoning dmesg with this recurrent message is
> > not good idea to begin with (the user space will have a door to flood it,
> > which might be considered as an assistance to hackers to clear immediate
> > logs after a successful attack).
> 
> Good point about the successful attack hint! I was copying the existing
> code from pm8xxx_read_raw. Do you think those checks are unnecessary for
> pm8xxx_read_raw as well?

Yes, I think they are not as the returned code should be enough to identify
the problem. (For no such channel I would rather see -ENOENT, but we can't
simply replace that in the existing code as it's part of ABI.)

-- 
With Best Regards,
Andy Shevchenko


