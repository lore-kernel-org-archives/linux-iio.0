Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A054132B134;
	Tue,  9 Jun 2026 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985601; cv=none; b=fkB8Dp0YsGWTdhiV8Hubu6EpSmt6xRiFFPV4gPYR6sA6xzvONXeTTqhpEw66uW8eI8fsfBLOqvT/odkV8v10xt+dDQeQGMQ0McxY+kCsDwhCsA32+TTJzjG2jtjUuf+akt9OVlCRwN2dF8rovckqESERfqRFZBscbj/SuDBxYQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985601; c=relaxed/simple;
	bh=FcLJzAa+S4HKMTVWDts2O8MD2FMc2ByhHgzPFsHSDsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xt2nrXAYGq4UH5nJj50EX4p1hDR+UbrsfC54YCrjG+1z2uW+pGF8wgZ8naOu0sA+op4YzWU6NCdrVFrKChdGXmuZMHvi7j1teJXXe8tjd7CKXBPnJJFZMw3h8tRnRG3vxzRPCh2aERVC2v6CTU29ezAnB/mgQ4FQpfZYyhd1N64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBplAorl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBplAorl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780985600; x=1812521600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FcLJzAa+S4HKMTVWDts2O8MD2FMc2ByhHgzPFsHSDsA=;
  b=LBplAorlsRSfHxiDyF2YSUmD6o0nBCZEoTJge/PIa4ZWNBoqZ1Ze8NE7
   O7zSOhWeAxe5ZYsZgSGHaHwfAPVMmDZQ9E0jLIa7TGMIbvnZn72ygFGR0
   H8qVYRWkvDv8kZxdW3O4gDKBMoFBMz9qpo4WUvQK6QC9uIbzyN5etPc69
   EgA2XPASnFTo7rVln6kM6KLGC9IizvEzg1F6BgZtnovH6vQJyT9mwFPt0
   aHHbPTfb0bBBuABU4ElhEgNqwNFNKsNs8harsBW/Kw1Ywerxp95/nDY6w
   JaEAZUuSQySxyfwOkCU7DgtClyx9adhOOtg8qlP1OW2LHEuJMu1kMPh+k
   Q==;
X-CSE-ConnectionGUID: 4y37W+ZXSuO3xOaJhhHJSg==
X-CSE-MsgGUID: gp09l36tR8O1I0fibU99LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="92844074"
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="92844074"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:13:20 -0700
X-CSE-ConnectionGUID: U9mNzVb7S5G4oJIesNnrWw==
X-CSE-MsgGUID: 5MVBxzFLRyuF6KE9AIkJ1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,195,1774335600"; 
   d="scan'208";a="250678857"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.39])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 23:13:16 -0700
Date: Tue, 9 Jun 2026 09:13:14 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hungyu Lin <dennylin0707@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: bm1390: replace short msleeps with
 usleep_range
Message-ID: <aieu-h2a1qqAzHnX@ashevche-desk.local>
References: <20260607140018.59586-1-dennylin0707@gmail.com>
 <20260608184154.72a88788@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608184154.72a88788@jic23-huawei>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 08, 2026 at 06:41:54PM +0100, Jonathan Cameron wrote:
> On Sun,  7 Jun 2026 14:00:18 +0000
> Hungyu Lin <dennylin0707@gmail.com> wrote:
> 
> > Replace msleep(1) with usleep_range(1000, 2000) for the
> > driver's short delays.
> > 
> > The BM1390 datasheet specifies a 1 ms reset cancel wait time
> > (tSC1) during the power-on sequence. Use usleep_range() for
> > these short delays, as it is more appropriate than msleep()
> > and avoids unnecessarily long sleeps.
> 
> Use fsleep() which has the added advantage of standardizing the
> 'slack' so we don't have to thing about the values chosen

While true, msleep(1) is kinda idiomatic, we don't need to hunt subtle timing
issues in case of switching to stricter fsleep(), which will most likely choose
usleep_range() beneath. TL;DR: I do not see a value in this change.

-- 
With Best Regards,
Andy Shevchenko


