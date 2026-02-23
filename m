Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BBC3451D9
	for <linux-iio@vger.kernel.org>; Mon, 23 Feb 2026 15:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771859153; cv=none; b=r13c/oWCM3nllKiRzYsNkQMprYz1CJJ9XiH0rvo87RwgkoA5S19xqSI0JQQ6Q7xD1/CABJ+WMEC8u55Lut638EG6ZU715b++ddNziyDdLcskVHSwhN5oQer1m4kY5getJ3Us9DZE7B8RxQDCGvfI6MhdqdtEYuyzkM2kmQQ7CCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771859153; c=relaxed/simple;
	bh=LM5cHfwCw8fOP555+OOiEcuPaeAPAbe9SvDfEUa2/Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aL5R6tGeNX7KRjVioqjjP+/8SJ7oDZDZc8/6THvJCum06e37y9458RSb524e/X90hzq1kNTI10hxkFZE2KsNo/IH+6Vtxi2fuzsHGG4bOrs9aXetLCni5oNXM63b2zj+AItSIMBIFhNC4Qy7+UQGUt/fiZuXvokvKQPfgzqg4iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jKMWH5NS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jKMWH5NS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771859153; x=1803395153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=LM5cHfwCw8fOP555+OOiEcuPaeAPAbe9SvDfEUa2/Kk=;
  b=jKMWH5NSlEFpzWG9dVYEkU/qowpbqxIyLV1+/LhTozDLWo5av4C90wZv
   KcskJqWUk90WPsZ1gfr/VJyzgQyKDQ2CCqBSgA6l1MHD7p0TS9eZ4SPeD
   BQsTgfbaUqZF7GMKqOOvPGgRyIeLZ3kQp6aQCOtXYUzWoZ8pY+gYcy73e
   /iHJaua1p69aDD2m3It9wTfn3tI48F+xx2HutNhtFAcB+/iK0kM1z/8eh
   Qb3MdCmxJh4TzjBhbpSm4myomnpYUPOs08TQuIlJ3oyFGgTxoZQ45aiFH
   JMev4W5AMqfqvYHuCAV8R/OOvPPw80t70UjqBMrn+awnUYIeaLEs8/prk
   g==;
X-CSE-ConnectionGUID: VN525S43T7ORsB+QK5XXIQ==
X-CSE-MsgGUID: 7rvhU3ccQNa+qZfawOXLpg==
X-IronPort-AV: E=McAfee;i="6800,10657,11710"; a="60430925"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="60430925"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:05:52 -0800
X-CSE-ConnectionGUID: LIrUvC9rT7iNDKt3ISsKkw==
X-CSE-MsgGUID: CGWNXfTUR4y3d/NhJxKRBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214815163"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 07:05:50 -0800
Date: Mon, 23 Feb 2026 17:05:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer: Fix wait_queue not being removed
Message-ID: <aZxsyzVegdm1Ex_5@smile.fi.intel.com>
References: <20260216-iio-buffer-write-fix-v1-1-bc08b239f37a@analog.com>
 <6f5158e3-84e1-4159-9c61-789c2b198af2@baylibre.com>
 <20260222123756.59273a33@jic23-huawei>
 <09ea310dee18ba2174c29e078dce00a539a20a27.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09ea310dee18ba2174c29e078dce00a539a20a27.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 01:39:37PM +0000, Nuno Sá wrote:
> On Sun, 2026-02-22 at 12:37 +0000, Jonathan Cameron wrote:
> > On Sat, 21 Feb 2026 15:27:42 -0600
> > David Lechner <dlechner@baylibre.com> wrote:
> > 
> > > On 2/16/26 7:24 AM, Nuno Sá via B4 Relay wrote:
> > > > From: Nuno Sá <nuno.sa@analog.com>
> > > > 
> > > > In the edge case where the IIO device is unregistered while we're
> > > > buffering, we were directly returning an error without removing the wait
> > > > queue. Instead, set 'ret' and break out of the loop.
> > > > 
> > > > Fixes: 9eeee3b0bf19 ("iio: Add output buffer support")
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > > > ---  
> > > Reviewed-by: David Lechner <dlechner@baylibre.com>
> > > 
> > This brings the code inline with the near identical
> > flow in the read path.
> > 
> > It's been a while since I last looked at the locking / tear
> > down (what that ->info check is all about).  I'll add actually
> 
> Yeah not sure if you remember but I already said this a couple of times. In the buffer
> paths I'm not convinced the check we have is enough. Still very open to races AFAICT.
> I have it in my list to try and trigger and actual issue/dump on that path so it's not just
> theory. Already asked the bot to write some stressor/test code :).

Perhaps also a good task for stress-ng? Ask Colin!

> > documenting all the corner cases to the todo list as IIRC
> > there are some non obvious ordering constraints.  IIRC,
> > in the buffer paths, it is fairly straight forward
> > as it's just an optimization to avoid queuing or draining
> > data when the device is going down - nothing about the buffers
> > themselves involves interacting directly with the hardware.
> > 
> > Applied to the fixes-togreg branch of iio.git and marked
> > for stable.
> 
> BTW, I just realized we now have an Assisted-by: tag for getting help from AI. I should
> say that this bug was identified by Claude code (when bulding the stressor test app I 
> mentioned above :)). So, maybe (or can we Reported by: Claude Code?!!):

> Assisted-by: Claude Code

-- 
With Best Regards,
Andy Shevchenko


