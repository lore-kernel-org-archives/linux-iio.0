Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64723264F1;
	Sat, 21 Mar 2026 20:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774125751; cv=none; b=VoAuQW7qB5S5UoM614fAbeyq+fk4GPzG6ln8084F5nlJH+LFaRWGXAQrL1nfYRPt/ftYBu7Kpo6ZjGCsR+YUf4wfIz/ZYrZ2cCQhjQzXAQOPNdGH74Mq5EAEvftGMgT7T2UISmgyGbcCFU0rbBMwzRd3+val4OH5AEWFZYPblHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774125751; c=relaxed/simple;
	bh=5+K73ScHo0RxRNHyDVOeAtv3nfCAvTdWBBYgQE14pF4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9/4zn0AkjWzlIsDq7zeOHi3jYc0tRsu0+95Uj0A5crbIhBNcesZCqksnbFT0zEaHylAlO5PdFMsY4hh/ocDLyShJ34aM4vWO7G4P/nkv7SkQmFSYNzmQ2ZJEbpYg966m0BBKxI8rWOYu6B6oow0eCz2tDD0/t2yw4nKSBPgBxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzHuuKTI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzHuuKTI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5963CC19421;
	Sat, 21 Mar 2026 20:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774125751;
	bh=5+K73ScHo0RxRNHyDVOeAtv3nfCAvTdWBBYgQE14pF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nzHuuKTItOvSlCgSPne/UcHcf5pP+0zB768U39hYDVRVg2uXpuLk722s7NBdJKQb0
	 pM7Uj5wcgWOQZIQoOx+msSYtY0ktRBesk6fXf4E9dDF5l+H/GVfZSNNpYJi5IzBTOM
	 6u1gS8rmrvTD8t8+k1p7d0gtcvuHAqVeKZ9ctvMp5otc6XEVMVVYPtZUM/0ocb9sop
	 TIODxHBJfRCkxq3poEr+ZtYyPJKreJPT8lgshYQADRVeHat++mp5S0VYchHrvcfndz
	 eGFS0ECS0ncQ1DJ0fFzX9IXfaGkUUSASTxlpcbGnyAfDgIQuwIi6BuBDPiYVqPfYTz
	 yivcOe+bHRCdQ==
Date: Sat, 21 Mar 2026 20:42:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Matt Ranostay
 <mranostay@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti-adc161s626: fix buffer read on
 big-endian
Message-ID: <20260321204223.68398b92@jic23-huawei>
In-Reply-To: <abgMCgp8JIUigQLq@ashevche-desk.local>
References: <20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-0-56243b11e87b@baylibre.com>
	<20260314-iio-adc-ti-adc161s626-fix-scan-buf-v1-1-56243b11e87b@baylibre.com>
	<abgMCgp8JIUigQLq@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Mar 2026 15:56:26 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Mar 14, 2026 at 06:13:31PM -0500, David Lechner wrote:
> > Rework ti_adc_trigger_handler() to properly handle data on big-endian
> > architectures. The scan data format is 16-bit CPU-endian, so we can't
> > cast it to a int * on big-endian and expect it to work. Instead, we
> > introduce a local int variable to read the data into, and then copy it
> > to the buffer.
> > 
> > Since the buffer isn't passed to any SPI functions, we don't need it to
> > be DMA-safe. So we can drop it from the driver data struct and just
> > use stack memory for the scan data.
> > 
> > Since there is only one data value (plus timestamp), we don't need an
> > array and can just declare a struct with the correct data type instead.
> > 
> > Also fix alignment of iio_get_time_ns() to ( while we are touching this.  
> 
> ...

I agree with Andy's comments, so applied with diff below.
Please sanity check this. Applied to the fixes-togreg branch of iio.git and marked
for stable.

Thanks,

J

diff --git a/drivers/iio/adc/ti-adc161s626.c b/drivers/iio/adc/ti-adc161s626.c
index 1d427548e0b3..42968d96572b 100644
--- a/drivers/iio/adc/ti-adc161s626.c
+++ b/drivers/iio/adc/ti-adc161s626.c
@@ -112,19 +112,20 @@ static irqreturn_t ti_adc_trigger_handler(int irq, void *private)
        struct iio_poll_func *pf = private;
        struct iio_dev *indio_dev = pf->indio_dev;
        struct ti_adc_data *data = iio_priv(indio_dev);
-       int ret, val;
        struct {
                s16 data;
                aligned_s64 timestamp;
        } scan = { };
+       int ret, val;
 
        ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);
-       if (!ret) {
-               scan.data = val;
-               iio_push_to_buffers_with_timestamp(indio_dev, &scan,
-                                                  iio_get_time_ns(indio_dev));
-       }
+       if (ret)
+               goto exit_notify_done;
+
+       scan.data = val;
+       iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
 
+ exit_notify_done:
        iio_trigger_notify_done(indio_dev->trig);
 
        return IRQ_HANDLED;

> 
> >  	struct iio_poll_func *pf = private;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct ti_adc_data *data = iio_priv(indio_dev);  
> 
> > +	int ret, val;  
> 
> Can this be put after the 'scan'?
> 
> > +	struct {
> > +		s16 data;
> > +		aligned_s64 timestamp;
> > +	} scan = { };
> > +
> > +	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);  
> 
> > +	if (!ret) {  
> 
> Personally I prefer goto approach over unusual pattern and TAB indentation.
> 
> > +		scan.data = val;
> > +		iio_push_to_buffers_with_timestamp(indio_dev, &scan,
> > +						   iio_get_time_ns(indio_dev));
> > +	}
> >  
> > +	ret = ti_adc_read_measurement(data, &indio_dev->channels[0], &val);  
> 
> 	if (ret)
> 		goto exit_notify_done;
> 
> 	scan.data = val;
> 	// Also can we consider moving towards new API?
> 	iio_push_to_buffers_with_timestamp(indio_dev, &scan, iio_get_time_ns(indio_dev));
> 
> exit_notify_done:
> 
> >  	iio_trigger_notify_done(indio_dev->trig);  
> 


