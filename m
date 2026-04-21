Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A81319858
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781943; cv=none; b=YrnulED9k5IJH9dLP7aABcnLsSFW5quNU1V/0RQ92f3rMe/e+VeANXGGNI6ipsYjiKfGvgF5iFvuoPM+hF6zYhlMHr9C3zng0E1AHh6wa1QJGeGC3re5/yNGFnE/b4kng7PfLLRcW4kzLLFcTHbKQaVpX8xwsgtuVKiwimayXzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781943; c=relaxed/simple;
	bh=2W5aFHf2yf7tmuTGoQKVKM4bXthLxrmSjkLyCk1hIrg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kq7QbOVsb1oxBklhhySuuI71fFzcMwHKKHKaxJJ+DJGXJe5HLyUCAfpqR+phyWiKWC1tEgug97dLuA2ALGjTc4o/Q0IqYgfRAXE5kGeukALLOCbweF+sg14z+GnIRmZ765YZONe8UMANAOoZpLK8FINlpgW992dzyQPLE2u0qis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7ExaPeX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7ExaPeX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7D6C2BCB0;
	Tue, 21 Apr 2026 14:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776781942;
	bh=2W5aFHf2yf7tmuTGoQKVKM4bXthLxrmSjkLyCk1hIrg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B7ExaPeXs6sayA0MFM/P3bmb/gA1yoLv68ahQvuYgwXCl9qoGmQh2rme8RCl9XEz/
	 NW8iI8tdI5USaQeDO4IYOZE250bPhZKkw6xbFkauvEY5PBNg5w25d47VkVoTCMtcZd
	 2MHqsEzj8/H1w8uxN+k47X0XxT5bShuGCwpXqTpmDUSAUHjCDJ9d46qSlrwwB4xwXp
	 9GBOSN30RR210rz71AcW9cz/UFhNXmGPbIsh/2C0yiEPBfUFQmABBpN2e4IZQWmwAw
	 wX99G5XBfS2kNOkqxXn6Azi2RaQadLcztQCFw8ktNwmnZ123oh5lwED3wnMXAO5Aiy
	 1mRJr2s7kA1DA==
Date: Tue, 21 Apr 2026 15:32:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Eduardo
 Augusto <eduardoaugustoabc@ime.usp.br>, Christian Barry
 <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: refactor driver to use bitfield API
Message-ID: <20260421153214.755c40be@jic23-huawei>
In-Reply-To: <20260420215021.14112-1-gustavo.pagnotta@ime.usp.br>
References: <20260420215021.14112-1-gustavo.pagnotta@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 20 Apr 2026 18:49:18 -0300
Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br> wrote:

> Update the mcp320x driver to use the standard Linux bitfield
> API (<linux/bitfield.h>) instead of manual bitwise shifts and masks.

Even though you replied to v1 with why this was being sent, this
should still be clearly marked as [PATCH V2] in the patch title to
reduce the risk of the wrong version getting picked up.

> 
> This replaces the hardcoded shift operations in the TX data
> preparation (mcp320x_channel_to_tx_data) with FIELD_PREP()
> and replaces the manual masking in the RX data extraction
> (mcp320x_adc_conversion) with FIELD_GET(). Explicit masks
> using GENMASK() and BIT() were also introduced for both transmit
> configurations and receive extractions.
> 
> Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
> Co-developed-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
> Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
> Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
> Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
> ---
>  drivers/iio/adc/mcp320x.c | 58 +++++++++++++++++++++++++++------------
>  1 file changed, 41 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 57cff3772ebe..b7523e5ea903 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -44,6 +44,29 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +
> +/* MCP3x02/04/08 Tx Data configuration */
> +#define MCP3X02_START_BIT	BIT(4)

I'm not sure how this driver got in with a wild card in the name but let's
not make it worse.   Manufacturers are far too inconsistent on naming
for them to be 'safe' so just name these after the lowest numbered part
they are relevant to.  Same applies to all wild cards in here.


> +#define MCP3X02_SGL_DIFF	BIT(3)
> +#define MCP3X02_CH_MASK		BIT(2)
> +
> +#define MCP3X04_08_START_BIT	BIT(6)
> +#define MCP3X04_08_SGL_DIFF	BIT(5)
> +#define MCP3X04_08_CH_MASK	GENMASK(4, 2)

As noted below. This is only really the mask for the 8 channel
parts.  They should be split.

> +
> +/* MCP Rx Data extraction masks */
> +#define MCP3001_DATA_MASK	GENMASK(12, 3)
> +#define MCP300X_DATA_MASK	GENMASK(15, 6)

Here's an immediate example of why wild cards are inappropriate.
That clearly includes 3001 and I only have to go up one line
to see it doesn't.

