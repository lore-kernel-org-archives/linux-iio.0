Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794267599;
	b=NfLpMZ3xLCHF9UNGhta81YrfiwYQr9SKERJ0gaAoDUebbqwXz9LxEd8lzLoOQHr6p1t8
	 drm6NJHQE0sDqKiFn4Jp0Jb1CRMIlrjNYNZUNaoejocWnJFytgVRrwwvcpOqREwQ51UVI
	 t1dttQ9QrVsqAU4Qu+wRV10lRHetGukqQygVgDZN+ukh6wbkqlV36/RURYqTzH0ehMZR8
	 dZuP1u43/a8mQFPBV+MM5xHV9Q85UO+bAec5N6wsyY6ego2VQFkeRMrTEYSztFey3k3G8
	 7kyEoAKlB5udgYptDnvfKA2T7ntnLCleZrH/GdPLE4ksBftS8r8O84d0v+2qp5+3GAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794267599;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=6h5zxCWn+DoijFiBqhdIQXlQP/2jlNHpgkQCpj9M10o=;
	b=wWy3a754Dzk392HlYOeIQ618WW04fPpVEid9C5qkpwae54o3biPB9JZLMMObc7zEYVZl
	 o/MPhgL2c5f8n+mIgh+8Tl4JMZSr0yzAUP5sxa+GCMDSu7AJYR0Je3PayMluU9gAnWrk0
	 9OZ2N5khiTOoGPmofuiQfysvHWoyE39GY6rITqLZp6u3OhshMfQPKXSMIqxPUwvz+jI2k
	 fQ9ZNU5PNfdHhIV3CAfIzoGbfr+OXvH9n/C54yU/7H3lUyOEApB3Tmb7BYq8jgJCffCIp
	 DhJbrBimYDwodiBUFDNum9Cokb2y5CFQMvc7iMZxrHqGOQRrtRQSj0HQL5kAWV8y2wA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYwl5OBQ;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690B4606A31C;
	Mon,  9 Nov 2026 23:39:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 690B4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GYwl5OBQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794267599; x=1825803599;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6w3vUl81E6tgblJWSy1ZLmUFWpHHa31fSlMuBE4cMC0=;
  b=GYwl5OBQwGGO6IX/233IO1p6lU3ob4E7RqBfa2LjhhvJvveaqgTeI/BV
   d/z/HxSUL/IYXH1QK728b5tdoZmn6YFaMnOtdvgjS1tKZ/QEqPEwq+rnj
   CHaNAhh+/5MNkfbneenekpbumfWS1c6q2G0ZPUwgRT/dV2rGqeQmaN8Td
   ruZTQRQ1cGfIz7jVaO5ozYYvRw6Pv8UanuZX9Qhg6dBq8EdHyRzOdWt7m
   xVvYlPQWumOyJ3NKE4PZzVUq3ks/6GPwEjdc76+Pb+EPczBalBFq7y69f
   p+iR8hgRu5IKaMiVZkOKYagHFcf461bThNjifOOW+zdIU7CYxWmrO/SEY
   w==;
X-CSE-ConnectionGUID: Twe0VmJaSd6y3/7r6Qsq6Q==
X-CSE-MsgGUID: 74JbfzAISlCEX6IMAd3X2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2901751"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="2901751"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:39:58 -0800
X-CSE-ConnectionGUID: G7Q2+33BRXmRJMgFFA4eMw==
X-CSE-MsgGUID: qpT5d+7gQbSo/V5qOwRjvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8323616"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:39:56 -0800
Date: Tue, 10 Nov 2026 01:39:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avJZyb5S--smaHpX@ashevche-desk.local>
References: <SN1PR12MB252841150D2280C7C1294A11A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
 <SN1PR12MB25282CCC3930ABE760956095A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB25282CCC3930ABE760956095A5742@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 02:08:29PM -0600, Victor Chernyakin wrote:
> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.

...

> +static int fdc1004_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct fdc1004_data *data = iio_priv(indio_dev);
> +	struct regmap *map = data->regmap;
> +	s64 val64;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (unsigned int i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); i++) {
> +			if (fdc1004_samp_freqs[i] == val) {
> +				guard(mutex)(&data->lock);
> +
> +				data->samp_freq_index = i;
> +				return 0;
> +			}
> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OFFSET: {
> +		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
> +		    val % fdc1004_offset[1])
> +			return -EINVAL;
> +
> +		guard(mutex)(&data->lock);
> +
> +		data->offsets[chan->channel] = val / fdc1004_offset[1];

Make a temporary variables to have division and modulo operations coupled
together. The rationale is explained here:
9b3cd5c7099f ("regmap: place foo / 8 and foo % 8 closer to each other")

> +		return 0;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		val64 = iio_val_s64_compose(val, val2);
> +		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
> +			return -EINVAL;
> +
> +		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> +				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));

Why casting? Shouldn't it be handled on the regmap_write() stage based on
the register / field description?

> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		val64 = iio_val_s64_compose(val, val2);
> +		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
> +			return -EINVAL;
> +
> +		return regmap_write(map, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
> +				    DIV64_U64_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko


