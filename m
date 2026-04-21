Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D75E1E2614
	for <linux-iio@vger.kernel.org>; Tue, 21 Apr 2026 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786703; cv=none; b=OLUpoQ7Sx6F2QWxdRkl86ZxUbpnXWYV+6HKHkawNIliutRk25uhiZOUZ5eo+3cJFjsHpPkw9B7wXjSbd6JGB+ELz5SSfpR0IZCOrJTt4NZ5gphFfk/m5x/Fe5BcPJIP7rcG3pReM2komUF0pA+mLxWBlrRW3aPh0vBmqkjHEQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786703; c=relaxed/simple;
	bh=WSQfvMNF59WLtZCk+JfVWkLPf2iy75kseDZmSF4GaX4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klFju0TDvV98MxqJMHhK6psOlqYTo5b5vq2hiDb0P1YkGGOjcNX28dZUJh7i+TnECbWBDvwSe3kbkGBKym4Z1pb4ANmOr2jcgeHN2qWOnUip0RlESwqDduT8hQnltdB2/LRcFIIXOdiEsmajBtwqLxAmCZ6pkxjWR0dIPiWNfF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSlJ5JHo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSlJ5JHo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BCCFC2BCB0;
	Tue, 21 Apr 2026 15:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776786702;
	bh=WSQfvMNF59WLtZCk+JfVWkLPf2iy75kseDZmSF4GaX4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SSlJ5JHo/BSOV6/AyiFplvatxdy0aj7alue4CxoGJNBjfQV4bGXR8fo++pSP05xyR
	 xXeifssii4+nAk2qovJvQTvkCgBf40QwnUnSBncAEH3l24AHtaorM9ffFtLbdEcZPe
	 szNNWFQ51UjmW2DcYZ4/fp2TimyJrjgHI7IeVFUj2+aEtaVwetkLJjIoJXJy6wxiUm
	 vPClHRL2COKgovPsNrKPAlP9/oR1OyPfWP9KFJy+IuP3KYWnVSx1GjrXCw0n25RlpQ
	 qqsNEFm7UI1Q223cAqL9HGqS/OEdkVzEMxjx6UjaaC/0EbXakR+9szDmg3O6yeyoJm
	 0sdlcnOzboRvA==
Date: Tue, 21 Apr 2026 16:51:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Eduardo
 Augusto <eduardoaugustoabc@ime.usp.br>, Christian Barry
 <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: refactor driver to use bitfield API
Message-ID: <20260421165134.0235b764@jic23-huawei>
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


> @@ -140,26 +163,27 @@ static int mcp320x_adc_conversion(struct mcp320x *adc, u8 channel,
>  	if (ret < 0)
>  		return ret;
>  
> +	u16 raw16 = be16_to_cpup((__be16 *)adc->rx_buf);

Sashiko pointed out that rx_buf is unaligned so you need an unaligned accessor here.
https://sashiko.dev/#/patchset/20260420215021.14112-1-gustavo.pagnotta%40ime.usp.br
> +
>  	switch (device_index) {
>  	case mcp3001:

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
&= ~MCP355X_OVR; ?

Sashiko wins again. 

J
> +		else if ((raw & MCP355X_SGN) || (raw & BIT(21)))
>  			raw |= GENMASK(31, 22); /* underrange or negative */
>  
>  		*val = (s32)raw;

