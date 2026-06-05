Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B6740E8E2;
	Fri,  5 Jun 2026 14:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780668604; cv=none; b=GxV0VsRmwU8+Q67F91N77LrmeHgNFHfPHgVLDS9ZE1LStnW27+hhr36NIEhAVMI9h0ffWvrx31A31p7A2n3uQPaV9erR8A6ABj+XDgDHt1wkCALUAfw0BI9wVpDYRfAacaPB+Q3EwC028Glj6iegqC7idMd8Lg00jlrz4kODVoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780668604; c=relaxed/simple;
	bh=xB1Mo0ZL1kEYBMQPeShV1xsBEhsJmlbe5Pi6nQWqLvA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5ohYcwrdEr00c2CU/q02sYu2+s2trJcSuOndLyXraahuLQ8hyMuqsK60lMaYac/ntXJsI2cyjV3kBQyV4f8SchXx0hJnhruEnrPIUViUr2tdWbXbSJvPc3ZQhwJ67RUkhPDmq4evOLrE7pntbNE4l07/20X4QokKELP9jyZc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7CiFcEB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7CiFcEB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A5D21F00893;
	Fri,  5 Jun 2026 14:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780668602;
	bh=Xv79vCkfi3tsuNiev9znO8IdUX1iN7cx6A7mjZ930sI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=E7CiFcEB2KsHHpwXRUL2YxFR6HNto+hVjb6eODvSQQUh6Qey0Fd+fV0xM52TEciwy
	 ocf4RGW/tmnTQjVmuBuRWMpdnzlALgWvAa9yxHVZgcTSIuKPkzSZb1AlHXHV/Xxq5/
	 vpvc/bOG3jbNNtnIyIbRFuz0uop0EM+NkbzFQWjkLUo19oioaacbU9xsRvFt51U+SG
	 9Q/2bKmSapdi8nYT6RxgKp88/kvwbsDeW7aQNGOJCt4QiRWp/LS2s3FuXbuMKxNctI
	 xNNC2Sg3eo20m3Z6ipcCs27JgZRj7uKGGSI4elZc7zVpMaU3cQUfp1wTjoQ1OISYox
	 24dnf1TmunpwA==
Date: Fri, 5 Jun 2026 15:09:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
Cc: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>,
 rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 10/12] iio: dac: ad5686: add triggered buffer support
Message-ID: <20260605150951.1c793b76@jic23-huawei>
In-Reply-To: <i3wvatdosla3cszhhtizgoetcbknl56be3mpipzdxqx2jzvch2@l4hzeer5zoa7>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
	<20260602-ad5686-new-features-v1-10-691e01883d27@analog.com>
	<20260603134151.7cf1654b@jic23-huawei>
	<i3wvatdosla3cszhhtizgoetcbknl56be3mpipzdxqx2jzvch2@l4hzeer5zoa7>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 5 Jun 2026 12:34:31 +0100
Rodrigo Alencar <455.rodrigo.alencar@gmail.com> wrote:

