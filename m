Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FB3262D0B;
	Fri,  7 Aug 2026 01:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786064948; cv=none; b=qoqQee5oZPrU3VIpDEmUOPjcIhJ7w7iCap7r1O4SQeIG3n5tXj/BtfmQSTfHJZQQe/6ZE1hJo8d9wlGHzl6y6TgJaphwzoSK5QCwkfYS7hDZKcR5ZHWDS1lzxi/rlGNhUEP0diZdxE94Ld/5LsOZAKHShYLcWYV8604yb02eQzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786064948; c=relaxed/simple;
	bh=2RQlyTNLjt/lJcNs8BtndykYH69lOBIEXAwVZIz2K9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QKo/V+KqN7h+flF9J8viR8N8+kJqjtdrs2pAmd1uQQ1oLAQm6Ly2FxMWil9Tqae8pPozJh7YeNF39jLJsZA1DYNDcJpI8I4pXMiA/mMKqCzTto28A7+V1dGCFs3folDmN9BmPOnis1ZYPKvI86lfDWuXoOQlz51TAylP9wExpuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XMpM6AiK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XMpM6AiK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786064945; x=1817600945;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2RQlyTNLjt/lJcNs8BtndykYH69lOBIEXAwVZIz2K9c=;
  b=XMpM6AiKDEw7zL+mRQeMaz4jOA/+SKBBSseKGWBTJJQhb5Bq7tgK/yRg
   3WW06D1cKB3LfFxRtdvsl0nHk/3dbONQXu99dfWIA+MM5dvpqNSw36swd
   xSoiupk++U6TF0hukJxLYcNIgtnsuTGXeIdd9AuyOETrAf3Qsd1TdtP08
   bIeXkKU9IANNgEKjltH/iE7IAfobqol5TtZnVo0jQd8kekeLVnPnXgIYh
   TUKjkVPy6x70u+tVsE9Lc/DcUTmooc3XF0KSZgNeY2hnB/spwzu1KFjJQ
   uPVN/Zm49fRxQEGvoEu+5SjjAhAy56yARk2sqLmOXn+XagKcHyWRZNVct
   g==;
X-CSE-ConnectionGUID: sDdKsP9+SZaOb8U/ySN4TA==
X-CSE-MsgGUID: Z5tk99J4Sc++EtP9BA3qGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86524437"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86524437"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:09:02 -0700
X-CSE-ConnectionGUID: pdCiHVV4TaKgNWCBsd4GaA==
X-CSE-MsgGUID: /iY/L7OQT8iGptA77P1lNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="262876436"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 18:08:59 -0700
Date: Fri, 7 Aug 2026 04:08:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Message-ID: <anUwKGyjjwYxQ8NI@ashevche-desk.local>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
 <20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 27, 2026 at 09:09:50AM -0500, David Lechner (TI) wrote:
> Add support for I2C CRC8 to the TI ADS112C14 ADC driver. This verifies
> data integrity of all I2C transactions with the device.
> 
> For now, it is always enabled, but it could be made optional in the
> future if needed (e.g. for higher-speed data acquisition).

...

> +static int ads112c14_i2c_add_driver(struct i2c_driver *driver)
> +{
> +	crc8_populate_msb(ads112c14_crc8_table, ADS112C14_I2C_CRC8_POLYNOMIAL);
> +
> +	return i2c_add_driver(driver);
> +}
> +
>  static struct i2c_driver ads112c14_driver = {
>  	.driver = {
>  		.name = "ads112c14",
> @@ -1217,7 +1347,7 @@ static struct i2c_driver ads112c14_driver = {
>  	.probe = ads112c14_probe,
>  	.id_table = ads112c14_id,
>  };
> -module_i2c_driver(ads112c14_driver);
> +module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);

This is not needed if you call crc8_populate_msb() from the probe using
DO_ONCE_SLEEPABLE().

-- 
With Best Regards,
Andy Shevchenko


