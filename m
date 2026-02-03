Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC0EF50F;
	Tue,  3 Feb 2026 17:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770141280; cv=none; b=d6mcmPPsBoFCiKEiYYmbVAE2oOieu2crDVuWEoImYnDK1rUCoA9ZTgUD/Uj7LaHF7rBG2fbQfFwQIreUFv5XWK1j/MFUW5LjkcMV7AjromMuKFze/jMoPh+/1Wmq2c0L/e9+1fhV0wx0CMp9yYUT8YYiyroHjPj6J/9X0xFBa7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770141280; c=relaxed/simple;
	bh=VLetFPKwHcvjdVCavcZRFp1BoK4FCqP2UIToarHeHRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zf0IUJqK0xHpqm8vVY27p+wqh3jarcHonZUzV+u032tX4Q31CrDGp8EcI7wsTKdCFl2g7SjUfNh4v4n5l3ZnkQuBzSOczgZOR+VQI3x3uWapP3N5y4cqHrSGdALUEFh3WHhyKuaTx1hsD9dDJ+pfMoiv9Zd6l+76mGR5LpHEDSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FY1Lykvt; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FY1Lykvt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770141278; x=1801677278;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VLetFPKwHcvjdVCavcZRFp1BoK4FCqP2UIToarHeHRE=;
  b=FY1LykvtERpLNhK65EcOs1ClLICcyXukqgo5rVrU3oSAuaEU0hj4xbcu
   KrFw00EhfaQxzGLfATgolxi6Gxc3nSTeAxRXv1hvgz5LT1tEgPLQtbRkg
   3gIUehVFh7wTn0B+UKOHxNoloi342MAb3u9fsGVUJnaqpk8rR8THuBURl
   MMuruV+QV1h2h15myhm75FvXF+iN/4BE7YAudmb1zJy3vRuzppCEJXHLR
   oRsknPidkPdUGARTdMIG2kooGMXrm2Fh45STqzQdBbmmnYJewEXdcQ7en
   cFzg7fsd6TUeRsKEggt+Vq3si+8LV/M2vgIhZsGr9fIsUOyNnPzUxmYTa
   A==;
X-CSE-ConnectionGUID: TbkUcnztSVWfiKRGus1MVA==
X-CSE-MsgGUID: L1G8zWDaRzynogxtopGLbg==
X-IronPort-AV: E=McAfee;i="6800,10657,11691"; a="81950685"
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="81950685"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:54:37 -0800
X-CSE-ConnectionGUID: 7B4EOuIVR42ANZBIbnKxrA==
X-CSE-MsgGUID: pm0K+k8LQE+CyXOEwsAAxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,271,1763452800"; 
   d="scan'208";a="247515433"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.99])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2026 09:54:34 -0800
Date: Tue, 3 Feb 2026 19:54:32 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Andrew Ijano <andrew.ijano@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH v3 next 1/6] iio: sca3000: cache SPI device ID in probe
Message-ID: <aYI2WANAXteA8Qxz@smile.fi.intel.com>
References: <20260203122109.689669-1-harshit.m.mogalapalli@oracle.com>
 <20260203122109.689669-2-harshit.m.mogalapalli@oracle.com>
 <aYIR-LAq9iJETwjK@smile.fi.intel.com>
 <a8eed14b-2baf-46f8-85c1-067481c02d7c@oracle.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8eed14b-2baf-46f8-85c1-067481c02d7c@oracle.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 03, 2026 at 09:25:08PM +0530, Harshit Mogalapalli wrote:
> On 03/02/26 20:49, Andy Shevchenko wrote:
> > On Tue, Feb 03, 2026 at 04:20:45AM -0800, Harshit Mogalapalli wrote:
> > > Store the spi_device_id at probe entry and reuse it for the name and
> > > chip info instead of calling spi_get_device_id() repeatedly.
> > > 
> > > While at it, reshuffle variable list in a reverse Christmas tree
> > > order. No functional change intended.
> > 
> > Did you miss David's comment? AFAIU the suggestion was to convert to
> > chip_info(). With that done, this should use spi_device_get_match_data()
> > (or something like that, I don't remember the correct spelling of that API).
> 
> I was thinking of dealing with it in a separate series(as documented in the
> cover letter). Also David pointed out that if I am planning to do that
> conversion separate, there is no neccesity of this patch, as it is anyway
> going to be replaced soon when I have that ready. So I will drop this
> simplification in my next version and leave the conversion to
> spi_device_get_match_data() to another patch set. Will also include your
> "irq > 0" check fixup in the following series. Hope you are okay with that ?

As long as there is no added churn I'm fine with the approach.

-- 
With Best Regards,
Andy Shevchenko


