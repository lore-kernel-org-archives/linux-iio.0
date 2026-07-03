Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F8D3D6487;
	Fri,  3 Jul 2026 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085415; cv=none; b=QTkUdDPjBbGodputSr6vncnz7VICcaDJZd1ppU0rqc0Eun191igkcKgji8HeRNBW2BCb2Uz0NmUnLaRxzPAfOza7ZXi1YjLJmWibd48Rb9jSCogWM+1UcqbbcYFzGUb+WOIi2+76q+JTvpanmrBSnL0QqBQWxpxkJ98BUBan6nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085415; c=relaxed/simple;
	bh=5EpHk1wO5d9taJbc9hNQaJkd7OdOQDqBi9ZtuEIdDJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drODK2YPa//Kj0R2MhhDBXpJ3bd6yv778AFGVOuwG+QoMT/69gcLnlxmZnhT9QZHlxz12I9QrZAvXOElCJ4WChfU6mKbDN3iexMePNzJGtASYaTaQCX72MgDe9KNg8czlTfsuHI6NGg5+Q22CK+wxHsoEef+llr4hE45eXcrL0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRHqHM50; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRHqHM50"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783085413; x=1814621413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5EpHk1wO5d9taJbc9hNQaJkd7OdOQDqBi9ZtuEIdDJw=;
  b=GRHqHM500RWpuLKMycrbbjCV6/ACwzjuBQ0SKwnBbLSqtcK9pqihvC8W
   g+QKddNeTHhfMwg7OmY7+Pj5ABvYr62TfLQEgQraMDfuofN2uh1AD45jY
   EnR9DkAycsH7iaE19FoNPRCw2fZWM2HsrJYwxXc5yIC4CCXhcBxSnjbVS
   98kQlqvgjxy4Q3lQJ7vx4Sar2TTarVWSfs1RB1oVELCD6RHw3O6/RBrD3
   5YKA9yIvxwt6sho5aCOwKro5xCmbk5ii+Vb6yQAYlqyDaj65FU9Jnmrro
   RvNRi5ETVcI06klBv3UYUN5E+MVeWUN2Oz1fmlia5vDWqj0R3TPIRgKK2
   Q==;
X-CSE-ConnectionGUID: GiiAKvhqRPmSKhD71umjGA==
X-CSE-MsgGUID: 8k7FrdLASy+/iKroYwYRFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="82826549"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="82826549"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:30:12 -0700
X-CSE-ConnectionGUID: pkTZ1QAcSe2NMLmSf+535w==
X-CSE-MsgGUID: ZDUrG/ahS8iMXcMXGChoyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; 
   d="scan'208";a="251395013"
Received: from carterle-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.80])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2026 06:30:10 -0700
Date: Fri, 3 Jul 2026 16:30:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Mert Seftali <mertsftl@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jelle van der Waa <jelle@vdwaa.nl>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: dmard09: Implement IIO_CHAN_INFO_SCALE
Message-ID: <ake5YH7GsGFnkSPm@ashevche-desk.local>
References: <20260703130750.66549-1-mertseftali@web.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703130750.66549-1-mertseftali@web.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 03, 2026 at 03:07:50PM +0200, Mert Seftali wrote:

> in_accel_scale has returned -EINVAL ever since the driver was added.

You mean "Reading the in_accel_scale attribute ends up in returning..." ?

> The channels advertise scale via info_mask_shared_by_type, so the IIO
> core exposes in_accel_scale, but dmard09_read_raw() only handles
> IIO_CHAN_INFO_RAW;

> a SCALE read falls through to 'default: return
> -EINVAL':

This part is repetition of the first paragraph. Drop one of them.

>     $ cat .../iio:deviceX/in_accel_scale
>     cat: in_accel_scale: Invalid argument
> 
> leaving userspace with raw counts it cannot convert to m/s^2.
> 
> The driver was written from a vendor source [1] without a datasheet, and
> the scale was declared but never implemented. The vendor source carries
> the sensitivity: its conversion is
> 
>     acc = raw * GRAVITY_EARTH_1000 / sensitivity   (then / 1000 -> m/s^2)
> 
> with sensitivity = 32 and GRAVITY_EARTH_1000 = 9807 ("about
> (9.80665)*1000"), i.e. 32 counts correspond to 1 g.
> 
> That sensitivity applies to the value this driver already reports as raw.
> The vendor processes each 16-bit sample as 'data >>= 3; data &= 0x1ff'

Try to write it more human and less programmish. Something like

"...16-bit sample as a signed 9-bit..." In other words, drop those technical
details, people can check the code by the link.

> plus a sign-extend of bit 8 - a signed 9-bit quantity from register bits
> [11:3] - and dmard09_read_raw()'s 'accel <<= 4; accel >>= 7' yields the

"...and in dmard09_read_raw() preparation yields the..."

> same value. It is self-consistent: 256 counts / 32 = 8 g full scale,
> matching the part's +/-8g range.
> 
> Implement the scale derived from that sensitivity using standard gravity:
> 
>     scale = 9.80665 / 32 = 0.3064578125 m/s^2 per LSB

> [1] https://github.com/minstrelsy/mediatek/blob/1f49d8c87b839651bc89afc870277e8e0f2e2d55/custom/common/kernel/accelerometer/dmard09/dmard09.c
> 

Make this a Link tag

Link: $URL [1]

> Fixes: a4fa6509dda4 ("iio: accel: add support for the Domintech DMARD09 3-axis accelerometer")
> Signed-off-by: Mert Seftali <mertsftl@gmail.com>

...

> +/* Sensitivity is 32 LSB/g; scale = 9.80665 / 32 m/s^2 per LSB. */
> +#define DMARD09_SCALE_NANO	306457813

I'm not sure how it's derived. Can we use more of calculations here instead of
precalculated value?

-- 
With Best Regards,
Andy Shevchenko


