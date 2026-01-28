Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22AE42D0C92;
	Wed, 28 Jan 2026 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594860; cv=none; b=d+Sm7wB3kvcNFkS9XOuAYgTlspFV6c/YaZg6Hrki/7k2dQztrl68+gf7ailM/6QyEhni91yOT6wRCqdyBKqUDX/auoYRIVfwkoXHQZj35fxoTg5OTgMlEid4JegiILGrXdCR8KYFxMRwAMcSeWGfo3tIe5PvQAaqsqtrVjefsPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594860; c=relaxed/simple;
	bh=dc5Up4a/vumotxTjBgsOwM80kZI0zOMTOhJqCvi4olA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cZVqbf5XFsxEYTO/MSBk9fhs5hORlwtuAXXG4CTqjYQklKYpkft0VEtC+WP6xq0GzMBpJWwqhSSQhHmcwc80+nWtDboBnxqCiIc2WMuy+mF25AEhr4k0bQdx9SOXb6FzKJlWk7b9g+9VKKAsORyyFVDAo/cs2IbDbgPafIWVLrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g+K7hx6q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sbBuLH4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g+K7hx6q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sbBuLH4"
Date: Wed, 28 Jan 2026 11:07:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769594857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbscuRDkEWKMwPed9C6neDCxDHBdvV77WV722sWbREY=;
	b=g+K7hx6qS0L1y0MhiZpFOWuULMIbQRJYwUDWHC74Wq95p7uT8TsYQIX26i7GOrkJxAN8YT
	IrDmRj0aAPkPVzbuEWSbXNC2jyHnn8NnarpDv3CPSvlEDZPU/T+xEzugOuo4oZG14Sbzfw
	WUWXYNxOIzsqf3FGJRZinocotgu2phX2aDnz72oYH54cotu0aK9QQPgyflqG+L2U9ETKE2
	F5Whexm3AddQ+PQKgz2htCxk7/+FsOqIwTDGa0o3ZPxIrLTDoFjjHDIwTvfPG6vWmZG5Yj
	VpVbNAWPYMxSP25afRIGo3I633XeQlb1K6XWVVEOGMy2fUz46M2o/mJlO5jMMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769594857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GbscuRDkEWKMwPed9C6neDCxDHBdvV77WV722sWbREY=;
	b=3sbBuLH4Bz1dsvf1kBDTi4w1F3DwJVUn20MyqeIBVKDl2ZriCmNBsi9hGCoIk4MLf2kUcM
	2mamiiTTzVMmMEBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: tools@kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260128100736.Fdw5Oknz@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
 <20260126081510.jr8Rp6R7@linutronix.de>
 <aXc5Efu-PlLNCxkk@smile.fi.intel.com>
 <20260126101034.lnGGQmUD@linutronix.de>
 <aXdJbidb3DPyRaxB@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXdJbidb3DPyRaxB@smile.fi.intel.com>

On 2026-01-26 13:01:02 [+0200], Andy Shevchenko wrote:
>   ---
>   Cc: person 1
>   Cc: person 2
> 
> Just don't reimport them via `git am`.
> 
> > I lose it on the next if I update patches in tree and re-export them. 
> 
> I don't understand this, sorry. Can you provide a step-by-step example?
> Do you mean that you are taking previous version from the list and reapplying
> it via `git am`? But shouldn't `b4` take care of that as long as it knows the
> Change-ID and it matches?

So doing this and switching to b4 trailers to grab the tags actually
help. Then I have been playing with prep. So thank you.

Then I stumbled upon --auto-to-cc which picked up all addresses and
added it to the cover letter which was fine. But then `send' used those
for every patch in the series which I did not want. So for that part I
probably stick with git-send-mail since this not in everyone's workflow
(sending a series across multiple subsystems and avoiding flooding
everyone).

Anyway. This seems to have turned out nice.

Sebastian
