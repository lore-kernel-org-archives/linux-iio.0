Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C9B332EBB;
	Mon,  2 Mar 2026 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772439676; cv=none; b=tptcsnSf7WtBzH6Dnn2AANLFZaob/B1wrG5dpXn+o6Y7M9nYBLd7lQv3lW/AZz5iccqG7VPDSYzhnjvVF2HBsyQQpZWfGHgnpxYR1QmdL4TL3pQVXLGOFDcBLLfOAzEW0nIbVhHodEimKLb03hzrDVWoq5LQSd5gOANNsEu+wg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772439676; c=relaxed/simple;
	bh=1gikG+xt7pIdRBSGv8RPqOpGSqs7X1NXyBofoZUBPKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H+kawmIX6fcXJ4cevoPVulSwJYPUpWbdrEncxpb4CaWk0vzVgTeb29L9TOjr02GYimOiPaQWEqTo6yyuTY9E31PBGDU+zKlL4RERxlO4VXMu8BQHxjkmvsNjfTGFzuhxgw1/L1MklqKiNBoleT+GH6s/dRhpTmQp/TePOQN71eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z1t0bOuO; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z1t0bOuO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772439676; x=1803975676;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1gikG+xt7pIdRBSGv8RPqOpGSqs7X1NXyBofoZUBPKA=;
  b=Z1t0bOuOUqA7cHv7ogrCxdNcuTW/tDFFT/qbZIQg9qGAvFdboNgIHI0F
   Dhtoti061MHzX8S8nBt01UGRthBibetdm17fl9d65+kjFfOhodB50h1SI
   ZhcTcDd+a13ugYs2zrNnrBEoQm4GzEIhXhy5KsiCKrD4NlXz/ZtrhAkqx
   mtsFLLSi7wgGpWxjgu7TL2tcm1n+zfdBOaS4AeEH2MTIsqWG4SbCYDRun
   dXMIOGXq95jhcGADjPByg2DTgH5o8njjurixD7WnPI43TqooNSw2ltuI1
   bVGRXCgGftEkAzF/thfpxu2sh3d7G9V7pS7UO38eKLj0C3XOHQen6xwNH
   w==;
X-CSE-ConnectionGUID: nYWCrwLSSjClCZoK0LtQRw==
X-CSE-MsgGUID: 2MxTylO/SBeelDn4ia6ivg==
X-IronPort-AV: E=McAfee;i="6800,10657,11716"; a="77280948"
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="77280948"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:21:15 -0800
X-CSE-ConnectionGUID: Xh2QbtDCRZykOHynCBEskg==
X-CSE-MsgGUID: /ZSt7myqTW+ZCZLurEqwiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,319,1763452800"; 
   d="scan'208";a="248081945"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.52])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 00:21:14 -0800
Date: Mon, 2 Mar 2026 10:21:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Neel Bullywon <neelb2403@gmail.com>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] iio: magnetometer: bmc150_magn: use automated cleanup
 for mutex
Message-ID: <aaVId0_InmrZJCl5@ashevche-desk.local>
References: <20260228172320.68144-1-neelb2403@gmail.com>
 <20260301115633.7529cbee@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260301115633.7529cbee@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Mar 01, 2026 at 11:56:33AM +0000, Jonathan Cameron wrote:
> On Sat, 28 Feb 2026 12:23:20 -0500
> Neel Bullywon <neelb2403@gmail.com> wrote:
> 
> > Use guard() and scoped_guard() to replace manual mutex lock/unlock
> > calls. This simplifies error handling and ensures RAII-style cleanup.
> > 
> > guard() is used in read_raw, write_raw, trig_reen, and
> > trigger_set_state. Case blocks using guard() in read_raw and write_raw
> > are wrapped in braces at the case label level to ensure clear scope for
> > the cleanup guards.
> > 
> > A bmc150_magn_set_power_mode_locked() helper is added to deduplicate
> > the lock-call-unlock pattern used by remove, runtime_suspend, suspend,
> > and resume.
> > 
> > The trigger_handler function is left unchanged as mixing guard() with
> > goto error paths can be fragile.
> > 
> > Signed-off-by: Neel Bullywon <neelb2403@gmail.com>
> Hi Neel
> 
> LGTM, but I'll leave some time for Andy to take another look if he
> wants to.

I briefly looked and I'm fine with the code, but I haven't reviewed it fully,
hence

Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


