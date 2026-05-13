Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590473A4F5E;
	Wed, 13 May 2026 20:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778702901; cv=none; b=JEDPMDArAtc6uH1U8HCJeYOZ1Kfqq1l2MdD+FXyyUfJ/aHlLHJDIjK+hIPrLqG03Zn43Cgk2Nn1i8LZn5cehFHizPvDrpZJx6tTEtWN0U5u29DCahoBuHuLIRM20DBA+xDmv8v9TM/cCyD+niZr9eugqsOZd/TE2UsoZz7sE+bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778702901; c=relaxed/simple;
	bh=wEZdnlBzXiXgklo4AMJinDo+1dSlxmx+bhPZ2hijPH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VnvpHShmwWJlDhMj8I0Q58ELU6hifCIGA7Y5R3zD9A6zbCp2HzyBqJNPNcp05bBF0wW1la9li5Eq866HqUCThJsC0mPnQiTfqeJFiFJOKJ8eCjgQ9n1Z33yyfmP1KoCSoDTvVTDQgAEtULNq4yIyGlD8CnfbR/6zeXXtilExYQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzYcR2uo; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzYcR2uo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778702900; x=1810238900;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wEZdnlBzXiXgklo4AMJinDo+1dSlxmx+bhPZ2hijPH8=;
  b=gzYcR2uo7gZaKVvhstCfHwth0BtW5QyTGzA5IYuiqqxlTqKyB08QLyHw
   ckewo7qgW3Qy3/oTuMlInT+7DklRIOrKu9TkqFeTu0dLHUxQ25i26faOB
   ti169yCC6K5ifhYJK9iPLj9t+W57zTCIYzpkyif8pnZGimx8IHqUAPNu5
   LG9UkkLCdY0qjilwQOVfTgyecIKAsimcx2gzmnKp+lI8HdpE51D/CXAvV
   PdRQlRA6vYg/Yd7+oMBd5nnF+smr+MkO8dfu7chIJdPjUFUA9f5S7d0ay
   UUh5RplH/pplMelvDDoK9NkAN67ePM29EFJJHb3q0iBIUn07ntZAD1H10
   A==;
X-CSE-ConnectionGUID: WYG1QiMnTyqnZCufMXg+Nw==
X-CSE-MsgGUID: Rq8gTUaQR92j3rTvLi5RUQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="102308053"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="102308053"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:08:19 -0700
X-CSE-ConnectionGUID: l8Tmh2ACTsmVeOfVXnyxPQ==
X-CSE-MsgGUID: c37rQcwXQMSaPNfvwqGDwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="261932652"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 13:08:16 -0700
Date: Wed, 13 May 2026 23:08:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] iio: light: add support for veml6031x00 ALS series
Message-ID: <agTaLpR_K7HdbMG3@ashevche-desk.local>
References: <20260513-veml6031x00-v2-0-4703ca661a1d@gmail.com>
 <20260513-veml6031x00-v2-4-4703ca661a1d@gmail.com>
 <agStVi6NXRnQOOOO@ashevche-desk.local>
 <DIHRBHBFUWEO.CMT0EUZJ5JR2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DIHRBHBFUWEO.CMT0EUZJ5JR2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, May 14, 2026 at 07:23:10AM +1300, Javier Carrasco wrote:
> On Thu May 14, 2026 at 5:56 AM +13, Andy Shevchenko wrote:
> > On Wed, May 13, 2026 at 05:49:44PM +1300, Javier Carrasco wrote:
> >> These sensors provide two light channels (ALS and IR), I2C communication
> >> and a multiplexed interrupt line to signal data ready and configurable
> >> threshold alarms.
> >
> > Can you split this to two or more patches:
> > - basic functionality
> > - feature 1 (exempli gratia, IR)
> > - feature 2 (exempli gratia, multiplexed interrupt)
> > - ...
> >
> > ?

> Yes, I can. I will wait for more feedback before proceeding.

Sure, with a driver like this the recommended time between the sequential
versions is about 1 week.

> > But let's wait for Sashiko if it swallows this big slice of the pie
> > and not choke on it.

Also note that in IIO we expect ~750 lines per patch with rare exceptions.
~1300 is almost double of this, so the split I am sure is desirable.

...

> > Oh, is 'x' is a real letter in the part number or a wildcard? If the latter,
> > please avoid. Choose the base part number instead.
> 
> I mentioned that in the cover letter: the x belongs to the names in the
> datasheets and every part number.

Ah, I missed that. Thanks for confirming.

...

> >> +static const struct i2c_device_id veml6031x00_id[] = {
> >> +	{ "veml6031x00", (kernel_ulong_t)&veml6031x00_chip },
> >> +	{ "veml6031x01", (kernel_ulong_t)&veml6031x01_chip },
> >> +	{ "veml60311x00", (kernel_ulong_t)&veml60311x00_chip },
> >> +	{ "veml60311x01", (kernel_ulong_t)&veml60311x01_chip },
> >> +	{ }
> >> +};
> >
> > Perhaps use C99 initialisers, as there is an activity to change all drivers to
> > follow that. Jonathan, btw, what do you think we should do in the light of Uwe's
> > approach? Require C99 initialisers in new code, or something else?
> 
> I will account for that in v3 alongside any other suggestions that might
> still arise, thank you.

At least C99 initialisers make code robust, independently on the decision it
might be good to go with them, the only question here is more administrative
(if we want this to be already a requirement for a new code in IIO or not...
 yet).

-- 
With Best Regards,
Andy Shevchenko


