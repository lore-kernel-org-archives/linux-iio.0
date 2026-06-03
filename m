Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FB1367B90;
	Wed,  3 Jun 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780489461; cv=none; b=MEIEkb0KP9SdlZIsOY5yOkbmkTUYP8fq7l9MnHyML5vNMyWHetHy9GKUB1gBGmlgc4SETBNvqHH24qgxDx427JYx22x0YSzdnUwRdU4zG1vMNPHtojzrz5J7EUdaHqppP/TcBnbX8UWpv/Dh6bJyJSCnSr3IP/pERmEc7TxBcHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780489461; c=relaxed/simple;
	bh=nOyyGH1P6djiHEzmzGacg830szkwACcMg6XnfBHOBSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+73B9UB91i5ftxoNcjqMPbU5tDDuKBb5LrzGPlzvHIhfsDRp669yNZ1Zp8bcDbq9JOYpOlP9GTOI07GP2g39870ufbYY+uiY2c7qplRXhC16rAOmiIVYWe8UYTDghyRge/bHZrfgPFHh8icynZGq/rvjMfjM8vNYLanjIzTaEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VnuBHFxM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VnuBHFxM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CC31F00893;
	Wed,  3 Jun 2026 12:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780489460;
	bh=LgpJ04htxN+FPiPR/7cZ0zFIVPjLpPWLeq0o4HBwQoE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VnuBHFxM+e9+dKqrB+UTFtwqKJ6VuR4aosHHxBdyT6MFKogBxetK1gZTAvUb/YdUX
	 BswkKGrFLRivbbwuiYSWZr+2IlR5ZozD61c2uX38SzTHAa8lu7eCJmGY5sFcsqdkvs
	 CMTW7Dt5uGbUbzoI4E3C61u/HqykXhUPFTEQcouxoxoR1HkuN/ccXerACE2Q+gaZCK
	 7exRauxf/HpczoyfVzfEG84GHHXbZQ4ZM0BKLo7CUFmQKC1/EyugN8LUPqKKvv81EX
	 yOoECBi1JNzkMQ96q1Vm4VMmojsC5K6E4XPqQGx/FA7W6DIfwjsPYoWbCiNWnMKnHL
	 5ZBV9StN5pJ7w==
Date: Wed, 3 Jun 2026 13:24:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, Michael Auchter <michael.auchter@ni.com>,
 linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, Kees Cook
 <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 09/12] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <20260603132409.504ee84a@jic23-huawei>
In-Reply-To: <20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
	<20260602-ad5686-new-features-v1-9-691e01883d27@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 17:33:56 +0100
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Use of local SPI bus data to manage a collection of SPI transfers and
> flush them to the SPI platform driver with the sync() operation. This
> allows for faster handling of multiple channel DAC writes, avoiding kernel
> overhead per spi_sync() call, which will be helpful when enabling
> triggered buffer support.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Some minor stuff inline.  Maybe it does make sense to adapt for a generic
solution in the spi core, maybe not but most of these comments apply anyway!

Jonathan

> ---
>  drivers/iio/dac/ad5686-spi.c | 109 +++++++++++++++++++++++++++++++------------
>  drivers/iio/dac/ad5686.c     |   4 +-
>  drivers/iio/dac/ad5686.h     |   8 +++-
>  drivers/iio/dac/ad5696-i2c.c |   2 +-
>  4 files changed, 88 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index 6b6ef1d7071f..66a5a2164395 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -12,59 +12,81 @@
>  #include <linux/errno.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/spi/spi.h>
>  
>  #include <asm/byteorder.h>
>  
>  #include "ad5686.h"
>  
> +struct ad5686_spi_data {
> +	struct spi_message msg;
> +	unsigned int size;

Not obvious to me what size is from the naming. Maybe this
structure needs some documentation.

> +	unsigned int capacity;
> +	struct spi_transfer xfers[] __counted_by(capacity);
> +};
> +
>  static int ad5686_spi_write(struct ad5686_state *st,
>  			    u8 cmd, u8 addr, u16 val)
>  {
> -	struct spi_device *spi = to_spi_device(st->dev);
> -	u8 tx_len, *buf;
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer;
> +
> +	if (bus_data->size >= bus_data->capacity)
> +		return -E2BIG;
> +
> +	if (bus_data->size)
> +		bus_data->xfers[bus_data->size - 1].cs_change = 1;
> +	else
> +		spi_message_init(&bus_data->msg);
> +
> +	xfer = &bus_data->xfers[bus_data->size];
> +	xfer->rx_buf = NULL;
> +	xfer->cs_change = 0;

These are both 'resets' to defaults and you are heavily relying
on other fields in that rather complex structure never being set.
Maybe initializing all the fields is simpler?  

>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> -					      val);
> -		buf = &st->data[0].d8[0];
(why not use d16 here? Obviously this is original code, but applies
below)
> -		tx_len = 2;
> +		st->data[bus_data->size].d16 =
> +			cpu_to_be16(AD5310_CMD(cmd) | val);
> +		xfer->tx_buf = &st->data[bus_data->size].d8[0];

