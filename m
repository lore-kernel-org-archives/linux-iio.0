Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794941953;
	b=ra+tTKFof5XIiUl4lMvaNH8Gz8a+DHSZ1aOdHn0Zo0/6umUMa76PIdkVC+Ra+z6tACd1
	 qSHjo8jDIFCFZMbYjOkAtSKEpPkNAyMVxTN03rEEhBrdrOHM9wYPH8c2Vht2XxFVGiB6U
	 zQYLiDTNlmz2RTJkxjrK5cUdAwJN5sWMqL34zj/1ILc7otQuBU1BU5PHnz9SQqsueYZY0
	 cwMWrq2bbZ1Cbhh2FD3AmE2zh4VLmULYnDa+DPbfsLz89BJTwZMHXjbVnyW50i966OzHC
	 iBysndO91eqsOG75XbDkr4OkzJJ4WmZMPmwxnEOOUY2uVIhNKjf006ee2nMvYQtSf0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794941953;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 Organization;
	bh=7hJxtqXBPfqark14BY8bw5v3+/Teimr8R1AXsM1mMRI=;
	b=c9nWdcocak0XpNcla5zekbD5dWy/8KOB9eKfjxGC3fr+/HIqWsq/znC9hK5OarjDvOlC
	 WDO/nEN2pkGGIFR53v2kXdaIEqOcqzEGBwJbvjasOapRtxOBLDtqLqM2HZ5Bjm40/Eyfm
	 Ek5hIif2FH7+cLhCN9VqJ+NaDIh8OfohbzDf1x97yvAPtZpnOWLeU/yT3LR4Wj6o2/tBg
	 NbNIOp6SEz3qIqOnirEYb68I+AnhMAKnAN9TFEzV/oC1UpblsDJHYdLIwpEbPk+lb93N8
	 RgUnFlWjrcoe4oOk6bG6VXZ5xZDPYy9BMqO3KTfHAiVeiwMZFxx3r00o01cjVNy6Ykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWBmnMLa;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5447E606A32A;
	Tue, 17 Nov 2026 18:59:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5447E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hWBmnMLa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794941953; x=1826477953;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vkhc7EfR0Bckp6Ddz+uAhm9P/S4T58+7MYjBoqJB++c=;
  b=hWBmnMLaguV2VdP19SYGbFwXAFCY39HMrqo+SL3Qk+L7j+sYckIc3+cA
   WAYq3RSspB7BT++hsce3TiXfx0zquNc/32TRRl60J416EBdhrqWU/Iwu8
   OVazX9Us0vFRr5lrtno7GVzEaJ7uHg5Wn4+bGYigad1QYIkVBiQQGaQEd
   leN+4U1upKP/5LJyFlGRl+yOiDYnp9n3WoSglGG/kPDMnx5VfungT24/r
   mpdxWvLho3b2RrhF5xflt/5YSq4N6b6X0g6tPlIKoQWZ7K7yKYMY7Vxg8
   /9oPO+MT2XQC7DbKv0TGdVr39LLlOCYrcrzVa5v2M1FvA9HeJflC8SRgj
   w==;
X-CSE-ConnectionGUID: TqTRbcJFSbyQexm1IQBeNQ==
X-CSE-MsgGUID: m/rp8wG7RvqJ8B2bR85RLQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3622458"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3622458"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:59:12 -0800
X-CSE-ConnectionGUID: p0WP9NnaTJCTHj6/n3Z58Q==
X-CSE-MsgGUID: qtspzAJ3SliWgSU7v9IE7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9907548"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.254])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2026 10:59:09 -0800
Date: Tue, 17 Nov 2026 20:59:06 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: proximity: sx9324: fix proximity threshold
 writes
Message-ID: <avyj-lOGvj04A_Ak@ashevche-desk.local>
References: <20261116205320.26070-1-kapoorarnav43@gmail.com>
 <20261116205320.26070-3-kapoorarnav43@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261116205320.26070-3-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 17, 2026 at 02:23:10AM +0530, Arnav Kapoor wrote:
> sx9324_read_thresh() reports a PROX_THRESH code r as r for r <= 1 and as
> r * r / 2 otherwise, but sx9324_write_thresh() converts back with
> int_sqrt(2 * val).

> For odd r the read value is (r * r - 1) / 2,

No, it's r²/2 but in integer arithmetics. That's why for odd number squares
it gives 1/2 that becomes 0.

> so writing back the value that was just read programs r - 1: setting the
> threshold to the value it already has lowers it, for 127 of the 256
> codes (3, 5, 7, ...).
> 
> The int to unsigned int conversion also lets some negative values
> through: 2 * val wraps, so e.g. INT_MIN is written as 0 and values just
> above INT_MIN as small thresholds instead of being rejected.
> 
> Reject negative values and use int_sqrt(2 * val + 1), which picks the
> largest code whose reported threshold does not exceed the requested
> value and makes read_thresh() and write_thresh() inverses of each
> other for all 256 codes.

So, for the read part

	reg		value
	0		0
	1		1
	2		2
	3		4
	4		8
	5		12
	6		18
	7		24
	....

For the write part (the negative is problematic only on 32-bit case IIUC)

	value		reg
	-INT_MIN	0
	-INT_MIN + 1	1
	-INT_MIN + 2	2
	-INT_MIN + 3	2
	...
	0		0
	1		1
	2		2
	3		2
	4		2	// has to be 3
	5		3
	6		3
	7		3
	8		4
	9		4
	...
	12		4	// has to be 5
	13		5
	...
	18		6
	...
	24		6	// has to be 7
	...

Yep, what we see is off-by-one for full squares. This is because division
by 2 in integer arithmetics makes it floor number. So, what you want
to have is a correction for all odd numbers.

...

> static int sx9324_write_thresh(struct sx_common_data *data,

>  	reg = SX9324_REG_PROX_CTRL6 + chan->channel / 2;

This one is not used in the conditionals, so the new check may well be done
before it.

> +	if (_val < 0)

Checking _val after assigning val to it is confusing.

> +		return -EINVAL;
> +
> +	/* Inverse of read_thresh(), so that writing back a read value is a no-op */
>  	if (val >= 1)

First of all, I would drop the '=' here.

> -		val = int_sqrt(2 * val);
> +		val = int_sqrt(2 * val + 1);

And here I would rather use (val % 2) instead of 1. See above why.

>  	if (val > 0xff)
>  		return -EINVAL;

-- 
With Best Regards,
Andy Shevchenko


