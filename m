Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B93DF007;
	Mon, 18 May 2026 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779088459; cv=none; b=H8EDwUNwffh5hz/z22d1vJVQbCFSxrnfW6cQLY3TAVCCeIa7c1Jhz+Qp7UmqcwcCJNzz6qYvf6/eQQ1ULluWK/0kW1KjcMi6fqjrpipQULVMZagR+Z5WmXsqLfwLRyUBuO8e/Ev6M44ACsSTxgOVaXWEEApkr0hwm9uALcrvzWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779088459; c=relaxed/simple;
	bh=ch4+KzHRX15oTvy0eQozXsJdu2/rvZ4j7JoeMWZ9U1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhXG6PfqJrJ+cOXH+n2+ZsHIwH5xiq/wmdqcAaecSqgxwHt5tRgrX94fiUxVnfDO7UcLCJK3tW6W/EqxDqxlzuXLu6tYGgilGbRSIj/wrkbWP0P0pyFAWEkZarTpgrK5WHAF/l8PvWSyFqdTnPZVLh6LDsQA6AB5VI1Wv+zA0WM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mEmEANVX; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mEmEANVX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779088458; x=1810624458;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ch4+KzHRX15oTvy0eQozXsJdu2/rvZ4j7JoeMWZ9U1o=;
  b=mEmEANVXx9g11tUNzrbXIPSrrqb1mXtnkawg1abYBYpvTgcAhLpH2ZYz
   HqxgdpabYP/BeqRd7pJD6R+zxv3tyxELOof/FJ4/G/RGUPp7SEl8Adh6P
   c/oJqTrtEDbQuhINEusnPx5O4ymYutWsK/qR6w0QnfVGTWS/+y6eb1hva
   EiYAhyj0JOiIqj2IbUTAL+iNKoMWSGNUawgER4lE4GCdW4T0F1FINxfTp
   ko55hue6oeUIGtzkufYq5uJopGFNABPY38l7POclw0gVwTa2/fUeHGest
   BmPZW4MaV6/PYjxi32hq5gRXkVbL+dOxGGHCMzEuhrGOk+1KlYMHNV9D3
   A==;
X-CSE-ConnectionGUID: TJaJk8lhTF+3nvdUFWipvA==
X-CSE-MsgGUID: zI8CWDTrQwOI3mN93sA/Ug==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="78958833"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="78958833"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:14:17 -0700
X-CSE-ConnectionGUID: +Phijwm0Ska1e8wiM6r36g==
X-CSE-MsgGUID: EM438IG+RRW9tRuH3o9R/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="244324026"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.3])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 00:14:13 -0700
Date: Mon, 18 May 2026 10:14:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jyoti Bhayana <jbhayana@google.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH 0/8] iio: timestamp declaration cleanup
Message-ID: <agq8Q1wpzIw4XhNQ@ashevche-desk.local>
References: <20260517-iio-timestamp-cleanup-v1-0-61fb908c11c7@baylibre.com>
 <agq7PPw0qupI_8Dh@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agq7PPw0qupI_8Dh@ashevche-desk.local>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 18, 2026 at 10:09:48AM +0300, Andy Shevchenko wrote:
> On Sun, May 17, 2026 at 01:17:17PM -0500, David Lechner wrote:
> > While looking around the code, I noticed that there are a lot of places
> > were we are manually filling all of the fields of an IIO timestamp.
> > 
> > This is error-prone (as seen in the first patch) and more verbose than
> > it needs to be.
> > 
> > I went with the approach of using the existing IIO_CHAN_SOFT_TIMESTAMP()
> > macro for doing a struct assignment. This does require a cast, which
> 
> No, it's *not* a cast. It's a compound literal. And instead of doing this in
> every driver, add it to the macro (in a separate patch). Oh, let me just cook
> it for you (I added that to several cases in the past).

20260518071349.469748-1-andriy.shevchenko@linux.intel.com

> > makes it a bit more verbose, but we were already doing that in to
> > drivers, so I went with it anyway.
> 
> > If we want to consider alternatives, we could make a iio helper function
> > or macro like the first and second patches did.

-- 
With Best Regards,
Andy Shevchenko


