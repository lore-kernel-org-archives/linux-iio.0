Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A342D7812;
	Tue, 30 Jun 2026 11:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782819371; cv=none; b=QimsD6kzEkEdIXf2ZTmBUb//akn+qQ8JJcgePiEM71+XC5zliwFMk2QLB0sQr0NrfPTEYr02NTg7BMV7borLPOkgU/Reu8bo0/08F+xSuJnjX4wwEOEc5HqEg+8NAoFGNaM7Hsua3kgedlSgq2dcgztN8z+kq1CFjpPV0fTtxig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782819371; c=relaxed/simple;
	bh=AOrSt0ytGcYunDyeVrE2mtXF0JUE9sF29fmLH+8Phdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNSiFWShO73qZlYvjop48rdZrT8UsPXXZfB6nhCdrCyQuxzN3yX6Et6YTLZ5gL/zcVuQhu2mwZtONl0VP6guguCZa5qn5GNC3frV3aoc8p2rTQVUMkC2liwz8cuqGC0ASF8ZnBb2qIWKVbupikwZ2aNpGv7TKaeRUDt+/WHjReo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sn3gmX/C; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sn3gmX/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782819369; x=1814355369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AOrSt0ytGcYunDyeVrE2mtXF0JUE9sF29fmLH+8Phdg=;
  b=Sn3gmX/Cc/fiM89DVq/HUSBqYY/Pe4k2OOI71ZkixfT20LXajSWKZn11
   pvoUKDeJbgJl0ASFJC1xFefBN2Jc4NEuJjXAYkdO7xMAy1AOL9f3ugbDo
   ZuklgjCSOl8dPnp/j5hDFhBlSjvG3x3WYHs6VMUj1tkalqM9iPr3m7y2a
   R8W3H9otlLoFL1wAZyyWB1w1JmIBBRNo52LI7KzG2PJ8OOdV5QdZw1Xq/
   F9uG4SV4HI1L7fjSL+3oBUoFcXwjBAvWNgDDJhS/y8jmU87pEWm2X/RAo
   PR2dErVkaKgz/rb/68oq1ZPMOdpJIhGpog6vMOlkzhRBHwrUDhUb2ZMz7
   Q==;
X-CSE-ConnectionGUID: yN068zpnQMOGjtSoHlayNQ==
X-CSE-MsgGUID: 28LCPedXTWScdASW1IMySA==
X-IronPort-AV: E=McAfee;i="6800,10657,11832"; a="106322016"
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="106322016"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:36:09 -0700
X-CSE-ConnectionGUID: 89L1EsSsRTC/WowA+Ca0PQ==
X-CSE-MsgGUID: Ot9jzLlnQeGvcaeGclJhug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,233,1774335600"; 
   d="scan'208";a="255833692"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.96])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2026 04:36:04 -0700
Date: Tue, 30 Jun 2026 14:36:01 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
	andy@kernel.org, antoniu.miclaus@analog.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, dlechner@baylibre.com,
	duje@dujemihanovic.xyz, jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com, joshua.crofts1@gmail.com,
	krzk+dt@kernel.org, linusw@kernel.org, linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com, mazziesaccount@gmail.com,
	mike.looijmans@topic.nl, nuno.sa@analog.com, robh@kernel.org,
	sakari.ailus@linux.intel.com, wens@kernel.org
Subject: Re: [PATCH v4 1/3] iio: adc: Fix incorrect reading when datarate
 changed in single mode
Message-ID: <akOqIVDibovrbBAK@ashevche-desk.local>
References: <20260622221550.374235-1-jakubszczudlo40@gmail.com>
 <20260622221550.374235-2-jakubszczudlo40@gmail.com>
 <ajpO9zaZbIl3x1uC@ashevche-desk.local>
 <20260629235118.1abc4067@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629235118.1abc4067@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 29, 2026 at 11:51:18PM +0100, Jonathan Cameron wrote:

...

> > >  	size = data->supports_data_rate ? ARRAY_SIZE(ads1100_data_rate) : 1;
> > >  	for (i = 0; i < size; i++) {
> > > -		if (ads1100_data_rate[i] == rate)
> > > -			return ads1100_set_config_bits(data, ADS1100_DR_MASK,
> > > -						       FIELD_PREP(ADS1100_DR_MASK, i));  
> > 
> > > +		if (ads1100_data_rate[i] != rate)
> > > +			continue;  
> > 
> > This will look better if you break here and add a check
> > 
> > 	if (i == size)
> > 		return -EINVAL;
> I just saw the result of this in v5 and wondered why?
> 
> i is controlled by the for loops stuff only so i never == size.
> I'm not sure what intent of this comment was.

Meant to add 'break;' and move the actual check to outside of the loop.

> I am fairly sure what Andy is suggesting is the following..
> 
>  	for (i = 0; i < size; i++) {
> 		if (ads1100_data_rate[i] == rate)
> 			break;
> 	}
> 
> 	if (i == size)
> 		return -EINVAL;

Yes, that one. Sorry for the language confusion.

> 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(&data->client->dev, pm);
> 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> 	if (ret)
> 		return ret;

> //note that we 'could' do what some other users of ACQUIRE_ERR()
> //have allowed
> 	if ((ret = PM_RUNTIME_ACQUIRE_ERR(&pm)))
> 		return ret;
> 
> I'm open to hear if people think we should allow this or not.

I'm against that. The style is prone for errors and readability issues.

> 	ret = ads1100_set_config_bits(data, ADS1100_DR_MASK,
> 				      FIELD_PREP(ADS1100_DR_MASK, i));
> 	if (ret)
> 		return ret;
> 
> 	return ads1100_poll_data_ready(data);
> }

-- 
With Best Regards,
Andy Shevchenko


