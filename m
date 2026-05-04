Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7A22E1C7C;
	Mon,  4 May 2026 07:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777880159; cv=none; b=cDqxUSMgOXnMdMVqcKDlIEGIsJOomVsGDdOl/wz1X+aJlveulT0rj2wW6yrhYazIMldY7I+/7et2XJGwdTp4igbtjcHfDxkbolF3YXo8/jh1dCA7ctwgbSvBwM0yp6MuFGonKTnHsj8ASnosizYGXC6cuvS0F05523Sgn1R9qBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777880159; c=relaxed/simple;
	bh=GINihiFTQx0CqIBgCZyDJLFbFGJ00lOErCIUIlVNPXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UI3oEj6Cpowc9GsUEdLQIp6G3E1cz4e/RhsFYsWWHr3OMcqnSB1vW+wSObowvt0wB9YOvaBHoolQ2f1DYV2cz+yBkD/tsmj7rJtzEihTKHaqm4oa5EfqXYR2vX4YZlEP73YrK4va2/HQx4EE9LLYkDsnXyczEZL6l+PV5EUGT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cyGXwe55; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cyGXwe55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777880159; x=1809416159;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=GINihiFTQx0CqIBgCZyDJLFbFGJ00lOErCIUIlVNPXg=;
  b=cyGXwe55UDKbBPHMTTlRz7Zor8nXpGna9EsZ6m8T1A8mmgNGrOgh5ggN
   5YgPiSvbSD4eDRQVCXeXS5wEA+1i2lGYn2NyxKJgyw8MHhRboZKT2hZBv
   9aDMzRFsRoggTUqny1zs2X8XdnuYrpHiDqq6VubrmXng3YR2IYbqCFYB0
   HtsBz2J90g0aWUQRP/2sPTva5QbjJUblOiDpE/LSO+am3kxb/YTrg7Pv+
   wCkPjBOumqKVhJLwqDtEtGzrAt7YCOh/WKBNt8uEGvQ8rWuTUM2dWx6FP
   aViVu1TSPcGxOyaStxaTjlVTBna1q9IsW+6tA8CvoCD0WUBfpOTV6Q1Jn
   A==;
X-CSE-ConnectionGUID: 3XTCKQ/PRQSe2yoBqwv66Q==
X-CSE-MsgGUID: Yzl0ff8qTvOca7C0swe5gA==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="96160259"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="96160259"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:35:58 -0700
X-CSE-ConnectionGUID: 8SoZ/IcNQJCYVsQX2OOWzw==
X-CSE-MsgGUID: c4Nul8PWTRKEV5q1JlHq2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="234425105"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 00:35:56 -0700
Date: Mon, 4 May 2026 10:35:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, lars@metafoo.de,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/5] MAINTAINERS: Update Analog Devices IIO drivers
 entry
Message-ID: <afhMWfXd6yVUsDDo@ashevche-desk.local>
References: <20260430190642.3434650-1-sanjayembedded@gmail.com>
 <20260430190642.3434650-2-sanjayembedded@gmail.com>
 <d859d9d22fea4af4dd23221d407aff055ad52524.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d859d9d22fea4af4dd23221d407aff055ad52524.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 01, 2026 at 10:05:11AM +0100, Nuno Sá wrote:
> On Fri, 2026-05-01 at 00:36 +0530, Sanjay Chitroda wrote:

> > Lars-Peter Clausen is currently busy and is therefore removed from the
> > ANALOG DEVICES INC IIO DRIVERS entry, with input from Jonathan.
> > 
> > Add Analog Devices mailing list as contact for the ANALOG DEVICES INC
> > IIO DRIVERS entry for coverage support.

...

> >  ANALOG DEVICES INC IIO DRIVERS
> > -M:	Lars-Peter Clausen <lars@metafoo.de>
> 
> I honestly got the impression that for the entries that had individual maintainers,
> we would not touch them but maybe I lost track of the discussion. Anwýways, if we are
> just relying on this, then I need to put in here given that these day I'm the one
> taking more care of the mainline stuff.

> >  M:	Michael Hennerich <Michael.Hennerich@analog.com>
> > +L:	linux@analog.com

My reading of this patch that you, guys (ADI), have a public ML / distribution
list that you manage now inside the corp. Whoever is in that list is
automatically will be a potential reviewer. However, it doesn't prevent
(and I actually fully support that) that ADI nominates more Designated
Reviewers and/or Maintainers.

> >  S:	Supported
> >  W:	http://wiki.analog.com/
> >  W:	https://ez.analog.com/linux-software-drivers

-- 
With Best Regards,
Andy Shevchenko


