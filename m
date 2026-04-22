Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDFA377575;
	Wed, 22 Apr 2026 08:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847115; cv=none; b=jfqMQ+fz1AznwJPcWA5akcncxY7C1wHYwmUrwXhSD3H41eHOvYDHaFjCZjAe5gMAyZTEvStlFqhC4jpD1CF02VzYCXPdBka6cb4q8EEBhF2DxrXMWTbGwUrhdHrVaXzCuOKf0190jADgapRQ9RfC/bPgT92o8KrUXls26QXxKrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847115; c=relaxed/simple;
	bh=SGFiszYWwELiHAMEag3AphiHYHhVkHzsdYJds8nekqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VHKnzNQX12RvSwJbdCiseBCuWPOw9c2xQyGIPtVFGlIpQTPsN3ZV3ZTNWXvgx7NuVIQMregY7+Vcjxu30X3IxPMsu7WN1RIaRcCNYTmaAjBkYZT3AZV1SS19CnqG7LDD9Xzt6FNChEt8IwsGLYOINYQmLBoJ9EFSmvPwCGpaAl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sf701QAj; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sf701QAj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776847114; x=1808383114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SGFiszYWwELiHAMEag3AphiHYHhVkHzsdYJds8nekqs=;
  b=Sf701QAj3xDh727Yo38oNTiqO0UVP31J8jMTGXC8TzGSBMdD4yzTCMVK
   2wXLT7cmATYcAFoGuq3TtGLUt4QXeTg73q1sNy6Xi6ZICny5BANTJ3z72
   viAeyjZG6/8ldANPvUwtlFHKZnuiERex5sARBVzUMiSNy8qotCmqUDjk9
   9yRiPWU7UtytmJlU5PgGPUWvoNk18PxWfQXrqcUQYgdBaCZtaY4tfVUZk
   EoQ8/6quMm43R4mFLVm8n1nVVVNiBqQfasPGVVajpF30U555xcOtsKRHS
   gJSXMZbwtS0apSYTqM39Zs5v1VWCAZkcO2TwRqEn61lQ/ZYX19e3x1W0w
   Q==;
X-CSE-ConnectionGUID: YMKHspj+Tv+lhKVUowwUvQ==
X-CSE-MsgGUID: RUaJU5myR2OcLt3TYprPPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77980099"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77980099"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:38:34 -0700
X-CSE-ConnectionGUID: VfyumcftS7WCEwTf9dp9mQ==
X-CSE-MsgGUID: EpVLnCZbTzeeis9CLTqPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232200985"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 01:38:30 -0700
Date: Wed, 22 Apr 2026 11:38:28 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: jic23@kernel.org, ak@it-klinger.de, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: hx711: add support for HX710B
Message-ID: <aeiJBMjI0Frs3h26@ashevche-desk.local>
References: <20260419174654.683692-1-piyushpatle228@gmail.com>
 <20260419174654.683692-3-piyushpatle228@gmail.com>
 <aeXryRD34RLveqDi@ashevche-desk.local>
 <CAMB+xka2ZXbT-G-RUMAusJm8KsOjpCVwjijG2eUaPxBYahQrgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB+xka2ZXbT-G-RUMAusJm8KsOjpCVwjijG2eUaPxBYahQrgg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 22, 2026 at 11:19:15AM +0530, Piyush Patle wrote:
> On Mon, Apr 20, 2026 at 2:33 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Sun, Apr 19, 2026 at 11:16:40PM +0530, Piyush Patle wrote:

...

> > > +struct hx711_chip_info {
> > > +     const char                      *name;
> > > +     const struct iio_chan_spec      *channels;
> > > +     int                             num_channels;
> >
> > Why signed?
> 
> num_channels cannot be negative, so unsigned int is
> more appropriate. The same applies to fixed_gain_val. Will fix both.

Thanks for pointing on that, now I see one more thing: please, run `pahole`
and check if the layout is optimised (to me sounds like it has unneeded memory
gaps).

> > > +     const struct iio_info           *iio_info;
> > > +     bool                            fixed_gain;
> > > +     int                             fixed_gain_val;
> > > +};

-- 
With Best Regards,
Andy Shevchenko


