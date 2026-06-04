Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF610395AD0;
	Thu,  4 Jun 2026 19:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780602334; cv=none; b=DE0xUpfaZnsI1k55IXS3v10o5kaKUHpuRM4M+pw+TQFWzirajGiwtT3fZnFlPMXJyLMzwXpRMxIQvT4IK3GyN6mDyOAsdKwDgHJunNqy20RZl6h3n9b7uLiYbSzVDOCrbLBRmSBIfb7XyQ30ihTVVWCwnLM5mpYAdbSfjhPMves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780602334; c=relaxed/simple;
	bh=WMK4bTHC4COjtMnoY/gx2o8LNTtg032vV51R4f5uW8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/YR+KUavFKpei8f9fgmBTVyIES0/0hsqVLFQg+ep0PfpicBSHxRvEF+TFzDMXHffEs8ea51CDzxr54T5jqIy0FpTHqUurfBnjNm4J726tt0WYxoXD6ubn123zZ8f7OXwXHEPWO5AgUMc81250wz9maofiMdTkSFUzJ6yO6E5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mIRbuqU9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mIRbuqU9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780602333; x=1812138333;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WMK4bTHC4COjtMnoY/gx2o8LNTtg032vV51R4f5uW8M=;
  b=mIRbuqU9WrU2mSUQ1KNcQLyLiAtCWGfj6XlVmHZchz/HYyNCGXxo5cgl
   ejlrrEzW6kysRli/bdq7w0AoULCox8MF4WvMDckDVWRrhVOvGvTR7iObH
   AooueErGMeBp+pjF8HPh8y2RmXfZyqX7ShuEipJ2M89EIH5X1lhEldO1F
   uSj7XVsRl4J4RFt54ggbj15ayCvHAUADSQcbvHpjUoDmXb+1jRc42/A/k
   igr7zrYU9haPMr/TYyIGfiYfd4URt12zFzIgntONdjX0orrKsf6NamBAq
   caKTeC9nL5+5aODnEgrqOFCpo+pvXDBoh7OBvLIv2T068umq/dtE3UaI2
   g==;
X-CSE-ConnectionGUID: f3eoZS6vTQyo/3kdSf2qvg==
X-CSE-MsgGUID: rh9scg5hS8u201ur2CRt0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="104098246"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="104098246"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:45:32 -0700
X-CSE-ConnectionGUID: K9iRRo49QZ2J4PScV7UK5Q==
X-CSE-MsgGUID: a9Y12UIwSDul6vSDZvMz2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="241650755"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 12:45:27 -0700
Date: Thu, 4 Jun 2026 22:45:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
	linux@analog.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Mladek <pmladek@suse.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v16 09/14] iio: test: iio-test-format: add test case for
 decimal format
Message-ID: <aiHV1VnTAy3fOHbh@ashevche-desk.local>
References: <20260604-adf41513-iio-driver-v16-0-1a7d09143bc2@analog.com>
 <20260604-adf41513-iio-driver-v16-9-1a7d09143bc2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604-adf41513-iio-driver-v16-9-1a7d09143bc2@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 04, 2026 at 10:59:03AM +0100, Rodrigo Alencar via B4 Relay wrote:

> Add iio_test_iio_format_value_decimal_64() kunit test case for decimal
> value formatting, exploring different scales types. Also, the same
> iio_val_s64_decompose() helper used to populate local array is used in
> iio_test_iio_format_value_integer_64().

I missed that. Always fond of test cases!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


