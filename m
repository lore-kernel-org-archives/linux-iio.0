Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF8234CDD;
	Sat, 19 Sep 2026 14:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827003; cv=none; b=PKOEdOENSi88w+o55sLOcc6ROTpzWap83Psn/adn1E8eDbXYzOAn1O2RTJJWSehOVMlK1G2HN4wjajhvE/slYXhHprJlqFdJQVCCKyZy+PKuDy1tcMpmw0f5yd1fHfUo61zvK568O8bRHGgPSSE2+5vs+43fdGLafit4r8gH+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827003; c=relaxed/simple;
	bh=lpbC9bqxlXiFOlAGsSpwmRN0e8ost2AFl1v+1bUkEio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRVxhOcceYqDWyejcCResUEuU8Rh4wqeb/GsIZtw38k6VAyU6nZSdTN1bRxojDTK2iX7O0cxj7SaUaNYPU+Wddsno3C9Cg2J0ulQuK2EY3sJMsGT3ruHV5C0TP4HbpDvzoGzYimKVgx9OSqKnsYpJpzNoIsa6B8Kv2EzXzQl1nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bq1/SVRZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bq1/SVRZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789827001; x=1821363001;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lpbC9bqxlXiFOlAGsSpwmRN0e8ost2AFl1v+1bUkEio=;
  b=Bq1/SVRZ0WxC/EpxVWP82apI7pjnTgnlJXjTlydN2zjFOTLnv7HEmw52
   Vjq5ln7n40Xa9mWSWasNh1NtmbktU1vo9l01tYIf6soa2dbhYw3YoxyTa
   G+aQVijTwqx84HyBhBRSman60qskkm0HRmMxbEGswpPVBna23Z6j+t18N
   KzsLju3KZgHmyDV/Gjpf/siNkz+FpQ0YPfdoMIH4JGyJVvvhsMs5stuu0
   Y6WTLNAKlA/+cZodoQX+2Yx4WVIRP9Y0O50kjHKz1jKI8jwpmSt0j8iQV
   M6uOJdDGlRNk++8I6oBbIVmh+iypBdBnG47nM3nydLrOxeWCTr2q80+oq
   w==;
X-CSE-ConnectionGUID: BojJJr3eQeKYXmUQmz21KQ==
X-CSE-MsgGUID: VwLeynM3TV6+fEZUjktRVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11910"; a="100951312"
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="100951312"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:10:01 -0700
X-CSE-ConnectionGUID: Enbc9vJOThOo7iW/7y0OrQ==
X-CSE-MsgGUID: n3fnl7NxT7Wqpr+9Ja1Qlw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,111,1787036400"; 
   d="scan'208";a="272156919"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.50])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2026 07:09:58 -0700
Date: Sat, 19 Sep 2026 17:09:56 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jaakko Koivisto <jmatko@utu.fi>
Cc: Andreas Klinger <ak@it-klinger.de>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: chemical: sgp40: Implement
 get_serial_number-command
Message-ID: <aq6XtHY6Yp-qyg5f@ashevche-desk.local>
References: <20260918134019.1101308-1-jmatko@utu.fi>
 <20260918134019.1101308-2-jmatko@utu.fi>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918134019.1101308-2-jmatko@utu.fi>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Sep 18, 2026 at 04:40:17PM +0300, Jaakko Koivisto wrote:
> -Retrieve the chip serial number.
> -Present the serial number to userspace as device attribute.
> -Rename the tg_measure -struct now that is is used for multiple
> commands.

...

> +	ret = i2c_master_send(client, (char*)&get_sn, sizeof(get_sn.command));
> +	if (ret != sizeof(get_sn.command)) {
> +		dev_err(data->dev, "i2c_master_send ret: %d, expected %zu", ret, sizeof(get_sn.command));
> +		return -EIO;
> +	}
> +	msleep(1);

Explain this sleep.

> +	ret = i2c_master_recv(client, (char*)&res, sizeof(res));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(res)) {
> +		dev_err(data->dev, "i2c_master_recv ret: %d, expected: %zu", ret, sizeof(res));
> +		return -EIO;
> +	}
> +
> +	if (crc8(sgp40_crc8_table, (u8*)&res.A, 2, SGP40_CRC8_INIT) != res.A_crc ||
> +	    crc8(sgp40_crc8_table, (u8*)&res.B, 2, SGP40_CRC8_INIT) != res.B_crc ||
> +	    crc8(sgp40_crc8_table, (u8*)&res.C, 2, SGP40_CRC8_INIT) != res.C_crc)
> +	{
> +		dev_warn(data->dev, "CRC error in get_serial_number");
> +	}
> +
> +	data->serial_number = 0LL | ((u64)be16_to_cpu(res.A) << 32) | ((u64)be16_to_cpu(res.B) << 16) | (u64)be16_to_cpu(res.C);

0LL ?!

> +	dev_dbg(data->dev, "serial number: %llu", data->serial_number);

Why?!

...

> -	struct sgp40_tg_measure tg = {.command = {0x26, 0x0F}};
> +	struct sgp40_command tg = {.command = {0x26, 0x0F}};

While at it, add more spaces.

...

> +}
> +

Unneeded blank line.

> +static IIO_DEVICE_ATTR_RO(serial_number, 0);
> +
> +static struct attribute *sgp40_attributes[] = {
> +	&iio_dev_attr_serial_number.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute_group sgp40_attribute_group = {
> +	.attrs = sgp40_attributes,
> +};
> +
> +

Single blank line is enough and we have ATTRIBUTE_GROUPS().

-- 
With Best Regards,
Andy Shevchenko


