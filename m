Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2F6368958;
	Thu, 17 Sep 2026 02:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789612344; cv=none; b=nHy95M/B1kgB2rrZMBq7VGXxjWghGRqII5qahny18R67DutTIcGRZifOm7klQXTeATK1zpmxsOgzM+YsD6+E1+Vn8gAaA1Gv0IwymnnDup3jtYcDe1JTGLtR2eiL2Yvuubv1476DXpaZ0qynaOvLRilenqbASG/SyC2CLvU6cEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789612344; c=relaxed/simple;
	bh=TXjNRLL9Uv4YfcS6euo6YsDJf7CBtcEvevfoQ3wjZc8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocPK7PcXTSHvfwlRQvC3xBFy77gvn6Sy4cI/vymlF16AtABxI1IlDvs78QF2tsLLa2XFa685bM/3bDfKBYdOe5CfW8MLB+98vmmiLYc4rU59h/GQplbEikv2eQPfN/cqG/iAlEaoZznrnFEahbR7KSiyWHCJyeyR+zy6Ft6pRvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ms0uLPjQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ms0uLPjQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A261F000FF;
	Thu, 17 Sep 2026 02:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789612337;
	bh=I4E0GCKh4Sn5F9lgbZ/MqMACyLxDgq5v1Ztf72t9lrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Ms0uLPjQOomGGJP9CefkdrMzk6KgUDy3DQ8ToQBXuMSSex0ntoT8cW3/cdoXOuqzz
	 QZ2aSIIwRKneQtPGt0wcvX5A0PiX781QkJ7lzYS9jeGPwmhduyxHq4K4kQPGDGu3Ef
	 atLJr9Fdhjfl92f3dIYSDCpa2Y7GEU/9ACzBTjUHXUONaT+8+5mLC5sIjUrKdxp0ri
	 upGQqa8hbCcEhNYDXSVxQnaEHDGywFAFwVi7ln4Tsxi9mZzHKx/rblzHZmya8IHd+g
	 Oy62M/o8hb5pUp7xnzTbPdZxela6XEyZ6K5CqXZAWlWiZhDE6oPx8t1dLldCpsOEWA
	 waEp4WIxqjizw==
Date: Thu, 17 Sep 2026 03:32:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macromorgan@hotmail.com>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>, Andy Shevchenko
 <andriy.shevchenko@intel.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Linmao Li
 <lilinmao@kylinos.cn>, kernel@axis.com
Subject: Re: [PATCH togreg v4 0/2] iio: imu: inv_icm42607: fix PM error
 handling
Message-ID: <20260917033211.6226c895@jic23-hlaptop>
In-Reply-To: <PH0PR19MB99733868ECBD2EBDD57833E80BA5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
References: <20260824035531.141429-1-lilinmao@kylinos.cn>
	<178939644602.1670536.5651900027161221634.b4-review@b4>
	<PH0PR19MB99733868ECBD2EBDD57833E80BA5BA2@PH0PR19MB997338.namprd19.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 12:00:28 -0500
Chris Morgan <macromorgan@hotmail.com> wrote:

> On Mon, Sep 14, 2026 at 04:34:06PM +0200, Kanak Shilledar wrote:
> > > The recently queued ICM-42607 PM support has two error paths that can leave
> > > the PM core's state inconsistent with the device.
> > > 
> > > Patch 1 propagates sensor shutdown failures from runtime suspend.  Patch 2
> > > ensures that system resume restores runtime PM management on both of its
> > > error paths, so that a failed resume does not leave runtime PM disabled for
> > > good.
> > > 
> > > Changes since v3:
> > > - Patch 1: commit message expanded with the practical effect of the current
> > >   behaviour, the cost of propagating the error, and a description of the
> > >   recovery path that does not assume a particular regmap bus
> > >   implementation.  No code change.
> > > - Patch 2: unchanged.
> > > 
> > > Neither patch was reproduced on hardware; both were found by code
> > > inspection.  They were compile-tested with W=1 and checked with smatch.
> > > 
> > > Whether patch 1 is worth making is still a fair question - it trades a
> > > possible idle power leak that may be cleared by a later successful access
> > > for a runtime PM error state that needs an explicit reset.  The commit
> > > message spells that out; happy to drop it if you would rather not take
> > > that trade.
> > > 
> > > Linmao Li (2):
> > >   iio: imu: inv_icm42607: propagate runtime suspend errors
> > >   iio: imu: inv_icm42607: restore runtime PM on system resume errors
> > > 
> > >  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 38 ++++++++++++++-----
> > >  1 file changed, 29 insertions(+), 9 deletions(-)
> > > 
> > > base-commit: 350d1fb9204b13c5f95e511e98b8bcb47574d425
> > > --
> > > 2.25.1  
> > 
> > Tested on Invensense, ICM-42370-P development board. Performed testing
> > with basic r/w to the device and checking the PM runtime status. It
> > worked as expeted.
> > 
> > Tested-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > 
> > -- 
> > Kanak Shilledar <kanak.shilledar@axis.com>  
> 
> Sorry, I've been a bit busy with back-to-school stuff this month for my
> kids. I've tested these patches and do not see any problems with them on
> my device. Note though that I didn't observe any errors prior, but I can
> at least confirm this doesn't appear to introduce new ones.
> 
> Thank you,
> Chris
> 
> Tested-by: Chris Morgan <macromorgan@hotmail.com>

Great. Thanks to both of your the tests.  We should never hit any of
these conditions unless something has gone wrong hardware side.

Applied to the fixes-togreg branch of iio.git. Whether that
goes upstream before the next merge window or waits until then
is dependent on what else comes in.

Thanks

Jonathan

