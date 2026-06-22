Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1513911C0
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 08:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782118263; cv=none; b=ItCF8BSAMscQf0IChcNoAAALfrSpyQozmJH6xZ4XIcNA1bo+QbhE8bV273CL9NNL9hq+TOUO8DPI+A8+zRw/KZ7kAf19+ckmOLF94+td/5k9TN6/wcMxVhZXdQ7ti6MeVkdA7iGMwZOS4QlWPftVkuE8Ug3vY1drhCP+PNBbGdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782118263; c=relaxed/simple;
	bh=8cxYJffMTcRoiH1t6rIKcnnfOIswC1goyaxXlOhGaIw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gIbL5BFg9Vtn3Mi+hF45uB1Im1U91mHe1A90vk20FtrsXWGX1jYbt9B9INXRz8LemYATtwAC+YfkNOAWsrTR2JnwmnI0Zwc8Zb8gL5+4sJfMZdHk/EHnH0HYo5VHBebBqX8FRCHBY5UGGDuN6b96wvvSgUvA5FNFqi9hQtboSGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSTzfNdA; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSTzfNdA"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6978f1eeb87so1943520a12.0
        for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782118260; x=1782723060; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nmNXJUQs9yO1XdMAOL14hcf+fv2uHMoUTTUvjBKx4vc=;
        b=aSTzfNdApvgJ33BZ9psuFaGvsY4F67R5bDTR0SsAPKYwTMZ8ecD0hccM/14SWIDClF
         v9pGkk345XGMz3IODs7zVc7Zo/eY4KuPnrRbjFL1VjKR4lyGNmpsQ73EY7nG8qFtUzbp
         33KcLY+uPofqYOctyZN5JyAPPrbdYmjCYX1YZrbdxMVo4kcKWP9T8KEYGW4MHq3Wf3vG
         Feoh5HmQovsBr+fJjGSW0ECcteVps/heI1AVeKKlPoM+10KFuCL4TS5tM6/99/8Jhmnq
         AHIOyzpn3Icp+rPft1khqk574kKdsWTx/YxxzAWkhebF6pdd38cMDXI5lsNsjq4mGeRf
         VoTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782118260; x=1782723060;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nmNXJUQs9yO1XdMAOL14hcf+fv2uHMoUTTUvjBKx4vc=;
        b=oAschBZjLevc6jgqzuVzAEIWWl/56BoFiOHfEwupQ96gX0uuUtHqHkq0uOdGljRQEo
         bnGyl2orHSlzvRFN8Q93HL6lHZTpVRaHyyomkbpIR4oPldir5APkheOuNmkyJmfkGRzR
         O5cwkAbAo0MA7ZQRGFzA1M3VkC7rUZx2A3Sduo2Tajl5JVA6T3AJli0XQlmf3oAam/hF
         f+fpiGQnaDgRJy8zYy9NmZb3O5qrsgS5w7FpY+8nJ7miNYv3NGOiWqblsNYWS0z4ovoO
         r+HEmGx3twsPwhoWeA3fBGb+3YwbPY1WZ5mKtahWFxyMSc9I5snKisZPhQyfJPBF75EM
         ifdg==
X-Forwarded-Encrypted: i=1; AFNElJ8GGTec6VFCIhUzUhkd16nLlr4LpJbRMsgFFxLImu6tMskG5Er2Rg5EJR7QfB4/KmKlxqpw8+jNSm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn2Y9CMOpJi+UdnNvmw9+qhzgB3BtNf0cMd/7N48S1jPuMgdgb
	G4ujHYXrIanJYIlHxotr+B3SpCO+tJZtDfk6AB2hLeo6ff7GDE1Hx4wa
