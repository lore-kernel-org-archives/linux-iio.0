Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C73386551;
	Wed, 13 May 2026 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778691423; cv=none; b=OtU/R7X8OVsL9coSFXX8Y9rOrBXcArFB09SFTZQHeSewMdn7VE/if5IWLMnl787apAFSdaKBO23mGfv13aVRRpuG4PJ+AdaiqIcQkG/UG8nufOEUOfs9cwwZKBklC4OgGDvOZ8AzMMsjhDhUWALznpQfWXRbtiAWXLKMAOngiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778691423; c=relaxed/simple;
	bh=urPbnKqvk3ZHbUkeLsbZ2u1ZcsQ2bu8Gk3DDa15ymeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UrQh9BND7p3Zz5gMWit1T5v9Gg9vi3ZEvR6ii03/0DlWzUaAfJo91Wzs6Sw1h7qcCw+wErkUgbmEF7ve7/qLvIliNbiam1s3zaacOg1l3vcbHY65BEEIcTVgaKV5iaoioo93XMQgm7pgGH05arYXgXPxyLsCHZwtF4SjGvT18DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dMbLOzBZ; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dMbLOzBZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778691421; x=1810227421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=urPbnKqvk3ZHbUkeLsbZ2u1ZcsQ2bu8Gk3DDa15ymeo=;
  b=dMbLOzBZ/HQhSqnwcYUPmWvP3O+Zvs9ebloKwKYNXST+xG54Dsx/RuYk
   TEaKmHVOH/xFCzKIQtLDWdzbEZ4kMENbfgY3NLHR4QFP/g9xZd0X2vYed
   yrN61q2cG6rwBdL040aBg9MrgX7eBWk4hKMKWNiCyO11JyCRozHZv+UVT
   lHzKJqy8OOIZMVOaNoltADsGjbzAdHhnTGEkhY/+xZ+cy13KlYBjVxb41
   FWZj8EquL7PDnpQO0RBytbcgBgUvn9yYaBxDeM2C6a+3k/ifz2PWVQHy6
   YJAU2BYCTmriu5CAEPqYSGiXoqdfRnzsqF2VrblRv5NvPbSl3al+fklwT
   A==;
X-CSE-ConnectionGUID: DvbacVf2Rvm9Xng5fNMU6g==
X-CSE-MsgGUID: TVqzfMO1SsCEp9aV/l5YYw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="83498095"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="83498095"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:57:00 -0700
X-CSE-ConnectionGUID: Owh6TnqvQn2SaHKzOWmwXQ==
X-CSE-MsgGUID: Q/yWXLZGTxy9OJtYioK0Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="235069502"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 09:56:56 -0700
Date: Wed, 13 May 2026 19:56:54 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <agStVi6NXRnQOOOO@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 05:49:44PM +1300, Javier Carrasco wrote:
> These sensors provide two light channels (ALS and IR), I2C communication
> and a multiplexed interrupt line to signal data ready and configurable
> threshold alarms.

Can you split this to two or more patches:
- basic functionality
- feature 1 (exempli gratia, IR)
- feature 2 (exempli gratia, multiplexed interrupt)
- ...

?

But let's wait for Sashiko if it swallows this big slice of the pie
and not choke on it.

...

> +	{
> +		.compatible = "vishay,veml6031x01",
> +		.data = &veml6031x01_chip,
> +	},
> +	{
> +		.compatible = "vishay,veml60311x00",
> +		.data = &veml60311x00_chip,
> +	},
> +	{
> +		.compatible = "vishay,veml60311x01",
> +		.data = &veml60311x01_chip,
> +	},

Oh, is 'x' is a real letter in the part number or a wildcard? If the latter,
please avoid. Choose the base part number instead.

...

> +static const struct i2c_device_id veml6031x00_id[] = {
> +	{ "veml6031x00", (kernel_ulong_t)&veml6031x00_chip },
> +	{ "veml6031x01", (kernel_ulong_t)&veml6031x01_chip },
> +	{ "veml60311x00", (kernel_ulong_t)&veml60311x00_chip },
> +	{ "veml60311x01", (kernel_ulong_t)&veml60311x01_chip },
> +	{ }
> +};

Perhaps use C99 initialisers, as there is an activity to change all drivers to
follow that. Jonathan, btw, what do you think we should do in the light of Uwe's
approach? Require C99 initialisers in new code, or something else?

-- 
With Best Regards,
Andy Shevchenko


