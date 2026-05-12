Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 635A847D95B;
	Tue, 12 May 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778577137; cv=none; b=kBCmli9p1W8tdIe1MmsdrBszEe9BAEokbSH0ZkzuImWO9QF1DnxwifY3yw8JTiqq8PMuVBkAs6AB8z7Mwu8vfsqai56DEUcuz+kOcA9ypnnN3KZl0clup1pbRAnXWQbqGurtInNcDu6+HW+J27Bwab87lPIcK5ftc/gRHZS3kjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778577137; c=relaxed/simple;
	bh=w9wYw2xLVzUmGJHMmQSpQbDGu4EJPRwUSBPQHpG7BXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sxXXK96kzzdM8g93MCvpTV1lhzkmWSXzJAJ+6s+nQ0lOvPjyXYToJq9rmpJhE5yYMu0q3Sq+KKSGsw8nUYvS8RhJe1wHc52bPwAq/YSuNaUCFclsDot8QItjr0jqXlfBz74CZ0wwb31Pxecv2Qxu+cFk2xKrkxqEkWNe1x/Gn+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hAIxqnml; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hAIxqnml"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778577136; x=1810113136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w9wYw2xLVzUmGJHMmQSpQbDGu4EJPRwUSBPQHpG7BXc=;
  b=hAIxqnmlACGY3EJy4Ek9Fe/xo+2MSQsHJmR51oAtZmR0pecTnmJsr9gc
   pBlUPBdDxhNjAqhN4sAe/Cqjm+NHfSbXnkbvXPAPj9EvLVudDimLtXZad
   RjvK0Q1ARlV5QYqRi5sWDU4xJEgE2Of3YGWk0vAzxGs6vcT6SWoxDykce
   eklF09zHZHx5hYvXlOJlafKeWgYpZbruhfX4EYAp3s8H2ZREKn2Yu3vnF
   Iwu07ujSEv2yRO+ofsOMTdiz3QDR3/4DdLqtqbrp5opbOwop1u8IE9TgR
   UiTcAvrTED+hcGQMjJA/bwLrV+6HsEfJQW93j8kBOe8OT0R+zeEn6NsWD
   g==;
X-CSE-ConnectionGUID: dOBYoOjQRK2dJl6XSobULQ==
X-CSE-MsgGUID: 30ucSZ+3T6OA4uFkZRC7Ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79429091"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="79429091"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:12:16 -0700
X-CSE-ConnectionGUID: 17CbI0i7Spm5u1gYxWzqPw==
X-CSE-MsgGUID: diALgUxFQ+6mZdE71Y6C8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="242711308"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 02:12:14 -0700
Date: Tue, 12 May 2026 12:12:11 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: joshua.crofts1@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] iio: magnetometer: ak8975: driver cleanup
Message-ID: <agLu6wF3JhF9zZDN@ashevche-desk.local>
References: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511-magnetometer-fixes-post-pickup-v7-0-9d910faa28b6@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 01:26:09PM +0200, Joshua Crofts via B4 Relay wrote:
> This series is a continuation of the previous ak8975 driver cleanup
> effort, as most of the patches were picked.
> 
> Changes include:
> - using BIT() and GENMASK() macros
> - moving to devm_* resource management
> - adding a scan index enum
> - moving from using wait loops to iopoll functions
> - various code style changes

Thanks for doing this!

Jonathan, the same Q I had in previous version round, can we get some patches
applied to reduce the burden of the series? (I think of 1, 2, 7, 8 and might be
more.) As for the series, I think if this version is still not good enough
(patch 3) we need to rearrange it so that patch is going to the end (as much as
possible) of the series, so we want delay the 'good' ones to be applied.

-- 
With Best Regards,
Andy Shevchenko


