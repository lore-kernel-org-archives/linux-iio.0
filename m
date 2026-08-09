Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43622E401;
	Sun,  9 Aug 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786317539; cv=none; b=LMgC1finbMZRem5JRX0mYaF2n9xo782UKN5dc4j1GCaSsMM7jik7odHtm0otoIqUp1uWaI4WjTEVSzdTOlVrthpzFer7TenNEhbvQD6sHNvW9O8Aa8SpMOsJ5wdyE4IlcGgwI8/1XoJRGNOw7bsGZPxtQYAD3CIUuAE/RzKpGNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786317539; c=relaxed/simple;
	bh=qoOBhhHcHtV5XcQ5ydDCNWcZWW8+WFZv1FXAOGl1hdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIaS8V0AeLAiG2L72Tkz/8vy/CTFUZG5f/QMUZTMfj/6Ad/W1+ZdPgJAn2yFhvHOoJeIpzPXKTJ4xNORk5vSQgPOyrTn12KyafqMo2CrRhNhHro6CxLVl/j/OLp2EW9Q6LoCu7qTVv6GyK7tTS3SIgz6Pb3sNkJrhPjVzsjntEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mOlK2Xwt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mOlK2Xwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F68B1F000E9;
	Sun,  9 Aug 2026 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786317537;
	bh=dNlxyD0tnvIXGCgSg0Bg9MSA4aZ7eLd8BBO2V6oGo2Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mOlK2XwtVxSJu8YRWPrlXIpkS+JH1p0DOYGlKxOvJSKlG0oLeea3XCWzLK9O6a88B
	 K9UIGaRrXjGTWCVi3FNv41v7eCO4Wn0pX0fV/8CVSxxhSgXK9TOn/wK+oWMWfuARs8
	 XfkGWOT/UGlJcDAIgT7HCe1QhFCq0kfmzcSkpZBt4jz2EIQYuQuqjeEaYMOlE/ytFn
	 BCxCqAhXhIA9soVWH2PAsB7rU4BEL05yqo55FE8gdH4W+UgM+uE2s8EuC/+DFSk5jn
	 zcVx4RXZPYbpiGncOIrPjwGyHeRj1JaVKB9vqCzjsXzlmNHXY4tOLPDBPhKVjMv33w
	 Q7gDYsZ9LBRYA==
Date: Mon, 10 Aug 2026 00:18:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Yash Suthar <yashsuthar983@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: bmc150: use IIO_DECLARE_BUFFER_WITH_TS
Message-ID: <20260810001852.6afc2c2e@jic23-huawei>
In-Reply-To: <20260809235934.6045eab8@jic23-huawei>
References: <20260808220236.421832-1-yashsuthar983@gmail.com>
	<20260809055442.434972-1-yashsuthar983@gmail.com>
	<20260809235934.6045eab8@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 9 Aug 2026 23:59:34 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sun,  9 Aug 2026 11:24:42 +0530
> Yash Suthar <yashsuthar983@gmail.com> wrote:
> 
> > Replace bmc150_accel_data plain buffer with IIO_DECLARE_BUFFER_WITH_TS()
> > that also keep timestamp aligned.
> > 
> > Fixes: bd7fe5b71918 ("iio: accel: BMC150 accel support")
> > Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>  
> 
> For future reference, please never reply to an existing thread with 
> a new version of a patch.  I'm a bit confused why this one keeps
> coming up as I'm not aware of any part of the kernel that requests
> doing it this way.  Reasons not to do this:
> 1) Confusing threads once they get sufficient numbers of replies, including
>    making it harder for tooling to work out what is going on.
> 2) Reviewers and maintainers tend to use mail clients that put replies
>    to old threads, somewhere back in history, so the chances of getting
>    a review is reduced.
> 
> Anyhow, don't resend existing patches to 'fix this' but make sure
> to do new threads, if you send out any new versions.
> 
> This looks fine to me so applied to the fixes-togreg branch of iio.git
> Note that branch will be rebased on rc1 once it is available.

Actually no. I've backed that out. 

Given the data alignment is fixed, if we were going to do this it would
be clearer as 
struct {
	s16 chans[3]; //see later, I believe this should be __le16
	aligned_s64 timestamp;
};

But that is very similar to the structure that follows immediately after
this, but that has __le16 chans[] 

So what is going on here?

bmc150_accel_trigger_handler() Does a bulk read into data->buffer (so the
array this patch is touching). That is then pushed to the buffers.
Note this should be DMA safe, so we need to ensure nothing shares cache
line with it that might be edited concurrently.

data->scan is used in __bmc150_accel_fifo_flush() by memcpying
from a local buffer into this to marshal data.

That local buffer isn't dma safe, so good to fix that as a separate issue.
The buffer is fairly small (32 x 3 x 2 bytes) so one choice would be to put an
aligned buffer at the end of the iio_priv() structure.  Anyhow, that's
a different issue.  

So we already have two very similar structures.  
The chan spec is little endian so the scan one is more correct.

So I think the fix for this issue is move the scan element to the end of
struct bmc150_accel_data and mark it with __aligned(IIO_DMA_MINALIGN);

Then use that for both the bmc150_accel_trigger_handler() and __bmc150_accel_fifo_flush()
paths.  A second fix will resolve the local buffer in __bmc150_accel_fifo_flush()
that is being used for a bulk regmap transfer that may need a dma safe buffer.

I'd place that after the moved scan element in struct bmc150_accel_data.
Do that change as a separate fix.  As we have two dma buffer issues in this
driver take a look for any other bulk regmap accesses that may have similar
problems!

Please combine these two fixes (if you agree with my analysis) with a
follow up to do the iio_push_to_buffers_with_ts() all in one series
as they will be touching the same code.

Jonathan



> 
> Thanks,
> 
> Jonathan
> 
> 
> 
> > ---
> > v2:
> > - Rewrap commit message.
> > - Add Fixes tag.
> > 
> >  drivers/iio/accel/bmc150-accel.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/accel/bmc150-accel.h b/drivers/iio/accel/bmc150-accel.h
> > index e8f26198359f..e0773533efeb 100644
> > --- a/drivers/iio/accel/bmc150-accel.h
> > +++ b/drivers/iio/accel/bmc150-accel.h
> > @@ -64,7 +64,7 @@ struct bmc150_accel_data {
> >  	struct bmc150_accel_trigger triggers[BMC150_ACCEL_TRIGGERS];
> >  	struct mutex mutex;
> >  	u8 fifo_mode, watermark;
> > -	s16 buffer[8];
> > +	IIO_DECLARE_BUFFER_WITH_TS(s16, buffer, 3);
> >  	/*
> >  	 * Ensure there is sufficient space and correct alignment for
> >  	 * the timestamp if enabled  
> 
> 

