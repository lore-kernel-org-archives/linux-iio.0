Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785202765D7;
	Sun, 13 Sep 2026 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789268401; cv=none; b=Q60IZmctLbRolQsNbEKDK5af3UH5YZTEQHJQymF/myZKxq07RIlLtTKhYY34rasHDtDX+5nT5WcD8R9AfGrgUjtkyQr53JPoVq41HFwKQv0k60ExwxppyMRZzkAk1iL/OkV/Mgi4vlm3ehJMtYyafGmRXpzQ7QBb5WshZ2TEN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789268401; c=relaxed/simple;
	bh=nebcldvjasnNIaE8xLDrcml/O7iGT6X4/ykys5IcfuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H6QuXWcaCbdCYL3vRYAec+nBhqyCHD/vCFEJoArQlSSbH+OJ4WLBuYQSuaneSFsWGNO+3LBe91+rCqWpiWJd8SaIKTGJKyUDE7rSoPqIF9FZ5s5a4jkdANKoWesK3EgPVL8opNarklnUeR3FUpK3Ti1vFQDyqw8t/cD+z9HeiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AnNpgQFr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AnNpgQFr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AD01F000FF;
	Sun, 13 Sep 2026 02:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789268400;
	bh=45E+0rPqi4Q5EA4SZ6KErOV5kKZDAlhBMi5yePEo1ZU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AnNpgQFr54Usir0fOZgHzFHteOa78dYAJSQZGu+zwZcxDdPwy5OMReLp+WpoxnvhA
	 VRElaRBM8vEG61jZM6hw4RduYsZAx9ZjvnSjsKLzlhhY48e2iTkOwtO67eFktwM+Q+
	 xg+9ynaGLsdQoQDlktsi7mZoNE3X1K0HtNDgzD7IKfosSI29OtWeIpkJLowmkv7gLo
	 l+SsEt7Qaw90TR2yl2wUpK7KNNJ+7+Ix/9hR4FS8xrrztqDUDl3HvHO2SyXxNH/zPl
	 pcY2a8wmgfudp8Bg8/oPKIeVpLV9A4dENwIqyq3SYzejppkcHgM0DRqPC3zXNbDd+3
	 5EYFRc7Eg5c0Q==
Date: Sun, 13 Sep 2026 03:59:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com
Subject: Re: [PATCH v6 3/3] staging: iio: adc: ad7816: Use DMA-safe buffer
 for SPI read
Message-ID: <20260913035957.7eb0dd2b@jic23-hlaptop>
In-Reply-To: <20260912132517.55686-4-abdelnasserhussein11@gmail.com>
References: <20260912132517.55686-1-abdelnasserhussein11@gmail.com>
	<20260912132517.55686-4-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 16:25:17 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Stack buffers are unsafe for DMA with VMAP_STACK enabled because
> they are not physically contiguous and can share cache lines. This
> causes data corruption.

This one has come up a few times as a false or at least misleading
explanation.  It really doesn't have anything to do with VMAP_STACK
as that only a most deals with pages and cachelines which matter here
are much smaller.

Any stack variable is a problem simply because we don't control the
data layout and pretty much anything else can end up in the same
cache line. 

> 
> Fix this by using a dedicated rx_buf aligned with IIO_DMA_MINALIGN
> in the device state structure to ensure cache coherency. This also
> corrects the size argument in spi_read() to match the new buffer.

Make sure you understand why this alignment marking works to ensure
the buffer is in a cache line on it's own.

However, don't do this for a single use small buffer.
Use spi_write_then_read() (with 0 sized write) but also make
sure you understand why that works.

Jonathan


> 
> Fixes: 7024425db64a ("staging: iio: adc: new driver for AD7816 devices")
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7816.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index acf26c5a267a..2fd2d6796603 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -53,6 +53,7 @@ struct ad7816_chip_info {
>  	u8  channel_id;	/* 0 always be temperature */
>  	u8  mode;
>  	struct mutex lock; /* protect device state during SPI transfers */
> +	__be16 rx_buf __aligned(IIO_DMA_MINALIGN);
>  };
>  
>  enum ad7816_type {
> @@ -68,7 +69,6 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;
>  
>  	guard(mutex)(&chip->lock);
>  
> @@ -96,13 +96,13 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
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

