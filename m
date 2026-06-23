Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E18A368D5E;
	Tue, 23 Jun 2026 09:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782208483; cv=none; b=ler1vqwMM4wW3Ek0hNKuFTMUWomBkY82EQUgbbm6iurSF17v6pxrpwAV3UvI1A8QERW7fOxts2EkZYZF3jFw91AZmn/Vuw+jcJaWkflNbj6LsY/sbYBAgZBQ2OG5phieMPBVfbGTMUwyXlArSOcmL1r9cyx4T6EvUyqeNXpMtCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782208483; c=relaxed/simple;
	bh=vkFETun7c0Vx4s11aeriB3dobfV+C7MaHaRn0CTIr/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VoTHbOLFOZgcujUjGlDQ095RPe14KJJOXOR0iyTrNBlQfMXt3MYYBwoKcWAp/OpM5qz196ozu6CE/mGAah5plKsmgGmIpIiotVsEFNjdrJWHpYEmZq0vAWDV1V0jJHMLRjPqEvpyDSDBapCmxBEc/kmLMcBhX2n+YGAA9qXRpXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eHbXPUHg; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eHbXPUHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782208482; x=1813744482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vkFETun7c0Vx4s11aeriB3dobfV+C7MaHaRn0CTIr/s=;
  b=eHbXPUHgo/+DLla1almhd88oe0vI6sBZtb6lFNPRGBEEb3VC8oo9Ek/O
   X62gujWwLHgQFnlJaUYcFdu7SAQdPc05iIstOCTGVXj9XmKdf+CTf9Xmr
   KTZFV6M7kT3CHeiDzLEsjJI3kWnc1iYUNsHAnWePoD1UQ5GQSudwEpj9i
   o1qZHBZbXNUWMJ5NRmT7nsTn12hnt1KmpXlu1VXoKlgyLnubmC18PodTL
   BSD2H+FnWgs9Oq6QKOT4gz0zGjHOk19jGB3EDkD0Wsc2CxSR2hDjWz6xY
   DWVaLIur3dsbzAYdZmjnhxyo++2rhvR0+wjdmGTTybOKfpjFJZ4ymzndH
   w==;
X-CSE-ConnectionGUID: VWpvX0QdRQ6sxCgovQuAEQ==
X-CSE-MsgGUID: +cgFauzFTh2xyBSnGHvjKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="93537219"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="93537219"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:54:42 -0700
X-CSE-ConnectionGUID: q3/WUKbKSVmUc1Zi61eWcg==
X-CSE-MsgGUID: ufxCW/2fRTqRcD7q5+9NWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="248326947"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.7])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:54:39 -0700
Date: Tue, 23 Jun 2026 12:54:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"Rob Herring (Arm)" <robh@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: stm32-dfsdm: Treat flags as booleans
Message-ID: <ajpX3E2zHYh2e8FG@ashevche-desk.local>
References: <20260612215151.1886851-1-robh@kernel.org>
 <ai1dhJWb9vKqxEEe@ashevche-desk.local>
 <20260621151026.69714694@jic23-huawei>
 <46fce99d-9dd5-435b-95cd-86ed4771aa83@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46fce99d-9dd5-435b-95cd-86ed4771aa83@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 23, 2026 at 11:43:49AM +0200, Olivier MOYSAN wrote:
> On 6/21/26 16:10, Jonathan Cameron wrote:
> > On Sat, 13 Jun 2026 16:39:16 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Fri, Jun 12, 2026 at 04:51:50PM -0500, Rob Herring (Arm) wrote:

...

> > > > -	ret = of_property_read_u32_index(indio_dev->dev.of_node,
> > > > -					 "st,adc-alt-channel", chan_idx,
> > > > -					 &df_ch->alt_si);
> > > 
> > > > +	df_ch->alt_si = of_property_present(indio_dev->dev.of_node,
> > > 
> > > I believe it still has another (serious?) issue. We usually don't use indio_dev
> > > for device properties. It's not a device that is described in DT.
> > > It seems the only driver in IIO that does that. Note, I haven't conducted any
> > > deeper research, it might be (however I'm quite in doubt) that this is correct
> > > use and one device registers a few indio_dev:s.
> > 
> > It is curious.  The registration sequence in this driver is complex, but I'm not
> > seeing anything that sets the fwnode for the struct iio_dev->dev before calling
> > the init() callbacks that end up in this code.  It is set later by iio_device_register()
> > (iirc that has something to do with consumers turning up later).
> > 
> > St folk could you take a look at this and see what we are missing
> > if it does currently work?
> > 
> > For now I'll apply this patch but might need to drop it if a fix clashes
> > with it.
> 
> I confirm that the current legacy path is functional
> (With the st,adc-alt-channel property fix applied)

Yeah, it's here
https://elixir.bootlin.com/linux/v7.1.1/source/drivers/iio/adc/stm32-dfsdm-adc.c#L1772
and should gone. Basically one wants to replace all these to use device and
fwnode propery APIs and proper device node, without that hack.

> It currently works because the driver initializes np from dev->of_node in
> probe, and that value is then used in init callbacks.
> 
> I agree that this approach is not robust, as it depends on initialization
> sequencing and on using an IIO object that is not the DT owner object. I
> will prepare a patch to use the DT device directly as the single source for
> DT properties.
> 
> I also suggest keeping a fallback path for st,adc-alt-channel so we do not
> break legacy DTs that have not yet migrated to the new binding.
> I prepare this also.

-- 
With Best Regards,
Andy Shevchenko


