Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C82A481AA4;
	Tue,  5 May 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777994870; cv=none; b=B17OhzkXXj0bmNqYtnQxZeXIOXT62auibTG1OdMEr1+d1EEyqOW7R2z4gtHR53CTLPcZK5gsQ9ke8eB2Nlc6ozodo7+8uXw6Ax+zP8cx1mU6Qa1qZgpzuoLduBY0LGxXiKMIcj/G/yWGRqHzf6ROMTiWzJKPjPThDu5wLSzG0Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777994870; c=relaxed/simple;
	bh=F4rEre7fzYMgP96LfFhQSVmiKZhqxVk6YAV+lc2nPQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNuYECohIACDxKwN+6nk0J2DFmeIAxp5AHsnKbQgeHrI759bRFH9bPYZZ26eSCvN6TkYZ04VKufODO8r6Njdicl12dY3pXt4zUfBr1vzRlKkjdzohQIXlvs0nh+gbmLIJDzVgI4EeqjZ+3Io1WExoWDVzxFiqdMOoZXHFnkyZto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJM3Yvsy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJM3Yvsy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777994869; x=1809530869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4rEre7fzYMgP96LfFhQSVmiKZhqxVk6YAV+lc2nPQA=;
  b=ZJM3YvsyxmWn+7786WJp4AsPMCWOI9CZdMnDqdOencZSy1mhu+XWQb/5
   s20X5vnhn0q3P1dnYNch+CUhEEbXIRx3RJn3vcIih79EbHxS6AkyBlcqX
   azD0PJ2l+oB0QIliBw+/X6SabVnAaPwfXl5BwMpAKD3nOXvEnLNOz4+Fa
   NDyKH3SuAKmqy8ttx69mVtnbWuyqR7/ObVAUtGPRLDG7bs5anJprNqL01
   EPO2p/rsvDDCfRytivsfCT9j2nJgbzTQz62+fEpNViZyidk1AirQnDIJN
   TFoNesJ29NWcwO9zMZj4gCpsrbNALMaIcuATY7VNKXcRL1nwh84TQgGtg
   A==;
X-CSE-ConnectionGUID: C9zJmNbwSKCmJwujWXg/1g==
X-CSE-MsgGUID: jWV1/mZLTZGQ9DlvroH0KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="78892787"
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="78892787"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:27:49 -0700
X-CSE-ConnectionGUID: fAMOEIy3TVeX5I3PvNRc+g==
X-CSE-MsgGUID: UB2XvjbVRI2/lFBjTTAxuA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,217,1770624000"; 
   d="scan'208";a="240835745"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.5])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2026 08:27:46 -0700
Date: Tue, 5 May 2026 18:27:43 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v6 09/12] iio: dac: ad5686: add helpers to handle
 powerdown masks
Message-ID: <afoMb7IJdUrifv-Q@ashevche-desk.local>
References: <20260505-ad5686-fixes-v6-0-c2d5f7be32be@analog.com>
 <20260505-ad5686-fixes-v6-9-c2d5f7be32be@analog.com>
 <afnt7awu2vRI8JTh@ashevche-desk.local>
 <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <lnoaqgoxwvnskoklp2ucjivgkbbxezm2gps62553kouhmmgkji@dozbs2qlcckn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 05, 2026 at 03:13:43PM +0100, Rodrigo Alencar wrote:
> On 26/05/05 04:17PM, Andy Shevchenko wrote:
> > On Tue, May 05, 2026 at 01:35:10PM +0100, Rodrigo Alencar via B4 Relay wrote:

...

> > > +static inline void ad5686_pd_field_set(const struct iio_chan_spec *chan,
> > > +				       unsigned int *pd, unsigned int val)
> > > +{
> > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > +
> > > +	*pd = (*pd & ~(AD5686_PD_MSK << shift)) | ((val & AD5686_PD_MSK) << shift);
> > 
> > Just noticed that semantically this is more like _field_modify().
> > Besides that I would consider adding a shifted mask variable or definition
> > 
> > 
> > 	*pd = (*pd & ~AD5686_PD_MSK) | ((val << shift) & AD5686_PD_MSK);
> 
> We cannot do this as the mask would depend on the shift too. AD5686_PD_MSK is
> being defined with no shift, so that any shift needs to be applied at runtime.

In my proposal I thought of

#define AD5686_PD_MSK(shift)	(GENMASK(...) << (shift))

> > > +}
> > > +
> > > +static inline unsigned int ad5686_pd_field_get(const struct iio_chan_spec *chan,
> > > +					       unsigned int pd)
> > > +{
> > > +	unsigned int shift = ad5686_pd_mask_shift(chan);
> > > +
> > > +	return (pd >> shift) & AD5686_PD_MSK;
> > 
> > 	return (pd & AD5686_PD_MSK) >> shift;
> > 
> > accordingly.
> 
> Same here...

But maybe it's over engineered, and your version is okay... Maybe we can even
switch to
field_get()/field_prep()/u32_replace_bits()/u32_encode_bits()/u32_get_bits()
from bitfield.h.

> > > +}

...

> > > -	if (readin)
> > > -		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
> > > -	else
> > > -		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
> > > +	ad5686_pd_field_set(chan, &st->pwr_down_mask,
> > > +			    readin ? AD5686_PD_MSK_PWR_DOWN : AD5686_PD_MSK_PWR_UP);
> > 
> > TBH, I would leave the if-else untouched, only branches to change.
> 
> What would be the difference compared to this:
> 
> 	if (readin)
> 		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_DOWN);
> 	else
> 		ad5686_pd_field_set(chan, &st->pwr_down_mask, AD5686_PD_MSK_PWR_UP);

That's what I thought about...

-- 
With Best Regards,
Andy Shevchenko


