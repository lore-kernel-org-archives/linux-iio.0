Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96A3B3E0C41;
	Tue, 14 Apr 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776167014; cv=none; b=E5m0ivEFIacyAgxn/GMqelGet/sltjHToQ3OcoAj0o9d4gURAtCDM4NJlZvy6MAGvjmQjOYdMJrQv+60lpe+O84ODO0H1viXB75BU7STcVfc8OVpkHAapGJnkiaqknxZBnNj/Oz7o5eoNZ/bKDSER0a/Vu1ArOKHSyhndWEmJ4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776167014; c=relaxed/simple;
	bh=ZNGgs+XbbY0TR3N6oX8WbSlvugKITUCjPmHZ0zIpzDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=am9j72xxVNFRP6RU3GxocQ5L1QELJnEQ4vSedHLV+p7PvMcloqRckOv35zJPCGdCPMaRBebEbjH2rT/rTnV7K9S3OHVKZG1HKcOK23iA5ShhwqqsXHYrtZ98K4psGiP+WuPmHMEOhWu/qhr5EmB56ig6jGqSqyDgLaK4R9/oS+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QUwkeqPe; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QUwkeqPe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776167013; x=1807703013;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZNGgs+XbbY0TR3N6oX8WbSlvugKITUCjPmHZ0zIpzDc=;
  b=QUwkeqPep2wFhl+qAlwePFK24QoovpEHmT4Ib3Kabv9J0bvo0E4nYHSt
   pYcHKvk2CcPUIRAZMLfduAfundIeXXxJ9ZgvYcdk+uwWEm3KnkjFQ8dEm
   pVAgPd2hyW/NDeVjiZyvTnblUIbFcAq+GfYiJ/rQgwz1OAfIIZl4CJHvT
   66ZL/R5blFgI6bILt/d2JKGQpFIk2x08o5kAPu2ibcW8S+RqWHVBsYV45
   bPWuUWDSsnPPkdjb3Lk5jO1J1czAIcZ82eaThxtkaj1iQp6Is/5EL46Pd
   H0QHk2qW3ZlRlF9f+Bn6czeQ2xQiXYhS3ulWOTN6rAoNKtcW4m801/YT+
   g==;
X-CSE-ConnectionGUID: OmY4+2/ZRAOaN9pP0QfD9Q==
X-CSE-MsgGUID: VEzuyIMyRr6SWkpdcAWqdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="64656848"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="64656848"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:43:32 -0700
X-CSE-ConnectionGUID: kqwDVv1vQqOgXTpJSlO3Kg==
X-CSE-MsgGUID: KbUtcPRcRVurijS8LwbW3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="223575525"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 04:43:30 -0700
Date: Tue, 14 Apr 2026 14:43:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: frequency: ad9832: remove kernel.h proxy
 header.
Message-ID: <ad4oX0Py3T8j9Y7h@ashevche-desk.local>
References: <20260411123512.84739-1-joshua.crofts1@gmail.com>
 <20260411123512.84739-2-joshua.crofts1@gmail.com>
 <ad4K-K3MpwD3U4F-@ashevche-desk.local>
 <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-wikg1aDAfhgHYR10ep8a0Ab+hJ4mAUyAR4nuV4Uysj+g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 12:12:02PM +0200, Joshua Crofts wrote:
> On Tue, 14 Apr 2026 at 11:38, Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:

...

> > >  #include <linux/device.h>
> >
> > What about this one? Is it used?
> >
> > Many drivers just need dev_printk.h + device/devres.h. Some indeed require
> > device.h. Please, double check.
> 
> I compiled it with the include combination above and it passed, but looking into
> the generated .i file I can see a full struct device definition, so I
> assume there's
> some sort of transitive include behavior (spi.h or something)

Please, avoid following the suggestions blindly. This work needs a careful
check of what's exactly is being used and which header should provide the
necessary information. While it may compile it might be still wrong. You
need to (briefly) read the code in full. I don't use iwyu tool with tweaks
by Jonathan Cameron, old school guy, but you can also try it [1].

[1]: https://lore.kernel.org/linux-iio/20250629183649.184479-1-jic23@kernel.org/
Read the whole thread, it's not big.

-- 
With Best Regards,
Andy Shevchenko