X-Gm-Gg: AfdE7cnwoiVsyLAfVz4RRh172jiQXLFIat8i6M0lkSjPx0Cq+sgTn1p9b2xemWyMLjj
	U2BiMrQykRd1DvSGSZRgzIomVsL0HtOcNlsazzUpPOxb6u7yVip15uAatDhIgakuJHIL3wGGqb5
	sYWMDMsiqZhtf9WurI/t/GALxZMcR+HiODvBzAPQb8TDxdmE2FQTw9Ott5v1d9GZnYbfN/rkAv+
	Qyj4MffiJjft0l9MX6yief1QimBHgEZuIam/OyU+0moaqWpH0n2jZ8W+7T0sURQK8ZrqrPjCICw
	X/6hr7m6yFqHcupE5yRz3ZuHY/2IVop1QDsUibbjoa5FWynWyN30ONMLji0D3PVF5qvWypEPqgC
	v/NJDSPIf92H7kQ1k6pCi5gCMMxX4PySNW5BoVXODV3mTxtVzC7QctJxk9i6fmW3mB2WNjjD9rb
	28ld0yYWPe9+gdps529ePbQk3Km5pUBRETcrT9xVR/Gjsfs3CPaxact9XSxjFm46f4O2P9CdVzW
	eBhPOm3xTyGxCc7iGvqQUcH1ENH
X-Received: by 2002:a17:907:c09:b0:be5:2bc0:5370 with SMTP id a640c23a62f3a-c097c9c79dcmr629568666b.36.1782118259798;
        Mon, 22 Jun 2026 01:50:59 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c0c5ef8acaesm317407166b.27.2026.06.22.01.50.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:50:59 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rdealenc@rdealenc-l01.ad.analog.com>
Date: Mon, 22 Jun 2026 09:50:53 +0100
To: David Lechner <dlechner@baylibre.com>, rodrigo.alencar@analog.com, 
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v3 09/12] iio: dac: ad5686: implement new sync() op for
 the spi bus
Message-ID: <3i3fdq6qjd2h4o4wwicl4zlpzyggzb7gljm2acwz33k75ds57k@7mdevoavx3ao>
References: <20260616-ad5686-new-features-v3-0-f829fb7e9262@analog.com>
 <20260616-ad5686-new-features-v3-9-f829fb7e9262@analog.com>
 <50a7e765-ba20-45c0-8a13-5e672413b600@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <50a7e765-ba20-45c0-8a13-5e672413b600@baylibre.com>

On 20/06/26 11:33, David Lechner wrote:
> On 6/16/26 3:21 AM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.

...

