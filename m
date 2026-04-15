Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C5126F3B;
	Wed, 15 Apr 2026 08:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776243539; cv=none; b=R5LDy0U6RMOZfxGeoz54X3Z/QNfFB8yARsHmzBIExFropqckd4n+isQqSpcmHD353ddIhlTPW7qNmQ2QhaE83p8X2KsipbjV9MQ2ciSReQ+a2b9MwN7iRN29O6gO+CSUlacy/5IvZfA0I4PQoX6+Gib47p9DvEGKOppKprsxHJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776243539; c=relaxed/simple;
	bh=6VU4pqtTLmcH5YmpG8MAoIa2YX4tL25GOQ/BzQZxOP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHz1soTygxXK52nGHvhk14V40UC/b1tQi0OphUqqjQ0SOQixp3W7r6/oGfgfksv5h0KqhXVISWPHcCkg9nWBjm62jlYtiFV0kKIGe20DtQIxa0ND/cEoUWow59IfovIQI5WW88ek/mOET6dTSbXfsfSIQ0lwbAqxgu8bckbXexA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z75eI9vh; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z75eI9vh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776243538; x=1807779538;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6VU4pqtTLmcH5YmpG8MAoIa2YX4tL25GOQ/BzQZxOP0=;
  b=Z75eI9vh1wxeWITK8RCYolQsSbV2nF4Jh3HN9D3iG1eI4O/TP1UfRgfC
   FkAZR8AhWdM4JTZkn2dDvQ4Dt+/rVqf+GEWK72EcHBRxIgIqdl/RwedR+
   gwUc3zMGBHjK4t2NAGUs4lxCIcXpkFhdQzjmAwfaHCw1LoOdiz0VKeyiG
   qYGRhZS4XwDbWKBL0e1VkNfrXgCS9EJ3cMElCo5zJgnSd1X7KvjXBxcKd
   U+FXoLwHMsXJfCHCu7Pj4IRLPvAA74yp19A8Gj9bcuith6fb7mPTgGEN4
   u/whCfQxgsfZ8ZJQiCkF5Y0K9DQTXuooMXwjKoPyZ12GxwmmucFycB2F+
   Q==;
X-CSE-ConnectionGUID: uUWvVDgWSAKMKlNeLzEm5w==
X-CSE-MsgGUID: YUtxD4V4Sgeky27KP89/Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11759"; a="77286234"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="77286234"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:58:58 -0700
X-CSE-ConnectionGUID: iQB2DxR9Twy9YyNH0WDMHQ==
X-CSE-MsgGUID: puik4IZ/QEWz/eRlaHWPMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="229505000"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.34])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 01:58:55 -0700
Date: Wed, 15 Apr 2026 11:58:52 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	gregkh@linuxfoundation.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: frequency: ad9832: simplify bitwise math
Message-ID: <ad9TTFaLo6TAROEq@ashevche-desk.local>
References: <20260415080812.1284-1-joshua.crofts1@gmail.com>
 <20260415080812.1284-3-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415080812.1284-3-joshua.crofts1@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Apr 15, 2026 at 08:08:12AM +0000, Joshua Crofts wrote:
> Refactor the ad9832_calc_freqreg by adding a BIT_ULL()
> macro instead of manual bit shifting for better
> readability.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


