Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DA4E272E56;
	Wed, 20 May 2026 18:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779303199; cv=none; b=ahklsaQFp2UEG86MjMveoO4leShp0duMpCNkyBcqoAWwFaiT33hSJqDs0sskemfUMVnPyVfVD6X7xNYvUZ6YsFCRvqZEh3WYFF3ex6Lm2BkkOByyIbJKn0duVyiocZ07Rk8FPiAUb4NT2HkPWauHKT88oteOc0C9M5F6hYzliOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779303199; c=relaxed/simple;
	bh=Ywx1mGdSgqbv5k9HmpLCR0s+Q572k8jWkACMalkVr/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HoHgq5XUqvhUk1kKw0lUZVvGEdNeO3l9etBR5tzQWBigBMSnxu14/qg+8wbyv8N027vi1cEupuhM7X1gCM4ZGfCfeLRmqRFhxHjcWrNioKas4QU9/0sHdjcJhscaluakEMeDR7ExqE6cYEVDqfyHiHBTNg6qwO09pE+A5id6XMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IggBUpcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IggBUpcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4A901F000E9;
	Wed, 20 May 2026 18:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779303198;
	bh=tdxodyJKcIQWQQePbZ1iQzbrwRLc3HZLKX6TGNn3DJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IggBUpcTMOD7KV5y7K3N5L0xosHIkx8y+TVtDSuHdZzDglbbW+mvovC06wfxbhVwD
	 X8cD8qBFKK2y9FafiB7lErihgowON3bsLpwrHIzmEcr/k4uiG3F/W4guY8ThhF0Kd9
	 EX/DDUPxdsMy9vAIYgA+Y6HVVGIqm6BZOzX3tsmZtbwcSd3ChQCq1q3rT21+NWblBR
	 ZH5nSFcP7Uf30dbU8ywktbuzS5tvQIviQaLohjMV5GpPgUNaIW4fRS/2SmZctWpGRD
	 no1V7oRHXRzZvAn+WFGQZeXAUvD1+Wlnlsq0RtprmPbn7emTLv1UxDHJ3qtMOw/QrJ
	 ZJuVpq8v5jObA==
Date: Wed, 20 May 2026 19:53:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260520195307.6c06760d@jic23-huawei>
In-Reply-To: <20260520181940.548759-1-liviu.stan@analog.com>
References: <20260518145802.49a3bc94@jic23-huawei>
	<20260520181940.548759-1-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 21:19:37 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> On Mon, 18 May 2026 14:58:02 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> ...
> > > > > +		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
> > > > > +			return dev_err_probe(dev, -EINVAL,
> > > > > +					     "sensor type %d not supported on %s\n",
> > > > > +					     sensor.type, st->info->name);
> > > > > +
> > > > > +		dev_dbg(dev, "Create new sensor, type %u, channel %u",
> > > > >  			sensor.type, sensor.chan);
> > > > >      
> > > >     
> > > > > @@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
> > > > >  
> > > > >  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > > > >  {
> > > > > -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> > > > >  	struct device *dev = &st->spi->dev;
> > > > > +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
> > > > > +	u32 chan, iio_idx = 0, status;
> > > > >  	int ret;
> > > > >  
> > > > >  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> > > > > @@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > > > >  		    !assign_iio)
> > > > >  			continue;
> > > > >  
> > > > > +		/*
> > > > > +		 * Copper trace and leak detector sensors without a custom table
> > > > > +		 * produce only a resistance result; the chip does not populate
> > > > > +		 * the temperature result register. Emit only an IIO_RESISTANCE
> > > > > +		 * channel in this case.    
> > > > 
> > > > Do we care?  That is are they useful without the table? We could just make it
> > > > required in the binding.
> > > >     
> > > 
> > > The datasheet specifies the table is optional. But more practically, in order to
> > > be able to add accurate values to the custom table, the users first need to measure
> > > the sensor's resistance at multiple known conditions, so I think the resistance-only
> > > output is useful during that characterization phase, before the table exists. Making
> > > it required would force users to provide placeholder values just to get the driver
> > > to probe.  
> > Who cares of datasheet is crazy :)  
> 
> Fair enough :)

Nice if I could type "if" obviously!

> 
> > 
> > The initial case could I think be handled by an 'identity' table. 
> > If it's useful in more general cases maybe we should always put out the resistance
> > channels? This would be a bit like we often do for ambient light sensors, where
> > we have a computed illuminance channel (IIO_LIGHT) + the data it comes from
> > (IIO_INTENSITY)  
> 
> I checked internally and we could make the table required for leak detectors. For
> copper traces, sub-ohms variants cannot have one, but we could make it required
> for > 1ohm ones.
Great. Thanks for chasing that down.

> 
> This means we could remove the LTC2983_SENSOR_LEAK_DETECTOR from the if condition,
> and have something like this in ltc2983_setup:
> 
> if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE) {
>     if (st->sensors[chan]->n_iio_chan == 1) {
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>         continue;
>     }
> }
> + the n_iio_chan == 2 check at the end
> 
> or drop the n_iio_chan == 2 check and do something like:
> 
> if (st->sensors[chan]->type == LTC2983_SENSOR_COPPER_TRACE) {
>     if (st->sensors[chan]->n_iio_chan == 1) {
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     } else {
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_TEMP, iio_chan_t++, chan);
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     }
>     continue;
> }
> 
> if (st->sensors[chan]->type == LTC2983_SENSOR_LEAK_DETECTOR) {
>     st->iio_chan[iio_idx++] =
>         LTC2983_CHAN(IIO_COVERAGE_PERCENT, iio_chan_c++, chan);
>     st->iio_chan[iio_idx++] =
>         LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     continue;
> }
> 
> or use a switch case:
> 
> switch (st->sensors[chan]->type) {
> case LTC2983_SENSOR_COPPER_TRACE:
>     if (st->sensors[chan]->n_iio_chan == 1) {
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     } else {
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_TEMP, iio_chan_t++, chan);
>         st->iio_chan[iio_idx++] =
>             LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     }
>     continue;
> case LTC2983_SENSOR_LEAK_DETECTOR:
>     st->iio_chan[iio_idx++] =
>         LTC2983_CHAN(IIO_COVERAGE_PERCENT, iio_chan_c++, chan);
>     st->iio_chan[iio_idx++] =
>         LTC2983_CHAN(IIO_RESISTANCE, iio_chan_r++, chan);
>     continue;
> case LTC2983_SENSOR_DIRECT_ADC:
>     chan_type = IIO_VOLTAGE;
>     iio_chan = &iio_chan_v;
>     break;
> default:
>     chan_type = IIO_TEMP;
>     iio_chan = &iio_chan_t;
>     break;
> }
> st->iio_chan[iio_idx++] = LTC2983_CHAN(chan_type, (*iio_chan)++, chan);
> 
> What do you think?
> 
I don't immediately have a strong opinion. So choose which ever
looks most readable in situ.

Jonathan


> Thanks,
> Liviu

