Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8B34D4DE;
	Mon, 23 Feb 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848979; cv=none; b=UiL66dhdOHw0XiMZJE8v06/Dd8BYdd0fV27HgT8OeNgxPbCMWNU7u/CYoniQpXf64SVNqhjA+QK8cRGK8i5oYArQG657h1fBIFhxhcy1JZXb4CDJfYZFvEQH8F8SMWLQ2uatJyQryuJQI3JK3tVcaQ3+OR5IxOxD4LaGJTiaxUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848979; c=relaxed/simple;
	bh=qXtyfcTzXgq2YYPLU0LTvfoeUIKl7R4WHcvtKbsUHxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xd+PVFG/z1VIUvg7hvYdIef8ba0z6Dxtb1sZie0YkXGyvZ7azuwWVTCMRzLtBDgDiXh8BCPcA4laPcRCuwdW0pmx7tenBao7BMXkROspyEU5G6fOArLLk+/ce5nIbksWZhxXh4NlIxcg166/femudLMmLJGlKofhjtUMUBEVS9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RhiX5WPr; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RhiX5WPr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771848978; x=1803384978;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qXtyfcTzXgq2YYPLU0LTvfoeUIKl7R4WHcvtKbsUHxk=;
  b=RhiX5WPrXDhyTefiSq6tcfV+HBnEgvdVGEAT4Cfkmy5s54MGlI+LtO15
   X5Rnmfy+RTbU0ZnWEkGxtMrkAyjgfa0BBARi2SsvIRVSpdoIv/OxeuDcb
   +xkAt2qFQCtQ6S9ND8JBPQ0ljmKzxMGyhgcm7G0YzNZzv6rWHDWUVc/I0
   ipBdeDIGr8JguqvWnjVUz4POdVZs+RPAMPd3YD/b8q3h/Q6Q2+DlCufet
   DX2yzJNwLZXelpsGYgTl2aQaJjQJwv3jXGgZYwNZN7Q+O2R38nQ4L1XKF
   IFRgHVWrwQmWsLcci6IVS90SKmP0yfyAHz+Be1M5U+b3NFLRB+veYU+lC
   w==;
X-CSE-ConnectionGUID: YTvFjgDMQgqIui3ONayo+w==
X-CSE-MsgGUID: zMHw6IM9RWmlO4gkiA0BjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11709"; a="90247905"
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="90247905"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:16:17 -0800
X-CSE-ConnectionGUID: 8jGkF702TDuPxCiMpEUbdg==
X-CSE-MsgGUID: KZGp2vh4RkKyPR8e4bjWkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,306,1763452800"; 
   d="scan'208";a="215387718"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.222])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2026 04:16:15 -0800
Date: Mon, 23 Feb 2026 14:16:12 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ethan Tidmore <ethantidmore06@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 00/10] General clean up and bug fixes
Message-ID: <aZxFDIaOiqSqAbd9@smile.fi.intel.com>
References: <20260223034020.27625-1-ethantidmore06@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223034020.27625-1-ethantidmore06@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Feb 22, 2026 at 09:40:10PM -0600, Ethan Tidmore wrote:
> This series performs a general cleanup of the gp2ap020a00f IIO driver.
> 
> It integrates my original work switching to the guard() cleanup handler,
> fixing a signedness warning from Smatch, an error swallow bug originally
> spotted by Andy Shevchenko which I expanded to cover both buffer setup
> functions and general cleanups written by Andy Shevchenko [1].

...

> v5:
> - Patch 1: Integrate some of Andy Shevchenko's changes.
> - Patch 4: Split patch up as requested by Andy Shevchenko.
> - Patch 5: Split this patch from the patch number 4, to keep bug fix
>   separate from style fix.

Jonathan, this version is good to go in my opinion except patch 6
("iio: light: gp2ap020a00f: Fix possible error swallow").

Ethan, do *not* send a new version until we decide what to do with patch 6,
and actually the rest may be applied by Jonathan if he is okay with them.

-- 
With Best Regards,
Andy Shevchenko


