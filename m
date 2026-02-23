Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7734D4D2;
	Mon, 23 Feb 2026 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771835839; cv=none; b=mfnU9ig4jqlyZ6t1sUtv3nhzI/nfIjOtSrqYwauYVtOFXgeyWqIpGY6mTagwzSQcFHG6uYIZdK321TztICZ6UVq+KElK+nLcLqVevVUGGs/dSmiqUgOip45Oql5HTyT2duAb09EfcVI+BThSBupdOVaorGxD/F4JY360Ezd93IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771835839; c=relaxed/simple;
	bh=ISN3AMJU2NaJnMTZjgi6dG5+oLLR4UyCXFllChnzKtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=To7b9vzpduvw8CBMqzb5qQy/tR0PNPBaU5wJCa7phOvw3+R2462Cvtk92leVz88s6ExI2v+IFhsf28WExSBmdbFpGL+J6pyemKBXmuG+rNmmMUJPYNmUAb3k2uY83DOcfz+woO4BsJq2NzdxQe88bVzMS6jKzexnkHj0UXjJx84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=oJyXoi7T; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="oJyXoi7T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771835837; x=1803371837;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ISN3AMJU2NaJnMTZjgi6dG5+oLLR4UyCXFllChnzKtA=;
  b=oJyXoi7TA5eUhG8eNl51sk3gRPg7VW5tlsbLR1/aARj/sc1Ybl65vkf3
   Bv40CghKYo15/qooKMQSR0xb+aw+TKReKAjCpOSzepqpvGouk141M46Xp
   4H0sh2Zz+T3Em/orD0VOSA3el2e4upEYBQyVQxcX2X/Jvchj/24NVVrtr
   /5Wv0/4MqKIc8Cd4z4ELFKKUczG7ShNofFVgQRlDUE2T+zgeNYegaXdf0
   GfrCgiMWzb4KfVItQif/QZpqmJRaBv5LockzrNej9bm4cq5UdO1Uv7tXQ
   burepwRVvLI3rAmpr5om4b+fK2wA+d/He1N7t63WxuBbsnNiteuZuXmtJ
   Q==;
X-CSE-ConnectionGUID: dWSwkzKNRdqO9ug+S7h5zg==
X-CSE-MsgGUID: NUR3GnZqRsKOcTBrogxXpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90230631"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90230631"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:37:17 -0800
X-CSE-ConnectionGUID: NGqpXAc0RBOKy0THYnsKmg==
X-CSE-MsgGUID: nRF71R9RQHmi7TD8FCgerQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="253211880"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 00:37:15 -0800
Date: Mon, 23 Feb 2026 10:37:11 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Archit Anant <architanant5@gmail.com>, lars@metafoo.de,
	Michael.Hennerich@analog.com, gregkh@linuxfoundation.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: impedance-analyzer: ad5933: use
 div64_ul() instead of do_div()
Message-ID: <aZwRt7ws7PeHyuPM@smile.fi.intel.com>
References: <20260218125327.21467-1-architanant5@gmail.com>
 <aZXD0smUd3CRgPcv@smile.fi.intel.com>
 <20260222134326.7fc1f45a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260222134326.7fc1f45a@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 01:43:26PM +0000, Jonathan Cameron wrote:
> On Wed, 18 Feb 2026 15:51:14 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Wed, Feb 18, 2026 at 06:23:27PM +0530, Archit Anant wrote:
> > > Replace do_div() with div64_ul() since the remainder is not used.
> > > div64_ul() is the preferred API for 64-bit by 32-bit division when
> > > only the quotient is needed.
> > > 
> > > Also replace explicit casting and shifting with the BIT_ULL(27) macro
> > > for clarity.
> > > 
> > > Note: A mathematical simplification to `(freq * BIT_ULL(29)) / mclk` was
> > > suggested during review to improve precision. However, as confirmed by
> > > maintainers, the original driver's truncation via `(mclk / 4)` might
> > > be intentional or relied upon by userspace. Since hardware is not
> > > available for verification, this patch preserves the original logic
> > > to avoid regression risk in the absence of testing.
> > > 
> > > Issue identified by coccicheck using do_div.cocci.  
> > 
> > > Changes in v2:
> > > - Replaced explicit `(u64)(1 << 27)` with `BIT_ULL(27)` as suggested by Andy Shevchenko.
> > > - Kept original arithmetic logic `(mclk / 4)` to preserve behavior.  
> > 
> > The place for changelog (and comments)...
> > 
> > > Signed-off-by: Archit Anant <architanant5@gmail.com>
> > > ---  
> > 
> > ...is here.
> > 
> > But do not resend until maintainers explicitly ask for that.
> > 
> Tweaked commit message as Andy pointed out was needed.
> 
> Applied to the togreg branch of iio.git
> 
> Andy, if you want to give a tag I can role that in for now as need
> to rebase anyway on rc1.  This mail felt like an 'almost tag' ;)

I think you are talking about my Rb? Sure
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


