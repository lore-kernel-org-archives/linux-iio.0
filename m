Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07D833F589;
	Wed, 26 Aug 2026 07:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787729271; cv=none; b=Zy18aoUSTPQjVcjDPLJ8Y6o02ip0aCBf7ZEAhltRxT3mTBAzWm1RkROUgGJLoItIDZos6zRCxoDQ430RghYNOs4zjI6Rag6c8Ju7Oa6P0s47wQxaKsFwXtDPy1Bv42rAbjBC4mS1Z2b9yeFnrJrdAc+lmknOlvRpZG/slg1FssM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787729271; c=relaxed/simple;
	bh=GNR7ns7Ns3sdCOR5OtMGipxO9x433LO9assu298sSkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLJeq/KmzZE3h7xlPCaFbhtOaSBEZ6+YMGekIvpyDg0rOGYg1wudhKWjmX3xc+pfTpWRGS5M9PTtxld1RuiSkSpb3KS9PcNep1JkG5lTxKG90x6E0lc0mym3LDlfXsvSciYKqDjeNyQLrYm8CM3hKi5a6eR2X2BHhNeNRJKnC3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dO2FDL5N; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dO2FDL5N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787729270; x=1819265270;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNR7ns7Ns3sdCOR5OtMGipxO9x433LO9assu298sSkw=;
  b=dO2FDL5Nyz2cxucGu/EDsPErInxl7NabiJ652BGCVxRVFgQ+6oqPaFVL
   XLGP9D4gNuUgDRhaV82O1BNgV/qjDrwbGpk3cXliG3Yq2y3Ib4DcbFh+W
   ifkahCGscYbBdYU5ycyiI+pe3tKzguz3rj9LFXiQo+SmCWZfWNIMY48gf
   CjjSwruPjQemE0SACXHyNyJFZEceokANkh/L6b8PNGVEsDL+ivX+ogms6
   Dc5AnvQYG15qug1LT89QULwrU8z98nM/0JjLBtkSYp2h0C2h5NqhQt2lM
   GE+5fhT9L4pre+Rc1lJ/kI/eHYvY3mZwb1F9ehRWivtb0OAlTmckf4UHe
   Q==;
X-CSE-ConnectionGUID: /pydZ11mRmG23R8Fe7npTg==
X-CSE-MsgGUID: OfsXEA9xQd+sNMyqb+e9xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="91885660"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="91885660"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:27:49 -0700
X-CSE-ConnectionGUID: CatdtcIuShuEXX5ylwAgOw==
X-CSE-MsgGUID: 6E9IUNyJRs+A7WmZNzk2PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="269447556"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 00:27:45 -0700
Date: Wed, 26 Aug 2026 10:27:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	Christoph Muellner <christoph.muellner@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v6 6/9] iio: accel: mma8452: Reuse existing dev pointer
 in mma8452_probe()
Message-ID: <ao6Vbm59IX1cl7tj@ashevche-desk.local>
References: <20260825-mma8452-open-drain-v6-0-9b252804ee80@geanix.com>
 <20260825-mma8452-open-drain-v6-6-9b252804ee80@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825-mma8452-open-drain-v6-6-9b252804ee80@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 10:27:44AM +0200, Esben Haabendal wrote:
> In commit 32a5c04d4575 ("iio: accel: mma8452: Use dev_err_probe()") the
> struct device * pointer was assigned to local variable dev, so we can just
> as well reuse that throughout the function for sligthly more readable code.

...

>  static int mma8452_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);

This change is unrelated and should be as simple as

	struct iio_dev *indio_dev = dev_get_drvdata(dev);

OTOH, this might require the full device.h to be included...
Either way, it's not for this patch.

>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret;

>  	ret = mma8452_standby(data);
>  	mutex_unlock(&data->lock);
>  	if (ret < 0) {
> -		dev_err(&data->client->dev, "powering off device failed\n");
> +		dev_err(&client->dev, "powering off device failed\n");
>  		return -EAGAIN;
>  	}

Why? Just use given 'dev' as is.

-- 
With Best Regards,
Andy Shevchenko


