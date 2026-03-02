Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04FD31E82A;
	Mon,  2 Mar 2026 21:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772486151; cv=none; b=nr6h5wXPfJQ2ue9nvN2MHDoyKmXx2e+hN92NWz55exxqSwFwbRhKK97RIU5lFrK+bmw0HRKqPrHuhtaclkWBt9AJK+bG11t0psJoQwNfQ/+jvomCV33cYr5WREDCm1Mc+Z0ID2UQaGY61gK1rTU+Mco9mX4SXkTyWPir36Ywn24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772486151; c=relaxed/simple;
	bh=rAPVsvuaK+d5VxDG3OsqWwsmO1pdqFZ5TJnRLZ4Njqo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pUplWTLau7TOqpE7/WkMl2QC+I8Soz17LgRw9Ou9jQzwqLnY8brwoTgLLKAbrTxsfDfK6vpI76pzwgc0ujgFBn42Mn/lTLqtNz6EITEwMo4m+wvICaFHxFbno5MZmDKp8R5xPEuLuSkX8uNFBbKKRTI1H1L64yp9Mmun2AbmHoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzhoVGyW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzhoVGyW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3131C19423;
	Mon,  2 Mar 2026 21:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772486151;
	bh=rAPVsvuaK+d5VxDG3OsqWwsmO1pdqFZ5TJnRLZ4Njqo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WzhoVGyWPGCLsToSoyFJkTVi8WAbtgBALdwJnCJMN2x07P/vQAPy41FuEcU0a0usq
	 tWbuNlb+68+0RbywxlWnkj3nNg6dl8lhJM0ybF6QMZNZcP9XMYmpCKLXu4VxEa43Cu
	 e5YGpmfBy1eCRpJa08EFZy4qwm0+Iy/et7B8ewE14vcdVhRuKKqTccEqjI8SJqikIb
	 EtTWOZyogFL4zva1SYq3jglITE6h7LsOsC60Gr+fIJu2JmMVfx1l1ClV+1QegiLOiu
	 SFi69WDoVVXu1Lzd9b1Wmqg6mZB6f3iQPeNgnyaQl7vZoVVZASVu1L2EcaBcR8zYIT
	 Ett6Cr3pfxHQw==
Date: Mon, 2 Mar 2026 21:15:43 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Neel Bullywon <neelb2403@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] iio: magnetometer: bmc150_magn: use automated
 cleanup for mutex
Message-ID: <20260302211543.28efc28b@jic23-huawei>
In-Reply-To: <aaVId0_InmrZJCl5@ashevche-desk.local>
References: <20260228172320.68144-1-neelb2403@gmail.com>
	<20260301115633.7529cbee@jic23-huawei>
	<aaVId0_InmrZJCl5@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 2 Mar 2026 10:21:11 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sun, Mar 01, 2026 at 11:56:33AM +0000, Jonathan Cameron wrote:
> > On Sat, 28 Feb 2026 12:23:20 -0500
> > Neel Bullywon <neelb2403@gmail.com> wrote:
> >   
> > > Use guard() and scoped_guard() to replace manual mutex lock/unlock
> > > calls. This simplifies error handling and ensures RAII-style cleanup.
> > > 
> > > guard() is used in read_raw, write_raw, trig_reen, and
> > > trigger_set_state. Case blocks using guard() in read_raw and write_raw
> > > are wrapped in braces at the case label level to ensure clear scope for
> > > the cleanup guards.
> > > 
> > > A bmc150_magn_set_power_mode_locked() helper is added to deduplicate
> > > the lock-call-unlock pattern used by remove, runtime_suspend, suspend,
> > > and resume.
> > > 
> > > The trigger_handler function is left unchanged as mixing guard() with
> > > goto error paths can be fragile.
> > > 
> > > Signed-off-by: Neel Bullywon <neelb2403@gmail.com>  
> > Hi Neel
> > 
> > LGTM, but I'll leave some time for Andy to take another look if he
> > wants to.  
> 
> I briefly looked and I'm fine with the code, but I haven't reviewed it fully,
> hence
> 
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 

Applied. Thanks

J
