Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94DE23DF019;
	Mon,  4 May 2026 16:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913242; cv=none; b=rtYD0khU3NOIgKDAjV46KzJ7D6buEbKdYQcYZ+yQo2KJKGx1F2tPa6Oi63fTBSO7v+OQMRosNmPt+Ao0nz0XIzsvZKZNl4RT2/FW/kzse8j7rx92zSPrMY98CcFzDZED9LTn/u6h6MChCLFtEAybU7Il5rrjI7+ZwtUIB6Abo3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913242; c=relaxed/simple;
	bh=6xAannm3IPgnwnuas01Foh1Fwipc/xGHc5HQqIhiYJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CxxEOxGQuMm0sf/9MNupgRsBQGiLcExdSVF6zjb5KHxh2WG/7LB0+NRm04cIOqO8hQukZWGg3uLv35ThW5R/ql97oU0RFvkbEA7s+JrxP8+4e2bpFAKsS9Ra9ZnAY5Dwd8l9Uu5simYNFMIQjIjYlL1rUAtkzE2hkJ3kf9EusAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B8tFjhed; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B8tFjhed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410CBC2BCF4;
	Mon,  4 May 2026 16:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913242;
	bh=6xAannm3IPgnwnuas01Foh1Fwipc/xGHc5HQqIhiYJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B8tFjhedaNJgyvi+fixy9xfEY5A0C/zr4nZO8/qdLHEKRdxgGQkqQz5n4vNSEYfv3
	 SXNdQ+0yGLsiEoPC7vTDD7Is+YbtUSXQHh6+WZJvDq9NFoKt0KHNgfwjvYCdjpgW5O
	 +NA/kJaQmEOO+f0RWvHhHYe4ErlnmSGLBwSRVG9PWg5Wyn4jCfC4S+Q7EBE8E/V195
	 N8c3IYl+AVo2alVa7dnC9YsJWh0D78ppHKBA64fGOBxtB/unuNWJqGke+wXpt3CSjJ
	 9A9Qzy+TYCoOOlvFVhuSktR66XMqvuKtedrfE9UsTEUyqHknK0L0yy4Ac4lDiC1qHd
	 v0xPLmqHKUHOw==
Date: Mon, 4 May 2026 17:47:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Maxwell Doose <m32285159@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: kmx61: Use guard(mutex)() family over manual
 locking
Message-ID: <20260504174713.538469dc@jic23-huawei>
In-Reply-To: <afhafBqBV79d9FBv@ashevche-desk.local>
References: <20260502032455.76107-1-m32285159@gmail.com>
	<afhafBqBV79d9FBv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> ...
> 
> > -	mutex_lock(&data->lock);
> > +	guard(mutex)(&data->lock);
> >  	iio_for_each_active_channel(indio_dev, bit) {
> >  		ret = kmx61_read_measurement(data, base, bit);
> >  		if (ret < 0) {
> > -			mutex_unlock(&data->lock);
> > -			goto err;
> > +			iio_trigger_notify_done(indio_dev->trig);
> > +			return IRQ_HANDLED;  
> 
> Hmm... Is the HANDLED a right choice?

Ah. Long running discussion point on what right thing to do if you
are sure it's your interrupt but your handling failed - in a fashion
that doesn't prevent the interrupt clearing.  Not obvious :(

> 
> >  		}
> >  		buffer[i++] = ret;
> >  	}
> > -	mutex_unlock(&data->lock);
> >  
> >  	iio_push_to_buffers(indio_dev, buffer);
> > -err:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> >  	return IRQ_HANDLED;  
> 
> If the answer is yes, I'm wondering if we may deduplicate that...

Would require a helper function to avoid gotos + guard() in the same
function or some ugly code flow. Might not be worth it.

Jonathan
p.s. I deleted some more stuff from Andy so look at his reply.

