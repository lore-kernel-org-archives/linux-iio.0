Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC05B43BDA8;
	Mon, 24 Aug 2026 14:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787582900; cv=none; b=AlctbSPye2w/fZIQ9rxjrmBdhLQ/aHPI4XPrMTJ1ACfH6+q07AVlpVNybPXcKV4QGI1fHdQvgrn2fp2mcx43tKqKhMO68XMsYglKxzHLhVp8OtnpdWa026a+aY6t+7Qt4Ga7VmBbpF46rpA2bRJITxfzkaGmIEMwvsNFEqNDy1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787582900; c=relaxed/simple;
	bh=aqOa6XtW+aFZB3MhqJktHgQ8+c2E+S4uwzwmAua27uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lGWd6MR5d72zHIJqtXeLROLybpVyYFgr4uxfyuIQuUKb3L8cruc1wFvS/FO3JwMVvdzW7VGWDG64EHkWh/boghTUVwBJmkjlglkf9pOKcyQ6fDl8Ta+8jlWMaGrS31Q9f8/U/2t8jeG5Ux/irjmncAatKlniiTgnMByk+Ahigko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AHC8NBnD; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AHC8NBnD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787582897; x=1819118897;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aqOa6XtW+aFZB3MhqJktHgQ8+c2E+S4uwzwmAua27uo=;
  b=AHC8NBnDi7N2ymSgukz+K42ufIEzu6x4LWNYnUmLypy392nMIJiOov+0
   pD5b6+OZGiy9IdqEWoguluOiU5KB0B4BIcGFKIVdzLsZXD45ACfTQ77pS
   x0aofYoDXPW1fOk9nGNkp5vlqlDSoQE84PTFYOhVKnyjEuu+haaM8SdF3
   o8eR7H1irPFO6r1S2uMSO282eCGo4uPO0fgnV9na9vvVRV6uwa+vkJyfQ
   oJlzMXi/C1mVHeYsbsRuBfbvsdWEim4nBaaMGhc5TGwudKq3NDyD+/uQa
   gwY3uEexXN6BxBmyYAyh8CPtqi4lI5ddEBQrVBVCYj51JMkdE3SbZcdn4
   g==;
X-CSE-ConnectionGUID: GAJoFOL0Qee+Uf/cnVLbQA==
X-CSE-MsgGUID: ecpl+EO2SeyGiteeRcFSsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11885"; a="88160955"
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="88160955"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 07:48:16 -0700
X-CSE-ConnectionGUID: XyyS3nDLTGCB+rrrjCKjSw==
X-CSE-MsgGUID: pcMT6CqRSxu5+5mgBFnFDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,240,1779174000"; 
   d="scan'208";a="267588099"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.130])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2026 07:48:13 -0700
Date: Mon, 24 Aug 2026 17:48:11 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Rishab Madhugiri <rishab.madhugiri@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: Avoid BUG() on invalid clock types
Message-ID: <aoxZq7sc4ndMG-V8@ashevche-desk.local>
References: <20260823222502.30764-1-rishab.madhugiri@gmail.com>
 <aowVI_n7s0VAmN3D@ashevche-desk.local>
 <20260824120503.00003500@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824120503.00003500@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 24, 2026 at 12:05:03PM +0200, Joshua Crofts wrote:
> On Mon, 24 Aug 2026 12:55:47 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
> > On Sun, Aug 23, 2026 at 10:25:02PM +0000, Rishab Madhugiri wrote:
> > > Replace deprecated use of BUG() in default switch cases of
> > > iio_get_time_ns() and current_timestamp_clock_show() with
> > > WARN_ONCE() and return correct fallback or error codes.  
> > 
> > Why?!
> 
> Because BUG() and BUG_ON() shouldn't be used anymore, no? Linus himself
> said that he hates the macros.

Why? Please, study the case. As for the above change, there are two questions
(at least):
- Why BUG() is deprecated? Where is it stated?
- What will WARN*() gain us here? (Note some specific kernel command line
  parameter that may convert WARN to BUG)

-- 
With Best Regards,
Andy Shevchenko


