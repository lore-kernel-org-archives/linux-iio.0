Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22430CD9E;
	Sun, 27 Sep 2026 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529306; cv=none; b=lOWTa4GkqtJFM2et3ZZOeUp6cO5RrnLOcv34rq/qKF2idJpNDSnCumCFwksZlKUrJdlHz8Ho/KjHPA7hIGL+jWUDZvYHy5jd4/cAAk1dQUgt9H+IS49xQ/sa0SOM78T+XvjFTmKBddCdjrjTGPWp4ZO6IohCK+lH46fd6kyzCTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529306; c=relaxed/simple;
	bh=Zv6a3B7SBOFZJf0/OdMIYvgax6yueIR3mk6pnKNpzGY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WduxUFWSJPkH3r/QBA1KZ/hUnRnKPC8oKJM/s7ihLvoRNbkV9fWunV8uUmfcwYwM3hWtKyCnMtBQ7Ya8bTqUyH16N5TpyofNItUbYWpG0lLb74+4RlUb25h0syfCW64i0lh1wTI4kFLFQ1gATOjUnxNlQHZ6pDqbJVC0L/zvY7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOk5mVEZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOk5mVEZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8BB1F000FF;
	Sun, 27 Sep 2026 17:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529304;
	bh=tUVuQeB2+5l1YBVm2X8JwCfhuWe29w3vaWzNKgnimKo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cOk5mVEZBtlVcC/w/It8tDyID9yX93m37/3HoyMtD2m+5YFoixoJP2xD2QDo7z7Pb
	 0UI5g2hqFN4bF81uPRmUHwcswKexNnQI9o9vCgr/VIEAAIXj9qkxJn84jmCTmPWzNt
	 Y46oP741MmXg7jC2imjL18gdRO0DR3iHFwM7xpPfaGFiDyR4RdeMwHsquS9x7KQrM7
	 eiyXJ6LnscZ2QlmzVwtzMsqt/9n92hLT41oB0sO4MpYkatGIrIFL8su+hAGh1tIFE+
	 j7lMZwdCz1DpvQ1/B1/gblAk2+JJHd1HD+nqNZr2dto7qUvI6DXKZSnF1GaaiFnKG+
	 VHVTejnOPKekA==
Date: Sun, 27 Sep 2026 18:14:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "jiale yao" <19888972804@163.com>
Cc: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, "Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= (The
 Capable Hub)" <u.kleine-koenig@baylibre.com>, "Bjorn Helgaas"
 <bhelgaas@google.com>, "Matti Vaittinen" <mazziesaccount@gmail.com>,
 "Danilo Krummrich" <dakr@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: kxcjk-1013: reject duplicate event disable
Message-ID: <20260927181458.22f022e3@jic23-hlaptop>
In-Reply-To: <7fec18d8.e8d.1a0dc78eba2.Coremail.19888972804@163.com>
References: <20260925140945.2254656-1-yaojiale02@163.com>
	<araCbz928KEnAamY@ashevche-desk.local>
	<21e57d3a.1d0c.1a0d9008daa.Coremail.19888972804@163.com>
	<20260926014942.0af1a16e@jic23-hlaptop>
	<7fec18d8.e8d.1a0dc78eba2.Coremail.19888972804@163.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 14:48:27 +0800 (CST)
"jiale yao" <19888972804@163.com> wrote:

> At 2026-09-26 08:49:42, "Jonathan Cameron" <jic23@kernel.org> wrote:
> >On Fri, 25 Sep 2026 22:38:07 +0800 (CST)
> >"jiale yao" <19888972804@163.com> wrote:
> >  
> >> At 2026-09-25 22:17:19, "Andy Shevchenko" <andriy.shevchenko@intel.com> wrote:  
> >> >On Fri, Sep 25, 2026 at 10:09:43PM +0800, Jiale Yao wrote:    
> >> >> The IIO core does not filter duplicate writes to the event enable
> >> >> attribute. kxcjk1013_write_event_config() already ignores repeated
> >> >> enable requests, but a repeated disable request still calls
> >> >> kxcjk1013_set_power_state(data, false), dropping a runtime PM reference
> >> >> that was not acquired for this request. This can underflow the runtime
> >> >> PM usage count and trigger a "Runtime PM usage count underflow" warning.
> >> >> 
> >> >> Return early when the requested state already matches ev_enable_state.    
> >> >
> >> >Sounds like a bug that needs to be fixed and hence Fixes tag to be applied.    
> >> Sure, I'll add the Fixes tag in v2, 24h later,  for any other comments before sending it.  
> >For a simple request for a fixes tag, I'm also fine with you just
> >replying with that tag.  b4 will pick it up (though technically in the
> >wrong place so I'll massage things whilst applying)  
> Thanks.
> Fixes: b4b491c0832e ("iio: accel: kxcjk-1013: Support thresholds")
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan
> >
> >Fix looks good to me.
> >
> >Jonathan
> >  
> >> >
> >> >-- 
> >> >With Best Regards,
> >> >Andy Shevchenko
> >> >    

