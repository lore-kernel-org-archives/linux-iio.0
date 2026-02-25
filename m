Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FB12FD69F;
	Wed, 25 Feb 2026 11:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772020389; cv=none; b=BVm+kj6JkIfqhkECfqV+qzXpNvV8O0RBj1NqSNHq1LLcThWnpjXJLC1E/9GwvEy7uJFbfMcKpTBG3nynxcUykTIsqJ1N2DepoyiYK3S8jbLfS7UXVC9VVIhXK9cX5+FpraVYjH6EblP/4z33anIjboAlrsbAXuVVKg7TAKqQ2C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772020389; c=relaxed/simple;
	bh=dNt7JG8MH0/eBZa+VJtID8uu9oHzXlBLTJYB4+yEGHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iTavEt0xRmc3OmkIDwGKOV8TAvVgKUAszVfrMUOefCVbIYaccKVrMseHJUeyWB/5tzKprqMNX2oDGnbFlIPtjFLlOjRCrFKbRK7DNPMiDCbIh07pKcLc9ZXuk+OwPvk7RVszq6LkIBK0/+ExS4MQd2Uhky+u62DViX5yu/ZXhvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=df8u0tlk; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="df8u0tlk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772020387; x=1803556387;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dNt7JG8MH0/eBZa+VJtID8uu9oHzXlBLTJYB4+yEGHo=;
  b=df8u0tlkRpjvITO9/A1zAYx8lnJ04F+5JwC+mvgk5/b5TCdvBKZy3mWu
   NKdgwPNkT1QCA6RwQSerRKBKWmHHPO7AAM37lPuNrAkGXMVleognna4ik
   xj/WOxJqJWfVSGhohj2ijng2OHuVU4HmYd9Jjo5rLyTxS1qx6FeukTaT0
   Cex7elPcKdAZBsGgd7mz5pJfuDhCDfaFeQaEwNitoAxm2/luF4sPFNAQM
   W1fFabHZ6txA8fEEeUHMUJoxSnfSIXQM/QkDBSyv/jV1ue0ypcPP4P8/W
   Q6zm6z1E/pMNqXqhNh52/BVcQZIPmr9aLmOtgYxhmetpyBeaeNVHSpr5Q
   Q==;
X-CSE-ConnectionGUID: Ns2nWtAsTBeb9bmer4fiRQ==
X-CSE-MsgGUID: XT32aAjZRqGQKyceFcMvKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="83681730"
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="83681730"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:53:06 -0800
X-CSE-ConnectionGUID: gENcmoUQTPe0IHTfY9sBWg==
X-CSE-MsgGUID: O9agz8n4TB24jchazT4Wxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,310,1763452800"; 
   d="scan'208";a="214337696"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.71])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 03:53:04 -0800
Date: Wed, 25 Feb 2026 13:53:02 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: linusw@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: gyro: mpu3050: Fix out-of-sequence free_irq()
Message-ID: <aZ7inmsCXRxR94w9@smile.fi.intel.com>
References: <20260224224818.2452675-1-ethantidmore06@gmail.com>
 <20260224224818.2452675-5-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224224818.2452675-5-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 04:48:18PM -0600, Ethan Tidmore wrote:
> The triggered buffer is initialized before the IRQ is requested. The
> removal path currently calls  iio_triggered_buffer_cleanup() before 

Double space and trailing space.

> free_irq(). This violates the expected LIFO. 

Trailing space.

> 
> Place free_irq() in correct location.

...

No need to resend unless asked for.

-- 
With Best Regards,
Andy Shevchenko


