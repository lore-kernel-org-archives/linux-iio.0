Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FCD36828B;
	Mon,  8 Jun 2026 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780918791; cv=none; b=H4P+1Qtt8fzalZmOoIK8lkHgLuc6Q2on0N52odqwJluQVfRFiyFaB87JjW6rtIuodRITZODLCk1QH+/2GMxfzcILRznFLlRCHg17MayTWku6Uze+bun/GhMMXKTdcKwicGmiWsSR9fFluMfr1zYT3NxcWQB6h7IoTgxF3jDjrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780918791; c=relaxed/simple;
	bh=/ewBj+Q1LgXvE2iuTXxs+3Je6rg0UxzarHfhU82Ek+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KVHG2ps+vF0f2YpxAxQdkChrSV6MUZ2SFhjpZt513wKIBZB12AD9c2Z9f62uvPARaWRtzpJd+/vBFLiWNuycP4DbNEftdZMKL5BcLSNGWfJfBzekM+vx/oZ9xxciiEyVmLu6Wqe9nJPNmWn8OIPbfNeLM7nlzRygyI/gJJCV00o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TIyYFCOq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TIyYFCOq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780918789; x=1812454789;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/ewBj+Q1LgXvE2iuTXxs+3Je6rg0UxzarHfhU82Ek+0=;
  b=TIyYFCOqaxXVFtgnnsChIAf/PjIN6ok1ml9LPvQauA3rbqVWZzfbS25B
   ofExU83SFNNdtHzjo1gqf33GioT9YMTkxe24zjC/G5/EiF0SuyalK1EHf
   Ilpot7QmNb/6MMVL86JGkXrvkr5Ka1sgK8t3yldAGW49VoeiFWo5zvxel
   3zTUIq0owzetoDtpnUQ21XMnrEgk/tdKFHeClsDfPjlFdO9z1ELle+HkQ
   GynixMXbGYrCxfAygvQvmOZ3v4N2DqsHBUPSfYT6X0v4FRk92fPzXOIVD
   ebeCrcjHDJTx9Dr8Exxfs53FFThPXqjkseYGFNPAEVZAD5U72J86l00fd
   g==;
X-CSE-ConnectionGUID: hWwyA/8qRAOcOuBwKavdaw==
X-CSE-MsgGUID: 8IACE6i8Teu3mJweSat86A==
X-IronPort-AV: E=McAfee;i="6800,10657,11810"; a="99062211"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="99062211"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:39:48 -0700
X-CSE-ConnectionGUID: G0DRiRB9Qjq2jOcmdAojLQ==
X-CSE-MsgGUID: /IL3uq1lR9i4dmoW5hdcgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="239184172"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.110])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 04:39:46 -0700
Date: Mon, 8 Jun 2026 14:39:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Siratul Islam <email@sirat.me>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: proximity: cleanup fixes for vl53l1x-i2c
Message-ID: <aiaqAEMj4mX9un--@ashevche-desk.local>
References: <20260608033218.26514-1-email@sirat.me>
 <20260608033218.26514-2-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608033218.26514-2-email@sirat.me>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 09:32:06AM +0600, Siratul Islam wrote:
> - Sort register defines list
> - Extract vl53l1x_wait_data_ready() polling logic
> - Logically split regmap_read_poll_timeout()

You may want to rephrase the commit message as in the current form it feels
like it has to be split to a few patches. In practice, it's basically one with
small amendments in the code that may or may not be split depending on the
Jonathan's preferences.

Also, you don't need a cover letter for a single patch. The cover letter makes
sense for the series and rarely for a single patch.

-- 
With Best Regards,
Andy Shevchenko


