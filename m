Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EB7365A0D;
	Mon, 23 Feb 2026 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771849040; cv=none; b=YiFHo61OEsVRQYijkvmkA3a0ah1E9MoAg5s3YZ/fvBI5SE0eIPum9c4vrqkk3Y2VnYfAcD8bf/QXmD6zETeMTCrR9kcokrLnPh3xnDTDPRrn/puycn9K9800ZjWkFWAAAZ/gv0jXSXiUpnghyea9vpt6Bxv6HqZRfxN2SDnH6XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771849040; c=relaxed/simple;
	bh=FO7RzKKjrMQaxWvymcpkmAIVYyxycXBdRbocdxWYeBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mAgbb0iHw3g4prY3bctQ7Jfc5OhyEFFveQC6g8ybApFmwvRudznNOY9vrDI5Tb9gQ1M1WwxL0IyvbeNHtTQZirBnQ1d9uOiNQ+mqk1msMF842AOgUPuDKiMYUdeNiQS4lR61t570fmVlKLiDZTfb8A55LNRiaIUoC3uvENWFebM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j7R0gILR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j7R0gILR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771849039; x=1803385039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FO7RzKKjrMQaxWvymcpkmAIVYyxycXBdRbocdxWYeBA=;
  b=j7R0gILRBpE4AjqxFq1JfoVgp4H0tmGgros5S6K3Tc7I/A37eXJ+6efm
   +8lRlSZxCD4TvUyNLyWnd/818RFzGjw3g60iXWk6S8lfLPKPgxMupDDft
   hof0aFrOXp63HwdRjlYhSF4ipcm/9pKsWtt5k4EOmUSmhi7nTZqX6YsBl
   +Yfq5iTtTNkK1xCuyflRgRh3bM+M5U8Yb1bEg4ZHpVEXEzWiDc//Hyo7+
   DncPE2U08znn8GV4izXGKcixPuKuAY1TCAHbz+6mwdVqVWjIAlWJcygF8
   u0ECSWJXTGM3eAzTTEN7iwFM8xiJTiP4xoz269iYMxkRmIzLXLm9EMvmD
   w==;
X-CSE-ConnectionGUID: yyXku5gFSJiYVRKplhseog==
X-CSE-MsgGUID: 6oplZaVCSMSJjPBGzxkjIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="72749973"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="72749973"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:17:19 -0800
X-CSE-ConnectionGUID: qP/wQ7DKS7CZ738+/TgxFw==
X-CSE-MsgGUID: YgtZ38HFT0OcOIzjZ2fzRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="214633899"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:17:16 -0800
Date: Mon, 23 Feb 2026 14:17:14 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] General clean up and bug fixes
Message-ID: <aZxFSoTwIpDKNU4N@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
 <aZxFDIaOiqSqAbd9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZxFDIaOiqSqAbd9@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Feb 23, 2026 at 02:16:17PM +0200, Andy Shevchenko wrote:
> On Sun, Feb 22, 2026 at 09:40:10PM -0600, Ethan Tidmore wrote:
> > This series performs a general cleanup of the gp2ap020a00f IIO driver.
> > 
> > It integrates my original work switching to the guard() cleanup handler,
> > fixing a signedness warning from Smatch, an error swallow bug originally
> > spotted by Andy Shevchenko which I expanded to cover both buffer setup
> > functions and general cleanups written by Andy Shevchenko [1].

...

> > v5:
> > - Patch 1: Integrate some of Andy Shevchenko's changes.
> > - Patch 4: Split patch up as requested by Andy Shevchenko.
> > - Patch 5: Split this patch from the patch number 4, to keep bug fix
> >   separate from style fix.
> 
> Jonathan, this version is good to go in my opinion except patch 6
> ("iio: light: gp2ap020a00f: Fix possible error swallow").
> 
> Ethan, do *not* send a new version until we decide what to do with patch 6,
> and actually the rest may be applied by Jonathan if he is okay with them.

It's patch 5, sorry for the confusion.

-- 
With Best Regards,
Andy Shevchenko


