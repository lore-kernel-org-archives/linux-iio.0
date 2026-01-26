Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BBA33E352;
	Mon, 26 Jan 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437787; cv=none; b=RyUZAnlPYFp2voSUMG/ryr8a+Ko0Oqw4l4r7uHCAuAB1e8uQJ6eomf+nexLuCcN/FZ0hoz+T4/pwrp7fSO+pHAnwOvz5SiXsaD8VFmCbOJz5XDxOG8q7VxLSYY48UrjbdenWeW4XaG85bjC68JzFDW7PitZrKA0quW2LVf5G1M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437787; c=relaxed/simple;
	bh=JuNUE3cqSEeHRIZOLqDcHGRkN7MeU/unX5fXwmPNeR0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=if+mX/9Rg02fZmcjplub6r9zQ9EE0FlkrNBDncESpcGlgM1osRQD5wV8CG5S5nL0U21elbxvFGCHzW0rkMQr8+QqT5cXUIR+v+DESVP+AXFG9YpOGq+Pd/fYO0ejIgQ/UJllHimbipE8svS9Q6U+g0vhZrc4uc+tNs6/5UhB6PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb3KBXBJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb3KBXBJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CA6C16AAE;
	Mon, 26 Jan 2026 14:29:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769437786;
	bh=JuNUE3cqSEeHRIZOLqDcHGRkN7MeU/unX5fXwmPNeR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb3KBXBJ7Lg6WuCndOI4fK9hFv1sWSR8Kj11cI8/m9BMlgcAz77dehImPW8L1tGr9
	 OXkzdJrKBktkuNcEfwyv+Xs9NVCAokvnmF+hpZEscqxgLFLerVS0UFDXsA66Gw6gYm
	 OVPdE1rVpNo7PxdnYJBKJZB3Q+SUy7dcgY8Wu00/I3dYmM9XzDLHHSuS2qj6EMkV1L
	 dKc1nW5/O6wsud85Y83Wfp1g2xJnZyuu5Lq/e1TwRJqrCalobS9J9Mm82H8Q7Cm8SZ
	 6LNNOIBJXW1w5zwvGxfid+Fgwhwp72MS2pZDv0iJ8ARtRCVrjjBXPI8vrNxU5CBot0
	 0V+zvIsZ0E4Hw==
Date: Mon, 26 Jan 2026 09:29:45 -0500
From: Konstantin Ryabitsev <mricon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, tools@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Marcus Folkesson <marcus.folkesson@gmail.com>, 
	Kent Gustavsson <kent@minoris.se>, Gustavo Silva <gustavograzs@gmail.com>, 
	Nishant Malpani <nish.malpani25@gmail.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260126-cocky-sawfish-of-variation-c0cedd@lemur>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXdJbidb3DPyRaxB@smile.fi.intel.com>

On Mon, Jan 26, 2026 at 01:01:02PM +0200, Andy Shevchenko wrote:
> > I lose it on the next if I update patches in tree and re-export them. 
> 
> I don't understand this, sorry. Can you provide a step-by-step example?
> Do you mean that you are taking previous version from the list and reapplying
> it via `git am`? But shouldn't `b4` take care of that as long as it knows the
> Change-ID and it matches?

That's not the intended workflow -- the series is kept as a branch in your
local tree and any updates happen to that branch, so any entries in a commit
falling under "---" will persist across revisions.

> Hmm... The https://b4.docs.kernel.org/en/latest/contributor/prep.html
> doesn't clearly tell me if there is a carry-on procedure for the Cc
> list between versions.

There isn't any special procedure. ¯\_(ツ)_/¯

-K
