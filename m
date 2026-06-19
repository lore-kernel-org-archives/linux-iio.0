Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F2E3976A7
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781879202; cv=none; b=BzUqS42mRUmlBZh8qIS9NwDKtJdqr8Y8B91fW+YibP5jeZIZQwL3MCHK68ghL7DmRDfQWF+s8eX/zUZxX9wNUjfvu/GH4OTqmSV/N9JjEUTCIxW8O1Vod7u599Pp6KRq7nmOzDecKzrxyRsen5qI+5CFDl4CvTSwCpQEWUgc1Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781879202; c=relaxed/simple;
	bh=qcaWSGPvUy2u54fK8ZwK+zHysS4I1DayUEvb7c8WnWA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G71X32aIQgvNru7Qmz8dVx18JKWHfuSFLhWzfLlZH7gmjwgK1srrn3XoIe2hOj2snuL9TfjwKEDMvrg8KrgrdE9GtiukDLt0m8cuGPJ3P1jDi+6TlhrS+Wi7ar90m1812JxyMuGNGTjkbLiNi4BjQeV/YISpor8vXs3m7DcGWAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMhxd+f3; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMhxd+f3"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-139986373b8so1984075c88.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781879199; x=1782483999; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+NOFvW+oVtBVeLrjfLCqJyDxKh0T7V/dXs1RZ3OhYY=;
        b=CMhxd+f3T0sWeh9EFmuzHt8LoaghepR4KFKr2Ncf/DNX5y8U/5g38b4OT/7wE+5Cd3
         QI+dmyU1jbkSn6O88YOitKwit3n5+0Bd6EJ6R11L2kQIaozFeJolTlJSF9rpY3cJjljR
         sA4SkXUOhbgdyY1616RXyuQGnFWwyL1E+enN7Sht+SFIpAusfH62L/wx9vSb1WUFUcDS
         +NKca1BJ7ltroUSjJ00JEDgNC3RBz0EopG27HcPYihe7sdIjYdRppw+gkS3RySSfFy0C
         AYO5JUZwi5coDqm72KEB3nJ7u2FHFWnsbztvDDi0U31ndj8cXu5NC3WphOnYDwtTP3hh
         NFuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781879199; x=1782483999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q+NOFvW+oVtBVeLrjfLCqJyDxKh0T7V/dXs1RZ3OhYY=;
        b=XxZbelXbl1lfgef58KnflWEzinz3FpAchsnOB/IcNrzwktdaF2QSFbZ4XZp0+8wM5J
         Lv+voXEUCONlTt83QtxAPPJKXlzG1vUvoPnLXqWIEGXQRGGweehqVOv9LaUoif/o3LAH
         mah4jDLqyLweJwPJcPO+RxdjYvrVCHhmwnhponLpCXqlcRpRiBLrFyoy0Kqpskgthhkz
         mXgl6ocGeaTZ2U0rnOfzQ9ovZwt3K1jCfFbCtd3zDaj91PcpTlbeLKaJljtlWg6QQX3b
         8/7M+g10H1tQm+JhwkiPqKiAq77LNsoQaSkraYtnuEdzwK37lUrOu5oD80jOB/jOgQnP
         Zssg==
X-Forwarded-Encrypted: i=1; AFNElJ9oedbinqk0V1zpOjrS3GJNL9U5kGoR5ulWzDipVXw6UXrbm7I9+IBeAGa1uhYBGEBYQ8BySEDDB7w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiCcvy6+fFXUApY+ekz+XVXAeJKgalRWu1X+muDuoYvCD63b+O
	WLWU2KRbPSMM0y5Ep4vRoZA3upg1XFVFkh+xCvivah01fjH93RK2k6TJ
