Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01D70380FCC;
	Sat, 22 Aug 2026 22:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787436698; cv=none; b=iRQhZYptivD/IXP51g1P1M47xeO6tOFSR+xmLlZdE2vz6vt2CZlWZL4cHbGvPanUfXz1Oa/aH4QZgZcG8/Re4X6Sr49zx2KfCZauLgSOU9NLp6KkMjvFguIytZvUvOeJnvP2Rs+e0ozf4byTLr3IZ7R0BkebwBBalmrNWjBAHaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787436698; c=relaxed/simple;
	bh=SnmlKCwt/ddvw4XVvCH1MOTlb98ZFQn0bkCaMbl+rBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORewT44CaBvC7eJeBrmQw4ikBFvYu4NJ9xW+DTWYEHqZRxRkyWqzcpyUVQtjTJyDS9bs+PG57kP+4PiF5nRBAaXywd30eY1C2GPkJW0HaELnlPoMAVUdbUuEdWje3ny+NVgrveLGxYe9u6ZIM8iWlgDYA3M7L0v94eLsYFqjzcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FR6lFACy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FR6lFACy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B141F000E9;
	Sat, 22 Aug 2026 22:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787436696;
	bh=8KLh6a9zXK+AUbwNf5bpkns8aT4W1VolX4g3WILBFUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FR6lFACyU/nfgYqTpg/B+DN+Tk1bPdcdstawU71m5bQwfq3JwJgKFcBSZgWlXnn0z
	 S8lCzmJWF+evGt5b9En4krpPBVpqyhw0yeGzv4Kt+5n58GjXttRu+fcxfB5b7Jsjgi
	 +gf/IEo4CUVBwHoUUhV5JpOQH3qv6ma+CQcxi88lMmtwlip+lgPt4DCk9YgMmNKD6n
	 wSOTq/XpBgCbrWeKf4PWr8qdi22LhpqYve64uCkNAwfyv2rtPR75xs3MeLxoZPWLti
	 BKwEW9N3RfDdGOtRiwgd/cKL7so5EMhDA3cjaA9BImGZXotal2xwVFf4fOw/wwJ3Yd
	 uciRl0xr414Yg==
Date: Sat, 22 Aug 2026 23:11:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Gabriel Rondon <grondon@gmail.com>, andy@kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Stepan
 Ionichev <sozdayvek@gmail.com>, Maxwell Doose <m32285159@gmail.com>, Yash
 Suthar <yashsuthar983@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/3] iio: accel: bmc150: use guard(mutex) for mutex
 handling
Message-ID: <20260822231130.6011f3ce@jic23-huawei>
In-Reply-To: <aoR-rPWNMrqlFv2q@ashevche-desk.local>
References: <aoMrJvd4oSj0HgN4@ashevche-desk.local>
	<20260818154135.3324-1-grondon@gmail.com>
	<aoR-rPWNMrqlFv2q@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 18 Aug 2026 18:47:56 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Aug 18, 2026 at 04:41:35PM +0100, Gabriel Rondon wrote:
> > On Mon, Aug 17, 2026 at 06:39:18PM +0300, Andy Shevchenko wrote:  
> > > Not directly related to this change, but even in the original code what is
> > > protected here by the mutex? data->scan.channels?  
> > 
> > Agreed it is out of scope for this cleanup, so I left the scope unchanged.
> > 
> > Honest answer: not much that is obvious. data->scan.channels does not need
> > it, since the triggered handler is the only writer and the core serializes
> > it. The accel one-shot read is already gated with -EBUSY while buffering, so
> > bmc150_accel_get_axis cannot race the handler. What is left sharing
> > data->mutex and still reachable during capture is the temperature read, the
> > bandwidth get/set and scale set, and the event config. But since the handler
> > is a single regmap_bulk_read and regmap already serializes the bus, it is not
> > clear the driver mutex guards a real invariant here, and it may well be
> > vestigial.  
> 
> > Dropping it is a behavioral change worth its own patch and testing rather
> > than something to fold into a lock-syntax cleanup.  
> 
> Of course! Just made an observation.
> 
> > Happy to look into that separately.  
> 
> If you have HW to test, I would like to see such a change.
> 
See my reply to Yash's thread.  The lock scope may well expand as a trade
off against bloat of the iio_priv() structure.  If following what I suggest
it will be protecting the set of cachelines containing the various buffers
used for bulk reads during both DMA and whatever else is done with them.

Jonathan


