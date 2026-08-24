Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3FC40EB9D;
	Mon, 24 Aug 2026 12:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574744; cv=none; b=k7E56OKCAp7s1kBUUd5b7PZJmzJp3+XEL2JJvP9bOA67LgT1lf8KecpzuJjzOWsQRF3CyY05BFdBcmsdVVFAGBL+vZhtgHRTK/tgO7H7cD69EP7IFVZWuro+CUCiaJgPSRWh4BJE4VMm8vdJ4ewoNeHHBIgF3J/2kCpnn13Ivyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574744; c=relaxed/simple;
	bh=xqykfgQ/Du2x0MColCr3mSkreHTtjHJZeMPbzY7rz3s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOtNB9eTqNeDWvnvtsIlZoPD1J4Bhcz6tL/80df7RMOoD4V51THAujhBZOOwpMNW2x+4Er6b8KSNx9eb1YbCjH0jlLgne3GOtU0rW5bVi6onEwzQ3EIKfMrd4775fAW2d9WEUJw3k0I79RV1uLTKpZ2g79dS8KfOB3fpPpLaAfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJXweq83; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJXweq83"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDA41F000E9;
	Mon, 24 Aug 2026 12:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787574743;
	bh=KMJxfROyeX/B2GqRjh1mfOkUFpYLar3s1zAHNwZtK7g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UJXweq83t1pXhNa7H6yP1Yzs4ULPPvZoM6+r8QZ6UrXAqyqvqqCeUZC6gxbSX0NIa
	 8fxwRqbws+sIYIRRjVsUm1D8xnnGM/YwcMZewvEDAZW2zNKiWStDNPMtpSISFthFDh
	 nJaQREFvGeq71jZfSosM4wswgPmrdOy1ddS6f5qoK6Ip56RkGYYB3aIL1oUhYqVUAs
	 fODFeCUxV+Si7wznHrUvc+CbhTfMrKRf9G6JKF3JA0hU/OfyNUR9jtcfNecyqucYUq
	 HvRXGcXy7wPpdqj5/jEyJ8Fdhek+EYsR6Bfdx0Zc94fW3gYkDa7HBzTF921tX36z+v
	 I70YRwBwab9VQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1wyTqe-00000001nAw-22Ti;
	Mon, 24 Aug 2026 14:32:20 +0200
Date: Mon, 24 Aug 2026 14:32:20 +0200
From: Johan Hovold <johan@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: srf04: fix runtime PM autosuspend cleanup
Message-ID: <aow51Nk-cet9qaUQ@hovoldconsulting.com>
References: <20260807141938.2491195-1-lgs201920130244@gmail.com>
 <aoQGR8uSXXmOxnWI@hovoldconsulting.com>
 <20260822010809.04404b4e@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260822010809.04404b4e@jic23-huawei>

On Sat, Aug 22, 2026 at 01:08:09AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Aug 2026 09:14:15 +0200
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Fri, Aug 07, 2026 at 10:19:37PM +0800, Guangshuo Li wrote:
> > > srf04_probe() calls pm_runtime_use_autosuspend() when the optional
> > > power GPIO is present, but srf04_remove() does not call the matching
> > > pm_runtime_dont_use_autosuspend() before disabling runtime PM.
> > > 
> > > The runtime PM documentation requires pm_runtime_use_autosuspend() to
> > > be balanced with pm_runtime_dont_use_autosuspend() when the driver is
> > > removed. Failing to do so can leave the autosuspend usage state
> > > unbalanced and may result in a usage_count leak when the autosuspend
> > > delay is negative.  
> > 
> > I believe the term "leak" here is misleading as the usage count would be
> > dropped again when the user re-enables autosuspend through sysfs, right?
> 
> A user has no reason to do that under normal circumstances.

This issue only arises when a (privileged) user *does* exactly that in
order to disable autosuspend by writing a negative timeout value through
sysfs. And the reference then taken is dropped when the user later
undoes the operation through sysfs.

So there is no usage count leak here.

> So whilst that might work it is rather non user friendly to the extent
> I think I'd consider it a bug that should be fixed.  Backport or not
> is a different question.

What is leaking is the autosuspend setting, but the implication of that
is generally not even noticeable. Remember that this only happens when
root unbinds a driver. And in almost every case, it is the same driver
that will later be rebound.

I guess you can try to come up with a situation where a different driver
is later bound which does not use autosuspend, but here we are very much
in hypothetical corner-of-a-corner-case territory which is not relevant
for stable.

> > That said, drivers should clean up after themselves so disabling
> > autosuspend is still the right to do. But it's more of a cleanup than a
> > fix (and does not need to be backported).

Johan
