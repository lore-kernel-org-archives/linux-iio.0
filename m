Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B79125B0B7;
	Thu, 14 May 2026 15:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778773301; cv=none; b=hr38nL4sxlCPTSoLsf74RYOCpfVwqtIxOFd/EVspHi7FMZTMxt3PL5gTkHyKhTEaaeGcMH6B09hgzKAqvKT4gJTBA/aynXHVHzAUV+8gFsDdWUOyfOrrXZWy8EbDe6plMjA9kSl7rux/i24tASA9hXuEGlP5UZaKh9D/mSCE4YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778773301; c=relaxed/simple;
	bh=l/I4OW+DP3r+c/C9F3yLDoWt4IkW5vNZBEHIUy9fTK4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMTvkq05+QHzuQ1uZ037vvJR2kARjjsG/Se8X8LeCb3Rf9HAs++lAwGwgS3W/GFTx+AL5i36PdQ/hTHhjbYHtVpe1i/smcaSHjwHbpnu1Z6IoJxgpI+xz2dYROUnJSyUCWbzHkDNlP561kGDfacOXeT6Y8EF4mEawNoocK/pQpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEtBAXeo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEtBAXeo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F496C2BCB3;
	Thu, 14 May 2026 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778773301;
	bh=l/I4OW+DP3r+c/C9F3yLDoWt4IkW5vNZBEHIUy9fTK4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEtBAXeoNLqUEGokae36mkM25KLnyjUNEPH+VSV/tchzN4TL2JIUobt0cgi34bE2t
	 TWJNQhnhJYQEcZp609vloS5pl+kdhEzDFMr1t7XiWLGzvSvl7qjFussUCIcZhcPnoZ
	 HUE0wqLD4KwLdWx6OpZsaEl2ApO60b0E6WkXplqWWfikTRkQPxdMjvtDqFy06vl1mT
	 M4I1rt+V+VXMqeJmNjpeuel3R/cpCTs8Ei5q822DvD1bUVV7bbF03LyBXOYozz9734
	 nVxoGxcNz8HzaJLneX88EPzpNuRycYmoaQ5JsMuvtgJh4F5NJqxrvkaCfp4YK+AiVZ
	 Xx5pQHrnNWYCQ==
Date: Thu, 14 May 2026 16:41:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH] iio: iio_triggered_buffer_setup_ext(): request
 IRQF_ONESHOT only if threaded handler is present
Message-ID: <20260514164132.6545e492@jic23-huawei>
In-Reply-To: <20260514-iio-irq-fixes-v1-1-3bc28b094ad6@pengutronix.de>
References: <20260514-iio-irq-fixes-v1-1-3bc28b094ad6@pengutronix.de>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 14 May 2026 16:43:41 +0200
Marc Kleine-Budde <mkl@pengutronix.de> wrote:

> Since commit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT without a
> threaded handler") the kernel warns when requesting an IRQ using
> IRQF_ONESHOT without a threaded handler.
> 
> iio_triggered_buffer_setup_ext() always passes IRQF_ONESHOT to
> iio_alloc_pollfunc(), even if no threaded handler is given by the caller,
> which results in a kernel warning.
> 
> Fix this warning by only passing IRQF_ONESHOT if a threaded handler is
> given.
> 
> Fixes: 23f2d735a932 ("iio: Add helper function for initializing triggered buffers")
> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
> ---
> Hello,
Hi Marc,

Thanks for the report + patch.
> 
> I'm not sure if this is the correct fix, or if the
> stm32-adc.c/stm32-dfsdm-adc.c driver needs fixing.

Sounds like another case of what we had to fix for hid-sensors (and a few others
IIRC).

They should never have been using triggers in the first place for this path -
but now we have ABI we can't touch.  Note there are even comments saying that
the infrastructure registered is not used!

So we have to have do a small dance to ensure the sysfs files are still created
but without the need for the pollfunc setup etc.

https://lore.kernel.org/all/20260220224514.471348-1-srinivas.pandruvada@linux.intel.com/

It is in theory possible to have a case that needs the fix you have below
but that would not be using iio_pollfunc_store_time().
That being used without a thread is pretty much pointless as no one reads
the timestamp.

I took a look just at stm32_adc and things are more complex because in some
cases we should be registering a triggered buffer (with both top and bottom
half set) and in some cases we should not - but should be doing what we
did in the hid sensors.

Given I believe this is a harmless warning I'm not in a huge rush to fix it.
We need someone who has the time + hardware to test solutions as they
can be a bit fiddly.

Whilst the code you have here papers over the problem it's changing from
having an entirely correct warning to hiding that the code is wrong so
I'd rather not merge that.  I've rejected it as a proposed solution a couple
of times so far - and thought we were getting to the end of drivers that abused
this stuff :(  Seems not quite yet.

Jonathan

> 
> For iio_triggered_buffer_setup(), they both use iio_pollfunc_store_time()
> as the hard IRQ handler, but the stm32-adc.c in PIO mode and the
> stm32-dfsdm-adc.c always no threaded IRQ handler.
> 
> As iio_triggered_buffer_setup_ext() always uses IRQF_ONESHOT this triggers
> a warning since ommit aef30c8d569c ("genirq: Warn about using IRQF_ONESHOT
> without a threaded handler").
> 
> Another thing I noticed is that iio_pollfunc_store_time() returns
> IRQ_WAKE_THREAD, which should trigger yet another warning ("IRQ %d device
> %s returned IRQ_WAKE_THREAD but no thread function available.") if used
> without a IRQ thread. But I'm not using this subsystem right now, just
> stumbled over the new warning.
> ---
>  drivers/iio/buffer/industrialio-triggered-buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c b/drivers/iio/buffer/industrialio-triggered-buffer.c
> index 9bf75dee7ff8..40eea3a44724 100644
> --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> @@ -64,7 +64,7 @@ int iio_triggered_buffer_setup_ext(struct iio_dev *indio_dev,
>  
>  	indio_dev->pollfunc = iio_alloc_pollfunc(h,
>  						 thread,
> -						 IRQF_ONESHOT,
> +						 thread ? IRQF_ONESHOT : 0,
>  						 indio_dev,
>  						 "%s_consumer%d",
>  						 indio_dev->name,
> 
> ---
> base-commit: 86138b484d6367a57312f69af4ec958806c2673c
> change-id: 20260514-iio-irq-fixes-1485db263ac3
> 
> Best regards,
> --  
> Marc Kleine-Budde <mkl@pengutronix.de>
> 

