Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D7B48A2B1;
	Wed,  6 May 2026 15:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778082359; cv=none; b=YZ8eTC2Oh5ucWTMW5dY/cnyn2kYXtbazq2aFfxRb1zglXYnVHAzB3ShOd4YZ1pLmyhCMHCLYidJpQPkAwlGXEBRCVsMjusClzEcXF8L6xZb/kI12BelHWErqng+4xMi7oQHD0OHEO2k2Mt/wKv6NnNLauNtw5gJZ/uzPPEMFhbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778082359; c=relaxed/simple;
	bh=QqlCtMiLAL4XeX46Zata65qWqC9bXCCftFoa0e9dJ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti30Bnyn5X7+YVCBF0ctC2GzGHdLyIHHYnyVxBqpwJ5zbtvLQ9ToE94mSiXN8vIpnt8e2qf/CGTQS0T2pfnC3dMkaVXQKm7Si7f8W5uEVbXPY4I1fdwyYzU/pPo7ZfxlPCJW4y4NXMTQWq6M2ZI5dytHxWAyBCO7KggHF41jMLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gGl1U2uO; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gGl1U2uO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778082357; x=1809618357;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QqlCtMiLAL4XeX46Zata65qWqC9bXCCftFoa0e9dJ60=;
  b=gGl1U2uObBhD8Lcy69t5aSxhxX16c4f7ExHqSXdMVcBfILPC8JVebomu
   vGFwxFfsI7jgK8hS1L0yiVhpmxXYBM5dj6hYV93QmgWP6+GF0+uAisien
   /hB7aQK80eOnCFlXAiw9yLMrafA1frHlThiFSoxF4aEGUa0tw7T4JNBs/
   DJU1qxWWD9Zb6qk8UiCAOm9z5DeGZM/f95Oi3SPHlCKISYvuSAX9T8WGk
   A271hSNps+NUYVRgWyjYLpkaggTPG9Hk0yAhxRFzw6WxDcQAcqyNuJCzb
   iZnwvekZ6qkj4XvCg0prYS9p747Cuf/qsxktjjtSDXIgHFhVi6Nuw2SPj
   Q==;
X-CSE-ConnectionGUID: o0NVtI76Sx6cOAuAPtH0ow==
X-CSE-MsgGUID: TexVyt9FSiWj42+xUEumPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11778"; a="78868514"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="78868514"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:45:55 -0700
X-CSE-ConnectionGUID: EB6Awzv6Q2uxLwImnseoaA==
X-CSE-MsgGUID: 72n2t8MaTtizOWhOgSCeKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="235174633"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 08:45:53 -0700
Date: Wed, 6 May 2026 18:45:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aldo Conte <aldocontelk@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 0/3] iio: light: tcs3472: devm conversion, wait time,
 locking cleanup
Message-ID: <aftiLlKIdT89cpi2@ashevche-desk.local>
References: <20260506094311.222500-1-aldocontelk@gmail.com>
 <afsWI3MKoWZS4mL3@ashevche-desk.local>
 <16c08754-840f-440e-a252-b14172393394@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16c08754-840f-440e-a252-b14172393394@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 05:35:42PM +0200, Aldo Conte wrote:
> On 5/6/26 12:21, Andy Shevchenko wrote:
> > On Wed, May 06, 2026 at 11:43:08AM +0200, Aldo Conte wrote:

...

> Thanks a lot for the detailed review. I'll address all the points in v2.
> 
> Regarding the series structure, I need to clarify the correct order:
> 1) Guard (mutex) conversion

Since this most likely wants a new cleanup.h to be added, the 2) Header sorting
should go before even this one.

> 2) Header sorting
> 3) Devm conversion (with the new TCS3472_Powerdown using Guard (mutex)
> directly)
> 4) Wait time implementation
> Would this be OK?

Otherwise sounds good, but I can't be 100% sure until I see a v2.

-- 
With Best Regards,
Andy Shevchenko


