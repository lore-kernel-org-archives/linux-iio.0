Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A6A3932DF;
	Thu, 23 Apr 2026 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968324; cv=none; b=GizqZaVLWw6Xljo6onNR13RectbO/W/920cQ2RTTBbUxUvJL8GrQVFDFIQRAodbhgsosq3hPztiPVxPuhSscrmzNEvZexmz97+hiCZTBBwbdsx4vvQIl8LhFoH9nIR7b7TjC/6+97r7i33JfmP9MgsHyHncQK5BW19Zmy3VBXlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968324; c=relaxed/simple;
	bh=4gu6q02/44njTaRacOEFGwkRPgoFwiA15dgZ5MLfqnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0dpcdTCUI3iZkKKj59swZErafw/Ei+4GF2+iAZeSoBhAAewi50vzTaxonimTQWC2cyYsI287s+JQQRw6t6G/k2UTeBHNLOE/AWKBbNqrC9Nr52/yl0SM1QtSBXrtyTtSWEidu7/0XcV3LK6jamSDvCDRMyKJpr3BuLcF/9SkGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AS2p+Vq9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AS2p+Vq9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC12C2BCAF;
	Thu, 23 Apr 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968324;
	bh=4gu6q02/44njTaRacOEFGwkRPgoFwiA15dgZ5MLfqnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AS2p+Vq956xKd6IvrOw6Ush/aBXTlxlzI+rBZmwrD+iw8WtCHnU0LKV36jA8ZrNMD
	 yJe1M7sOR02N0hfgPkORVGq57fXnc46AxrlMrIsv0ncc+d+rRdUMku+xhPI2BtK4Zx
	 jhG+48Gbu9p4fr0A+j30uSnDJhL2pu3MmxGgDXRMVfN8RzQ9xkp2+FmlotxS2Weg6A
	 gUxpanNF9cvPlMEOrQ41Mwuj7CXBa44Vw+ts8Gvg3ZMJIJYO11fGo5xaybkKm9NqWD
	 6c8ZEFObMd6rJZTy7zj+IGbExQ684Kn15JPwWfvGGFiSczW2P+Jrmw61NAyWZpSqwH
	 q9q3HDHZaWqug==
Date: Thu, 23 Apr 2026 19:18:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Michael Auchter
 <michael.auchter@ni.com>, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Kees
 Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 20/22] iio: dac: ad5686: implement new sync() op for the
 spi bus
Message-ID: <20260423191833.0de9fb8c@jic23-huawei>
In-Reply-To: <20260422-ad5313r-iio-support-v1-20-ed7dca001d1b@analog.com>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
	<20260422-ad5313r-iio-support-v1-20-ed7dca001d1b@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 15:45:54 +0100
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
Interesting approach to potentially optimise for SPI.  Do you have
perf numbers or similar to support it being worth the effort?

Otherwise a few minor comments inline.

Thanks,

J
> ---
>  drivers/iio/dac/ad5686-spi.c | 110 +++++++++++++++++++++++++++++++------------
>  drivers/iio/dac/ad5686.c     |   4 +-
>  drivers/iio/dac/ad5686.h     |   8 +++-
>  drivers/iio/dac/ad5696-i2c.c |   2 +-
>  4 files changed, 89 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5686-spi.c b/drivers/iio/dac/ad5686-spi.c
> index ebfc40efa679..bacfb1deab31 100644
> --- a/drivers/iio/dac/ad5686-spi.c
> +++ b/drivers/iio/dac/ad5686-spi.c
> @@ -13,57 +13,80 @@
>  #include <linux/err.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/spi/spi.h>
>  
>  #include "ad5686.h"
>  
> +struct ad5686_spi_data {
> +	struct spi_message msg;
> +	unsigned int size;
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
>  
>  	switch (st->chip_info->regmap_type) {
>  	case AD5310_REGMAP:
> -		st->data[0].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> -					      val);
Fits on oneline.

> -		buf = &st->data[0].d8[0];
> -		tx_len = 2;
> +		st->data[bus_data->size].d16 = cpu_to_be16(AD5310_CMD(cmd) |
> +							   val);

Even these I'd put on one line to improve readability, or split as:
		st->data[bus_data->size].d16 =
			cpu_to_be16(...)


> +		xfer->tx_buf = &st->data[bus_data->size].d8[0];
> +		xfer->len = 2;
>  		break;
>  	case AD5683_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5683_DATA(val));
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> +							   AD5683_DATA(val));
> +		xfer->tx_buf = &st->data[bus_data->size].d8[1];
> +		xfer->len = 3;
>  		break;
>  	case AD5686_REGMAP:
> -		st->data[0].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> -					      AD5686_ADDR(addr) |
> -					      val);
> -		buf = &st->data[0].d8[1];
> -		tx_len = 3;
> +		st->data[bus_data->size].d32 = cpu_to_be32(AD5686_CMD(cmd) |
> +							   AD5686_ADDR(addr) |
> +							   val);
> +		xfer->tx_buf = &st->data[bus_data->size].d8[1];
> +		xfer->len = 3;
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
> @@ -84,8 +107,18 @@ static int ad5686_spi_read(struct ad5686_state *st, u8 addr)
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
> +
> +	spi_message_init_with_transfers(&bus_data->msg, xfer, 2);

Why not carry on using spi_sync_transfer() here?
We'll end up with an spi message the stack but I suspect that's
not a significant performance cost.



> +
> +	ret = spi_sync(spi, &bus_data->msg);
> +	if (ret)
>  		return ret;
>  
>  	return be32_to_cpu(st->data[2].d32);


