Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A652E9757;
	Wed,  6 May 2026 21:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778102749; cv=none; b=IKffSzveriD50/M2QuxiToR54SEI9++tkXZq/f7JDf5Cxe7Y2cjw5/kHWSu5vDp6pba4kySR3pXXBfcVENLbO3OqWTKr6MLaepWjrS0fhyJk2qL3bExBNOP88sBOhi7XHJ/XRJmIHiNJVLXBheSo2frnlIA3Nor+Yq/ldzi0p9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778102749; c=relaxed/simple;
	bh=+ph73cjmY9AQiWYW1nhX8KQHgFXLEaHO+lcHUHFx3GQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XC/UMhIIO/oNrqsBfNanvYLvb9NPjMg06pFQZkH+E+rT/yxTjgQQ4db4C5M+KXsG5vt6Nu+5jzkNDAjwTZg7RAtAu9slIH6FVntMWgXVINuFrgejwyRQoMX4jYzdWTfSjqEbpGAewCSNRRvtbkkgnQmuEkmivr4Z9y87i22KXaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xkju3FDN; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xkju3FDN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778102747; x=1809638747;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+ph73cjmY9AQiWYW1nhX8KQHgFXLEaHO+lcHUHFx3GQ=;
  b=Xkju3FDNF7XmioQ/5jaw5x6iPO00dSCyvbxHb0cItvuEB+tMzMe9AKqr
   T9+eEB7IJGhZFqA+ZaeUw7kPvCoRMR09JKhH5rfzIb3/4HYu5I+/uDqJK
   ZGwMX2tGLV0nEt4JNZubtRuh/PC6k1nXQ4D4y0CGixnxDQ8/tYgLTc0f5
   moCbeuIKWJRaiaDyxKXrb16vD8MlVjuRouZS/V7tuoE/8ALydMxHXpen5
   6mcB8+ADKx3PUUI5jRrdLeKEp7lB0bDeq/0qabUQIS5dLogbnqEQ28Y+U
   9IcLlxtcDdNpaEoO+KHVBsadFIT0nG8+HLs1hgrvfoTvg+5gVDnvDIo4o
   Q==;
X-CSE-ConnectionGUID: fE6s+VGoSnaqFaKXaoIgjw==
X-CSE-MsgGUID: nPQEqvuDSt6g0ntT2f4E3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="79154358"
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="79154358"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:25:47 -0700
X-CSE-ConnectionGUID: z50eV/edQ5G6bSekb/g1JA==
X-CSE-MsgGUID: faMIJQxIQoua2NQGm56jUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,220,1770624000"; 
   d="scan'208";a="231730973"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 14:25:44 -0700
Date: Thu, 7 May 2026 00:25:42 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 18/18] iio: magnetometer: ak8975: make use of the
 macros from bits.h
Message-ID: <afux1tXZJxG-5yDt@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-18-831b9b5550fc@gmail.com>
 <20260506181216.049f87f8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506181216.049f87f8@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 06:12:16PM +0100, Jonathan Cameron wrote:
> On Tue, 05 May 2026 13:46:14 +0200
> Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

...

> > Make use of BIT() and GENMASK() where it makes sense.

> One small thing in here.  Feel free to just leave that for a separate patch
> and for now leave it as 0x7

...

> > -static const unsigned long ak8975_scan_masks[] = { 0x7, 0 };
> > +static const unsigned long ak8975_scan_masks[] = { GENMASK(2, 0), 0 };
> Hmm. This is a fun one... It's actually 3 separate bits so please represent it
> as BIT(0) | BIT(1) | BIT(2)

Ah, TIL.

> or maybe add an enum for the channel scan indexes?
> BIT(SCAN_X) | BIT(SCAN_Y) | BIT(SCAN_Z) 

This looks good to me.

> (and there will be an unused here SCAN_TIMESTAMP

-- 
With Best Regards,
Andy Shevchenko


