Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628E1F30A9;
	Tue, 11 Aug 2026 09:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442009; cv=none; b=NEA20fvLYu/uGiXBw6r/S4yFdTbBEJ4lD3DUhoO1c218VFagZdmOU+BNj1uO4AZUy5qDdImh5IGlLnFD31Iw6kR/bnceMnDaRlC8H59alavHWXU6ChCMwosZnTNUDDZXudWD+C4Qs4pjXZQMWZYvKHBx0sIlfprkYUlSH9HU4pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442009; c=relaxed/simple;
	bh=G43tGHbnGB2qUJHPpqi2WjbRmE9j3kNA3SiCEKcgBmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9ebioPy1W4FatDByWf4Y399OSE4NgFnZJYJTJ33BupokdFiQKb8x+fMDr9K5zve+V04fmrEFXldd+vQR7gfXgYXuJ09OZT/pYasQOaQZdJfpp9Ymd+mfNTYpNezj8oTAoeupJsN0TJzGvhT0b4XElfQ74w7VHnD9zN03ke+Ds8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=U3h+HD8U; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U3h+HD8U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786442007; x=1817978007;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G43tGHbnGB2qUJHPpqi2WjbRmE9j3kNA3SiCEKcgBmY=;
  b=U3h+HD8UnOZNKlEu7fC84ibUnbUL/wYIJ7ZtyR8CwE5XWSaQK/Igxc8K
   OPP5rtdEKBAeKA76IyORbqSU83vdRNfbmJuC3nIlAP49FvTux0U6tcqkN
   cgossLBB9iExGalVROVq9vb3G7bzu+imAy5NbtY2pR+4bEkpwfYImW/tz
   p3VKvJ0Oz/QTRo+BtsOIW23SYkS35Nyn5xS2GUeE30zbLKvNxhrrC34+N
   2/ErTupnOvKaJD9wsRky/o7M54BPRuSmqpcR46XxafCGVbj57E+hifZFo
   2Qgab9C1LKp96stSdWsbyI/KRlVR2R1+dezwLK9DpyLnBJmpnLLq3mlu4
   A==;
X-CSE-ConnectionGUID: Biv5YhCAQAWTHfixVWhkow==
X-CSE-MsgGUID: 10NuKfVoQuqOFY8HqZZyQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="109757199"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="109757199"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:53:27 -0700
X-CSE-ConnectionGUID: CqT2ekd1R76aywAwiEGrxg==
X-CSE-MsgGUID: PFWQEezfQzCK75JkfORvpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; 
   d="scan'208";a="266778994"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.207])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2026 02:53:24 -0700
Date: Tue, 11 Aug 2026 12:53:22 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tsz Shan Chan <tsz.chan.dev@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Tsz Shan Chan <tchan@jacques.com.au>
Subject: Re: [PATCH 1/2] iio: light: vcnl4000: use correct channel array size
Message-ID: <anrxEpjjlPVOnR2F@ashevche-desk.local>
References: <20260811-vcnl4000-v1-0-50e7fb657692@jacques.com.au>
 <20260811-vcnl4000-v1-1-50e7fb657692@jacques.com.au>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811-vcnl4000-v1-1-50e7fb657692@jacques.com.au>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 11, 2026 at 05:07:24PM +1000, Tsz Shan Chan wrote:
> Use ARRAY_SIZE(vcnl4040_channels) for num_channels to match .channels.

I was under impression that I have seen this patch a few months ago.
In any case sounds like a fix and hence needs a Fixes tag.

-- 
With Best Regards,
Andy Shevchenko


