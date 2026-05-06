Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAD37104C;
	Wed,  6 May 2026 07:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778051780; cv=none; b=Q4V50RzxSNMYUR0vjgOxeq2aShfpwgehi6gZw+7ZJRIY+uCFQzzGTTzOH3IEGOU3IfqbdJzMbcJaQUUZSKRy1phztgyiycZCqSjPhbQP29VDBQeWlrC3Nz6p/jEzhz6daoCYLJk504rNOyt1ZX81r8IMrFUaUXCBiNkJD/HMIoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778051780; c=relaxed/simple;
	bh=mlwMNMpAdOuoZ0ZiIP49BJZ02D7viokUcReRBfh6Qno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGbY/yfiik2vgp9YilZxWuuzrL2KZ9zXcDv+5gmBrDt2w9eLgkcLwn905u21zGbCXZBw4h8jF95SMbVbm3U/wbsHM7rSHMW91qQYsCJvX5uwRZnJHETe9LZLEeXMfyG/SlREIkui15eKSRpBK3RNTe95bQ8dXrgGMA3lSuFoE/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GHBfUhFi; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GHBfUhFi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778051779; x=1809587779;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=mlwMNMpAdOuoZ0ZiIP49BJZ02D7viokUcReRBfh6Qno=;
  b=GHBfUhFilsvQGbHrlJqw8pPOVwUUR39l5hrmJKma36Mg5IyiMPidFy1R
   +D/QJO78RYz7jqWwzkv5ZUgBt6izbLiz1uvucS4ozuS5GRi49VUioO51x
   iN1W0RXwE6srb35RXHGDqcSgM5GVLivioIh9Tfpe15ABYzoa9Vo4FHJed
   b130MXTV5kgm3M/wyZmHmTy5ZaftvH0OB8n+fcTZjIDGtv1C+8Lre7uh8
   uw4IJyofOsfWSmg93SnEzFiY9SMTucdpCENvQnvNiEZvO7e1e+ARGF6CL
   U8gvkM/k0fgGWKDWccWfZ/sp+80JlecYy+ZU9aSUfCgSvl2l/9y9nVPDF
   w==;
X-CSE-ConnectionGUID: yNOfbVixTDWerU9U2ETfAg==
X-CSE-MsgGUID: K0AEPHPpQi2XFXp2OU3Xjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11777"; a="82840924"
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="82840924"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:16:18 -0700
X-CSE-ConnectionGUID: wLplkebbSHCd88oPOvedeA==
X-CSE-MsgGUID: pqwjHNoUSbqXeF1GvSIEhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,219,1770624000"; 
   d="scan'208";a="237871221"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.183])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2026 00:16:16 -0700
Date: Wed, 6 May 2026 10:16:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Maxwell Doose <m32285159@gmail.com>
Cc: joshua.crofts1@gmail.com,
	Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 08/18] iio: magnetometer: ak8975: check if gpiod read
 was successful
Message-ID: <afrqvtBMhlUR5WmJ@ashevche-desk.local>
References: <20260505-magnetometer-fixes-v5-0-831b9b5550fc@gmail.com>
 <20260505-magnetometer-fixes-v5-8-831b9b5550fc@gmail.com>
 <DIB6Y4HLH5R6.XIP49B2XPVNC@gmail.com>
 <CAKqfh0FhpVMtoRyBPjmv5JHn9ad4fPgn5wiyYpEnSYf73Wd-rw@mail.gmail.com>
 <afrplquQwS2hmjEM@ashevche-desk.local>
 <CAKqfh0H1Cc1tizgYKFatEAVvyVMTsCAu1mb1XdSTqB4ecMvqPQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKqfh0H1Cc1tizgYKFatEAVvyVMTsCAu1mb1XdSTqB4ecMvqPQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, May 06, 2026 at 02:13:37AM -0500, Maxwell Doose wrote:
> On Wed, May 6, 2026 at 2:11 AM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Tue, May 05, 2026 at 08:42:12PM -0500, Maxwell Doose wrote:
> > > On Tue, May 5, 2026 at 8:09 PM Maxwell Doose <m32285159@gmail.com> wrote:
> > > > On Tue May 5, 2026 at 6:46 AM CDT, Joshua Crofts via B4 Relay wrote:

...

> > > Actually, timeout. Sashiko had a good potential catch here:
> > >
> > > https://sashiko.dev/#/patchset/20260505-magnetometer-fixes-v5-0-831b9b5550fc%40gmail.com
> > >
> > > "Does this new error path leak the pm runtime reference?
> > > In ak8975_read_axis(), a pm runtime reference is acquired via
> > > pm_runtime_get_sync(&data->client->dev). If this new error path returns
> > > val back up the call chain through ak8975_start_read_axis() to
> > > ak8975_read_axis(), the code jumps to the exit label.
> > > The exit block unlocks the mutex and returns the error code, but it skips
> > > calling pm_runtime_put_autosuspend()."
> >
> > While it seems like a valid concern, it doesn't relate to this change.
> >
> > > I'm going to withdraw my reviewed-by until I can confirm that this
> > > isn't a problem, sorry about that.
> >
> > Why?
> 
> I just wanted to make sure this wouldn't cause some crazy regression,
> I think it's valid to be somewhat concerned.

Yes, but this was the concern even before this patch, no?



-- 
With Best Regards,
Andy Shevchenko


