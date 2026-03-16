Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17097374169;
	Mon, 16 Mar 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773655030; cv=none; b=JIAmyJOprg9TtJxazdJmCwUfXvyxwbNEy1NTCamWxTHd//yGLBNpBOvrETAIaBlbtAEvrDLWDAxECE3RiCKzyG/7IHFI3dLqqYnQVHeK0zfiWKrkiLJvUpzypqK+S2Gq3XR8tE4Rz1POaNFcGtruel8XtUT0kZ+HDeRyRpqVm54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773655030; c=relaxed/simple;
	bh=03Zbk3tl0shE9j+i7na+H1FYUo0npA/XRfSLaNFUdWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uozomLp1XPlwrmIN0w1+VyHPvIteIF2pfs0knX/MGqvpen4zhDpVQF42KF0FSV195hz7fDOTr5OQDqeW7GN1UCnmH/wbVsT1eiXy7Qjti+tfe9yxSWTJHJiMTUpEYr5/FcdbFv7AaiWRuhAU58iOHXfIe2JIRee4u20m4eMBJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OqDTUDZ5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OqDTUDZ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773655028; x=1805191028;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=03Zbk3tl0shE9j+i7na+H1FYUo0npA/XRfSLaNFUdWM=;
  b=OqDTUDZ5tY11WzXK7lJH2cLoYwT25Y3b8himvuvq+awL3CcU/YwYtoRe
   qzQoQps1axZ9Lutzvpxyc7CKy3f5mZ9zXaq5qa+DxRcF6bCH22thwTiN6
   Amly/DCmErsxrXAcZPeYpK2IK2jC+E2Thsp1nJzyfHvCg97UTWWLleC3z
   ZO0m/SHB19RvgBncQam1btlJ9kk/EcdvhYU5eUjPsTrjn42huAzXJViYZ
   kRmzm2aWHNpHgl/8UeiGop9JviInq95BDp/UK3irVs4aY1MJi4LyzW/oA
   AiFi3ybBsXkrMcKmLTPhlSgTvY7jpNgXYIRmPILb5G4dVWvIILR7BZTPx
   A==;
X-CSE-ConnectionGUID: vuhuRG5iRTCo71mctEM4XQ==
X-CSE-MsgGUID: atYz9WubSHKSpsq8bNKsyQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="77275364"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="77275364"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:56:52 -0700
X-CSE-ConnectionGUID: RM/eJYsQQ+W5FvMxLMwBVQ==
X-CSE-MsgGUID: BUXKMKq9SeamZ1c6I+yJJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; 
   d="scan'208";a="225983417"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.237])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 02:56:49 -0700
Date: Mon, 16 Mar 2026 11:56:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/4] iio: adc: ad4080: add support for AD4880
 dual-channel ADC
Message-ID: <abfT3qbFaM6PIDKx@ashevche-desk.local>
References: <20260313115856.87763-1-antoniu.miclaus@analog.com>
 <20260313115856.87763-5-antoniu.miclaus@analog.com>
 <abQdvXq9MtIZ0EpZ@ashevche-desk.local>
 <20260314120022.56265de3@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314120022.56265de3@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Mar 14, 2026 at 12:00:22PM +0000, Jonathan Cameron wrote:
> On Fri, 13 Mar 2026 16:22:53 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Fri, Mar 13, 2026 at 01:58:53PM +0200, Antoniu Miclaus wrote:
> > > Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
> > > integrated fully differential amplifiers (FDA).
> > > 
> > > The AD4880 has two independent ADC channels, each with its own SPI
> > > configuration interface. The driver uses spi_new_ancillary_device() to
> > > create an additional SPI device for the second channel, allowing both
> > > channels to share the same SPI bus with different chip selects.  
> > 
> > I am still not sure this is the best approach we can have.
> > In any case, I have immediate questions here about regmap usage.
> 
> I think we have a fairly fundamental misalignment on what this is.
> 
> To my understanding (diagram on first page of the datasheet)
> + the functional block diagram on page 3 it's effectively two almost
> entirely separate devices in one package (sharing of power etc) and
> a few common wires for clocks references etc.  Pretty close to some
> of the multi die devices we get for IMUs etc but with tighter coupling
> that forces one driver (for the IMUs we just register separate drivers).
> 
> It 'might' use one SPI bus, or 2 or even 4 (if using separate data
> interfaces).
> 
> Just to speed things up let me have a go at answering the questions.
> 
> > - Why do we need to have a separate regmap per channel?
> 
> Propose an alternative? It's two independent interfaces, so you
> could spin a special regmap to handle that, but it's much simpler
> to just use standard stuff and keep them separate. Not to mention it
> would either have to do external locking or falsely imply
> there was any restriction on using both interfaces at once
> (there isn't)
> 
> > - What is special about channel 0?
> 
> Nothing.

Then why code does explicit access to regmap channel 0?
We should have regmap[ch] in all cases in the code.

> > - Is it okay to communicate with different channels simultaneously?
> 
> Yes. They are entirely parallel bits of silicon. Own state machines
> and everything.
> The configuration registers section of the datasheet says:
> "Each channel has it's own independent configuration memory
> accessible through it's separate configuration SPI interface."
> 
> >   Wouldn't be a nasty race with HW IO?
> 
> Nope. You are talking to different devices (more or less).

If it's a twins in the package, why do we have a special handling and not just
describing two independent devices in the DT/fw?

TO me is either something special about channel 0, then we have to synchronise
accesses, or there is no point to have this patch at all, just make devices to
be the same under the hood and describe as independent pair.

-- 
With Best Regards,
Andy Shevchenko


