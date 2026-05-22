Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFA23B47CF;
	Fri, 22 May 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453971; cv=none; b=ek5ZGooqMtwf3tSXUrh3Rr6wNFsMX8rSUUO88JTdqyWiBIxJKy4FGZQu22LrOf1b/pI0Rsjkp4MGWEa0L1PzJQTsA2xKqYoHsgJ/SzjhB2YGhy1pCxrMw3Nx1c9+ydvvEyUfEG+aJqLAxc5voznBBHG6w7zvXXSdOItyCxb193g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453971; c=relaxed/simple;
	bh=o+oRcxpUM9cp0udN5BC6r8RM9H3W9w1Aqr2yDV8baBw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CIJRBb7tNoe4PlTpH5yAeVlHCpzy4T300ehmnklrKFzB4R+iq3mw/BeYCIk1Ogl/0QLhLGiUuC46/9InOzxg/nLnQgw3UvgZ7NWSFXAvzJV4itK+/lvM8fbYnIEQyejj7GmCmWHhHMRVtRVpZMw6H6QrFr1V2CxY+1lLndU+gJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VcTsrbZq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VcTsrbZq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC41D1F000E9;
	Fri, 22 May 2026 12:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779453970;
	bh=1gIF7RMl8o4KKwmvQCTCGk5Sgj9p61mzrsb9TNtWpwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VcTsrbZqMFuQAjSGx3xhTst+9Um97DpBCFKuIXhc4Sx/LcIP2CgkzYvJTA8fftQfP
	 DV88n15RSCzF+lMRHEwhxaHbxhokAranntIPLfSbsHqhsKa/k5wH9PcY5aHk71Dyd6
	 0tNNzVmWU4kHfPQPJwjdiBlqp1+vwPh3rb3VZfYI4bz3Wb/vaIzjX/ahP2Y7JUF+y8
	 h5VeEnznCoOU6IsHYEKQlDUUAdsNGnobHpQWdlqHBS4hodss/7CJbabujjh+CgQYjq
	 PWq47F5QsLd5M/Kc8j93geUi6RogKximNjI7UcsNms0o6PjbQA4xLuNhdKxGADWk25
	 jubPX4oznOrTA==
Date: Fri, 22 May 2026 13:46:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v7] iio: imu: kmx61: Use guard(mutex)() over manual
 locking
Message-ID: <20260522134603.07d31cbd@jic23-huawei>
In-Reply-To: <20260521223044.61410-1-m32285159@gmail.com>
References: <20260521223044.61410-1-m32285159@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 17:30:43 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> Include linux/cleanup.h to take advantage of new macros.
> 
> Replace manual mutex_lock() and mutex_unlock() calls across the file
> with guard(mutex)() and scoped_guard() where appropriate to simplify
> error paths and eliminate manual locking calls.
> 
> Add new helper function kmx61_read_for_each_active_channel() to mitigate
> certain style issues and to prevent notifying that the IRQ is finished
> whilst holding the lock.
> 
> Update certain returns, and add default case to return -EINVAL in
> kmx61_read_raw().
> 
> Remove now-redundant gotos and ret variables, as the new RAII macros
> make them unneeded.

A few remaining things inline.  I'll tweak whilst applying.

Tweaked as:
diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
index 52a6e044e1e5..b8a8297b39af 100644
--- a/drivers/iio/imu/kmx61.c
+++ b/drivers/iio/imu/kmx61.c
@@ -827,15 +827,17 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
                default:
                        return -EINVAL;
                }
-       case IIO_CHAN_INFO_SAMP_FREQ:
+       case IIO_CHAN_INFO_SAMP_FREQ: {
                if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
                        return -EINVAL;
 
-               scoped_guard(mutex, &data->lock)
-                       ret = kmx61_get_odr(data, val, val2, chan->address);
+               guard(mutex)(&data->lock);
+
+               ret = kmx61_get_odr(data, val, val2, chan->address);
                if (ret)
                        return -EINVAL;
                return IIO_VAL_INT_PLUS_MICRO;
+       }
        default:
                return -EINVAL;
        }
