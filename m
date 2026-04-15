Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D533508E;
	Wed, 15 Apr 2026 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776246142; cv=none; b=cNtgy0FbxvXlIXjyHHMpObtyIONnz8JlYIrVnC39dmff4O3Jej3KVDoVR0GK99uwG0w7uORb84SI3tSxuoBU3ZDjzPjdbgqqs5sjCfO2UnyizLeGEqWQ6JDXJuHim3TYGSrgqTb0y7vf4C4fOV8EXcqw7j8Z6h31V0qaU4QIShY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776246142; c=relaxed/simple;
	bh=M1UEwpxVdZdDVOrgtmAzMlMrkN7lBjsAi6dysLIg/xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUUuPhMsGYus9QvhHFf8eQapY8B0oXICCe+B6GEwyBbkOlruKQmIAhrDjibVn4VQ7L9R/dGD8WOicQrBihsDBZURmUhuZuNI49CJsSTmX4JwBEgxUhTCZ02R5/YCockzj5kxVaMItNlXfdtLzZbGolHCETlzHHIN4NniUlCXKzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KP1yykoR; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KP1yykoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776246140; x=1807782140;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=M1UEwpxVdZdDVOrgtmAzMlMrkN7lBjsAi6dysLIg/xA=;
  b=KP1yykoRBX37rnb8FnFenYebbLz+WqMnRCXjXh9Udp74S056YBE1R+87
   WAPF3wIOkrbsoiQK7Bh5JlCkEssoNwV739O1k84Eh7qgRuti4e0Fd3ONP
   4KStXIhvbRi97vuTzat8L5EinDQw9AljCGxECkRgRMBB2LmGhgjTRFY1v
   AiLjT1IJ52Cb9Zm5zSkQyG+EQGSVYkff/8mmj4D9reP0HsZ43IPJ3JqF7
   k3PON2DFBuRptUWmp3kaJUc0QZQqhuJCsymf3pg8ARamQBEv/uhRf8+Pq
   ZMeEkkkANiVhQMYpYYaEj4UeamFopP2e+Y5ASS57qlpTvUF09vupuUyPe
   A==;
X-CSE-ConnectionGUID: 29JmELHVR7KJ8dWUFibjeQ==
X-CSE-MsgGUID: QzdCP5GZSSOA4Bhmf4TlXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="94789364"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94789364"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:42:19 -0700
X-CSE-ConnectionGUID: Hj9n7Lu5S/KxhvcRyvtsVA==
X-CSE-MsgGUID: MmVn1nh5RCuM5+HbcmMI7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="235314987"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 02:42:17 -0700
Date: Wed, 15 Apr 2026 12:42:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: use pm_ptr() for dev_pm_ops
Message-ID: <ad9dd_-lLmazqD5g@ashevche-desk.local>
References: <20260414192045.3598010-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414192045.3598010-1-sanjayembedded@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 12:50:45AM +0530, Sanjay Chitroda wrote:

> Use pm_ptr() so the PM ops pointer is automatically set to
> NULL when CONFIG_PM is disabled. This avoids unused-function warnings
> and follows modern kernel power-management conventions.

...

>  static const struct dev_pm_ops mma8452_pm_ops = {
>  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)

You also want to change this to DEFINE_RUNTIME_DEV_PM_OPS().

-- 
With Best Regards,
Andy Shevchenko


