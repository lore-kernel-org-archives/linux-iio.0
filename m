Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B7243C065
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961078; cv=none; b=SYW1SYAVR4pWv3b7692K415TqEPDcBGfyZ7qV5LR4ZIEEn0j83HzR6rMW2Hg8Nl0utssEX84BkuxbozXly72KHRzWCogTa9f40wdwp92ihsF5mcvX1pzPkqzIEb9tWt95+LIr0lTAwLmn1RTIn0rTPI7gOCX2YMAEt2KFHv+n30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961078; c=relaxed/simple;
	bh=nNTqNq7xMs/jXDzPl/ePNEIhBvhz9TuNxBRMnOKKpbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZmMDYe7xNc7r4sPPdCcNrEcNcUdn6FzpCn6oj+n47gHEm6n/Jy7L6O6MmLrEEmEWgd82Kuetvg232kFdJKfugD9AkVmhYaqTyymt49qyHSaXIZo/bGnSgJGdUeByTM9sw8k+yXApuq6vMdjmiGPzCSQWSRQhQVlYib5H44rFIoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlwg+Fqw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlwg+Fqw"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-493c733f15aso31932325e9.0
        for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783961075; x=1784565875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RjYd7MVan8krnGSSqxV4jQoaD7g5/4a0TcjKtRhjtfw=;
        b=dlwg+FqwRh8SusCqwS5NGG9ZMqUONQ4E8LG72Ld/UwR73FTMPLsHYAD8GlQ327ZSwx
         Gc2so+x1H/m62G4Mleryiaw2Kwo44o87e9PCTMkdDgd7BNL1d99q08OJAVr57gQUmtEp
         R0xU72+kGS++sXve1n6fblxlEyOzdbAibCkFL05xIBk/JFETPEa4YXe7wfYjsGvDwgG/
         zSTuJSVQralsKAUjxF4JXOx200H/0e1NNnbTdAfv2A6HJMie37IWpwQHOxpYL/nrNZwl
         2XVHpBx3TIDmqODu3eu0tcKBm3BjgOFfQhIg3bssIa/b8UiqKga1tJ9HZqt7KQD5oKGf
         MsCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783961075; x=1784565875;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RjYd7MVan8krnGSSqxV4jQoaD7g5/4a0TcjKtRhjtfw=;
        b=ftaEtGAilkExt2bJhZuYakOeEnf6nOdHNR7P9fdV1xNT7ZbVDCtLuU1nWu9WkpWFz0
         9qINi7aZNGAy/61wr8JeTBTwwCdmDcEnlg6C6+7jrA6y1wGCI6fBeXrRL7e3WYNoR4d5
         VIXIEOWZiNGKuo8OnyO63vPM9hEUj/uzS0tDdh0E7WDiuj/bUUv5OW5s6TKw7tzcuHYG
         whjCBGwliArW7oYmYX6HICf3pDieAC88NbGWCzpjdDgU/kpvjbs4H0BrZDYiLK5IsITD
         9COOO7eZT4AkkuDLLGnebfywKtmwK+hPaVQmhKAq9r88/yK4vqGHmPOASQBRf9x37i02
         Ir9w==
X-Forwarded-Encrypted: i=1; AHgh+Rr23CXO+ogK5DfKM3L6dI+6o62/AXhxLz52TdTtHOKG8H8kli0V6zYv9aJ876qJB0v2c6t9IOqZN4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfADQtfotvjU/r7O2r/O/1T95ptZrau7A54OxAgP2os6ffi20J
	Wrqdvb2abhMmHuy/w8q1Jyzr7/BUwV3eLztAUJzdhba9Yrx9beQIQ2n/
X-Gm-Gg: AfdE7cldUUh0rYl35xMTGsR6csJtg0DSbwZIUB3trbsSg4fqKZ/shO0zjynKQuxARUq
	0/uDEvYUt2KF/zOvD5CnVhWxnyRGuJsN+St6ioNJs9giiCH54ziOjKthE1rrpKDWln/p7vd7YGv
	VRiCj7mHCTl9q7rbwaBAaNmDz796Bx/XzctB7VtuAPvfjKx+Ovj4sIz2jk+4K7zNrhr2OBIH0Hq
	N5yuF2VahJIqnBTPyR6HArzglz/nq8ufuOEhvDalB9agSIwLtBMIhYG2nas0qAwNJKpopzOn4bW
	FLjT6TfqcSwOPqT7tMzgzudseKKHxRAZDUOPqvQ1tJG3kEbS12O1DUjnBACb0zrbP5553HLn3PW
	Ryl00W4Z71GQFxEkQTplbNb8X/Ns0rUr0QsxgJUyJsI5VQAQ/5qG2gc4uTUmNsCfJAIOxXtQwhI
	aXs6dzCXMfVIFpKP8MvMLxxaTkUUisl2i8ZOH9z+KgDTHKiA/9nv21fgXb9cp6DSx3G347lHNkV
	MVit0zLGYmT+5Hh
