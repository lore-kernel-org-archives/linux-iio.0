Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2B399004;
	Mon,  4 May 2026 10:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777890011; cv=none; b=iHVZswLPmvLmn9feizwl9kXaOyU92ErE+Ib0s4ydjuhyySNQriDCihT3flWPrLsCukaVBydYuhnYFMNQYIJkftd8RuHzzXT9hmWHSpL40Rvtssl7yeg7ktogUvLA1L3N2q9b4THqUQzDmu3sweeJBMSkfqxvGh14N2h0HdwIIQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777890011; c=relaxed/simple;
	bh=BZDIAgth4Eb1/4yxW97Jyv0o7RMBiduj489saa3JUFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6ldbv6hiVjCkcZzVWV//n9W8/Xnj8+UjZEd/3iyIEas/Zqs8r7mMBY4j35hadcxYTh04rHip8z4exMVNR95M7tkFgVS7s2HlWjNlLNUxNckr8j4pGyX0zl2ZlEHHTmwlDBP/e2z9FqV9mvP38wuIpDuwv9zT1Zxvva0C4Hn/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C566SCZr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C566SCZr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1777890010; x=1809426010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BZDIAgth4Eb1/4yxW97Jyv0o7RMBiduj489saa3JUFo=;
  b=C566SCZrTgIAuiiiYJjo8XvPB5HlwYUSRSbYv8lSps4puahJmxpiy9RR
   SVN4hkWb2OOi0avXAE+pAiGz6aqvw07mMlGb14JHgAQk+mnceDr+7oiQe
   2p5ihH0yvgaJ5pD7T9A8tPwW0W9pZ+L0Gw4hlneLaFVqltNR1CoTBtdUZ
   3Oc5owRAesEDPcih3uppovBR6n1jgVmtrC9nKfitwK2e+55811GJ7jxON
   JA4PlotZnL+PudaBzm6FZILCzr0pOhsxuKpn2vCMlRlxS9zUIc0sKQEQt
   za/99CfX0fynHnIjRRwwFnn8tPN3nzbAatK6svS7fvkwFc07SK8/DVxRW
   A==;
X-CSE-ConnectionGUID: nWt5ezm1TZKAXyho0el1tQ==
X-CSE-MsgGUID: 7dPEvyvUQbiZwWjc4UHQZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11775"; a="78607332"
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="78607332"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:20:10 -0700
X-CSE-ConnectionGUID: uU/uDDcHTcqHQQuOmOLLzA==
X-CSE-MsgGUID: /u+eFunURu2nBpl+SGZ1rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,215,1770624000"; 
   d="scan'208";a="273602467"
Received: from hrotuna-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.245.78])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2026 03:20:08 -0700
Date: Mon, 4 May 2026 13:20:05 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v0 00/14] iio: magnetometer: ak8975: Additional changes
 to the driver
Message-ID: <afhy1bo6R48QJs8X@ashevche-desk.local>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
 <20260428173540.28b7913e@jic23-huawei>
 <CALoEA-xm0FGRk1rUWOO1YvzczC86Bgvu-t4Fe4iy3S_LCTygRg@mail.gmail.com>
 <afhkdxsxDbUDqG9g@ashevche-desk.local>
 <CALoEA-ybX_RPQaxCviS03mHvneWzH-WxNvbgBMxXXEmrfc3fGw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALoEA-ybX_RPQaxCviS03mHvneWzH-WxNvbgBMxXXEmrfc3fGw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, May 04, 2026 at 12:13:45PM +0200, Joshua Crofts wrote:
> On Mon, 4 May 2026 at 11:18, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, May 04, 2026 at 11:13:36AM +0200, Joshua Crofts wrote:
> > > On Tue, 28 Apr 2026 at 18:35, Jonathan Cameron <jic23@kernel.org> wrote:

...

> > > Given the relatively big backlog of email in the list, should I wait a
> > > bit longer sending the combined series?
> >
> > I'm fine if you send it today or this week.
> 
> Is it fine if I do a RESEND PATCH after rebasing or should I wait? Sashiko
> reported "failed to apply".

Better to wait, have you missed the --base argument? Or is it incorrect?

-- 
With Best Regards,
Andy Shevchenko


