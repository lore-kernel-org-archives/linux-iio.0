Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832C04A2A79;
	Tue,  8 Sep 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788863499; cv=none; b=MC5OzwzOc0HaU5uUmaNtf0REK175rqjT4DOKau6FjMcu39WjRPJ6R5jpzK6pC5wiGDxoi5h1v2jzcMWPaXD16fsIk8TXmOa2qLhyiKYNyec4xF94vcP9zMm/HSS1gOx+i0M/CqxDEvI1wTuaWHXkVqZB3Xm9n5yNNu7Z5Mr+/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788863499; c=relaxed/simple;
	bh=ZTsHRPhqlZKepMOErbLGI/CG3t1KSDXVSJBq+fKZQcc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqCEQWqRUTPkFKkGsEXIF+/d/xX7fpbatd1Lx2PBDRMpgLGB7HT2A11DnIVZi8HS0IB9wRNb0BS1Q0uDaY5jHshl1Tf89oWz+QbRU5NGER10Ao6LsKgrw1Vic0C9BHLMaq68BQc197y72vqd+PtyYpr88h7qnb8mI/ZJYln1s/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbg3IS8b; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbg3IS8b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788863497; x=1820399497;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZTsHRPhqlZKepMOErbLGI/CG3t1KSDXVSJBq+fKZQcc=;
  b=nbg3IS8btECEi6R2UCYOJLzXbXkCUFijS4v9WAw1s+DA2w4dkS0JP5uO
   IuJFE5zCyh64S3bi768yA87wenu8/swZCTwiLKQfRiq28964VBlMX9AiD
   Y6sz2fnJ+5yxazi/YLdIod9/CfKwvLUSHXjbiFIeUImQ6ThneyRjTm7pL
   mtgXe6bv/nAxDqNPZqNlDRgw+bcU9wCHJnvuPR6FAsyZ213RPmH+coscs
   DgPh4RgO/WptYOJa9HiNnnNQmQe5hdjHd/lYwLE5yjAspwzXEij5zcPaT
   /45uOUNU2F9Gh8cKIJ3hKV9XzadMQGcckMiMAYntPDDmrDLh9vjb84IhN
   g==;
X-CSE-ConnectionGUID: qDlZ+BfxQT2VlqcdL/uDjw==
X-CSE-MsgGUID: grpOOMgURuiJsmmQQYYHrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="99593074"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="99593074"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:31:37 -0700
X-CSE-ConnectionGUID: ulMrxIieQF6pCXIMlkSjCQ==
X-CSE-MsgGUID: SQY0KR0YTNODtewELi0l6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; 
   d="scan'208";a="272888162"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.92])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2026 03:31:34 -0700
Date: Tue, 8 Sep 2026 13:31:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Flaviu Nistor <flaviu.nistor@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1015: Add support for label
Message-ID: <ap_kA8laT70faM9B@ashevche-desk.local>
References: <20260907152304.4992-1-flaviu.nistor@gmail.com>
 <20260907152304.4992-2-flaviu.nistor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907152304.4992-2-flaviu.nistor@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Sep 07, 2026 at 06:23:04PM +0300, Flaviu Nistor wrote:
> Add support for label sysfs attribute similar to other adc devices. This is
> particularly useful because the label can match the schematic signal name,
> identifying channel voltages easier if label is defined via device tree.

...

> +static int ads1015_read_label(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan, char *label)
> +{
> +	struct ads1015_data *data = iio_priv(indio_dev);
> +	const char *name = data->channel_data[chan->address].label;
> +
> +	/*
> +	 * Avoid printing "(null)" in the console in case label property
> +	 * is missing for the channel, or channel is not defined.
> +	 */
> +	if (!name)
> +		name = chan->datasheet_name;

Is the datasheet_name static? Can this rather be made only once
at the probe time?

> +	return sysfs_emit(label, "%s\n", name);
> +}

-- 
With Best Regards,
Andy Shevchenko