X-Gm-Gg: AfdE7cmyqp20yl3Bf+R7NST0o0aSpLhj+D6IKrWjXsapEqbil0tHGQGonV6bIZC+44g
	dp3/u6CNKnkRChmIbapfzF9cWSbwHVtSg7cBYPawQmXj4VjsLE7RrK9EUYErFO0hlNlGp/xn/aj
	dDIxQnZ/0WTiEeeBd/iwTcTetwscIYISZTlkJO+/ld4dSYFSfiearXrje/Ehr2JjdXOZQW0eZXo
	10OPYzEjNqptM6C/+5C/IiS6NI3Hl9qXmcQAL+hM8eoOa6Aoy4PUK4y/5ZRYg/lisxS9En2IQmt
	cw6InjJot7wLSoF8VCMp3ymBa9pYHNd9GOit5wM3o1Ai98giKAUv460TDe5784+SFecsFLFeeM9
	FLoGR5hBLO+RCeKU+YLznj/EQoDGRJ0tS+El78ytqtOeU3a4wDCN/lQ+/D/U63EiHARXXUD44QI
	I2/EmhVIlbBWiD+N6rnpqxGA==
X-Received: by 2002:a05:7300:6c9f:b0:2ea:c085:44b1 with SMTP id 5a478bee46e88-30c071533c3mr2469687eec.19.1781879199101;
        Fri, 19 Jun 2026 07:26:39 -0700 (PDT)
Received: from localhost ([2804:30c:1f0a:b600:e457:1a16:4082:3e0a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1ba1f137sm1470eec.1.2026.06.19.07.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 07:26:38 -0700 (PDT)
Date: Fri, 19 Jun 2026 11:27:16 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, Michael.Hennerich@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, pop.ioan-daniel@analog.com
Subject: Re: [PATCH v3 5/5] iio: adc: ltc2378: Enable triggered buffer data
 capture
Message-ID: <ajVRxCPejqxlo_Z4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1781661028.git.marcelo.schmitt@analog.com>
 <22248e8ba646fbe8edfc87e2b9be527632d5b48c.1781661028.git.marcelo.schmitt@analog.com>
 <4f7f50ad-c305-4947-b4e9-3666a4f31031@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f7f50ad-c305-4947-b4e9-3666a4f31031@baylibre.com>

On 06/17, David Lechner wrote:
> On 6/16/26 9:04 PM, Marcelo Schmitt wrote:
> > Enable users to run triggered data captures with LTC2378 and similar ADCs.
> > 
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
...
> > @@ -27,6 +27,21 @@ int ltc2378_lib_buffer_setup(struct iio_dev *indio_dev, struct ltc2378_state *st
> >  		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
> >  
> >  	return 0;
> > +
> > +trigger_buf_setup:
> > +	ret = __ltc2378_set_triggered_buf_ops(st);
> > +	if (ret == -EOPNOTSUPP)
> > +		return 0; /* Let device setup complete without buffer support */
> > +
> > +	if (!ret)
> > +		ret = st->ops->buffer_setup(indio_dev, st);
> > +
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "error on buffer setup\n");
> 
> This is repeating the code above. Seems like it would be better without
> the goto.
Ack

> 
> > +
> > +	st->chans[st->num_iio_chans++] = IIO_CHAN_SOFT_TIMESTAMP(1);
> 
> Adding a channel here seems messy. I still think static const channel
> data would be better. But at least would be better if this was moved
> to the same function as the other channel setup.
> 
Agree, will think of a better place to init the timestamp channel while
switching to static const channel.

> > +
> > +	return 0;
> >  }
...
> > +static irqreturn_t ltc2378_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct ltc2378_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = ltc2378_convert_and_acquire(st);
> > +	if (ret < 0)
> > +		goto err_out;
> 
> As mentioned elsewhere, SPI xfer size may be 2 or 4 bytes, but
> we are always pushing 4 bytes, so this only works on little-endian
> architecture.
> 
> I think best would be to have storagesize = 16 when appropriate to
> avoid having to manually handle this.
> 
Okay, it will probably be easier to do that with static const channels.
Am checking out other sashiko comments as well.

> > +
> > +	iio_push_to_buffers_with_ts(indio_dev, &st->scan, sizeof(st->scan),
> > +				    pf->timestamp);
> > +
> > +err_out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> > +	return IRQ_HANDLED;
> > +}
> > +
> 
Thanks,
Marcelo
