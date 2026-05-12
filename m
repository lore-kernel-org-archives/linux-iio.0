Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BBB368D5B;
	Tue, 12 May 2026 07:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571150; cv=none; b=UwEQTRwaLJZ5G33X7RnH2LRwwSoE9VLD+udYBfUnadHJm4MlSxh6T3ctuKtrZg8fQML+hxDhkt3kvZ0FQ+R7/nnyMqxKYAAr9Y001CLZ6bCQa7igQx9Oy6VC7GvJ3V/1DQ/veuXmwtnM9ng5H9jxyPTdwHGLMIeXAYWbkVrjLwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571150; c=relaxed/simple;
	bh=8M8AnlipjiO5MO6UxXxrWmbjx4V8D3ea3dtKY+A59Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZM8dYekV+pL0geL7/v7aHbeO/BMA7DLT8UeLRHuVOQiDU5m0gVGvxcwxrZmREqYisQMFWj+WBADKxZZ9sk4fCiP38ZSM1kLX69kkHI5jWgWjtCz2k/SBb521QO2ob1XTYbdMbAjyG4U+ABxuKdDGaORQz1dYL88mkG8+/laOpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XaITvfny; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XaITvfny"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778571149; x=1810107149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8M8AnlipjiO5MO6UxXxrWmbjx4V8D3ea3dtKY+A59Jo=;
  b=XaITvfnyvKQ31HG/jIAcslEaiounRnOuPmh0IQwyUHiBzHScrpYy7eP0
   glWgh3W2x5oQDV970XdE9NA3k4vx9NxR7jLYLS8oONuewHqTYS5T8nsuX
   Fq5Fp3t68jSNRpx9EOGH8CZ5kLA9oWXLWMsnkc0BTQ6Hcz2ANCeSEH9P3
   t5uZ4qJ3Rfxl0ET5/IM5oLuD+1EylxFe+ppVTF/ezJuQMll5LaawtYzOJ
   edObYI1Oeo+tpE1jMemWZ6+E6iRQ6XG4oPdIcfpS+80gLYLLVKw2h6phS
   YtTLwM/s4T637juFSNQlXeRLMV8Dauts4BraCpejw8dX3z6pEK3p9GQRh
   w==;
X-CSE-ConnectionGUID: QQFqyqr3SQOl5x4Nm4ZX0Q==
X-CSE-MsgGUID: v2D0wsdfS06HNMziCvDmsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11783"; a="90572814"
X-IronPort-AV: E=Sophos;i="6.23,230,1770624000"; 
   d="scan'208";a="90572814"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:32:28 -0700
X-CSE-ConnectionGUID: J7pqNgueQtyGzz2Cqx15Ng==
X-CSE-MsgGUID: 6hlOLBkgRyCP+OrJnU05uA==
X-ExtLoop1: 1
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.112])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2026 00:32:26 -0700
Date: Tue, 12 May 2026 10:32:23 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Stepan Ionichev <sozdayvek@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, puranjay@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: accel: adxl355: replace usleep_range() with
 fsleep()
Message-ID: <agLXhxaVkqj-UeM0@ashevche-desk.local>
References: <20260510113853.50019-1-sozdayvek@gmail.com>
 <agGE7F5zm2pN_dBk@ashevche-desk.local>
 <20260511171331.77f3ef39@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260511171331.77f3ef39@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 11, 2026 at 05:13:31PM +0100, Jonathan Cameron wrote:
> On Mon, 11 May 2026 10:27:40 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Sun, May 10, 2026 at 04:38:52PM +0500, Stepan Ionichev wrote:

...

> > > No functional change.  
> > 
> > Strictly speaking the upper limit is not set as 10 milliseconds now,
> > but defined by the internals of fsleep(), usually +25%.
> 
> I'm not following.  There doesn't seem to be a statement of anything
> about the upper limit that is used - just one on it not being specified
> for the part.

I meant that switching from usleep_range() with explicit high limit is
different to implicit fsleep(). And that's a (subtle) functional change.
Hence "No functional change" is not fully true. Hope now it's clearer.

-- 
With Best Regards,
Andy Shevchenko


