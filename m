Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9CD255F28;
	Tue, 18 Aug 2026 13:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059980; cv=none; b=NayRE16lE5ShPkCmy8WRaMqxDjq4SB166jYYpVXj9IRyQT9+eQci+ZG2cN8XDZ2ORLfNrCEuBboWLLLZ0/JsjjZn3YbDrUxod6nRaCIPmRIUntDR6ccyi6IR63a0l7c5+WeGCJpWFsJzZWKdcVFK6kubasRLDu5xKHkEsd2k3aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059980; c=relaxed/simple;
	bh=DRIQ/EfZQjLrZttEMIKd3G7pXaVqlnHuo1kW46tLBMM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VGH45gkfqSzN09Qo4eD6Q95JMbwi2Lt4LYa/oHmwxfGUhl27UICpHiXeDMr7PzjPkfI85ChQD5PZswgvf4AXlHrx9nL0bu726sOZgT30bgOomxBmUpBEGSZYs7jEdcE9BjluFweBC+u0zn1D/VXQb7eKrUDZ1kaiIq6tweGBo5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KZB7TB/X; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KZB7TB/X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787059979; x=1818595979;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DRIQ/EfZQjLrZttEMIKd3G7pXaVqlnHuo1kW46tLBMM=;
  b=KZB7TB/XGAAZnv4GH4ArQOh/fNYbAvs8+GzDIVPWisxktSD8B5PXXzoJ
   0RDfOV2lov7LeGYI/LVSAv3OuCRe9k6fsSCkAys4o/RZspa+J+4KFVHUY
   VF4AGBb1RuH6ttf6XLAW9ldT6Sa29cRo3Ph33paA7C7aYrf1G7E9RfU8S
   6tB1RQ1DE/XoDY0VjaMhGLePXwY9095sxu27PxY+KIicTpuWbhfKQqSfB
   qtt0qac4ejWQda57w1F8WNfnMkiRRLoweqhU/8pHY02U7VH+AbyytJnf+
   qFw5e8rW0dfHhjK9PO6dZbDp/pfqJ8hmcouT1mc6ph3R1MgETi1ZFoMI4
   A==;
X-CSE-ConnectionGUID: mswQSou+TgqBGhv4ePKrGw==
X-CSE-MsgGUID: IEh59GqpTpeElOji5U6Pcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="91422324"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="91422324"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:32:59 -0700
X-CSE-ConnectionGUID: r3T+TgJtRLG1V6gJUXfXDQ==
X-CSE-MsgGUID: OycAPORwRMiXfXHwkfaVRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; 
   d="scan'208";a="269067785"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.209])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2026 06:32:56 -0700
Date: Tue, 18 Aug 2026 16:32:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/4] iio: light: veml6031x00: add support for
 triggered buffers
Message-ID: <aoRfBb1mruUxS8Xt@ashevche-desk.local>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
 <20260818-veml6031x00-v7-3-2b0de0f20edf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818-veml6031x00-v7-3-2b0de0f20edf@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 18, 2026 at 01:34:28PM +0200, Javier Carrasco wrote:
> Add triggered buffer functionality for the two channels the device
> provides (ALS and IR).

...

> +static irqreturn_t veml6031x00_trig_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *iio = pf->indio_dev;
> +	struct veml6031x00_data *data = iio_priv(iio);
> +	struct regmap *map = data->regmap;
> +	IIO_DECLARE_BUFFER_WITH_TS(__le16, scan, 2) = { };
> +	unsigned int i = 0;

Split assignment, so the code becomes robust in case this variable gets reused.

> +	int ch, ret;
> +
> +	if (test_bit(VEML6031X00_SCAN_ALS, iio->active_scan_mask) &&
> +	    test_bit(VEML6031X00_SCAN_IR, iio->active_scan_mask)) {
> +		ret = regmap_bulk_read(map, VEML6031X00_REG_ALS_L,
> +				       scan, 2 * sizeof(*scan));
> +		if (ret)
> +			goto done;
> +	} else {

		i = 0;

> +		iio_for_each_active_channel(iio, ch) {
> +			ret = regmap_bulk_read(map, iio->channels[ch].address,
> +					       &scan[i++], sizeof(*scan));
> +			if (ret)
> +				goto done;
> +		}
> +	}
> +
> +	iio_push_to_buffers_with_ts(iio, scan, sizeof(scan), pf->timestamp);
> +
> +done:
> +	iio_trigger_notify_done(iio->trig);
> +
> +	return IRQ_HANDLED;
> +}

...

Also no need to resend, this is minor thing.

-- 
With Best Regards,
Andy Shevchenko


