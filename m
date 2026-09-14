Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68843290B7;
	Mon, 14 Sep 2026 03:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355141; cv=none; b=sW+rOxDyjiBwWOwlCueYU8fDJpD2Gn+rRG3xUTVEb5GNQxPezifYUwmDjWm6s0tcWO/t0m1vtUFEyIXXMuMOx980nw/lVXS5mMhnohv9p0HigpibmibLNiiZxhvO+QT2rXJQzntd6zltZUEEhEAx5zwENK3Lg1qXIfBHA96s3n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355141; c=relaxed/simple;
	bh=n13pyDwfskpPV/6Nsqj65nuI1WV7YdGf7bUgnn2eeiY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OjNI0IiLyZ99aCnP9AjbykJdxTSZBtZy1Ta6dOAw8WdAC0S4Ck/pSFquPS3/5HeY//3+dZM1U06si6PR37VrU+QGktiabmt8yFIRF9gZ9uH8aVyn2UZUSmLdjJG8gyA4tRy/m6AYgUo4gCHDP0oozjdtKwS0+QX95IJ50bFxcZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBqI6mOP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBqI6mOP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CAF1F000FF;
	Mon, 14 Sep 2026 03:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789355139;
	bh=N1oUz0uoNHb/8XozU114yRjSi4A22ayZTk2PiMCMKbE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YBqI6mOP0dsCdE7LawYiuV3lX0+yj0foJPVGPFrasUVvRDk23vk2ZPLyQwDwoQiOU
	 C0Hwj8PhOmNJtB3RNwWW2pc23GYSePR30A9YFt1bx3ZWgFpgbFdnACoymN7kGZ15yX
	 dtYrOzekRlbUyPsSGVCH1qMZ53GE1aJnMyJ3Lm8jtYFpsZfoJoe8P6kGUzxKY/EpTl
	 gSy/2nUSE6ZeBxTPckpJtaZlMql6FAJedMiUq7oBpkaCQkRBA26il40ojSsscy1mfP
	 rykW8zVRqX1c3DEbEy/fsX5pfO2ETY938Pl8K4peejgfUOaJUXx+mO+gp5yWVqcP2M
	 15fbBmbqeVAEA==
Date: Mon, 14 Sep 2026 04:05:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Chris Morgan
 <macromorgan@hotmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Kanak Shilledar
 <kanak.shilledar@axis.com>
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID: <20260914040534.772a4aeb@jic23-hlaptop>
In-Reply-To: <20260901022243.740760aa@jic23-huawei>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
	<20260901022243.740760aa@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Sep 2026 02:22:43 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 24 Aug 2026 11:55:29 +0800
> Linmao Li <lilinmao@kylinos.cn> wrote:
> 
> > The recently queued ICM-42607 PM support has two error paths that can leave
> > the PM core's state inconsistent with the device.
> > 
> > Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
> > ensures that system resume restores runtime PM management on both of its
> > error paths, so that a failed resume does not leave runtime PM disabled for
> > good.  
> 
> These look fine to me, but I want input from Chris (and ideally some sanity
> check testing) before picking them up.  The dead chicken test that they
> don't active break operation when we don't see errors is probably enough
> given the analysis seems fine to me for what happens on error.

Kanak, given you are looking at this driver perhaps you could take
a look at this series as well?

Thanks,

Jonathan

> 
> Thanks,
> 
> Jonathan
> 
> > 
> > Changes since v3:
> > - Patch 1: commit message expanded with the practical effect of the current
> >   behaviour, the cost of propagating the error, and a description of the
> >   recovery path that does not assume a particular regmap bus
> >   implementation.  No code change.
> > - Patch 2: unchanged.
> > 
> > Neither patch was reproduced on hardware; both were found by code
> > inspection.  They were compile-tested with W=1 and checked with smatch.
> > 
> > Whether patch 1 is worth making is still a fair question - it trades a
> > possible idle power leak that may be cleared by a later successful access
> > for a runtime PM error state that needs an explicit reset.  The commit
> > message spells that out; happy to drop it if you would rather not take
> > that trade.
> > 
> > Linmao Li (2):
> >   iio: imu: inv_icm42607: propagate runtime suspend errors
> >   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> > 
> >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
> >  1 file changed, 29 insertions(+), 9 deletions(-)
> > 
> > 
> > base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425  
> 
> 

