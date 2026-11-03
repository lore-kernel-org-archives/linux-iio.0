Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700321;
	b=uCFlLHYJnnqtwEhsg8k83U3MGKoAbjtCIx48QEYT7IvbFLhWiOb6XXkcf5kq+gOz7XIe
	 f40YKZk71GwihpTjoZd2Gc4B7wB8bLpsIIDTe5rAqsOJiIxckkdHmwCySHPvhzuWq0Xj+
	 sdRGensG4cHymikrtIuD8FcVdfgFFQAaps/WG+oAUp2ZcteKus1p9zwrIypGP7JKo8d7m
	 9OJiBCpvhFgoDfwWYm0twUkmJydkCsF6xGYPsh77R61e/j6HSU2bfJGXk+4726gLMaP99
	 9naZUm9QVro3KHYPYBAuevC1chBnzCHeHfcC979zwv/utUpsWg2+Dg8JstkjsAAvZww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700321;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=H01nuevod7cnFCrtDHpk23vAzEHHZdXCHyJSMzdN5dM=;
	b=HzYEnqFrZ+E0qCfDowRBGxV9S7S0O7cRqXWVLPcZRerLuIu6loIibN0WhqRI47mIbvW4
	 MEP8rBPf5W9k1YzagGzQz7Gsnb6/4dGMCnhrI+7KH1Xmgj9d1b9xqSMvlAUyIoOsPqGiw
	 pcPHHDNp/mN4qPxkpIkqjdQMX1LKp2bBsGT8biVoJPINFvl3ZdFKuxZzIj8xzVPUkfYiY
	 MkHqSab2+WDUYtKKBjgCcJaToXJTjVHZjmVaGDB4YQ4knvOoV0qBBhwUQwdyZIi6zN6Dj
	 ZuPih0QZPJPhEkcKwIJP7l0muhOuQDJ7clqbb3IHooDKxM8HiSIST0T03jdr9iLGNhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7dnz2HM;
	arc=none smtp.remote-ip=192.198.163.8
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D61606A836;
	Tue,  3 Nov 2026 10:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D61606A836
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a7dnz2HM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793700320; x=1825236320;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/4YV5Hv0XTl7jI4bSouEDC6Desep4PfFSDZDI0//9gY=;
  b=a7dnz2HMkk8VX4fOSICk77lSxOK44sIYEPaOSRYDn+iMs9l7eVFKLYI5
   hzfxX5O4YWfLNBXGQ8tBpjzPxlEPL3NVUKGHIuQC6a7zJ4audztqZZXA9
   C3mem88CnUE0vUmidXQNLBIsZrmY3LLCyq283miTJ3QpNznJEnpsIrFgr
   s2fjrvl5cbJ6YM5cK41nB/giGzp8nu0gCQUwjQzFOzMAWtPJYpbzjjOVd
   T07qWM4Y/Vn94hvVLhGtCZD8ZUDSBUFf1tlnhmRh9nOdZYFPzBf5RN2GH
   cawytP4QlFXiSLlfPBkjlR2VZ2B17gzDbYitnQbtpkWnqpDfRlitvailm
   Q==;
X-CSE-ConnectionGUID: Rs3XfL3gTg2+HycdCKwFLw==
X-CSE-MsgGUID: U0IoOYAuSsOBwHc/zho0nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2308179"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2308179"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:05:19 -0800
X-CSE-ConnectionGUID: uUP+FxXpT42+jL9+a6xt/Q==
X-CSE-MsgGUID: uiJ1IYByS3iTK3YMRmRpeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6490303"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 02:05:17 -0800
Date: Tue, 3 Nov 2026 12:05:15 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Arnav Kapoor <kapoorarnav43@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Gwendal Grignou <gwendal@chromium.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: proximity: sx9310: keep the IRQ balanced
 across suspend and resume
Message-ID: <aumx29VuBAuKdGIJ@ashevche-desk.local>
References: <20261028220444.70121-1-kapoorarnav43@gmail.com>
 <20261028220444.70121-2-kapoorarnav43@gmail.com>
 <20261101015416.4b477c91@jic23-hlaptop>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101015416.4b477c91@jic23-hlaptop>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Nov 01, 2026 at 01:54:16AM +0000, Jonathan Cameron wrote:
> On Thu, 29 Oct 2026 03:34:37 +0530
> Arnav Kapoor <kapoorarnav43@gmail.com> wrote:
> 
> > sx9310_suspend() disables the interrupt first and returns with it still
> > disabled if a register access fails. Resume isn't called after a failed
> > suspend, so the interrupt is never enabled again. sx9310_resume() also
> > returns without enabling it on error. Without an interrupt line,
> > client->irq is 0 and both callbacks act on IRQ 0, which the driver
> > doesn't own.
> 
> irq 0 doesn't exist any more on any architectures I think..
> It did once, long ago. Today it means no interrupt.

...on the new architectures (?), on the old ones we have to live with it.

-- 
With Best Regards,
Andy Shevchenko


