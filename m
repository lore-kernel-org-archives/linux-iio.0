Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D01A219A8A;
	Wed,  5 Aug 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785888355; cv=none; b=ap5sDqYSsv8kw174J1OJexqyNANR9Y4IM0Dp56UZwAXKuKZes5wV5wGDdVJSRXVhDMr8hCq28WA8GruW6/E2+k9rHAyuXFhIKulwphKWskR+1LqSjlkLt0od1YeWhhYNyO/lJa/r3GH0ShLzpn4e5axmp1GF0/ozTESiGNGNYnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785888355; c=relaxed/simple;
	bh=XUkFVT9AY/g5O/85fx06nzKHZ2PrXNs69w8aMDsR7e0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsTojkwPkAgVm7BOqe8hrOaNluh1ZEyHuIzOZa/hKJtWHgsx3smYp7vq5iTMtaFJo/vmP9gE1ViBsrv3eiHyznImRzZKC8DWX2k0c4zI9121B5tsHvf50bAWvOPcfGgGWtOK4RWZAIHzMic3Uspf+6u6YQXCpFpCf5k4dheXyfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PmpFutM8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PmpFutM8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76851F00A3A;
	Wed,  5 Aug 2026 00:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785888354;
	bh=UhOyHQQwd0L4QOJhZV/0HzZdvBXt4uNkOhxTyaBDyOM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PmpFutM8dTxLlyXxWkUYwFVF3DbhvWahpMD3IvGyCjlSdEvAS3mZWlLbR7tflDYms
	 yjdto8tHfHZS5iG0Vmrw3LfR02MPmJpQg2Nmkueryaptgp8bqBy3NDBhvr0iJK2GzW
	 W0B7sRdjaU2pYkNGw/Ifpxa9F+IwsQS1IwPYqzA4bFPfaHKFGWR23m9VU3MHsDBr4w
	 onWCks4C4zW4E/hy+bHVITQ3lIzLbsZAGrZzWm95tNdcqaCw9MyhSWkSOkZWcaI+AZ
	 50DO5k1h6GmUOHg30S4tBGaSAOQlNFxgqCZS/RlhJk+9ZePfwNxNOd1E5PiXzWBEAt
	 R+WzXPCnk8rvg==
Date: Wed, 5 Aug 2026 01:05:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] staging: iio: ad7816: avoid DMA from stack in
 spi_read
Message-ID: <20260805010550.4c513e22@jic23-huawei>
In-Reply-To: <20260803134346.6733-5-abdelnasserhussein11@gmail.com>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
	<20260803134346.6733-5-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 16:43:46 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The SPI transfer buffer is allocated on the stack, which is unsafe when
> the SPI core performs DMA transfers. With VMAP_STACK enabled, this can
> lead to DMA mapping failures because the stack is not guaranteed to be
> DMA-accessible.

Hmm. That's a new one for me. I was just thinking it was the cache coherency
problems that meant we shouldn't DMA to/from the stack because we can't
guarantee what is going to be in the cacheline.  Looking briefly into
it it seems this is another good reason not to do it.

> 
> Move the buffer into struct ad7816_chip_info to provide storage with an
> appropriate lifetime for DMA, align it with

Why is lifetime relevant here?  The on stack data was fine lifetime wise.

> __aligned(IIO_DMA_MINALIGN), and update the spi_read() sizeof() argument
> to reference the relocated buffer.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> 
No blank lines in commit block. Sometimes I just fix these up when picking
patches up, but sometimes I get grumpy and bounce them back to submitter
to fix up in a new version.

> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index b5a0c2871e00..c58a6bf77020 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -51,6 +51,7 @@ struct ad7816_chip_info {
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
>  	struct mutex lock; /* protect device state during SPI transfers */
> +	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum ad7816_type {
> @@ -66,7 +67,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;
>  
>  	mutex_lock(&chip->lock);
>  
> @@ -95,7 +95,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	gpiod_set_value(chip->rdwr_pin, 1);
> -	ret = spi_read(spi_dev, &buf, sizeof(*data));
> +	ret = spi_read(spi_dev, &chip->rx_buf, sizeof(chip->rx_buf));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
>  		mutex_unlock(&chip->lock);
> @@ -103,7 +103,7 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  		return ret;
>  	}
>  
> -	*data = be16_to_cpu(buf);
> +	*data = be16_to_cpu(chip->rx_buf);
>  	mutex_unlock(&chip->lock);
>  	return ret;
>  }

