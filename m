Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5B52D0C82;
	Mon, 24 Aug 2026 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583278; cv=none; b=GWPbUEKC5z7/+uicr9+LDV3JUiOeO/4jnUVj+P+KLEX1M85A0PmCrL7HxFWd2ZP/E87De9YSsb+Sizf4kpZgdSF6T3U9wTzUSmc5jgwW4z/Wcbo/6aWVBRZCIaVHTTnb1l1al3sL+494nj2nbDohhz0wcp+vH2ttYUo3evYl0LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583278; c=relaxed/simple;
	bh=OHMDX2xLhq6CI4i0NCsCCHEP/m+my8GmIBzpa37z8Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obBueRrOQyupVdqkUY1yv2mAlbpwoGv5w+UHzOg97+8rhTohBv08tCEKV7qwUmT5RzwrpKtHi0hZSU/kT8PNfohGhXNgCHb1ElZHXcr9QeCmfKXZL+MoKeTaOs1R4Xsfs4ASBoxx60n4ry0HSkpClzck26tVtk2lD/MP92LajG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gVC2NiOY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gVC2NiOY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787583276; x=1819119276;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OHMDX2xLhq6CI4i0NCsCCHEP/m+my8GmIBzpa37z8Gg=;
  b=gVC2NiOY4IosUAmRKXMWKr5B6dkxAy78H5A10+Php0P/3e6JI6f1E8+O
   tAOp9HVyYLXyH2MhmDSl1ZT9f2NismINAT1kkUvO0Lws7SSpmWKeyg/Rf
   1R0LM1qbzJYRRxYP7onzn5rqxhs7JED4LdydEBES8T22+++4jmUhdCplk
   oDqcQqhWby9e9vjYZBcBWulaOK/jidfCb9AEZ379ZGk0g10eMo+Omdvvj
   MDQefvRVW1DxVxlQUZiqLYGzfsQ7SiXuHslXHmqeFp9XqCKqAxU9VCBq5
   DIdVwVrVEqunkpLKnBA4g3NRr2f80NqTClF+ffVPfT6JEhWEfXo+nfo/Y
   w==;
X-CSE-ConnectionGUID: S//V77wWRFCT4yjo3jqkHA==
X-CSE-MsgGUID: U07K4uu9QkyCyNOGJEdE2Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88161608"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88161608"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 07:54:36 -0700
X-CSE-ConnectionGUID: +X9SHcHtSOGo0ixGmHV0eQ==
X-CSE-MsgGUID: a/ylGkoKTmqDCb8W10S41w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="266495044"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 07:54:33 -0700
Date: Mon, 24 Aug 2026 17:54:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <aoxbJzV5OQ839gAN@ashevche-desk.local>
References: <20260824051026.11049-1-salah.triki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824051026.11049-1-salah.triki@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 06:10:26AM +0100, Salah Triki wrote:
> ad4030_set_avg_frame_len() computes avg_log2 = ilog2(avg_val) before
> validating avg_val. The existing check (avg_val < 0) allows avg_val == 0

Try to write the sentences straight to the point using plain English,
Avoid using C language as substitute of plain English.

> to pass through, resulting in ilog2(0) being called with undefined/garbage
> behavior.
> 
> Reject non-positive values (avg_val <= 0) before computing log2.
> 
> This issue was identified with assistance from Claude AI and manually
> verified against the code.

> Changes since v1:
>    - Added note stating the issue was identified with assistance from
>    Claude AI and verified manually.

Assisted-by?

...

>  static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
>  {
>  	struct ad4030_state *st = iio_priv(dev);
> -	unsigned int avg_log2 = ilog2(avg_val);
> +	unsigned int avg_log2;

Have you read my comments to the previous version?

>  	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
>  	int freq_hz;
>  	int ret;
>  
> -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> +	if (avg_val <= 0 || avg_val > ad4030_average_modes[last_avg_idx])
>  		return -EINVAL;

Ditto.


-- 
With Best Regards,
Andy Shevchenko


