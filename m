Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020CE280A58;
	Fri,  6 Feb 2026 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390898; cv=none; b=G3OqgpFWwC41yTXP1FkV7mNO6mjtSh1eh0FCMvT3Bp9jZQphHFfgfOUJY5yqm2qHEe4czyE1NXtOA48xb5MTxxd3VK2/uFp10wTJPKEeiaPZxaztRz9Qe7QvpbC/AlsYN+WLM17LJFFHsHP5MHY62wj9IlNltufseBocy38PRsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390898; c=relaxed/simple;
	bh=bOl60S6rQ8W24TM/j1b8VfvaCFZ9ERjf7JbAY7mLSyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM6kPXeOwbX8QjGF4xgH0lZbRzmfJnLa0HFkzlV/Cyz6voDFJeWEWHVhOlD03PPFkqNLEV6qFQEa2dYEwZLnseK9eAIRpwHzLE4leZqf1GwmLkLRkl0hT6ROycu7qlkLOhR51SdGEygxyZzHxgRUqS3UFhKA97d/Cg5r/W6VUkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XnFbQGip; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XnFbQGip"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770390898; x=1801926898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bOl60S6rQ8W24TM/j1b8VfvaCFZ9ERjf7JbAY7mLSyM=;
  b=XnFbQGipaazmxLEqDg8Ge5rk6cl3cE7N3lhfo0tLe3ALUjilHg6Xsquk
   P8K9ytDKsgkXMMnbcDhCtIyuuIQGmnu60g8iRJs3OyfjSDsNehes70uon
   X0jl7+t2EVxUKTbGWHiI313wTOB4yfaP6w4hLoRk0OGYfaumbnu6pRJMs
   p7SmYIDakSXHAn4Kz2V94wX2D4FAaC581jbm+5rJVwIlIjvHxsH4c04sV
   tlCwbjOwtiAlKo25wu+O8Ymv3YlreLx2RMt9nLD64kMhIFZqdKTHFV5tS
   JMDb6EIiABXGORYUSjWcah4beQ7gdrDECRVE7ziMkMp+CV3rxhwbEt2M9
   A==;
X-CSE-ConnectionGUID: Th2ZDn4jRp+srTi/1ilzzA==
X-CSE-MsgGUID: Gy/RwmhOTXi5fFYcMnSELA==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="89177031"
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="89177031"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 07:14:57 -0800
X-CSE-ConnectionGUID: aYrZEyemSx2DbCKwoba/2Q==
X-CSE-MsgGUID: X6MD5q85R/Cqhrd8ZNmcgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,276,1763452800"; 
   d="scan'208";a="210174008"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.202])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 07:14:55 -0800
Date: Fri, 6 Feb 2026 17:14:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <aYYFba5-ZV8VuZHM@smile.fi.intel.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
 <aYXvP5FLA5BvkoVX@stanley.mountain>
 <aYX016NlTNkJzGdT@smile.fi.intel.com>
 <aYX7tlJ593KBDGW0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYX7tlJ593KBDGW0@stanley.mountain>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Feb 06, 2026 at 05:33:26PM +0300, Dan Carpenter wrote:
> On Fri, Feb 06, 2026 at 04:04:07PM +0200, Andy Shevchenko wrote:
> > > drivers/iio/dac/mcp47feb02.c
> > >     712 static int mcp47feb02_init_scales_avail(struct mcp47feb02_data *data, int vdd_mV,
> > >     713                                         int vref_mV, int vref1_mV)
> > >     714 {
> > >     715         struct device *dev = regmap_get_device(data->regmap);
> > >     716         int tmp_vref;
> > >     717 
> > >     718         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale);
> > >     719 
> > >     720         if (data->use_vref)
> > >     721                 tmp_vref = vref_mV;
> > >     722         else
> > >     723                 tmp_vref = MCP47FEB02_INTERNAL_BAND_GAP_mV;
> > >     724 
> > >     725         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X1, tmp_vref, data->scale);
> > >     726         mcp47feb02_init_scale(data, MCP47FEB02_SCALE_GAIN_X2, tmp_vref * 2, data->scale);
> > >     727 
> > >     728         if (data->phys_channels >= 4) {
> > >     729                 mcp47feb02_init_scale(data, MCP47FEB02_SCALE_VDD, vdd_mV, data->scale_1);
> > >     730 
> > >     731                 if (data->use_vref1 && vref1_mV <= 0)
> > > --> 732                         return dev_err_probe(dev, vref1_mV, "Invalid voltage for Vref1\n");
> > >                                                           ^^^^^^^^
> > > vref1_mV is not a valid error code.
> > 
> > Why not? When it's negative I believe the above statement is not true.
> 
> I saw this as just sanity checking the input.  vref1_mV is never
> actually negative.  I don't know if devm_regulator_get_enable_read_voltage()
> can return less than one millivolt.

 * In cases where the supply is not strictly required, callers can check for
 * -ENODEV error and handle it accordingly.
 *
 * Returns: voltage in microvolts on success, or an negative error number on failure.

What did I miss?

-- 
With Best Regards,
Andy Shevchenko


