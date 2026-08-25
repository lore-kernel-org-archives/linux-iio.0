Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44BDA380FF3;
	Tue, 25 Aug 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647742; cv=none; b=DzzaLaguijGhor/7BCIDRrMp85ax2WJnF9dNlJSa+TT7sgYyYfHXkgsaQyO/Z0X0/QYMWhOybhurXIdFGywaRt8sKxxg56abIV2Rh3YD4Udv7JpJVkzNqZ5x9LT8sUBWNJcYl9pP8fSZD2HsW7uYGBgRgq6XeVSDpnDPWRDFKKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647742; c=relaxed/simple;
	bh=oFA5ChBaOhQy2aWVo0LFlpYtMR2ka7y4OABb86DXEl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Li3ScU80HCzYEZNQ982uq/nRJf5feTyQX3tLxWSq2lGt5odYv+Uc2Kccgfs2DvN9wRl2KBJHsYAtAWlEW6qFjl2pwMDUBpnh4zzoKPYrjI9M8iDnmQsaKXRCUBSj9mdsBctsGRjsVBH5gGTgVW3sC/qlkpu/x/Ss0PWogbZAlqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L6JOx3La; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L6JOx3La"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787647740; x=1819183740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oFA5ChBaOhQy2aWVo0LFlpYtMR2ka7y4OABb86DXEl0=;
  b=L6JOx3LaNvIB1pVpkqPbDuP9tX9j9rjrA9C4Yx+LqYVE3dzSKrv6E3fj
   OCEexixIJkHIj4cZsL72uNCbTvkPYmH4FW9MrVVUqUDAhO6+oDhO5pMNR
   0fWFaUtpvECCxh8qgMGU2fbquYY9yMXR0NbHn55yZYVP67u3y/hJMSJl+
   i+GDOYrgsqjc/J2eYylFlmBEkPLCCg3jtnh5JHGOYar+itiUVXCK09sI2
   jLmZ9t0NmCSD65oJl8zmNTHdeJb+rojr8TLjCc60e3Gv/Nnp10becpc/K
   jgbuviLiKJ/gKvlpsDLiwfsuQ6/aJWMNIo7UeMPiaMhFbPR/vRPNeqhUi
   Q==;
X-CSE-ConnectionGUID: K546jCIsSVaFoLrmDQSpcw==
X-CSE-MsgGUID: 0dO2/t7CSxyc4N0OtmM4Jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88030789"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88030789"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:49:00 -0700
X-CSE-ConnectionGUID: bHLkqxcAQWyTtPz69wr8fQ==
X-CSE-MsgGUID: gRtgM200SFCtxgkEpZ0Oow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="271029105"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 01:48:58 -0700
Date: Tue, 25 Aug 2026 11:48:55 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH v2 2/2] iio: light: vcnl4000: add shared IRQ support
Message-ID: <ao1W99ygxMvfPdY8@ashevche-desk.local>
References: <20260814-vcnl4000-v2-0-9b771290cc1d@jacques.com.au>
 <20260814-vcnl4000-v2-2-9b771290cc1d@jacques.com.au>
 <20260822032550.31a0fa9e@jic23-huawei>
 <aov_uhPCcno0YJTe@ashevche-desk.local>
 <ao0FKRhOyiIqhvr-@fedora-1>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao0FKRhOyiIqhvr-@fedora-1>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 01:22:13PM +1000, Tsz Shan Chan wrote:
> On Mon, Aug 24, 2026 at 11:24:26AM +0300, Andy Shevchenko wrote:
> > On Sat, Aug 22, 2026 at 03:25:50AM +0100, Jonathan Cameron wrote:
> > > On Fri, 14 Aug 2026 14:30:43 +1000
> > > Tsz Shan Chan <tsz.chan.dev@gmail.com> wrote:
> > 
> > > > The INT output of vcnl4010/4020 and vcnl4040/4200 is open drain active
> > > > low which can be shared with other devices.
> > > > Add IRQF_SHARED and switch the trigger type from IRQF_TRIGGER_FALLING to
> > > > IRQF_TRIGGER_LOW. Edge triggering can miss interrupts on a shared line.
> > > Fairly low risk change but I guess we'll see.
> > > 
> > > It used to be annoyingly common for interrupt controllers to support
> > > only edge based interrupts, but hopefully that silliness is a thing
> > > of the past.
> > > 
> > > So crossed fingers, I'll apply this and see if we get anyone shouting.
> > > I think we'll get away with it
> > 
> > In another thread somebody mentioned a type of the signal that HW generates.
> > Having OD output doesn't prevent HW to behave like it does edge interrupts,
> > id est generating a pulse instead of keeping the level until it gets acked.
> > With that being said, I would ask the datasheet citation to clarify the case.
> > 
> 
> vcnl4010/4020 datasheet, Page 11 Table 15 Notes:
>   "Once an interrupt is generated the corresponding status bit goes to 1
>   and stays there unless it is cleared by writing a 1 in the
>   corresponding bit. The int pad will be pulled down while at least one
>   of the status bit is 1."
> 
> vcnl4040/4200 datasheet, Page 13 Section Interrupt Flag:
>   "INT_Flag represents all of the interrupt trigger statuses for ALS and
>   PS. If any of these flags trigger from "0" to "1", the INT pin will be
>   pulled low. Once the host reads INT_Flag register, all the flags are
>   cleared (reset to "0"), and the INT pin is reset to high."
> 
> The interrupt is latched. The line stays low until the driver clears it.

Please, add the summary of these to the commit message.

-- 
With Best Regards,
Andy Shevchenko