@@ -1178,8 +1180,6 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq, void *private)
  * @indio_dev: IIO Device struct to read from
  * @buffer: Destination buffer to write to, the array must be of at least size 8
  *
- * Intended only for use in kmx61_trigger_handler().
- *
  * Return:
  * 0 on success,
  */

See below for why.


> 
> Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> ---
>  drivers/iio/imu/kmx61.c | 129 +++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index 3cd91d8a89ee..6e9eafc06d78 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -7,6 +7,7 @@
>   * IIO driver for KMX61 (7-bit I2C slave address 0x0E or 0x0F).
>   */
>  
> +#include <linux/cleanup.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/mod_devicetable.h>
> @@ -783,7 +784,7 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  	struct kmx61_data *data = kmx61_get_data(indio_dev);
>  
>  	switch (mask) {
> -	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_RAW: {
>  		switch (chan->type) {
>  		case IIO_ACCEL:
>  			base_reg = KMX61_ACC_XOUT_L;
> @@ -794,28 +795,24 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> -		mutex_lock(&data->lock);
> +		guard(mutex)(&data->lock);
>  
>  		ret = kmx61_set_power_state(data, true, chan->address);
> -		if (ret) {
> -			mutex_unlock(&data->lock);
> +		if (ret)
>  			return ret;
> -		}
>  
>  		ret = kmx61_read_measurement(data, base_reg, chan->scan_index);
>  		if (ret < 0) {
>  			kmx61_set_power_state(data, false, chan->address);
> -			mutex_unlock(&data->lock);
>  			return ret;
>  		}
>  		*val = sign_extend32(ret >> chan->scan_type.shift,
>  				     chan->scan_type.realbits - 1);
>  		ret = kmx61_set_power_state(data, false, chan->address);
> -
> -		mutex_unlock(&data->lock);
>  		if (ret)
>  			return ret;
>  		return IIO_VAL_INT;
> +	}
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> @@ -834,41 +831,40 @@ static int kmx61_read_raw(struct iio_dev *indio_dev,
>  		if (chan->type != IIO_ACCEL && chan->type != IIO_MAGN)
>  			return -EINVAL;
>  
> -		mutex_lock(&data->lock);
> -		ret = kmx61_get_odr(data, val, val2, chan->address);
> -		mutex_unlock(&data->lock);
> +		scoped_guard(mutex, &data->lock)
> +			ret = kmx61_get_odr(data, val, val2, chan->address);

Why is this one a scoped_guard()?  Seems like it would be more consistent
if it was done like the one above with {} and guard()


>  		if (ret)
>  			return -EINVAL;
Unconnected to this patch but why are we eating the error code from kmx61_get_odr()?
In practice makes no difference as -EINVAL is the only error returned.

Still nice to do
		if (ret)
			return ret;
so we don't need to go check that.
I'd be fine with you sneaking this in this patch with a brief not in the commit
message if you want to. Or can leave for another day.

>  		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
>  	}
> -	return -EINVAL;
>  }
>  
...


>  
>  static void kmx61_trig_reenable(struct iio_trigger *trig)
> @@ -1181,30 +1172,51 @@ static irqreturn_t kmx61_data_rdy_trig_poll(int irq, void *private)
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t kmx61_trigger_handler(int irq, void *p)
> +/**
> + * kmx61_read_for_each_active_channel() - Read each active channel into a buffer
> + *
> + * @indio_dev: IIO Device struct to read from
> + * @buffer: Destination buffer to write to, the array must be of at least size 8
> + *
> + * Intended only for use in kmx61_trigger_handler().
Not seeing a reason to have this comment.  If there is another useful
place to use it the function is fairly generic.  Right now there
isn't obvious, but we don't need to justify that!

> + *

