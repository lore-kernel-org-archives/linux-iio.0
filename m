Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40C925B0BF
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778616718; cv=none; b=SJX8x/UG6ra0tIoKi4vSpZ+9OXImFrfN/CFA6aWzhwHVCFbY2Wo8Rij3WUc4NFV5jimNbeAj1FQrUixX35TZxTyRcyTnrObvrVWWb6qkofxb3ModYCxmlaLuE2Jg8luQHtCSkatoMpiL0toCOKZ+trOKSQrI6CcflyVfkyz+atU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778616718; c=relaxed/simple;
	bh=1VRVEKNrSoK+HjBqhCQIVLIXS72QOaDi99C44aCDflc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYm7DI45WqXvQzd5Vy09zaRIzRRp4gEPkK3RNqCIi8IGzKyG0RlDh/VmW4k9Qes0DTjEzGa2DNkuLbfY9Va4mQcNCK7CDclXsdZlg4umOQMb4u//LiUQ6wJSoyoHYudMbJB7ucFmFQjJJTrScHKx8lrfd4PUBaSo5xQUzcYbFSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RCWvIBS6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RCWvIBS6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778616716; x=1810152716;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1VRVEKNrSoK+HjBqhCQIVLIXS72QOaDi99C44aCDflc=;
  b=RCWvIBS6zy64FsY0RkMgkLR6MSrjIJCORJuQSHcYqBKVtB/NRezBdc/H
   3QYUlC2rh5ZYOSoUwWi/Hmhn6SSo+7D41pZy0f8G1kgmxau168dXY4TCm
   6VPdMA21LLsa8hPdhkKw+NV7l/CuP1BQcjYLtkooHNYqdM1+suLQPxMWX
   E8oCRqCGQuOI7nprR+wt8+b0UwoWMoR44LBr8subbWnYOtkdUrGGtaXeg
   iSYQF9hDsvG1tPD1F5injF9kPUqs8s/JMmfPHlaKdMypJuY6iAU0OO8aa
   WeIB94RJ9R9ygKasqQ1M24FK8+sCmC8ZBh+1P6rJNpoQK/5K1WkGUR+ac
   w==;
X-CSE-ConnectionGUID: 2VQke8ZXRGWi+zm8BHE94w==
X-CSE-MsgGUID: esHeKlJWTPiw+wj89l2SCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11784"; a="90920519"
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="90920519"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:11:55 -0700
X-CSE-ConnectionGUID: MxKmPVU6S1+wSgwepBnsBA==
X-CSE-MsgGUID: av7p0MmOQMGjOIcEpRaAVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,231,1770624000"; 
   d="scan'208";a="242221428"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.244])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 13:11:53 -0700
Date: Tue, 12 May 2026 23:11:50 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Aline Ayumi Nakazawa <aline.nakazawa@ime.usp.br>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: use guard(mutex) and scoped_guard
Message-ID: <agOJhr9lj6hKnX4q@ashevche-desk.local>
References: <20260512172538.101383-1-aline.nakazawa@ime.usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512172538.101383-1-aline.nakazawa@ime.usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, May 12, 2026 at 02:25:14PM -0300, Aline Ayumi Nakazawa wrote:

> Replace manual mutex_lock/unlock calls with guard() and scoped_guard()
> macros.

...

>  #include <linux/pm.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
> +#include <linux/cleanup.h>

Keep it ordered.

...

Here I finished my review. We have a flood of the patches from the .usp.br.
You, folks, have to talk to each other and share and study previous reviews.
You are repeating same mistakes over and over!

Please, come again when you fix all the problems that were flagged in the
previous reviews for the usp.br contributions *and beyond*, meaning start
reviewing others' patches and learn from other reviews.

-- 
With Best Regards,
Andy Shevchenko


