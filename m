Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C8733AD91;
	Mon,  8 Jun 2026 11:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780919137; cv=none; b=qLlquRtNN/TEXS6iOZTKwlSVEOqapJCsU5+XWK8Gaa8E+ZllvWWYiOcniytvNCsHqGhFAHZq++5Ao9NzydlyRs0pMHbG/yzOgkNdUZEl/G2uEYnlmz9DVZtOtnq4UnkIWGaQdtEJySHXpIdHXrkwYy1AkVXZjYwD33U9Qx3tFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780919137; c=relaxed/simple;
	bh=I546cR0WXX0c9AbyNfOPEBurEHKxLKd8jA6cYAlEQmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R9GAnb51++ukHTqqybzbfeGhm30fiLaMSWzTKc/erMxp8Xu/wO8wP7OC/F4if+sLBXvX4xKXmubysQMLYsI4ecqCFIv9togT+K2R3ugrESH4edcqGDVpSToBAHQnZ+kQuDo/y8+VKil2IwI4hZsrIwwYyzPAnXs5ht1OaI3pvsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QucZCpW3; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QucZCpW3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780919136; x=1812455136;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I546cR0WXX0c9AbyNfOPEBurEHKxLKd8jA6cYAlEQmE=;
  b=QucZCpW3LecXAYhrJahgtssCqRcL2z+IejoA55TYg9emsEBMNHxSsdZX
   49kVIQRAMMTemtYkEg/TEqiZD6iXeNZUHZo3uhSa8gN4qBbTYZs95E6/a
   UJhkCKPcf5GCkaf77hojSooGKK7Zipa5LIhqSmHG7F9PuZ3JD6sSo2rGQ
   SEl1t9x033xzFay1QtV4bh//BBFdjzzvFRE2wi6jLe0Oi62mrEutdcKCc
   fMubWjaf7hRv8KxYINybQwqJUu2d5HDEekci5MHaXWD651RxMKU9J0k3e
   2asXVR7KvD3vld7PuMmDKiqHRfJv2D/bKFUNKvqpiA+LMyWoVzA3DINM8
   Q==;
X-CSE-ConnectionGUID: irMONn/5Q6envlRG6UQF2A==
X-CSE-MsgGUID: hj/NXaTVSt66bhDT+7MEUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="92757394"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="92757394"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:45:36 -0700
X-CSE-ConnectionGUID: h9CVIuW3TBOCL4TKmKjX5g==
X-CSE-MsgGUID: reagnGMLS/GN9UQIjivwcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="245585835"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:45:33 -0700
Date: Mon, 8 Jun 2026 14:45:30 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi323: use min_t() for watermark limit
Message-ID: <aiarWiBCrx2TJwXS@ashevche-desk.local>
References: <20260607132200.56495-1-dennylin0707@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260607132200.56495-1-dennylin0707@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 07, 2026 at 01:22:00PM +0000, Hungyu Lin wrote:
> Use min_t(u32, ...) instead of min() with an explicit cast to
> match the argument types and address a checkpatch.pl warning.
> 
> No functional change intended.

NAK. min_t() has not to be used. Find a better alternative (see what David
said, for example).

-- 
With Best Regards,
Andy Shevchenko


