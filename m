Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793118800;
	b=Rkg+yeyteUVPIEK/a+MqVlA+Qy65rA+mLn0lLAth+tjZNmWaS6mDbfKJC2CTjX41pOO0
	 WE3cwaSslt3bhXwG+/kG/HeQdjxj/zu44p/NRtdrPyX1V2Ce4lJIFitNjoh41deFBxTLq
	 mj7YOBIi0F+k8zRE6GuXHRwLPfhmwvP98aIv98tAp+wwB9b8a+dkgQtEFkxqRRh1SJp8k
	 N9ZjB/YW6m5tt79H+xxms0AyTnTazGhztTnfTlzWa+2j7ElXkgw3U2Vv4QnRokQXgTsHi
	 7lftG+vjFRLb3pLU3dQNvM3/fXLBN4yeg4o9bweZMeTfqaf1tRCh1DSSO5UnF/mLgiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793118800;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:Organization;
	bh=oUH3PfCxcRjKPXYVmYqe+H03WTS0x76fQkCcrSzPc9U=;
	b=yYK3AVHgpJ4RAg4vakLIOV/D6vN/qIq4GshECGVWplGHDkfmlWOyFyeYtsyO1N45YL/D
	 5vUmtZCxEyVZJQaHNac3wbgB38Oq7OP77yFVsiEVVRaH+T2rKMZDewFtftwXZp2HLD4NJ
	 nWk/wPtE/P7yi5u9cSm2ho8zp5v5JRxGgbFmla34LYr3TGm0kCSNcZnNLoZIVm9WJMcCM
	 wgRSq92reKHs3DsTW2sF9LbuHbKQ6ZJdDsJZ9OdqRDS8tEUuyIShpb0l2+c299cwVbhjP
	 8PiPLf7IKOwtsLw/O3OzSC6jyqV96OonRKOyo/AHfnhIkXxl52l9TVqux2vviSbne9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DsX9oDVd;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD622606A31F;
	Tue, 27 Oct 2026 16:33:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD622606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=DsX9oDVd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793118800; x=1824654800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ahSNnKvQxghxBzFnaPlkwiogmqW5ZV/8vLRqpfwB0K8=;
  b=DsX9oDVdYkBsMGxBP6+DrKEYlpMaF3sDVy2f02eDkNTdmUMu8WIxYw2z
   sBdG3nTmgZgkIeZP417+mZyGAGetdm6shSa0VDMdmH7u+AtA77c0AN0oR
   vvVRJNW+mSLMuk8L42lR9z2uTyusWBSEwuolG9GeWvt6Peed+Pb0yVC5p
   V7D/Le6QmN3oDH9Q0AUnJWTlOGqPhSAg0k5KBaqlZ6CM6I85xO8dg7N14
   h6RMAHCgQAuACtvLR9wblknV1eRTA8HkyBnJYjIep4td3yy4GMG+U1pmn
   zutJXALamNrJj5w8usteYUL66eX3AfI5Yk5VZYgnjR0J+JwCWCtJEbErx
   Q==;
X-CSE-ConnectionGUID: 2C613jNSRriZKR5FAN3YHA==
X-CSE-MsgGUID: ZrowVB4/SuqN/zpH07tuOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11948"; a="1931873"
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="1931873"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:33:19 -0700
X-CSE-ConnectionGUID: YSY7vDFxRaaXZJzz1tijCA==
X-CSE-MsgGUID: +2XfVK/VTV2/SIT0C/nwNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,181,1787036400"; 
   d="scan'208";a="4541532"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.196])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2026 09:33:16 -0700
Date: Tue, 27 Oct 2026 18:33:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nithishvelan M <mnithishvelan@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: iio: impedance-analyzer: ad5933: use
 devm_mutex_init()
Message-ID: <auDSSrRLqM5sg7ti@ashevche-desk.local>
References: <20261027160829.1731-1-mnithishvelan@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027160829.1731-1-mnithishvelan@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 27, 2026 at 04:08:29PM +0000, Nithishvelan M wrote:
> Replace mutex_init() with devm_mutex_init() in ad5933_probe() and
> check its return value. The driver already uses devm_* helpers for its
> other resources and has no remove() callback, so this ensures the
> mutex is destroyed automatically on teardown when mutex debugging is
> enabled.
> 
> No functional change intended. Compile-tested only.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


