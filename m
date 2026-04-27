Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79D37B018
	for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 09:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777283454; cv=none; b=HwsoNl54ZTlLcfnhKan0zjtOOogARaxzP4Avq5oeuR4ZHOh3b/JdrfmoKLJB4kxCj6hzLYP84S4VI/NlbJbrnlvVzThv+fCtKC71VptuYMvmqg754+Bymc+be5W1tMUSg0QvdPiH47ZmV5qS6HRWwyLBhCmk9wsF2z/g7sWpXSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777283454; c=relaxed/simple;
	bh=K16jtHwF4yPp9JMkktT1aUmSgbxm+THDb6sgljMPb2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1coQ08sp8CG0Jzxs50Q+XqBjkX74CNbyCv4WoKfRN8BLBmVOKFAgFfeAxQg7Hl0ukU/4BMd/Yw9XS8m5TGrvmYrIAkggelCfItSYDGDamJAasBb7n5V8+yh3cxhrxUBzq0SNGVP3oZofYZVYqnhGtYlWLl4hukCZaM+VnIoFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ciWngVOX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ciWngVOX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777283454; x=1808819454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K16jtHwF4yPp9JMkktT1aUmSgbxm+THDb6sgljMPb2c=;
  b=ciWngVOXrAT8c5QQ8UP+AIhYKUBRplYoBN6UxdOuCPfWe/hNY+n+7Gkt
   uq3uTAepsBoNFQb3vO6wpWktBMSH4ozA/cRSWRl5rYgPF9GuaQ06Ac4+f
   4mLzdUQG0mSkv4fZRp2M7/RfuSyK0+RR63GAckyS9U4ryU8zgFlLPAtvP
   OY+Xav5hoeeyCy2tDQ2BwwXRB8JMgxnADpB3D7K95RshoSfpguWg9LMKM
   llY4YI4Zr5HgHoiZEQ91Dc+gh3r2VZ6WeVBOwbduKSh8D7Z6QDavu0Isk
   WdRX4K180y7UgRuuPX9rt3WWlG1lCg8Evltu4MgaW9R52HvfWdowPuS5K
   w==;
X-CSE-ConnectionGUID: GQucQiUeTeek3AAUVwvf+w==
X-CSE-MsgGUID: 3OC+URGbQxeVWOmRrBm4bQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11768"; a="81775562"
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="81775562"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:50:53 -0700
X-CSE-ConnectionGUID: 5qUJxnBrSHmyDPhP+Wj8bg==
X-CSE-MsgGUID: diT0lo2hQ7OD2PTyqy3B/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,201,1770624000"; 
   d="scan'208";a="237555452"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.244.2])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 02:50:50 -0700
Date: Mon, 27 Apr 2026 12:50:48 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Caio Morais <caiomorais@usp.br>, andy@kernel.org, dlechner@baylibre.com,
	jic23@kernel.org, michal.simek@amd.com, nuno.sa@analog.com,
	linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/3] iio: adc: xilinx-xadc: remove unnecessary includes
 and add missing ones
Message-ID: <ae8xeI8VVUWn6OqQ@ashevche-desk.local>
References: <20260426211834.3318306-1-caiomorais@usp.br>
 <20260426211834.3318306-2-caiomorais@usp.br>
 <CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-zz-2cG7SJr1iKNQ0H81TVMXLQh3omkxJc9YRW673Kqqw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Apr 27, 2026 at 08:42:55AM +0200, Joshua Crofts wrote:
> On Sun, 26 Apr 2026 at 23:20, Caio Morais <caiomorais@usp.br> wrote:
> >
> > Signed-off-by: Caio Morais <caiomorais@usp.br>
> > ---
> 
> You're missing the commit message body. While it's understandable
> what changes you've done in this patch, it's good to expand the idea
> further (what you did, how you did it, why you did it). This goes for all
> of the patches in your series.

Dunno if it's your first review (congrats in that case!), but I fully agree with.
We do not accept patches with the empty commit message bodies.
(*Yes, it used to be okay twenty ears ago, but now.)


-- 
With Best Regards,
Andy Shevchenko


