Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794304278;
	b=x8f66k33URo2f5mJtMbud5Bve1EvXwDPj/owWLMVK1iLxfnC6mPcgNPCXAw0csfa+Fo8
	 81znBhKxKwk6gUQO8oMMcuc8qPQdXijx+VDgviXiMg3pcV+4wvHw53tTfNVlN7wXghhla
	 4oFrNNz2qxaMCfw+typoCLRPYD9R5ld6rYVAQCx9MW6RDk6NA+SGoSNWevCJV2tYDjz5P
	 ul6DkGEfi+EferWTiuieCAWC+GtxLjXGpvjIBy5g62svoVocIhWuYD9DekID5C0xU1F2c
	 Jz0r+8/nbMLxt7gmSpzRd5IC/nRDU3frETtiRODtgZe/Ur7GT9DuvIiA3eyla2fadhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794304278;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=YbxS4r3glnO7uNVQhRoODAC5fMs2dZeYVmrXo7/d8vw=;
	b=RhH85ERq+nSHcFuZEL34BOTYpiIBTLEEevbCkfi1CW0v8oE4gB/zDyf8PIiPr2KcaVG7
	 NZzYwDawfrxo7IGHgg61u/YQJwqZipPH12AiVrEeDI/sjlBPDV3A2+dIETVtM5JzQ5PnW
	 D5PvKJ0v0dT0dxrbVPH39Y3InYOtJR7wJ/qzqWp7XfrfriSJUWDqSCg9VsJGKPVW9uDd0
	 sI0z9lWuP1irZLWul2eiFyfKiyES4VSIazjd2AvV5sTDR/uWaFH14+U5DaN/AX6/mc7zv
	 yo0S98EhnzeHhJzzuK/K5ASYqS+jY9rymovH5FVmyoFZ4lPi9jaq14fyF90LQ5YhXgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="OmAK/lUN";
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAC606B9D2;
	Tue, 10 Nov 2026 09:51:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFBAC606B9D2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OmAK/lUN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794304277; x=1825840277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EQIiYTmm+SRmdC9RpdohF83EwIDHyO3vFfvlI99ygw8=;
  b=OmAK/lUNYEwXB/u6NdVOH2LXeROc6sRYzntMiaHQ9R7YIozYUSrg77ha
   /KbD0/PwnuLkGnASDw1heP36OgncSi/zrCW7T7TPEWLOLBQ/GAiwCjPAw
   egvDmba9MDMRBuzVISeErqiSwwPbHx9S3+SR+QZacvzjPrWD/+rJC+/hZ
   1azqSBXOCB3cAh/liepgWM5sRaWYU8o29RKRCd+y+ff2itYTIeZwjv0qf
   KL3FQP1Iq4YBkSAXh2d7i/VOiXLIEypz2qiFHHVi0zd+jHefPbZ1q6q3m
   h4Stp5HX4DyMqn6x1hdeww0V28GEyOWg7qaqGa0jMIclSS95KggY65W+U
   A==;
X-CSE-ConnectionGUID: 6wKW89E3Q6aCKhaVCei6FA==
X-CSE-MsgGUID: M3KesH8TQWi1ct4x5U2p0Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="2933299"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="2933299"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:51:16 -0800
X-CSE-ConnectionGUID: wfDQNmQoQ1yMM5C8d4P5RA==
X-CSE-MsgGUID: jZDpL9LPSZ+loOUSCVp40g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="9851826"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.244])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 01:51:15 -0800
Date: Tue, 10 Nov 2026 11:51:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v7 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <avLpEA6CoZvicvDN@ashevche-desk.local>
References: <avJZyb5S--smaHpX@ashevche-desk.local>
 <SN1PR12MB2528754241E5C6271A02734FA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528754241E5C6271A02734FA5722@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 09, 2026 at 09:56:44PM -0600, Victor Chernyakin wrote:

...

> > > +		return regmap_write(map, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> > > +				    (u16)DIV_S64_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
> > 
> > Why casting? Shouldn't it be handled on the regmap_write() stage based on
> > the register / field description?
> 
> This was prompted by this sashiko review:
> 
> https://lore.kernel.org/SN1PR12MB252888B43D53AB1723952D21A5742@SN1PR12MB2528.namprd12.prod.outlook.com
> 
> TLDR I'm not certain the cast is necessary, but I'm also not certain
> it's not necessary (if regmap does handle it, I couldn't figure out
> where), so I've added it out of caution.

Yes, regmap core code is tricky in many places. So, as far as I read it,
the I2C default bus with val_bits == 16 (if you have no custom regmap IO
accessors) uses internal format operation regmap_format_16_be() along
with format_write kept at NULL and hence defer_cache set to true (cache
after formatting). The default working buffer for the data is work_buf,
to which the above formatter puts the data, it doesn't put anything outside
16 LSBs.

Since the code is tricky, please double check my way of understanding the code
and confirm or point out any mistakes I made.

-- 
With Best Regards,
Andy Shevchenko


