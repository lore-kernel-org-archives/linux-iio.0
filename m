Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F03736B055;
	Tue, 17 Feb 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340802; cv=none; b=bh3QW3rkdb7rKQtDqLcRP9yjw1zH9OEV37s3A78ngt6HiW7uDqJeu77WNaf+Ug5Q/cu00sDA8Xi9lWjDOqQTzTGMqcW13WxDfUxL8WVp2BlW5JC6fG0UCGXX2bzCJ3i6mUKB0lnrnomWjrBg0BVNaDXPA6tsqXuhkVgWO1QcVZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340802; c=relaxed/simple;
	bh=QJMjU0kTBfBclrkjvlaZi8lBKsQNws63Jc9N3VYKfRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IMXUQpl7zqbdbp16iqPQF0mNOjdJZSCsRqW/gbto1eUTLBc9/kyLki0xcdonvvhe8O64cXbhv3YhPR7dlMuEdFM9GQA4wMMrFhAMo2dpW/a6Xy8GDP34YX8I2pm6GV1cjWOOsq7xaHDZmsi7w8jWguYchR15wvutJMruv1DHBPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mSZDD8eh; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mSZDD8eh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771340802; x=1802876802;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=QJMjU0kTBfBclrkjvlaZi8lBKsQNws63Jc9N3VYKfRY=;
  b=mSZDD8ehudsrAznydlmGS44ydi6Le1/zkHtPLIN10zeztulrMkAnA/w5
   MKIWSXCdHsLA4Vwhn0BuS+2T8jP2TzuzGrZEHNF7w7l+xVbU0AcHBoBmm
   pNjEjXcIT4cOXqhF6Uxr7/0TIWIvLsgLtw0wC643W3k2HDo5eiKu1UD19
   N8unPG4PShnbbzPCg1Btkvs1iyObZhvDiW34yfC6syzz8mDZ2SPpi29F0
   fw9lcW7ZeigBu09R1Zr4TP4fiYHA27URi3Dm6bKPQBCyq76/122xjR/Kh
   DAUxrWisr7GLOcqTSJA6aNudookeCI0h9vU3C4QjmWSymGvrJJg+MdknG
   A==;
X-CSE-ConnectionGUID: F7rdzoiBTaKbMRFb8voRSA==
X-CSE-MsgGUID: Db3dLkiIQuW4AiLvQqBGyw==
X-IronPort-AV: E=McAfee;i="6800,10657,11703"; a="89994973"
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="89994973"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:06:41 -0800
X-CSE-ConnectionGUID: 2jZd3xBzSPuIOGAFDonlJw==
X-CSE-MsgGUID: m4U9FRqIS9mS1hZpG+2GHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,296,1763452800"; 
   d="scan'208";a="213145339"
Received: from dhhellew-desk2.ger.corp.intel.com (HELO localhost) ([10.245.245.123])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2026 07:06:38 -0800
Date: Tue, 17 Feb 2026 17:06:35 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Revert "properly check
 spi_get_device_match_data()"
Message-ID: <aZSD-3WIVwT6XYWX@smile.fi.intel.com>
References: <20260217080514.1288115-1-andriy.shevchenko@linux.intel.com>
 <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebc2f13040d97e6e3b9797d3fa580198125e3f5.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 17, 2026 at 01:47:59PM +0000, Nuno Sá wrote:
> On Tue, 2026-02-17 at 09:05 +0100, Andy Shevchenko wrote:
> > This reverts commit b7f99fa1b64af2f696b13cec581cb4cd7d3982b8.
> > 
> > The added code is currently a dead code. Moreover, the driver is not
> > designed to have any defaults effectively making driver data a mandatory
> > information to work with. Taking all together, revert unneeded change.
> > 
> > Reported-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/iio/adc/ad7192.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> > index 530e1d307860..8b1664f6b102 100644
> > --- a/drivers/iio/adc/ad7192.c
> > +++ b/drivers/iio/adc/ad7192.c
> > @@ -1402,9 +1402,6 @@ static int ad7192_probe(struct spi_device *spi)
> >  	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
> >  
> >  	st->chip_info = spi_get_device_match_data(spi);
> > -	if (!st->chip_info)
> > -		return -ENODEV;
> 
> I'm ok with this but as long as we get some consistency agreed on. So far,
> IIRC, the policy was to check for the NULL case even for the cases where that
> was not possible to happen.

Is it kernel-wide policy?
Because what I have heard is that:
- we don't do defensive programming for in-kernel data;
- we don't add a dead code
 (only for the exceptional cases usually accompanied with BUG() or WARN() call).

Both are kernel-wide. Am I mistaken?

-- 
With Best Regards,
Andy Shevchenko


