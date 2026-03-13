Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158163054EB;
	Fri, 13 Mar 2026 08:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773392191; cv=none; b=bxwUB/HGp6nqA1c+1YIKK0YolcacLpzdAgNco3RHji0jproK79+ibcOQD91U6n4hdGgbBa4a3hOrxhMlthq78piyqdT6gLYYjXpW9ZoW9aZnz+M0p7wYUXPnfl2+XqxBsORP6CHQ2Z8azoapPTxStG3qmGNR61fo50c+D0JT1WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773392191; c=relaxed/simple;
	bh=0FKRr5wf/V+OfnYl7pKGDdrZk+FQQdqK9t65g1P2YF8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snj02beU+pW1wDHLwnPAzU5C+ryLlvjQ+Y5tFJ4fsPUo5jTBAjWPaf1ms7PCXKHEvplJGEN0IjVbT3WN1LOw/AMR6oHw5G4PgVjdnbGiN9E3AKc1YzOoGoDClyPmRzrHKmPF4sOIY03hWyi5SGt/K4HZH0aNHkAiCRVqYJK/XP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EKsghJWD; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EKsghJWD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773392190; x=1804928190;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=0FKRr5wf/V+OfnYl7pKGDdrZk+FQQdqK9t65g1P2YF8=;
  b=EKsghJWDi8S//vTktlPAT07w0+qsiyCAK5ZOBxqinRkLuKAVr1RTorNr
   d2ZkfTk3AjZhp/aElLvBmr9/Q5sCo8rEq0MVgECWnuMqRaK7rqdj3eG+G
   SjRbTZJo8bIumb6d8tCHi8H0kfY+88lBUUAxlxJoYk7BjpqII9jokPEzN
   8P1w2SRxZUeGBYnn9QZqYehTlJTwz2bI7aOOphrek7U31xVSeRP5wFubs
   +lmYaGFZny0seSofL5jRzaStXlYPYpdRYX0ULIiGW9zchqURwHzVhzk3J
   s/8aMGI6iplkyVAdz3fp2auhEcr6Z7UTx+FFbbCB2cJcUBQpEGy+IWMlg
   w==;
X-CSE-ConnectionGUID: BHHKxFzWSuKMgkv59zaUdQ==
X-CSE-MsgGUID: PR2+33pNQ+OdM7oieRpEnQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="74392509"
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="74392509"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:56:29 -0700
X-CSE-ConnectionGUID: R6lLRyQPTImnr2kgwPaWZg==
X-CSE-MsgGUID: zvIYJMzXTK2u/KHwzHntCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,117,1770624000"; 
   d="scan'208";a="216040432"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 01:56:26 -0700
Date: Fri, 13 Mar 2026 10:56:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rajveer Chaudhari <rajveer.chaudhari.linux@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, waqar.hameed@axis.com, linusw@kernel.org,
	sakari.ailus@linux.intel.com, harshit.m.mogalapalli@oracle.com,
	antoniu.miclaus@analog.com, andrew.ijano@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] iio: accel: bmc150: convert to guard(mutex)
Message-ID: <abPROEIYF40ndg78@ashevche-desk.local>
References: <20260312081942.23858-1-rajveer.chaudhari.linux@gmail.com>
 <20260312081942.23858-2-rajveer.chaudhari.linux@gmail.com>
 <abLLap9bN3tTXfD6@ashevche-desk.local>
 <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANS1UbjkAEhaLYWoDRFenBwrW91ttzo12cXS2CjtmW7Sz0pP3g@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Mar 12, 2026 at 09:57:33PM +0530, Rajveer Chaudhari wrote:
> On Thu, Mar 12, 2026 at 7:49 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> >
> > I don't understand why you can't do that as prerequisite. At some point we
> > probably go through them to fix, but since the new header is added, it makes
> > sense to put it to the proper order.
> 
> Thanks for the review, as Waqar Hameed said earlier to not change
> anything until they have
> a consensus here.
> Ref Link: https://lore.kernel.org/all/pndwlzk51j3.a.out@axis.com/
> 
> Do you want me to order the headers now in the new version?, I would
> be happy to do that.

In IIO we want to have the unified style across the drivers. WRT header
inclusions there are several expectations:
- headers are sorted
- IWYU principle is followed
- the IIO (and rarely some others) are grouped

OTOH we don't want to see the patch just for the same of this unification
as it adds just a churn (if driver is not under active development, it's
better to leave it alone for the maintainer's decision). Since you have
other patches in your series which introduce a new header, it's okay to
have a prerequisite to fix the ordering issues.


-- 
With Best Regards,
Andy Shevchenko


