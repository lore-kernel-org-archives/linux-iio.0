Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794822215;
	b=U5UCeraD7epH43GDSwQDi0Td6mnSeHagkoPseO42A7f5/hcmVBDQbeHzWoyO0QqCkcLg
	 dpusWlY4znwmroH6t0Yrb5t0g3IvcukUCDD2/u1Oy3yDtd1V3E7ESBAPp6KHC6kd4GoKb
	 9O+shaCf954vULRvFeq5TVufF/cPdM5iCvU9RnWIU4ms0jweLvHsaRRO/6oDaQDk61k84
	 Aolohhrp87puJxNtJe67d/HN62HDQV+Bx0sM/ghUApT1fK9kzgfyAFTXmlPVl4CS8eCbz
	 3cy+51l8+gFbwT54BxHqQVgOxKNHK0oK/ZtTkZ0KwM/1BtKfni6PZc3J8wh6JDlm3jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794822215;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=r1AFOpbsqxX3uo9toBA+mdQLGQJc8KzZTyPjj6RARv8=;
	b=MzIBoCI8avURNs1tUnkMUXtVQs2I+ydOsa3heXiFW/xAvwXG2WphTNEkwv+GOiUCpdOy
	 atCZYrQYOmIrjYHz5G6e52LjBa8mAbbWRWqekQyC7enFYp4a4WngJxz8pI/0E3I4oOS0K
	 eGSWGKbFNr4ikixMbtix05L2TMwWyNqRIfL/b6TLOqy/EElscoal999ayOQ2XTojuYofi
	 9swLbL/QlWgtSeQ141isjA4/t5KSRJpd1cRDpgtwqiy/gGAbASjNDSbgRAQItMbm6R8Xm
	 4KvcDDUy4UJT5BZ8VWkXx1A3eMPX9VLbqSnOGcF49AwRpbq5ADdIpYQ00mtTZsxD+lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="b/tck9XR";
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A0606A32C;
	Mon, 16 Nov 2026 09:43:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 042A0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=b/tck9XR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794822214; x=1826358214;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZLXdMjZSdnPw4vZYqATM3k2jfuyeh2FfD2QSdsLjbkc=;
  b=b/tck9XR27OfdXzCxEHBaTiVpnwBMZLjZmGw0GwAchwsdfLAz8+kcIpg
   XayfDdK4jLxqnjp3tChVFDRnEd3vDntqN+p/Z4mpW09G2NsATZqWdSNwp
   Wp3ZU9DnDsggT8JpgbpncVtlWR+JPspm42UPtaEEgrNJkFNFSpPI8Ig54
   bxWeJoPcYNAlcfgLOSjwsnQUdYSh+LQvxcMGxPr9OdvbAj722uM+oNtZb
   R2KejArcjC6PFqAGAIysHGxPTI1wRvmkywSeUwwAOcSulguOaM/WVZcF+
   MCIRS+vZZqJ0tfcZamM49ib2I0RaRPiQWdqCMNZwDWx+b7DB9uDK04jcW
   g==;
X-CSE-ConnectionGUID: RlvhuL14T52TVU9Z6V9rYw==
X-CSE-MsgGUID: hu6D5KkfQliTjlgXhpG5Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11967"; a="3444682"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3444682"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:43:15 -0800
X-CSE-ConnectionGUID: OSRgF9FqSTCaD1fLpmkP0w==
X-CSE-MsgGUID: N1z6ttoJQAqeqqk9GVw/7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9644707"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.90])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 01:43:11 -0800
Date: Mon, 16 Nov 2026 11:43:09 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: admin@tsv-stahl-riesa.de
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <avrQLQyTPODd4gcZ@ashevche-desk.local>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
 <20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
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
In-Reply-To: <20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 13, 2026 at 08:59:00PM +0100, Patrick Fischer via B4 Relay wrote:

