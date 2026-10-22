Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792688712;
	b=a8J3d5NtbIHzy5NdLToSOPPpD2cFceHy+lS6m6QGgDu4x2oIwwd2+6uAQbyJ7OId+Y+M
	 69UPcNlaTcjDuCOdlseUW8cgCIlwya2DdjA4CUwbvNC3ro2sVi5KRJbQGGJXWIZxVjo/u
	 quDn9Mzqzc9TxNTwPOEOtbAum464IuLoslu08Yi8xFctnMU7V3XeqvB1Y/6Pm15TeddK9
	 EdRwHWbVI6MCOlUWEpyQZstP2C9BUEgcJYs6a78eXZuMFhhWinUzALGWirblrVMyV4AIJ
	 /I46Oefm/bx2xTLvE6Yup79Re0Pr8wJbjhr41iqZlk7KoX9KWxOzQ7Sa47boHqVxeNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792688712;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=AumMrA7/B/d4okNxR/VNRrns0flvuSaqDE5lrscAo1o=;
	b=DrdSO3M+xcG6OjGTIVcyhpeTZTwYhHuCPu4Sy6y0OGhOE2lPknOCsZVmitF2aVBiUwMD
	 aH6eRhQVDSpDOjejj5tc9worJlcx+8qDGijBPDEhhVL2g5f8u9M96ehzTT2ETjPYYXMuy
	 Jz5mqj5xGcGEzLutbdWQEzy8yhZcrmP8WakZfoUPCv3f5M98cGlwSupQ9azys5MK4OwBE
	 fSDVlh1o7sOkq3ugWEaxc93w0B4MhaJK6HDdAS/S3K8BvF82o3XZt8peWDGoDHTAggCJe
	 Am5a7+H8624cZQMLXx2uBBURm1fWvs4oqNaasi/p9dtL7vt6MlGV6iVcrTH38trGwkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=STlZhha5;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF113606A319
	for <linux-iio@vger.kernel.org>; Thu, 22 Oct 2026 17:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF113606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=STlZhha5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792688711; x=1824224711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zpwZWPgrIXZBnxIixVNojCcDBQFcz7HWxi43tsZ6D8A=;
  b=STlZhha5x8ny3MWwITrwlAkqMaZyA1Ow1/oGa5p/4bZFV2Y+wWyYzi7l
   FuRJGQVJJH5Gn2i9Ej1rtmSk7iXmTRWvde2uS5wh202h0glUXLT/zkFnj
   /zVxFDBroPbnEQTo3KRDFQuGU7V3TAIn11dwOoYTSwA8cfaaftri8Ugpm
   7y8TOPFRAVpUkgBnN3U7kKx86Qchd8bdzOYmBQkmrubTYa/CIRlypa0Qx
   2atnoN+iihNBeWYfn8eX9GAtljSNSMff0DZ6q56hhiqRFhxJ7hYceZ+DM
   d3T5rCCrICfo5RTEx4cY0tzlFDP/vSeBZnfef/7+BPncDRGIoo5tnixsB
   A==;
X-CSE-ConnectionGUID: lrGBbt+ATAyYT0Gqe9cPPg==
X-CSE-MsgGUID: YuviecrFRaueuC8hZPqLVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1459336"
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="1459336"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:05:11 -0700
X-CSE-ConnectionGUID: 11I+FFDkSOCWHBlEG4RlTA==
X-CSE-MsgGUID: J+h6clnSR5W0REpvGZum0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,172,1787036400"; 
   d="scan'208";a="3465736"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2026 10:05:08 -0700
Date: Thu, 22 Oct 2026 20:05:06 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Viral Patel <viral8854@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Dixit Parmar <dixitparmar19@gmail.com>, linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, joshua.crofts1@gmail.com
Subject: Re: [RFC] iio: magnetometer: Infineon TLE493D-W2B6 support - new
 driver or extend tlv493d?
Message-ID: <atpCQhRG-c9z__Bn@ashevche-desk.local>
References: <CAFkCdFwEOUq1nG42GPDHHMLDoVEWJQ63bJd2tPTJ30AKvdKn2A@mail.gmail.com>
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
In-Reply-To: <CAFkCdFwEOUq1nG42GPDHHMLDoVEWJQ63bJd2tPTJ30AKvdKn2A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Oct 22, 2026 at 09:24:50AM +0530, Viral Patel wrote:
> 
> I'm planning to add support for the Infineon TLE493D-W2B6 3D Hall
> sensor (automotive-grade, AEC-Q100), a second-generation sibling of
> the TLV493D-A1B6 handled by drivers/iio/magnetometer/tlv493d.c.
> Before writing code, I'd like your view on driver structure.
> 
> The X/Y/Z data packing is the same (12-bit two's complement, MSBs in
> 0x00-0x02, LSB nibbles in 0x04/0x05), but most other things differ:
> 
>  - I2C protocol: addressed writes (trigger bits + register address)
>    instead of a raw stream to a separate write-register space; reads
>    use a 1-byte mode (PR bit) to read from 0x00 without an address
>  - Register map: one unified map 0x00-0x16 (config, mode, wake-up
>    thresholds, diagnostics, version)
>  - Parity: mandatory odd parity bits (FP over MOD1/MOD2, CP over the
>    config/wake-up registers); a wrong FP makes the sensor flag itself
>    defective until reset
>  - Data validity: Diag register (PD0/PD3 flags, frame counter, bus
>    parity) instead of the channel bits used by tlv493d
>  - Temperature: 10-bit, different encoding and scale/offset
>  - Modes: master-controlled, low-power with 8 update rates
>    (0.05 Hz-770 Hz), fast mode; full/short magnetic range
>  - Reset: dedicated I2C reset sequence (FF, FF, 00, 00 frames)
> 
> Given that, my plan is a new driver (e.g. tle493d.c) targeting the
> W2B6 first, leaving tlv493d.c unchanged. The same register map is
> shared by other second-generation parts (TLE493D-A2B6,
> TLI493D-W2BW), which could be added later once verified.
> 
> Questions:
>  1. New driver vs. extending tlv493d.c - any preference?

I haven't compared datasheets myself, but if your judgement above is correct it
justifies a brand new driver to me.

>  2. Naming: tle493d.c, or a family name such as tlx493d.c?

No 'x' for sure. Name after the first supported one.

> I have a TLE493D-W2B6 Shield2Go board on order and will test on a
> Raspberry Pi 5 before sending patches.

Have you checked other drivers? No more (close enough) matches?

-- 
With Best Regards,
Andy Shevchenko