> +		xfer->len = 2;
Following on from above on resetting xfer fields.

		*xfer = (struct spi_transfers) {
			.tx_buf = &st->data[bus_data->size].d16, 
			.len = sizeof(&st->data[bus_data->size.d16),
		};
>  		break;
>  	case AD5683_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5683_DATA(val));
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(AD5686_CMD(cmd) | AD5683_DATA(val));
> +		xfer->tx_buf = &st->data[bus_data->size].d8[1];
> +		xfer->len = 3;
Similar use of designated initializer at small cost of clearing stuff
that is clear.  I doubt that matters.

>  		break;
>  	case AD5686_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5686_ADDR(addr) |
> -					      val);
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 =
> +			cpu_to_be32(AD5686_CMD(cmd) | AD5686_ADDR(addr) | val);
> +		xfer->tx_buf = &st->data[bus_data->size].d8[1];
> +		xfer->len = 3;
same again. 
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
>  
> -	return spi_write(spi, buf, tx_len);
> +	spi_message_add_tail(xfer, &bus_data->msg);
> +	bus_data->size++;
> +
> +	return 0;
> +}
> +
> +static int ad5686_spi_sync(struct ad5686_state *st)
> +{
> +	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +
> +	bus_data->size = 0; /* always reset, even on sync failure */
> +	return spi_sync(spi, &bus_data->msg);
>  }
>  
>  static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  {
> -	struct spi_transfer t[] = {
> -		{
> -			.tx_buf = &st->data[0].d8[1],
> -			.len = 3,
> -			.cs_change = 1,
> -		}, {
> -			.tx_buf = &st->data[1].d8[1],
> -			.rx_buf = &st->data[2].d8[1],
> -			.len = 3,
> -		},
> -	};
>  	struct spi_device *spi = to_spi_device(st->dev);
> +	struct ad5686_spi_data *bus_data = st->bus_data;
> +	struct spi_transfer *xfer = &bus_data->xfers[0];
>  	u8 cmd = 0;
>  	int ret;
>  
> @@ -85,8 +107,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  				      AD5686_ADDR(addr));
>  	st->data[1].d32 = cpu_to_be32(AD5686_CMD(AD5686_CMD_NOOP));
>  
> -	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> -	if (ret < 0)
> +	xfer[0].tx_buf = &st->data[0].d8[1];
> +	xfer[0].len = 3;
> +	xfer[0].cs_change = 1;
> +	xfer[1].tx_buf = &st->data[1].d8[1];
> +	xfer[1].rx_buf = &st->data[2].d8[1];
> +	xfer[1].len = 3;
> +	xfer[1].cs_change = 0;

Similar to above - I'd initialize the lot as suggested up there.
Saves on effort thinking about it. Maybe the cost matters but I doubt it.


> +
> +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);
> +
> +	ret = spi_sync(spi, &bus_data->msg);
> +	if (ret)
>  		return ret;
>  
>  	return be32_to_cpu(st->data[2].d32);
> @@ -95,12 +127,27 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
>  static const struct ad5686_bus_ops ad5686_spi_ops = {
>  	.write = ad5686_spi_write,
>  	.read = ad5686_spi_read,
> +	.sync = ad5686_spi_sync,
>  };
>  
>  static int ad5686_spi_probe(struct spi_device *spi)
>  {
> -	return ad5686_probe(&spi->dev, spi_get_device_match_data(spi),
> -			    spi->modalias, &ad5686_spi_ops);
> +	const struct ad5686_chip_info *info = spi_get_device_match_data(spi);
> +	struct ad5686_spi_data *bus_data;
> +	unsigned int capacity;
> +
> +	/* read operation requires at least 2 transfers */
> +	capacity = max(info->num_channels, 2);
> +	bus_data = devm_kzalloc(&spi->dev,
> +				struct_size(bus_data, xfers, capacity),
> +				GFP_KERNEL);
> +	if (!bus_data)
> +		return -ENOMEM;
> +
> +	bus_data->capacity = capacity;
> +
> +	return ad5686_probe(&spi->dev, info, spi->modalias, &ad5686_spi_ops,
> +			    bus_data);
>  }
>  
>  static const struct spi_device_id ad5686_spi_id[] = {
