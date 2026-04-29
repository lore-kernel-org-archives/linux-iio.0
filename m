Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E76287259;
	Wed, 29 Apr 2026 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777444568; cv=none; b=X2zhJrznCyrr04Qncpz+Z/xqd8Ew2kH6Cm2PRSoeUe5A4Wtyvlrg2+r9/FgCsuYK4pCH6mlcRLSedZSFfkfxOgX1VLlfwj4cFS9R8J4aOYXUPTelgVs0bLU0i4Fi+LH0GEonKKOAnLcOkGe2K4k/KDj3h1rpLVJIyqeKIvpZZCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777444568; c=relaxed/simple;
	bh=WQpiuEzDMfNgKjWNUtIN3UUfC/a5jK7vZ1QlvMyincM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuDrt11ZSe7xvSxQlwMWSuEEXwah5tazp6q7snPyGjQQ9zAsOqmsIQYDWaQHgYqq2aKFsHkUAFkmiZVo6draqFroGySwE3utW9F9XiV+1SnEchUTJE7zNuDSYjtMfk0g6XqruVoV3EpHD9XCAJN4SVbQ6l5lHdB3ee3B7Y4ZUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEziWkyw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEziWkyw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777444567; x=1808980567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WQpiuEzDMfNgKjWNUtIN3UUfC/a5jK7vZ1QlvMyincM=;
  b=TEziWkywmK7OcL7paubx3WsF4raeybH6NHyG6377bEs4S2Lzw74CVeDo
   ErdwjPgOkR5zlMHnYYKHrBxn6i/BkDE4j4vkkyxFdgzowyuv0Ho2uq5Vx
   2PtKE75fWagVjIGqBk6dpxrB73/p9wRoBB7nMuXtA8oBkgKcsIusJjhm5
   CCXQJgdWpwLGnIIUxcTXDEjyKpMigBi1+js+4vms34ZIZnf7/rkSp4zG1
   0REy0WnGF29pY2/j690FqEihxmrPnD+u26GWL66Sln7rQihmOphV4lgdh
   icWOH9mX3TSZRTTsxx+V5HzaPInIF3JRKu2dJDKy97c91N8SqD3he7JtC
   Q==;
X-CSE-ConnectionGUID: 4XFNDq4HRxKSfvLS5mljVg==
X-CSE-MsgGUID: smyuY+t5RwKGjr6p1p3Ngw==
X-IronPort-AV: E=McAfee;i="6800,10657,11770"; a="88963045"
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="88963045"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:36:06 -0700
X-CSE-ConnectionGUID: YJkh8UaSQDy0SkIbbwCm9w==
X-CSE-MsgGUID: L48drwnKSzScYD+N/5TkaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,205,1770624000"; 
   d="scan'208";a="233319392"
Received: from ettammin-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2026 23:36:02 -0700
Date: Wed, 29 Apr 2026 09:36:00 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stefan Popa <stefan.popa@analog.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Auchter <michael.auchter@ni.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v3 00/11] Fixes and cleanups for the AD5686 IIO driver
Message-ID: <afGm0PFtXl_Y-277@ashevche-desk.local>
References: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428-ad5686-fixes-v3-0-9cff7bd67a15@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 28, 2026 at 06:02:15PM +0100, Rodrigo Alencar via B4 Relay wrote:
> This is the first series of three on updating the AD5686 driver.
> 
> A bigger patch series was sent before ("Extend device support for AD5686 driver"),
> but this is not exactly a v2:
> 
> https://lore.kernel.org/r/20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com
> 
> This one adds a number of cleanups and fixes, like:
> - Refactor include headers (IWYU);
> - Remove redundant register definition;
> - Drop enum chip id in favor of per-device chip_info structs;
> - Fix internal voltage reference control for single-channel devices;
> - Acquire lock when doing power down control;
> - Fix powerdown control for dual-channel devices;

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


