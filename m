Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54294395ADF;
	Wed, 13 May 2026 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670050; cv=none; b=LHtQbkCi8u32FPiRZVzPZmVVCDijLECRtLe59tm175PiDIfVoc64jhtnlWKaB/vhJmD4f9Uit0TFmyHTTNVXNYHmVJZIiLjevCoRXoanye2jbneZFRgGy0a/g7iIxQUtiw4BcaCKgyMM2TlNvg6kDDt3cFdfeXdnHmMV61GKUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670050; c=relaxed/simple;
	bh=krVVYLitAYLM5WIRShwa2zVxDfmg3GTg9ucpYByLKAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgKlZW3SsniwSbYoHLgAu8aRKdvMiiKQxI3U4sKRmIqWncfKcVgcicMRuARSn1gb6PF4et1TFOWZYOHgs3iVK31y6AxEYQzVGqZaqUEGxDBzTX5jQBaDWFNu3WkioPulf9WQTjfMtweSyL6hGr+Jdr8B6aGwQ7552Zen8mq/puM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fU0GjXJ+; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fU0GjXJ+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778670049; x=1810206049;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=krVVYLitAYLM5WIRShwa2zVxDfmg3GTg9ucpYByLKAg=;
  b=fU0GjXJ+rhl0hHHsMpmK2nxQWduPAZ8asvDUsjF9hcTr+JOoNkD4bUTu
   grvQ9di8j/0BGtx1a3oDexCO0VAcBJpLJH2nDK7pxJudRAlqjXUMu8tmF
   G4exdTfLAaTxGdQoRvaFSNS/H8sgO9RMEJeyAb7LBI1sDx3b8foxoTLe8
   MaoNdR3LwS5mm60vZguZfl5YFZbqwUW9xvh+9nex7AtuGPuK+gvOrVLcR
   8L2DMXRmBZzh0B+erzmhK5hTJ5G4tc9DqhRuN9ElWBTSpL/KiuBKqPp0C
   FyCxE/dLOWWQUCHJlqzSvgRp/hv3UhnmpkhWGu9PR/HmdWABdJjrO5HYm
   A==;
X-CSE-ConnectionGUID: v6Egh6m7TXGuTYM+P8vJjw==
X-CSE-MsgGUID: 6buK8OIhQzafdIKj5QrDGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="89898444"
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="89898444"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:00:48 -0700
X-CSE-ConnectionGUID: FdPTEvqeQDyrFI7SnRk8pQ==
X-CSE-MsgGUID: qjBKiXO4Ro2Kt3JSG5ooKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,232,1770624000"; 
   d="scan'208";a="233781445"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.106])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 04:00:45 -0700
Date: Wed, 13 May 2026 14:00:42 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 2/5] iio: light: tcs3472: convert remaining locking to
 guard(mutex)
Message-ID: <agRZ2sSZ9za8oOgC@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
 <20260512223215.25596-3-aldocontelk@gmail.com>
 <CALoEA-zrmGs8PjE6N=ToQ6fUk3H63_rpJy1=mBCVVBb1xRAd+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zrmGs8PjE6N=ToQ6fUk3H63_rpJy1=mBCVVBb1xRAd+A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 13, 2026 at 09:47:06AM +0200, Joshua Crofts wrote:
> On Wed, 13 May 2026 at 00:39, Aldo Conte <aldocontelk@gmail.com> wrote:

...

> >         } scan = { };
> >
> >         int ret = tcs3472_req_data(data);
> > +
> 
> Unnecessary space here, function calls and return value checks should
> be grouped together.

Ah, good catch! We actually discourage the assignment and definition like this
(when the result is going to be validated). It's harder to maintain and prone to
subtle bugs.

Giving the above context, this should be rather as

       } scan = { };
       int ret;

       ret = tcs3472_req_data(data);
       if (ret ...)
           ...

-- 
With Best Regards,
Andy Shevchenko


