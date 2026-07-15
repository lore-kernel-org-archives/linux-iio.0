Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC7313283;
	Wed, 15 Jul 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097146; cv=none; b=hmMuCUkR420EtdjvR0wCGThlG+haGCQVaF+QBHS8IKoXqjc7nJAAa2dt7FJ9oxFaFvqRyAqJScjqyZiE1sUFeOvlbfGFa2fnAgvGTNmenPHUt4wwiD+jH9ruL9nD5VkLnQHRQkTsEyVoYotmA2uA3B4FWvrd9XZkOnpziJAIS0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097146; c=relaxed/simple;
	bh=RgFSZ4GcQNxSGk/4lQiMQnPxmHi1gAvKmjEWlI5TUMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lynxQIEOGTtCroC/NLEeIJfX9UkGQ57sfPKj+4wUlMgyjCbPNkaXFwQMFpRlyp1Jrcki+U8pPKJoBnLAH9nQIY6oJj1Lz5TVZJ2jxMzrSFXyd6XIsUCCxRgax+gq4b2TuF+0CbyTlm/zwlzqOiXXNKeEAe2++hnkzky4Gaf+jWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q2TbwCJN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q2TbwCJN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784097145; x=1815633145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RgFSZ4GcQNxSGk/4lQiMQnPxmHi1gAvKmjEWlI5TUMQ=;
  b=Q2TbwCJNmrZaYb5Qd80ZDc5UTaurU4mwkq6Hr4uRF5QPJjMH3HPmqKD6
   PkA6QyAg+tfpSNxNU/YH8Y7qRUKG8+I8vSRlzHnLpbAXuSxbicotmPbFF
   GhdDu0MtcTlWMH9wB4aevZf7F0AGV42vKz36ZxbibDz1mVnnAWHq0FRWV
   If7ua3SEV21gdOqIKOqBdA53Q8GZ0HaejxsJqSFaiQXjJon3ne554HiDp
   adiX5LK5SzXSXgNsd2/LS34f2pmVL9mksMsaqtmMjorF2RJDiUatAZqDA
   gZDPtaTHePRD+YmxK1AycJ0aW4jcZqqkhgqNhW5adMNHLLr9CBa3vTQxy
   w==;
X-CSE-ConnectionGUID: +LQO0EBGTcyfoHYW7ufkIw==
X-CSE-MsgGUID: 09u5F7t1QVynrWvNSIzYhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84842206"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84842206"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:32:22 -0700
X-CSE-ConnectionGUID: 0DPTEpseSdSJFiU6iNrQpg==
X-CSE-MsgGUID: fImbR2beQzyJHFlgMfVyjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="254332119"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:32:18 -0700
Date: Wed, 15 Jul 2026 09:32:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 07/17] iio: test: add kunit tests for channel prefix
 naming generation
Message-ID: <alcpb-7GVSfk6jFB@ashevche-desk.local>
References: <20260707-ad9910-iio-driver-v7-0-a4ec30f63700@analog.com>
 <20260707-ad9910-iio-driver-v7-7-a4ec30f63700@analog.com>
 <20260712020928.2c8d1667@jic23-huawei>
 <egyms7ulkxsgu4pvfkoruelec3sf6ca4bndcuqkvxljrdluqwu@edlqne7oy3xs>
 <20260714180812.000070c4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714180812.000070c4@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 06:08:12PM -0700, Jonathan Cameron wrote:
> On Mon, 13 Jul 2026 10:52:56 +0100
> Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:
> > On 12/07/26 02:09, Jonathan Cameron wrote:
> > > On Tue, 07 Jul 2026 15:04:28 +0100
> > > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

...

> > > > Because __iio_chan_prefix_emit() is static, the test translation unit
> > > > is pulled into industrialio-core.c.  

KUnit also has static/non-static automation via a macro (defined in the
kunit/visibility.h) and I see that's used in the below example.

> > > Isn't there some magic route cases like this that makes it non static
> > > only when self tests are enabled? 
> > > Claude tells me to look at include/kunit/visibility.h  
> > 
> > There is, Although I think that using
> > 
> > 	#if IS_ENABLED(CONFIG_IIO_CHANNEL_PREFIX_KUNIT_TEST)
> > 		#include "test/iio-test-channel-prefix.c"
> > 	#endif
> > 
> > was more straight forward, less invasive and easier to change than..

Maybe, but thanks to this thread, I fixed other modules that use their own
approach to use the standard KUnit infra for this (as below).

> > 	/* In "drivers/iio/industrialio-core.c" */
> > 
> > 	#include <kunit/visibility.h>
> > 	...
> > 	VISIBLE_IF_KUNIT ssize_t __iio_chan_prefix_emit(...)
> > 	{
> > 	...
> > 	}
> > 	EXPORT_SYMBOL_IF_KUNIT(__iio_chan_prefix_emit);
> > 
> > 	/* In "iio_core.h" */
> > 
> > 	#if IS_ENABLED(CONFIG_KUNIT)
> > 		ssize_t __iio_chan_prefix_emit(...);
> > 	#endif
> > 
> > 	/* In "drivers/iio/test/iio-test-channel-prefix.c" */
> > 
> > 	#include <kunit/visibility.h>
> > 	#include <iio_core.h>
> > 	...
> > 	MODULE_IMPORT_NS("EXPORTED_FOR_KUNIT_TESTING");
> > 	...
> > 	// Use __iio_chan_prefix_emit() in tests
> 
> I'd rather this wasn't built into the core module.  So prefer you jump
> though those hoops.

Hmm... The above (while being verbose) is the standard way of how we export
symbols for KUnit tests. Do you have a better alternative that everyone can
use? (Not only IIO subsystem.)

-- 
With Best Regards,
Andy Shevchenko


