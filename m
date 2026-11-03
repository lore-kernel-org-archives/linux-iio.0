Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724762;
	b=3e30BRKJFzz327S8v3t6NbFWT75SL27C20akafrsABp/CvwfZhhv+uSEEzRncmXCHVJj
	 KDBjmZy7IzoO/kvl9EwQbTjlmw8xM863/9EMChvm2D8aHg+qGDkI0nDY0dKTAWUKqPpzA
	 7YLDWoNaO0EC0EJ+tuIeT2FV19SCZEK8edK0w5pvpW0nuGZ1qaqtOVDmYvwXWhn37qfJy
	 xN+NvjL+Rq74etVeygd2yvXcVaov2Y46ab0URGNo+g7Gm8pPKhRBAI2qA6dZ0zJyv/YgZ
	 4AcUDkEx5Nk4YDUNK2/6RwRqaNnUBOr84BBSpgg+xL6qiEZzt2Z7AbV9uPy5ez2KrKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724762;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=eq9RBFV4mF9vmsivc1/ScTryAoUmzQgiPi33oC80fC8=;
	b=OiKE9W12ul2or+b5z4Li3MhGvJ460l94WoWjz9epsREfsR4t8kCYUb75NILXFpDToqBW
	 EHoN46YeOjWD2prLrwIWWtyDnHLtrWmaWrqPRoZB4DUCRz2NlfwnFLbqDo+TnK05W9ctA
	 ZkrLyHw3PT2o16fluXBk70+jAKwMslXb9F0FhOW2DcmgeWer3/UQyeTak65Y/1ZgrdU0B
	 vGZ1/VZRI7LOQCQZ5t3WoGFXha3rUpThKpx89G2MTpyHPwmn7NzGZWJ/8L0ewvTgViNbs
	 o6uBRv2SlfoBsksQ3aaq15zMQVd5CEXQfavdQYUi+wfzLvKTH4wAtNUKyoYdOGaYU9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="G/fUaX24";
	arc=none smtp.remote-ip=198.175.65.9
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0ED606A327;
	Tue,  3 Nov 2026 16:52:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B0ED606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=G/fUaX24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793724761; x=1825260761;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q86yi8er8PEFdgAbKUVWCIlMTSmIPNbAIaFARD1QCSc=;
  b=G/fUaX24vQJcPW1LgOY3iZD8i9105FYT34hMleYOGqnEHJr5rJSUrl3t
   57iopSIPWOjXUW/69kK4YISB0RKqltSrQMBkbBMmtIucFLoq38zdMBx0G
   Qv3c+6Ju6H9qWNTEt8nh6x20uHTNEolGbSwZGPM3lgaiUEvltvjz+U6J/
   HEj8pJ/I8fF0KvCF3XZsonET/KzdU5aOqNNNDMXcWEKvPP6TEi11HUSLR
   haWy5am2G9ITVk8dNY99W2keaJaSLHygEAmpQtPiH7Asl2e/nsOhYKcAg
   3oe2mmVqKUXPh4yhTgBD96ZNBg6ZBbwKDQhHumU76M7z6itD/sxIeEsif
   A==;
X-CSE-ConnectionGUID: WYuX/jPeSau4d7sL5+Wifw==
X-CSE-MsgGUID: lS0zhqCYQq2l/X05fW3iQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2350942"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2350942"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:52:40 -0800
X-CSE-ConnectionGUID: nVQB23KbTp+YIDlb2CRK2Q==
X-CSE-MsgGUID: hD+kQ+rSQ5i45ca1PrVdNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6324410"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 08:52:36 -0800
Date: Tue, 3 Nov 2026 18:52:33 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux@analog.com, devicetree@vger.kernel.org,
	linux-pwm@vger.kernel.org, linux-doc@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v3 08/10] iio: frequency: ad9910: support iio backend
Message-ID: <auoRUS-tsK4X0KoU@ashevche-desk.local>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
 <20261103-ad9910-backend-support-v3-8-0e9224ddf7b7@analog.com>
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
In-Reply-To: <20261103-ad9910-backend-support-v3-8-0e9224ddf7b7@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 03, 2026 at 11:53:04AM -0300, Rodrigo Alencar via B4 Relay wrote:
> 
> The AD9910 parallel data port allows modulation of the DDS core parameters
> at up to the PDCLK rate, which requires a high-speed data source. Add
> support for an optional IIO backend that provides such interface, with
> data streamed into the device through an output buffer.
> 
> The parallel port channels get scan indexes and scan types according to
> the data destination: 14-bit amplitude, 16-bit phase, 16-bit frequency,
> or the 8-bit amplitude and phase pair for polar modulation. As only one
> destination can be active at a time, this is enforced by the available
> scan masks. On buffer enable, the destination is configured in the
> backend and the parallel data port is enabled. The sampling_frequency
> attribute of the parallel port channels controls the backend data rate.
> 
> The backend is also notified about profile changes, as it may drive the
> PROFILE[2:0] pins, and the debugfs source attributes now consider the
> parallel data port when reporting which channel controls each DDS core
> parameter.

...

> +enum {
> +	AD9910_SCAN_IDX_AMP = 0,

Why explicit assignment? Either we do all (for HW bits) or none and
let the C programming language standard take care about these.

> +	AD9910_SCAN_IDX_PHASE,
> +	AD9910_SCAN_IDX_FREQ,
> +	/* polar phase goes first, as it is placed in the lower byte, D[7:0] */
> +	AD9910_SCAN_IDX_POLAR_PHASE,
> +	AD9910_SCAN_IDX_POLAR_AMP,
> +};

...

> +static u32 ad9910_buffer_chan_idx(struct iio_dev *indio_dev)
> +{
> +	unsigned int scan_idx = find_first_bit(indio_dev->active_scan_mask,
> +					       iio_get_masklength(indio_dev));

Split assignment.

> +	return ad9910_scan_chan_idx[scan_idx];

Who guarantees the scan_idx to be in the boundaries?

> +}

...

> +static int ad9910_buffer_postdisable(struct iio_dev *indio_dev)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int ret, ret2;
> +
> +	guard(mutex)(&st->lock);
> +
> +	st->scan_mask = 0;
> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR2,
> +				  AD9910_CFR2_PARALLEL_DATA_PORT_EN_MSK,
> +				  0, true);
> +
> +	/* disable the backend channel regardless, return the first error */
> +	ret2 = iio_backend_chan_disable(st->back,
> +					ad9910_buffer_chan_idx(indio_dev));


I believe the second part of the previous comment should be split to standalone
comment here:

	/* Return first occurred error */

Maybe even with more elaboration on how the caller is supposed to react in both
cases.

> +	return ret ?: ret2;
> +}

-- 
With Best Regards,
Andy Shevchenko


