Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D429F361DBA;
	Sun, 17 May 2026 11:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779017468; cv=none; b=iO3FrWFV9VwtsYdCOa6AyAnzrm0zOYeCpbg/S9tTeRUqoUftaKIUzy+6qz/lksXGjhfopYLBG+uaGjEcFyuVEXiK/QeVKkVlzh5mtKskeihDine3LGV5AFBRHLewcbahMpEEzW8x5xp3VQCuxiaofzuocC68VViVllfo2hO48+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779017468; c=relaxed/simple;
	bh=WO8uXu6x7MUx0hTUSjc2zk7BrthCjLk4fddR5yAQSYs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WVG+cD22x+b5Unp26V/pncYBTPTyTRS47d0zYcXEn6Hv0foP+POQvvRiQ9SbjFewoUAcEF30jt3YMQd0NMOANbvXMqqshiV1K6MTC5DwFl43XDfb5+inuDS6vYmCQYXUVcCXpGHzPMBVSCTiz05cStM6BZJVbt3/rrx06SDTW9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SBM4hD+W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SBM4hD+W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC89EC2BCB0;
	Sun, 17 May 2026 11:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779017468;
	bh=WO8uXu6x7MUx0hTUSjc2zk7BrthCjLk4fddR5yAQSYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SBM4hD+WXeYp7ftQj2pL6gdBhgVXBj20BIgWukYzagU5+3JZBCeO7oi/eoeIaK2Cc
	 6hh3uJsFnhMBxCDM9tPtAQ3ZM6NriD+ePKrqIHGRo+tN8P+eaf1xec3EhEgsTNR6u4
	 uX7GtLGQZ/uae1vMVZw3Tra1ko6STv6q/01uKQycKRZD9lFDkiZMXHNDIq1XHDaZaL
	 oqF5KFstR4tZUKC7igVGbMae+kgZ4yqMbXUVj124nrMcg4k6pae/nf7wfMFaR6F1sk
	 mY+X2fMRZaOgbRjRoJUB6euYjk49gym55shVjsIy3cDo30db/vQWBfP/NOn9IMUJLX
	 8ZKZZgLoy+eRA==
Date: Sun, 17 May 2026 12:30:59 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, nuno.sa@analog.com, andy@kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iio: accel: adxl372: Add timestamp to FIFO data
Message-ID: <20260517123059.49570d36@jic23-huawei>
In-Reply-To: <54eca584-b749-4417-b37a-40c5513b0442@baylibre.com>
References: <20260510082556.3867-1-shofiqtest@gmail.com>
	<20260510082556.3867-2-shofiqtest@gmail.com>
	<54eca584-b749-4417-b37a-40c5513b0442@baylibre.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 May 2026 13:55:34 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/10/26 3:25 AM, Md Shofiqul Islam wrote:
> > The driver pushes FIFO samples using iio_push_to_buffers() which does
> > not attach a hardware timestamp to the data.  Add a scan buffer struct
> > with an aligned_s64 timestamp field to the driver state, capture a
> > single timestamp per IRQ with iio_get_time_ns(), and switch the FIFO
> > push loop to iio_push_to_buffers_with_timestamp().  The same timestamp
> > is reused for the event push call in the same handler, replacing the
> > duplicate iio_get_time_ns() invocation there.
> > 
> > Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
> > ---
> >  drivers/iio/accel/adxl372.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/adxl372.c b/drivers/iio/accel/adxl372.c
> > index 545a21e5a3..521e8313b1 100644
> > --- a/drivers/iio/accel/adxl372.c
> > +++ b/drivers/iio/accel/adxl372.c
> > @@ -367,6 +367,10 @@ struct adxl372_state {
> >  	u16				watermark;  
> 
> 
> >  	__be16				fifo_buf[ADXL372_FIFO_SIZE];  
> 
> I would just change this line to:
> 
> 	IIO_DECLARE_BUFFER_WITH_TS(__be16, fifo_buf, ADXL372_FIFO_SIZE);

Doesn't work as timestamps are per sample and that's buffering the whole fifo.

Anyhow, fifo timestamps are hard to do and this is no where near
doing it right.  Far as I'm concerned this series is dead because that complexity
isn't worth doing unless we have a user needing it and I don't think we do
yet.

Jonathan


> 
> >  	bool				peak_fifo_mode_en;
> > +	struct {
> > +		__be16 channels[3];
> > +		aligned_s64 ts;
> > +	} scan;  
> 
> Then we don't need the extra struct and memcpy().
> 
> If we really do need the memcpy() for some reason, this struct
> can be declared on the stack instead of here.
Stack might indeed work..
> 
> >  	struct mutex			threshold_m; /* lock for threshold */
> >  };
> >  
> > @@ -703,13 +707,15 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> >  	struct adxl372_state *st = iio_priv(indio_dev);
> >  	u8 status1, status2;
> >  	u16 fifo_entries;
> > +	s64 ts;
> >  	int i, ret;
> >  
> >  	ret = adxl372_get_status(st, &status1, &status2, &fifo_entries);
> >  	if (ret < 0)
> >  		goto err;
> >  
> > -	adxl372_push_event(indio_dev, iio_get_time_ns(indio_dev), status2);
> > +	ts = iio_get_time_ns(indio_dev);
> > +	adxl372_push_event(indio_dev, ts, status2);
> >  
> >  	if (st->fifo_mode != ADXL372_FIFO_BYPASSED &&
> >  	    ADXL372_STATUS_1_FIFO_FULL(status1)) {
> > @@ -733,7 +739,10 @@ static irqreturn_t adxl372_trigger_handler(int irq, void  *p)
> >  			/* filter peak detection data */
> >  			if (st->peak_fifo_mode_en)
> >  				adxl372_arrange_axis_data(st, &st->fifo_buf[i]);
> > -			iio_push_to_buffers(indio_dev, &st->fifo_buf[i]);
> > +			memcpy(st->scan.channels, &st->fifo_buf[i],
> > +			       st->fifo_set_size * sizeof(__be16));
> > +			iio_push_to_buffers_with_timestamp(indio_dev,
> > +							   &st->scan, ts);
> >  		}
> >  	}
> >  err:  
> 

