Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8802F8EB7;
	Sun, 10 May 2026 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778397586; cv=none; b=Bfl2uk+2+7HTDP6dGd8MpStTOHq9+YWQm08nzd9wQOzKyxDGXmiTKiXW3z5TuhmyTYHiAJrD3GSHFfIFwu24oRNQBEE0tbP/nqK+msVi9pg1v8ziz/fVfZypikFtDD0stvDmOFSrmJcNLC4ISMdiSOYSmL9JnaazUehUpCrFwtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778397586; c=relaxed/simple;
	bh=eohYJHwoejrU/BXmKoOTeozRPO2vN5Bzmy9y7RhES0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LDhHNiUO7ynGb+Vu1WS9FwF0xaJ4lJ1xPgQGJ9cLWO06drphRM+lZVAdjhsLZzE5felc44nqVcD6/UFRn1747wF5fRvODiK2FIBWYclR5EFc+6p0qWJAxRysLVkXOMVJwHf2D7OAt/SVL7RDtY0VnWz3lRA1vfPvfeHN3G8AJSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h1AiuAu5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h1AiuAu5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778397585; x=1809933585;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eohYJHwoejrU/BXmKoOTeozRPO2vN5Bzmy9y7RhES0M=;
  b=h1AiuAu55/KNr3uVvxL+/yGJmKo7IwfJ6FnB4t2T3CK3BwT2CwSn5cVg
   OECEnB/cp41cheu7DPfYCISj+g3fhcRa8Fti81iMN68lx8cgutGgf15IK
   j79XC9DafqNBLWzwzRZOP0nFMvWXWBbgDhbi3o0j1qvLGkwrq7pNEtWqA
   DaL/uRk/jkTOU58ACgzKjB+NhUjnbhS/M5dZoFx7LRLlzJF2qQXAUixIs
   POJ9Mzar18Jw+L9nRrxg49hZ1aFmr1CUR7Fyzzp7NRvN0XKCipT2Y1Cdk
   8OzPvEs0GdfepiooE7pOgpB9fq0LUfd5zoPPFTkbUjb5QATbfRf39eC0l
   g==;
X-CSE-ConnectionGUID: o4n/zY+KTruEZDRf9MMFIQ==
X-CSE-MsgGUID: QKQeaYEQQe622zZvJR88IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11781"; a="81883150"
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="81883150"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:19:40 -0700
X-CSE-ConnectionGUID: Q6NL2Ul6RrWvEv4v96Pz4Q==
X-CSE-MsgGUID: 9B1zZ9kDQaawGMPUIXQGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,227,1770624000"; 
   d="scan'208";a="237390094"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.244.171])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2026 00:19:36 -0700
Date: Sun, 10 May 2026 10:19:33 +0300
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
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linusw@kernel.org>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, phone-devel@vger.kernel.org,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v6 4/4] iio: adc: qcom-pm8xxx-xoadc: add support for
 reading channel labels
Message-ID: <agAxhcwXH4jCnJLO@ashevche-desk.local>
References: <20260510-pm8xxx-xoadc-label-v6-0-49700fd03005@smankusors.com>
 <20260510-pm8xxx-xoadc-label-v6-4-49700fd03005@smankusors.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260510-pm8xxx-xoadc-label-v6-4-49700fd03005@smankusors.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, May 10, 2026 at 07:01:45AM +0000, Antony Kurniawan Soemardi wrote:
> Implement the .read_label callback to allow userspace to identify ADC

I would write in a usual pattern here, id est .read_label().
But no need to resend just for that.

> channels via the "label" property in the device tree. The name field in
> pm8xxx_chan_info is renamed to label to better reflect its purpose. If
> no label is provided in the device tree, it defaults to the hardware
> datasheet name.
> 
> The change has been tested on Sony Xperia SP (PM8921).

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +{
> +	struct pm8xxx_xoadc *adc = iio_priv(indio_dev);
> +	const struct pm8xxx_chan_info *ch;
> +
> +	ch = pm8xxx_get_channel(adc, chan->address);
> +	if (!ch)
> +		return -EINVAL;

Usually we add blank line here (and in similar cases).

> +	return sysfs_emit(label, "%s\n", ch->label);
> +}

Again, no need to resend, I hope these can be fixed by Jonathan whilst
applying.

-- 
With Best Regards,
Andy Shevchenko


