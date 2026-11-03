Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698865;
	b=rKot5yufonlNbee2FU4PUx6nQz5FmfT9G1FqF0nnTgYNXKC5o4M82PzoGAmJc/3Mf3CX
	 Q8QOoNb7H9XCCGjrzWiOLBDVL1v6qXN4Vt+/ussND6K5thf+MhBixrk/gQTUSZa3+CqDU
	 SzRWQJCJmHQHa4hhzw3SGi0QSfmMLFC7y20pBA2CxD32lwAdZn9CL1uGlB2+OQyxx9EH5
	 4+pHRaIlvcBjwXfp9up9p5D+s+GI8X2RLs1I6yJ9N5OJr6piqmrnPF36lsL6vX7atTRZB
	 WrV1dhZzCj+VqVVQRfH1AagKHSUo6fsOhmr2NOu+PjIKruAi+dLBcxPdEFOcHrO5eXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698865;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=c4cqAdmP/8MWIB/pdsOK0iBsN5mIxubdS4vXQ6mtVFY=;
	b=wv+b+lMpP9/q8hFGtPBcCetVzqnyF0FUwZaGcF8MTHrJeIbbDT1a193Ww0hL1WP2ZHgT
	 bMPHzB0kXvUF9oUvUWYYSUKt0KXeBnMDpvQtY7KHISf9Kuv/l2/KI23bxxJRNpLi7mCRS
	 fxiFWcNUZ5iekloSqXHRuO/oPMVzGe0E4/0rnlvafiYmys8/K+XdCp87vkYu1oRGsi9+J
	 eWEePfuoh15htqlfQpc9cQ/lKoDP3riJFadpzE7mltP5gWUIMgDSB9JtHyEDAynGSuaSE
	 hsDveSEVq3RrfWl1o0WsJ4diCK5E+1FF/3bV48NFCJdX4NC5lQka8v2HojihEil+VCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CYvPPrYP;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1543606A331;
	Tue,  3 Nov 2026 09:41:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1543606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CYvPPrYP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793698863; x=1825234863;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M/cp1iW+rfSZJ6jmKcU5tSwLUpMwx5G6HERoO9ZQ2no=;
  b=CYvPPrYPDUqK9mkFe45L5I+UhLcGjkNq01fa1chPaQSXt4AWcIfW0wg3
   mLMewC475KPptm6ei3rveVrSqQxuTuwNunGaMhfyPl9jMyIgotbbURTon
   arWrmOmVXwp3AOew7wn9rmeaV6/kBjmnw/4kIIxXRlPzO36poDZsI0Bvt
   k2jzXJ3C56ctsHOIpYqNWvn4IngYhZLEVkB+HGIdFtz6PfQzGPls80lyC
   LDY+Qgn8iUzbDA2y8LbEd4toNJAAx8azCL8Ygh3oSo0Hppn6lamloSPy1
   XtAwK6XPdNS93KcHPh8swuWuMRMjfMmwbXVRMTTydgeik3I4O7INGkpdo
   A==;
X-CSE-ConnectionGUID: XfSMC3p8TtyM9DpkjmiXdw==
X-CSE-MsgGUID: ideOaA02QSmmaiYamBl3MA==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2428790"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2428790"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:41:03 -0800
X-CSE-ConnectionGUID: oOpU5dp4Q/aLaDS/hth2Lg==
X-CSE-MsgGUID: ttu9stL2TmW64LxKe4tmjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6377794"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 01:41:01 -0800
Date: Tue, 3 Nov 2026 11:40:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v3 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <aumsKylMrxSOC0XD@ashevche-desk.local>
References: <auBTxjakiTKn1LL_@ashevche-desk.local>
 <SN1PR12MB2528C775582FEF9B200A1FBCA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
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
In-Reply-To: <SN1PR12MB2528C775582FEF9B200A1FBCA56C2@SN1PR12MB2528.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 31, 2026 at 10:22:34AM -0500, Victor Chernyakin wrote:

...

> > > > +     /*
> > > > +		 * Now read the two registers making up the measurement.
> > > > +		 * The datasheet says to read MSB first, LSB second.
> > > > +		 */
> > > > 		// also note in this case we don't need to have _MSB in the name
> > > > 		ret = regmap_bulk_read(map, FDC1004_REG_MEASn(0), reg_val, sizeof(reg_val));
> > > 
> > > I agree we could drop the _MSB if this was the only use
> > > of FDC1004_REG_MEASn_MSB, but we use both _MSB and _LSB macros in the
> > > volatile register table definition, and it would be weird to have one
> > > macro with _LSB but the other without _MSB.
> > 
> > You can have three!
> 
> I suppose, but I would prefer to avoid duplicating the macro, and
> I think having _MSB here helps to confirm what the comment is saying,
> that we should be reading MSB first.
> 
> > > > 		if (ret)
> > > > 			return ret;
> > > > 
> > > > #ifdef __LITTLE_ENDIAN
> > > > 		reg_val = swahw32(reg_val);
> > > > #endif
> > > > 
> > > > 		*val = sign_extend32(reg_val >> 8, 23);
> > > > 
> > > > 		// I assume the following is also possible in this case
> > > > 		// *val = (int)reg_val >> 8;
> > > > 		// but usually we use sign_extend32() in IIO even when simple
> > > > 		// casting is okay
> > > >
> > > > This also reduces stack usage.
> > > 
> > > AFAIK a good optimizer should be able to see that reg_val and reg_vals are
> > > never live at the same time and reuse the same stack slot for both (whether
> > > GCC or Clang actually do that for this function, I can't be bothered to check).
> > > 
> > > If you and Jonathan prefer that version for other reasons though, I can
> > > switch to it.
> > 
> > I gave an idea, I would wait for Jonathan to judge on it.
> 
> Since we're waiting for an answer, I've posted v4 without this change
> so that the other parts of the patch can move forward, but I can
> always add it to v5, etc.

Generally it's not recommended to post without waiting for the resolution.
If you do so, at least make sure you have mentioned the opens.

-- 
With Best Regards,
Andy Shevchenko


