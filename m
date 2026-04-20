Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA73A5E75;
	Mon, 20 Apr 2026 18:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776708927; cv=none; b=J7NyZif6L29pcKl0YjL6q0Hrg1cgI4rZV51rzXsCKXpm+4QWGtWL1xyM+oubyrKQ7QAK1lzEvNQhq6+BqBykax64KIroVzDmATEAALxmF/vBpBtiAN6z9Rrn9r6HMkOjktmbod0WBv2oj2CEi/zkiwReH8XcmmSoBWc74/KHRy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776708927; c=relaxed/simple;
	bh=yq/QOSQF+GF8jcOgjqBWByPYclByv7msNihyzmEa+Wk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8VkT8Z2bn3c7E9jBfBujFlTIp1RnNFg8Let0VE3rwYk+5UwXnfbQ7UyOMqallx/yO1urZEC+uBv9CFySifCTMpAN8QD/ienkGD51bYLVpL05c784gI+oHJwGSjDlnY8Zkrqf+RZnzCH7G0qf8WAqW8AfP94mrwJ731rVfNaTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LzfyYK6O; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LzfyYK6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF68AC19425;
	Mon, 20 Apr 2026 18:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776708927;
	bh=yq/QOSQF+GF8jcOgjqBWByPYclByv7msNihyzmEa+Wk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LzfyYK6OVuxS9qsZaLkbja02bQoJ2UoQ8org6vpUdv8NWN+jZFY6uZSpBY1vPVnbI
	 q0DIwkuKiDHpowh63fFCjF0UEDrYu8MSp/8ddAba0LoK9FZD2OcKp2xC2PszyB+MTC
	 pO0YZOK8rPNZfViUM+n3o5x0Bq3vlqbh2mibH/BLgHylcLcQv1kVi1zOrvgP1jdZpd
	 RejlUAHaX6OjHtLemZIzKTqOEP2XlZ+6VGBmW8TzSuki+fzFlU6/ajvBhmhLiCOB8U
	 REzToUopZ0XkycggImAqXZeRGZRvHeMflFW8MqNtNiv7vvhNcSUruiAlhZ/CE41Uvu
	 pNi8ppmtBfRIA==
Date: Mon, 20 Apr 2026 19:15:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Rondon <grondon@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bmc150: use guard(mutex) for mutex handling
Message-ID: <20260420191519.43604fb0@jic23-huawei>
In-Reply-To: <20260408082843.35716-1-grondon@gmail.com>
References: <20260408082843.35716-1-grondon@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  8 Apr 2026 09:28:42 +0100
Gabriel Rondon <grondon@gmail.com> wrote:

> Replace manual mutex_lock()/mutex_unlock() pairs with guard(mutex)
> from cleanup.h in functions where the mutex protects the entire
> function body. This simplifies error paths by removing the need for
> explicit unlock calls before returning.
> 
> Converted functions:
>   - bmc150_accel_get_temp()
>   - bmc150_accel_write_event_config()
>   - bmc150_accel_get_fifo_watermark()
>   - bmc150_accel_get_fifo_state()
>   - bmc150_accel_set_watermark()
>   - bmc150_accel_fifo_flush()
>   - bmc150_accel_trigger_set_state()
Not sure this list is useful in the commit log. Rather verbose.
> 
> Functions where the mutex is released before subsequent non-trivial
> work (e.g. bmc150_accel_get_axis, bmc150_accel_trigger_handler) are
Add () after those function names.

I took a quick look and can't see anything beyond an if (ret) check in
bmc150_accel_get_axis()

If it's the only one left I'd use scoped_guard() for bmc150_accel_trigger_handler()

I'm not against a mix of guard and not as appropriate in a given place, but
when there is only one left it seems silly to make a reader have to consider
both styles!

> left unchanged to preserve the existing lock scope.
> 
> Signed-off-by: Gabriel Rondon <grondon@gmail.com>
Good patch in general but there is room for further simplifications
in the code being touched.

> ---
>  drivers/iio/accel/bmc150-accel-core.c | 49 ++++++++-------------------
>  1 file changed, 15 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
> index 42ccf0316ce5..6a2d7a133d2e 100644
> --- a/drivers/iio/accel/bmc150-accel-core.c
> +++ b/drivers/iio/accel/bmc150-accel-core.c
> @@ -7,6 +7,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> +#include <linux/cleanup.h>
>  #include <linux/delay.h>
>  #include <linux/slab.h>
>  #include <linux/acpi.h>
> @@ -597,21 +598,18 @@ static int bmc150_accel_set_scale(struct bmc150_accel_data *data, int val)
>  static int bmc150_accel_get_temp(struct bmc150_accel_data *data, int *val)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
> -	int ret;
>  	unsigned int value;
> +	int ret;

Unrelated change - here it just acts as noise for the real changes so don't
do this sort of code movement of lines we aren't otherwise touching.

>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  
>  	ret = regmap_read(data->regmap, BMC150_ACCEL_REG_TEMP, &value);
>  	if (ret < 0) {
>  		dev_err(dev, "Error reading reg_temp\n");
> -		mutex_unlock(&data->mutex);
>  		return ret;
>  	}
>  	*val = sign_extend32(value, 7);
>  
> -	mutex_unlock(&data->mutex);
> -
>  	return IIO_VAL_INT;
>  }
>  

> @@ -847,9 +842,8 @@ static ssize_t bmc150_accel_get_fifo_watermark(struct device *dev,
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	int wm;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  	wm = data->watermark;
> -	mutex_unlock(&data->mutex);
>  
>  	return sprintf(buf, "%d\n", wm);

	return sprintf(buf, "%d\n", data->watermark);

>  }
> @@ -862,9 +856,8 @@ static ssize_t bmc150_accel_get_fifo_state(struct device *dev,
>  	struct bmc150_accel_data *data = iio_priv(indio_dev);
>  	bool state;
>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  	state = data->fifo_mode;
> -	mutex_unlock(&data->mutex);
>  
>  	return sprintf(buf, "%d\n", state);

	return sprintf(buf, "%d\n", data->fifo_mode);

Though, given we are touching them anyway maybe also
	return sysfs_emit(buf, %d\n", data->fifo_mode);
is appropriate.

>  }
> @@ -906,9 +899,8 @@ static int bmc150_accel_set_watermark(struct iio_dev *indio_dev, unsigned val)
>  	if (val > BMC150_ACCEL_FIFO_LENGTH)
>  		val = BMC150_ACCEL_FIFO_LENGTH;

Unrelated but if I were reviewing this code today I'd have suggested
	val = min(val, BMC150_ACCEL_FIFO_LENGTH);

>  
> -	mutex_lock(&data->mutex);
> +	guard(mutex)(&data->mutex);
>  	data->watermark = val;
> -	mutex_unlock(&data->mutex);
>  
>  	return 0;
>  }


