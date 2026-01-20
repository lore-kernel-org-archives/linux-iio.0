Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA113E95B6
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 23:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768950583; cv=none; b=vEfQwRNRtN9L/+zQzS7XuF0l87O/LEZbskc0HWND/f98r/y75c0IdxvYmQeRLLnSNNnnCHUaJwLzbzvHld8gQdvJPW4v+zcsLIHs2tynCS5WEOsty4zk6qcqnrYyX0ZPX+pi+EXp5ivjsxoczhB/0g2ZQAEEqPTJv8NiQYkl514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768950583; c=relaxed/simple;
	bh=wf8rbGI+BwbHr/v/eiWQcTcvQ/wwgyk84RiXzn6snfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ksIhLHQtJ4DqGaJ1MkRD33P9A1ppN/2mrC8HhhpB6/j65GJLjwTO2iu+kLzejX2ab4CSbLQULGSH9QPRyaWk6lmkPI/xiF3DoygqEjsNT7EBYu38Y43gE55myGHLGOoFooxlWmHdfus4gxo0+/V1eNLD5B4FnPRvAiDE73IpANQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NhXwUOUl; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NhXwUOUl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 935ADC2033B;
	Tue, 20 Jan 2026 23:09:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9814A606AB;
	Tue, 20 Jan 2026 23:09:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 349F6119B01E4;
	Wed, 21 Jan 2026 00:09:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1768950578; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=cSo/CbqltJypUPT2B2N/y5DKktBTma9cQloHLapKu3w=;
	b=NhXwUOUlvNM+TXjjrVeqLAyJiF0bcho6nG2+/ry4NlCvX7OxPuv6dUgZdc8wHd1D1UEa1L
	cKLHmjK+sLkrIQ1/o9NuB295+WS+ZXKs+sZ6/N0NHefTsU4KjipwlKMxKWhCpedzsRvCfQ
	ffnjUz4OWqSn1gk2UYqBZBpyXatzC9DFRJ0FFIWlt+rKT4Sodmn/6QIoDoBBU1ZymlEPmO
	BONckFfmBFvqkhLgAY2e29Znhf64SsxTtOnGdpBHGH+eXb26DTSS4STcEKyeZINsTSZOKK
	keX33AsEu5rx9ZXogqfkv28JeIOFrtuxQf/KqnpwLeC382sXTbNsLzwdjUCGGA==
Date: Wed, 21 Jan 2026 00:09:35 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	jorge.marques@analog.com, Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ad4062: Switch from struct i3c_priv_xfer to
 struct i3c_xfer
Message-ID: <202601202309350bdc5dd6@mail.local>
References: <20260119213617.745603-1-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119213617.745603-1-jic23@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

On 19/01/2026 21:36:17+0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> commit 9904232ae30bc ("i3c: drop i3c_priv_xfer and i3c_device_do_priv_xfers()")
> currently in the i3c/for-next tree removes the deprecated
> struct i3c_priv_xfer and i3c_device_do_priv_xfers().
> 
> Switch to struct i3c_xfer and i3c_device_do_xfers(..., I3C_SDR)
> now rather causing a build issue when both trees are merged.
> 
> Suggested-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: jorge.marques@analog.com
> ---
> I'm already carrying this on my tree to resolve the issue in next
> but feedback still welcome!

This looks fine to me, I'm sorry this patch is causing you so much
troubles, I was pretty sure every drivers where converted so I took me a
while to understand that this is actually a new driver, I didn't expect
this!

