Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631C430EF8F;
	Tue, 25 Aug 2026 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649276; cv=none; b=Z71JBAosSVt+N+QBxUXSIqC66wN5LEbwIGqidFRXFPLeb2wG5GHNzkiTahKzBLCM4SQZyCZl2IgQPVgnmBxNboMgG4kDJSYkGV7/gPLbXyRs4LphKf2m0yMbVpeqmAQ4UEVntFmu34H9T3nbXU5in8MstHeVLOUNwcCjt5JE0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649276; c=relaxed/simple;
	bh=6TgCRUGVbL4ny5lapGm6DsNOzs2P90opasn/jYDYYU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r57JxOUdOtq6i+OwAtVGvjqZo2Vi6VAhAhM0O2OKKlIS5CC6NBPqXYNDGHZwh7Kdt3vXyeQZY1si0KSlotEanTIvbCLBJ/zvoDzpmW0NK0CO2c6sK9YbcQXx2Ql7n8ua5h/I6qKCzhzo6jgv/9Bvw6zW/1jsoFmcqE7PNALSBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IJTUal1b; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IJTUal1b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787649275; x=1819185275;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6TgCRUGVbL4ny5lapGm6DsNOzs2P90opasn/jYDYYU4=;
  b=IJTUal1bobCsYWh1gntd5/OsZgCVjLLWdVgjR0Gyyb91BBsrC112m0BG
   WCYTS++r7D/doXF8nFh/OkSjMK18L4l9CnLeCZkb4vFgexRIBo2ZoDN0g
   exrCsdEGqPoVAdOEx2IlHZFDrE+U2AAAfgp1iQUijD0SeEPhhMAFvapgf
   npb8H8uo1b77GzVFTQ7k4KwSJUad9unz6tTZUmktMEMhR1UqRup2J8TVn
   reV05TP9RJ6h2JOUOlsJ5CnLqBXTujwdQgLGr/SA5AngBM9z7MAVhb3ml
   atHZxoRi682nzHAmTuIHg60pWX11xTAxbIr4v7DNX4kQNZo8GJQe/ZVAK
   Q==;
X-CSE-ConnectionGUID: 75H7bhEZTsKKnqTvQp3B/A==
X-CSE-MsgGUID: oWealmxeS72t/cqIGtR3mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88033555"
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="88033555"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:14:35 -0700
X-CSE-ConnectionGUID: aM+X4UxXQyuWNswwbv8aeA==
X-CSE-MsgGUID: hrd8n4BTScGKmbuqhYsjhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,242,1779174000"; 
   d="scan'208";a="271032844"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.59])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2026 02:14:31 -0700
Date: Tue, 25 Aug 2026 12:14:29 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Triet Hoang <triet.hoang.dev@gmail.com>
Cc: andy@kernel.org, bleung@chromium.org, chrome-platform@lists.linux.dev,
	dlechner@baylibre.com, groeck@chromium.org, jic23@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2] iio: cros_ec: Convert to DEFINE_SIMPLE_DEV_PM_OPS()
Message-ID: <ao1c9cSEpCDfaO67@ashevche-desk.local>
References: <20260821014454.15960-1-triet.hoang.dev@gmail.com>
 <20260825012725.8908-1-triet.hoang.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260825012725.8908-1-triet.hoang.dev@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 25, 2026 at 08:27:24AM +0700, Triet Hoang wrote:
> Convert deprecated SIMPLE_DEV_PM_OPS to DEFINE_SIMPLE_DEV_PM_OPS

SIMPLE_DEV_PM_OPS()
DEFINE_SIMPLE_DEV_PM_OPS()

> and pm_sleep_ptr().
> 
> This lets us drop the __maybe_unused annotations from the resume callbacks,
> and reduces kernel size when CONFIG_PM or CONFIG_PM_SLEEP is disabled.

Not really, the __maybe_unused is done in a way that _object_ size is bigger
(function is compiled), but since it's put in a separate section, linker will
drop it as unused, so the resulting binary will not have it.

...

Code wise looks good to me.

-- 
With Best Regards,
Andy Shevchenko


