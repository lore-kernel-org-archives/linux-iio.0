Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D7D23E325
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769962623; cv=none; b=B8c56obqZj8NkBaPrwkTlNsn5IJWzXvifnzFfBw928MUfjjvpJcxdTqjfEbssYBDWJRHbZAbawPJJTaqr5ec5K0uYL5BXHCth4xgGZ8V+bVlt/54MqdThwCBHB/46FSfDrhYD9SJoxoBUsXnK2I2eZk3NW3Lftipie6KUMEAanc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769962623; c=relaxed/simple;
	bh=BKa8SBN4plHpTsV/Y4RchZt4nx8QkRJkjA0ba5l6Klk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1SI/MAAkH//R1M1RL+FNSulnXjtCAqaYRxruA4DuDDFUvrCiRP8go7NbMplJTRu5KCb6yu7HLXrh+MD2lMXJ2SzuOAiIIxp0zagvAURqGg+ixJCY+lfUEW1072kS7Br8F2mhOPTM6p8rSeb2Zjy2MPpwxKhLqyN2GwWgUqdiEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1vma86-0003Gr-EC; Sun, 01 Feb 2026 17:16:54 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vma85-003axm-36;
	Sun, 01 Feb 2026 17:16:53 +0100
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1vma85-00AMMI-0S;
	Sun, 01 Feb 2026 17:16:53 +0100
Date: Sun, 1 Feb 2026 17:16:53 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Sander Vanheule <sander@svanheule.net>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v2 5/8] iio: dac: ds4424: convert to regmap
Message-ID: <aX98dbnCcFnFY3ks@pengutronix.de>
References: <20260127060939.3914006-1-o.rempel@pengutronix.de>
 <20260127060939.3914006-6-o.rempel@pengutronix.de>
 <2cfd142fbaad3ddd3b3fb632c77a4e9f58d50f66.camel@svanheule.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2cfd142fbaad3ddd3b3fb632c77a4e9f58d50f66.camel@svanheule.net>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org

Hi Sander,

On Sun, Feb 01, 2026 at 03:42:28PM +0100, Sander Vanheule wrote:
> Hi Oleksij,
> 
> On Tue, 2026-01-27 at 07:09 +0100, Oleksij Rempel wrote:
> > Refactor the driver to use the regmap API.
> > 
> > Replace the driver-specific mutex and manual shadow buffers with the
> > standard regmap infrastructure for locking and caching.
> > 
> > This ensures the cache is populated from hardware at probe, preventing
> > state desynchronization (e.g. across suspend/resume).
> 
> 
> [...]
> 
> > +static const struct regmap_access_table ds44x4_table = {
> > +	.yes_ranges = ds44x4_ranges,
> > +	.n_yes_ranges = ARRAY_SIZE(ds44x4_ranges),
> > +};
> >  
> > -static int ds4424_set_value(struct iio_dev *indio_dev,
> > -			     int val, struct iio_chan_spec const *chan)
> > +static const struct regmap_config ds44x2_regmap_config = {
> > +	.reg_bits = 8,
> > +	.val_bits = 8,
> > +	.cache_type = REGCACHE_FLAT,
> > +	.max_register = DS4424_DAC_ADDR(1),
> > +	.rd_table = &ds44x2_table,
> > +	.wr_table = &ds44x2_table,
> > +};
> 
> Note that REGCACHE_FLAT will allocate 0xF8 unsigned longs you will never use.
> REGCACHE_MAPLE will probably be much closer to the size of the original value
> cache, for a small look-up performance penalty (but always fast compared to the
> I2C bus).

ACK, already migrated to REGCACHE_MAPLE in the v3:
https://lore.kernel.org/all/20260128153824.3679187-8-o.rempel@pengutronix.de/

Which works mostly fine except of the cache initialisation. If I use
num_reg_defaults_raw with REGCACHE_MAPLE as proposed by Andy
Shevchenko, first access to regmap values over debugfs will explode with
NULL pointer etc...
If I remove num_reg_defaults_raw, I need to read register manually
to init defaul values as implemented in v3.

The REGCACHE_FLAT has one more problem, the cache will be inited with
i2c NACKs (0xFF) if used with num_reg_defaults_raw.

> [...]
> 
> > @@ -163,49 +184,52 @@ static int ds4424_write_raw(struct iio_dev *indio_dev,
> >  
> >  static int ds4424_verify_chip(struct iio_dev *indio_dev)
> >  {
> > -	int ret, val;
> > +	struct ds4424_data *data = iio_priv(indio_dev);
> > +	u8 raw_values[DS4424_MAX_DAC_CHANNELS];
> > +	int ret;
> >  
> > -	ret = ds4424_get_value(indio_dev, &val, 0);
> > -	if (ret < 0)
> > -		dev_err(&indio_dev->dev,
> > -				"%s failed. ret: %d\n", __func__, ret);
> > +	/* Bulk read all channels starting at 0xf8.
> > +	 * This populates the regmap cache with current HW values.
> > +	 */
> > +	ret = regmap_bulk_read(data->regmap, DS4424_DAC_ADDR(0),
> > +			       raw_values, indio_dev->num_channels);
> 
> Are you forcing a HW-to-cache sync for performance?

See response above.

> Previously this function would just read a single value to verify a reply was
> sent, instead of seeding the cache in data->raw, so that's a change in behavior
> (and purpose) of this function, meaning you may want to change the name if you
> keep this.
> 
> You could (should IMHO) use a sparse cache, which is actually aware of its
> content's validity and will transparently access the device on the first access
> to initialize itself. I would recommend REGCACHE_MAPLE as above, but
> REGCACHE_FLAT_S also works. REGCACHE_FLAT is tricky to properly initialize [1],
> and I would not recommend using it in new code.

Ok, thx!

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
