Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794885064;
	b=z3dMCQ/MdxLpBlCIbTMqz9rQ12jwSlU+uN6kx+UtJXcKXzMMIXppQ6lepJYD4pjkQdxQ
	 jl/GthcyiIzZb5cKchsCScll43BGlarTxeY18m8rqrsaWv/8Wr6x9+pOwNa3Z9AsYwwk5
	 Fk8lMdoNIn92Cz8Kyit3LgphSjI3uP0sWq3u59dhHAl1T8bhWCMnv7NrKkKoKDKGfPa6h
	 ZnUDpSxIDGx2CbOMdMp8ng7LUZ1LVcwaV81uWL73vZMrj6BhqDdqEtdLe/JiYVs7lforq
	 uS/7sphGTE3byPG07MWMCZc8HJKH3fGBSdeJnIaMB3O6HCLy1W6V2BenYNJJruHnoNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794885064;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dSfXqLyo1DSgUCjb2gDQy+lRJPX2i3GEqXsEkxQ7JxM=;
	b=p8dlzkU/k0tAqQNd1H+W7HX4lV/sEroDFWpujd/Bu1vs/Hr4vYqwGEzjownR82F1br0L
	 3NcatngQysdOZOgURY63frTqT23Slu16VyPIEpGGWSgIgeGTSycOoNgGOTXolYB8gTsLZ
	 GhHJXek2CEx9bnYDludaJ2FHDbB9odJFCSPN2k4SAtBTjA0KKlT06QQbGL9YHUZvks4QY
	 9iuiENLDAFTZXStJB0L26jqINrMhzuG59nMEfkkF+2X2eouACU6Mw1hS7MAft7130Nlan
	 u4oRqK9rG3KvyEvplo1we55wI2QPZkkvK9i2CwACL2TS4G/FvGRRUQTfZljVWcVeb8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHIhEXoT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FC4606A31C;
	Tue, 17 Nov 2026 03:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHIhEXoT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D1D21F000C4;
	Tue, 17 Nov 2026 03:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794885064;
	bh=dSfXqLyo1DSgUCjb2gDQy+lRJPX2i3GEqXsEkxQ7JxM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lHIhEXoTXimq2mntEZ8HmrSDDjnodkHPryB6SWInk6OUSwzyX2kI0mDvaKIsH3P33
	 noZIUv6Z+HRkp7ynMEcIjFu530tLeuEt+Hlqk1kB5Ukjm2EzpHSSFFeOEq0UQcq015
	 19GO8nsQQ1ZddSa4kzWhmElX7gqx3ufkLIoWo4Zlxe++8Kr1POyMF28eeQ5WY+fsRX
	 Ako7KvZG8cNOahLRWcCS+4WGpxn03H4RRkP8lcS22fXyJOG0bF3leds3nKVytsLvCI
	 lxP+XBqD/kdG7mXwDMgysBMvB3LlsXSfbnU9ThxSbltsNpm1GM01+qX+yUb0C1Rjsd
	 oFY8AjiZyQiCA==
Date: Tue, 17 Nov 2026 03:10:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Patrick Fischer via B4 Relay
 <devnull+admin.tsv-stahl-riesa.de@kernel.org>, admin@tsv-stahl-riesa.de,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>,
 Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, Svyatoslav Ryhel
 <clamor95@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: light: Add Capella CM3217 ambient light
 sensor driver
Message-ID: <20261117031057.58cb5e7e@jic23-hlaptop>
In-Reply-To: <avrLkP1IR449AwLy@ashevche-desk.local>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
	<20261113-upstream-iio-cm3217-v3-2-c4d5b2485dff@tsv-stahl-riesa.de>
	<20261114012906.6f66edce@jic23-hlaptop>
	<avrLkP1IR449AwLy@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 11:23:28 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Sat, Nov 14, 2026 at 01:29:06AM +0000, Jonathan Cameron wrote:
> > On Fri, 13 Nov 2026 20:59:00 +0100
> > Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org> wrote:  
> 
> ...
> 
> > > +static int cm3217_probe(struct i2c_client *client)
> > > +{
> > > +	struct device *dev = &client->dev;
> > > +	struct cm3217_data *data;
> > > +	struct iio_dev *indio_dev;
> > > +	u16 addr_lsb = CM3217_ADDR_CMD2_LSB;
> > > +	u32 reg[2];
> > > +	u8 cmd1, cmd2;  
> 
> Keep reversed xmas tree order.
> 
> > > +	int ret;
> > > +
> > > +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	data = iio_priv(indio_dev);
> > > +	data->client = client;
> > > +	i2c_set_clientdata(client, indio_dev);
> > > +
> > > +	ret = devm_mutex_init(dev, &data->lock);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = devm_regulator_get_enable(dev, "vdd");
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "failed to enable vdd supply\n");
> > > +
> > > +	/* Without a firmware node (e.g. sysfs new_device) use the fixed one */  
> > 
> > I'd rather we handled that explicitly.
> > 
> > 	if (dev_fwmode(dev))
> > 
> > That way we can return an error if there is firmware but it's broken.  
> 
> I think here we want
> 
> 	if (device_property_present()) {
> 		...
> 	} else {
> 		addr_lsb = CM3217_ADDR_CMD2_LSB;
> 	}
> 
> I really discourage people to check for FW node presence with dev_fwnode(dev).
> This is a corner case which is in most cases needs better granularity (like
> distinguishing the fwnode by type). But in general ideally it has not to be
> used at all.
I agree though in this particular case a property presence check doesn't
solve the same gap.  The intent was to pick up on the driver having been
force loaded without firmware.  Normally we'd just fail that given it
looks like it needs firmware. In practice it doesn't as the address this
give is always one greater than the device address.

Thinking more on that, just don't read it from firmware at all.  It's
fine that the binding wants to describe it, but we don't have to ask
the firmware when we know the answer.

Jonathan

> 
> > > +	if (!device_property_read_u32_array(dev, "reg", reg, ARRAY_SIZE(reg)))
> > > +		addr_lsb = reg[1];  
> 

