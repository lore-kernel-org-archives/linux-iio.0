Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ADA12F7AB0;
	Mon, 26 Jan 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769414947; cv=none; b=k8Oj5vJgod/YTWP22/UpX08KPOLJmL6qm1rsMP0KIDRmpmCqyRbS7bgVkClNWVP9VpnVPMQhmqu3Jkqx6uaQxfOdcU+cHL9Ab3o9fozmj68o4DRsojBO/6GMbG9CR0dj51zK5/y4O0X0O/r/T5RG1tji8W4KeFo8vhqNNy+xUQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769414947; c=relaxed/simple;
	bh=YLmq/4V33IVPXpBPesKfkrKT3R1gHM5x5Zp+EbOJ+RA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YnlXGmV/2qOC2IhtwQ6k4/Zbln3a1xLAVdaoFWFHJMltFMruSL9mkpuGL2ZVrfLcdF9KftA3NyyFk34h+C2CxH29El/xBxr5hOIzyHF47GzqGeS8ipqBPiBpGc0Sbqb7KXEr55SQNJ8yh8eYPfDnjAX87RPDcHRydk9UxjrEfUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uYu7FYbM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=urhmF9ET; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uYu7FYbM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="urhmF9ET"
Date: Mon, 26 Jan 2026 09:09:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769414944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFBQZM8xOueSz/hl7zwsg7bUlgr/D2ef1BAUvS4o2fA=;
	b=uYu7FYbM/waAYRcokhv0vQT0ahX2XLek4LulRo0/jfMq0B0nRHX3vAw1iut3/FMmcXCJEa
	GeEl64jpZHsVIAnVFc1XHusYRcPpiy3+JKOXlYfZvAIUDol8b5jazQo8PQYIf+gHDMA+Ut
	5v70TzM5XLJdgRS/gCyq8knjlcT9iXwZULRe4MM81giwT3o7ds2gtNR0lEx9bt+YCDy2Ye
	KEn+nldrjpp+MJSlAb1QXjPYq/GXIcMk02U81V2JJkZMFLSP2vA9qzXAGlEudag1yzvry0
	3UR2/aLGSYAIrxHLiX9RLg74Vq7R1JI3G1JdTznaUzALgnp7nf5oOOnFQeEIFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769414944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XFBQZM8xOueSz/hl7zwsg7bUlgr/D2ef1BAUvS4o2fA=;
	b=urhmF9ET7CA5XBqaRjHDT8LUz8u3lqQ8KO9FKg0UKiwjkUvqfVyjHvtaKnDaWRLFfLtVvH
	Lprc5Cm0nVHl8QAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 19/21] iio: Use IRQF_NO_THREAD
Message-ID: <20260126080903.B0_vWRKy@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-20-bigeasy@linutronix.de>
 <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ac45bbeb-7a76-42f0-88d8-35dbf9742a0c@baylibre.com>

On 2026-01-23 14:56:32 [-0600], David Lechner wrote:
> > -static irqreturn_t ad7766_irq(int irq, void *private)
> > -{
> > -	iio_trigger_poll(private);
> > -	return IRQ_HANDLED;
> > -}
> > -
> 
> Replacing this with iio_trigger_generic_data_rdy_poll() seems like a
> separate improvement that should be in a separate patch.
> 
> At a minimum, the commit message should explain this change. But I expect
> the reason will make it obvious it should be a separate patch.

The other use iio_trigger_generic_data_rdy_poll() as the handler except
this one. Which uses a wrapper around it. It looked to easier to add
this hunk.
What do you want (split or keep)?

> >  static int ad7766_set_trigger_state(struct iio_trigger *trig, bool enable)
> >  {
> >  	struct ad7766 *ad7766 = iio_trigger_get_drvdata(trig);
> > @@ -260,8 +254,8 @@ static int ad7766_probe(struct spi_device *spi)
> >  		 * Some platforms might not allow the option to power it down so
> >  		 * don't enable the interrupt to avoid extra load on the system
> >  		 */
> > -		ret = devm_request_irq(&spi->dev, spi->irq, ad7766_irq,
> > -				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN,
> > +		ret = devm_request_irq(&spi->dev, spi->irq, iio_trigger_generic_data_rdy_poll,
> > +				       IRQF_TRIGGER_FALLING | IRQF_NO_AUTOEN | IRQF_NO_THREAD,
> >  				       dev_name(&spi->dev),
> >  				       ad7766->trig);
> >  		if (ret < 0)

Sebastian
