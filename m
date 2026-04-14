Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F693C873B;
	Tue, 14 Apr 2026 09:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776160719; cv=none; b=JFds3b9ZbXFvnCMxQpdyKFT5y7yNRVazM2O5qyxq+F8++BZJ1EoCG34SK+jyhdAHCKkau8ZDwg0HZoYvNWcEUNi/TWXWtF53DQKUb8logjpemWImPou78ioOokZ0/MGHMiaU3WeTTGxwYyQVTxFvrSBZKxcGGswTBxskfy85Rzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776160719; c=relaxed/simple;
	bh=1hlA721MfokjRkyG5KY0seHM22gZqQM5oNsSnbvVu74=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2R+HF1v0JcGTHZ/l7Fl09aOFeuxgNKTSudYyRO2LKBcjO9bEnF79Ud+SYKBjlh2Fv3PGXYmmlWQFhHLwA+Wgyc6xWN+SQe9uW8z0TSA+ej2fSWvK4l9GaF0vUWcEniZtthT5DXGVILfQdPalEbFjlwlyaS7Jk7b6Hgv5bbj/sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfTUM6o7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfTUM6o7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776160717; x=1807696717;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1hlA721MfokjRkyG5KY0seHM22gZqQM5oNsSnbvVu74=;
  b=CfTUM6o7euiQXh+bXnNVQC6I0Ppb1fEXwWci9FP4r9fd2/p+/OgZQZsX
   z+CDAw5Xrs54VEsSVRyFhPomkcfIXVxs/tHh9dzglyhWXmpDUgcNYGfKG
   05f1+3rYM52VqnZ5fpxpQVnacaZagIPi2Xj+tuOlMBM0xpqkdylj93lUJ
   7/RTZXMw5WgfexVmKOEcSAi2IfF8deJASbrqTofSu8pN/GyDh9Oai2q4L
   fiFGsrwxkwLMBsJ4UvwpPbhy+kfYF7aUcsVhy7/ONZiBCpRPA/REJvLR/
   INxjXEkM1CPSySE6pg2661k495usegD4Gk3qjh5wpqgTMznLDkbpaLoVX
   A==;
X-CSE-ConnectionGUID: 0MYHwW53S2mZoZojiaLW/Q==
X-CSE-MsgGUID: rkdARCVHQ42XphAF1oAjDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11758"; a="76994021"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="76994021"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:58:37 -0700
X-CSE-ConnectionGUID: M8vvljpGTbGQCh9rYLuJGw==
X-CSE-MsgGUID: cdQ8FNbSQ6+tFLv9y9zWXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="234447981"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.106])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2026 02:58:33 -0700
Date: Tue, 14 Apr 2026 12:58:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
Cc: Salih Erim <salih.erim@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: xilinx-ams: fix out-of-bounds channel
 lookup in event handling
Message-ID: <ad4Px0Aghm2gHzRV@ashevche-desk.local>
References: <20260414093018.7153-1-guilherme.bozi@usp.br>
 <20260414093018.7153-2-guilherme.bozi@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260414093018.7153-2-guilherme.bozi@usp.br>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Apr 14, 2026 at 06:29:28AM -0300, Guilherme Ivo Bozi wrote:
> ams_event_to_channel() may return a pointer past the end of
> dev->channels when no matching scan_index is found. This can lead
> to invalid memory access in ams_handle_event().
> 
> Add a bounds check in ams_event_to_channel() and return NULL when
> no channel is found. Also guard the caller to safely handle this
> case.

> Fixes: <d5c70627a79455154f5f636096abe6fe57510605>

Incorrect format of the Fixes tag. Please, consult with Submitting Patches
documentation on that matter.

-- 
With Best Regards,
Andy Shevchenko