> The CM3217 has no registers and no ID. Writing a byte to address 0x10
> or 0x11 sets command byte 1 or 2, reading a byte from 0x10 or 0x11
> returns the high or low byte of the 16-bit light count. The driver
> takes the second address from the second reg entry and falls back to
> 0x11 when there is no firmware node, as with new_device.
> 
> Command byte 1 holds the shutdown bit and the IT_T field (1/2 T, 1 T,
> 2 T or 4 T), command byte 2 the FD_IT field (800 ms down to 66 ms). The
> count scales linearly with both. The driver exposes FD_IT as the
> integration time and IT_T through the scale, so the scale list offers
> four ranges for each integration time.
> 
> The datasheet is not public. The bit fields, the reserved bits that are
> written as 1 and the startup setting of 2 T and 100 ms come from NVIDIA's
> downstream drivers (drivers/staging/iio/light/cm3217.c in the 3.4 kernel
> rel-tegranote-r8 and the 3.10 kernel
> android-tegra-flounder-3.10-nougat-mr1.1). One value differs: the vendor
> header defines 4 T as 4 << 2, which is outside the two-bit field. On a
> Tegra Note 7 field value 3 gave four times the 1 T count, so the driver
> uses that. For the resolution, Capella
> gives a range of 0.01875 to 119156 lux. The driver takes 0.01875 lux
> per count at 4 T and 800 ms. This matches both the upper end (65535
> counts at 1/2 T and 66 ms) and the 0.3 lux per count that the NVIDIA
> 3.4 driver uses at 2 T and 100 ms.
> 
> The sensor has no data-ready flag, and a new setting only takes effect
> when the conversion in progress ends. A conversion takes IT_T times
> FD_IT, up to 3.2 s. Leaving shutdown starts a new one at once, so the
> driver passes through shutdown on every change and waits one conversion
> period plus a margin before it reads the count. The timing was measured
> on a Tegra Note 7.

There are a few nit-picks below. But in general looks very good.

...

> +static int cm3217_read_count(struct cm3217_data *data, int *val)
> +	__must_hold(&data->lock)
> +{
> +	s64 wait_ms;
> +	int lsb, msb;

Reversed xmas tree order.

> +	wait_ms = ktime_ms_delta(data->ready, ktime_get());
> +	if (wait_ms > 0)
> +		msleep(wait_ms);
> +
> +	lsb = i2c_smbus_read_byte(data->client_lsb);
> +	if (lsb < 0)
> +		return lsb;
> +
> +	msb = i2c_smbus_read_byte(data->client);
> +	if (msb < 0)
> +		return msb;
> +
> +	*val = msb << 8 | lsb;
> +
> +	return 0;
> +}

...

> +static int cm3217_find_avail(const int (*avail)[2], unsigned int len,

This parameter is weird as we don't use at_least or so. It might be that
compiler can test it with the static const parameters supplied, but better
not to rely on that.

> +			     int val, int val2)
> +{
> +	for (unsigned int i = 0; i < len; i++) {
> +		if (avail[i][0] == val && avail[i][1] == val2)
> +			return i;
> +	}
> +
> +	return -EINVAL;
> +}

With all complexity this gives, I would rather make one helper per each case.

static int cm3217_find_scale_avail(unsigned int fd_it, int val, int val2)
{
	for (unsigned int i = 0; i < ARRAY_SIZE(cm3217_scale_avail[idx]); i++) {
		if (cm3217_scale_avail[fd_it][i][0] == val &&
		    cm3217_scale_avail[fd_it][i][1] == val2)
			return i;
	}

	return -EINVAL;
}

> +static int cm3217_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct cm3217_data *data = iio_priv(indio_dev);
> +	unsigned int fd_it;
> +	u8 cmd1, cmd2;
> +	int i;
> +
> +	guard(mutex)(&data->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:

> +		fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
> +		i = cm3217_find_avail(cm3217_scale_avail[fd_it],
> +				      ARRAY_SIZE(cm3217_scale_avail[0]),
> +				      val, val2);
> +		if (i < 0)
> +			return i;

		fd_it = FIELD_GET(CM3217_CMD2_FD_IT, data->cmd2);
		i = cm3217_find_scale_avail(fd_it, val, val2);
		if (i < 0)
			return i;

> +		cmd1 = data->cmd1;
> +		FIELD_MODIFY(CM3217_CMD1_IT_T, &cmd1, i);
> +
> +		return cm3217_write_cmd(data, cmd1, data->cmd2);
> +	case IIO_CHAN_INFO_INT_TIME:
> +		i = cm3217_find_avail(cm3217_int_time_avail,
> +				      ARRAY_SIZE(cm3217_int_time_avail),
> +				      val, val2);
> +		if (i < 0)
> +			return i;

In the similar way here. I think it it even grown in LoC, it will be not too
many,

> +		cmd2 = FIELD_PREP(CM3217_CMD2_FD_IT, i);
> +
> +		return cm3217_write_cmd(data, data->cmd1, cmd2);
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +	data->client_lsb = devm_i2c_new_dummy_device(dev, client->adapter,
> +						     addr_lsb);

I would make it one line.

> +	if (IS_ERR(data->client_lsb))
> +		return dev_err_probe(dev, PTR_ERR(data->client_lsb),
> +				     "failed to register second address\n");

-- 
With Best Regards,
Andy Shevchenko