X-Received: by 2002:a05:600c:b99:b0:493:aaa2:f034 with SMTP id 5b1f17b1804b1-493f882ae23mr104948055e9.26.1783961075315;
        Mon, 13 Jul 2026 09:44:35 -0700 (PDT)
Received: from RDEALENC-L01.ad.analog.com (24.206.116.103.netskope-rdns.com. [24.206.116.103])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49508727f7dsm8128065e9.4.2026.07.13.09.44.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 09:44:34 -0700 (PDT)
From: Rodrigo Alencar <455.rodrigo.alencar@gmail.com>
X-Google-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Mon, 13 Jul 2026 17:44:28 +0100
To: David Lechner <dlechner@baylibre.com>, 
	Michael Auchter <michael.auchter@ni.com>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v7 4/7] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <satyxehagxb4zdqfmni7b57ipwyk6bmu5opkfquz2ie7ohne2s@jbobjkgdp2pk>
References: <20260710-ad5686-new-features-v7-0-1bcc8c280e4d@analog.com>
 <20260710-ad5686-new-features-v7-4-1bcc8c280e4d@analog.com>
 <931fe63d-d200-4b79-9e17-fa48c8de7f29@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931fe63d-d200-4b79-9e17-fa48c8de7f29@baylibre.com>

On 11/07/26 10:07, David Lechner wrote:
> On 7/10/26 6:20 AM, Rodrigo Alencar via B4 Relay wrote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > 
> > Use of local SPI bus data to manage a collection of SPI transfers and
> > flush them to the SPI platform driver with the sync() operation. This
> > allows for faster handling of multiple channel DAC writes, avoiding kernel
> > overhead per spi_sync() call, which will be helpful when enabling
> > triggered buffer support.

...

> >  static int ad5686_spi_write(struct ad5686_state *st,
> >  			    u8 cmd, u8 addr, u16 val)
> >  {
> > -	struct spi_device *spi = to_spi_device(st->dev);
> > -	u8 tx_len, *buf;
> > +	struct ad5686_spi_data *bus_data = st->bus_data;
> > +	struct spi_transfer *xfer;
> >  
> 
> This could use some comments similar to the explanation in the
> commit message that this function is just queuing writes to
> be sent over the bus when sync() is called.
> 
> > +	if (bus_data->size >= bus_data->capacity)
> > +		return -E2BIG;
> > +
> > +	if (bus_data->size)
> > +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
> > +	else
> > +		spi_message_init(&bus_data->msg);
> > +
> > +	xfer = &bus_data->xfers[bus_data->size];
> 
> Why not a local variable for st->data[bus_data->size] too so we don't
> have to write it so many times?

The union is anonymous.. is it fine to use:

	typeof(st->data[0]) *buf;
	...
	buf = &st->data[bus_data->size];

> 
> >  	switch (st->chip_info->regmap_type) {
> >  	case AD5310_REGMAP:
> > -		st->data[0].d16 = cpu_to_be16(FIELD_PREP(AD5310_CMD_MSK, cmd) |
> > -					      FIELD_PREP(AD5310_DATA_MSK, val));
> > -		buf = &st->data[0].d8[0];
> > -		tx_len = 2;
> > +		st->data[bus_data->size].d16 =
> > +			cpu_to_be16(FIELD_PREP(AD5310_CMD_MSK, cmd) |
> > +				    FIELD_PREP(AD5310_DATA_MSK, val));
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d16,
> > +			.len = sizeof(st->data[bus_data->size].d16),
> > +		};
> >  		break;
> >  	case AD5683_REGMAP:
> > -		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> > -					      FIELD_PREP(AD5683_DATA_MSK, val));
> > -		buf = &st->data[0].d8[1];
> > -		tx_len = 3;
> > +		st->data[bus_data->size].d32 =
> > +			cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> > +				    FIELD_PREP(AD5683_DATA_MSK, val));
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d8[1],
> > +			.len = sizeof(st->data[bus_data->size].d8) - 1,
> > +		};
> >  		break;
> >  	case AD5686_REGMAP:
> > -		st->data[0].d32 = cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> > -					      FIELD_PREP(AD5686_ADDR_MSK, addr) |
> > -					      FIELD_PREP(AD5686_DATA_MSK, val));
> > -		buf = &st->data[0].d8[1];
> > -		tx_len = 3;
> > +		st->data[bus_data->size].d32 =
> > +			cpu_to_be32(FIELD_PREP(AD5686_CMD_MSK, cmd) |
> > +				    FIELD_PREP(AD5686_ADDR_MSK, addr) |
> > +				    FIELD_PREP(AD5686_DATA_MSK, val));
> > +		*xfer = (struct spi_transfer) {
> > +			.tx_buf = &st->data[bus_data->size].d8[1],
> > +			.len = sizeof(st->data[bus_data->size].d8) - 1,
> > +		};
> >  		break;
> >  	default:
> >  		return -EINVAL;
> >  	}

...

-- 
Kind regards,

Rodrigo Alencar
