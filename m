Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DE12E0412;
	Mon, 27 Apr 2026 18:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777315091; cv=none; b=OoBvnSw0kcoI98GZe7YJjPDa7L6og0foe7BVBQTvLnnuVuLW7YHbGySAfxXysZ3NumN6VPx1X1+d1k/R9izugshAK57i25lDt8ABFG0AC9RdPpOHAUl6ND3QRDi+eLOhyxD39IJYdLciePznm0NeCW8dD+Q76T0DwO5c0EuNTus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777315091; c=relaxed/simple;
	bh=+OpmoAu13fY5wZP+SeSwWUXkGEYUd9HoSGTid1eDS58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkKlTlbnfVHHkoRYAhI6jZuIBAbiicgT2nh4hIT+Udz6ZNAScCLIytz7DZIhhSQRJaevx86A19Z5wXMLMRnKQq4A4FDf2xG83KdulIsBy4a7rNqK1eZPtVn3w8+1JyCz2xnpzNZGSsYNkbdEtfTKVa+3ouOXCH0JUe1rZU8OEVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OsDfRZ+D; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OsDfRZ+D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777315090; x=1808851090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+OpmoAu13fY5wZP+SeSwWUXkGEYUd9HoSGTid1eDS58=;
  b=OsDfRZ+DXPg0VryMo5D1yP9nUEYWWHtnoqn/SEeQps6icPnWCPO51NRV
   VyNys1KorsncNp1SGl3gS5QURh34FnnWNSDhu+nLgCV7FIQbL7rLTmtcc
   ufS2eMr9xzChAe9DHet/Ek8xhEESNZo8UfSA+htmclflrC9xFj/coET+U
   KvFwHLZ6gtMZzC+wivCaNgK3taZMT2JveL0CW4/V8MKs4mF5IJ2bXHNL4
   c5jNE3+JJoAlEYJHgzAxNufHKQGCX25X+G1DTkKbtc4etu+GqC1gZ4Pa6
   7mmyDRmCMNQqYeqM3rf/X6HUVkHHR/OCTHCLx7oGzbrgfXZMmcahp5mUo
   w==;
X-CSE-ConnectionGUID: hxeoxBVOQlaJ8/RxVSuwCg==
X-CSE-MsgGUID: bDuSXqmQRv+i+P/maDi2tA==
X-IronPort-AV: E=McAfee;i="6800,10657,11769"; a="78197481"
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="78197481"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:38:09 -0700
X-CSE-ConnectionGUID: JSUxNLBSS12D3OVNaqYiwg==
X-CSE-MsgGUID: ZflEqIJTR4m26XQKJD9IRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,202,1770624000"; 
   d="scan'208";a="238755006"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:38:06 -0700
Date: Mon, 27 Apr 2026 21:38:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Salah Triki <salah.triki@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v2] iio: adc: mt6359: fix unchecked return value in
 mt6358_read_imp
Message-ID: <ae-tDFwxxTgTPayu@ashevche-desk.local>
References: <20260427165759.5756-1-salah.triki@gmail.com>
 <20260427181856.613a22ee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260427181856.613a22ee@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 06:18:56PM +0100, Jonathan Cameron wrote:
> On Mon, 27 Apr 2026 17:57:59 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
> 
> > In mt6358_read_imp(), the return value of regmap_read() is currently
> > ignored. This is problematic because if the bus read fails the variable
> > val_v remains uninitialized.
> > 
> > The function subsequently assigns this uninitialized stack value to
> > *vbat, leading to incorrect measurement results being reported to
> > the IIO subsystem without any error indication.
> > 
> > Update the function to check the return value of regmap_read(). Ensure
> > that mt6358_stop_imp_conv() is still called to clean up the hardware
> > state before returning the error code.

> I'd be more concerned about what it might otherwise report.. Will expose
> something random that was on the stack previously.
> 
> Ok on this one having a fixes tag given the uninitialized, though as I mentioned
> I'd have been tempted to take the approach of just initialising it.
> 
> Even with the code as you have it here a static analyzer may not be able
> to see far enough to tell it is initialized and so throw false positive warnings.

True.

> Still, let's see what Andy thinks before you change anything.

...

> >  	/* Read the params before stopping */
> > -	regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);
> > +	ret = regmap_read(regmap, reg_adc0 + (cinfo->imp_adc_num << 1), &val_v);

> >  	mt6358_stop_imp_conv(adc_dev);

This still uses unchecked IO.

> > +	if (ret)
> > +		return ret;

So, assume we got it right and error code is 0, but failed to stop conversion.
What would be the consequences?

As I said, the whole driver needs to be re-think of. If you going to check this
you need to add checks into _stop_imp_conv() which may lead to adding checks to
the complementary functions and it will go as a rabbit hole.

I agree with Jonathan that quick fix of initialising it explicitly with
a comment will be better approach taking into account the state of affairs
of this driver as a whole.

-- 
With Best Regards,
Andy Shevchenko


