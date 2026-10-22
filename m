Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792689184;
	b=aYWNTA0go3ei4LvUAYIJkxIKVFL3dFSiv8xzIFUHXLJ8kMup66POzLmPmpzFWy4MKyOm
	 0k6N3G5V3FJUvqh4YOV0ilxJwZyw+ZZxtK791FH49yLNcQXxZn89/fwl7UkQqpSIvXMZt
	 3QP9npidfNMFgag74tbo0wC6Rwd1qctCxWcSNRChNewxcRM3XritOvWGrpPWQLLCJ/QbU
	 XEEO0A3B1bQtR8rXdx3O63N40xJ+u4ki3d4PyDvJjn1kSxOMe1GYE88ZwMPuccbIl86/f
	 ARom7V+6JfWBfnqcF73HuWXA2KWMGJuN+KfmpGasPkhwQwgFdp4tHRrithKiE+tvGXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792689184;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oTL3AeZwV6ZEe/kOcuwqr+gYR3dBMWnb8q5n1L841M0=;
	b=L/bJvgDxJx5Vf6wvGtts8zI7E1WK4WOntLDFiqp2ESisWu1QOw1sGOCI+97AdE1CzGXx
	 V6E97QTr3oEKM6D2U9Lwi+qwf1+is0RBoL33v2uXxcjqxpGcOSatdIMwFV9jGDKxj4Z4l
	 sAD/3U9BnAWtXWJfz9yJg29BY6sM5CM7iQis/rbInC3TizeNWFw+A629l1yf6WXYAxGLH
	 hpDNTERQz8xFczyhQZ21EBXi5NFO9aPlbBtdqtVglLJzd9HsgcBYmRZc2uhCbOhUEEQum
	 /SFU7lYeva3S8WVnvoH0ciRScjqdvxV07zwbm/H0i7n/vH81BLmq6IwNV80Cc5rcLfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="iInod/N4";
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C019C606A31A
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 17:13:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C019C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iInod/N4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792689183; x=1824225183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2upO2Q+Wopsmw/6bFemWtxyPZmT7UkAgO+Sp6AcMrtI=;
  b=iInod/N4c/QUUEJfuG4u4h/XjlhulkfCnyCNQLDIXd2Y5z7vdhWmHuhX
   W2N/xPr3KB0sK3s95HrBMC6Wui4s3GEsdZhrqXLpE5QcSIhTUsLUd7iCP
   GBQhJ9KduYsGgreu/xVLgv5TsBLxAfj2q343Z4/FxXoyxxho8Ckj+b6rJ
   ysDPrXxJpolNjP+O/PV+jsQPdRuWLpriBf7BOy//A0BDSK5D/P+Jsr8oB
   Su9NtSCdoXMikzXi/0f9Zaq38SwRKVZdpfB5b2/MAAnLfqWwVxwkfBvIF
   zW4ndPIRmn0sBwRM+YvtqYz9Kk32f6gnoW45RH2l4oi8G3+6Dbx+Q10U/
   g==;
X-CSE-ConnectionGUID: y4Sl5dpmQ42fsNNzEB2Nng==
X-CSE-MsgGUID: tsfkqL+vTnqhdDEzafnzJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1480271"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1480271"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:13:03 -0700
X-CSE-ConnectionGUID: FXcVcXJTTuaPM9VwfSvGHQ==
X-CSE-MsgGUID: 5zSrhU8XRA+2S9qrluxnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3892040"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:13:01 -0700
Date: Thu, 22 Oct 2026 20:12:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, lkp@intel.com
Subject: Re: [PATCH v2] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <atpEGkRrt5pBlRtA@ashevche-desk.local>
References: <20261018170013.79443-1-nikhilgtr@gmail.com>
 <20261022150652.4842-1-nikhilgtr@gmail.com>
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
In-Reply-To: <20261022150652.4842-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 08:36:52PM +0530, Nikhil Gautam wrote:
> Allow userspace to configure the CCS811 IAQ measurement rate through
> the IIO sampling_frequency attribute.
> 
> Support the three IAQ measurement modes with sampling frequencies of
> 1 Hz, 0.1 Hz, and approximately 0.016667 Hz, corresponding to
> measurement intervals of 1, 10, and 60 seconds.
> 
> Preserve unrelated bits in the MEAS_MODE register when updating the
> drive mode, and cache the selected mode after a successful register
> write. Expose the supported frequencies through
> sampling_frequency_available.

...

>   * TODO:
> - * 1. Make the drive mode selectable form userspace
> - * 2. Add support for interrupts
> - * 3. Adjust time to wait for data to be ready based on selected operation mode
> - * 4. Read error register and put the information in logs
> + * 1. Add support for interrupts
> + * 2. Adjust time to wait for data to be ready based on selected operation mode
> + * 3. Read error register and put the information in logs

I would just change the 1st line as

 * 1. DONE. Was: "Make the drive mode selectable form userspace"

And renumber / kill when it's close to complete.

>   */

...

> +static int ccs811_set_sampling_freq(struct ccs811_data *data,
> +				    int val, int val2)
> +{
> +	u8 drive_mode;
> +	int ret;
> +
> +	if (val == 1 && val2 == 0)
> +		drive_mode = CCS811_MODE_IAQ_1SEC;
> +	else if (val == 0 && val2 == 100000)
> +		drive_mode = CCS811_MODE_IAQ_10SEC;
> +	else if (val == 0 && val2 == 16667)
> +		drive_mode = CCS811_MODE_IAQ_60SEC;
> +	else
> +		return -EINVAL;

You have an array, use it instead of duplicating values here.


> +	guard(mutex)(&data->lock);

Always make sure the guard()() is put standalone (id est surrounded by
blank lines).

> +	ccs811_set_wakeup(data, true);
> +
> +	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);
> +	if (ret < 0)
> +		goto out;

> +	ret &= ~CCS811_MODE_MASK;
> +	ret |= drive_mode;
> +
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					CCS811_MEAS_MODE, ret);

A single line, and the ret = foo(ret) is not good style, add a temporary
variable with good name and use it.

	u8 mode;
	...
	mode = (ret & _MASK) | drive_mode;
	ret = _write_byte_data(mode);

> +	if (ret < 0)
> +		goto out;
> +
> +	data->drive_mode = drive_mode;
> +	ret = 0;
> +
> +out:

Instead, make a wrapper that does this wakeup calls, guard()(), bu calls the
body only once, so you will have here

	ccs811_set_wakeup(data, true);
	ret = my_new_kool_body(...);

> +	ccs811_set_wakeup(data, false);
> +	return ret;
> +}

...

> +static int ccs811_get_sampling_freq(struct ccs811_data *data,
> +				    int *val, int *val2)
> +{
> +	guard(mutex)(&data->lock);
> +
> +	switch (data->drive_mode) {
> +	case CCS811_MODE_IAQ_1SEC:
> +		*val = 1;
> +		*val2 = 0;
> +		break;
> +	case CCS811_MODE_IAQ_10SEC:
> +		*val = 0;
> +		*val2 = 100000;
> +		break;
> +	case CCS811_MODE_IAQ_60SEC:
> +		*val = 0;
> +		*val2 = 16667;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	return IIO_VAL_INT_PLUS_MICRO;

Replace break:s with this return.
Also use an array you have.

> +}

-- 
With Best Regards,
Andy Shevchenko


