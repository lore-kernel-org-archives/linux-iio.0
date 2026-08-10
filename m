Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D3A42DA2A;
	Mon, 10 Aug 2026 18:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786387475; cv=none; b=a8Dwg3URrcWMhlAtiZJ/qH8oiRJTrs5jzihyYeBtnumdW+4+Q6C6T2o0H2axiPjHzu2Alkmak0GfTqLkYOHDCh4R+wcD5TvIxWSIcTdh50SwyomrkVkNvlUbU3NQanVqxtdZv2NJxzf3CfbPf3JX5QHre3Ix7eA+A4iL5RX6Yjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786387475; c=relaxed/simple;
	bh=4yLLnwp0xDNkm/f5GVFH1NaPXOFvOBG3Dn+UzsCOS44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nHvp+3aqNoRYH107NsJ7Bp1QktHHj6aBRxsUnD86vNOgRotY4LseUPKrGsiKTkDCZwUOV1K2YkPq7saVKdkg7f0vpGvZSrKCtlcJ12AeOj551Ofa+VN6oZQ+WF5XoUQFg+n2E8Uewy7MiURSPUrdv5MsVT+KdWbW6+xiQHjGenI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JXzdgC9S; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JXzdgC9S"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786387473; x=1817923473;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4yLLnwp0xDNkm/f5GVFH1NaPXOFvOBG3Dn+UzsCOS44=;
  b=JXzdgC9STlSMw7+has6avV8j+y9tyfcaipJ61i0l+l0U4M4QYrkDFVPR
   D8imy0AXWsAeVJ65Xr2kw+h83gzWXkBi5eD7YJ2JC+MjJf3Nssafd/eTF
   Ch6dwdpYR7LEDraJsHAVTnuZSsuEhgwoIK8D7iKShfoUrlAvKhuLMcIZ7
   Gr9zlLvpGXXCPmY7LctMyhB578A3i94BVqc5lnxYajduNjh69p1LBI+DH
   Vy1azhz5Hqp/ASe966AgKtTZfz1nJvJTT8OGmRsJnY18Lo4Idme9NX4md
   17zOvnikaoerYIeFvoCbjb7SaKN3xCc9YGlf8QsQbfqKiLzLKnfedF27a
   Q==;
X-CSE-ConnectionGUID: 78Jb20HcTZ6rVqTdYG0V3w==
X-CSE-MsgGUID: bMwH5mSIQnGNibpxEBbzow==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89437339"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89437339"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:44:33 -0700
X-CSE-ConnectionGUID: c/4/lkPDR2qdwzdjko1kMw==
X-CSE-MsgGUID: 5+gkzdf8QHikxFO8ybLBzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="259811498"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:44:28 -0700
Date: Mon, 10 Aug 2026 21:44:26 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, marcelo.schmitt@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mike.looijmans@topic.nl, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, jorge.marques@analog.com,
	antoniu.miclaus@analog.com, mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com, duje@dujemihanovic.xyz,
	wens@kernel.org, sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH v9 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to
 ti-ads1100 driver
Message-ID: <anocCvybqPKWV-cT@ashevche-desk.local>
References: <20260804192840.29121-1-jakubszczudlo40@gmail.com>
 <20260804192840.29121-4-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260804192840.29121-4-jakubszczudlo40@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 04, 2026 at 09:28:40PM +0200, Jakub Szczudlo wrote:
> Add ADS1110 support that have faster datarate than ADS1100, it also uses
> internal voltage reference of 2.048V for measurement.

...

> +struct ads1100_config {
> +	const char *name;
> +	const int *available_data_rate_hz;

We have a trend to make units case-sensitive (as it should have been from
the start), id est _Hz here.

Also no need to resend, hopefully Jonathan can tweak this (and its users).

> +	const int data_rate_count;
> +	bool has_internal_vref_only;
> +};

-- 
With Best Regards,
Andy Shevchenko


