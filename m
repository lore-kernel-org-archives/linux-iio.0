Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADA03B52FF;
	Mon, 31 Aug 2026 07:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159654; cv=none; b=uL2cwQJR/CUOTXxceVxJihWIFjCl7fA2sFIAWJwBPhEBPvlKSgrTCUL+XGTTMKpgLrxkEznI9g3A/8xvwO2eLKlG7/VLrsYyC6E/CAddUz+GOmy8ZcU1bd64HlkGpiXU7DbU7SGgcpBpi6GHEAZhIwWOk3vsh49dUCdyc8yT1lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159654; c=relaxed/simple;
	bh=Hn3EHBeIAzk0zyW/UC6IRQtLGwUSfg/yjQjy0j53JMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZVRtj0CjvvUXiJ8bqzwCJy/B9lvnf7xs2sT5uvqIuz4ISVywCC8/Qhhob5b6+LPCfENgomFYDpDv53oHTkLBMIQXCxyCCnIweHhiWNUTv3JEvVhtq6b83LSsKoTMIpkMMtDTcncUFkJyytd1S/ftQBs2sCID+SMuuVLDybnl9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2z+5vpa; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2z+5vpa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788159653; x=1819695653;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hn3EHBeIAzk0zyW/UC6IRQtLGwUSfg/yjQjy0j53JMw=;
  b=B2z+5vpaezuK3b3P9RMaQChhu1J+2MuBQlaMxJfXqRijc71p3q1ZSzez
   xGJT6WeEl7s1mPTt4bHKOW4Vr1Aa+K2rIAHmEXYxbCP57XxbDrz34yHF0
   4aDJ3XHLmvE99An/hYG+6AbfW9Bh2j2kUXl2ceyLNmavQI3CaM8/OEZnR
   27rJUkUGDgiKmMKwmgp0gRW/mAMsomPKRivdDX4Qc83Olbc+jhQ1uRMCU
   70TZAQ+rrNzpbR6b14yYGxJGIB/e/V9DjO2SCvRliFSxANa0PfGOXXgaw
   vXFdt+6yZQkUxoS7FN3lQXP3/a7y7UDr0L+sbRfHLVts0zRCVG03VvXBF
   Q==;
X-CSE-ConnectionGUID: sWVACIjbStKjHRsmwaFY4A==
X-CSE-MsgGUID: CX7Yn0fDQ2G97O/Wuc8TIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11891"; a="88582957"
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="88582957"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:00:53 -0700
X-CSE-ConnectionGUID: 1Y2NU9Y9QsuYeEnMC3Mzrw==
X-CSE-MsgGUID: ZmODhPHSRTyhIKIyHRaLnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,252,1779174000"; 
   d="scan'208";a="265476596"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.21])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2026 00:00:49 -0700
Date: Mon, 31 Aug 2026 10:00:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Yash Suthar <yashsuthar983@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, grondon@gmail.com,
	linusw@kernel.org, hexlabsecurity@proton.me,
	sakari.ailus@linux.intel.com, srinivas.pandruvada@linux.intel.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: accel: bmc150: use
 iio_push_to_buffers_with_ts()
Message-ID: <apUmn2WKlqO1mZXO@ashevche-desk.local>
References: <20260825085156.212042-1-yashsuthar983@gmail.com>
 <20260825085156.212042-4-yashsuthar983@gmail.com>
 <ao_iV2xg-1Oc5Ttb@ashevche-desk.local>
 <20260831012728.0261184b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831012728.0261184b@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 31, 2026 at 01:27:28AM +0100, Jonathan Cameron wrote:
> On Thu, 27 Aug 2026 10:08:07 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Aug 25, 2026 at 02:21:56PM +0530, Yash Suthar wrote:
> > > Replace deprecated iio_push_to_buffers_with_timestamp() with
> > > iio_push_to_buffers_with_ts() to allow source size runtime checks.  
> > 
> > With this you might want to use IIO_DECLARE_DMA_BUFFER_WITH_TS() in the

(For the record, I put it as "might".)

> > definition of the scan buffer.
> > 
> Why?  The structure used is: 
> 	struct {
>  		__le16 channels[3];
>  		aligned_s64 ts;
>  	} scan __aligned(IIO_DMA_MINALIGN);
> 
> So given we never let things get enabled with just timestamp, the timestamp
> and channels always end up in the places the structure describes.

OK! I personally consider the macro a bit more robust in the cases when
we _might_ have new HW to support where it will be the case.

> Where that is the case, I much prefer this to the magic buffer with enough
> elements of the channel type on the end.

No objections.

-- 
With Best Regards,
Andy Shevchenko


