Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EF23ACEE2;
	Thu,  6 Aug 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786052052; cv=none; b=o+kBFGTOpW5Wut/ue0k8DRYYhiLwju1D8fhyCwQ/TkuzvYmbVHy771BS0cmk3yPFwKot8KclPzgIHItUAtCYAZfMng0GrxRcLWtHlr0LdHEgZFGnWzR8Ssmdd8YSgfTOF6tiZ0vzcI8QqYXvTGM+EKT3wT/Wbu6cqstygZOyYic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786052052; c=relaxed/simple;
	bh=odfYAIGK6SJNSRv9LzQomDhybvJv2MdeBybaCNeMxeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8anf6SUw/zIxNeqiEoxxCZi1yKLVLIy8aw1HZPuNlKgl5CebW7oNH0mCb4EHNrbPwbkB62Xf0GBFJnTy36rFoIckiloFkf5sYlVJ3kIwAgRDF3Kzmctl706nM0/OHs5SMmRktgja6GAg3R+VgTklTWsmdFMx7KyQKmfbRsHoiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ROGqqrY5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ROGqqrY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786052049; x=1817588049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=odfYAIGK6SJNSRv9LzQomDhybvJv2MdeBybaCNeMxeg=;
  b=ROGqqrY5ikCfeQJlzZHunybP7gtWsjVKu0ld0gIbW/vPO02Bus9Ndd7V
   WB05NBACi+QdZLHvdUe3eQ2wXyTBE2WS/McV2qPXdqgEwyeTJeE2rVAqL
   uoFPLaN/iaohJi8yeNP9SaMwmWTtW2MmuMQWx3hPFlD3CMnexWvPyNRNa
   XKQnI1b9w+gNtsO/TFJl+RoWoOPPh0Z265j8bseDq6lutcux6LDg6o3OO
   VgvKi512Q33yudBRWQjQnjtZYXyLSmmL7AnhuknIjRUl9eVwuXW5NrCdM
   /W4R3D+o6CIEDpKw5qoRPb8PGTsJs0JGnZK794uvu3w3X/9nlaA/qLFci
   g==;
X-CSE-ConnectionGUID: Ce4A48ddQv+BPGaLfoUwsg==
X-CSE-MsgGUID: Uhjab5chSrGLbGc48YLIkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86599073"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86599073"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:34:08 -0700
X-CSE-ConnectionGUID: gJZ8FVh0R9ufio5NI6hn/g==
X-CSE-MsgGUID: kVeTbTz4Ruu4cXuRo80zgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="257914277"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:34:05 -0700
Date: Fri, 7 Aug 2026 00:34:03 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: =?iso-8859-1?Q?Nicol=E1s?= Antinori <nico.antinori.7@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Brigham Campbell <me@brighamcampbell.com>,
	David Lechner <dlechner@baylibre.com>,
	Jori Koolstra <jkoolstra@xs4all.nl>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH] iio: humidity: am2315: add am2320 to i2c_device_id table
Message-ID: <anT9y_izVXiwPKrS@ashevche-desk.local>
References: <20260805183733.1000550-1-nico.antinori.7@gmail.com>
 <anRXbXxTLUfUgEPd@nsa>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <anRXbXxTLUfUgEPd@nsa>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 10:46:13AM +0100, Nuno Sá wrote:
> On Wed, Aug 05, 2026 at 03:37:26PM -0300, Nicolás Antinori wrote:

...

> >  config AM2315
> > -	tristate "Aosong AM2315 relative humidity and temperature sensor"
> > +	tristate "Aosong AM2315/AM2320 relative humidity and temperature sensor"
> >  	depends on I2C
> >  	select IIO_BUFFER
> >  	select IIO_TRIGGERED_BUFFER
> >  	help
> >  	  If you say yes here you get support for the Aosong AM2315
> > -	  relative humidity and ambient temperature sensor.
> > +	  and AM2320 relative humidity and ambient temperature sensors.
> 
> The above (same on the tristate title) does not really scale nicely and
> we've seen too often already. So I use something like "... and similar
> devices"

Right, and here something to be a list of the supported devices (in case more
will come):

	  If you say yes here you get support for the Aosong
	  relative humidity and ambient temperature sensors:
	  - AM2315
	  - AM2320

-- 
With Best Regards,
Andy Shevchenko


