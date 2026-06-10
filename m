Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A292346AE3;
	Wed, 10 Jun 2026 18:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781117497; cv=none; b=FI+/U9jxP3TbfN1InPoSB4QoQgJqyr4Pa2QvvtK7bFs3cZtgFMrOvqTJ0a4dedWxKzX10m1HFOHFjc0W1NXPoznq9mGOyfhHtbd1nigyS0llMHmEgxIbJfAW1fdB7xA+CL60lCovaAbmEyygAHSNoFvLoiFgoU8yMKCzZHuCeLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781117497; c=relaxed/simple;
	bh=IAJeaJCSOrokeJqsoh7ZMS5JEDntzqitc8aG5X9uM6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VW4n48saM8n31LoJ/zJdSz89rL4u5z7BsaxbVk7m2XTdfmMl51cqFZ8nMJ1VdIJNgOl7dmVrVcBNrj4B8f3gQvsCXg54vI87fASPceEKKI7BPSLaQMLT7L4R4PFYX41+0d3MEVcB9ctqvyffeT7sHj0PoYfopsrsOrasLAgouAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aye66uGD; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aye66uGD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781117496; x=1812653496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IAJeaJCSOrokeJqsoh7ZMS5JEDntzqitc8aG5X9uM6A=;
  b=aye66uGDZKdQa9WjHMvX9ETjKqfTUZgBFSSA0Bq5xxh5lzQAfK+g2BqH
   LAU0myHxq65Fo0sCMoTh7EZ4yMDs7hhfZQ2jxn42oSfgCFgmotgjyyiNf
   BPsP1dCs0bt1oevZytmakFJebNOlM1SObYjyqOB60q30Gk96MG7A4J6R3
   M26/9n/89fyX5FywxFTLCUC48dG2L/9dD7Ymt/ocgDY24uvrh0B1sxKn1
   +2DxP4/VM1Jt9NLVafPLnBffLumN67z4JKgW85x0uecoAknFlfx0IHyoT
   05myRlxrMGUf3W2rN/UMKBmJuIY4Txt5X5CxqWeSmOMJ1Ysb99rdAOn03
   Q==;
X-CSE-ConnectionGUID: lBddJ2uWRcyl589jQROy0Q==
X-CSE-MsgGUID: SG/qs1cmS4633UOA0NuT9Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81054028"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81054028"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:51:35 -0700
X-CSE-ConnectionGUID: Ld7552xLQuatmRnoelVB+w==
X-CSE-MsgGUID: 6f666/mdTJOs8w9zQz3/bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="245385735"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.38])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 11:51:30 -0700
Date: Wed, 10 Jun 2026 21:51:27 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
Message-ID: <aimyLwhc_BT6I5wD@ashevche-desk.local>
References: <20260606045738.21050-1-clamor95@gmail.com>
 <20260606045738.21050-11-clamor95@gmail.com>
 <aihm315UtdqJclhh@ashevche-desk.local>
 <CAPVz0n01ymfYGH+_MgfHvWqzg+tczLi8E-1q=rZ5cHu+uJrpdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n01ymfYGH+_MgfHvWqzg+tczLi8E-1q=rZ5cHu+uJrpdg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 10, 2026 at 05:40:56PM +0300, Svyatoslav Ryhel wrote:
> вт, 9 черв. 2026 р. о 22:17 Andy Shevchenko <andriy.shevchenko@intel.com> пише:
> > On Sat, Jun 06, 2026 at 07:57:34AM +0300, Svyatoslav Ryhel wrote:
> > > Missing coherent_dma_mask assigning triggers the following warning in
> > > dmesg:
> > >
> > > [    3.287872] platform lm3533-backlight.0: DMA mask not set
> > >
> > > Since this warning might be elevated to an error in the future, set
> > > coherent_dma_mask to zero because both the core and cells do not utilize
> > > DMA.
> >
> > Hmm... I am not sure about this. The entire kernel has only two drivers that
> > do that, and thanks to their commit messages one of them pointed out to the
> > commit from 2018. So, if no other devices suffer from this, I think it has to
> > be a better way of achieving the same.
> 
> If mfd framework warns that DMA mask is not set then this must be
> addressed. Why then there is such warning at the first place if mask
> can be just skipped. Then warning would be just a debug message. What
> is warning today can become error tomorrow.

It's there for 8 years. And only a few drivers explicitly nullify it.
I think doing this patch one should really understand what's going on.
(Note, I'm not that person, it's my gut feelings based on the experience
 and the above statistics.) MFD creates a lot of platform devices for
which DMA mask is set automatically. So, why is it not set properly for
this device?

-- 
With Best Regards,
Andy Shevchenko


