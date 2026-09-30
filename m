Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195954D4888
	for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797178; cv=none; b=UjeUkHZ2HPRdPALQ6As+Z33omqlCvMPuevsc0lPGxyPgAdzHu3xxo/Ys2nJlresjr0W2uBgKepa4EXvQYRsHpSlMlc9tuCo4hj9VZIjpvBh3I/JrZXxaR+7/gXPR1Sav1NqvyqJCZAGjfY0btDQKAxcEeAs622m9W5XDkA6U3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797178; c=relaxed/simple;
	bh=NYT/h8Qc+9GQnlKzSITUYD78AcEXwG2aqbxwXcG/L+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L0PUKhWrfaHqV37ATMmcPOcpA3pf3PtNqRQoYLNSf0ko1rJAYWdHd4vmWXQmca7/8QFCAWmU9Jp9+anjSivdLvBVaW9yK+wugn5aD1/5V/AifBKbSciVgVQbvqGp3DDBFRk2xDQlBLsPe5i0WVlm3qaA3oppQa+vLq55Lf7+kUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3sZzIb/; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3sZzIb/"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-98536aec408so104412241.0
        for <linux-iio@vger.kernel.org>; Wed, 30 Sep 2026 12:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797176; x=1791401976; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lkg30YzbMRtZmB6sxeYNBijNjDlXFAz/0Hn5HVfkijw=;
        b=V3sZzIb/QgP3No6FSpHxKZ+FV89gx21BF8+DJaoHjCboJ+smn9LjO2aFq5ANLGZ6OY
         vU93wQpk3X41utMP0QOjssUZ6rpEH0uhYowvpqOzjB+lRcB7y9/o+4aYjAy1jMFFst07
         zZJErUBV8nbdgTXv9NgFHAwvexv1I9I2O1AxDw91QjM8IT/yLsESKgcd/i3FIXXpEHcg
         E5C9BLYBx7mdTfMAEdPblS/rEnI0pLhksCJn7cOryr3Gy/rlB4A6rTmmfy7lIAVTIeTg
         snML/9Z/9SoNH4qzP4edgFnWwUlMlF3K4R7arRU6J3lDbOSX9JxWBuN+3kaMeYWOa9eu
         XYhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797176; x=1791401976;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lkg30YzbMRtZmB6sxeYNBijNjDlXFAz/0Hn5HVfkijw=;
        b=mzRYeq4B+bdhOYw3swi3m7VlIgzZ40iWCW6FQEjR71nk7X8k2DvDH3y2CVPt+EEGqr
         ETE7KA2NwfK1vr5WWqmcdfQ/IO11e7KnaSEa9+/kBue8bIseMt5eUZ5oCtuOWLHC68xX
         run9UaKn++yL64ZL1SwvRqyoksGbH9N/2VlysEZoVFY6XSwG2J6tdyFBEBgkTRhT3/Bm
         9tTebC+H2y9z2ThG2pbfm8gZlY8UhEG1aQ/gQsp58r8lEgUfOwUJpMNrrYAbNLYu79Ll
         BgMfidX7SFkF0HeGobV74lh/7Jy+w5F/ak8CONeb0nohjhLgP/aiY6ARPshnqDZbljV6
         +C/g==
X-Gm-Message-State: AFq9FYJF9KmxZTrX6eK6YMQ/TCuxICaS5ZfuBBzrQI0KKQ/BZB4+8ij4
	OW60R7RKOCZKI5OgiMUBNXZzZqNciraHLa7H0gL5vP1cnP7eiwQScphUbDGlBQ==
X-Gm-Gg: AYBFou2VvLDPXzx4UmX/qFIrlv8HkhshrM5+tWKvvtCchKNGMDSYBB2UjKP+mp0G5P8
	lmK+eka8pd5Q8PcFI03OWiUKzsC169jLNWmb7HchdDzo7ouoVXbgMFqNPl+QmwamxsZwhnyN+63
	SsPPUtAvU7QWbr7zXyOOSH3792eLKxS1hawFxKtBpK5tDYdk/KNkAWLkpdynfjQF4HusgnjZS5F
	zD4bCO88oWI6ML8ld0ybN3BcbRObTMTyDAJMnnyn9kxFxZUt4lPd3qaEsb3x+tzTR4UzUd6+y6i
	sUnmlUacgJhU1ngw+27VwUQ5mlh2zMT9ZS+rzExZHWnqfpeAjUJl8BMBJbLhiG7+TwzJIWXtC7b
	JlxX34JaWlz+oZkx07aWTHdBoyQJSWCANiNg45nnuiMyn+EuyLjN/S9Mykcm87oh4f+sLknlECy
	dvXNaiBm95tEQe7/bA7ZQH7/TyULzL/TxxDUtJntfPkro6UTiqGAL5gUM1PKuK7s65R161RPawK
	1Tn
X-Received: by 2002:a05:6102:5802:b0:7b4:6720:f954 with SMTP id ada2fe7eead31-7bf8355674fmr239816137.11.1790797175805;
        Wed, 30 Sep 2026 12:39:35 -0700 (PDT)
Received: from localhost ([2804:30c:96c:bf00:7844:c38c:894:4054])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-98a86e99290sm976242241.1.2026.09.30.12.39.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:39:35 -0700 (PDT)
Date: Wed, 30 Sep 2026 16:39:47 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, marcelo.schmitt1@gmail.com
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, robh@kernel.org,
	devicetree@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v3 10/13] iio: adc: ad4134: Support SPI 4-wire mode
Message-ID: <ar1lg7PMwP_RdzzO@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
 <c066072441fdba492c18c71d5332d84224379410.1790719425.git.marcelo.schmitt@analog.com>
 <20260929230830.A8F3A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929230830.A8F3A1F000FF@smtp.kernel.org>

On 09/29, sashiko-bot@kernel.org wrote:
...
> > +/*
> > + * When operating in modes other than minimum I/O mode, AD4134 register data on
> > + * the SDO line is sampled on SCLK rising edge (SPI mode 0). In addition to
> > + * that, when AD4134 SDO and DOUT0 pins are multiplexed by hardware OUTSIDE
> > + * AD4134 SILICON, the multiplexer state must be set to route SDO to the SPI
> > + * controller. With both SPI mode and multiplexer state properly set, register
> > + * access runs as usual. Still, to prevent concurrent hardware interface
> > + * configurations, callers must hold the access_lock. Finally, successful calls
> > + * to this function must be balanced with calls to ad4134_release_reg_access()
> > + * so to release the mux state lock. See AD4134 IIO documentation for details.
> > + */
> > +static int ad4134_claim_reg_access(struct ad4134_state *st) __must_hold(&st->access_lock)
> > +{
> > +	unsigned int cur_mode = st->spi->mode & SPI_MODE_X_MASK;
> > +	int ret;
> > +
> > +	if (st->spi_mode != AD4134_SPI_MODE_NO_CS && cur_mode != SPI_MODE_0) {
> > +		st->spi->mode &= ~SPI_MODE_X_MASK;
> > +		st->spi->mode |= SPI_MODE_0;
> > +		ret = spi_setup(st->spi);
> > +		if (ret)
> > +			return ret;
> 
> [Severity: Medium]
> If spi_setup() fails, the local spi->mode keeps the SPI_MODE_0 value but the
> hardware isn't updated.  On the next call, cur_mode will match SPI_MODE_0,
> skipping spi_setup().  Could this leave the device permanently desynchronized
> from the controller?
> 
If spi_setup() fails it will be tried again on the next register or sample read.
So, the device would be desynchronized only when not being used.

...
> >  	/*
> >  	 * To be able to read data from all 4 channels through a single line, we
> > @@ -284,7 +401,7 @@ static int ad4134_data_read(struct ad4134_state *st, unsigned int reg,
> >  		ret = spi_write_then_read(st->spi, NULL, 0, st->rx_buf,
> >  					  BITS_TO_BYTES(AD4134_CHAN_PRECISION_BITS));
> 
> [Severity: High]
> Since ad4134_min_io_mode_setup() is not called in 4-wire mode,
> AD4134_DATA_FORMAT_SINGLE_CH_MODE is never set. Doesn't this mean
> ad4134_data_read() blindly assumes the data is serialized on DOUT0 when it
> isn't? Could this result in reading Channel 0 data four times instead of the
> other channels?

The default on device reset is to output data from all four channels serialized
through DOUT0. Anyways, will make the configuration explicit in case the device
is not reset.

> > +static int ad4134_buffer_predisable(struct iio_dev *indio_dev)
> > +{
> > +	struct ad4134_state *st = iio_priv(indio_dev);
> > +	int ret;
> > +
> > +	ret = ad4134_release_sample_access(st);
> > +
> > +	mutex_unlock(&st->access_lock);
> 
> [Severity: High]
> Is it intentional to hold st->access_lock across system calls here? Returning
> to user space with the mutex held violates lock ownership semantics and can
> trigger lockdep splats. Furthermore, could this deadlock any subsequent sysfs
> regmap accesses while the buffer is enabled?

I'm not sure about this one. The intent is to prevent sysfs regmap access while
the buffer is enabled. IIO direct/buffer mode locking should provide that, no?
The rationale for the two mutexes is for access_lock to avoid concurrent updates
to the external multiplexer and for sync_lock to protect read/modify/write
sequences. Maybe IIO direct/buffer mode locking + sync_lock is enough?

> 
> > +
> > +	return ret;
> > +}
> [ ... ]
> > @@ -588,15 +768,69 @@ static int ad4134_probe(struct spi_device *spi)
> >  	if (ret)
> >  		return ret;
> >  
> > +	ret = devm_mutex_init(dev, &st->access_lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ad4134_regmap_config.lock_arg = st;
> >  	st->regmap = devm_regmap_init(dev, NULL, st, &ad4134_regmap_config);
> 
> [Severity: Medium]
> Is it safe to modify the global ad4134_regmap_config structure during probe?
> If multiple devices probe concurrently, could this cause a data race where one
> device's lock_arg overwrites another's before devm_regmap_init() copies it?
> 
Not sure. Should it lock on a mutex before editing the regmap_config. Maybe
I get rid of access_lock and make regmap_config const again.


> [Severity: High]
> In 4-wire mode, ad4134_min_io_mode_setup() is bypassed. Since st->odr_gpio is
> only retrieved inside ad4134_min_io_mode_setup(), won't it remain
> uninitialized (NULL)? Will this cause all software triggers using
> gpiod_set_value_cansleep(st->odr_gpio, ...) to silently fail in 4-wire mode?

Okay, that seems to be an issue. Will make the device request the GPIO if
offload/PWM is not available.

> 
> > +		/*
> > +		 * This controls a multiplexer OUTSIDE OF AD4134 SILICON.
> > +		 * See AD4134 IIO documentation for details.
> > +		 */
> > +		st->mux_st[AD4134_SDO_INPUT] = devm_mux_state_get(dev, "reg_access");
> > +		if (IS_ERR(st->mux_st[AD4134_SDO_INPUT]))
> > +			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_SDO_INPUT]),
> > +					     "failed to get reg_access mux-state\n");
> > +
> > +		st->mux_st[AD4134_DOUT0_INPUT] = devm_mux_state_get(dev, "data_read");
> > +		if (IS_ERR(st->mux_st[AD4134_DOUT0_INPUT]))
> > +			return dev_err_probe(dev, PTR_ERR(st->mux_st[AD4134_DOUT0_INPUT]),
> > +					     "failed to get data_read mux-state\n");
> > +
> > +		indio_dev->setup_ops = &ad4134_buffer_setup_ops;
> > +	}
> 
> [Severity: High]
> Since setup_ops is only assigned for 4-wire mode, won't NO_CS mode bypass
> ad4134_buffer_postenable() entirely?  If so, doesn't that mean
> ad4134_trigger_handler() uses st->rx_buf without holding st->access_lock,
> creating a data race with concurrent sysfs regmap accesses?
> 
NO_CS/minimum I/O mode doesn't need to constantly switch the external
multiplexer and can leave that in reg_access state. Also, since minimum I/O
always operate in SPI mode 0, nothing that access_lock protects is really used.
