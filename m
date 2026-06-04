Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE521A6831;
	Thu,  4 Jun 2026 06:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555219; cv=none; b=ZPWpCTCHllZap6zOxaFUlHSPKc82eXdTFRjX1ryFIswJfxS+nZCnttWpKF7aGgC+y7WARymHXQZEIzb+5rR5pQX8Ml/ivxq4ioJzsHmDL8s2WSVvrP0SUOSCcWYXBU6iNhTinPzQtxfXj5vIqR0q0gnPrjXfYW8XxvkauhqYI2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555219; c=relaxed/simple;
	bh=HWOeoupgdXvKfFrNtPQpOlzV9341Ke+N7Y0F6EwLkMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HyOD2hVWgatOSrhAwNOLuFeIyxJoGrFCYfmBqN5M5akkWrOY+PknNU3+D0FSIcoQqRovh8Kxvqv7ly7CozImjJ0dZxneMcCDw9TdNm5Su9kCNrd0bqzCq/aPfMQMy/MEJc174mtC8zYHofM9vUhyirR6v2qpvrEpt0D7+RvONKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dc3OA1mD; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dc3OA1mD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780555218; x=1812091218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HWOeoupgdXvKfFrNtPQpOlzV9341Ke+N7Y0F6EwLkMg=;
  b=dc3OA1mDoMKVdMntbHiov3WYWKjnqOIOhk8EREdr8lCMmPyom2eHN9Aw
   gCBA88JtJzXAypRbLBhInxBTkzUzakh7BcyZQ6+ZPbpTQoeRoeSGjsCSX
   j9ikI1g4nUsn+oxpfcGwzw3FZKqr7LjYlkPai/Ig1wkRYN2Rqe3bl2CG7
   HbWY1QHhHbzgKkMm190mgpR07aBpmj+XD8/fR00li+mHsHNeR3MPvzkqV
   bw2lJt9ck0bzMi1d5mwtZgk5Qi92l2Nw/wWdG2bp0azMR7aJ03s5aDo4G
   AW21PiEDbSUaQ1jlN8tYlMyHvyGE9xjCnTQB9dRZ79MukiT2gkbk9Z9s9
   w==;
X-CSE-ConnectionGUID: rsFVrmbjS9Cm5tm/NAsDTA==
X-CSE-MsgGUID: 39wYTbtHQT2itXpFSQ0lHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="91949159"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="91949159"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:40:17 -0700
X-CSE-ConnectionGUID: xdi6yHesS4yxb7jrfNzicg==
X-CSE-MsgGUID: OH6KIRaaRaaEQ1xgPWzCPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="241956043"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 23:40:15 -0700
Date: Thu, 4 Jun 2026 09:40:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Maxwell Doose <m32285159@gmail.com>
Subject: Re: [PATCH v5 4/8] iio: light: opt3001: localize for loop iterator
Message-ID: <aiEdzLQjaHvga5RY@ashevche-desk.local>
References: <20260603-opt3001-cleanup-v5-0-3ef7b926d555@gmail.com>
 <20260603-opt3001-cleanup-v5-4-3ef7b926d555@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603-opt3001-cleanup-v5-4-3ef7b926d555@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 03, 2026 at 07:12:55PM +0200, Joshua Crofts wrote:
> Localize loop iterator to tighten scope and improve code style
> per checkpatch.pl report.
> 
> No functional change.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


