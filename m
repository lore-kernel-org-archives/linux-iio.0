Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2294C2F5A05;
	Mon, 26 Jan 2026 08:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769415314; cv=none; b=APdu22H7gWK7JuNu+seWKv2yBPK9i7yvQiiN4s4wDQTFHPkKi90EE8EONvGt5DRPgsbd5zLl53W5z2GDvFZcgAWNcgty1H4PnfmtGzpMM+3XJ0vXqPrCpTGA1clLGS7bksxr547HZkD+k7WgyWBaF+0F1wSrx3/w1BzrXu2qHAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769415314; c=relaxed/simple;
	bh=HA2fFlAlKbnFma8q86UovV9FaibUExzsXq69HLJlEUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce0GeCaFF6WNr9Ao4eZzFjMHWVG3YgMNeBqfSowwOdHrlkVVV5fYR/eE9khno+hIC+qTSDE/QcuM1arP7wxXdO62G0dho3NF7/u3k2SH3ThfBUJbCNFktRDc606QIkSeHPDN5CYFhaucElTSWQbBl0klNdD+ZfRWbRbzaoZXMSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gtYRof4d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=18ZFeHwl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gtYRof4d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="18ZFeHwl"
Date: Mon, 26 Jan 2026 09:15:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769415311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A9edcdENk7/kHZIxVaei4JwKF1kXzQc+nA76MRtw+U=;
	b=gtYRof4dw4LVq5m+SLCmCyJXmr3ltYBHd6RI/gceR787AVYp53JhAUyxx/UsLTrBzzYT0d
	TAJGXpo6zwICcZO4w2UFksofcVDMPA0Acx8W4dylb40/hrKGjBNqV0Qmif3TGVuxGOD0Fg
	xMyCWVIImsobSs4Z+AHhRIh9Q5WQgkKjwOSKyqLroDI3IdxvDJuYbbNIvxq2z1eBga7vp/
	ivmF/l+CmtprOv5OKtYh38Lz0E9/qxbvItWl+FfkZySVSHr2L+YahIAOulU0Mx02uZJHyX
	tAwii7nntb4jwHBmixO+Mki3gH1k4CoNkpZ4T6SsdlQmsUeHlmmkSef7DV/FHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769415311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4A9edcdENk7/kHZIxVaei4JwKF1kXzQc+nA76MRtw+U=;
	b=18ZFeHwl8GfP/Ddxvo2oKYjsKNhXxDD8rnRIQTBqWaRDAGH841zLLmSfgG+xOo9rmOaPU6
	vCdMT3G5mkweGKDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Gleixner <tglx@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Kent Gustavsson <kent@minoris.se>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 18/21] iio: Replace IRQF_ONESHOT with IRQF_NO_THREAD
Message-ID: <20260126081510.jr8Rp6R7@linutronix.de>
References: <20260123113708.416727-1-bigeasy@linutronix.de>
 <20260123113708.416727-19-bigeasy@linutronix.de>
 <aXOKVqxyhQ10l9V4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aXOKVqxyhQ10l9V4@smile.fi.intel.com>

On 2026-01-23 16:48:54 [+0200], Andy Shevchenko wrote:
> On Fri, Jan 23, 2026 at 12:37:04PM +0100, Sebastian Andrzej Siewior wrote:
> > Passing IRQF_ONESHOT ensures that the interrupt source is masked until
> > the secondary (threaded) handler is done. If only a primary handler is
> > used then the flag makes no sense because the interrupt can not fire
> > (again) while its handler is running.
> > The flag also disallows force-threading of the primary handler and the
> > irq-core will warn about this.
> >=20
> > The intention here was probably not allowing forced-threading for
> > handlers such as iio_trigger_generic_data_rdy_poll() will intends to
> > invoke hard-interrupt handlers.
> >=20
> > Replace IRQF_ONESHOT with IRQF_NO_THREAD.
>=20
> Code wise LGTM,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
>=20
> There is a few nit-picks regarding style below.
>=20
> ...
>=20
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> > Cc: Puranjay Mohan <puranjay@kernel.org>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > Cc: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Cc: Kent Gustavsson <kent@minoris.se>
> > Cc: Gustavo Silva <gustavograzs@gmail.com>
> > Cc: Nishant Malpani <nish.malpani25@gmail.com>
> > Cc: linux-iio@vger.kernel.org
>=20
> Move these...
>=20
> > Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > ---
>=20
> ...to be here. This will drastically reduce the unneeded noise in the com=
mit
> message. The email will have (if using git format-patch and git send-emai=
l)
> them.

