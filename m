Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A2B369D64;
	Sat,  3 Oct 2026 14:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791039433; cv=none; b=QzzunA66OW07FfXGBvZw64K7rbI68OGwuNW+1KzWB7Nm2WDlRV2xsBJ3teTnPHuAOETl7LkFMWtqPqO1JsHaUREHWy7rtmZYuyf/Omi/3GZb2wfrNr3YujpILVzXvKLPZ7SHv5atEiC6BK7q1CAPeewI/tAzznbFF+U9GWOBlWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791039433; c=relaxed/simple;
	bh=XJAJPZsTzwtQBhaqAFguLrHEk9AFoUCuUXuSAF+Tz0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBbxtlMr6bNU81Qtlibt5mNRo9goDPVzF2B6C6K+FE2hihq9zM14OO6GACY9/Xti38pgPzzG1KVexua5/traO01qSN7hB6PAEDQj0gf4YpveCS575gY1Fg89uppbqtTizZLRRpBZgmpZUZBMkKpdbpxoeE6kIu354vCfH03dTn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cj6FDYmw; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cj6FDYmw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791039431; x=1822575431;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XJAJPZsTzwtQBhaqAFguLrHEk9AFoUCuUXuSAF+Tz0w=;
  b=cj6FDYmw72a3H1ODyqIjV5QtNtIGQPSD1MkhkGL4jbXN4kcvWwSfQnUt
   PUm2Mfmqtmjem+TMeq3OTfKeQskg3hf45gQF7h5NJEzwHjwChDoej+3Sl
   xOOxLAuPMffygvXPe6RPre32yYcEawJJOcuG4bhymmy3bNV8yJQiP6WIL
   pX+sUDP6YDgaa+zZRbCnfw+Q1Q55fqk1wsuUIRGxzgdKtMQshh5JZRZcn
   4XB2jTwjYIKZlGJ91JR++2kRBNicIrnEDL02j0WF+Iw5ZE56NTLWvlxyt
   8ieUsfd8udwS+G4aLNDihwHrlDFq9d6iPuMj1wta6Pk8r07nHP1AbavNr
   Q==;
X-CSE-ConnectionGUID: 85baykz2TXKFbiyyIGaE0A==
X-CSE-MsgGUID: lss8aEnWSX+EUt5ukOtUAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11924"; a="108155444"
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="108155444"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:57:11 -0700
X-CSE-ConnectionGUID: pP3DQNgkST+dQ8ePhkvpxA==
X-CSE-MsgGUID: UqU2aB0ZSVqxaEY6KW1cAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,138,1787036400"; 
   d="scan'208";a="279709598"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.245.78])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2026 07:57:07 -0700
Date: Sat, 3 Oct 2026 17:57:05 +0300
From: "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "andy@kernel.org" <andy@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, Kernel <Kernel@axis.com>,
	"macromorgan@hotmail.com" <macromorgan@hotmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"joshua.crofts1@gmail.com" <joshua.crofts1@gmail.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"jean-baptiste.maneyrol@tdk.com" <jean-baptiste.maneyrol@tdk.com>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
	Henrik Grimler <Henrik.Grimler@axis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v5 6/6] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <asEXwfztOii1y17z@ashevche-desk.local>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-6-c65281b745c9@axis.com>
 <ar-vFLFy1JhquDga@ashevche-desk.local>
 <6996d6084e7d346fda57b7995005d8eb6a583244.camel@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6996d6084e7d346fda57b7995005d8eb6a583244.camel@axis.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Oct 02, 2026 at 02:03:56PM +0000, Kanak Shilledar wrote:
> On Fri, 2026-10-02 at 16:18 +0300, Andy Shevchenko wrote:
> > On Fri, Oct 02, 2026 at 01:54:30PM +0200, Kanak Shilledar wrote:

...

> > > +		offset = sign_extend32(((lo_val & 0xF0) << 4) |
> > > hi_val, 11);

> > > +		offset = sign_extend32(((hi_val & 0x0F) << 8) |
> > > lo_val, 11);

> > Why do we have hi/lo and not proper __le16 or __be16 type for that to
> > begin with?
> 
> The reason for having hi/lo is because the actual offset values are
> split between two registers, as described in the section 16.33 to
> section 16.37 of the datasheet [1].
> 
> MREG1 register     Contents
> --------------     --------------------------------
> OFFSET_USER4       X[11:8] | other bits
> OFFSET_USER5       X[7:0]
> 
> OFFSET_USER6       Y[7:0]
> OFFSET_USER7       Z[11:8] | Y[11:8]
> 
> OFFSET_USER8       Z[7:0]

Oh, this is unfortunate.

...

> > Overall, the feeling is that this is cumbersome change and may be
> > split to
> > smaller and more isolated logical updates.
> 
> Do you have any advice on how to split this patch series?

I have just generic recommendation: try to find all pieces that can be done
before the main work, like renaming something, replacing, moving in the code
and so on. I haven't deeply checked the code, my feelings purely based on my
review experience and contribution that I made in the past decade or so.
I truly believe it's possible to split.

> [1] https://www.lcsc.com/product-detail/C5129967.html


-- 
With Best Regards,
Andy Shevchenko


