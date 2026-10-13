Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176AE32C8B;
	Tue, 13 Oct 2026 18:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915904; cv=none; b=ZlQabeHTFAD1gYSkJ2Or32VKiguYJAp6EHyAVh9sXy8ciAzT/rh0VmbmNdene9RCVE+clfs82UNDcaomYP5QOBW5D6M8MVYBSR1JenuC0Tu8xd/CqyLFkTkZd/SJW3a0JJllqxq01mEFNBdapcuOHz5k4siypqnexCgmhZOyc9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915904; c=relaxed/simple;
	bh=qGUhheLXJZ0bEsHWIiwj3QV75i/5ETHIBHc7I/BUuxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bSYJTfsocj8vy7mP2cF4fZIN+YApvN2/VBXM2WS8LHC4iKkvDLmCZJ8gDHVloo+HzaNEBGN/OyZ/3yBSW++ZmYd248ZEcqyasrdS6NozR5e6T2vPapy4L2QPIdh5RDskoeeOQREQzeBbde67eeprHp+1mzlhxFCoqjs/ZmXxcC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Tb94lAdb; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Tb94lAdb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791915903; x=1823451903;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qGUhheLXJZ0bEsHWIiwj3QV75i/5ETHIBHc7I/BUuxQ=;
  b=Tb94lAdb++ILtlPS6r3DnVUa6f7iJ/PJFeAXrfj+Q0IR1kWgReBwdUdn
   wZr4fYwmR7IDTOwQbpD7ypZ+RpLTtNmpj86LYN74piEQj+ZK/yej7avD9
   MmRQDrU9SLnF4G51BHGJafMxDG8EtYJyzUaS5zjxdC+oW8Z5EtrHWO0bP
   VV/tEWbEnzhCifnsMz3t4YaBmvCwmGQoJli1WMeGAsRsPrRoSP7iw4Ts9
   ojs+z95rTZyxVJQBRvlJWYHHGNjMlnj1fGkzNNhbA/uSwn7WF9FCPrrUU
   KN5cSZ6Mst/prLKn7+jVODZpLyxABt3tDifaFs4iqqYT2Uu/ozq0+wrUG
   g==;
X-CSE-ConnectionGUID: Iz4EnrhsSNiy535f4fn97g==
X-CSE-MsgGUID: e+q1fzXBT5uxIj2Dj0GsTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11934"; a="656424"
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="656424"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:25:03 -0700
X-CSE-ConnectionGUID: w4eVYpi7Rci/G6KcePLQYg==
X-CSE-MsgGUID: IB0P+yIATOSOjImv33rUig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,156,1787036400"; 
   d="scan'208";a="1150388"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2026 11:25:00 -0700
Date: Tue, 13 Oct 2026 21:24:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jan Remes <ciakval@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joe Sandom <joe.g.sandom@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jan Remes <jan.remes@mycroftmind.com>
Subject: Re: [PATCH 2/4] iio: light: tsl2591: add I2C device ID table
Message-ID: <as53evozT-V7RBoX@ashevche-desk.local>
References: <20261013143943.436816-1-ciakval@gmail.com>
 <20261013143943.436816-3-ciakval@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261013143943.436816-3-ciakval@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 13, 2026 at 04:39:41PM +0200, Jan Remes wrote:

> The TSL2591 has only the device-tree matching table, so it cannot be
> probed on a kernel with CONFIG_OF disabled.
> 
> Add I2C device ID table so that the sensor can be probed.

...

> +static const struct i2c_device_id tsl2591_id[] = {
> +	{ "tsl2591" },

Use C99 initialisers.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, tsl2591_id);


-- 
With Best Regards,
Andy Shevchenko


