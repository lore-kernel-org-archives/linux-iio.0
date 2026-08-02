Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A74A1D9A5F;
	Sun,  2 Aug 2026 02:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785636642; cv=none; b=crX/iub5FTRSs6CMrKd2sFkl0dS++DGzqA1/XBj+Was4gF6FN9hs87VIbgsZsXslpuU5mo7rnLLF5XzqL3+oktUTwbbSrUgK1KUEJl2hCAaZO7MFJvhLh9q5wFwUpbHe0lYb9vGn1TFwy7LbRXFkGbk0Jo1bjtfvQWT6b2lJHpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785636642; c=relaxed/simple;
	bh=WK/bQFymBKT5nLKpkNZsb/slBuSlyxpCwmWLD1LRyJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qFwqs7lsJr2XydZSWcwwXDePfzfRry6n+3Y+hpVnDMglYf3SHakPD5xIUsLyFPkLyTqVq8zAJvH4LmbKjbnyrCxm6T6BN+uZh9C5OACOBF98ZuSjOpehSf13RxcVULXMgwau7LTYyOGC8cMS8cj4oeySfKbAUwo+1cp3IlmFz5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYr7KOd8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYr7KOd8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 745AB1F00AC4;
	Sun,  2 Aug 2026 02:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785636641;
	bh=9qqumEo+SHN2ME3TFpetYvYiwnFA/K2LXuyraC/CEU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MYr7KOd8QK4s6LbhUIFwSh6CwT0ylXDnNK+En54LaP7hizr9iEwu3JXMPHNzpMk6O
	 C3TwiOLPRFB9HXt5/WbLoS+RFI2U/sahc7MhOuWgU0hXDQb4LuFKXOSjka2GNtbp0s
	 aRgA+7U4tW5uR5hvNRDP0Aczxjj2esvoAUOITh80sUVjgIKx2Rfd0ePcFNcvu+i4Pg
	 gF7XJRbE581SDQETRQQcFIP8yRSTGaLMXm2AfJ9QaTQabg6URSXwFz6BQnVE2t18Tv
	 nsS0graypmexgH8cQp4AR8U+wb2qpnZUyoKQDQC7OqDYJyfBd7X9qdGDwPQg9RKJhQ
	 JjyeF4vb3HFtg==
Date: Sun, 2 Aug 2026 03:10:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marco Chen <marcochen.dev@gmail.com>, nuno.sa@analog.com,
 andy@kernel.org, pmeerw@pmeerw.net, matt@ranostay.sg,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v1] iio: health: max30102: fix NULL dereference in
 interrupt handler
Message-ID: <20260802031035.6eb2be14@jic23-huawei>
In-Reply-To: <aca9bdb5-f068-491f-a651-d24a80a2786e@baylibre.com>
References: <20260731184124.112124-1-marcochen.dev@gmail.com>
	<aca9bdb5-f068-491f-a651-d24a80a2786e@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 1 Aug 2026 10:18:42 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 7/31/26 1:41 PM, Marco Chen wrote:
> > The interrupt is requested in max30102_probe() and stays enabled  
> 
> I've always wondered why most IIO drivers seem to do this. It seems to
> me that requesting the irq with IRQF_NO_AUTOEN and only enabling it
> when everything is set up for reading data would avoid spurious interrupts
> like this.

It teaches discipline.  More serious from what I recall the no autoen thing
used to be done via a racey bit of trying to turn it off as fast as you can.

Most of the time we should be able to write drivers that don't need to
use that flag and don't touch enable_irq() at all.

Obviously that's not always true.

