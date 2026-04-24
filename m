Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E6B2DCF45
	for <linux-iio@vger.kernel.org>; Fri, 24 Apr 2026 11:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777031312; cv=none; b=UJbwAc5iqNfiQCaT0lM9XjNq7AsUQjJoVzfqwlojByazJNzpYG7nxPUpujV5OhNfwVQ4lUnEoURo55oq8IR+9lreNxTstTeqa5frKkvXoF1+gJkCjNmrdj/BI3wIQdMoPe4KfrjZxszSIAi/6P1IOFwFswmF69jdRlAxD+o0kes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777031312; c=relaxed/simple;
	bh=XNDJ1WiFH8g3U0FL0+WTpHEIAqDSKIp5EwNyG6sd0OE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sWq4E2pNECfSHDk6LDJhekj5buT8tZvDmn2aswnP28gfnOOk++nkmNPBq26VaY3d02KWGLvDcErNvVbxPG5HoYjRiE6O1RUyvrHptlVpNIh49H83vt5SBx/23SqMQ99iYF0+iyruzXoJyLIml0pqKn7XkA/fRZISIur6t1h7Vw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rdLV5qSB; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rdLV5qSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97A6DC19425;
	Fri, 24 Apr 2026 11:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777031311;
	bh=XNDJ1WiFH8g3U0FL0+WTpHEIAqDSKIp5EwNyG6sd0OE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rdLV5qSB9dz/taNyetAJZSiDJU8TLWEYvPD7O/dok6Tk6AIWem2MV5HEFfquUxaGS
	 h+9mSrBLtRREoO6igaJ5cjasWmK2gb/Jm3kBP2nTRnBlHRrGoztn2csGldn0Q29Yg1
	 D4OpJbBfihZIAh8JYOdayIGPU5HzJkiQe1sAxgAOKTBj5rAjlGvoRqZtZlKpjFIwmb
	 sMArpPHAmgCuJA1sx2Ja3z31musaK6hJKL+X89Zb2nAXg4jpusRlRvuePNum5FcZI3
	 1HHCPE+lr5fDaesCHgDYul4UxYL/4uM/MDBWzL0XHAOFV2ntKnR8Sy9z2FAg9SrQGP
	 zTev33GkG448g==
Date: Fri, 24 Apr 2026 12:48:23 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, Gustavo
 Pagnotta Faria <gustavo.pagnotta@ime.usp.br>, Christian Barry
 <christian.barry@ime.usp.br>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: Use guard(mutex) for lock handling
Message-ID: <20260424124823.443b3c23@jic23-huawei>
In-Reply-To: <20260422211105.48158-1-eduardoaugustoabc@ime.usp.br>
References: <20260422211105.48158-1-eduardoaugustoabc@ime.usp.br>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Apr 2026 18:11:05 -0300
Eduardo Augusto <eduardoaugustoabc@ime.usp.br> wrote:

> Replace the explicit mutex_lock() and mutex_unlock() calls in
> mcp320x_read_raw() with guard(mutex)().
> 
> This simplifies the error handling paths by removing the need for
> the explicit unlock label while keeping the locking semantics
> unchanged.
> 
> Signed-off-by: Eduardo Augusto <eduardoaugustoabc@ime.usp.br>
> Co-developed-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
> Signed-off-by: Gustavo Pagnotta Faria <gustavo.pagnotta@ime.usp.br>
> Co-developed-by: Christian Barry <christian.barry@ime.usp.br>
> Signed-off-by: Christian Barry <christian.barry@ime.usp.br>
> ---
>  drivers/iio/adc/mcp320x.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index 57cff3772..799756f4c 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -44,6 +44,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/iio/iio.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/cleanup.h>
>  
>  enum {
>  	mcp3001,
> @@ -198,8 +199,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  	struct mcp320x *adc = iio_priv(indio_dev);
>  	int ret = -EINVAL;
>  	int device_index = 0;
> -
> -	mutex_lock(&adc->lock);
> +	guard(mutex)(&adc->lock);
>  
>  	device_index = spi_get_device_id(adc->spi)->driver_data;
>  
> @@ -208,7 +208,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  		ret = mcp320x_adc_conversion(adc, channel->address,
>  			channel->differential, device_index, val);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  
>  		ret = IIO_VAL_INT;
>  		break;
> @@ -216,7 +216,7 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  	case IIO_CHAN_INFO_SCALE:
>  		ret = regulator_get_voltage(adc->reg);
>  		if (ret < 0)
> -			goto out;
> +			return ret;
>  
>  		/* convert regulator output voltage to mV */
>  		*val = ret / 1000;
> @@ -225,9 +225,6 @@ static int mcp320x_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	}
>  
> -out:
> -	mutex_unlock(&adc->lock);
> -
>  	return ret;
Can do early returns now in all branches.  As Andy said, check for
reviews of similar code that has been posted recently.

If anyone who is doing this sort of work feels like taking the
combined feedback from those reviewing and writing a doc with examples
etc that would be great.  Maybe a blog or similar or we could see
if we could find a home for it in tree.

Too many patches to review for Andy or I to have the time, though
maybe when things calm down a bit...

Jonathan

>  }
>  