> ---
>  drivers/iio/adc/ad4062.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad4062.c b/drivers/iio/adc/ad4062.c
> index a6b3ccc98acf..dd4ad32aa6f5 100644
> --- a/drivers/iio/adc/ad4062.c
> +++ b/drivers/iio/adc/ad4062.c
> @@ -468,13 +468,13 @@ static int ad4062_set_operation_mode(struct ad4062_state *st,
>  
>  	if (mode == AD4062_MONITOR_MODE) {
>  		/* Change address pointer to enter monitor mode */
> -		struct i3c_priv_xfer xfer_trigger = {
> +		struct i3c_xfer xfer_trigger = {
>  			.data.out = &st->conv_addr,
>  			.len = sizeof(st->conv_addr),
>  			.rnw = false,
>  		};
>  		st->conv_addr = AD4062_REG_CONV_TRIGGER_32BITS;
> -		return i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
> +		return i3c_device_do_xfers(st->i3cdev, &xfer_trigger, 1, I3C_SDR);
>  	}
>  
>  	return regmap_write(st->regmap, AD4062_REG_MODE_SET,
> @@ -607,18 +607,18 @@ static void ad4062_trigger_work(struct work_struct *work)
>  	 * Read current conversion, if at reg CONV_READ, stop bit triggers
>  	 * next sample and does not need writing the address.
>  	 */
> -	struct i3c_priv_xfer xfer_sample = {
> +	struct i3c_xfer xfer_sample = {
>  		.data.in = &st->buf.be32,
>  		.len = st->conv_sizeof,
>  		.rnw = true,
>  	};
> -	struct i3c_priv_xfer xfer_trigger = {
> +	struct i3c_xfer xfer_trigger = {
>  		.data.out = &st->conv_addr,
>  		.len = sizeof(st->conv_addr),
>  		.rnw = false,
>  	};
>  
> -	ret = i3c_device_do_priv_xfers(st->i3cdev, &xfer_sample, 1);
> +	ret = i3c_device_do_xfers(st->i3cdev, &xfer_sample, 1, I3C_SDR);
>  	if (ret)
>  		return;
>  
> @@ -627,7 +627,7 @@ static void ad4062_trigger_work(struct work_struct *work)
>  	if (st->gpo_irq[1])
>  		return;
>  
> -	i3c_device_do_priv_xfers(st->i3cdev, &xfer_trigger, 1);
> +	i3c_device_do_xfers(st->i3cdev, &xfer_trigger, 1, I3C_SDR);
>  }
>  
>  static irqreturn_t ad4062_poll_handler(int irq, void *p)
> @@ -852,12 +852,12 @@ static int ad4062_set_chan_calibscale(struct ad4062_state *st, int gain_int,
>  static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
>  {
>  	struct i3c_device *i3cdev = st->i3cdev;
> -	struct i3c_priv_xfer xfer_trigger = {
> +	struct i3c_xfer xfer_trigger = {
>  		.data.out = &st->conv_addr,
>  		.len = sizeof(st->conv_addr),
>  		.rnw = false,
>  	};
> -	struct i3c_priv_xfer xfer_sample = {
> +	struct i3c_xfer xfer_sample = {
>  		.data.in = &st->buf.be32,
>  		.len = sizeof(st->buf.be32),
>  		.rnw = true,
> @@ -876,7 +876,7 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
>  	reinit_completion(&st->completion);
>  	/* Change address pointer to trigger conversion */
>  	st->conv_addr = AD4062_REG_CONV_TRIGGER_32BITS;
> -	ret = i3c_device_do_priv_xfers(i3cdev, &xfer_trigger, 1);
> +	ret = i3c_device_do_xfers(i3cdev, &xfer_trigger, 1, I3C_SDR);
>  	if (ret)
>  		return ret;
>  	/*
> @@ -888,7 +888,7 @@ static int ad4062_read_chan_raw(struct ad4062_state *st, int *val)
>  	if (!ret)
>  		return -ETIMEDOUT;
>  
> -	ret = i3c_device_do_priv_xfers(i3cdev, &xfer_sample, 1);
> +	ret = i3c_device_do_xfers(i3cdev, &xfer_sample, 1, I3C_SDR);
>  	if (ret)
>  		return ret;
>  	*val = be32_to_cpu(st->buf.be32);
> @@ -1236,7 +1236,7 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
>  	st->conv_sizeof = ad4062_sizeof_storagebits(st);
>  	st->conv_addr = ad4062_get_conv_addr(st, st->conv_sizeof);
>  	/* CONV_READ requires read to trigger first sample. */
> -	struct i3c_priv_xfer xfer_sample[2] = {
> +	struct i3c_xfer xfer_sample[2] = {
>  		{
>  			.data.out = &st->conv_addr,
>  			.len = sizeof(st->conv_addr),
> @@ -1249,8 +1249,8 @@ static int pm_ad4062_triggered_buffer_postenable(struct ad4062_state *st)
>  		}
>  	};
>  
> -	return i3c_device_do_priv_xfers(st->i3cdev, xfer_sample,
> -					st->gpo_irq[1] ? 2 : 1);
> +	return i3c_device_do_xfers(st->i3cdev, xfer_sample,
> +				   st->gpo_irq[1] ? 2 : 1, I3C_SDR);
>  }
>  
>  static int ad4062_triggered_buffer_postenable(struct iio_dev *indio_dev)
> -- 
> 2.52.0
> 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
