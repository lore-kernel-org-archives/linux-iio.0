Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4868A1A6815
	for <linux-iio@vger.kernel.org>; Wed, 22 Apr 2026 07:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776842788; cv=none; b=RCgGHzNsWoE9uGGrghIktSwT//rHXrJSqiYh7fPqP63GMjhjGZmE6iIeQx4YiID/uFAz7CMngPdjOQo/GOTt/1frAZ5S9agfwKLv3RMz1sfnfN7D973V/wEbGVji8TthumgjTCH4gRBquLtlXhp+BDZTepw3+drSJREeSy49DY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776842788; c=relaxed/simple;
	bh=NVz9mwCcCGwHG3cNvMZCGNijkfmsuQnxkYEewIsuARI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6lFgruD9JfC/cJvYtafMx/bs1twdDL48w0l99ufN2ukOg/BGQ0x5KrtgGKxfPIka5xXX2Z7uOpy9jQ8VsqV+bLRSrLKzTWobyqmkqCpa6D4b6jDezw3XRGr8ym+cK+GYVX223J8etIw9iZH29pBwpsD7wlSaGYsDOkO/53UpQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eshrKq3T; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eshrKq3T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776842787; x=1808378787;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=NVz9mwCcCGwHG3cNvMZCGNijkfmsuQnxkYEewIsuARI=;
  b=eshrKq3TWmScd4XCNeIRnv8bwTIZhPf2SFh0j50y8EoYGQX2AX1BMYo6
   oGksNtrEv+oyiWYLw3NIzK1rF4obfvrooL4RBAJkndjdX2Evj9daAE5i+
   C7pphmIo/w0HpaQ6F5LfXMt59b9MmXQ/SqhGGipS7H/IJJwTxECrWKptz
   rXRJtJk61Gte1YUeu/VNN48jy9d0vg3RONBe3gHMpTgHkO0RkkmXB733a
   2Qkf4peuYO2OX0vDZwiT12B6m8ZOwqK9Kj/W8qkrGgOJbXVjD/le0GBGs
   mppycspv3EBS7VuFshhxH80eKMQYTASB7z8jNnpjuAgdos/ORz/ORnU02
   A==;
X-CSE-ConnectionGUID: y74M1daZRuifyT0SaMQ+Kg==
X-CSE-MsgGUID: 6VhzlxpuSCOv7x+TI3dX1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="81654999"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="81654999"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:26:27 -0700
X-CSE-ConnectionGUID: X4bChWVWRRi6v0f2OUwx5w==
X-CSE-MsgGUID: jh6RSULvTtiseS6gtAqc1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231386857"
Received: from smoticic-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.201])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 00:26:26 -0700
Date: Wed, 22 Apr 2026 10:26:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Laura Arakaki <lauraarakaki23@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tsys02d: Use guard(mutex) in
 tsys02d_write_raw()
Message-ID: <aeh4H0GS2fgBRbix@ashevche-desk.local>
References: <20260421154007.1114389-1-lauraarakaki23@gmail.com>
 <20260421185019.64411e62@jic23-huawei>
 <CAJN_CScSHkrXGsF9pjWna5eYnRsPiwj47+7NbVYSVBGkwL3AJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJN_CScSHkrXGsF9pjWna5eYnRsPiwj47+7NbVYSVBGkwL3AJw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 21, 2026 at 06:47:09PM -0300, Laura Arakaki wrote:
> Hi,
> 
> Thanks for the review.
> 
> I'll address the issues:
> 
> - Fix scope in switch case by adding proper braces for guard(mutex)
> - Simplify the commit message
> - Remove unrelated changes
> 
> I'll send a v2 shortly.

No, please slow down. Take your time to review patches from others in this area
(IIO subsystem), read documentation, et cetera.

There are too many patches now that overload the capacity of the human reviewers.
Also by reviewing others' patches you will learn a lot without even submitting
anything.

-- 
With Best Regards,
Andy Shevchenko


