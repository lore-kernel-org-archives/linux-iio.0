Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0139333AD9B;
	Mon, 21 Sep 2026 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789962566; cv=none; b=Jp1qhQQtTppuKHaZ39czGJQ88ENw5bbJmI7lyOXZa45o/BwIkZVfnILsZT6GATGJsAV05X4phMQSZnz5K1fKWty7vJHyvdrXD9sUge55C94mSqATypPeD/EziplqqOZnCHQnTWidyX2/kSeUYgWqH4w18zAo6MmhyRIAfqHORUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789962566; c=relaxed/simple;
	bh=QIQKpcOOXCxrPaHM8KMrsuAZWKaQlxXd+RAIfb/IeYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svTVWcKeHqksziL7tVStnSHQsiOXqqANwIAM8VcGCC2qgqptZSG1S5jKBp0sOpIVyqGEj2QPpwcfs3vby9KcFpaDm/Wyip5xXRZaalJIBsrLgqYB5zqdesT40BiNDA1uKOdX0qpbgXNEjnHnj1PzRaq279qpxeT6hMB8musIsMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T65jHxU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T65jHxU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E7F1F000FF;
	Mon, 21 Sep 2026 03:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789962564;
	bh=CtW1ug9IUhLzmqXYZHdRgakfPwqnkFbULIirVlLwIgA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=T65jHxU+/qtANOwcji8o8U4PiHRLbZCYSfdsDtYDIbSCoPqw5pIqCIvmOy3+0fiNO
	 PB1wCqXX3clUjym+4ZMsbQAo7nGeiRCmMz3tL2ATbspgkwl5tzBu5Wo09uHszmGkg6
	 LFt5nIi5/oI3we4nzCyoM5Jjlq5N60djWOKKkwGLUGkqzVbSrB96YTI9EX3t8duDPy
	 3TkuIhP3queAifwAUSl3nkC+vEmTjl0nb2JcAC2rNPfewlAX7kmwV/9nSIUKagv1rf
	 f6V2Et7dhBd/Igx/PJCA1mwSEqwD/vCYynGnrWe4ouxl9RqAILOoWOcdnDmIam67L+
	 sfOJsu9W4aHUw==
Date: Mon, 21 Sep 2026 04:49:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, joshua.crofts1@gmail.com, error27@gmail.com
Subject: Re: [PATCH v2] staging: iio: adc: ad7816: Protect sysfs attributes
 with mutex
Message-ID: <20260921044919.2cc50837@jic23-hlaptop>
In-Reply-To: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>
References: <20260920091522.15507-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Sep 2026 12:15:22 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> The sysfs store functions (ad7816_store_mode and ad7816_store_channel)
> modify the device state and toggle GPIO pins. If accessed concurrently
> by userspace during an ongoing SPI transfer, this could corrupt the
> SPI transaction.

See below. One of them doesn't seem to have that possible affect.

Thanks,

Jonathan

> 
> Add the existing chip->lock guard to these functions to serialize
> access and prevent race conditions.
> 
> Fixes: 7924425db04a ("staging: iio: adc: new driver for AD7816 devices")
> Suggested-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
> ---
> Changes in v2:
> - Added a blank line after guard(mutex) statements as requested by Joshua.
> - Added Fixes tag as requested by Dan.
> - Collected Reviewed-by tag from Joshua.
> 
>  drivers/staging/iio/adc/ad7816.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index f76f0215119a..2a15d7598abb 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -143,6 +143,8 @@ static ssize_t ad7816_store_mode(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7816_chip_info *chip = iio_priv(indio_dev);
>  
> +	guard(mutex)(&chip->lock);
> +
>  	if (strcmp(buf, "full") == 0) {
>  		gpiod_set_value(chip->rdwr_pin, 1);
>  		chip->mode = AD7816_FULL;
> @@ -207,6 +209,8 @@ static ssize_t ad7816_store_channel(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> +	guard(mutex)(&chip->lock);
This isn't toggling pins or modifying anything on the device state side
of things. So at very least the commit message needs to be expanded to
what this is doing that needs a lock.

> +
>  	chip->channel_id = data;
>  
>  	return len;

