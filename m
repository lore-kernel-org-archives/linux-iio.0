Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A659F2D0C98
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 13:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780667408; cv=none; b=NQHwHfC+sBgCRdTjmxqhhaHixwILW3r4XoDF2Z+M1jXFcV9Nr/RsW6AbTNI5p8Miq3Xbb62QEzo4y5qk1kMyOfqLGs92PLR8cbydA/iKh2TZvcNZcUUlfQ4ITWFpAJkQQ2qM3iBmFlAPDWFzWjgMxPMhoNAJsvzcZP3dAWPF6FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780667408; c=relaxed/simple;
	bh=If8y4OIypP9qQMxGV8Wyw4/8nNiu2y9DZ3Aw/vauXrM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjYVolQu7RM1CnzYfcTbhyp2zJjKU7/8Nt8OIBW33VrRWhZaksZWiKTR+BY5wZjlNyLSUEu6a3YKFIT81mWlGegQvxv6ZbHvpQWJATRFQ3vdcyqnK0xTgWgCKh8m7p2ceeMMWPExwpFHPjfRBhoBAgxtJ8iHQuR0qFt0y+vlU/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=afPw9Bza; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="afPw9Bza"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCD8F1F00893;
	Fri,  5 Jun 2026 13:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780667407;
	bh=fJ4icNC+sMkP4L2M82exW7C56xk+1tyCALeG/p8AlHM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=afPw9BzaAnBItTxtykxgwXbFLYzfqJM6djXM3O6Co7T/oop+X91Coug69pfNqy6va
	 gJ73s6FjwXkJL7EZjzsF7LlG9w6wuYGY3W3CKz+XXQ9TRzIg8FoOJtoFk6LhKIvYg1
	 53hNlP2p+To7es38S2z/GL1j+OAPjClwsOwD/UtjmPWInWQlBw53EbAMlIhMEk7vSU
	 Swyu29y6UghWkt5UtEgNzZBERmf+Ay1nY8yscNSZv5rX3WhCVcs1eZZX5hekT6Qs1a
	 BAXtbs9eXYDrfdM4gcZQa/ZjQT/vL6c6A+n0DdkJ5MQeLcOtrqGVm1ggoGqRWJRjdh
	 gf2bXTXD3s0RQ==
Date: Fri, 5 Jun 2026 14:50:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-iio@vger.kernel.org, Jinseob Kim <kimjinseob88@gmail.com>, Joshua
 Crofts <joshua.crofts1@gmail.com>, Sanjay Chitroda
 <sanjayembeddedse@gmail.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 sashiko-bot@kernel.org
Subject: Re: [PATCH v2] iio: buffer: Ensure bounce buffer used for unaligned
 case is zeroed.
Message-ID: <20260605145000.0ae0356e@jic23-huawei>
In-Reply-To: <aiFBEn_DKx5f6ekv@ashevche-desk.local>
References: <20260604084307.640053-1-jic23@kernel.org>
	<aiFBEn_DKx5f6ekv@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Jun 2026 12:10:42 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Jun 04, 2026 at 09:43:07AM +0100, Jonathan Cameron wrote:
> > iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
> > to userspace if the data passed in is not a multiple of 8 bytes and the
> > timestamp is enabled.  Use memset() to zero it after resizing.  
> 
> ...
> 
> >  				   indio_dev->scan_bytes, GFP_KERNEL);
> >  		if (!bb)
> >  			return -ENOMEM;
> > +		memset(bb, 0, indio_dev->scan_bytes);  
> 
> May I suggest different approach, id est use __GFP_ZERO instead of hunting
> correct pointers?

That's a weird beast when combined with a krealloc so I was a bit
nervous about readability (and less so whether it was correct).
It should be fine in that we will either get stale data or zeros
because we always use this path to allocate the buffer so if you
think it is obviously fine then I don't mind.

The oddities are that if an object grows within a slab but doesn't need
a new one we are relying on those bits happening to be zero based on the
original allocation doing __GFP_ZERO as well (as it's the same call)

I'm nervous though as that region off the end is sometimes used for
debug objects and I really don't understand that bit of slab well enough.
If it actually does this, then seems like we'd end up with a lot of
nasty corner cases so I assume it doesn't.  However, I couldn't convince
myself enough not to just force a memset of the whole thing.

> 
> With Best Regards,
> Andy Shevchenko
> 
> 
> 

