Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C99443D500;
	Tue, 28 Apr 2026 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777382769; cv=none; b=lw3TCaeT0F3VsWernQsYkaiU33oCke1eEikOCMREOuoU955HHo7ExJ7R9cZYHdZtwgNb+8tBBy8Ziiu4PR5aNPd4BtrEj/J5L7hSOLfp5+02734s9oE0yiooqcM6csa12wvnkCaPBM8RHDX2DKQWk3gC1paECvkrLe7PhVK08Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777382769; c=relaxed/simple;
	bh=h3MuufUqQ/0jOSWBaUim2fykNeu7yWyU/TiOEDwa+To=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXP8AAFXNfTgDwMe+2HLreR++N/vWq9WTo/vSIIlzc1Ood7XL8NoLu9QKFSdXWMVj5KZUQizXz1lylHIm0k+BEL7rz9VK26ql6x9NK/sJSRnDM8sX2kW4dyRKYdIOU2buzs38fRl7/ATZlrK2Iro7wHjy2KT77Vq3cDFfpoS0lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsdHvqDq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsdHvqDq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777382768; x=1808918768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h3MuufUqQ/0jOSWBaUim2fykNeu7yWyU/TiOEDwa+To=;
  b=GsdHvqDqwXH6oAsZLHuOT8plYX+zw9KihD+UFowRq9lOAqKxhZN7SWbt
   0ewzTsayIPonZhECIpBBtDh1gO0MDXNIYty2mNOSa/WQJhqG6OMdsSW08
   JYp5uxn/kc3ecHsbkQd3J2nsVWHdw3ytHDuOq3/1mbckOU4B5/WNSWw9z
   YWDpBECPcNLjf9m+KaIjtET0XMbXOH/MycAz8G/izToBSRT6JSR9Kk0FO
   h1DwLx33JdkhGH4BqYodh60okG8fF6yCPKIZxPQzv235ALcjhC2U/ZtIF
   fenNe9lxoo5oCkVJdoAkr1P6TIlwqws7igM+dCwDErP1m8LRlbgWTo7cC
   w==;
X-CSE-ConnectionGUID: WlUycGY8RhmtheTTcA+f0A==
X-CSE-MsgGUID: mApdcWiVSg+6PJ5oB2fpBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="95704674"
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="95704674"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:26:07 -0700
X-CSE-ConnectionGUID: 5ZNnoebcR/atU91TnJ2MJA==
X-CSE-MsgGUID: xRmy6VvuRx2Zw9Qp1jGssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,204,1770624000"; 
   d="scan'208";a="233101779"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.213])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 06:26:05 -0700
Date: Tue, 28 Apr 2026 16:26:02 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: songqiang1304521@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] iio: magnetometer: rm3100: Use guard(mutex)() in
 rm3100_read_mag()
Message-ID: <afC1atIQYUaFBya3@ashevche-desk.local>
References: <20260428124644.49707-1-m32285159@gmail.com>
 <20260428124644.49707-2-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428124644.49707-2-m32285159@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 07:46:41AM -0500, Maxwell Doose wrote:
> Replace mutex_lock() and mutex_unlock() calls in rm3100_read_mag() with
> the more modern guard(mutex)(). This will help modernize the driver and
> bring it up-to-date with modern available macros/functions.
> 
> While at it, remove the now unnecessary "unlock_return" goto and
> directly return in if statements.

Perhaps we need to also put a summary of the extended critical section, so that
it will be clear that we thought about it and decided to cover that small memory
access + some bitops.

Otherwise LGTM.

-- 
With Best Regards,
Andy Shevchenko


