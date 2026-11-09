Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253419;
	b=gpfjM5wS104Bf7xJyK0tuE6ulbnEEi3Q1nhEpAAXJZV9wSW7GjqI9LGJNvRDoYyPxTNs
	 W/eR10R4PdsCfZliDw0mPnN0oTxHQ/i+yzX91SOTVj9PiL1Gzs7Z6FdH6pYzJT/JOaHHc
	 fLWmBygmKHmRgey9DozuJ3caAonAxwIsXEJSyvwOOHdAaplHjRU/XYlTYfWBEOW0fA58k
	 6g4O6WqqiNxylRPP9RNZ3L1h+nuJqFjH1f4NATgN/aLdCFm/06pR43A146eg6l0Q4Rnw1
	 i838HD46IaG0LX/ccWYnJEtD/sSihcYP+3aIsW8f3JDa+H4c7rkicUPQxk7ZpkMNdog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253419;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=4tzUHAD8cISFdwg6X2KpZ+wQl4rMETW33aQlL9cOx/g=;
	b=RaXdfeZ46ifcVbsOKSiOW8fOms3mCqsrYHB79BXKmWa0NIAAjbtw+uYxJEjfg2fP5vwU
	 kzfK/XGmr2LPfa/yKpHFya0nUcZOkFQhf455crd9mHOIsAEJht90MYF71qYey3j7GutYJ
	 JrcWsOf3IrL88OGbB5v1cQWV07rPLWxOwFmFL8855I38xDLTznFCIHO2iYfdtkSaldS9M
	 AYTOnYWc4XN8xNjYWuOjPTtbtnGcsqeX1rfF0lVB12mcaeOfjPcqDysIZY09xD9ygvkJA
	 5wFVWb0ZJgsadyhug98GFKT9JMHGXjtPep8o2OM2l8oUYEl6/FuD+owEsHZvYDIDCPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHEtR6oj;
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63E1606A321;
	Mon,  9 Nov 2026 19:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C63E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eHEtR6oj
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794253419; x=1825789419;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+R4YXXYgFDCqdcIFqhh4oFRdTM2C01Lzsqrhf/1eWbI=;
  b=eHEtR6ojlBtCqrK9jkH+VDRjeQJJ8wT+/Zxp1/crgM8HexEa4/YzBToU
   F+QPmEKNJ5jzJfMxAO+/kOK5xGSazjWOUqdbzBs3N1ImRMzjIhQBMOj95
   hPT75pNX2uAqqHH0WT7lMYWMKgKBxCYGYKMV6f/P1XOWJg0VOm3ABmVgB
   A6g6BmAlRE10t2tg5vLjRrB5nym2niuzTdmry7BYKtSuULqLW85EnGtAh
   gv/Ap7yNH3rlY6oRQRH2jmy9yH1DfPmwfZHjDCNSX7VAnYq5DV4+8zGoF
   zJhMat30xV837NMWp9kDbxQaBYpCBXGEqBJypnVQZsk1q1gWP0lUtO7QQ
   Q==;
X-CSE-ConnectionGUID: 0jLAi8bVRBiEZQcr7pECOQ==
X-CSE-MsgGUID: w4dJjzUAT+iHNF7aWRDSOA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2887305"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2887305"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:43:38 -0800
X-CSE-ConnectionGUID: X/wz/UWXTCSXCnc64O/XXg==
X-CSE-MsgGUID: rha019tmQteNnHwzERLfyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8116064"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 11:43:36 -0800
Date: Mon, 9 Nov 2026 21:43:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Archit Anant <architanant5@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, andy@kernel.org,
	nuno.sa@analog.com, u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 11/11] iio: adc: ti-ads1015: Replace custom shift
 macros with FIELD_PREP/GET
Message-ID: <avIiZfJtj0DTArWR@ashevche-desk.local>
References: <20261109165805.31160-1-architanant5@gmail.com>
 <20261109165805.31160-6-architanant5@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109165805.31160-6-architanant5@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 10:28:05PM +0530, Archit Anant wrote:
> The driver currently uses custom _SHIFT macros and manual bitwise
> operations to read and write to the configuration register.
> 
> Modernize the bitwise logic by replacing all manual shifts with the
> standard FIELD_PREP() and FIELD_GET() macros from <linux/bitfield.h>.
> This improves readability and prevents potential bitwise errors.
> 
> Remove the now-unused _SHIFT macros from the top of the file.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +		mask = ADS1015_CFG_MUX_MASK | ADS1015_CFG_PGA_MASK |
> +			ADS1015_CFG_DR_MASK;

Indentation is broken here.

> +		cfg = FIELD_PREP(ADS1015_CFG_MUX_MASK, chan) |
> +		      FIELD_PREP(ADS1015_CFG_PGA_MASK, pga) |
> +		      FIELD_PREP(ADS1015_CFG_DR_MASK, dr);

-- 
With Best Regards,
Andy Shevchenko


