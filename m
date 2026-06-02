Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5D33D565D
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396299; cv=none; b=Od8IUNzqbPPtWvj/9U6UuXVyrFLau5BFS6ulFG2U3SIj5uoBoMkyM8Zi0F4WGQ6G6GyWev2yrd5yR9kK/iFZ2V11k0PBNTPiMBmEDJpyZJCgEAWMidJsWf3pGYziaJcoR21I/nIuT2VHV6e4sD2RAYUQlTqt1tl7aYPf12px+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396299; c=relaxed/simple;
	bh=o0Nni+yp1Gx1jtyHijBx0ul2iFhVLO/rQkcI7P29gmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Noqo14jiVVx500xRDPf6qyaQrSN3rud5L9RC677eY4PhT2akC1oLK/WYkQbALyQi+gn/2KBjLzM1fRHIh8BdZPMjXek7RzWpyoHJT6PY+mSx1ucCSqwzBdAIb+oT4R66VU9W0Wl/I7T9nNWxsGGiwtizuUus+T9bOIfhO+xivbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlLSGV0J; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlLSGV0J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780396297; x=1811932297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=o0Nni+yp1Gx1jtyHijBx0ul2iFhVLO/rQkcI7P29gmo=;
  b=FlLSGV0JSZRniGIeexSs/Xq65/RzUTu/pKAMpI7mxCpiRTm0tXjQd/N9
   v90xHn/WfEIf6+N8ZDI/L4PSoaXBe2mmO8UjTfilpOfuZgBwHkSqtFZpR
   mAQVWx3+Si1R5jAEcRCYrdYNQ+Oh07LUffxU5GZU5gkl7AH5ZiHtHZ8vn
   wdHGBfpZuOsML5xJ9IfPJ8Y/aGBOmStjsMuUk2K8+wvY7B7MqYHml0O1N
   ZqHl85uysRpoh2fi7RhileTuCKNI9WuVbeihs7VykyqWndNUSackwOnGl
   +QcU8j5Hu3NAPHxzoTtr4jpLlFTXxEiPHIOr7lvs/EISFHBNMQx31eqMh
   Q==;
X-CSE-ConnectionGUID: /lqpyjIxQIW4o3KC3bitVw==
X-CSE-MsgGUID: ZyjTaWupT0mFavonnj672A==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="84801050"
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="84801050"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:31:37 -0700
X-CSE-ConnectionGUID: 5z1wrGUPQEqaEEEnvquwzA==
X-CSE-MsgGUID: L9WA0xICTVKfAYbp2gmjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,183,1774335600"; 
   d="scan'208";a="281979657"
Received: from mkosciow-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.229])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2026 03:31:34 -0700
Date: Tue, 2 Jun 2026 13:31:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	SeungJu Cheon <suunj1331@gmail.com>, linux-iio@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	apokusinski01@gmail.com, me@brighamcampbell.com,
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH 4/4] iio: pressure: mpl3115: add hardware FIFO support
Message-ID: <ah6xA19t8RlijavX@ashevche-desk.local>
References: <20260530113938.171540-1-suunj1331@gmail.com>
 <20260530113938.171540-5-suunj1331@gmail.com>
 <CAHp75VcN7B5BdKZGBiw5cbhYesGsO_tStcN3cKgggiHiuSnJ7w@mail.gmail.com>
 <20260530164306.70c9ac71@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260530164306.70c9ac71@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, May 30, 2026 at 04:43:06PM +0100, Jonathan Cameron wrote:
> On Sat, 30 May 2026 15:32:23 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Sat, May 30, 2026 at 1:40 PM SeungJu Cheon <suunj1331@gmail.com> wrote:

...

> > > +       u8 fifo_buf[MPL3115_FIFO_SIZE * MPL3115_FIFO_SAMPLE_SIZE]
> > > +               __aligned(IIO_DMA_MINALIGN);  
> > 
> > We have a macro for this,
> Which one?  We have the buffer + timestamp ones for IIO but that' not
> relevant here.

Ah, I stand corrected!

-- 
With Best Regards,
Andy Shevchenko


