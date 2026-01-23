Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66528345CA3;
	Fri, 23 Jan 2026 08:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769155308; cv=none; b=oKEjVJFmYCJGQIqm+ObGovwGSy/Zs7jgJgtKtxYeaFfpaU3QM6au/+ujJbElfmwsZdDru+bNkBgNrVvcDOIwG+HXnKPN1gxEddb0jt7KRn/ZCgr06KmZWKnahy/eDgsodhEbpOJ+EM9y6LHOOHti8XozGsTDZAgHYK7w+bAgaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769155308; c=relaxed/simple;
	bh=lWbKcI45So6qHwexFpABQSsa++sWJSBK3pzhuSxJ3qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YmKSIxIdRWU1rQRVQrZkqNyEnRhLnV5NZ3Pc6h5R6FtsEi61S1dPKCjG6JZchxISuUsQ4GgQo3IR1/pSpxWwxS313ZiTg+6ekWciT7APXkK0HxNOG5ANTlhVjHD9R5PilsFfhUFHumnvvEnLOjgrAv8YM3KTg/WlU1derNV89s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VWwGgKzy; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VWwGgKzy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769155307; x=1800691307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lWbKcI45So6qHwexFpABQSsa++sWJSBK3pzhuSxJ3qg=;
  b=VWwGgKzyv1kSiAGJj6W51hShzallljLzv9Nu3dB1zNjPhG7Qo695RTU6
   xxL9j0xeHv7rWD7CDetzSIBUEehs1kPgBCU0PjVHCNvxj3sI0vqjrfAVs
   oLt7PHlM+O5+2szeA48xjD34T85UWZgBn0tD72kpdyIBe7vJy8KJUVYtC
   AWWokxRKFCc7j5BH8+Z806sR7S7PUG8jKWEG4KiW6YeupEsNS3C9J4aK9
   K22ee1dkrCvhtNjgo9z+AyxnUtzt5aBi6BWKUaTAYpXbGmLR9ut8r2tvy
   s0Wz7j/lkb0F7MVKF7PY9jZGPVfaAcR2k3+T2mOHB33wwlSatRjgTGiB5
   w==;
X-CSE-ConnectionGUID: MVIoHJtjR0WpyztQFv+3Zw==
X-CSE-MsgGUID: uV8Phok4RSWRy2ghKBmfiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11679"; a="93073845"
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="93073845"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:01:47 -0800
X-CSE-ConnectionGUID: gIrY2jd+Qhyn338J2dLgsw==
X-CSE-MsgGUID: CyE2eFcfRtiSGhxy3D0AjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,248,1763452800"; 
   d="scan'208";a="207224658"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.112])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2026 00:01:43 -0800
Date: Fri, 23 Jan 2026 10:01:41 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Kurt Borja <kuurtb@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Benson Leung <bleung@chromium.org>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Shrikant Raskar <raskar.shree97@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v5 2/7] iio: core: Refactor iio_device_claim_direct()
 implementation
Message-ID: <aXMq5bBkj8It6f5z@smile.fi.intel.com>
References: <20260120-lock-impr-v5-0-d4d22347041f@gmail.com>
 <20260120-lock-impr-v5-2-d4d22347041f@gmail.com>
 <20260122190401.510234c4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260122190401.510234c4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 22, 2026 at 07:04:01PM +0000, Jonathan Cameron wrote:
> On Tue, 20 Jan 2026 01:20:42 -0500
> Kurt Borja <kuurtb@gmail.com> wrote:

...

> So sparse does change what it moans about with this one in precisely one instance
> There are 9 false positives with Al Viro's updated sparse - I haven't checked the
> original one recently.

FWIW, I also switched to use Al's branch of sparse and recommended LKP to use
that as well.

-- 
With Best Regards,
Andy Shevchenko