> > +/**
> > + * struct ad5686_spi_data - SPI bus specific data
> > + * @msg: SPI message used for transfers
> > + * @size: number of transfers currently in the message
> > + * @capacity: maximum number of transfers that can be added to the message
> > + * @xfers: array of SPI transfers, allocated with the provided capacity
> > + */
> > +struct ad5686_spi_data {
> > +	struct spi_message msg;
> > +	unsigned int size;
> > +	unsigned int capacity;
> > +	struct spi_transfer xfers[] __counted_by(capacity);
> > +};
> > +
> >  static int ad5686_spi_write(struct ad5686_state *st,
> >  			    u8 cmd, u8 addr, u16 val)
> >  {
> > -	struct spi_device *spi = to_spi_device(st->dev);
> > -	u8 tx_len, *buf;
> > +	struct ad5686_spi_data *bus_data = st->bus_data;
> > +	struct spi_transfer *xfer;
> >  
> > +	if (bus_data->size >= bus_data->capacity)
> > +		return -E2BIG;
> > +
> > +	if (bus_data->size)
> > +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
> > +	else
> > +		spi_message_init(&bus_data->msg);
> 
> Seems odd that spi_message_init() is called conditionally. What
> prevents spi_message_add_tail() from growing the message unbounded
> on repeated calls?

The "size >= capacity" check right above this.

> 
> > +
> > +	xfer = &bus_data->xfers[bus_data->size];
> >  	switch (st->chip_info->regmap_type) {
> >  	case AD5310_REGMAP:
> > -		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> > -					      val);
> > -		buf = &st->data[0].d8[0];
> > -		tx_len = 2;
> > +		st->data[bus_data->size].d16 =
> > +			cpu_to_be16(AD5310_CMD(cmd) | val);
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d16,
> > +			.len = sizeof(st->data[bus_data->size].d16),
> > +		};
> >  		break;
> >  	case AD5683_REGMAP:
> > -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> > -					      AD5683_DATA(val));
> > -		buf = &st->data[0].d8[1];
> > -		tx_len = 3;
> > +		st->data[bus_data->size].d32 =
> > +			cpu_to_be32(AD5686_CMD(cmd) | AD5683_DATA(val));
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d8[1],
> > +			.len = sizeof(st->data[bus_data->size].d32) - 1,
> > +		};
> >  		break;
> >  	case AD5686_REGMAP:
> > -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> > -					      AD5686_ADDR(addr) |
> > -					      val);
> > -		buf = &st->data[0].d8[1];
> > -		tx_len = 3;
> > +		st->data[bus_data->size].d32 =
> > +			cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr) | val);
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d8[1],
> > +			.len = sizeof(st->data[bus_data->size].d32) - 1,
> > +		};
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}
> >  
> > -	return spi_write(spi, buf, tx_len);
> 
> If this function no longer writes, should we change the name of
> the function to something like ad5686_spi_write_prepare_msg()?
> 
> > +	spi_message_add_tail(xfer, &bus_data->msg);
> > +	bus_data->size++;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad5686_spi_sync(struct ad5686_state *st)
> > +{
> > +	struct spi_device *spi = to_spi_device(st->dev);
> > +	struct ad5686_spi_data *bus_data = st->bus_data;
> > +
> > +	bus_data->size = 0; /* always reset, even on sync failure */
> > +	return spi_sync(spi, &bus_data->msg);
> >  }
> >  
> >  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> >  {
> > -	struct spi_transfer t[] = {
> > -		{
> > -			.tx_buf = &st->data[0].d8[1],
> > -			.len = 3,
> > -			.cs_change = 1,
> > -		}, {
> > -			.tx_buf = &st->data[1].d8[1],
> > -			.rx_buf = &st->data[2].d8[1],
> > -			.len = 3,
> > -		},
> > -	};
> >  	struct spi_device *spi = to_spi_device(st->dev);
> > +	struct ad5686_spi_data *bus_data = st->bus_data;
> > +	struct spi_transfer *xfer = &bus_data->xfers[0];
> >  	u8 cmd = 0;
> >  	int ret;
> >  
> > @@ -85,8 +117,21 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> >  				      AD5686_ADDR(addr));
> >  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
> >  
> > -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> > -	if (ret < 0)
> > +	xfer[0] = (struct spi_transfer) {
> > +		.tx_buf = &st->data[0].d8[1],
> > +		.len = sizeof(st->data[0].d32) - 1,
> 
> Would make more sense to say `sizeof(st->data[0].d8) - 1` since
> the buffer is  &st->data[0].d8[1].

the buffer is d8[1], d8[2] and d8[3], skipping d8[0], for a len = 3.

> > +		.cs_change = 1,
> > +	};
> > +	xfer[1] = (struct spi_transfer) {
> > +		.tx_buf = &st->data[1].d8[1],
> > +		.rx_buf = &st->data[2].d8[1],
> > +		.len = sizeof(st->data[1].d32) - 1,
> 
> And here.
> 
> > +	};
> > +
> > +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
> > +
> > +	ret = spi_sync(spi, &bus_data->msg);
> > +	if (ret)
> >  		return ret;
> >  
> >  	return be32_to_cpu(st->data[2].d32);
> > @@ -95,12 +140,26 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
> >  static const struct ad5686_bus_ops ad5686_spi_ops = {
> >  	.write = ad5686_spi_write,
> >  	.read = ad5686_spi_read,
> > +	.sync = ad5686_spi_sync,
> >  };
> >  

-- 
Kind regards,

Rodrigo Alencar
