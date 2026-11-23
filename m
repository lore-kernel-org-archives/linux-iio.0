Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795432543;
	b=DY3zEfA4sjjQfNlkZgf/x9u1JXOMNnKsbOhhl9gv4rXVwvxz/X00amiN7GBmRHtg+SXE
	 Ge7hnaepuXF4YnzAs1vbOYTG4rQYXkPPLao8t+b848js6hbK9RMQD7jkR2gCH2xxr/h99
	 bTEc01KES6tJ2/3+3Sxd9/FOyAFi4O+N9UJa0LBz015lHjS8mZ0EFssJ7jRnvTa54r6nH
	 FMaL+2FHkx1OQF3Hme49JSXB+Q3l9m4LvVyhU6k7pwW2aE+FlVuL7sv/jRXVbBrTNrl95
	 1FHibORpCdfyOWeqV2WSTeZkYpuuRIpNhgTebmMtaHcvT4sUbXYdxEpL4aHX4Ow0WOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795432543;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=LX+A9a0lW1HiTrW/Uz2nviRvwPEaKkd8gMQoME4OxnI=;
	b=P1WoyA43wbi70OAq5daMqn1DJj46OqJu4rmBoe/5HVMKYkmejKEg3frKlQXvNnBJKAI6
	 GJwXVmfx0Eiaan/mjvvnOae8kNXfD2qoZPPujUMffcVx0//Mc5brcIPTTIr8WIOmGbWRS
	 K5/FTne5wynlC/h8SKEvUn8M4dOwZzywbUPECO/RAs1KKeo7x/yuvoLfF7bvXCbqo539J
	 1HW97Fq6K2CQ2wlholnYSbJGCU87vMZdr0m72vl4UfWM5hKVjIDc8IHuqaMEsU+66O9Y9
	 LBt3VMt59srlt7RotaYuYPKFlHb81h3QFcSC1aa9MFCXz4GMoe90Ssa3XA1XswMJChQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bnSLJtMq;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F24606A31A;
	Mon, 23 Nov 2026 11:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39F24606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bnSLJtMq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795432543; x=1826968543;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0GpQepsmZFy1Eygu+W9dGi5Abg63IbCvsaFS9IHMmjQ=;
  b=bnSLJtMqDA6pNaVItfceOxAH7pyqhBKq7iknleXNdfB3iG8HGRv/5gUQ
   57ZQ8+43aumh1Q4F6CRp4mTHuIj218DAtm7aL6q0Zw7xB/20LOCxKJFCq
   MgKq/t6/lz0krVXz6b/u+CbfXns0p00Db+07bU40MeFsk5qMDky8PDaR7
   IBxvX95EBmnLCQrVCcFy/3GgkodnZubjVnztjxYIKxhylwWnhCTLHuCog
   2zGXx4Kq/vA7m7BIkVTA5e5UIPzNdORwL0MQ8Oy1SswDNO6qlKwckTLIc
   OFKL8jsc2X8YHDbuY1IXqUIQ6qpnnhyB6Iw+ZoRuco+QlF3w2A5zst7ia
   g==;
X-CSE-ConnectionGUID: ArTZG9VISDWOnn5go63wag==
X-CSE-MsgGUID: K7CPaA2IRryOMbLUCQbiGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4129649"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4129649"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:15:42 -0800
X-CSE-ConnectionGUID: VU4irReYScOvik0QYjPauQ==
X-CSE-MsgGUID: 63R25IokTeuM+ZATFNAn5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="11693110"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 03:15:40 -0800
Date: Mon, 23 Nov 2026 13:15:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnav Kapoor <kapoorarnav43@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: proximity: sx9324: reject negative
 hysteresis values
Message-ID: <awQgWmI3HmyqTcrS@ashevche-desk.local>
References: <20261122074649.239441-1-kapoorarnav43@gmail.com>
 <20261122074649.239441-4-kapoorarnav43@gmail.com>
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
In-Reply-To: <20261122074649.239441-4-kapoorarnav43@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 22, 2026 at 01:16:43PM +0530, Arnav Kapoor wrote:
> sx9324_write_hysteresis() copies the value into an unsigned int before
> comparing it with the threshold, so a negative value becomes a large
> one, passes the "val >= pthresh >> 2" check and sets the largest
> hysteresis instead of being rejected. The comparison is done in
> unsigned int, so this happens on both 32-bit and 64-bit architectures.
> 
> Return -EINVAL for negative values, before converting them.

...

>  static int sx9324_write_hysteresis(struct sx_common_data *data,
>  				   const struct iio_chan_spec *chan, int _val)
>  {
> -	unsigned int hyst, val = _val;
> +	unsigned int hyst, val;
>  	int ret, pthresh;
>  
> +	if (_val < 0)
> +		return -EINVAL;
> +
> +	val = _val;

You can validate assigned value instead as there are no side-effects.
But while I wrote it, I have noticed that there is actually one, we
modify the sign of the value. With that in mind maybe better to have

	/*
	 * Assume only positive input, negative, after conversion to unsigned
	 * is unsupported. // or something like this
	 */
	val = _val;
	if (val > INT_MAX)
		return -EINVAL;


>  	ret = sx9324_read_thresh(data, chan, &pthresh);
>  	if (ret < 0)
>  		return ret;

-- 
With Best Regards,
Andy Shevchenko


