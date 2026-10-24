Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792839557;
	b=mJk4qLix9sTbM+mvDjWcM3JQKXKJl00SBP+RB2j9eNcZiyLSRctXplLPFUC9qY4Uemlx
	 Z0qG9IuDn93mdfDSPrTJr4AuJONaYGEPdGzkLPgLQmimybJSjWIcV6T+eSOUE9zarKOQD
	 af5WS2Axu0VrXu9/LmrxRzNwLVnXHL6gsbMuV6WOE4AXO8DhOAQbTMnhYfBdIpIte9Gx2
	 HUa8nbWHMfnNJi1KBgfELRedI3Uq0gquQ+IymO5lcjJKSsmlDbB6fJJS6qSN1FGSWNvkI
	 ykIgS3WocoZUT6G65LHjJp7O2gP+PgtwwBWIpZbpm6iFcFskVCwY0MkkluLFjiuTIeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792839557;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=Hsp0ZP5lkd/j3ebKxRL7pDeHOxmdivyq+AHeUApmZs4=;
	b=JDwjeGadIwWAT8uW4No3nG5rSWGeCwM0RE+VW+Pq22cppu9X6zucfvp11MJrsCA/lLoH
	 aUTyCz4ZWfbzyPfIqACj7mbO8+MOn9MjsgedTdSIkmtelX/4pYhm23SjF0T0EwFfyDqMk
	 XtNNfnT288tFw92orXZR0coeS3NlOTkBhRhfsaCukse4UgGTfzu4/MIH13YdpiV47P2Bs
	 gTE9K296Jg9VED+GxL4FSgvlCGRCKhk5ZxCvXvX3TQeW23Uz9KZKm0PmPoQPcbpUN4c9d
	 AOpwDz7uxE+B6nqWTYUU77ZbS7jM2FM7//jDyJEoO3Rfmqo4oJ3Npve5oF2sJE3BxXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="K8pa/mut";
	arc=none smtp.remote-ip=192.198.163.15
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDB3606A31A
	for <linux-iio@vger.kernel.org>; Sat, 24 Oct 2026 10:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FDB3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K8pa/mut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792839557; x=1824375557;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ogu9ZU/u48esxf5GjYCxWFn/9DL6LJ8Kp7TzOaC72KM=;
  b=K8pa/mutPSGp1quRTSgWg1/K+6KhvNN2hdxXh9TZDYC60BChWDG3S9tQ
   JxDgzMwd+Z//Iom6FVvnMU/cV+Ws0Wo3NCe58ZAF1bzpTV6lX09rAi6Uq
   36H3U6E9edzr1FwWED1Y5DGteaQSll74nJs0mgxtY4MUjnMb1kPNdARXP
   r9iXkdiIQcAq31vqr/2PbSpAvCWohhwQLHlEonH4MGjUkWm5x7e1YZBhP
   k0kKkXCtOwwph+NEHOvi1KGY6uPQJjohl/FcFwlRHQsJUOT90ORbqMMYA
   45HOuK2RUBi4iTvYyRgLLRk06mGeQVH2bL/NnqXbAdmrJCtSicCDhZVsV
   A==;
X-CSE-ConnectionGUID: ZXmd1XJyQJedk3/iEhcbSg==
X-CSE-MsgGUID: hp+dRthUQ3WxPpbIkJ3s7w==
X-IronPort-AV: E=McAfee;i="6800,10657,11944"; a="1589917"
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="1589917"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:59:16 -0700
X-CSE-ConnectionGUID: F+PxdjFFTsGmXQ6E6IFElA==
X-CSE-MsgGUID: NOAeO9e8RjOtb8MGHbQvgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,176,1787036400"; 
   d="scan'208";a="5696833"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.221])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2026 03:59:14 -0700
Date: Sat, 24 Oct 2026 13:59:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Viral Patel <viral8854@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, joshua.crofts1@gmail.com
Subject: Re: [RFC] iio: magnetometer: Infineon TLE493D-W2B6 support - new
 driver or extend tlv493d?
Message-ID: <atyPf0msZ85z2m19@ashevche-desk.local>
References: <CAFkCdFwEOUq1nG42GPDHHMLDoVEWJQ63bJd2tPTJ30AKvdKn2A@mail.gmail.com>
 <atpCQhRG-c9z__Bn@ashevche-desk.local>
 <CAFkCdFz_b+P0LiEYuKmFPDKyyLjX4A-Xa9S7XN34SrU9o3upLA@mail.gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFkCdFz_b+P0LiEYuKmFPDKyyLjX4A-Xa9S7XN34SrU9o3upLA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 23, 2026 at 08:46:04PM +0530, Viral Patel wrote:
> On Thu, Oct 22, 2026 at 10:35 PM Andy Shevchenko wrote:
> > I haven't compared datasheets myself, but if your judgement above is
> > correct it justifies a brand new driver to me.
> 
> Thanks. I've cross-checked the list against the TLE493D-W2B6 User
> Manual v1.11 and datasheet v1.2, and the differences hold.
> 
> > No 'x' for sure. Name after the first supported one.
> 
> Will do: tle493d.c, compatible "infineon,tle493d-w2b6".
> 
> > Have you checked other drivers? No more (close enough) matches?
> 
> Yes, I went through drivers/iio/magnetometer and pending series on
> linux-iio. Apart from tlv493d.c, the closest are the other Hall-effect
> parts: tmag5273.c (TI), als31300.c (Allegro), si7210.c (Silicon Labs),
> and the MLX90393 series under review (Melexis, command-based protocol).
> None share the register map, the 1-byte read protocol, the trigger
> bits in the write frame or the FP/CP parity scheme. The remaining
> drivers are AMR/compass parts. The only overlap is the X/Y/Z bit
> packing with tlv493d.c, a few lines of FIELD_GET(), so I don't think a
> shared module is worth it.
> 
> I'll send the series once it's tested on hardware.

Good! Don't forget to put the summary of this into the cover letter to justify
a brand new driver.

-- 
With Best Regards,
Andy Shevchenko


