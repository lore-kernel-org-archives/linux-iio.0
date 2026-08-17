Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7A3BB672;
	Mon, 17 Aug 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786952836; cv=none; b=XOIZTfTH+0bgipQzmcaGx3+8nNGvrMvv/6ZlCq36XcODOJ/IFdAHpnmj4b3ugQ6CtWSYsswuZ0bd/ck7tAdoOBMX9b3/ygcfRw5wMjI8djeT933IzCU6ignmvHMZBxAS7648GugB4PLvSFGdP864OPNt5053ho2ASQem1Zm8GeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786952836; c=relaxed/simple;
	bh=s4n3xEt0lv2gV6J7jGE8iMW/xH4Fz7d0j5BKod9rwpE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oXbVBEeJ2jXfcxWt//MyDe+Y9aDd7Cxf+kwRFvHlcDE5ipLiBjzHpTg4vEtA8kWiPX1+cVD8BwTvPl7UZOrE2uy8v2QQ8wYB5M6AGFCeOdQEn9714MrT4R6xrDX9UDeTzCiGFXowQOnmhXijPLJ8X5jm7ot6qZpoA9vgEcuAKUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dYI9eyDO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dYI9eyDO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786952835; x=1818488835;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4n3xEt0lv2gV6J7jGE8iMW/xH4Fz7d0j5BKod9rwpE=;
  b=dYI9eyDOQwOrNThoA8S+g1p8hMjRZqJRxPSvWkHX57aHn4Ky0LJUJ1DU
   B6MvcIJHsXCLyPvvtMG0RaoKBkOvK/Zl21UX4tgLxBc3lGZ6ekbjCsE3Q
   jzoGSmqqrsafMv36zkkcfMdawLR9ATpRhewKglD8dy61j44WXCK2pg3IU
   lqP9YZOP3CmwseVLWH0mIAq4qrSSe7LYMmxfbWl7eqA0jn32IkyJwa7uO
   cvdkN+uUx5QGYMD6F4DgmJlpCLQQ81YLTcc9T9Eq1HOYKd5yCe1I4jfx/
   RMvX6oap8fDEqG3uI9vf7VzXJ2YMFY4Ju6g7nfjzLsKD6gojL8ua25ssA
   g==;
X-CSE-ConnectionGUID: 3eTBoTQjTHGNg+VvEYYR6g==
X-CSE-MsgGUID: hzfG8BozQ2+hNMqhCzzGNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87297174"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="87297174"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:47:14 -0700
X-CSE-ConnectionGUID: VXEkxhSkRd6DMKD448tnrA==
X-CSE-MsgGUID: nAcGBbmZSIOwrEtO3dBApw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="303078023"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 00:47:10 -0700
Date: Mon, 17 Aug 2026 10:47:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Chris Hall <c-hall@ti.com>,
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>,
	Nguyen Minh Tien <zizuzacker@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: ti-ads112c14: add support for I2C CRC8
Message-ID: <aoK8fEahg8sjfTN7@ashevche-desk.local>
References: <20260727-iio-adc-ti-ads112c14-buffered-read-v3-0-cbbcaf030148@baylibre.com>
 <20260727-iio-adc-ti-ads112c14-buffered-read-v3-1-cbbcaf030148@baylibre.com>
 <anUwKGyjjwYxQ8NI@ashevche-desk.local>
 <05baac51-bb6c-4a2a-9587-4ae3e30aee21@baylibre.com>
 <20260815023508.3c8df8d2@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260815023508.3c8df8d2@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Aug 15, 2026 at 02:35:08AM +0100, Jonathan Cameron wrote:
> On Fri, 7 Aug 2026 16:18:40 -0500
> David Lechner <dlechner@baylibre.com> wrote:
> > On 8/6/26 8:08 PM, Andy Shevchenko wrote:
> > > On Mon, Jul 27, 2026 at 09:09:50AM -0500, David Lechner (TI) wrote:  

...

> > >> +static int ads112c14_i2c_add_driver(struct i2c_driver *driver)
> > >> +{
> > >> +	crc8_populate_msb(ads112c14_crc8_table, ADS112C14_I2C_CRC8_POLYNOMIAL);
> > >> +
> > >> +	return i2c_add_driver(driver);
> > >> +}
> > >> +
> > >>  static struct i2c_driver ads112c14_driver = {
> > >>  	.driver = {
> > >>  		.name = "ads112c14",

> > >>  	.probe = ads112c14_probe,
> > >>  	.id_table = ads112c14_id,
> > >>  };
> > >> -module_i2c_driver(ads112c14_driver);
> > >> +module_driver(ads112c14_driver, ads112c14_i2c_add_driver, i2c_del_driver);
> > > 
> > > This is not needed if you call crc8_populate_msb() from the probe using
> > > DO_ONCE_SLEEPABLE().
> > 
> > Good idea, but this series got picked up already.
> > 
> Follow up is fine.  DO_ONCE_SLEEPABLE() is a new one to me, and indeed looks rather
> useful for this sort of thing.

But please, double check that _SLEEPABLE() may be used there. In 8250
for some reason (and I don't know why, perhaps each of the DO_ONCE()
has to be commented) I used non-sleepable variant.

-- 
With Best Regards,
Andy Shevchenko


