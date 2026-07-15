Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FA9314D13;
	Wed, 15 Jul 2026 06:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784097765; cv=none; b=rKNebUpx4nAz9zpT85iYQNUTmQ1DfYQtmo+d7rSVx0IFSCq88BJ0Z8vCpXywftpw4SI0BYzw9xZytjkQK8C8nlb6LBHmvubrYy/Wfekg8SSfvsYBYGU1IGph2rIUsdo4UUkigG/JMOl7LH+LXdiYFIDHtZL59v2uNW0E2WZs8mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784097765; c=relaxed/simple;
	bh=PH8yYsZVplyMRBBIC+qn//UkncjaepSOmNKRXjE1aRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fa+/oxl07rFsPX+bXcNlsS5J3VSAEUFYTFYAFnRfdoILA81CrCehFvzfZxc9L0eCgONVP5fE5oKiB6KXZMZaO7gEJhWQ6rkvolsiAaHR3xehz8Va2TaFNEp0eFtCDbRrAT08SyKXZVAAh5+YDjJUaDgEI7pXROCCORHHqbIOHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NofJ0n4a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NofJ0n4a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784097764; x=1815633764;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PH8yYsZVplyMRBBIC+qn//UkncjaepSOmNKRXjE1aRY=;
  b=NofJ0n4avQh2wIQJP68Lxx8/8mTzS/Fq2g4chgHkT5/ixQ7nHhiSOK+9
   +ek32n+H9OXWaX+xj/4agSfpiCKTuX4Bd6LkwZO5jHQsgTBKZBX+gc86B
   RjT00nPo/zzonH/E7h9y7C2SqGQv8c5JmZ2xCToeUET9qEH37VsEfUbE8
   xvFPBHrygMSZ3zqXXQixTval9JRK4GDSbyMcXWCaP1v2RivPjNBl16Y++
   gd4WydoiuM625arhOgAvWNhJc8HIkTiznK/9yyUfHIZrl8PLvlBELaT5v
   ANAJN9VxnXRVTSd47vfsOGQbyDZJAtsh7LBFB0LVhgDtK+Pmd+lH3RoKA
   Q==;
X-CSE-ConnectionGUID: EbZlKU4pQI+koVqmoEwtaQ==
X-CSE-MsgGUID: kKo5tp5dSi+sqxlPTH+Ilw==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="84507089"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="84507089"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:42:43 -0700
X-CSE-ConnectionGUID: oelYCXWDT42KFq3zb/CCkg==
X-CSE-MsgGUID: fVbtJBQwR+qraZxkYkAv+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="280517716"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.44])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 23:42:38 -0700
Date: Wed, 15 Jul 2026 09:42:35 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jakub Szczudlo <jakubszczudlo40@gmail.com>, linux-iio@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, andy@kernel.org,
	marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mike.looijmans@topic.nl,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jorge.marques@analog.com, antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com, jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz, wens@kernel.org,
	sakari.ailus@linux.intel.com, linusw@kernel.org
Subject: Re: [PATCH v7 3/3] iio: adc: ti-ads1100: Add ti-ads1110 support to
 ti-ads1100 driver
Message-ID: <alcr28F603bH6TBM@ashevche-desk.local>
References: <20260714195528.597753-1-jakubszczudlo40@gmail.com>
 <20260714195528.597753-4-jakubszczudlo40@gmail.com>
 <741bb99e-e9bf-40ef-9eeb-b736e31b980c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741bb99e-e9bf-40ef-9eeb-b736e31b980c@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 03:18:04PM -0500, David Lechner wrote:
> On 7/14/26 2:55 PM, Jakub Szczudlo wrote:

...

> >  #define ADS1100_SLEEP_DELAY_MS	2000
> > +#define ADS1110_INTERNAL_REF_mV 2048
> 
> Maybe the diff is messing with the tabs, but I hope the
> numbers are vertically aligned.

They are. Remove the quoting in your MUA and you will see that.

...

> > static int ads1100_read_raw(struct iio_dev *indio_dev,
> >  			    int *val2, long mask)
> >  {
> >  	int ret;
> > +	int data_rate_index;
> >  	struct ads1100_data *data = iio_priv(indio_dev);

Likewise in the rest of the (new) code, try to follow it the reversed xmas tree
order

	int ret;
	struct ads1100_data *data = iio_priv(indio_dev);
	int data_rate_index;

...

> > +	data->ads_config = i2c_get_match_data(client);
> > +	if (!data->ads_config)
> > +		return dev_err_probe(dev, -EINVAL,
> 
> Andy has been pushing to use ENODEV for these. Current situation
> is about equal numbers of EINVAL and ENODEV in existing drivers.
> Would be good to pick one and stick with it for new code.

Maybe -ENODATA as you suggested? Sounds perhaps better?
I saw the code where this kind of call and followed by it both use -ENODEV,
and after thinking of your suggestion I now tend towards -ENODATA.

> > +				     "Can't get device data from firmware\n");

-- 
With Best Regards,
Andy Shevchenko


