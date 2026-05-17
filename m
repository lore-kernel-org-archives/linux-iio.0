Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984943064AE;
	Sun, 17 May 2026 11:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018402; cv=none; b=ss+OcKhCVV/OExFPI3UTELtROEspEAHnyG2LSdMU9NIG2LD6zr/oN/Vm3nLLiEnGZvxioUrMrxHqyQI4j4I11Ab0Gw83j+6n07Er5s2hB981fkeZRJJlZgZsyTocctaSAzWUlNOpajQ/HF+onTNGlVPCJVqJoet4LNDEyNMP6R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018402; c=relaxed/simple;
	bh=EYckaXV+q315W4ItxHfgEnc/fWdb1uqs5Gyt7GNLxN8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sFaSXM+zVaIhaA7dasfn3wNHgQmnbUVyktKkkvSliO9me6/njMw7uL269Mc2XO+6bMIkRxALr2zuxfZiYwMWO3LtKxOfs8/UCMDyeQnzhgVjGaKd4+zRjyEEXfoGH71f32hZ0BnXF+880vvjq3pU0i5qjRgC9XimfP6TKJEmO5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bb97UEOg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bb97UEOg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AADF3C2BCB0;
	Sun, 17 May 2026 11:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779018402;
	bh=EYckaXV+q315W4ItxHfgEnc/fWdb1uqs5Gyt7GNLxN8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bb97UEOgpdy24c0itBFnmpcpaOfN7A7qmncJph1KofyTMzpneAX5DLnigGR4H/leu
	 +Yj386CgY8HZYSQsoZjAKLD2VK7jWqqAzqOpONBupzncO7XbexoPpdKyU283+zbRuJ
	 8zwA9brzo05aJobdaJHUCTEUntW/1JLU1jaO2RIOCSnuIwrTXWVrVBbf3Gl4Lk+6Ay
	 6rxZMBRaxmuoARQ8Hwf7E2Gd7DDHTBuAOCbCrRPgZpz/KR4B+v40IGgLHMdXAi8JK7
	 fbBLUtcMzb2F6MgbBXstXzIXWgWIZ8rgEyVFXS6els8fn1/ZXhzqjIXsBDdtk/2Fou
	 efJBto/FaTPhA==
Date: Sun, 17 May 2026 12:46:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sam Daly <sam@samdaly.ie>, stable
 <stable@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 2/3] iio: light: veml6075: add bounds check to
 veml6075_it_ms index
Message-ID: <20260517124633.7f02c03d@jic23-huawei>
In-Reply-To: <agl128K9M_48QUxs@ashevche-desk.local>
References: <2026051420-strudel-graves-f6cd@gregkh>
	<2026051422-hungry-dolly-0250@gregkh>
	<DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
	<20260515153236.1acf1ca4@jic23-huawei>
	<agl128K9M_48QUxs@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 May 2026 11:01:31 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Fri, May 15, 2026 at 03:33:07PM +0100, Jonathan Cameron wrote:
> > On Fri, 15 May 2026 08:17:18 +1300
> > "Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:  
> > > On Fri May 15, 2026 at 5:23 AM +13, Greg Kroah-Hartman wrote:  
> 
> > > > veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
> > > > values 0-7. If it returns a value >= 5, this causes an
> > > > out-of-bounds array access. Add a bounds check and return
> > > > -EINVAL if the index is out of range.  
> > 
> > I'd prefer it if this sort of change called out that we don't expect
> > to ever see those values except when we have bus corruption or
> > a broken device.  Good to protect against but that info might help
> > folk decide whether to backport or not.
> > 
> > I'll add a note whilst applying.  Applied to the fixes-togreg
> > branch of iio.git.  I also rewrapped the description as 60 chars
> > is rather short.  
> 
> Can you also clean up the commit messages from Cc list?
> 
I did. Forgot to say.  Those have little value once it's merged.
(and can go below the --- to make my life easier ;)

J

