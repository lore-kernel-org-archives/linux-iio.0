Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4426E2FF66A;
	Sat, 14 Feb 2026 18:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771092017; cv=none; b=VRI/mKMlLr4Mjc/pYx1/OYoZNkVOrOgsy0fWUc2Fk7MaNvm7UTVWDUfYRijY6KKlxuClWQet5xKVvH3yFwNIbEnbjAcQPVdUiQQODaHB3H+s50WtIWLY6+GQom5j3+IBgXdSyiwiX43HvbF8xklGVoKUmCXrg+oCXiQz26DtK6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771092017; c=relaxed/simple;
	bh=jY3GOtE1QbcFdlnhe4cJpwHVNG+mVHArs+xycwxsm20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Abi8/mMPQzBpaZ50MuaT50vPXqEhdbC3bp0uvU8wv0APdPlfOSGq9FhaKryZsNgm0Q/90/jh5spyfZEM4oWjTVVOTq7eO1BEdTYJTQjv79FYAUS2IQU/mRu2jHzqrrYJgX0nol9iiDSjHQS7vbjlpQPTcOc7pbyLvvYh8/lMams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=evCIkntO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="evCIkntO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771092016; x=1802628016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jY3GOtE1QbcFdlnhe4cJpwHVNG+mVHArs+xycwxsm20=;
  b=evCIkntOzQ9Br9/XWilH6Qtho+nvceH616I7fmM5lDnwmyP5VnR36iIF
   2QTk+ocQmupBYiM9vkAZa70AVu0+MwoBftHN6BrFMdYfGa+l3Ng8BtFpD
   j6xTQsnO28CmveuDY1c0iRSZJnCP64qd8Yfkwdjw0s/EuiainFsSjv8Ip
   V75is+db1EIcCeJ/SSYbt5Pigm2SiFHcsDuqy90HupwYGKHs9WJMRmWPo
   sIQ7omDIii0cE5FfE7bDQaWiW0gJg1TE4rGfbr/GbrdsDYmnCed3Ty4iM
   q2PstMd0L/yo4okhocGj2MVvrP7fbHu87vIr++Qx/LSozHj3XxKPxc7ji
   g==;
X-CSE-ConnectionGUID: xjlDcWgQTO22Bep4HIkK2w==
X-CSE-MsgGUID: ozTsgUMnQX6o8RDk623+fg==
X-IronPort-AV: E=McAfee;i="6800,10657,11701"; a="72340207"
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="72340207"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:00:16 -0800
X-CSE-ConnectionGUID: 9IcoVdPDTw+OCAtpf44NIQ==
X-CSE-MsgGUID: yNgYd5bWQnKUJEN51y+jWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,291,1763452800"; 
   d="scan'208";a="236193507"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.136])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2026 10:00:14 -0800
Date: Sat, 14 Feb 2026 20:00:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, jic23@kernel.org,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] iio: magnetometer: bmc150_magn: minor formatting
 cleanup
Message-ID: <aZC4LBKjjZSz5k4L@smile.fi.intel.com>
References: <20260210233945.40975-1-neelb2403@gmail.com>
 <20260210233945.40975-4-neelb2403@gmail.com>
 <f53438af-0177-4326-acc5-aa653046052b@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53438af-0177-4326-acc5-aa653046052b@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Feb 14, 2026 at 10:31:44AM -0600, David Lechner wrote:
> On 2/10/26 5:39 PM, Neel Bullywon wrote:

...

> > +} bmc150_magn_samp_freq_table[] = {
> > +	{ 2, 0x01 }, { 6, 0x02 }, { 8, 0x03 }, { 10, 0x00 },		/* 0 - 3 */
> > +	{ 15, 0x04 }, { 20, 0x05 }, { 25, 0x06 }, { 30, 0x07 },	    /* 4 - 7 */
> > +};
> >  
> Just an opinion: I think it is easier to see the patterns in
> the numbers if we leave it as one struct per line. (Fixing
> the indent and padding is still an improvement.)

I proposed both, so I'm okay with that too.


-- 
With Best Regards,
Andy Shevchenko


