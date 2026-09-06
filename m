Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60BC31715F;
	Sun,  6 Sep 2026 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716853; cv=none; b=pvztBELIuu5f6/QMvWAHAqK5SaFK6GBSXAf6gvQJCd1K2NNN2ZmQOJCu4Ip7f6+t/L9H5Z9O0qpR4Y9F0RCsjajk3FhupbBT2+wZKaGl4ID1x4P/UBg70Dg+gjvyA8FTi4tMPhCIiffOe2NRjxEBdA60jH8skv0mz+Cwu+zD3sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716853; c=relaxed/simple;
	bh=0O0ypgaT/G2VcYjKN+21o3nWpsP/Qr/0kc23poOV1N0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BhGgilVN2R3+oP8Xx0sqb7rZRJqXJDoY8N/zxYFW/h5vc57Ch4ysxWDTbqHrk0MuIVy+hURkjMbFnF90D1SjHRfqRuisIChr26FF0sTlH9d/cSZwkh9LP3vuihvrn8Fddbch+2MweDW4XQlRT8pOTgvIIRdQkuvI8mRFVKDRcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEwyFdly; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEwyFdly"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F77F1F00A3A;
	Sun,  6 Sep 2026 17:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788716852;
	bh=WDqUTqfuwYGhUEA2KOT3qieNopzvD2G9zWZFnbpim1U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EEwyFdlyoWq//0zNaRP81bfg9KIfBqilTgOFPaxpxrOathjm7yXuoghcBAMdPvnc2
	 ZsN5bgInsm2eLG5fUVahqNQcxT3ae5iS0nkOewx1K5dOf60D73zufuqLle8KktzYG+
	 50ofzidZVCp1JXf/Zc04EBPji07w3ZV7EqXZIhQw+9/WnET6GMlnxvz/FUts5WXxqf
	 VEoHPPjgh16LIoVKPP6kmpkzJf93QCBoDXXytIUjhV1MNwBHX5eUKXPIXhHAyENXT6
	 kbDDAuU5nd0KkoTrsHW64oDSdHM8MoHB8Tb+hrZfcyI/WjY63Shmo0jHnJuxa/YB1q
	 FugIbEl63W3Aw==
Date: Sun, 6 Sep 2026 18:47:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: gregkh@linuxfoundation.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] staging: iio: adc: ad7816: Serialize SPI read
 operations
Message-ID: <20260906184728.22b256d6@jic23-huawei>
In-Reply-To: <20260906114049.32912-2-abdelnasserhussein11@gmail.com>
References: <20260906114049.32912-1-abdelnasserhussein11@gmail.com>
	<20260906114049.32912-2-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  6 Sep 2026 14:40:48 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Add a mutex to serialize SPI read operations and prevent data corruption. Used guard(mutex) and devm_mutex_init() for safer and automatic cleanup.
Check submitting patches, this is not well formatted.

> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>

Alongside the comments Joshua had I'd expect to see a description of what
the race you are preventing is and if you are going to say things like
data corruption, an illustration of what gets corrupted and how.

Jonathan

> ---
>  drivers/staging/iio/adc/ad7816.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
> index 0e32a2295990..ab80b3a889bb 100644
> --- a/drivers/staging/iio/adc/ad7816.c
> +++ b/drivers/staging/iio/adc/ad7816.c
> @@ -14,6 +14,8 @@
>  #include <linux/list.h>
>  #include <linux/spi/spi.h>
>  #include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/cleanup.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -65,7 +67,8 @@ static int ad7816_spi_read(struct ad7816_chip_info *chip, u16 *data)
>  {
>  	struct spi_device *spi_dev = chip->spi_dev;
>  	int ret;
> -	__be16 buf;
> +
> +	guard(mutex)(&chip->lock);
>  
>  	gpiod_set_value(chip->rdwr_pin, 1);
>  	gpiod_set_value(chip->rdwr_pin, 0);
> @@ -360,6 +363,10 @@ static int ad7816_probe(struct spi_device *spi_dev)
>  		return -ENOMEM;
>  	chip = iio_priv(indio_dev);
>  
> +	ret = devm_mutex_init(&spi_dev->dev, &chip->lock);
> +	if (ret)
> +		return ret;
> +
>  	chip->spi_dev = spi_dev;
>  	for (i = 0; i <= AD7816_CS_MAX; i++)
>  		chip->oti_data[i] = 203;

