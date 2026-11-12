Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499576;
	b=ZWkpAhKIyXP4/e0DouIiewT7JqX3CI6WaBEwy0gjaeF1lUZCVq8d/OwNsdNdv50HKV9n
	 YJhs+yGIYxD17kkZbr0MmIwTy1/EE0g9Vfne+fZXUC6Xet1wMhwM3ZV2XJsmhPwdDpA9Z
	 FnhiVtKVlknF51AHhISt9uIGrCY7Ljx9IlljKRSzZqJxLWZjYJws947WKxDqLmXji+7RP
	 eRVcMNJHnC4XtIDp86QivGihGRqI49n9S6stiX2s9fmNz/AOg/rxN4mF29gYu+KjM/nQ2
	 EVh0wbdiZtloLbq7jsk1Finp97C35A62llUlRKUk8hYjCY7dj1St+Ji9DCrZz8wafUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499576;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=n6bZ12c38+MSydyqKD0TsjoCHDLoSnN1/IQ7uLFiOUQ=;
	b=rMptGhJF8wXy5IBdwDxgUVEBR7En/ICD92aZMOkbgmSbW8KcCo023MiruKZvXljfMkbs
	 /07D6H2p1rKAumey0dXV3E8DWCY7SCib0NqYeY6/yPThzwCZQjcqC6GizrUSpmYZysj/G
	 R+WMRFcAPbBoz/U4QDbzXLItVMO3mLjxGK9wAOILTjnmffCE3+SlU9PoLuqxAnxHjbkLG
	 22+Zo67Ka3pnqjDvD4uMWSWrB8agcUXi6smRlwHuDQ6eM44ulvwLTUptN9aG4/qkQ2qtt
	 t+3XWEOAD7ZtsdKOF9gy0/nJAhU5YCOo3RUwGoGn3ZtRiO3UV0dBVZ33vcZdK2zBbNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=joUlVNeo;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B89606A881;
	Thu, 12 Nov 2026 16:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7B89606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=joUlVNeo
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794499576; x=1826035576;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FCbwcS+VSOrqaclkby+6/25tWegvBmYfdZm+0n5A234=;
  b=joUlVNeoiMCmyk9oNerOiSFkSOCmhw43UAD3IxshfpWjFJMNvxKSYnqy
   gaRg+HxJS3/p/JHMN8ElExYoJbk5c9+E7vnKxDZ4jr9uVJqhgRuqx8Nl+
   PI8ZYWoJJaMgsSCNyXDsYts5wFYQNUyltd1Eg662aQVDEUm6rUK8I6out
   o6gk3BV7GX7o6WXJYmq5OFaOwrxhy3ipjAW9SluwARplkI6f+lg1vJmdn
   7Xmttsq5l75xYZoqDmJ616pmxDakLSDJdqsBd3mLc/S+NncMB1nRUTtC9
   FtsgAEaKiYz2AA9LaPXNmjo6aP1HsI34J1/YrN8ssY/STqcniDWWV4UGE
   g==;
X-CSE-ConnectionGUID: 1YBJVSWrTdqzsLtqJhmpAQ==
X-CSE-MsgGUID: 9gfNpxWkQC69mhflpJTeFw==
X-IronPort-AV: E=McAfee;i="6800,10657,11964"; a="3184215"
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="3184215"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:06:16 -0800
X-CSE-ConnectionGUID: olH4cjeiRvqau/bz04eG8w==
X-CSE-MsgGUID: DQO+3xQXTPqO9dtb1sA1XQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,210,1787036400"; 
   d="scan'208";a="9017284"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.6])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 08:06:13 -0800
Date: Thu, 12 Nov 2026 18:06:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Zhu Jun <zhujun2@cmss.chinamobile.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	crofts@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: temperature: mcp9600: Bound thresholds before
 scaling
Message-ID: <avXj8xuuITKgjbd6@ashevche-desk.local>
References: <20261112015738.115833-1-zhujun2@cmss.chinamobile.com>
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
In-Reply-To: <20261112015738.115833-1-zhujun2@cmss.chinamobile.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 12, 2026 at 09:57:38AM +0800, Zhu Jun wrote:
> mcp9600_write_thresh() multiplies the integer part by 1000000 before
> clamping to the supported temperature range. The multiplication can
> overflow int, so a request such as 3000 degrees can select the lower
> threshold instead of the upper threshold.
> 
> Clamp the integer part to the hot-junction range before scaling. Keep
> the existing final clamp for fractional values and the narrower cold-
> junction range.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +		val = clamp(val, MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,
> +			    MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);

In such a case I would wrap on a logical boundaries:

		val = clamp(val,
			    MCP9600_MIN_TEMP_HOT_JUNCTION_MICRO / (int)MICRO,
			    MCP9600_MAX_TEMP_HOT_JUNCTION_MICRO / (int)MICRO);

(but no need to resend, let Jonathan to decide).

-- 
With Best Regards,
Andy Shevchenko