> 
> > for the lifetime of the device, but indio_dev->active_scan_mask is only
> > valid while a buffer is enabled. When an interrupt arrives while no
> > buffer is enabled, the handler dereferences the NULL active_scan_mask:
> > 
> >   Unable to handle kernel NULL pointer dereference at virtual address 
> > 0000000000000000
> >   pc : __bitmap_weight+0x64/0x98
> >   lr : max30102_interrupt_handler+0x48/0x160 [max30102]
> >   Call trace:
> >    __bitmap_weight+0x64/0x98 (P)
> >    max30102_interrupt_handler+0x48/0x160 [max30102]
> >    irq_thread_fn+0x28/0xa8
> >    irq_thread+0x184/0x30c
> >    kthread+0x118/0x124
> >    ret_from_fork+0x10/0x20
> > 
> > Return early when no buffer is enabled. The interrupt status register is
> > read before returning, since reading it deasserts the chip's active-low
> > interrupt pin. Otherwise the pin would stay asserted and no further
> > edges would be delivered.
> > 
> > Fixes: 90579b69e94b ("iio: health: max30102: Add MAX30105 support")
> > Signed-off-by: Marco Chen <marcochen.dev@gmail.com>
> > ---
> > I ran into this while interfacing with the MAX30102 over I2C on a
> > Raspberry Pi 4 running the IIO subsystem tree testing branch and
> > learning the IIO sysfs interface for the first time. When physically
> > rearranging INT pin wiring with no buffer enabled, the kernel oopsed.  
> 
> This is one of the reasons why you are supposed to turn off power before
> moving wires. ;-)
> 
> > This happened because max30102_interrupt_handler() attempted to
> > dereference active_scan_mask, which is NULL because no buffer is
> > enabled. With this patch, the same situation no longer oopses
> > and the buffered capture was tested to work normally afterward.
> > 
> > Some things I am unsure about though:
> > - Is IRQ_HANDLED or IRQ_NONE preferred here? I chose IRQ_HANDLED 
> >   because of the status register read to deassert the INT pin, but 
> >   I am not 100% confident on this choice.  
> 
> IRQ_NONE would cause the handler to just run again as soon as it
> exits, so it is almost never the right value to return. IRQ_HANDLED
> is correct.

This is always a fun debate.  If you do return IRQ_NONE you will enter
the handler again, but not for long.  The spurious interrupt detection
code kicks in and disables the interrupt with a nice loud splat.
That may or may not be appropriate.

> 
> > - Should the regmap_read() return value be checked? I did not add a 
> >   check because I do not see a useful recovery path from this I2C failure, 
> >   but I can add a check in a v2 if it is better.  
> 
> There isn't anything we could do other than log the error.
> 
> 
> > Thank you.
> > 
> > drivers/iio/health/max30102.c | 17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
> > index c37316c86f14..c30b029ba8aa 100644
> > --- a/drivers/iio/health/max30102.c
> > +++ b/drivers/iio/health/max30102.c
> > @@ -290,10 +290,23 @@ static irqreturn_t max30102_interrupt_handler(int irq, void *private)
> >  {
> >  	struct iio_dev *indio_dev = private;
> >  	struct max30102_data *data = iio_priv(indio_dev);
> > -	unsigned int measurements = bitmap_weight(indio_dev->active_scan_mask,
> > -						  iio_get_masklength(indio_dev));
> > +	unsigned int measurements, val;
> >  	int ret, cnt = 0;
> >  
> > +	if (!indio_dev->active_scan_mask) {
> > +		/*
> > +		 * No buffer is enabled so there is nothing to read. Read the
> > +		 * status register anyway to deassert the max30102's interrupt
> > +		 * pin; otherwise it would stay asserted and further edges
> > +		 * would not be delivered.
> > +		 */
> > +		regmap_read(data->regmap, MAX30102_REG_INT_STATUS, &val);
> > +		return IRQ_HANDLED;
> > +	}
> > +
> > +	measurements = bitmap_weight(indio_dev->active_scan_mask,
> > +				     iio_get_masklength(indio_dev));
> > +
> >  	mutex_lock(&data->lock);
> >  
> >  	while (cnt || (cnt = max30102_fifo_count(data)) > 0) {  
> 
> 

