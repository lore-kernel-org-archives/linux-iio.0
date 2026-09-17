Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780EC1AAE28;
	Thu, 17 Sep 2026 03:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789615368; cv=none; b=MkI9VfyKHn/xeWIG44vV9s3EhNDpsOZ9nmOo09n4wWBuJ/Z63DcSUfqZT8rKIcWkHGyjSHV84ktUCN50jroZsJ1GNgZeE61kLFqsHzB/JFZ3zj0t60C1o0gMIwfq0WEtddnEIHusSQHi43FPVlhXrJo8kJpQfpQ+fxwhTo+dMmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789615368; c=relaxed/simple;
	bh=OmpzvktthIMlmjbdkBRmlBz9EaCIIUVeLJJ8l3eMClI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qs+eXmpNDMXLRjDxW5zceIA2MzhBuZYTICbcbFSER54lx8LDeC3gGEZqZJ3qRnyPEgvE3HDuZBsRiLNhVgU8q2cy7smlZM4h7XlG7+NkONXQyPqLyQ/SFiJy1re0lCnD+w3zHsk9pg86/xooiVdjOqBOUIC2CHphWS09fN30Ib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jam9ldi3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jam9ldi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5023F1F000FF;
	Thu, 17 Sep 2026 03:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789615367;
	bh=SXsX5DsYswtzjcS3K0uNGf/QIEwH8p3X9vhYMBqrMQw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jam9ldi3KC+0+VczNEMScr4uJEqoxHZUdXakjFbdk17lAqJr8MpnPX0tD7I8KDZTu
	 L5ePZWzNyrBGWdQDqszzwqZ30QYFkxBMYGweY4kKn4iU+h8lDdHimDGDq03HY9lXwS
	 9pit+Z+1qA0/+XEvHdJgk0u3SnIk0/j2/EwVUmY5gvE48XPjwEJK1IR+sXxoSpy6Mm
	 oY0OOMLEeCdFTqsbv/VckIvSPuygzDJ1x6Q2M8SiH+/RHUPhx5O3BMrjEMAYUW3Ein
	 EyFKLS7DONzrAhXn3q7QyoB3BcQpCxg7xr5I5KHbhT4xqYXwfzlQvMhh/s8RsBaUMB
	 3E0qRgxv0accA==
Date: Thu, 17 Sep 2026 04:22:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v7 3/3] staging: iio: adc: ad7816: Fix DMA safety issues
 in SPI transfers
Message-ID: <20260917042241.05bc81a7@jic23-hlaptop>
In-Reply-To: <20260915075939.18180-4-abdelnasserhussein11@gmail.com>
References: <20260915075939.18180-1-abdelnasserhussein11@gmail.com>
	<20260915075939.18180-4-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Sep 2026 10:59:39 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The SPI operations in this driver are not DMA safe:
> 1. spi_read() uses a stack-allocated buffer.
> 2. spi_write() in ad7816_spi_read() uses a struct member that shares a
>    cacheline with other variables.
> 3. spi_write() in ad7816_spi_write() passes a stack parameter by
>    reference.
> 
> Fix these violations by replacing all spi_read() and spi_write() calls
> with spi_write_then_read(). This safely handles DMA by internally
> allocating a bounce buffer for the transfers, avoiding cacheline
> sharing issues without needing dedicated aligned buffers.
> This implicitly corrects the size argument in read to sizeof(buf).
> 
> Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
I tried to apply but having missed many of these in the path
have a git hook that checks fixes tags.

That commit doesn't exist.  Seems it is the fairly similar ID.

7924425db04a  which is downright odd as two digits are different.
Copy typing maybe?  Anyhow, fixed up and series applied.

Jonathan


> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index c18093ca8a82..f76f0215119a 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -74,7 +74,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
> +	ret = spi_write_then_read(spi_dev, &chip->channel_id, sizeof(chip->channel_id), NULL, 0);
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI channel setting error\n");
>  		return ret;
> @@ -96,7 +96,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> +	ret = spi_write_then_read(spi_dev, NULL, 0, &buf, sizeof(buf));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
>  		return ret;
> @@ -116,7 +116,7 @@ static int ad7816_spi_write(struct ad7816_chip_info *chip, u8 data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> -	ret = spi_write(spi_dev, &data, sizeof(data));
> +	ret = spi_write_then_read(spi_dev, &data, sizeof(data), NULL, 0);
>  	if (ret < 0)
>  		dev_err(&spi_dev->dev, "SPI oti data write error\n");
>  

