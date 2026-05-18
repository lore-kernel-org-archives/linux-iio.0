Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93FC33C18E;
	Mon, 18 May 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779112692; cv=none; b=hGjufDXK5U97hXiZfmrBHXHYjv/YpJQGsf9K6cEkefZM6hhE9MDNKqFYnjYiZeql64Is/D7r8P56hK2Rn3us83NExdfrbvieRhQt4Uxx22OburqhN5E6TGXdBLeD4VjdNbQ2x55PLn2xY4JbG/BSBLnfpWlgiEn5APTMCT8oZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779112692; c=relaxed/simple;
	bh=gOI3EtloXE0vHYMEZCfbRQeCy1ZlZvJfZkwlX480TPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bzgXXrgt5TeudwFDYPUvtE4/38K1k48AjxMeUeTTo67Gf1+qENscPN/pyoyRY3l3IGZGSuSC5HBIX/h1PYgo2m0Tleaybk+nBhGYbiYD2YhTNfuvnbEJ6ADIs9wH8wczx1k7FpZaveGkafRWeRubKLRFlH295XqCyTmYbV5aPZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bqYwfhfM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bqYwfhfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E592AC2BCB8;
	Mon, 18 May 2026 13:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779112692;
	bh=gOI3EtloXE0vHYMEZCfbRQeCy1ZlZvJfZkwlX480TPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bqYwfhfMjeWA65q0d9uh8/VTMia6+9/IcsQ8D2ICOlzs223Cyrp5u28df+cM0vQ+v
	 RCs4EcPii4Wwg/nTlq4JoW3C1hsiYP9H+Z0LJ71Ej9WghhwtcBQeL990fkl4ETVg9C
	 5N5cFQGebPf4e0IVpCqV0VGKtxM4Sl0/XhFyBMZYLftqw5/LhNs+Rm1VWYUmQLheLi
	 djF7Q5NSk+QFbxEby9NGlhQhF+ucFGK1C5J6JlxhYPHCzQpr+Gitdrpa7INqFh533n
	 LTK3VTpj2TMfEIf6GSxnY+a0goR0frk9+r82vllx3nSGfXFWYMvciMXlLTbkWNEZaq
	 1+CiYyPWfPWiA==
Date: Mon, 18 May 2026 14:58:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liviu Stan <liviu.stan@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Antoniu
 Miclaus <antoniu.miclaus@analog.com>, Francesco Lavra
 <flavra@baylibre.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux@analog.com>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 7/7] iio: temperature: ltc2983: Add support for
 ADT7604
Message-ID: <20260518145802.49a3bc94@jic23-huawei>
In-Reply-To: <20260518080731.83585-1-liviu.stan@analog.com>
References: <20260516181250.039e154a@jic23-huawei>
	<20260518080731.83585-1-liviu.stan@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 18 May 2026 11:07:17 +0300
Liviu Stan <liviu.stan@analog.com> wrote:

