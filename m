Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34C1337B81;
	Fri, 11 Sep 2026 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145046; cv=none; b=JXltsk/+BezXxGLdJPKbhGsWjOCuCF2xhcjKY8PbI2n/B/X+l7cfrIof6zuAdfvdkGjK3JsmENnIUiWn9vzB0/G1oy4BWhMMUv/qNkycXKPtpkEo+vabGV+GVV89eEnU/5sGEbrBVKL9s8y2h678P9Y36bd5w9gYrzHEbZJvz88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145046; c=relaxed/simple;
	bh=SgjYkhTSvrNQobs81bP+X0p5lyA+pnHIZkqQnoIThvc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JcQxeq1mDUccFI/EVckmhVRZDl6M7xXNP3XLJiaWyBSF1J74U3yYk4qjJDlpTrSibVo2F/KPBKPFl8RO5Im+QOwQo/Jd5cp0VKD+8OOuSDc8BFpkXhl8xbMdJMFrINAPvg1K4zIgNmhqA6X2gvlukz0dUl+G/Y5H1EZpA/wC1hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hb8KUVi2; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hb8KUVi2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789145045; x=1820681045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SgjYkhTSvrNQobs81bP+X0p5lyA+pnHIZkqQnoIThvc=;
  b=hb8KUVi2K8eboY3FDPIC97c3/f7CE0F5xk5VayuS/sHX94QReL59vEbL
   L2/OJDl3/2U9MHa2ZgwW/lkiQNRJ7WfsJYG4pUk+a7TuzvdbxcWr4nW3h
   F1FlOPtDTp3xdUO/9WukhpjJUnkqLmm1cUDG4V4ZeYsSCuE1KUtvpJREE
   0ml3YAThPxzTRdV7Tah70lUX30f6N3CvX4zQsCyZch9sRJFWMpQPskNNo
   iB/rZ8E1D04/HpgN+Z2tDy7a4wCbpnkX3EZytOePH+x/Frhzch3SUvS+k
   oxNQoLV81nxOCO7GM3FY0tFUYdeNnkAOWhd5AFVYbLT6UBQYxvEnFa0Vk
   Q==;
X-CSE-ConnectionGUID: v39/LWfwQRSOrqQBX7x90A==
X-CSE-MsgGUID: 1sAC4a9gSjS6gH0WVfgBmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11902"; a="89485133"
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="89485133"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:44:04 -0700
X-CSE-ConnectionGUID: UbMeKaogTO+sadtbQf+J6A==
X-CSE-MsgGUID: 03lti0sPT/mKaqjMZmtm9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,97,1787036400"; 
   d="scan'208";a="296950336"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.80])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 09:43:59 -0700
Date: Fri, 11 Sep 2026 19:43:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v7 09/17] iio: adc: ad7768: Configure channel sampling
 profiles
Message-ID: <aqQvzEmvNEqYMGLV@ashevche-desk.local>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
 <20260910-ad7768-driver-v7-9-7f70b07627e1@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-ad7768-driver-v7-9-7f70b07627e1@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 10, 2026 at 07:36:27PM +0200, Janani Sunil wrote:
> At buffered capture setup, select the fastest compatible power mode for
> the enabled channel rates. Group channels into the two hardware mode
> profiles and program their decimation, mode selection, and data clock.

...

> +	/*
> +	 * The output data rate ranges overlap between the power modes. At a
> +	 * common ODR, the faster mode has lower noise, so prefer the fastest
> +	 * mode that supports every enabled channel.
> +	 */
> +	while (mode_idx--) {
> +		bool supported = true;

Unneeded.

> +		unsigned int channel;

> +		for_each_set_bit(channel, scan_mask,
> +				 st->chip_info->num_channels) {

Make it a single line (83 characters, yes).

> +			if (!ad7768_find_freq_config(st, mode_idx,
> +						     st->ch_freq[channel])) {
> +				supported = false;
> +				break;
> +			}
> +		}

> +		if (supported)
> +			return ad7768_set_power_mode(st, mode_idx);

		/* No channel found with the requested frequency configuration */
		if (channel == st->chip_info->num_channels)

> +	}

-- 
With Best Regards,
Andy Shevchenko


