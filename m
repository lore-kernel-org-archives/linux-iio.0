Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD9F3E92AC;
	Mon, 11 May 2026 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778506244; cv=none; b=dcilh0dOdkWDowBCjghl18C3lzfojK0DAVFaq/eOPJ4i3BKfRyBX0+PlHzVYVLiG3LYTK13xwT8lfipZukHS+kgZPDIelonGcYiFTCL8Nilj25FrAumOhtElIOLb4zroeNb3xq/pjvI7EHqxk9yR8GXsH35J5xYBoZ9WWRq/cEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778506244; c=relaxed/simple;
	bh=r6bh73RL0sXeZQWBuDMZyjW5WE5/DoOoT8mQXRaUrSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BuysafbWz0lztbq4mXB+fLRjOY6q19k+KRlIWFAeCQJR9uywLvsBGTUwy6U7XqqddUFnNr7v336DUZQnP3ogguFEoLlC+Ng8YF9rV8LMwpJTbqfRGvZ2Wq1GC1plUz/PX4VOWrh+XFtZ5ppqKPnFlxwzexEOcOzQMDLE2twBUb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SBtNmvoS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SBtNmvoS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778506243; x=1810042243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=r6bh73RL0sXeZQWBuDMZyjW5WE5/DoOoT8mQXRaUrSU=;
  b=SBtNmvoSx/p8xGmjj2kAzV+fH+Va7p3vo4h67BmgZ5THAwevejoGBgjE
   iZ+n7RAP47652DggMAZJe0iMtmP1/lcSGlg3pFeHJO1W2nzTNv6+cbeJa
   9kcGhuNeUSjRodDcAhwXW967XwbwCK7KSGtQjpmoncGhqchHXHd3BV5lA
   wmPWN0/a6f/ZyGViTlnW0nzc2+Svpx6axS9/5nWJwXgyv+iggSJfSYdzc
   rE/qwOdaDStT0WXG1qdWK8NJMgylQbDckRPVszW5NmOrXkdCN2kvcAAD6
   P5dMvYzQmqevGXHj5GhWE4rZZh1PxiDoBW4+CJ6CFE3MNWeDZSmp/7IZ8
   w==;
X-CSE-ConnectionGUID: I4DT+mG7QUqWqHWbvt8t9A==
X-CSE-MsgGUID: munT88NDRHG7GJ+EjmMwwA==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="79494643"
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="79494643"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:28:45 -0700
X-CSE-ConnectionGUID: 2k57Np9oRaKXw7g7uU2QxA==
X-CSE-MsgGUID: lRubypsiStijhiGWlUmphA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,229,1770624000"; 
   d="scan'208";a="237408072"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.204])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2026 06:28:42 -0700
Date: Mon, 11 May 2026 16:28:39 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
	alisa.roman@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: adc: ad7192: replace usleep_range() with fsleep()
Message-ID: <agHZh32XjOMcPv2F@ashevche-desk.local>
References: <20260510113921.50133-1-sozdayvek@gmail.com>
 <20260511025545.41631-1-sozdayvek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511025545.41631-1-sozdayvek@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 07:55:44AM +0500, Stepan Ionichev wrote:
> The AD7192 datasheet (Rev. A, page 34, RESET section) says:
> "When a reset is initiated, the user must allow a period of
> 500 us before accessing any of the on-chip registers."

> Use fsleep(500) instead of usleep_range(500, 1000). The 500 us
> minimum stays the same; fsleep() picks the upper slack itself
> (about +25% on a default config).

The second sentence here...

> Add a code comment with the datasheet reference so the "why"
> of the wait is visible at the call site.

...and this paragraph are unneeded details.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


