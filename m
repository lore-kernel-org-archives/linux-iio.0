Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226F2175A9C;
	Sun,  2 Aug 2026 02:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785637576; cv=none; b=BDH548aNDIsxDX5C/7EMrIsL1LEuZkJ66RniA9psA26QrI6ZwHoMWyyhbIQygFNyJvE8f8RZwHl9dw1ipSstlJGTHrh3ts5In80to/VgmhMaeCM3uctuGEY+2zd8qtKjd7gjwdk/iEfgd8caSekdSKvqlqWpezVu+nrJXXiCVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785637576; c=relaxed/simple;
	bh=t83PiUU5L67t6yC5jSFJw7+S3kruWuqXalzBV6x0ktA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PsX/i57kIXeVLKENlVDa20O2ASdMjvVl5rooxeLOAMyMPImbiEpP69f0unLKKamLHZ6Y3oENt1gkBhQoQghiEdbdQh0sLqGyJaLQkwR1CISXMbYUjxLBu88LoL/FGJppUSoAKJ5/0mdIvtCK+GcgJmx/KdimTeRaVd8UGwLlOU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDLSKIqi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDLSKIqi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E99291F00AC4;
	Sun,  2 Aug 2026 02:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785637574;
	bh=G7NN/KGyWiYdHzPqO8yYtLLQhFcH1k/lBJq4oJMYoKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UDLSKIqigX3X1qAgixAnikmUjWAIID/zDuZCAJWosp14OdjCLT++qepihizKrbNrI
	 K/H+7RfHhZFQw4stpKvZJL46RI933+9tKGBdgchD6n0Br4fxpv9v9/nJW3rXDYCihE
	 0ZTFXSlNZ3/Hk/XdVFPYvFzdlBuvZjInkJtdOEfNYgBAO/R3foi2lYNgea8i79DbkH
	 MW+bIG0WaPvOw4B9LSlWWveMMA2irBIR4p39z2gCMFJ4D7eqO/DJdTAViYq8JtgnnG
	 5XUF/VB339lToBODHVwVcd8vT1AsvKuyxV4Tm14tExy4W6btBgP9tfxjrD3jTzFvrg
	 lmRO9Gl3HUSqQ==
Date: Sun, 2 Aug 2026 03:26:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marco Chen <marcochen.dev@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 pmeerw@pmeerw.net, matt@ranostay.sg, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260802032609.27900bb9@jic23-huawei>
In-Reply-To: <20260731184124.112124-1-marcochen.dev@gmail.com>
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 Jul 2026 14:41:23 -0400
Marco Chen <marcochen.dev@gmail.com> wrote:

> The interrupt is requested in max30102_probe() and stays enabled
> for the lifetime of the device, but indio_dev->active_scan_mask is only
> valid while a buffer is enabled. When an interrupt arrives while no
> buffer is enabled, the handler dereferences the NULL active_scan_mask:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 
> 0000000000000000
>   pc : __bitmap_weight+0x64/0x98
>   lr : max30102_interrupt_handler+0x48/0x160 [max30102]
>   Call trace:
>    __bitmap_weight+0x64/0x98 (P)
>    max30102_interrupt_handler+0x48/0x160 [max30102]
>    irq_thread_fn+0x28/0xa8
>    irq_thread+0x184/0x30c
>    kthread+0x118/0x124
>    ret_from_fork+0x10/0x20
> 
> Return early when no buffer is enabled. The interrupt status register is
> read before returning, since reading it deasserts the chip's active-low
> interrupt pin. Otherwise the pin would stay asserted and no further
> edges would be delivered.
> 
> Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
> Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
> ---
> I ran into this while interfacing with the MAX30102 over I2C on a
> Raspberry Pi 4 running the IIO subsystem tree testing branch and
> learning the IIO sysfs interface for the first time. When physically
> rearranging INT pin wiring with no buffer enabled, the kernel oopsed.
> This happened because max30102_interrupt_handler() attempted to
> dereference active_scan_mask, which is NULL because no buffer is
> enabled. With this patch, the same situation no longer oopses
> and the buffered capture was tested to work normally afterward.
> 
> Some things I am unsure about though:
> - Is IRQ_HANDLED or IRQ_NONE preferred here? I chose IRQ_HANDLED 
>   because of the status register read to deassert the INT pin, but 
>   I am not 100% confident on this choice.
> - Should the regmap_read() return value be checked? I did not add a 
>   check because I do not see a useful recovery path from this I2C failure, 
>   but I can add a check in a v2 if it is better.
> Thank you.
> 
> drivers/iio/health/max30102.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> index c37316c86f14..c30b029ba8aa 100644
> --- a/drivers/iio/health/max30102.c
> +++ b/drivers/iio/health/max30102.c
> @@ -290,10 +290,23 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
>  {
>  	struct iio_dev *indio_dev = private;
>  	struct max30102_data *data = iio_priv(indio_dev);
> -	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
> -						  iio_get_masklength(indio_dev));
> +	unsigned int measurements, val;
>  	int ret, cnt = 0;
>  
> +	if (!indio_dev->active_scan_mask) {

That is racy as this could be going on in parallel with the buffer being disabled
so we check here but it's gone before it is accessed.

It does protect against the spurious interrupt when the device isn't really in
use.

Hmm. I'm not sure what the right fix for this is or how much effort we put
into protecting against this level of things going wrong.

We could do a buffer mode claim, but then we'd need to do that in every
driver that touches active_scan_mask.  Also for that matter that pushes to
buffers as they can change at an time when buffered mode isn't in use.

> +		/*
> +		 * No buffer is enabled so there is nothing to read. Read the
> +		 * status register anyway to deassert the max30102's interrupt
> +		 * pin; otherwise it would stay asserted and further edges
> +		 * would not be delivered.
> +		 */
> +		regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);

That we should only do if we have any reason to believe it was set in the first
place. Did we check it?   Looks like we didn't.

Which leads me to suggest alternative fix - check INT_STATUS and if nothing
set it isn't our interrupt.  That doesn't get into the potential buffer
enabled / disabled races but should close your condition I think
- looks like it is read in the fifo part below. You may need to refactor a
little to not read it twice.

Jonathan

> +		return IRQ_HANDLED;
> +	}
> +
> +	measurements = bitmap_weight(indio_dev->active_scan_mask,
> +				     iio_get_masklength(indio_dev));
> +
>  	mutex_lock(&data->lock);
>  
>  	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {

