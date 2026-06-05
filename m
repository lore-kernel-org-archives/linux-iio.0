Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E514A3410
	for <linux-iio@vger.kernel.org>; Fri,  5 Jun 2026 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780659280; cv=none; b=jWKF5VjLDdh8wu9iidyos/a3UObQA5jCuSSO1ax6XfNdWzCNuLXoNt5iU5QYw4fyivfDCCATTToN50ycb3REEE4UCLkaQi59rw1s5ZWR6OTvJ9mYYThZjot39rq6XY8TtT0LGym+2d4XGmRPOlE24LgCql22e1a15SzVnlMWcS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780659280; c=relaxed/simple;
	bh=RTjhxEGvOy+F+VQ/siDtUUts+dyofnFoSYDC7g4FuG4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFVW1lRWl8CFzfNC3f4HCmBezKeLNQ1IcF/f3Ei47qMcCGQFCLHBJjnelSKeShaUge4zwDEgv7xkDWGVf1VLI2fwGjWlFQRVuSWU88OvnMrvBu8DzyXy6lJsGVU36oJJdkKMbLTfFYXnDGVyhDhVWOh0kD34sJfZna8V+RE+4mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wmq3kPUV; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wmq3kPUV"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-45ee5cdbd28so1821956f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 05 Jun 2026 04:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780659277; x=1781264077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hJRmfaxPaWcnCvs7QB4gUgP5UAYanEHUPfa/m1ombOs=;
        b=Wmq3kPUV9UQPwUwMfcEXS9nkcfIrne1+VxRzzjUKdhZSQLt92iAY6nYOEznZG/ER34
         DI+Ud3o2CrPMIs80JfWzrStGQL2ggC+z8+t/N0Z9zJtlWanXANkgmfUTohUzM0ZeWDtu
         GlweRSmz9jODSRyF7mOAblmcPhpdIfjohDSeviSD+UKuZ2V1LPE2w7QjwBhhowwetEB0
         LqDEmOuK7vAJdyDpzNLW4ZjT6MX+Ffq5dqimPRyIZQW61NZ0z06mJK/GcMfaDN5mpcJO
         mWKElBxtngM5oQCC8uS34uksuJNFEZ7I6AIRQZnOUN+L2qyOZaeFzBx0bx3cqYg8tiIR
         vkDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780659277; x=1781264077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJRmfaxPaWcnCvs7QB4gUgP5UAYanEHUPfa/m1ombOs=;
        b=SbZR8mwzmucwrYR7xySQXvKX4JjMF9VUZI9cxguefR+EgfYz+JumZn9RqhUOZciMGN
         gwuqyLhUpCpzOiJNZQYBCs0n4Ct3J5OhlIXrN5YinNmsGZOajhfkE6B/X/WozjojM3v/
         OtKW5CHZ3oiZAtgXALQZatPWeZTSY/sSqYM/FMvk1TqGD3mZMbh2uXi0bg0rEwZv5ZkB
         q7nAg891I0beBUbMNBn66rVAWQwETCJfR29JrOw/JLpeXiaCnjwGlD0bs4EpkXvcwtl0
         zEFP4p+q661vcIcY/m/RKBI+2aA5W26ncN4j4Mduu/19djhuDKtcJJ3jR8H3lBrSjlPQ
         6lCA==
X-Forwarded-Encrypted: i=1; AFNElJ/+TEMVDBn1tiAALWIMotfwlLEctcEhj+0re3Fw591S1AjRhp7y6ACqyKDL0dhdyFVP8BnUzocvYEo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFjGdyGsKPLs+JGhKdrdmmgBeLSmjI6Poro8sE1wmVb5Lp2w1Q
	KblCV8oDxs1UwaR9ODQdbpfilXgktbgA4U+6FXf1aSBbfe75FFAi2REx
X-Gm-Gg: Acq92OHxTMxuwtZuZSvVHYD2ziqWw5EUyGqfK/nTQrG1aZptalPNsA1uEjRRXVfmzPR
	WShqQd1q6tuewxI/Czrf3y0OCvXRliW89+brZALpgUC+RGly2n1MhmWv6vyBJyOSCuLZAVnSstd
	x3IE4dEOprbbUd6tHXqgdmNOuuOX7o5HeG68wwIyMMd6LU28Ez/RoqGS6NHNIERpMfGXxymdBNa
	kKv9t4Qpg3sEm3b2FVqbbraJwM9SiCmcTOA19rEWcQsKFtaRWyhkm7TfdHDEPyTRu8ovlpoziOu
	VgGersfLo7h4PZ6fXPKQJt+BLM6SX4C88cgFmM9GeGtE6H89ATaolLtgSzpLFEDJtOsRKxZ5bxo
	bdJNYP3vjEEu2cx8+xJM/OUjpl6wF3NpKlNIi7mAH7mI++aD8rB6Ub5069TbxZdhelUZQ1t0oY+
	qOBE4tZfhK/b2fhVsDi+Tu3H0gIkpIEvrX34mqMDOMe+dQ69KAHmjvoIENU9jSkyd73qcjTPY+N
	BGhsDPIHrMwveiV3TQJkEkxutRKy3xBqxotPtKH07GwTIC+v8toI/ReatLx
X-Received: by 2002:a05:6000:491a:b0:45e:dc0a:bcb with SMTP id ffacd0b85a97d-46032db42fcmr3878302f8f.22.1780659277189;
        Fri, 05 Jun 2026 04:34:37 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.131.netskope-rdns.com. [24.206.116.131])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46028a6dce6sm17068219f8f.30.2026.06.05.04.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 04:34:36 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Fri, 5 Jun 2026 12:34:31 +0100
To: Jonathan Cameron <jic23@kernel.org>, 
	Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>, 
	linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <i3wvatdosla3cszhhtizgoetcbknl56be3mpipzdxqx2jzvch2@l4hzeer5zoa7>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
 <20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
 <20260603134151.7cf1654b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260603134151.7cf1654b@jic23-huawei>

On 26/06/03 01:41PM, Jonathan Cameron wrote:
> On Tue, 02 Jun 2026 17:33:57 +0100
> Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> 
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Implement trigger handler by leveraging the LDAC gpio to update all DAC
> > channels at once when it is available. Also, the multiple channel writes
> > can be flushed at once with the sync() operation.

...

> > +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> > +{
> > +	struct iio_poll_func *pf = p;
> > +	struct iio_dev *indio_dev = pf->indio_dev;
> > +	struct iio_buffer *buffer = indio_dev->buffer;
> > +	struct ad5686_state *st = iio_priv(indio_dev);
> > +	u16 val[AD5686_MAX_CHANNELS] = { };
> > +	int ret, ch, i = 0;
> > +	bool async_update;
> > +	u8 cmd;
> > +
> > +	ret = iio_pop_from_buffer(buffer, val);
> > +	if (ret)
> > +		goto out;
> > +
> > +	mutex_lock(&st->lock);
> > +
> > +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> > +						      iio_get_masklength(indio_dev)) > 1;
> > +	if (async_update) {
> > +		/* use ldac to update all channels simultaneously */
> > +		cmd = AD5686_CMD_WRITE_INPUT_N;
> > +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> > +	} else {
> > +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> > +	}
> > +
> > +	iio_for_each_active_channel(indio_dev, ch) {
> > +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> > +		if (ret)
> > +			goto cleanup;
> > +	}
> > +
> > +	if (st->ops->sync)
> > +		ret = st->ops->sync(st); /* flush all pending transfers */
> > +
> > +cleanup:

It turns out that this label is not really needed. When sync() op is available
it must be called regardless of write failure, so the bus data can reset its
state. Then moving "cleanup" up would just make it useless.

> > +	if (async_update)
> 
> Error paths are always fun.  Do we care about setting ldac_gpio to 1 if
> we failed to write the channel values?  That will set any that did successfully
> update, but not all of them.  Note I'm not sure on the right answer for this.
> There may not be one!

I would not see a problem with that, as there is no much we can do with errors
in a interrupt handler.

> 
> > +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> > +
> > +	mutex_unlock(&st->lock);
> > +out:
> > +	iio_trigger_notify_done(indio_dev->trig);
> We get this pattern so often (though not always).  Feels like maybe
> we should put some effort into a generic opt in solution for this.
> 
> A job for another day but options that come to mind.
> 1) (hideous) a flag
> 2) Maybe an alternative callback. thread_always_complete or
>    something like that.  Pain to wire through all the calls though
>    and injecting the necessary wrapper isn't great either.
>    Implementation wise would be a case of popping in a wrapper function
>    in iio_trigger_attach_poll() call to request_threaded_irq().
> 3) Maybe a helper macro?  Bit ugly as we'd need one to generate
>    the wrapper function and another to use the same name for
>    the registration function.
> 
> Hmm. Those are all ugly (maybe 2 is ok ish).  Suggestions welcome!

using a cleanup.h? with something like:

	static inline void iio_trigger_always_done(struct iio_poll_func **ppf)
	{
		iio_trigger_notify_done((*ppf)->indio_dev->trig);
	}

	static irqreturn_t ad5686_trigger_handler(int irq, void *p)
	{
		struct iio_poll_func *pf __cleanup(iio_trigger_always_done) = p;
		/* ... */

		ret = iio_pop_from_buffer(buffer, val);
		if (ret)
			return IRQ_HANDLED;

		/* ... */

		return IRQ_HANDLED;
	}

> 
> > +
> > +	return IRQ_HANDLED;
> > +}

-- 
Kind regards,

Rodrigo Alencar
