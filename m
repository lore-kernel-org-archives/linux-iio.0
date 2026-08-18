Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11B41C3BFC;
	Tue, 18 Aug 2026 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787034646; cv=none; b=oOmaLzKudbkrBSlW3+tImD4Ju6DTn6DE7IZO32yct2MLMmL0RiWm6GgCgTKgWDJsFJkg2svKKcPyZu5nNynWbecM8/ioNuJ6XW8HM/ouuC9Yvi1jCnasUkNCyEXqNZWUTVQwLq87q4T7cl9mPeWJs3TJmorHywyB53d8jzVn9p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787034646; c=relaxed/simple;
	bh=6jOR4155Y6Y09n6fK1zJtznYL0gERuCjfwtFR/Lq00M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfsvb1GhEOmHz2KDWo60Uu537PfABfZ8eXKyPFFCwMA7uB2S2V7ESQ/hEMcviPpdYy2KzMG+HLy+jAqLlgVwIEyM1TN3fvSdLHxX93u83g09u0zA0cyqhf6Rh5lffgvJhV6FXBfh/XBMro8PLY3yI1sM0t3RYzTuplVM7oAy2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DzW9nYF1; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DzW9nYF1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787034644; x=1818570644;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6jOR4155Y6Y09n6fK1zJtznYL0gERuCjfwtFR/Lq00M=;
  b=DzW9nYF1BwXYx2W9JO/C21JEPsR6EtXKYqzpIPiIH81wjYo366agb9Gt
   CYoc/vExiqbKBn00OTzlXBeC3+9oYAuPmStCDU7iVqB1dXrmwZ2pSQCg4
   mOfcDLBqIFzRQEg/wqwL5elL/YRBY+s4iQS/zLmUqyZvjtsbK9ANN7eqa
   oEkXj2iBtZ+V0yzBSsA9LdLQvC9RYaS9SVRUkqeI6ZyBcSMtPnkyxJl3E
   dV3/OGbkBzRJ4oHzx37mnsumDMfAxZZQ7NkOaqQ1ibvTt0xkR40S5y4OT
   uodMcS/HSeEqWxi04F7bYykUhwg37Z6BHB7FtlCEYu3UvzrWNOyw7Aqgf
   Q==;
X-CSE-ConnectionGUID: dXQj5XYzSJCL7tC83z0RTQ==
X-CSE-MsgGUID: QLxlxXaqSpOsm2Uw2X0QJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87373083"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="87373083"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:30:43 -0700
X-CSE-ConnectionGUID: VF/nDYMARaqC27JhLtgE3w==
X-CSE-MsgGUID: 2Ce/Rt6lQ8WGGS2kF9BSPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="261851098"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 23:30:39 -0700
Date: Tue, 18 Aug 2026 09:30:37 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Taha Ed-Dafili <0rayn.dev@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	skhan@linuxfoundation.org, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 6/6] iio: dac: ad5504: support scale via
 output-range-microvolt property
Message-ID: <aoP8DQitMiLOSOor@ashevche-desk.local>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
 <20260817211118.21833-7-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817211118.21833-7-0rayn.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 17, 2026 at 05:11:15PM -0400, Taha Ed-Dafili wrote:
> The AD5504/AD5501 output range (0-30V or 0-60V) is determined by the
> hardware R_SEL pin and is required to compute IIO_CHAN_INFO_SCALE
> correctly. Previously the driver derived this solely from the vcc
> regulator's configured voltage, which conflated the supply voltage
> with the DAC's actual output range and offered no way to express the
> range explicitly in firmware.
> 
> Add support for the standard 'output-range-microvolt' device property,
> validating that it specifies one of the two supported ranges (0-30V
> or 0-60V) and using it to set st->vref_mv directly. When this property
> is present, the vcc regulator is only enabled (not read) via
> devm_regulator_get_enable(), since the regulator's actual voltage is
> no longer the source of truth for the output range.
> 
> For backward compatibility with older device trees that predate this
> property, fall back to reading the vcc regulator's configured voltage
> via devm_regulator_get_enable_read_voltage() when
> 'output-range-microvolt' is absent.
> 
> Use device_property_present() to explicitly distinguish "property
> absent" from "property present but malformed", rather than relying on
> the -EINVAL return from device_property_read_u32_array() as an
> absence sentinel. That return code is ambiguous: it is also returned
> when the property exists but the parsed array size does not match the
> expected length, which would have silently and incorrectly routed a
> malformed property through the legacy regulator-voltage fallback
> instead of surfacing a clear validation error.

We do not need a Dostoevsky novel in the commit message. Please, make it
straight to the point. Don't blindly use AI, you should understand what
the code is doing. Same comment to all commit messages in the series.

...

> -		st->vref_mv = ret / MILLI;

So, the change from 1000 to MILLI is in the line that is changed again in this
patch. So, no need to change it earlier. And again, it should be (MICRO / MILLI).

> +			st->vref_mv = range[1] / MILLI;

> +			st->vref_mv = ret / MILLI;

-- 
With Best Regards,
Andy Shevchenko


