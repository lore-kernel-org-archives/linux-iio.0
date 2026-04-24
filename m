Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4B929AB1A
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 15:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777045371; cv=none; b=SfjeSbB7cwzEKXtbJdHKPEpLNziREiTF6KvQ2VDML8It8K4nWHD4Tou32VFLEn3ibHqHNMz4JE1kJRRBmmSSwAdz6FIQO4OfL2jXD1ECOEYm8VH4fw1OU5EA4YGMqnaBtcl8WFWgFxIOm4By7LZLDBZmzAIcVoZLEEAE+lMev58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777045371; c=relaxed/simple;
	bh=C4zaCFa2yPnuOBLs9gsOq/mSLxXyoZz8iQH7Eret1Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4nTuzfuiC1wqq8kGWupfLTzz17izTdPuJ20/OQCbeGJ5105DiOPuXTV/IDLcFWz0XMxQZjNbkmTmfwnVfTil1b9BJDTG62r8SY1JF5mogtXX/Ul4Po9eURWSK50j5yemrEJvOa2H1cA8XqcpLllzt3u2vGa7336KeVIwnyXGJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S4sV7ed6; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S4sV7ed6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777045367; x=1808581367;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C4zaCFa2yPnuOBLs9gsOq/mSLxXyoZz8iQH7Eret1Zk=;
  b=S4sV7ed6FC6wV6JIIooUBnX14eEMLdCgGfAvnFOS2gG60/AJWx8K6RKh
   MBttC++TiSs6BssYDOq/uSNraGxcY3+4dgw6bV+UBwnr22KdgnI2mwNrR
   /q7S2d7yh0HUElbSAhRdGfu5F3iSPTg0cbKKcR6sAy+tCxo6CL2MztMYr
   jrMt4pjDYickeoN5NoQOYtWfFGMzs18HZ/NUc+a+v7F4LHQD8DGtW7ZqI
   T19sDhzj3pBBXgbICEmUOJNkD6Dy+pGkMOGHceN6Cywzn26XyULdTmSG+
   QG5K2r/McqNMMnm9/AvrCtuu9nVjJpcc9cNwcPeV4clsjvX9ua24+uNdi
   w==;
X-CSE-ConnectionGUID: qsKdNu0CQoaj/N5oijXMcg==
X-CSE-MsgGUID: 1maRRRsQQie5/l2dE/KEkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11766"; a="88335375"
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="88335375"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:42:46 -0700
X-CSE-ConnectionGUID: qsIde9X4RG+q2FavJy/W8Q==
X-CSE-MsgGUID: nRQ+SCrHTjqtaxxYwr2xLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,196,1770624000"; 
   d="scan'208";a="233278885"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.71])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2026 08:42:43 -0700
Date: Fri, 24 Apr 2026 18:42:41 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
Cc: andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
	Matheus Giarola <matheusgiarola@usp.br>,
	Felipe Ribeiro de Souza <felipers@usp.br>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 1/2] iio: adc: ad7280a: Extract chan->address bit
 fields into named local variables
Message-ID: <aeuPcIyq_IRMj8HE@ashevche-desk.local>
References: <20260424125001.17822-1-lucas@ciziks.com>
 <20260424125001.17822-2-lucas@ciziks.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260424125001.17822-2-lucas@ciziks.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Apr 24, 2026 at 09:43:39AM -0300, Lucas Ivars Cadima Ciziks wrote:
> Extract the upper and lower bytes of chan->address into named local
> variables devaddr and ch across ad7280_read_raw(),
> ad7280_show_balance_timer() and ad7280_store_balance_timer() to improve
> readability and avoid inline bit manipulation in function calls.
> 
> Signed-off-by: Lucas Ivars Cadima Ciziks <lucas@ciziks.com>
> Co-developed-by: Matheus Giarola <matheusgiarola@usp.br>
> Signed-off-by: Matheus Giarola <matheusgiarola@usp.br>
> Co-developed-by: Felipe Ribeiro de Souza <felipers@usp.br>
> Signed-off-by: Felipe Ribeiro de Souza <felipers@usp.br>

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


