Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096883;
	b=e/HOf84wSI/AR3YsqxsDI6NmqiK00BwVawmfWkurCYlsEGmNjxGWgDTECtg8h2KmSrfN
	 s/4b50XHCTIlM0ht/ccNdnjt7Yt/OJ/a9+C1XwSZXSwoMaWi6B4ZFWz80IUtKgYr1oCr5
	 C9WgAfrvErQkAnD3Py0WNZvIKeo4LJsCa5xDdseptLGXSGEQYo8qXqJaDsQO0tvDxQLaO
	 mq/bl28jUuGoZonhzbIarE3PYZ7u+lGAMhrtTZ/s4pt1k+/AXcM8IltT06eImcLQ5Wxbk
	 cOPrr6e6C1z/LhA2x3w8JA6Z6N3dZyg+I0XNXtS5oFTulIbPBrt24ht7c/z0+J2b71A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096883;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=pdXVOduGggyLG0Xo/K1PJVGxfUF7RtBliaZz/jOyAys=;
	b=TrouCOtw0oz9vrZ0dld+QxybqBD7/1or28SEq5wXomCvu7KMgW+VdM3yVf0aKd9+XgBu
	 racmE2h9/mB2a+Y3zET0xTYTDSK6dW/sYkwWsbQ4HFgBYbpKwfzSWfbvg3v9L6qEls0MK
	 A2zQIWOMV55h62ZUOu2UTEePKXXgVu8/zzQjf/9qk2ZrPwZuHh7fEvXrnLW/QkG4cwQbj
	 l9jFpnAyXi6IC01ExrIEXDcI6+BqhYVxaaiEMusw+mRw8is0rdA9pvd54GUsgt79fNWsb
	 KqyoVhhaBucD1bsbyUMEE+eivGYC/rdyWssrEkU2Q+EFCdpVk4ADbxRFmDzDKu9Blng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWJTHLwk;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A5606A31F
	for <linux-iio@vger.kernel.org>; Tue, 27 Oct 2026 10:28:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 684A5606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nWJTHLwk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793096882; x=1824632882;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u6dn5xaAoP2y7xrISH+CIMNh/ZfLhFg8VqgfyrS1ZwQ=;
  b=nWJTHLwk5dAlICvagll8eKZ6dGHfnLFrX2A7IaIzcnBwFX0UwuJAcrKm
   WVT+WL2aK3w39DeV1Z3E9gZjPNoBVXtcaNysAYTJ/ojHmQ07Z9mvJoXYh
   sEDHZQSFU/04BKB3J6JHny1Fqwaps964NgDGbOB36NbETQFKAvreWsBLq
   udk2Z+svC7JlDltxwDXxQ3UXSZ/TLiWffxGeyCVw8L6uArV2SCHgKFYDW
   55cT0Tk1qUqfnn6V9IvWIWeRfGORv8hUD/ejrPGO90ZXICtuL7fvvE+Fl
   StfrLLbQE/8oCEApiZWx/006PqYpuNDT+DW8MdWBSiianJM9x7fBE3oYi
   g==;
X-CSE-ConnectionGUID: MtnfxEz/TYOcPK/uDmouxw==
X-CSE-MsgGUID: b62S5zWBTNK4/Tp5PpyI3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1669742"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1669742"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:28:01 -0700
X-CSE-ConnectionGUID: a4nmKb6JRO6ifASe2Atnjg==
X-CSE-MsgGUID: qRWtLDEGQEufG6yDQkEmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4414069"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 03:27:59 -0700
Date: Tue, 27 Oct 2026 12:27:56 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 35/39] iio: accel: bmc150-accel-core: use
 iio_push_to_buffers_with_ts()
Message-ID: <auB8rKIaXGRfai6b@ashevche-desk.local>
References: <20261026-iio-v1-0-8b136778eedf@oss.qualcomm.com>
 <20261026-iio-v1-35-8b136778eedf@oss.qualcomm.com>
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
In-Reply-To: <20261026-iio-v1-35-8b136778eedf@oss.qualcomm.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 26, 2026 at 04:05:53PM -0700, Jonathan Cameron wrote:
> Replace the deprecated iio_push_to_buffers_with_timestamp() with
> iio_push_to_buffers_with_ts(), passing the size of the pushed buffer,
> at both call sites.
> 
> The triggered buffer handler read into a separate fixed buffer rather
> than the scan buffer used for the FIFO path. Use the scan buffer
> directly and drop the now unused buffer field. This also corrects the
> type of the read destination to __le16 to match the scan buffer's
> channels array. Widen the mutex-held region to cover the use of scan.

...

>  	u8 fifo_mode, watermark;
> -	s16 buffer[8];

I have a weak memory that I have seen a patch that reuses scan buffer instead
of dedicated one, but I'm not sure if it was against this driver (and if so,
why it got not applied).

It might be this one 8c5f649119f4 ("iio: accel: kionix-kx022a: use scan struct
for one-shot and trigger reads").

-- 
With Best Regards,
Andy Shevchenko