> +#define MCP3201_DATA_MASK	GENMASK(12, 1)
> +#define MCP320X_DATA_MASK	GENMASK(15, 4)
> +#define MCP3301_DATA_MASK	GENMASK(12, 0)
> +
> +/* MCP355X Data and Status bits */
> +#define MCP355X_DATA_MASK	GENMASK(31, 8)

Not sure why this wasn't done as a 24 bit transfer. Ah well,
not something to touch in this patch (or without hardware to test
on!)

> +#define MCP355X_SGN		BIT(23)
> +#define MCP355X_OVR		BIT(22)

These are odd enough that I'd add something short to reference
that there are more details on when these are or aren't part of the data
mask as in the comment in the mcp320x_adc_conversion function.

>  
>  enum {
>  	mcp3001,
> @@ -99,19 +122,19 @@ struct mcp320x {
>  static int mcp320x_channel_to_tx_data(int device_index,
>  			const unsigned int channel, bool differential)
>  {
> -	int start_bit = 1;
> -
>  	switch (device_index) {
>  	case mcp3002:
>  	case mcp3202:
> -		return ((start_bit << 4) | (!differential << 3) |
> -							(channel << 2));
> +		return FIELD_PREP(MCP3X02_START_BIT, 1) |
> +		       FIELD_PREP(MCP3X02_SGL_DIFF, !differential) |
> +		       FIELD_PREP(MCP3X02_CH_MASK, channel);
>  	case mcp3004:
>  	case mcp3204:
>  	case mcp3008:
>  	case mcp3208:
> -		return ((start_bit << 6) | (!differential << 5) |
> -							(channel << 2));
> +		return FIELD_PREP(MCP3X04_08_START_BIT, 1) |
> +		       FIELD_PREP(MCP3X04_08_SGL_DIFF, !differential) |
> +		       FIELD_PREP(MCP3X04_08_CH_MASK, channel);

Given you are using an explicit mask rather simply shifting, I'd break appart
the 4 channel and 8 channel devices.

>  	default:
>  		return -EINVAL;
>  	}
> @@ -140,26 +163,27 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  	if (ret < 0)
>  		return ret;
>  
> +	u16 raw16 = be16_to_cpup((__be16 *)adc->rx_buf);

This only applies to some of the case statements. Whilst
it might seem like a lot of duplication I'd move it into the
ones where it applies.

> +
>  	switch (device_index) {
>  	case mcp3001:
> -		*val = (adc->rx_buf[0] << 5 | adc->rx_buf[1] >> 3);
> +		*val = FIELD_GET(MCP3001_DATA_MASK, raw16);
>  		return 0;
>  	case mcp3002:
>  	case mcp3004:
>  	case mcp3008:
> -		*val = (adc->rx_buf[0] << 2 | adc->rx_buf[1] >> 6);
> +		*val = FIELD_GET(MCP300X_DATA_MASK, raw16);
>  		return 0;
>  	case mcp3201:
> -		*val = (adc->rx_buf[0] << 7 | adc->rx_buf[1] >> 1);
> +		*val = FIELD_GET(MCP3201_DATA_MASK, raw16);
>  		return 0;
>  	case mcp3202:
>  	case mcp3204:
>  	case mcp3208:
> -		*val = (adc->rx_buf[0] << 4 | adc->rx_buf[1] >> 4);
> +		*val = FIELD_GET(MCP320X_DATA_MASK, raw16);
>  		return 0;
>  	case mcp3301:
> -		*val = sign_extend32((adc->rx_buf[0] & 0x1f) << 8
> -				    | adc->rx_buf[1], 12);
> +		*val = sign_extend32(FIELD_GET(MCP3301_DATA_MASK, raw16), 12);
>  		return 0;
>  	case mcp3550_50:
>  	case mcp3550_60:
> @@ -170,17 +194,17 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  		if (!(adc->spi->mode & SPI_CPOL))
>  			raw <<= 1; /* strip Data Ready bit in SPI mode 0,0 */
>  
> +		raw = FIELD_GET(MCP355X_DATA_MASK, raw);
>  		/*
>  		 * If the input is within -vref and vref, bit 21 is the sign.
>  		 * Up to 12% overrange or underrange are allowed, in which case
>  		 * bit 23 is the sign and bit 0 to 21 is the value.
>  		 */
> -		raw >>= 8;
> -		if (raw & BIT(22) && raw & BIT(23))
> +		if ((raw & MCP355X_OVR) && (raw & MCP355X_SGN))
>  			return -EIO; /* cannot have overrange AND underrange */
> -		else if (raw & BIT(22))
> -			raw &= ~BIT(22); /* overrange */
> -		else if (raw & BIT(23) || raw & BIT(21))
> +		else if (raw & MCP355X_OVR)
> +			raw &= MCP355X_OVR; /* overrange */
> +		else if ((raw & MCP355X_SGN) || (raw & BIT(21)))
>  			raw |= GENMASK(31, 22); /* underrange or negative */
>  
>  		*val = (s32)raw;

