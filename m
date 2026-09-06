Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6053A961B;
	Sun,  6 Sep 2026 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788717033; cv=none; b=ExIdjswXUTzKZqcp8aCHTt/nhQARN27f7+kEUPWxKD7XMmLCwT8qKlVkBa4uYIUtvPIVd4TMpUaL3/Ta9aqjn2IV1I7XWN+0j7oePY+ChyEXjbkopC1ugf+X/Ct8E8LG4u5U2K1beNacWDYAYWOCL6TSmq1G1ZZmejqIt6/dzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788717033; c=relaxed/simple;
	bh=D+ALIOf68gIb+9RpZGrlaTMyhMf99Y5J+9c3KdaZthE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D4t832cPxu3Dtoy4mQApSfdDBYDHIm+NrRvkFQfd5kYPf/pelUL9BpmEfhskiVCqJF6RaxUsHCHkXs9pb6PyDzPfxQWiovomGoJh6m7jIBvMw0BOpKNrSAWcGV0RaGvGZQSjA/W3PG40En6OdcY367hxXQtd2eqNCH+2BhL461c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibs9lysz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibs9lysz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F192B1F00A3A;
	Sun,  6 Sep 2026 17:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788717032;
	bh=WbiCHobLkVZWRdBZ9HFaK8lfkf40zDYLRYyf/HrF29E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ibs9lyszkgcbZb9bJW+dKuuo3tfQH2RLnLSzXl7qME9Mdnz++EMdRNlHNF1JciCIe
	 y5uaaRyNiwXE+sjsESaKo+UUhD7wg2in/2tmNPulSEANxIlYntPKmgcGpZ1yoWuzCp
	 wclPcqpjF9E3SqJBl5HAvBqCYCn7hYZBjrsSbHvT5Iuj7mCNJuWVOPVEx8iWTO5ka6
	 kw89X3p+Zdqnma9SQLQLjld1HusEc3zkySVmZPMdgS6DL0k+ZETey/o+1e7SQpkej0
	 aSv/Zm4bAZPoYeLkgrXrpz+aaB7NE7Bz6j9pV3bR6k9T1ft5Hu2JIxjwH6rcr9V8Ui
	 oP6PE/QnA1ewQ==
Date: Sun, 6 Sep 2026 18:50:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] staging: iio: adc: ad7816: Use DMA-safe buffer
 for SPI read
Message-ID: <20260906185025.6a0d1240@jic23-huawei>
In-Reply-To: <20260906114049.32912-3-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
	<20260906114049.32912-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:49 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Stack buffers are not guaranteed to be cache-coherent and must not
> be used with SPI reads, which can trigger issues with VMAP_STACK.

This needs a rewrite and to show more understanding of what is going
on.  What it says write now implies that some how buffers on the heap
are magically cache coherent and ones on the stack are not

I'd suggest watching the talk Wolfram Sang gave at ELCE a few years
back on this topic as a starting point.

> Fix this by using a dedicated DMA-safe rx_buf aligned with
> IIO_DMA_MINALIGN. Also, correct the sizeof() argument from *data
> to chip->rx_buf to match the buffer size.

They are the same size.  I'm not saying the fix is wrong but calling
it correct is misleading.

> 
> Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index ab80b3a889bb..e14ae805f076 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -52,6 +52,8 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */
> +	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum ad7816_type {
> @@ -94,13 +96,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> +	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
>  		return ret;
>  	}
>  
> -	*data = be16_to_cpu(buf);
> +	*data = be16_to_cpu(chip->rx_buf);
>  
>  	return ret;
>  }

