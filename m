Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF5626ACC;
	Sat, 11 Jul 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783809456; cv=none; b=NfmUN6IzgQknJMy7kO/8jj53cSko7t9N+9RvVBbnYYyK4ZaeAe84dCFbs4+1AQKeyoXT70tr4P6zaU8Nwy/Uys3QxUn3qoUp0SWp+or/jsxPVDawnwRJgzEkqlt9uzNlR9UOJU06KSOKy/xveHP1lpqh5FTgHG/SfH8wupphmFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783809456; c=relaxed/simple;
	bh=LienSLMNqVETNAYctT8zj76hcxc/9g6iDuKErtk+wM4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dn53GigER2Z+ezPDEPWh1tZN2u3tlRRDQ1SdLvR0UNkC2ZcSfIQbdyA3zzEariNEIXPMdAGDZZ0GQ9Nvg2NMSVyjpy9H6jdKM84Bw1413A8itisTv/iOj84gS4RzAooZHXDjLiCBr3p07D5u/UK+dJHrOQlw+t08OdMaIvoFwGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4+vLi2t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4+vLi2t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8340E1F000E9;
	Sat, 11 Jul 2026 22:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783809455;
	bh=/Rp37bWcG8xvAUnQQcFb5Xww6FXRNkg5ATUBQemsSU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=A4+vLi2tvL7IUd7FJNNfAdu5X42tW6i16JIHLVLVeDMJLnkZRHonT1YON7bHNLc+j
	 vuohbPgd8acjFCCA9qyb+cWlt667eKc41sQ15D2wVRNPCkZLrY3dg55uyDH0opK93T
	 WQ20bLN4oqzG5LknkHlS79UydXp+A74c22nLhO24zOoA4fGyeizri49QqAsBNZr9zL
	 QduKjCtS0+aZMDPE5qhwK3d9lmoQvYn9NUkkeBABK13DKIU8CW4RmPqxnR6nFVb3uA
	 yCu74TPG/oEbsn+LVbKFyR6m1u264w9UrbdMgszXqvRwXUh3l2vUWD/NL5tjjFB/WN
	 7r0ELAomIHc7g==
Date: Sat, 11 Jul 2026 23:37:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: light: vcnl4035: Propagate regcache_sync() errors
Message-ID: <20260711233730.0cc37de4@jic23-huawei>
In-Reply-To: <akj4Yr086hmW7AJg@ashevche-desk.local>
References: <20260704071410.18757-1-pengpeng@iscas.ac.cn>
	<akj4Yr086hmW7AJg@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Jul 2026 15:11:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Jul 04, 2026 at 03:14:10PM +0800, Pengpeng Hou wrote:
> > vcnl4035_runtime_suspend() marks the regmap cache dirty before runtime
> > suspend. vcnl4035_runtime_resume() then syncs the cache before re-
> > enabling ALS, but currently ignores a regcache_sync() failure and can
> > still report resume success.
> > 
> > Return the regcache_sync() error so the PM core sees the failed register
> > restore.  
> 
> ...
> 
> > -	regcache_sync(data->regmap);
> > +	ret = regcache_sync(data->regmap);
> > +	if (ret < 0)
> > +		return ret;  
> 
> When do like this, add a blank line.
> Same comment to all similar patches you sent (or about to send).
On this occasion I fixed up and applied rather than waiting for a v2.
Applied to the testing branch of iio.git.

Thanks,

Jonathan

> 
> >  	ret = vcnl4035_set_als_power_state(data, VCNL4035_MODE_ALS_ENABLE);
> >  	if (ret < 0)
> >  		return ret;  
> 

