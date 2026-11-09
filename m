Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266084;
	b=vguqtqfFJ7Eqfe/SQA5o0fnP7Cs0nvkTuVY6aYDugXl10JcZr5Z/2qxRGXeciEEpH7Sn
	 OKPpry7Dg3P4s95TD2om9eJLTS+NeBeVX/HDNJ3vt37gFlFQ/KVSzkoPVDSUbfEMLB92Q
	 zuqQb6FNnUc1HM2ChtXBwI7qmZixa/jMuczW2F04eJixPcB8KFQYdViUmJ7fkkE6dXOk/
	 LsSMAu0+jocuRzR7KuzXCVZmbPXbe/mJQ7KdKjsctuBSGSzCwigG59DdizSgMxsPLEnz8
	 4oPxIWa9e48lLQJSo0lpP6Z58Ha9+s8SC5/2+3iRuNqOREYbFcGKQ3dzLUE3wJy6KDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266084;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=CA8oxOfNWkyRfRkpN5+GCFsKEO1plCpY8w9DA3leZ2E=;
	b=5fJPS7sbDYwNcYupjqy9RN5iiqZFgGpMVSpjciyj8mkWhWbM1D2BRNpSsetd40nLjGXx
	 Yd9EfZE7/9GRvxHrXO+NJvP3LtRgHSrUF3AB9f2+p1OWq764H8s9aH9dFzxN9uiZ8AGFk
	 31N8qeT7J9VznOZZZorse9exVZxDxkLGSP/xrPPV13qL1iAOXadBZlsGZKfpMZXopRNY3
	 USelQdXr62AlVa/O8tAWyfUend5aOLxaGQNGUsJTEP6DrENmPsq2qtHkdaUrU8jmekGbE
	 UQcApcZ99DzTlc88/b0mU9GBRg/suqRydiOp5RHushQu5nGOFy0Z7f0PzDpPZnWQMfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWhTxoa8;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E88D7606A31C;
	Mon,  9 Nov 2026 23:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E88D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=EWhTxoa8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794266084; x=1825802084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MehuQL4U6cstjaP13aY7pSpZfHsKcxcvjlN0DFYPXRQ=;
  b=EWhTxoa8xPdJN0D4/OOKZofVfUPzfzh9yUbb3cH7AOONJJHx1JQr/U22
   IEtNaTd4ViUDpZOFiinRgp4UHCqXsAFrPANd3q7DTc2gD6iSGNu87Omi3
   VLe1cZuvAkMlnZLcQlLbIipDjuvvMrPcUscJc3KL+thCt+8tAcgdZXkbB
   SwK8hviH1mSAXXB/fA9PmmY7K5jr9YhH4ge53v81dsnR00rBkLTzkWdHS
   ZkHEV+9r9Y92p88NSbxUNfBKN2WPSjGl175OhA0K0N72vY/WIYc4umZcK
   lCHnTIQGWWCzhDx5r1XokmwGN3ZCKL7kqxtk07X+d7IrPsqRvAdYvF6IA
   w==;
X-CSE-ConnectionGUID: K8Kbsd63TfWg2ADVyvS5xQ==
X-CSE-MsgGUID: aLL516JtSFeiYtKd8sWumA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3014367"
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="3014367"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:14:43 -0800
X-CSE-ConnectionGUID: AYiUQYxFSZO3OZO6G1QzKg==
X-CSE-MsgGUID: O+evBWJaQi+fg6aOhDuoRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,204,1787036400"; 
   d="scan'208";a="8321051"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.144])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2026 15:14:41 -0800
Date: Tue, 10 Nov 2026 01:14:38 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linus Walleij <linusw@kernel.org>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kyungmin Park <kyungmin.park@samsung.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 4/5] iio: light: gp2ap020a00f: Prepare for chip
 variants
Message-ID: <avJT3lRSjhl0EPmD@ashevche-desk.local>
References: <20261108-gp2ap030-v2-0-24eaa1b9fe59@kernel.org>
 <20261108-gp2ap030-v2-4-24eaa1b9fe59@kernel.org>
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
In-Reply-To: <20261108-gp2ap030-v2-4-24eaa1b9fe59@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 08, 2026 at 10:44:02PM +0100, Linus Walleij wrote:
> Introduce chip data for the device name, initialization table and channel
> layout, including the channel count. Use I2C/OF match data to select it
> during probe, preparing for sensors with shared register layouts and
> different initialization settings.
> 
> Populate only the GP2AP020A00F data, keeping its register values,
> channels and operating behavior unchanged.

...

>  	data = iio_priv(indio_dev);
> +	data->chip_info = i2c_get_match_data(client);
> +	if (!data->chip_info)
> +		return -EINVAL;

-ENODATA

...

>  static const struct i2c_device_id gp2ap020a00f_id[] = {
> -	{ .name = "gp2ap020a00f" },
> +	{ .name = "gp2ap020a00f",
> +	  .driver_data = (kernel_ulong_t)&gp2ap020a00f_chip_info },

It's unusual style, either make it 4 lines or 1 line per entry.

>  	{ }
>  };

-- 
With Best Regards,
Andy Shevchenko


