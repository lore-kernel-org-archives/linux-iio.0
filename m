Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B20241C2FD;
	Mon, 11 May 2026 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778523466; cv=none; b=jQjFbR2eZLP2NmF2SPAK8m5kxxVWXTVEZAcslqO6ttyCXB59VFw9J0SZKfr5IZ/zKBPgUDXjdYAcXKD3xn7aFWqOZIETlAWhHVHttsxs4s9ezRfhAfKZyVcPxq0NJ/aGbHVijGKzBsjY3vm5jLw36JpeLISGuQExtRWjlN6haW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778523466; c=relaxed/simple;
	bh=CQ2FJ1AOIv6jLghN32DAmSv4RJjdmOUH9BEaBlYWLuw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qqs++AQ0hEXE0WM+RXPT7VxflTodxj2gB6wkVHGgRNyWaKu1XhzwWBlVj7ko66rg6D2zwArrP50dICKuSci0zV8rsuHm/HjJpzvuaAzL6BavN0VVPk6ebM1ubRx8qpET6bbBr1jl6d4ZKlAg+oOlauvdwt5MZL/BaaAiTU6wfb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t2/sro2O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t2/sro2O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA7BC2BCFB;
	Mon, 11 May 2026 18:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778523466;
	bh=CQ2FJ1AOIv6jLghN32DAmSv4RJjdmOUH9BEaBlYWLuw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=t2/sro2OSuQC9LRmYhTtFe+APFuOj/MYlYgKKsYiieEvXd3ey5+Y0xKr/M7xxed7Q
	 qg1DiwXdEeNxuD/Kb4lT6kOPnzhcIxdM7Ldv8uG2IRLuqjvyfP/JgOlkgV/UZwFoRh
	 qR3+EPlTziPdOe5AsxlAaA3xPrl8y40aSMtsGKAlPr+3XMZZK2kKwqfbH5XIrv6bWi
	 a3LGgUH0LWmSiGhzfE2egKPRGH/ufIwizbSmgUJxgcXcPQu3v6kkqWn2pV3wuR3Peq
	 OUyl+ww6qeYybDzbSuON6R2qUfHUqTzQSHuR6qMx94dMn0R17tlCU6JD7HtaWFAGWu
	 4gGWiQTv4Ri5w==
Date: Mon, 11 May 2026 19:17:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Joshua Crofts <joshua.crofts1@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/8] iio: magnetometer: ak8975: switch to using managed
 resources
Message-ID: <20260511191741.5f45d6f3@jic23-huawei>
In-Reply-To: <af7oKgtzyFmPogJJ@ashevche-desk.local>
References: <20260507-magnetometer-fixes-post-pickup-v1-0-37827ca68fb3@gmail.com>
	<20260507-magnetometer-fixes-post-pickup-v1-3-37827ca68fb3@gmail.com>
	<af2zup3PFlgs2DtE@ashevche-desk.local>
	<CALoEA-y-Qg22NSfVBLtqx4VFp0q=xqLOuL5Wf8TxW1AswW1+hQ@mail.gmail.com>
	<af7Zql3NkhDwKWBc@ashevche-desk.local>
	<CALoEA-zBRC+sZqtP4YiSu8ZBgw69t9_ZqaOQ9BDResRWhnGR=g@mail.gmail.com>
	<af7oKgtzyFmPogJJ@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 May 2026 10:54:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, May 09, 2026 at 09:47:25AM +0200, Joshua Crofts wrote:
> > On Sat, 9 May 2026 at 08:52, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:  
> > > On Fri, May 08, 2026 at 03:51:06PM +0200, Joshua Crofts wrote:  
> > > > On Fri, 8 May 2026 at 11:58, Andy Shevchenko
> > > > <andriy.shevchenko@linux.intel.com> wrote:  
> > > > > On Thu, May 07, 2026 at 04:35:52PM +0200, Joshua Crofts via B4 Relay wrote:  
> 
> ...
> 
> > > > > > +     /* Only power down if currently active */
> > > > > > +     if (pm_runtime_status_suspended(dev))  
> > > > >
> > > > > Is this one a correct one?
> > > > > We also have pm_runtime_suspended(), which is different.  
> > > >
> > > > As we only require the status of the device and not the power.disable_depth,
> > > > pm_runtime_status_suspended() seems adequate.  
> > >
> > > Last time I have checked the code on this I remember that probably this one
> > > doesn't guarantee that immediately after returning to the caller the device is
> > > still in a suspend status.
> > >
> > > The difference between two as documentation said is in "...if runtime PM
> > > is enabled for @dev..." for the pm_runtime_suspended(). So the
> > > pm_runtime_suspended() is stricter in that sense.  
> > 
> > Okay, if you prefer pm_runtime_suspended() then I have no issue with it.
> > I can amend the series version this time.  
> 
> It's not about my preference (I am fine with either call), it's about
> understanding the code flow and what does fit better in _this_ case.
> 

https://sashiko.dev/#/patchset/20260509191907.24734-1-macroalpha82%40gmail.com

See patch 5 review.  I haven't checked the details but looks like this
dance might not work and we need to figure out something more clever.

This particular example 'might' be fine as we don't end up with
pm_runtime_set_suspended_action() being registered.

May be fine but needs more careful analysis :(

I'm a little concerned we get some stale state because in the 'early'
set active approach used here we don't undo the pm_runtime_set_active()
anywhere.