Yeah but if I have to send v2 then they are gone, aren't they? So I have
to move them for each submission. Or is there something I am not aware
of?

> ...
>=20
> > --- a/drivers/iio/accel/adxl355_core.c
> > +++ b/drivers/iio/accel/adxl355_core.c
> > @@ -770,7 +770,8 @@ static int adxl355_probe_trigger(struct iio_dev *in=
dio_dev, int irq)
> > =20
> >  	ret =3D devm_request_irq(data->dev, irq,
> >  			       &iio_trigger_generic_data_rdy_poll,
> > -			       IRQF_ONESHOT, "adxl355_irq", data->dready_trig);
> > +			       IRQF_NO_THREAD,
> > +			       "adxl355_irq", data->dready_trig);
>=20
> Leave it on a single line. It's only 81 characters and it's fine to be li=
ke
> this.
>=20
> >  	if (ret)
> >  		return dev_err_probe(data->dev, ret, "request irq %d failed\n",
> >  				     irq);
>=20
> ...
>=20
> > +++ b/drivers/iio/accel/adxl372.c
>=20
> > +		ret =3D devm_request_irq(dev, st->irq,
> > +				       iio_trigger_generic_data_rdy_poll,
> > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> > +				       indio_dev->name, st->dready_trig);
> >  		if (ret < 0)
> >  			return ret;
>=20
> Interestingly that this driver ignores the flags from firmware... Seems t=
o me
> like a bug (not in your patch, obviously). Ditto for other drivers doing =
similar
> things.

If the irq-chip is level or unknown mode on boot up/ default and the
device can only operate as an edge-rising then I don't see why this
should be a bug.

> ...
>=20
> > --- a/drivers/iio/pressure/dlhl60d.c
> > +++ b/drivers/iio/pressure/dlhl60d.c
> > @@ -306,9 +306,9 @@ static int dlh_probe(struct i2c_client *client)
> >  	indio_dev->num_channels =3D ARRAY_SIZE(dlh_channels);
> > =20
> >  	if (client->irq > 0) {
> > -		ret =3D devm_request_threaded_irq(&client->dev, client->irq,
> > -			dlh_interrupt, NULL,
> > -			IRQF_TRIGGER_RISING | IRQF_ONESHOT,
> > +		ret =3D devm_request_irq(&client->dev, client->irq,
> > +				       dlh_interrupt,
>=20
> Joined to the previous line it gives exactly 80 characters, which is allo=
wed.
>=20
> > +				       IRQF_TRIGGER_RISING | IRQF_NO_THREAD,
> >  			st->info->name, indio_dev);
>=20
> Forgot to indent.

Okay, let me fix this up.

>=20
> ...
>=20
> > +		ret =3D devm_request_irq(&client->dev, client->irq,
> > +				       iio_trigger_generic_data_rdy_poll,
> > +				       IRQF_NO_THREAD, "tmp006_irq",
> > +				       data->drdy_trig);
> >  		if (ret < 0)
> >  			return ret;
>=20
> Jonathan et al., this seems to me like a duplication from one to another
> driver. Can't we do like a helper for it, so we don't change it each time
> the IRQ core or other things got changed?
>=20

Sebastian
