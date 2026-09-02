Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF233876B2;
	Wed,  2 Sep 2026 05:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327567; cv=none; b=oh0CAxkwzRRdPgx4ir6gKObsrUgWj3apf9zPYJzPVixUZdnBtaN/XB3MozZRxZb1OczIYvBvAoS3fArWEFzUDF2uYTY4QqfIdEnmZBVbW0RNsl0HvP3MRD4iZds/Q2MeuhfgQ2PjxB2RqsBuufcgfBfBSK97CexdJ4/UDRRpeFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327567; c=relaxed/simple;
	bh=X0aYQPY8bRCoxLfrztyM62w6yYUnGlflclRm2b+Ndyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mdPCHgl4yMDqwxp86DasEyIoO/7WvncepM2+Mtt4n9Sp1+IzFBXXq0l6OcriSEoysn1X5F59cuuiGFSHztcmgcNjJkMuhz+V7vluxAmZSoiC9bHPPduSyST7u0eyVU02cauVh23cx2bcsNgfr3Fic073lQM0iAP0HtDv6Ial2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6ts/g+l; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6ts/g+l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788327565; x=1819863565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X0aYQPY8bRCoxLfrztyM62w6yYUnGlflclRm2b+Ndyk=;
  b=E6ts/g+lBsQyKyZfRz0H6TLTavt86Ga5Fi2kxfzGSty/FHHnwzgY5wKs
   qJ+prJQQK/dVHofThzGnWCZq1vjPiAYEVVMNPoOTNhDpka2kMuHvU3aMB
   Z9UeI0WalxkhlxBhFsfQbKhI6kCuChgOSSZ38MHhW05nlLU4aW1Gnv3D0
   Ll4W+SC3uyTdexWTxE2S0RBh1/FYQhKrdGBK//LhJ/OogZd8SPMqdt9AP
   P+9dMbwd1xMUwWZQqNJh339/0bZX9Lwwezqzu1pS7Fj/aAbMINBnSYgu3
   aiYC7ANqUujN23sqHp1y6qbbJyVUj6QAsw+AICoWV4r9HWqG+xN2bbPvt
   w==;
X-CSE-ConnectionGUID: WrnMaeEbQOGbbtb+fp0GuA==
X-CSE-MsgGUID: U6rfkuFpQSWxar0zOgsOvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="114315975"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="114315975"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:39:24 -0700
X-CSE-ConnectionGUID: e7ceWCaqSgGuCM2i7LyXhg==
X-CSE-MsgGUID: OugxhUzaRHOVrga+XPj2+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; 
   d="scan'208";a="266703839"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.118])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2026 22:39:20 -0700
Date: Wed, 2 Sep 2026 08:39:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <ape2hk7bFNTYK5Zr@ashevche-desk.local>
References: <20260901184302.8127-1-flaviu.nistor@gmail.com>
 <20260901184302.8127-2-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901184302.8127-2-flaviu.nistor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 01, 2026 at 09:43:02PM +0300, Flaviu Nistor wrote:
> Add support for label sysfs attribute similar to other adc devices. This is
> particularly useful because the label can match the schematic signal name,
> identifying channel voltages easier if label is defined via device tree.

...

> +static int ads1015_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +	const char *name = data->channel_data[chan->address].label;

> +	/*
> +	 * Avoid printing "(null)" in the console in case label property
> +	 * is missing for the channel.
> +	 */
> +	if (!name)
> +		name = "";

No need, you can assign below whatever you want for the default case.

> +	return sysfs_emit(label, "%s\n", name);
> +}

...

> static int ads1015_client_get_channels_config(struct i2c_client *client)

>  	struct ads1015_data *data = iio_priv(indio_dev);
>  	struct device *dev = &client->dev;
>  	int i = -1;
> +	const char *label;

Keep reversed xmas tree order.

...

> +		if (!fwnode_property_read_string(node, "label", &label))
> +			data->channel_data[channel].label = label;

We want something like

		if (fwnode_property_present(...)) {
			ret = fwnode_property_read_string(...);
			if (ret)
				return ret;

			...use label...
		} else {
			...assign default...
		}

-- 
With Best Regards,
Andy Shevchenko


