Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AF8305680;
	Wed, 15 Jul 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784123486; cv=none; b=Bjana8RK9CkDQ7WO/5LJMNxfLFtlXOB7l2HU/UocGr5+5SPYMmpV5rrm/YwDQH08Wzp22m4rt2Z5mZUQz4Q4+LpCm0t8/q6kmZTMFl2C6vLdecTPHD60bbgYHHBvq8rEeiWoqntVBzjWclaGmH391C6fnRSInzSSnGwkw/XcOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784123486; c=relaxed/simple;
	bh=ABx0kwYwMnS/WRBfVqJ+sIBtknov3lHYZT3/oXnnARU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/73AYZhXjf30rQsOQTACPLcXPsHfs2GPNELVD1aYTckx9p6r62Y5D27vuW60n0aErX2041VJFcBugiXRSp6vZBRNte2n90GnuVNnbSxDV7Ju6ARwqRXlybIIpBqEWOpUBdV85hgGZTxeRs7sbXGZh8rkT8ktPB7Z/BX8BTHGh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHIJGbXa; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHIJGbXa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784123484; x=1815659484;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ABx0kwYwMnS/WRBfVqJ+sIBtknov3lHYZT3/oXnnARU=;
  b=NHIJGbXaMWwabKiy999N9ot8W7w0fR4n53ChTd2ZOz/waD1Mb2VtpoR7
   WU6/yM7AfWKMiqQA//ZUylT6qY08EY4Zq3CCwwhs3oNS3Qh1gpGaASKAq
   +3p3p3jqxfaVcENDvBNRu9AwHzNiEg67NujM7ryT9a9QbLOR4UNhS5kU/
   vfbVQS/KmACFMvjhDgT5Cn3l9hWWwvUNg8P8Z5+D7TOK8cp7yAmgslAyD
   IUHBf2iE3YYUK2ftsHOTNd/AeeybF7PXjfcnmDNKhs+znnFNHMx3yl7Bz
   WPx/nR9JTWAp4lr2V6HKIheWcV2LRMVnAFrrjQ/SnHSWiYpV05e7Ox88m
   g==;
X-CSE-ConnectionGUID: sqIYOpmmQ2eTBPH9+lcaCA==
X-CSE-MsgGUID: I1HFga/eQ6y/NjQGXXf4uA==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="110306762"
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="110306762"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:51:23 -0700
X-CSE-ConnectionGUID: 4mvBir93Qn6oNh+qUbVaBg==
X-CSE-MsgGUID: iZFvdGvWQQqry38a7Hrusw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,165,1779174000"; 
   d="scan'208";a="256836623"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.129])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 06:51:19 -0700
Date: Wed, 15 Jul 2026 16:51:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Esben Haabendal <esben@geanix.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Martin Kepplinger <martink@posteo.de>,
	Sean Nyekjaer <sean@geanix.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Martin Kepplinger <martin.kepplinger@theobroma-systems.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: accel: mma8452: Allow open drain interrupt pin
 configuration
Message-ID: <aleQVYrK9YBoLqGl@ashevche-desk.local>
References: <20260715-mma8452-open-drain-v1-0-b1dd2a440c60@geanix.com>
 <20260715-mma8452-open-drain-v1-2-b1dd2a440c60@geanix.com>
 <cA7m1VgJxkr39GAxpnMPw9PVIKX2TR8Ju4Q0m6L2SxS_jJNITfZ6AA5LOeMIK0jGFXaUptY1_vPhDd_imWw5FQ==@protonmail.internalid>
 <aldH3vtk_eKh6oCC@ashevche-desk.local>
 <87ldbco582.fsf@geanix.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ldbco582.fsf@geanix.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 15, 2026 at 01:35:41PM +0200, Esben Haabendal wrote:
> "Andy Shevchenko" <andriy.shevchenko@intel.com> writes:
> > On Wed, Jul 15, 2026 at 10:07:39AM +0200, Esben Haabendal wrote:

...

> >>  	if (client->irq) {
> >>  		ret = request_threaded_irq(client->irq, NULL, mma8452_interrupt,
> >> -					   IRQF_TRIGGER_LOW | IRQF_ONESHOT,
> >> +					   IRQF_TRIGGER_LOW | IRQF_ONESHOT |
> >> +					   data->open_drain ? IRQF_SHARED : 0,
> >>  					   client->name, indio_dev);
> >
> > Why do we care?
> 
> Care about what exactly?

About exclusivity of the interrupt.

> We need to add IRQF_SHARED flag in order to allow shared interrupt, and
> we should not add it when using (the default) push-pull mode.

Why not? How would it make any difference from SW perspective?
Yes, I understand the HW case.

> > The (hidden) problem this will have in the future is that the IRQ core
> > will splat a warning in case that other shared IRQs might be
> > configured with different flags. Putting that flag conditionally makes
> > it a mine field for the users. Instead just unconditionally add that
> > flag and we will get reports as soon as there will be a user that
> > shares the same interrupt pin with some other devices which drivers do
> > not use the same settings.
> 
> If we add the IRQF_SHARED flag unconditionally, it will be set also when
> push-pull mode is enabled. I don't see how the kernel will be able to
> notice that that is not going to work. If you have another device that
> uses IRQF_TRIGGER_LOW|IRF_ONESHOT|IRQF_SHARED, it will not work with the
> MMA8452 device when configured as push-pull.

Right, and why do we care (again)? It's pure DT/FW/HW issue, not an SW issue.
Otherwise it will become a carefully placed mine for the poor user who will
use these flags and try to share an interrupt with the mma8452 device which
has no set property and uses push-pull mode.

Did I miss anything?

-- 
With Best Regards,
Andy Shevchenko