> On 26/06/03 01:41PM, Jonathan Cameron wrote:
> > On Tue, 02 Jun 2026 17:33:57 +0100
> > Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:
> >   
> > > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > > 
> > > Implement trigger handler by leveraging the LDAC gpio to update all DAC
> > > channels at once when it is available. Also, the multiple channel writes
> > > can be flushed at once with the sync() operation.  
> 
> ...
> 
> > > +static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> > > +{
> > > +	struct iio_poll_func *pf = p;
> > > +	struct iio_dev *indio_dev = pf->indio_dev;
> > > +	struct iio_buffer *buffer = indio_dev->buffer;
> > > +	struct ad5686_state *st = iio_priv(indio_dev);
> > > +	u16 val[AD5686_MAX_CHANNELS] = { };
> > > +	int ret, ch, i = 0;
> > > +	bool async_update;
> > > +	u8 cmd;
> > > +
> > > +	ret = iio_pop_from_buffer(buffer, val);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	mutex_lock(&st->lock);
> > > +
> > > +	async_update = st->ldac_gpio && bitmap_weight(indio_dev->active_scan_mask,
> > > +						      iio_get_masklength(indio_dev)) > 1;
> > > +	if (async_update) {
> > > +		/* use ldac to update all channels simultaneously */
> > > +		cmd = AD5686_CMD_WRITE_INPUT_N;
> > > +		gpiod_set_value_cansleep(st->ldac_gpio, 0);
> > > +	} else {
> > > +		cmd = AD5686_CMD_WRITE_INPUT_N_UPDATE_N;
> > > +	}
> > > +
> > > +	iio_for_each_active_channel(indio_dev, ch) {
> > > +		ret = st->ops->write(st, cmd, indio_dev->channels[ch].address, val[i++]);
> > > +		if (ret)
> > > +			goto cleanup;
> > > +	}
> > > +
> > > +	if (st->ops->sync)
> > > +		ret = st->ops->sync(st); /* flush all pending transfers */
> > > +
> > > +cleanup:  
> 
> It turns out that this label is not really needed. When sync() op is available
> it must be called regardless of write failure, so the bus data can reset its
> state. Then moving "cleanup" up would just make it useless.
> 
> > > +	if (async_update)  
> > 
> > Error paths are always fun.  Do we care about setting ldac_gpio to 1 if
> > we failed to write the channel values?  That will set any that did successfully
> > update, but not all of them.  Note I'm not sure on the right answer for this.
> > There may not be one!  
> 
> I would not see a problem with that, as there is no much we can do with errors
> in a interrupt handler.
> 
> >   
> > > +		gpiod_set_value_cansleep(st->ldac_gpio, 1);
> > > +
> > > +	mutex_unlock(&st->lock);
> > > +out:
> > > +	iio_trigger_notify_done(indio_dev->trig);  
> > We get this pattern so often (though not always).  Feels like maybe
> > we should put some effort into a generic opt in solution for this.
> > 
> > A job for another day but options that come to mind.
> > 1) (hideous) a flag
> > 2) Maybe an alternative callback. thread_always_complete or
> >    something like that.  Pain to wire through all the calls though
> >    and injecting the necessary wrapper isn't great either.
> >    Implementation wise would be a case of popping in a wrapper function
> >    in iio_trigger_attach_poll() call to request_threaded_irq().
> > 3) Maybe a helper macro?  Bit ugly as we'd need one to generate
> >    the wrapper function and another to use the same name for
> >    the registration function.
> > 
> > Hmm. Those are all ugly (maybe 2 is ok ish).  Suggestions welcome!  
> 
> using a cleanup.h? with something like:
> 
> 	static inline void iio_trigger_always_done(struct iio_poll_func **ppf)
> 	{
> 		iio_trigger_notify_done((*ppf)->indio_dev->trig);
> 	}
> 
> 	static irqreturn_t ad5686_trigger_handler(int irq, void *p)
> 	{
> 		struct iio_poll_func *pf __cleanup(iio_trigger_always_done) = p;

That's not a nice pattern given the lack of any local constructing. The ownership
transfer isn't obvious as both p and pf are really same type (it's slightly
hidden by the void * nature of p) - ideally we'd want p to be unusable after
that transfer.  Could do something hideous like 
		struct iio_poll_func *pf __cleanup(iio_trigger_always_done) =
			__get_and_null(p, NULL);
where p is set NULL so it becomes dead but that is ugly and not what that
is for so I doubt it would be popular and so we'd end up with yet another
weird macro.  There is some precedence with take_fd() but the use of that
is complex and I think it is only used to grab ownership from a local CLASS()
defined cleanup.

So it would work, but I've actively argued against this style elsewhere
in the kernel so don't really want it in IIO either!

Key disadvantage is that it is yet another weird bit of cleanup.h stuff for
people to learn and we have enough of those already.

So indeed an option but I'm not really liking it.

Jonathan

> 		/* ... */
> 
> 		ret = iio_pop_from_buffer(buffer, val);
> 		if (ret)
> 			return IRQ_HANDLED;
> 
> 		/* ... */
> 
> 		return IRQ_HANDLED;
> 	}
> 
> >   
> > > +
> > > +	return IRQ_HANDLED;
> > > +}  
> 

