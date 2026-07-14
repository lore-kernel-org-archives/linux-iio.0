Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48ED832B121;
	Tue, 14 Jul 2026 09:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020086; cv=none; b=Sh4azHuiCiN67c2OkeqnBjkblnhXUdJBO26gQ1PgP9YpmwHCcGtVpGb3GWBHYQGWa7lr2ICBGVv4sp8BZ1awu60p+Rt+ZKrcfV9QkvHa+tcSdP1DQ8LgjXbxGwMGpZXH/tqpblEfqS6FPa29DMgk8ui8JQJQKka4dbagSX3iX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020086; c=relaxed/simple;
	bh=IUso+Mzyx145mh9MGQHIdzUB9jky338Jq95gmO43E7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gP1RDb1SFFKhnxqFl+HjDLJRGeZNdAIWvTlXe1Kd99ntzgozOtVpKUSpE7qWkeUQBhWj8a3PYXKXr4AY9zhonHNPh6VR4mCzpYV16u57HAVqZQYkKsF7Gw0DJcoFj8/D00zE1TslhqX4Fl89oFpT3/SM1ebP7GnDYGAoFSdBMpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YESodvwP; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YESodvwP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784020085; x=1815556085;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IUso+Mzyx145mh9MGQHIdzUB9jky338Jq95gmO43E7E=;
  b=YESodvwPTlgAvUSyblD2yrDEBqvoU/KBckqIm+q8f+Ds3rPQ/C6alsm9
   DDqn32nM0+oddPjm5RPWadNmt20t13Gml5Yiuvh9I18wiOnOfQGuDU85k
   N0D8eudkqEGTdtYkZjOyGULnfupBHqxmSP7378k69Q7iWJfnd1PmtQIyx
   MNmJq0E39g7nPVf0fzge10V7skILEUsOD7hSKqlVkhjLJ81XOGZVEvqnV
   i2Hd0f1guV8OhtC4Yv4wVPYjjhXn1ABMCXWuOYfeM/eT4s/T164NgYTcq
   vlkNa/JzBEw7JvM2VwM3zbfggScyGQ7LNRjH18TOERWtQv9Weo5J8B8ab
   Q==;
X-CSE-ConnectionGUID: 9fHKKdjfRkCfJiFARzhYDw==
X-CSE-MsgGUID: x5oWJT7iSLyvan36QDQ28A==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95238758"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="95238758"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:08:04 -0700
X-CSE-ConnectionGUID: R2XPs1HOR7izm3F3+HyUdQ==
X-CSE-MsgGUID: qfRCoEQeSEOl5/SQjICRtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; 
   d="scan'208";a="252421225"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2026 02:08:00 -0700
Date: Tue, 14 Jul 2026 12:07:58 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Linkai Gong <gonglinkai@kylinos.cn>
Cc: nuno.sa@analog.com, jic23@kernel.org, olivier.moysan@foss.st.com,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: backend: fix typos in kernel-doc for
 iio_backend_interface_data_align()
Message-ID: <alX8brPnXIueYPOP@ashevche-desk.local>
References: <20260714085019.3109889-1-gonglinkai@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714085019.3109889-1-gonglinkai@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 14, 2026 at 04:50:19PM +0800, Linkai Gong wrote:
> Fix two spelling mistakes in the kernel-doc comment:
> "initates"->"initiates" and "proccess"->"process".

Is it the only a single spelling mistake in the whole IIO core?
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


