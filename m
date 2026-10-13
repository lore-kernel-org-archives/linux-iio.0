Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526B553C3D0;
	Tue, 13 Oct 2026 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918618; cv=none; b=gFkEGIgHCv3ag4oknPNYBLKkq/O7l3aYvqvxKI1Zim6F6d/PUJ8tIN4yxHjW0BbDLneQWvJSMlZijaBmmc0YTTH7TbhJoNfl89wz3hDFm2SQFHswbkE/P/VJ7+WN6IzPDu1HEhfOD6tqlNaynfpnfvCCFmtwrpCjcthM3R5M3OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918618; c=relaxed/simple;
	bh=k5J5sYDm1WpixLDPo6IWZrMHmPPhpzYkFJtt0x2fyjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E3FGt40cSLSfwkjg4WnEWfmGM5n2YL1FKf8EPnDQ4X8VvxbV8lcOZMTSNkt9P7RB5MRzob7KFNr8WTpyQRd58AENhmIMwmcUkv+VjxE0eS9RUGVFbrwp4USD3khUGvlKzAjeevvrFenHzm9ilQF0gyD0jaS5ePwP4mMKH6uYPTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rwi2orL2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rwi2orL2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791918617; x=1823454617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k5J5sYDm1WpixLDPo6IWZrMHmPPhpzYkFJtt0x2fyjs=;
  b=Rwi2orL2lyoBcufQYe34eDxuTM9t8eCBWQEofoPuVudYGPh9grOjmUNJ
   HRJTmxJD1RaIlZGIZ2HCMeSiJV83yO/yH/CnzCJ5Zhx/FhyMkL34yp8rN
   Xj+kkz6p932vb488xHT3n5dyxSWL8euSlEZRMd0xz/X/qLIknhRUk2G8q
   ifjE5qKQdnuqTOlu3rpymhEfohGBF9/pwzAiBi03kDrJMKKexKgF2bgol
   nyha62Ulp33zpbPVIjnVPqAbCQE3W0BAhsJGDd48LU1GkAJRK+pudeWZ/
   2oE7D08Yu5VGG6Gu5UiJ5HZwAtZeoO5Irn9BkrbOi7oMSm85pYH1a/++X
   w==;
X-CSE-ConnectionGUID: fhibYaRKT7KRs3jyhR1qhg==
X-CSE-MsgGUID: gNkUkiS6Snm9JKeUj3dLaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="661609"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="661609"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:10:17 -0700
X-CSE-ConnectionGUID: ift1l/QVRciaZpFVslV2YQ==
X-CSE-MsgGUID: YK0AieNmSl6ltkVzuUQSHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1243597"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 12:10:15 -0700
Date: Tue, 13 Oct 2026 22:10:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH RFC v2 4/4] iio: test: add kunit tests for channel info
 writes
Message-ID: <as6CFEHp1_69JGWL@ashevche-desk.local>
References: <20261013-e-notation-v2-0-d4adb5e193fc@analog.com>
 <20261013-e-notation-v2-4-d4adb5e193fc@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013-e-notation-v2-4-d4adb5e193fc@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 10:36:47AM -0300, Rodrigo Alencar via B4 Relay wrote:

> Add a KUnit test suite covering iio_write_channel_info(), the sysfs
> store handler that parses a channel info value according to the format
> reported by write_raw_get_fmt() and hands it to write_raw(). The
> function is made visible to KUnit through VISIBLE_IF_KUNIT and
> EXPORT_SYMBOL_IF_KUNIT, so it stays static in regular builds.
> 
> The suite uses an unregistered iio_dev allocated on a KUnit device,
> with stub write_raw_get_fmt() and write_raw() callbacks that select
> the format under test and capture the parsed values. Cases are grouped
> by format:
> 
>   - IIO_VAL_INT: decimal, hex and octal input, decimal fallback with
>     truncation and E notation, and 32-bit range checks.
>   - IIO_VAL_INT_PLUS_MICRO / IIO_VAL_INT_PLUS_NANO: sign handling,
>     truncation of extra digits, E notation and malformed input.
>   - IIO_VAL_INT_PLUS_MICRO_DB: optional "dB" / " dB" suffix.
>   - IIO_VAL_CHAR: single character input.
>   - IIO_VAL_INT_64 and IIO_VAL_DECIMAL64_*: 64-bit values split into
>     val/val2, including the S64_MAX / S64_MIN boundaries.
> 
> Further cases cover unsupported formats, the default micro precision
> used when write_raw_get_fmt() is absent, a missing write_raw(), and
> error propagation from write_raw().

Please, add 'dBm' to the test cases.

-- 
With Best Regards,
Andy Shevchenko


