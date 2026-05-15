Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFEB3F888E;
	Fri, 15 May 2026 18:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868326; cv=none; b=n67EGnMNEPlq6Fmxy4EciWvy8MQKW71NACbV9yG0rDzhnFphXpNb/Y/2xZ5tKi7ZPk7DPOlrr7H11WNXC2HwkyvJJRtuegKV1aF3Df4s+V3Z1OHKKJUExDR+mKGGjjdFnCt4II3Qb9kEYLJ2Vqt1ldI4SW91N0BQbLzJg7MAWS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868326; c=relaxed/simple;
	bh=d5l/VkeecglR6TIeIXinOw0xNpY6ct5m/0uqgEPv3II=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/vkledGhYvsrHHggHywrUyQr9H6QhgEipgeEkE+85LIk4bLEM+w9pAaz0c8+p+N3wuxQR3QO6ChNY//FMjn4cOefnwa+FvgwSpO4uhlVUXOb9ecbjlMO2ZRvCn6CXoTqZYuSj/cxjIZrpJmjqt4MIoiyBqppjBrehfueWXT6Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4IhUQKi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4IhUQKi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B96C2BCB0;
	Fri, 15 May 2026 18:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778868326;
	bh=d5l/VkeecglR6TIeIXinOw0xNpY6ct5m/0uqgEPv3II=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=E4IhUQKiRcAptbpLifMgoBXpz0Jmhm3MaVswxTBnJdrLUVeP8vXCxOlKi8aqxRnl4
	 CmalTDkSoO33WdEherKLJm9S+tZvA/NYmkXOuny+8w5hBbaU6BOnbQiVWyw++Sktoq
	 v0QmydbdXIuBBrGC9fu+d7f+RlfhrhllkW1S7IgOb7nooSsXv+gzr/C8KABt397nsk
	 LH5um7Lq2DwTnbG9q2peEUlKePRW7k/3l/ksMrO9t57v0ZTM6bTDgdZ5AM/J4tOMBN
	 eRnHxcOSRQgmY4Ai1YFJ3iFzewftzDK+FH3qEZRILhVINJGJHiDEdPmGfj+mp0yl/h
	 vNsL6nGT7rhqQ==
Date: Fri, 15 May 2026 19:05:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Aldo Conte <aldocontelk@gmail.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2 5/5] iio: light: tcs3472: move standalone return to
 default case
Message-ID: <20260515190517.70bb0ba5@jic23-huawei>
In-Reply-To: <agS70Dph8-zQT-e6@ashevche-desk.local>
References: <20260512223215.25596-1-aldocontelk@gmail.com>
	<20260512223215.25596-6-aldocontelk@gmail.com>
	<agRfMWL9BughLT2x@ashevche-desk.local>
	<36ed59a7-8af7-4458-9e90-70ea251b389e@gmail.com>
	<agS70Dph8-zQT-e6@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 May 2026 20:58:40 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Wed, May 13, 2026 at 06:12:25PM +0200, Aldo Conte wrote:
> > On 5/13/26 13:23, Andy Shevchenko wrote:  
> > > On Wed, May 13, 2026 at 12:32:15AM +0200, Aldo Conte wrote:  
> 
> ...
> 
> > Thanks for the review. Before I send v3, I want to make sure I split
> > the series the way you want.
> > 
> > My plan is to split v2 into 7 patches:
> > 
> >   1. sort headers (same as v2)
> >   2. convert locking to guard(mutex) (drop Suggested-by, clean up
> >      trigger_handler)
> >   3. replace == NULL with ! (add Suggested-by: Joshua Crofts)
> >   4. use devm for resource management (drop Suggested-by, remove the
> >      dev_info change, add devm_mutex_init)
I made a few suggestions in reply to that patch on stuff to move out
of it etc.

> >   5. use 'dev' for dev_info() calls (new, taken out of patch 4)
> >   6. implement wait time and sampling_frequency (drop Suggested-by,
> >      fix macro style, simplify cycle_us and all the other revisions)
> >   7. move standalone return to default case (same as v2)  
> 
> (Also collect tags for the patches that are not [drastically] changed, like #7
>  here.)
> 
> > Two things I am not sure about:
> > 
> >   - Should patch 3 ("replace == NULL with !") really be its own patch,
> >     or do you prefer it inside patch 4, since that line is right next
> >     to devm_iio_device_alloc?  
> 
> Jonathan is okay to combine in some cases, but I'm not sure if this is small
> enough. Ask him?

Slight preference for a separate patch - or just skip it.  There are lots
more things that could be tidied up in this driver I think. You don't have
to do them all!

> 
> >   - Is patch 5 (dev_info refactor) in the right place after the devm
> >     patch?  
> 
> Basically sort patches by severity, with this in mind seems you suggested
> the right order.

I would add for this that, to reduce churn it's fine to add the
struct device *dev = ... bit and use it in new devm calls. Just do the
remainder in the follow on commit.

> 
> 

