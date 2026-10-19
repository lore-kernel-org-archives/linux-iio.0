Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02C43603EE;
	Mon, 19 Oct 2026 03:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379016; cv=none; b=M8BbKI0t2Tz7+mOp7Hg1Np6TsHTLnItvnsCC39hnSYlUF9zWtrIXvyXEoGS2GvnOJ3tIec6IAMmBHunPI27bLLKbo96vezJEBaeWv/iT3YzIO9KXaAYYxLMMnfd4OIiwC05ueLaOTm8WsdJ3h/cKXGNHQ6gW9nfvAWmGtZ4Tz3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379016; c=relaxed/simple;
	bh=sexkzFM3JZ1Peqq8W/WpCxzxZWrmYhPDtG/c0xCnR28=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hRX1pOSGBgenQ802tDyfQKAZmRaW+9RVPInWO09vzkb+omeKAiNnCH92BNHCBU6AbMpcfC1pKtswVleLcqY/lGRRB3PaD1/59ULwmjLSMxDO1oC1t0ttmn7w7OHvKvWihRU03o+UdjEaYyXplxtm4rJCU+CGGogxYSnSH3q529A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNc/rMlP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNc/rMlP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0DA1F000C4;
	Mon, 19 Oct 2026 03:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379014;
	bh=IZomjIC98SGl6EP6Hus+ST7xnILmx9sFkWMwhPpB6N0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QNc/rMlPH84Aw4ZQOyew6p6TL7ptvYoV/GcKtuKEPf9yI72Z0laFvPGYp968dcsj8
	 KYtbDm66OPAy7RR8C6LKGp/q5+VVEZmTdIQrcHvFtMiF2/tlF/4bNO3w/yrtkmE2Oi
	 4h6LiX51JYZXiiFZrLF4+lkEqRJ0xrWWDJLOQj33iPJPEjq2QZG9hrMdIbTq0yuV8d
	 si+S6xDnkbfofT2NvT1DL6TtD980vQzorW9Koc1rIwlUE36AsczFNWAq4LUlat8xof
	 05KykAvz17EujSLQxcmuLkHO3MHrYlCf+KI68N1Zg5tbDDh+bqUoSjaXYsIcZo9ByM
	 cVq2HZA1EYrjw==
Date: Mon, 19 Oct 2026 04:03:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-iio@vger.kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: gp2ap020a00f: use
 iio_trigger_poll_nested()
Message-ID: <20261019040328.20bc809a@jic23-hlaptop>
In-Reply-To: <20260823192101.3991611e@jic23-huawei>
References: <20260822024654.315309-1-fanwu01@zju.edu.cn>
	<20260823192101.3991611e@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 19:21:01 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 22 Aug 2026 02:46:54 +0000
