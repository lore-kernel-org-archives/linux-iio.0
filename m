Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C4F373BFE;
	Mon, 18 May 2026 13:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111574; cv=none; b=ajnONW6T5MCA1IiqILC2M6jIs3H9w8/YrBuSbDiYbYszojajiNKzFybD+yOInsZVG+wD8tW3lqGPt1JFLGNShy/B+/7SVNmi21sxOnA9SGSKSLPy3YCP9MJnoc4CjB5xdZTavPc55QBIHKEg9h4Mxog4IghtTT9ppfKdeZc8ID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111574; c=relaxed/simple;
	bh=FKAT+0mk3cIYTY0APy/qpgBa4R9ZiZKA/zsqN547/1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fm8SepIG98tBcUIpNNwSMNtfQoGpCu65iUw3vszBqDIBzmHIjYxRtu4TobWBoIcFcBQTtYNtYDzQmBi/uWCiY1mH3BDEQ7BwoxSh68XRWu0WCkiO82vow4xcgEe/f5p6xx08JprbS5Dqt8Q0iSJy7jUjo7CzL5oyaNw/7PQrqvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uS6afR2+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uS6afR2+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0CAC2BCB7;
	Mon, 18 May 2026 13:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779111574;
	bh=FKAT+0mk3cIYTY0APy/qpgBa4R9ZiZKA/zsqN547/1E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uS6afR2+vBJHj6DTCQe/sIITalNk8uDksP265/wsd6puM7+N0MoFWNuTUnpsxrejI
	 CEk4ldkjmwCkON00hNCWZjnQX773BxZ/v5A2YNHu4OBIlJ5Ly3Cid1dRB+Dv5znU4Q
	 MYMJBl5fOth8Bp5XVWuOQW/cjYR+gvUhWsHbea74XWvkpWMN34s9j8ucR6lTGk8Pkz
	 w898wSIero4Chgb06H3CfKM7EiQPKIro/BCVdLgQiER1SSJAdF6+12agvpC3yjvczW
	 fnpYert6/Twt3TmTyf3DFlIZt9cDVz2VEZ2KKI6q8pEkuqkTHbqcq09GCPI4+ssjyb
	 XG+XEnS3UpRQg==
Date: Mon, 18 May 2026 14:39:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, sakari.ailus@linux.intel.com,
 christoph.muellner@theobroma-systems.com, martink@posteo.de,
 mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] iio: accel: mma8452: improve coding style, pm
 and resource cleanup
Message-ID: <20260518143925.610c3049@jic23-huawei>
In-Reply-To: <agq9uWCrS3txgO5B@ashevche-desk.local>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<agogfypMDl6dS9D6@hu-ckantibh-hyd.qualcomm.com>
	<agq9uWCrS3txgO5B@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 10:20:25 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Mon, May 18, 2026 at 01:39:35AM +0530, Sanjay Chitroda wrote:
> > On Tue, May 05, 2026 at 11:16:30PM +0530, Sanjay Chitroda wrote:  
> > > 
> > > This series contains a small fixes, cleanup and improvements to use
> > > modern kernel helper API and coding style for mma8452 accel driver.
> > > 
> > > The changes modernize mutex with guard(), dev_err_probe usage,
> > > resolve checkpatch CHECKS and pm_ptr macro usage.
> > > 
> > > Changes in v3:
> > > - Following input from Andy and Jonathan added new changes as following
> > >   0001: handle return value to have proper error propagation
> > >   0002: use non-devm API to maintain resource management LIFO order
> > >   0006: convert individual regulator using bulk regulator API
> > >   0009: use IIO cleanup helper for DIRECT_MODE
> > > - Address kernel coding stype specific review comment
> > > - Reorder local struct device and dev_err_probe change
> > > v2 series -> https://lore.kernel.org/all/20260422165643.2148195-1-sanjayembedded@gmail.com/
> > > Changes in v2:
> > > - 0005: address review comment from Andy and Geert
> > >   and use DEFINE_RUNTIME_DEV_PM_OPS macro
> > > - Added new cleanup channges in mma8452 driver
> > > 
> > > No functional behavior changes are intended.
> > > 
> > > Testing:
> > >   - Compiled with W=1
> > >   - Build-tested on QEMU x86_64
> > > 
> > > Feedback and reviews are very welcome.  
> 
> > It's been about two weeks since the latest posting, and it looks like
> > there haven't been any major comments so far atleast on initial changes
> > of series. I also don't see any progress on the iio/tesing branch yet.
> > 
> > Could you please guide me on how you'd like me to take this series forward?
> > I'm happy to rework/resend partial/full if needed or wait further.  
> 
> The recent flood of the patches in IIO makes maintainers and reviewers
> overloaded. If you want to help, be a good citizen, start reviewing others'
> work. Otherwise, wait when we have time (it make take a few weeks or more).
> 
Just to add a bit more info.  Whether I pick up partial sets is often
dependent on what else is going on at the time.  So generally unless I say
I'm doing it, just assume that a full new version of the series is needed.

Just to keep my own tracking simple I tend to make that decision at time
of review (rather than coming back later to see if I can grab them).

Anyhow, today it was fine to pick some up so I picked up 1-5.

Thanks,

Jonathan

