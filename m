Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CE43806A6;
	Tue, 24 Feb 2026 14:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944461; cv=none; b=fPDcT60n6wxaYBJqz1PTh+38cDGhndoRarmnc1b+3ewQQ5zlW284kZUWxEVA86zVM59tg97Ia794tAlBkBapAIbMXk219AAXU49Mml/XhkPDFoGa+ihHft/BDNRw5IbQgtg9s4hwFBFEAn2GxAwuaqAkl90fvh6/ZU1nzwmWtCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944461; c=relaxed/simple;
	bh=HNwIPreUxtPY9hJGBPCv+k4DTs5pbdiRTxC/peYEQuY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGzgUWieeeCSaoD/u+X4hy3gcfssvXh+J65t67BkwWlj648nGgPVSQyCIVhIzOSKPb5uY3p6UwGfHcQ/WjN8+01CsGWkPHbTm8rekqnLIOv6iRdz4UnEh5s4rggCfOrLHKEVJZuTcafw6HD8XcQAY0WfE3pgAXGBv7K3xM8HGF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LwGRyn7a; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LwGRyn7a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771944460; x=1803480460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HNwIPreUxtPY9hJGBPCv+k4DTs5pbdiRTxC/peYEQuY=;
  b=LwGRyn7aHmVT+2gPKcpLwMAzDDFtgLn0w8KklWzX6CW9olFEAsl73VuP
   12hDJeMQZVbqNxwtCPvApIohWkhjU1IfJbG+SvB85F6xev8PKxyTGG0h5
   WzAVtbGHkuXZ7oVEDN8xDdu5Cl89MQ/99z4ApIy8UpOJT3XxSq5qTYAn8
   TT2PiNLIkJWij/uXSwjL4x3KE1PE/kfXl7haFk5P41ahNzq23roKxqOga
   pfiF6GPEMnZSG9TlyFwWY0DXepcRCRcJP+6nZVtLWR3+q20vS7ZkGxg8S
   jEc+7liVgJmbvSjdSKfwk+dGmGquiBVFu8MFFuCcObYM0Lks69dhZSuy+
   w==;
X-CSE-ConnectionGUID: bGKig5ZeQvOWK6WuKFHlUw==
X-CSE-MsgGUID: hBg+wHlaSaSiMySJrehbiw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="72661759"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="72661759"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:47:40 -0800
X-CSE-ConnectionGUID: WSPsJHVARre17Ipcu4eZTw==
X-CSE-MsgGUID: jcNlNRtkSHe1/3KJkN9umg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="215160658"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.146])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:47:36 -0800
Date: Tue, 24 Feb 2026 16:47:34 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>
Cc: Antoniu.Miclaus@analog.com, Nuno.Sa@analog.com, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ade9000: fix wrong return type in streaming
 push
Message-ID: <aZ26BgzCKcssGPOZ@smile.fi.intel.com>
References: <20260224125921.70946-2-giorgitchankvetadze1997@gmail.com>
 <20260224132354.76672-2-giorgitchankvetadze1997@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224132354.76672-2-giorgitchankvetadze1997@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Feb 24, 2026 at 05:23:55PM +0400, Giorgi Tchankvetadze wrote:
> The else branch of ade9000_iio_push_streaming() incorrectly returns
> IRQ_HANDLED on regmap_write failure. This function returns int (0 on
> success, negative errno on failure), so IRQ_HANDLED (1) would be
> misinterpreted as a non-error by callers.
> 
> Return ret instead, consistent with every other error path in the
> function.

Again, do NOT start a _new_ version in the _previous_ version email thread.

-- 
With Best Regards,
Andy Shevchenko