> Fan Wu <fanwu01@zju.edu.cn> wrote:
> 
> > The threaded IRQ handler queues an irq_work only so that
> > iio_trigger_poll() can run from a hardirq-like context. The driver's
> > own buffer consumer does not need that context: the only thing the
> > pollfunc top half, iio_pollfunc_store_time(), does is store a timestamp
> > in pf->timestamp, and deferring through the per-CPU irq_work queue
> > moves that timestamp further away from the actual event. Whilst in
> > theory there can be other consumers of this trigger relying on the
> > pollfunc top half running, given this is a light sensor those are
> > considered unlikely to exist in practice.
> > 
> > Switch from irq_work to direct call of iio_trigger_poll_nested().
> > Remove now unnecessary irq_work related infrastructure and ensure a
> > local time stamp is acquired.
> > 
> > Suggested-by: Jonathan Cameron <jic23@kernel.org>
> > Assisted-by: Codex:gpt-5.6
> > Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>  
> Thanks.  This looks good to me, but will need to wait for the fix
> to being upstream and for me to merge an rc into the main togreg
> branch of iio.git.  So at least a few weeks, maybe longer.
> 
Applied.
> Thanks,
> 
> Jonathan
> 
> > ---
> > Applies on top of "iio: light: gp2ap020a00f: drain irq_work after
> > free_irq" in the fixes-togreg branch of iio.git; this drops the
> > irq_work_sync() drains that patch added.
> > 
> > v2:
> >   - commit message rework only, per maintainer review; code unchanged.
> > v1: https://lore.kernel.org/linux-iio/20260817024023.291319-1-fanwu01@zju.edu.cn/
> > 
> > ---
> >  drivers/iio/light/gp2ap020a00f.c | 27 ++++++++-------------------
> >  1 file changed, 8 insertions(+), 19 deletions(-)
> > 
> > diff --git a/drivers/iio/light/gp2ap020a00f.c b/drivers/iio/light/gp2ap020a00f.c
> > index 330d597..00164fd 100644
> > --- a/drivers/iio/light/gp2ap020a00f.c
> > +++ b/drivers/iio/light/gp2ap020a00f.c
> > @@ -37,7 +37,6 @@
> >  #include <linux/i2c.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> > -#include <linux/irq_work.h>
> >  #include <linux/minmax.h>
> >  #include <linux/module.h>
> >  #include <linux/mod_devicetable.h>
> > @@ -245,7 +244,6 @@ struct gp2ap020a00f_data {
> >  	struct iio_trigger *trig;
> >  	struct regmap *regmap;
> >  	unsigned int thresh_val[4];
> > -	struct irq_work work;
> >  	wait_queue_head_t data_ready_queue;
> >  };
> >  
> > @@ -802,14 +800,6 @@ static void gp2ap020a00f_output_to_lux(struct gp2ap020a00f_data *data,
> >  		*output_val *= 16;
> >  }
> >  
> > -static void gp2ap020a00f_iio_trigger_work(struct irq_work *work)
> > -{
> > -	struct gp2ap020a00f_data *data =
> > -		container_of(work, struct gp2ap020a00f_data, work);
> > -
> > -	iio_trigger_poll(data->trig);
> > -}
> > -
> >  static irqreturn_t gp2ap020a00f_prox_sensing_handler(int irq, void *data)
> >  {
> >  	struct iio_dev *indio_dev = data;
> > @@ -932,8 +922,7 @@ static irqreturn_t gp2ap020a00f_thresh_event_handler(int irq, void *data)
> >  	if (test_bit(GP2AP020A00F_FLAG_ALS_CLEAR_TRIGGER, &priv->flags) ||
> >  	    test_bit(GP2AP020A00F_FLAG_ALS_IR_TRIGGER, &priv->flags) ||
> >  	    test_bit(GP2AP020A00F_FLAG_PROX_TRIGGER, &priv->flags))
> > -		/* This fires off the trigger. */
> > -		irq_work_queue(&priv->work);
> > +		iio_trigger_poll_nested(priv->trig);
> >  
> >  done:
> >  	return IRQ_HANDLED;
> > @@ -944,9 +933,12 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
> >  	struct iio_poll_func *pf = data;
> >  	struct iio_dev *indio_dev = pf->indio_dev;
> >  	struct gp2ap020a00f_data *priv = iio_priv(indio_dev);
> > +	s64 timestamp;
> >  	size_t d_size = 0;
> >  	int i, out_val, ret;
> >  
> > +	timestamp = iio_get_time_ns(indio_dev);
> > +
> >  	iio_for_each_active_channel(indio_dev, i) {
> >  		ret = regmap_bulk_read(priv->regmap, GP2AP020A00F_DATA_REG(i),
> >  				       &priv->buffer[d_size], 2);
> > @@ -964,7 +956,7 @@ static irqreturn_t gp2ap020a00f_trigger_handler(int irq, void *data)
> >  		}
> >  	}
> >  
> > -	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer, pf->timestamp);
> > +	iio_push_to_buffers_with_timestamp(indio_dev, priv->buffer, timestamp);
> >  done:
> >  	iio_trigger_notify_done(indio_dev->trig);
> >  
> > @@ -1455,8 +1447,9 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
> >  	indio_dev->modes = INDIO_DIRECT_MODE;
> >  
> >  	/* Allocate buffer */
> > -	err = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> > -		&gp2ap020a00f_trigger_handler, &gp2ap020a00f_buffer_setup_ops);
> > +	err = iio_triggered_buffer_setup(indio_dev, NULL,
> > +					 &gp2ap020a00f_trigger_handler,
> > +					 &gp2ap020a00f_buffer_setup_ops);
> >  	if (err < 0)
> >  		goto error_regulator_disable;
> >  
> > @@ -1480,8 +1473,6 @@ static int gp2ap020a00f_probe(struct i2c_client *client)
> >  		goto error_uninit_buffer;
> >  	}
> >  
> > -	init_irq_work(&data->work, gp2ap020a00f_iio_trigger_work);
> > -
> >  	err = iio_trigger_register(data->trig);
> >  	if (err < 0) {
> >  		dev_err(dev, "Failed to register iio trigger.\n");
> > @@ -1498,7 +1489,6 @@ error_trigger_unregister:
> >  	iio_trigger_unregister(data->trig);
> >  error_free_irq:
> >  	free_irq(client->irq, indio_dev);
> > -	irq_work_sync(&data->work);
> >  error_uninit_buffer:
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  error_regulator_disable:
> > @@ -1521,7 +1511,6 @@ static void gp2ap020a00f_remove(struct i2c_client *client)
> >  	iio_device_unregister(indio_dev);
> >  	iio_trigger_unregister(data->trig);
> >  	free_irq(client->irq, indio_dev);
> > -	irq_work_sync(&data->work);
> >  	iio_triggered_buffer_cleanup(indio_dev);
> >  	regulator_disable(data->vled_reg);
> >  }
> > 
> >   
> 
> 

