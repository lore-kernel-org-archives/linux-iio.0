Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704957;
	b=2AfByChqZZdgx2KOMb8VIwmqSRCMopYdP2fdUDxEBTMnmessK61bO9KQA0DLjenpHOfC
	 JlM24hjqZpq6N+hfn3O/OhKqEHhkGNJpzUWdOLgAcTDgHixo1/bLKDhM0Oli1wwMMXIOI
	 LLHUP62uRQkdUzdCL+Szs/VrHo92yUvqua/BRrdDauM5MQoaUi4Pd/+gxBLzTcwxRLOtm
	 41DGH4ZVw+HwsUv1hS1qXrtvnxTjBKymd3CfjoVN2PiajVWldKpP9IxJgdqgkRLaCPEXp
	 V7OtU4Hm/gqAZ/4H2m8BEZ6oI+Ah/p36hMqxbSYCiIwFPIH24+fo4xQsNybkbZ+sgmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704957;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=j2Vh/M2QHwx9LQT45XzMEr7PiYDFWEPpUEvbC6uYgDI=;
	b=fZxq54qpPSVOQ0TcUcWjSQXvfLW1rNMPeQdSv7AnhsrucBK1XOHrzQomok1h20fdE2sG
	 2sOTOlCR/wWVqXKDls/onfr6m/OAmpld1+gVkbAYI3SOeODjfsNVcG64MwZ4x3BH2NGmZ
	 c0oBUqLHgQqhDx1mjFV1d7OM2tpikDXnGFSrqcv0dfqGM8HSGbETPVQGxlwMbTi3d7x7a
	 VioqeWS43y7YYh3rq5iZD6X1dohh8H+EwZ8am4vr9O+T1kxP+xJceZ3QZi+Mo3bSsXyTN
	 Y33V0Nr9Vm4mZq7Z95Iopf2CxMMDN0bMMUhCyw93I9JpUSYDsf2H82TKJQBsExRkSew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDVldgBb;
	arc=none smtp.remote-ip=198.175.65.19
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985EB606C584;
	Tue,  3 Nov 2026 11:22:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 985EB606C584
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EDVldgBb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793704955; x=1825240955;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LGOcdMIjTZ8MBgrCIttX59enpT8IHif0wBqJ31SNup4=;
  b=EDVldgBbatmNcmVlrX0zMALU3CZ2uymRac0JcRtsJjCCDSWVf6mSPOqS
   Jm0+y/rbrG5fQyMS6VXiZzeLOqa1iC3JcagFM9hpcuHPJYME+Rna+szxR
   jrZpm6ZqvBuY7JFeru2I5XoEJRvQieH9W734bNohPaBBnwhk9rP5Wu6Rf
   RS5UtlryGjd2OzMOzU1Hs8U1fwjeSZ78PFKyMZTVsHEYaNmaJ3CeQk8/K
   kN9XicutZ7buhkqNIg691IDwvSKYpZ2tDnu3kT455p7kFXieh4XsUCdew
   Zkbz2i2lhfpA5NjmU5JhOiTIT6EiqxSxc2gS+7EBcNxpXjHUnQvtAdYbZ
   w==;
X-CSE-ConnectionGUID: 1pQkppDVRlqIEw6I/9veQw==
X-CSE-MsgGUID: VDThjk2BQrSXQtV5UYBPKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2453527"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2453527"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:22:35 -0800
X-CSE-ConnectionGUID: 5tabxthBQLGBcCDsn+EM+g==
X-CSE-MsgGUID: b8AaKYU1RsK18v9j9dsZig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6227264"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 03:22:32 -0800
Date: Tue, 3 Nov 2026 13:22:30 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org
Subject: Re: [PATCH v4] iio: chemical: ccs811: Make sampling frequency
 configurable
Message-ID: <aunD9kPZ03d8s8AI@ashevche-desk.local>
References: <20261101054019.10188-1-nikhilgtr@gmail.com>
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
In-Reply-To: <20261101054019.10188-1-nikhilgtr@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 01, 2026 at 11:10:19AM +0530, Nikhil Gautam wrote:
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

> +static const int ccs811_samp_freq[][2] = {
> +	{ 1, 0 },
> +	{ 0, 100000 },
> +	{ 0, 16667 },
> +};

Now it would be better to have a common enum to index above and below.
So it will be kept in sync

enum {
	CCS811_MODE_IAQ_1SEC_IDX,
	CCS811_MODE_IAQ_10SEC_IDX,
	CCS811_MODE_IAQ_60SEC_IDX,
};

static const int ccs811_samp_freq[][2] = {
	[CCS811_MODE_IAQ_1SEC_IDX] = { 1, 0 },
	...
};

> +/* Drive mode for each entry of ccs811_samp_freq[], same order */
> +static const u8 ccs811_drive_mode[] = {
> +	CCS811_MODE_IAQ_1SEC,
> +	CCS811_MODE_IAQ_10SEC,
> +	CCS811_MODE_IAQ_60SEC,
> +};

...and here in similar way.

...

> +static int ccs811_update_sampling_freq(struct ccs811_data *data,
> +				       int val, int val2)
> +{
> +	u8 drive_mode;
> +	u8 mode;
> +	int i, ret;

Why is 'i' signed? Also keep reversed xmas tree order.

> +	for (i = 0; i < ARRAY_SIZE(ccs811_samp_freq); i++) {
> +		if (val == ccs811_samp_freq[i][0] &&
> +		    val2 == ccs811_samp_freq[i][1])
> +			break;
> +	}
> +
> +	if (i == ARRAY_SIZE(ccs811_samp_freq))
> +		return -EINVAL;
> +
> +	drive_mode = ccs811_drive_mode[i];


With

	struct i2c_client *client = data->client;

> +	ret = i2c_smbus_read_byte_data(data->client, CCS811_MEAS_MODE);

	ret = i2c_smbus_read_byte_data(client, CCS811_MEAS_MODE);

> +	if (ret < 0)
> +		return ret;
> +
> +	mode = (ret & ~CCS811_MODE_MASK) | drive_mode;

> +	ret = i2c_smbus_write_byte_data(data->client, CCS811_MEAS_MODE,
> +					mode);

	ret = i2c_smbus_write_byte_data(client, CCS811_MEAS_MODE, mode);

> +	if (ret < 0)
> +		return ret;
> +
> +	data->drive_mode = drive_mode;
> +
> +	return 0;
> +}

...

> +static int ccs811_get_sampling_freq(struct ccs811_data *data,
> +				    int *val, int *val2)
> +{
> +	int i;
> +
> +	guard(mutex)(&data->lock);

> +	for (i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {

	for (unsigned int i = 0; i < ARRAY_SIZE(ccs811_drive_mode); i++) {

> +		if (ccs811_drive_mode[i] != data->drive_mode)
> +			continue;
> +
> +		*val = ccs811_samp_freq[i][0];
> +		*val2 = ccs811_samp_freq[i][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int ccs811_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct ccs811_data *data = iio_priv(indio_dev);
> +	int ret;

Why? I don't see any followup, without which this variable is redundant.

> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		ret = ccs811_set_sampling_freq(data, val, val2);
> +
> +		return ret;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


