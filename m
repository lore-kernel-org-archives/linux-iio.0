Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86B1730C167;
	Sun, 17 May 2026 08:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779004899; cv=none; b=d9NsY5fwD5hHfyk2hmS94PGp1HEh9n+V91HmdOKR+D/BlQ9Tz4fJAcnRdSigDDfSPv0St9xecOnPri5GXR+BzP7ZDNOnnuwbU+8JHxnGy/iMLA5uGLOmcrWVwsqoY6OBio1Sk2tNEGTlKye+86aLxggAAzdRx28Ds2mnAdTK6yQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779004899; c=relaxed/simple;
	bh=KLnBPUym3Id6q6yTpiDJAC4TH3qJw5u8LTJ/Iioao/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pehjNU6Up86C7v1Tw7gMJUdnAhOp1hVGPoXKIoE4sEPt1ysdPVtf0Xg2GicmVICBPLA+7mILOZkEAW3dxegUfFG7H5eJIeIzKEelA3i84NspMM75t1ZurfcyzxFHS8h+HUcnIau6an9W4pUGPcos57SeLfSvKR1rR5S0lqhs/MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e1VaNZjR; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1VaNZjR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779004898; x=1810540898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KLnBPUym3Id6q6yTpiDJAC4TH3qJw5u8LTJ/Iioao/o=;
  b=e1VaNZjRQJgRZXab1e9HcxxzAiZ0rB58LnNCsApj1pLjBWBnU01xpQOS
   +lLfXA0Oy01QL17JCfFBvgik66HaZ3YxZBCjDux7Z2eYfnbfAXJp+3o/Z
   uUGHuRLBZ0MffCqKHe+umPmrxYjR3TJVB5s/gg0llmNAeeuV3wjeL6zjQ
   BqMSksUfYfen53v9P2YyAMuYO6LBafXXZ17Up4xlJQ1k70ZkqycmYY7cM
   eAVl5xdCmQvPeVHH8tcAXIEKPesy/O/xcsZirMj1GlKJmYa3JVFDZYk6r
   PhlHoTFQGmGMY4tUUFEmV6+hXbW14W9x0p7D5AtiXpclc1MScty09hXuD
   Q==;
X-CSE-ConnectionGUID: GxZle4juTkODGRpvrb/Lgw==
X-CSE-MsgGUID: vzuEZ7dDQii/Vb4yaREAuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11788"; a="83761739"
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="83761739"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:01:37 -0700
X-CSE-ConnectionGUID: FiMWsd2bR5+CmHGSctSLqw==
X-CSE-MsgGUID: AHOB8y4rRxeUdFBtY0wlBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,239,1770624000"; 
   d="scan'208";a="239364535"
Received: from slindbla-desk.ger.corp.intel.com (HELO localhost) ([10.245.245.182])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2026 01:01:34 -0700
Date: Sun, 17 May 2026 11:01:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sam Daly <sam@samdaly.ie>, stable <stable@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/3] iio: light: veml6075: add bounds check to
 veml6075_it_ms index
Message-ID: <agl128K9M_48QUxs@ashevche-desk.local>
References: <2026051420-strudel-graves-f6cd@gregkh>
 <2026051422-hungry-dolly-0250@gregkh>
 <DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
 <20260515153236.1acf1ca4@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515153236.1acf1ca4@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, May 15, 2026 at 03:33:07PM +0100, Jonathan Cameron wrote:
> On Fri, 15 May 2026 08:17:18 +1300
> "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:
> > On Fri May 15, 2026 at 5:23 AM +13, Greg Kroah-Hartman wrote:

> > > veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
> > > values 0-7. If it returns a value >= 5, this causes an
> > > out-of-bounds array access. Add a bounds check and return
> > > -EINVAL if the index is out of range.
> 
> I'd prefer it if this sort of change called out that we don't expect
> to ever see those values except when we have bus corruption or
> a broken device.  Good to protect against but that info might help
> folk decide whether to backport or not.
> 
> I'll add a note whilst applying.  Applied to the fixes-togreg
> branch of iio.git.  I also rewrapped the description as 60 chars
> is rather short.

Can you also clean up the commit messages from Cc list?

-- 
With Best Regards,
Andy Shevchenko


