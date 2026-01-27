Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E5E345CA0;
	Tue, 27 Jan 2026 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769525954; cv=none; b=H3V5ilvzerea2ez7S+csPaartRX1+pDkLhiajgiJoK8YL6gRnJtaNBLNkEa15oK+gTpvr24BYy6iLbC5ptimgRNjo/5IobLywTh8yzQZEatqa4NSn8WggIh0ORAnoC+10ZPta+D5VSbmZHxm3pTxb+SOuYtWsuMUK/twJwn7UA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769525954; c=relaxed/simple;
	bh=12ylRXjtbWKFG+i2puZLfoAfxtG+BcQMhnW4WttkvDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mMHRi2uahSowVjt9W9GFLW4TCCiCYVEATyBU2jLbVli9gaGMrrmGOnX9FabEwhOUd2Ly4N3SgsvfAc6+xlbDHXyQjhfB16AV237yhpXvPhKnmYJFDaA3Ft5tqkhEfBEHORGeHdSWjODWIcEN4+GGQRBXXeXxZwj/SeV0hF9880o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UdsfZ4sp; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UdsfZ4sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769525954; x=1801061954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=12ylRXjtbWKFG+i2puZLfoAfxtG+BcQMhnW4WttkvDQ=;
  b=UdsfZ4spn46k04dOB7fGDoCxxLVJHXftOHsP+sObLnKiU8Mz/ZpzVf4q
   bWXfMQb2l0kawGpj1Ht/VbufG4Zkk6oGlIi1HX6c2iLX4uroiegJKB25C
   qZyi7YNoN5tLHsPxBSVf/LlZyok0i2jfZyqHZftUEEKkQcYQiJZoHPkLG
   y/EttgkChB4GIHyz2sjnd+mUWdcRObSPkWLJxrtW+C24VO66Es33ZxMW2
   dg5QR/9p4o3aIWJtJoOq47OmOKe72riCnrQnOq1xHBFtcDhLi9dfQYrOO
   xUNpxe5UKyMez4v1GrlCUInYQPZjDeFjMZ/PcGDXgu0/64uRGpRwyBieR
   Q==;
X-CSE-ConnectionGUID: LlhLgXcPR5ekVxJaBYkRQA==
X-CSE-MsgGUID: QSvozk0cR9eGpwOfyLMOCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11684"; a="70763350"
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="70763350"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:59:13 -0800
X-CSE-ConnectionGUID: l+xGni1ITmKyMGxZtDspUQ==
X-CSE-MsgGUID: /oJ+/BtWRPihS/u1IxPOvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,257,1763452800"; 
   d="scan'208";a="208242629"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.248])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2026 06:59:10 -0800
Date: Tue, 27 Jan 2026 16:59:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 3/6] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aXjSvHyAify83fra@smile.fi.intel.com>
References: <20260127-b4-rfd77402_v5-v7-0-3e7f2d452da2@gmail.com>
 <20260127-b4-rfd77402_v5-v7-3-3e7f2d452da2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127-b4-rfd77402_v5-v7-3-3e7f2d452da2@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 27, 2026 at 01:02:17AM +0530, Shrikant Raskar via B4 Relay wrote:

> Replace the manually written polling loop with read_poll_timeout(),
> the kernel's standard helper for waiting on hardware status.This
> makes the code easier to read.
> 
> Move the polling logic into a dedicated helper function, as it will
> be reused by future updates.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


