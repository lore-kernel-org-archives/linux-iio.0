Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581730677E;
	Mon, 17 Aug 2026 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964424; cv=none; b=FaafyCmu1bqaRKg2FTVwcdNbzKLXX2Y8iihsmEEpDGDj6EJaJDam1Ka6JHBzNWNfKUgeSFx5bZiD2dA6cNv/tJywqJTPEokRgrxTAUde/xw8gWYVNePNlfHGX3fAVMxVLCluyVMx68t1alJFfnQ23K5n20bP3/mu43wSVtzzEPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964424; c=relaxed/simple;
	bh=WY1gQCTxDV9Zv9Rx3mAu7UMRf3FVb65FxJ86Bvgc3rU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufvw0fTttbx7ve/IPz23lSNpkl4lU8J4TBOOiA4Luk29JGGODnWjcuDWx315tj+UTzJiLCAw0rQTDwrQX4VEfU1KFvGACgLVn6SXQR37Ut35FOlzxLxTIvO3ZE8D1IUjr3dlvjeq+oGpVQ5ErOSxhqIsLE8vMJ4cI8k9gvVL97I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzGTtuCx; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzGTtuCx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786964420; x=1818500420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WY1gQCTxDV9Zv9Rx3mAu7UMRf3FVb65FxJ86Bvgc3rU=;
  b=dzGTtuCxWhGyCH3YNh0G1QsNkz35CJWHKCTyE9J+fregYgb7YK7QM3gT
   BdiF+O4gqlIsFox1ZeRDjNUpabTnElAGY9Oi6t/O0UYbp63OXmvXEYsMP
   oc7H8ZdTa0aUy+npO4LYUdRkxktmQMvG0HrS5d1S7MsQS/wNiMSWiBy8Y
   QVUCnOo0dVU3qq+HrkwG1fstotd/ll8kOLXlOmyt6sjKv8M5Q3aYzPXae
   hscBZOvlTZF7Pvo9wgJseCd4XeyYYZNPKEP58ZUO/W7om0zpMs51PJSWq
   2HwSxO4XFfv1pb4NDm6ygfwJAGvYSh9Wz4bSgwhtL5lDP1R8WoF1ZwoWd
   A==;
X-CSE-ConnectionGUID: l6x6yVKoTPydTGzOfI7WkA==
X-CSE-MsgGUID: Wx/VoDlISYmYiJJaDkmVtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="104971590"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="104971590"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:00:18 -0700
X-CSE-ConnectionGUID: Pm6cIpI0Q2aPTMS2tXP4hA==
X-CSE-MsgGUID: 16jlo4MhQQexg8h1ZlNcLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; 
   d="scan'208";a="261623334"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2026 04:00:15 -0700
Date: Mon, 17 Aug 2026 14:00:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Shengzhuo Wei <me@cherr.cc>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>, linux@analog.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: accel: adxl367: reject out-of-range FIFO
 entry count
Message-ID: <aoLpvN_-BkKm1zbH@ashevche-desk.local>
References: <20260812-adxl-fifo-v2-0-86bea20faf1c@cherr.cc>
 <20260812-adxl-fifo-v2-2-86bea20faf1c@cherr.cc>
 <anwqC4tczcdnmF1u@ashevche-desk.local>
 <20260816015358.76f644f5@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260816015358.76f644f5@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 16, 2026 at 01:53:58AM +0100, Jonathan Cameron wrote:
> On Wed, 12 Aug 2026 11:08:43 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Aug 12, 2026 at 03:58:50PM +0800, Shengzhuo Wei wrote:

...

> > Aren't they already were discussed in linux-iio@ mailing list earlier?
> 
> I'm lost.  Yes it was discussed a few times, one of them in the v1 thread
> for this.  Andy, can you be a bit more specific on what you mean here.
> I for one am half asleep today so could do with the pointer!

Sorry for the unclearness. I think I saw the similar discussion in the past
(but probably related to another driver in IIO with the similar symptoms).
I can't quickly find a pointer, I might have been hallucinating (luckily
it's not a property solely related to AI).

-- 
With Best Regards,
Andy Shevchenko


