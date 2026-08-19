Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCC63D0C07;
	Wed, 19 Aug 2026 07:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787123932; cv=none; b=n3GheuZlaU73uGMSjvJxCEZTve8gEKG54iox0c96r4ZE7gIyiY3Kc0MREtyINn5gQOQ+RlALUxLfWu1EA35ZDC4qJq4UxHgDYMGU97XeaIJWmNvHBrPEBTCmsDxgDd7Dv1mLvNkcMcaBOidfNKet0XOt3nhS36KdTAE0vHibUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787123932; c=relaxed/simple;
	bh=+SldjJXxIn/tVCxPBUkMPJ5Rt4uUW9yqVy0ODOkjykY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TRj/lK16/uvT+zYk5gUpr4+SIdnYnnXCaKpTMr1GTSxQfxRoW4F/HoSK1lZcXTYwXDCBOt8TwpjC2RPzEBOAn1e/0hvh5LY+FLPImGag/b2MxuwDtiRXRx9QdL+0R8Mr5Y3NO0aOj3nimEt3vFvtJF8BsYN5hEtmJN8uO813Sfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IsNhoklb; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IsNhoklb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787123930; x=1818659930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+SldjJXxIn/tVCxPBUkMPJ5Rt4uUW9yqVy0ODOkjykY=;
  b=IsNhoklbdJaDaT7Kr+AYZ2s5BVTD3ytRRoYOgllyLIJmxLNQnIKuffX3
   jJ835pewMSsif+Xv24ywP4E0PNwJQJoJHpt/j5Y0H8f21+4q4H8CvbG0R
   N5O0FgBg6Eok7ek3ws/rwHYECDG4gdyjwD3bnNwxycLMp3AhHI/YPYh9k
   Lb+47vvYGMeKhBM+Tr65l6XLS3AdMZnYcutRdAZFcBxl2OkYpw3Yt81X5
   aJYvicr3Ocx432UJ9p+YJz0f+ql/zBxvY/r43xEbup9qF0eNmQv0h+MHx
   vy5bOyDnwxmjo905YZHNtbv6+pV2Y51KSNwvO/v0eBW+VvSKango0EOjF
   A==;
X-CSE-ConnectionGUID: r2znhPOuQRiUNWAD9KQTbg==
X-CSE-MsgGUID: uS+uFYfHQLWzlGBaNt/S8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11879"; a="87485159"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87485159"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:18:49 -0700
X-CSE-ConnectionGUID: 7CvtSbWDT5y27WoJ4DUI1Q==
X-CSE-MsgGUID: yN3CNYiMQEKg+uSL1hkFcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="288972734"
Received: from amilburn-desk.amilburn-desk (HELO localhost) ([10.245.244.106])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 00:18:47 -0700
Date: Wed, 19 Aug 2026 10:18:44 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Gabriel Rondon <grondon@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: accel: kionix-kx022a: unify staging buffer
 and convert to iio_push_to_buffers_with_ts()
Message-ID: <aoVY1NpKxKskuUC1@ashevche-desk.local>
References: <20260818215122.52715-1-grondon@gmail.com>
 <20260819010900.7728cff8@jic23-huawei>
 <a23c2959-5c05-4018-9ac8-7c87e563d1c8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a23c2959-5c05-4018-9ac8-7c87e563d1c8@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 19, 2026 at 08:15:40AM +0300, Matti Vaittinen wrote:
> On 19/08/2026 03:09, Jonathan Cameron wrote:
> > On Tue, 18 Aug 2026 22:51:20 +0100
> > Gabriel Rondon <grondon@gmail.com> wrote:
> > 
> > > v1 was a single patch converting the two push sites to
> > > iio_push_to_buffers_with_ts(). Reviewing it, Jonathan pointed out that
> > > the driver carries two separate staging areas holding the same thing
> > > (buffer[8] and the scan struct), and asked to fold the cleanup into this
> > > set.
> > > 
> > > So v2 is a two-patch series: patch 1 drops the redundant buffer and
> > > routes the one-shot read and the triggered handler through scan, and
> > > patch 2 does the deprecated-API conversion, now with a single buffer to
> > > push at both sites.
> > > 
> > > Changes in v2:
> > > - New patch 1: drop buffer[8], use scan for the one-shot read and the
> > >    triggered handler, move IIO_DMA_MINALIGN onto scan (Jonathan)
> > > - Patch 2 now pushes data->scan at both sites instead of data->buffer
> > > 
> > Nice.  All looks good to me, so I'll queue it up.
> > 
> > Applied to the testing branch of iio.git which will be rebased on rc1 once
> > available.
> > 
> > Note that there is plenty of time for additional feedback, tags or indeed
> > me to drop it again if someone spots something I missed.
> 
> Ah, Jonathan was quick and efficient :)
> I'll drop my comments to 'nits' in order to not generate more work for

And I, in the opposite, insist on mine against patch 1 as I consider that that
makes code easier to read and follow.

> Jonathan. Hence, acting on my comments is not required.

-- 
With Best Regards,
Andy Shevchenko


