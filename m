Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3A3A0E80;
	Tue, 14 Apr 2026 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776161082; cv=none; b=bqh303IIYsTR8WsUlr9k5xp/M879iSm4/zay70LPh2L/hWf9MksiyyJbyTFM4fVLwfFYi7N2DgL6IF+G1kKySBKGBQqbjHwidYWcXanulAg5CWxlPlsXqaS+/uK3EclsgUpTBx9OYUQ6zT1alyQRd+2SpVD8dKddmeyv+0sAIZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776161082; c=relaxed/simple;
	bh=p7DZIoBmA2wN6KmMdoSx188+rw4x3RljsLKbDdiYkbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyiM9Fex7K5lCXsZyOQI0sY+aaguM/WVw8mLFWl5f7HFsdObQBeIDLzWrsH3XeiUbjqCJoaNomzA0lYKBH2Y2X5AUpPSEsNOIJ314Wr7NwoyQvOOLgV8rtttdUC7Dpys//vEE4X7TRHfkhDM+GVi6MOOGCBo69y9cV5C2O6DZkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WY5LRmw+; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WY5LRmw+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776161080; x=1807697080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p7DZIoBmA2wN6KmMdoSx188+rw4x3RljsLKbDdiYkbU=;
  b=WY5LRmw+ivY/HG0ony4n0UNldqxAwC6rFMGRbvtPP2y1WvoJEinq6mia
   2vSfKCP6ZZexhEuZVZO1no0C/ge+INjI5cgzZjgk6D9uZG4kkfMo8LU+H
   rk5m2GSYHPX46OHC8AWCDeJykp6s6r/UAdv9McXGjmuSJ/LCeP9d7cvEF
   asbYJmZbViXXfORU92F+JJQTFL6eTJkUsA5NH2qszI7i0M9kvJVR0ILze
   0z3m/Uurm5pYmcY9gaIymRVIuiWZ6u9+GePd7zFz6hTWtLcF8JTK/imNA
   Q3NBO74eIcyREj0z7nAt9syKqKJwECepzL791+Vf/zucm1BILCJCVv4a+
   Q==;
X-CSE-ConnectionGUID: 7XlJ2283QSWqBWAlhI6YmQ==
X-CSE-MsgGUID: W5jxvUnMTbuRoUBO25TtrA==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="77081706"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77081706"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:04:40 -0700
X-CSE-ConnectionGUID: 8F7NurjgTN6hNLEO3PwBiA==
X-CSE-MsgGUID: 7AMoNrw/T7uzfd7ALaW48A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229926197"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 03:04:37 -0700
Date: Tue, 14 Apr 2026 13:04:34 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: adc: xilinx-ams: refactor alarm mapping to
 table-driven approach
Message-ID: <ad4RMqwGR3Mya0vY@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414093018.7153-4-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414093018.7153-4-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 06:29:30AM -0300, Guilherme Ivo Bozi wrote:
> Replace multiple open-coded switch statements that map between
> scan_index, alarm bits, and register offsets with a centralized
> table-driven approach.
> 
> Introduce a struct-based alarm_map to describe the relationship
> between scan indices and alarm offsets, and add a helper to
> translate scan_index to event IDs. This removes duplicated logic
> across ams_get_alarm_offset(), ams_event_to_channel(), and
> ams_get_alarm_mask().
> 
> The new approach improves maintainability, reduces code size,
> and makes it easier to extend or modify alarm mappings in the
> future, while preserving existing behavior.

...

> +#define AMS_ALARM_INVALID		-1

This value sounds like out of the range, also signed.
Can't 0x000 be used instead?

#define AMS_ALARM_NONE			0x000 /* not a real offset */

>  #define AMS_ALARM_TEMP			0x140
>  #define AMS_ALARM_SUPPLY1		0x144
>  #define AMS_ALARM_SUPPLY2		0x148

...

> +struct ams_alarm_map {
> +	enum ams_ps_pl_seq scan_index;
> +	int base_offset;

With the above we put this as u32 (or whatever is used for offsets).

> +};

...

> +static int ams_scan_index_to_event(int scan_index)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(alarm_map); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(alarm_map); i++) {

> +		if (alarm_map[i].base_offset == AMS_ALARM_INVALID)
> +			continue;
> +
> +		if (alarm_map[i].scan_index == scan_index)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

-- 
With Best Regards,
Andy Shevchenko


