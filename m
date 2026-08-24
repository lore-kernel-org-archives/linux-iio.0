Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352E7395D86;
	Mon, 24 Aug 2026 09:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565353; cv=none; b=a1Av+hdNrfdeq5YvDerpzXsdZ3eysO7A6dSWhOVbetosKEBqZfdaIH3sPwayh/390mPMq5MVAcPu/vDLTzMdUrp0xugppv11JmnRgyH4OkJ4ZJXQxzyOnKXv3RG8W+FQQndlFSQQ5ZzP74RQsFz5w6//z6s0Z9XLYCvtVii3ee0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565353; c=relaxed/simple;
	bh=wG2nT6tj9Wt8frouo/5eEC/yOH1Uy2RMsUeVkRctNgc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=juMdQlUyr+5DxkjIxDcwvBDssgW1fYa+DGHpNMNkAXh6rDb73s0FyjpgwLbL60IVwAt5BGtW2Oz1iX9JW5rC8NatAJ0fT8TcGygPgOAvfhQh7ibkH2kh7qmnTyhX/Z1BeTvn54dhvQSZAyIJgGStx0CyJp1oVVp4H0248bp4w1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SDMYBB/z; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SDMYBB/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787565353; x=1819101353;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wG2nT6tj9Wt8frouo/5eEC/yOH1Uy2RMsUeVkRctNgc=;
  b=SDMYBB/zQziMnhAClxTedglnKfVQ6X9uR7QDWvK+RvcylpKPLle/OLiD
   ww/E6/v8bGAnv9T0iegnKaWa4w89p8FVOsJfcP7XGb6mqDUjcdrN+c/fd
   7LBIJAbHvEarJnC96knxDQgnd0fkcQMJrdwMAwB1BEVkPi25fBacowhlZ
   GQ+SxPGIvm4WBChvM1JPFg4LIs3OfcyEYUSeTfqkNvphwbW/a8SI8t8m+
   quz0bF1NsygmGeiwikGiWnOx2sUTo0HF3l72rjlPIhL2xLzpry+cUzTuL
   KA/BURbEHfYw//T94exiHHBYhOsWUZYN/VacMgG+0JofCW5UZ6l2NSP5Y
   w==;
X-CSE-ConnectionGUID: cj+z9xjOTTCInXKohZ+3Dg==
X-CSE-MsgGUID: 4TDWkRkDRbicJBCAwyU3qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11884"; a="88027666"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88027666"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:55:52 -0700
X-CSE-ConnectionGUID: e26S82B3TWGj0qLBHsDEsw==
X-CSE-MsgGUID: yLoTTn0dQAO0Nd6nNfuyfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="272168337"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 02:55:49 -0700
Date: Mon, 24 Aug 2026 12:55:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Rishab Madhugiri <rishab.madhugiri@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
Message-ID: <aowVI_n7s0VAmN3D@ashevche-desk.local>
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> Replace deprecated use of BUG() in default switch cases of
> iio_get_time_ns() and current_timestamp_clock_show() with
> WARN_ONCE() and return correct fallback or error codes.

Why?!

-- 
With Best Regards,
Andy Shevchenko


