Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03931361DDC;
	Wed, 26 Aug 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787732822; cv=none; b=MQUsdztVWBbynaHWYISNK0QY2fBuV8ssnpgQvJmpZ1oZecuAXCsVNcAjClUvov0eDNf2uIUFp9Zh8eCbmKaGyRZn/fDd9lF5PeYlSgp7eL6BXlAwHwGMeSBU5OC3eCHt6xebC0q2ZV7fq9xM6p0dlA1aoir3PhrHQi/CAaFS92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787732822; c=relaxed/simple;
	bh=DjG1oq7SnqRdBe8jkPiEySnDuQMRC2HVO2VHS57Nhcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/it2Hf52hQIJroqrw2DJ/W9+PLCRSmz2NtOfjo/W7a2n81+8XoIFnAgEW29DDtLm74movYq/QTrERrzChR6hjhAcoje1+W2Dvsg+zXBK+nYPvrWLlq3vVwXdgXdzPFnDhFW8zw8dFBLXuHCHNu2lidBnoieGGpzqTk0gEEhdAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AN/avrT9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AN/avrT9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787732813; x=1819268813;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DjG1oq7SnqRdBe8jkPiEySnDuQMRC2HVO2VHS57Nhcg=;
  b=AN/avrT9opIk0M+3z/8rgKdo0/1TcFCl+WIrgdk1V90DzH472Fbi/1nL
   JT1DonvWpnyCRGoBLseVwP3tH29AMipulTf4dBNiMrZsB8V2stiRrwWgF
   vUE0qJSKvBj6q9VOiOtkF5HDaTlZ5rrZqoUo+lJwCOe6eqDGhCNMliuCH
   UM4KM1AnjRVyAsNmocDepbgQPWA7CLr4VOmsjn7Xk90/9en7eIdCgR3Wg
   h+9ZfBmkKte0m2Mp/crJIg+Z/pCeKNF4X3+HVpeLHvvICtsSEoCvK20kK
   DIBC9rBhcjz4mJCUs0U23OKa+j+JgTH1rBc5MoTrNklvg7H6t2MFEcWPl
   A==;
X-CSE-ConnectionGUID: 4ctie9qLTJOU48GFOS0OLg==
X-CSE-MsgGUID: iuJA1WPSSuqgBtDO9FACdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11886"; a="92025821"
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="92025821"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:26:46 -0700
X-CSE-ConnectionGUID: eyUnDHdPSLK0+ojSgWQ8EQ==
X-CSE-MsgGUID: Rk9WNzlvRhuTPNK+gKAvEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,244,1779174000"; 
   d="scan'208";a="261382198"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2026 01:26:43 -0700
Date: Wed, 26 Aug 2026 11:26:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: mdshahid03@gmail.com, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] iio: adc: bcm_iproc_adc: sort headers
 alphabetically
Message-ID: <ao6jQaJc9FokuK6A@ashevche-desk.local>
References: <20260825172155.250484-1-mdshahid03@gmail.com>
 <20260825172155.250484-2-mdshahid03@gmail.com>
 <ao5dVuReF1Q63ccU@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao5dVuReF1Q63ccU@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 26, 2026 at 12:28:22AM -0300, Marcelo Schmitt wrote:
> On 08/25, mdshahid03@gmail.com wrote:

...

> The sorting looks okay to me. Though, there are some includes missing and a
> couple of them that don't seem to be needed (delay.h and io.h). Either in
> replacement of this patch or as a follow on extra patch (not sure how maintainers
> would like to have it in this case),

Too many lines to sort, hence separate patch:
- sort
- apply IWYU

> it would be nice to also update the include list according to
> include-what-you-use principles.

> If you decide to work on the update to make it iwyu compliant, it may be
> helpful to set an IIO tailored mapping file such as the one shared by Jonathan
> a while ago.
> https://lore.kernel.org/linux-iio/20250629194336.34a03946@jic23-huawei/

-- 
With Best Regards,
Andy Shevchenko


