Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B05384CDD;
	Thu, 27 Aug 2026 07:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787816862; cv=none; b=gJ394i21AxG22lH78w6Q3B5SHpLHQyNrW8teHpBpMdXR5U0VxYasD9qA/wpI7Jjb4u9QYnkkFFwZe/yI5rNNfbmXToUi4VJb+oAIfixa+S9lvy60GWzs64J4xif4vuuy5ff/iqtTopLOzGQYAxi3RC0j8J/GBZd0cMrmJ6MT3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787816862; c=relaxed/simple;
	bh=3mpc3/XGngghG/LQTi/xvQZzN6kYddA32cuozEHrGxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsVhcFS10SQFpnt/DmQPk1DJOPqQAcYIeFbxDvk87hFV9S5zKD0c9D7/PafN8l9gcuIk3+J+oZppIHY16oZO521wqy6k/hT2G6/k4GGfDug3dLGcZiohGwOFHGYNM5zVo2LgbG3olvyyFQHegyABmN7vAoBEImkez02QGGHBKG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OajNQSO6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OajNQSO6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787816860; x=1819352860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3mpc3/XGngghG/LQTi/xvQZzN6kYddA32cuozEHrGxk=;
  b=OajNQSO6OxfAifP2APZ1aAxESKFKL9H9wgRuMfL1IbzvQyUwtGeFw4jI
   H/M8vaeuTEYotbZJsiSRBXmp5vJq3WK2A6s3SlOQxmWPoYjJ6fg7db6Gp
   lIgDxVNhWHe6Bq+orID380337kP7BNGm1K91xY3Y8yz09V2KUbyzcJ1bX
   f9oUCJ0fRWKNLhQg+6kZw7/PnFl9gLCzwlxmmpmmT4lMx/yPOKCcu6Ovk
   mGWoUUusDNbPqbMs+LEqTA/dGLyXEZ6+bHOwpjmapmuPjx5RCTjz59TUU
   vIHyQb34a5Fk/ula7fZnQq1ewUBuVfZaP39RotBde2KbR2xA5XssmwQqX
   Q==;
X-CSE-ConnectionGUID: fHDi2ESJQmuacQ2HTpzt+w==
X-CSE-MsgGUID: 5LEVH0jvTQWQ0ZGgoXThtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11887"; a="88188380"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="88188380"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:47:36 -0700
X-CSE-ConnectionGUID: o8G2RghJQNClq4EAEQF29A==
X-CSE-MsgGUID: OuWmlL7TRgCEFkoyJ8qbIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; 
   d="scan'208";a="297678682"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.125])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2026 00:47:32 -0700
Date: Thu, 27 Aug 2026 10:47:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jorijn van der Graaf <jorijnvdgraaf@catcrafts.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	Luca Weiss <luca.weiss@fairphone.com>
Subject: Re: [PATCH v2 4/5] iio: light: stk3310: add per-chip match data
Message-ID: <ao_rkVztBCSQfQno@ashevche-desk.local>
References: <20260826175409.326131-1-jorijnvdgraaf@catcrafts.net>
 <20260826175409.326131-5-jorijnvdgraaf@catcrafts.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826175409.326131-5-jorijnvdgraaf@catcrafts.net>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 07:54:08PM +0200, Jorijn van der Graaf wrote:
> Introduce a chip_info structure carrying the device name and channel
> specification, attach it to every i2c, OF and ACPI table entry, and
> let probe take it from the match data, failing when there is none.
> Every firmware bind path carries match data, and with the id names in
> lower case a client instantiated through the sysfs new_device
> interface under a compatible-derived name receives it through the id
> table. The shared channel definitions move into macros.
> 
> The ACPI table entries change to named initializers, matching the
> other id tables.
> 
> This is a preparatory change for a variant that provides more channels
> than the existing parts. No functional change for firmware-described
> devices; a sysfs client under a name that binds without matching any
> id entry (the full compatible string) now fails probe with an error
> instead of probing as an stk3310.

...

> +/**
> + * struct stk3310_chip_info - chip-specific data
> + * @name: device name reported to the IIO core
> + * @channels: channel specification
> + * @num_channels: number of channels
> + */
> +struct stk3310_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
> +	unsigned int			num_channels;

I don't think we need tab-based indentation of the field names.

> +};

...

>  static int stk3310_probe(struct i2c_client *client)
>  {
> +	const struct stk3310_chip_info *chip_info;

	struct device *dev = &client->dev;

>  	int ret;
>  	struct iio_dev *indio_dev;
>  	struct stk3310_data *data;
>  
> +	chip_info = i2c_get_match_data(client);
> +	if (!chip_info)
> +		return dev_err_probe(&client->dev, -ENODEV,
> +				     "missing driver data\n");

Use -ENODATA

		return dev_err_probe(dev, -ENODATA, "missing driver data\n");

>  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>  	if (!indio_dev)
>  		return -ENOMEM;

-- 
With Best Regards,
Andy Shevchenko


