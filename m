Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA4405872;
	Thu, 11 Jun 2026 18:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781203611; cv=none; b=MwQwUBeQYm7hHa60qXh6ZYquC4WMPUNf8pQV/YagacCRLWU80wCehHbq27NZUNU9ssgPAVYt7dNzaKuvadDp8OB3Zc4AEbzGXV049arvY6u4luX4DdlcS2io5X/RARuun6tZHmQJhPPEaLPFPbawYk7CMzUsBo+WQFiqkJ/ew9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781203611; c=relaxed/simple;
	bh=hHM5hTo+ieS672ETi8SpnzYLXpHLkGksNkawobyQ2uU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G38L59vhWSoe3c+DoTp/im/1rXeiy+mAx6vSVWY5bqSorjoZ9Ck2nnkZeaPFq3Smdoy+wqrwpO3TfcuERjYH+StzjH98rny+z/ZThU4TmMD2vE+1mKAEEpwlThh6ngYNIqakCyB8UYOrz1XW9SWVXzKxv4MnFEto5lBZPjflEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iB1o4vMq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iB1o4vMq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781203610; x=1812739610;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hHM5hTo+ieS672ETi8SpnzYLXpHLkGksNkawobyQ2uU=;
  b=iB1o4vMqiUI7U+M5KMRx5zGQWtW5sPm5lgm6Bb3F1CCZjSk4QMVIkRrB
   NbEQEz0Hnpfcw4t6s7UjryMtgdWYEGM50cyYZdDrcYCjs31xAvMKcsP1T
   Ro3v5OpIUxkxyKNNOv1hTVDwYufvDeLROhspE23SoGCsQHMbUBazpZ553
   tIiQ2gFQkAO8j20SOKdyV45soRL/0lOBMUsXYaJ2Hd4eQwl+5a8nFxEVS
   pJWzfLc1b70LAbOP1LS36HgcsdZG4qcwe/2R46BmeQ95U3+NFKto3hPWd
   id5hvApOFnslAu4BPZtsHTZSysJJ8flQbqObuwKCVOUr+ZASbq/RxYGkZ
   A==;
X-CSE-ConnectionGUID: j9nh5GHjTHyTsVZwwjQO4Q==
X-CSE-MsgGUID: lYjWPi1VRz20p4xI/ABVcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="85657414"
X-IronPort-AV: E=Sophos;i="6.24,199,1774335600"; 
   d="scan'208";a="85657414"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:46:50 -0700
X-CSE-ConnectionGUID: A+XrYCr0S6OxamorIbZoUg==
X-CSE-MsgGUID: gWNbHlklTYiVuDt1qSFRAw==
X-ExtLoop1: 1
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.123])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2026 11:46:47 -0700
Date: Thu, 11 Jun 2026 21:46:45 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Manuel Ebner <manuelebner@mailbox.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	open list <linux-kernel@vger.kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] Documentation: ABI: fix brackets and bracelets
Message-ID: <aisClWbXCX-XjVJ1@ashevche-desk.local>
References: <20260611085620.127959-2-manuelebner@mailbox.org>
 <20260611104643.2a5ed6c2@jic23-huawei>
 <54d15f70bd8ec76eea0a792ca701195b8472ee2a.camel@mailbox.org>
 <20260611171520.0a96ac83@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260611171520.0a96ac83@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jun 11, 2026 at 05:15:20PM +0100, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 13:54:04 +0200
> Manuel Ebner <manuelebner@mailbox.org> wrote:
> > On Thu, 2026-06-11 at 10:46 +0100, Jonathan Cameron wrote:
> > > On Thu, 11 Jun 2026 10:56:21 +0200
> > > Manuel Ebner <manuelebner@mailbox.org> wrote:

...

> > > Take a look at hos this stuff is routed into upstream.  Each 
> > > subsystem 'owns' their own documentation.  So this needs splitting up
> > > on a per subsystem basis.  I'll also note that you've only +CC IIO folk
> > > so you aren't going to get much review on the rest!  
> > 
> > I send it to the addresses get_maintainer returned, except the git blame
> > ones. How can I find out who to send this to?
> 
> Some are easier to track down than others - look up related subsystems
> in maintainers + look at anyone who has made significant changes to the files
> in question.  However, some folk who work on Docs don't necessarily hang
> around so also useful to use lore.kernel.org to see if they have been
> on the list recently.  Also sometimes it is a bit fiddlier so look
> at the original commits - that lets you find out what the files are associated
> with.

Also Cc Randy Dunlap, he is interested in documentation fixes.

-- 
With Best Regards,
Andy Shevchenko


