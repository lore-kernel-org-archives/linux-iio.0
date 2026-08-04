Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E1845A291;
	Tue,  4 Aug 2026 23:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785887954; cv=none; b=NoUFHirYFlDPyU0H62huZjahU5cTwpRNHtqxWNnvSayo/DVMIBYAtHfj3MDEFFXgeLsPbSWaw9mzmEWGm6xUkPXiOgHGkioAxL2+6wdF5vT2vu0w/cq/o89sLst5z3BTwVNMtYnU986vab2QjoXmlanWLQBUQmliE0BDiwm+Xjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785887954; c=relaxed/simple;
	bh=8KV82jRYlLgNLQ7iXKGsJrT2zFnKjSO32/5O8ujcsxg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hdc5aHMy+JqsUBZBwx01rHDiwzjCWHIzPd2+xiylhDQNonY9ZlyYxqIpjhZ92BIFpjp9GyCFnjt41gzTLYTAvR3VFdXHWJPGxiSa7q0AgnOlbKP9P+DpkPDgrKBwkGl8JPJuWWpYPdqh4eCeW/nGqfGQkv+D3aV8OJqF4LH8YxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SML7SySM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SML7SySM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510C81F000E9;
	Tue,  4 Aug 2026 23:59:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785887952;
	bh=Pzpd8wnwbqhEmfXYdUXTFZMk1PKJl6LZJzJATemskyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SML7SySM4uW3o/Wb05uHC8WkUt21Hmpbg+bP3kIt1o0Cu4FQEZynmE8gp0KWOCvmM
	 QDhVz3bO/I7UO92lThsGnLDmAnXdFo3QpQ9juUYp3ZgarrHx0cV2rH/kEkdXywXMOA
	 zs4lPqiV2jWVjBUyqx96bLcNAg6YyzNFYf0wgcv0pddBHeGKlX2bQZ2JjCR11I1Sc3
	 T78kKvDpdLil4QMJM3G4u9Mn8ES+Vikp6OvhaaRa9QRMhuDDTvrjZBnIPjFa/6o6xr
	 I91lXSPE2cXxWuBT22CQRHQIC8sOnrfQHg5EXCKCTAMosPbVqANmqejEjRjFHirB7I
	 scKbSITMCHg4A==
Date: Wed, 5 Aug 2026 00:59:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: nuno.sa@analog.com, Michael.Hennerich@analog.com,
 gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] staging: iio: ad7816: serialize
 ad7816_spi_read() with a mutex
Message-ID: <20260805005909.3137c74f@jic23-huawei>
In-Reply-To: <20260803134346.6733-3-abdelnasserhussein11@gmail.com>
References: <20260803134346.6733-1-abdelnasserhussein11@gmail.com>
	<20260803134346.6733-3-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 16:43:44 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The ad7816_spi_read() path performs a sequence of SPI transfers and GPIO
> state changes that must not be interleaved with another read operation.
> 
> Without serialization, concurrent callers can interfere with each other,
> leading to inconsistent device state and incorrect data being returned.
> 
> Add a mutex to struct ad7816_chip_info and hold it across the entire read
> sequence to ensure exclusive access to the device.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>

Split the two ad7816 out as a series on their own.

> ---
>  drivers/staging/iio/adc/ad7816.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..b5a0c2871e00 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -50,6 +50,7 @@ struct ad7816_chip_info {
>  	u8  oti_data[AD7816_CS_MAX + 1];
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
> +	struct mutex lock; /* protect device state during SPI transfers */
>  };
>  
>  enum ad7816_type {
> @@ -67,11 +68,14 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	int ret;
>  	__be16 buf;
>  
> +	mutex_lock(&chip->lock);

Use guard(mutex)(&chip->lock);
and adjust the rest as appropriate, including adding cleanup.h if it
isn't already there.




> +
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
>  	ret = spi_write(spi_dev, &chip->channel_id, sizeof(chip->channel_id));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI channel setting error\n");
> +		mutex_unlock(&chip->lock);
>  		return ret;
>  	}
>  	gpiod_set_value(chip->rdwr_pin, 1);
> @@ -94,11 +98,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  	ret = spi_read(spi_dev, &buf, sizeof(*data));
>  	if (ret < 0) {
>  		dev_err(&spi_dev->dev, "SPI data read error\n");
> +		mutex_unlock(&chip->lock);
> +
>  		return ret;
>  	}
>  
>  	*data = be16_to_cpu(buf);
> -
> +	mutex_unlock(&chip->lock);
>  	return ret;
>  }
>  
> @@ -359,7 +365,7 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
> -
> +	mutex_init(&chip->lock);
	
	ret = devm_mutex_init(&chip->lock);
	if (ret)
		return ret;

>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;