> On Sat, 16 May 2026 18:12:50 +0100 Jonathan Cameron <jic23@kernel.org> wrote:
> > > 
> > >  drivers/iio/temperature/ltc2983.c | 401 ++++++++++++++++++++++++++++--
> > >  1 file changed, 386 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
> > > index bf435e965c6d..acd043ed62f5 100644
> > > --- a/drivers/iio/temperature/ltc2983.c
> > > +++ b/drivers/iio/temperature/ltc2983.c
> > > @@ -28,6 +28,8 @@
> > >  #define LTC2983_STATUS_REG			0x0000
> > >  #define LTC2983_TEMP_RES_START_REG		0x0010
> > >  #define LTC2983_TEMP_RES_END_REG		0x005F
> > > +#define ADT7604_RES_RES_START_REG		0x0060
> > > +#define ADT7604_RES_RES_END_REG			0x00AF
> > >  #define LTC2983_EEPROM_KEY_REG			0x00B0
> > >  #define LTC2983_EEPROM_READ_STATUS_REG		0x00D0
> > >  #define LTC2983_GLOBAL_CONFIG_REG		0x00F0
> > > @@ -186,17 +188,43 @@ enum {
> > >  	LTC2983_SENSOR_SENSE_RESISTOR = 29,
> > >  	LTC2983_SENSOR_DIRECT_ADC = 30,
> > >  	LTC2983_SENSOR_ACTIVE_TEMP = 31,
> > > +	/* Sensor types for some parts only; map to RTD_CUSTOM/THERMISTOR_CUSTOM in HW */
> > > +	LTC2983_SENSOR_COPPER_TRACE = 32,
> > > +	LTC2983_SENSOR_LEAK_DETECTOR = 33,  
> > Given you care about being in range of this I'd add
> > 	LTC2983_SENSOR_NUM  
> > >  };  
> >   
> > > @@ -1329,7 +1649,7 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> > >  	if (!st->sensors)
> > >  		return -ENOMEM;
> > >  
> > > -	st->iio_channels = st->num_channels;
> > > +	st->iio_channels = 0;
> > >  	device_for_each_child_node_scoped(dev, child) {
> > >  		struct ltc2983_sensor sensor;
> > >  
> > > @@ -1357,7 +1677,13 @@ static int ltc2983_parse_fw(struct ltc2983_data *st)
> > >  			return dev_err_probe(dev, ret,
> > >  				"adi,sensor-type property must given for child nodes\n");
> > >  
> > > -		dev_dbg(dev, "Create new sensor, type %u, chann %u",
> > > +		if (sensor.type > LTC2983_SENSOR_LEAK_DETECTOR ||  
> > 
> > To make it easier to extend in future, perhaps add the NUM entry I mention
> > above then >= to it here.
> >   
> 
> This makes sense. I will change in v3. Thanks!
> 
> > > +		    !(st->info->supported_sensors & BIT_ULL(sensor.type)))
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +					     "sensor type %d not supported on %s\n",
> > > +					     sensor.type, st->info->name);
> > > +
> > > +		dev_dbg(dev, "Create new sensor, type %u, channel %u",
> > >  			sensor.type, sensor.chan);
> > >    
> >   
> > > @@ -1445,8 +1782,9 @@ static int ltc2983_eeprom_cmd(struct ltc2983_data *st, unsigned int cmd,
> > >  
> > >  static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > >  {
> > > -	u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0, status;
> > >  	struct device *dev = &st->spi->dev;
> > > +	u32 iio_chan_t = 0, iio_chan_v = 0, iio_chan_r = 0, iio_chan_c = 0;
> > > +	u32 chan, iio_idx = 0, status;
> > >  	int ret;
> > >  
> > >  	/* make sure the device is up: start bit (7) is 0 and done bit (6) is 1 */
> > > @@ -1493,8 +1831,26 @@ static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
> > >  		    !assign_iio)
> > >  			continue;
> > >  
> > > +		/*
> > > +		 * Copper trace and leak detector sensors without a custom table
> > > +		 * produce only a resistance result; the chip does not populate
> > > +		 * the temperature result register. Emit only an IIO_RESISTANCE
> > > +		 * channel in this case.  
> > 
> > Do we care?  That is are they useful without the table? We could just make it
> > required in the binding.
> >   
> 
> The datasheet specifies the table is optional. But more practically, in order to
> be able to add accurate values to the custom table, the users first need to measure
> the sensor's resistance at multiple known conditions, so I think the resistance-only
> output is useful during that characterization phase, before the table exists. Making
> it required would force users to provide placeholder values just to get the driver
> to probe.
Who cares of datasheet is crazy :)

The initial case could I think be handled by an 'identity' table. 
If it's useful in more general cases maybe we should always put out the resistance
channels? This would be a bit like we often do for ambient light sensors, where
we have a computed illuminance channel (IIO_LIGHT) + the data it comes from
(IIO_INTENSITY)

Jonathan

> 
> Thanks,
> Liviu
> 

