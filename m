Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF4D41D23F;
	Thu,  6 Aug 2026 21:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786051657; cv=none; b=MeTMm/D1i5tvmlrNmLmu/ywrw9yIH3VxRd6r+yzx+VrYgPdHv6KxRg7AqUKKZra889CfgmE0CktaOv5T1hDZ+FRlJKaTnremZF/02fT2ICpmUZsmSaoM06nw4Yebou99sJBbKunuR/KsT0S7sJjJ9MD/Nzz9sdSegJdMxO/2Pfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786051657; c=relaxed/simple;
	bh=qZySRy0xBC4/klrowonxwwqACmAxnPw6AKQQjANNSVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjIMqvkrd2xl65+GQ3H+rPN1Jru4x8Y8BhkG2LYUK/eNI4utCoINGgDeoQQIHPf/U81MvIXxiI9oJyzzmBgOR/nQHBCEMvi7Az8CCxIIZ0yhXMAG9/5wAEbEpTP4NSq0C5p3II3Z99IxrbT8paL25u96b+ptHC7et/zTy5eCQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dBunoZMM; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dBunoZMM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786051656; x=1817587656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qZySRy0xBC4/klrowonxwwqACmAxnPw6AKQQjANNSVY=;
  b=dBunoZMMoP77hGqALedw1BjMUY7JSHK57CkcFM0Vkoa5f6+cQRJAFGH4
   oUjNUwBDJtjfJ/B2i066VEVlwYfbT6pGsHviJipytrLLfEgTchAmyQ3Ne
   COCSFhKi+799xEd/2lIIw6mlcMnp3ZjVTTzzr20vkxpUqP69NgyqRrCE1
   QCa4KNMwDaAkMq5PXSk55xWd82iDvVkUwoZg0WmyMTesObcw1w4goe6uQ
   mSyql/eTTJYmJuHYfoC4lFDmfG5gtnQNUR0z4g4cXgnXHvSKBZ6mFTLKr
   4X2aklsCLexqPbNNuDtA9EmScFpqUaJBz7IPCh7AAp7UQT1MO8geOqvjW
   g==;
X-CSE-ConnectionGUID: 17CJslugQA6a7vXKpOOJcw==
X-CSE-MsgGUID: LGuWhXzaTKGlQaI590UwEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="109452644"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="109452644"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:27:36 -0700
X-CSE-ConnectionGUID: VZFKowUAS1C8s2rhTmKhbA==
X-CSE-MsgGUID: lSJc0mh+So2YNQvJ3oF0tA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="300428555"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 14:27:33 -0700
Date: Fri, 7 Aug 2026 00:27:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: pressure: ms5637: Add variant specific
 temperature compensation
Message-ID: <anT8Qs1ga7ayvtWZ@ashevche-desk.local>
References: <20260610020458.104818-1-adamianlouis@gmail.com>
 <20260610020458.104818-3-adamianlouis@gmail.com>
 <aimvBvJp8CsNKlPU@ashevche-desk.local>
 <20260611151026.4abf8804@louisarchdesktop>
 <aisNMmwMREF7Iga6@ashevche-desk.local>
 <20260805130651.4aceb71f@louisarchdesktop>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805130651.4aceb71f@louisarchdesktop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 05, 2026 at 01:06:51PM -0400, Louis Adamian wrote:
> On Thu, 11 Jun 2026 22:32:02 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Thu, Jun 11, 2026 at 03:10:26PM -0400, Louis Adamian wrote:
> > > On Wed, 10 Jun 2026 21:37:58 +0300
> > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:  
> > > > On Tue, Jun 09, 2026 at 10:04:58PM -0400, Louis Adamian wrote:  

...

> > > > >  struct ms_tp_dev {
> > > > >  	struct i2c_client *client;    
> > > >   
> > > > >  	const struct ms_tp_hw_data *hw;
> > > > >  	u16 prom[MS_SENSORS_TP_PROM_WORDS_NB];
> > > > >  	u8 res_index;
> > > > > +	const struct ms_tp_comp_consts *comp_consts;    
> > > > 
> > > > Please, check with `pahole` if this is the best layout.  
> > > 
> > > I will correct the packing on this per pahole's finding.  
> > > > >  struct ms_tp_data {
> > > > >  	const char *name;
> > > > >  	const struct ms_tp_hw_data *hw;
> > > > > +	const struct ms_tp_comp_consts *comp_consts;
> > > > >  };    
> > > > 
> > > > Can this be simply embedded into ms_tp_dev (and copied there if
> > > > required)?  
> > > 
> > > Copying in ms_tp_comp_consts provides no benefit over
> > > referencing the pointer; the values are per-descriptor, not
> > > per-instance and never modified. I'll keep the pointer (same as
> > > ms_tp_hw_data).  
> > 
> > Okay, let me ask differently then: Can we use the same data type in
> > ms_tp_dev instead of adding basically the same fields as in
> > ms_tp_data?
> > 
> Sorry for the very slow reply. Yes, for v3 ms_tp_dev will hold a single
> const ms_tp_data *data instead of its own hw and comp_consts. This
> drops the duplicated hw that predates this series. 
> 
> One thing worth noting before I do that: ms_tp_data is currently
> private to ms5637.c and will need to be moved to ms_sensors_i2c.h for
> ms_tp_dev to point to it. I don't think this is a problem; it matches
> how ms_tp_hw_data is defined now, but let me know if you would like to
> avoid it.

The pointer may be opaque, in that case it's not needed to be exposed.

-- 
With Best Regards,
Andy Shevchenko


