Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A541891A9;
	Sun, 15 Mar 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773600754; cv=none; b=sO9L6l1MLUjPPofNwS0viNnOaeZYxYYuJC0uW76tqDC6YvenvdoWeY8mcRL8LKOtNanfeBxlMOGf19pRunqjRrwkV07rdLIvUY6EfIDK/3XINPlA1eFRZSsUC+EpkjnuNz7ICsU1onYuFAWd45kE1kcCjkbqNK1pn0RJaIqsEEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773600754; c=relaxed/simple;
	bh=FV+EI0smjT8S1w7eDJI5od9gRMB4R0LdWbJuGCnHhk8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RHsRMnwieI+vOgeN2rwCs7MPCRWj+gBZUaw95o/40qrFKZY+3+tFC3OCoHqLsCs5QNlv5eL9hkT1Iuf8tVLgPjNRhoWsxkONbFZE/v1I7KeB1H6XqWJgpsZj8dr/d70LZbi5kYxt6JV8tIHIb/3kFjduIiO3g1jnZjsWPWcekX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8svTJv3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8svTJv3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DD9C4CEF7;
	Sun, 15 Mar 2026 18:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773600754;
	bh=FV+EI0smjT8S1w7eDJI5od9gRMB4R0LdWbJuGCnHhk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=c8svTJv3Ze0qsI9lhD69A/e60uEwxad601VZ83SoiZcSETcNQ+iMg1ZDMGRW4gyA5
	 jdCtLieq2QOba1OpWXoqg9juKj/cNanIGPLnC8OwP5xyKVhvpy/wFR9HxC+b5OagV/
	 QPeGieuui+BV+7bWmvE1BqBUnvOkEb8hfD1efhz15wW/pPbndlzglbmO7n9dlg0L/D
	 S/laSsi7jfjYX+k4lykwJe54Q3SnqQGSmA5KJGaE9vk20pvf8B5Lo9f18/lmy3ebvY
	 6uiBTpko0391tyBtP9F1D0w1bbBLDvLTwXc/7NonvKv8fCwsmzxuT5LFgFkeF+6xB5
	 gZT+iFYEgYiNQ==
Date: Sun, 15 Mar 2026 18:52:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 kees@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] iio: ssp_sensors: ssp_spi: use guard() to
 release mutexes
Message-ID: <20260315185226.2bc4d8bc@jic23-huawei>
In-Reply-To: <20260315125509.857195-2-sanjayembedded@gmail.com>
References: <20260315125509.857195-1-sanjayembedded@gmail.com>
	<20260315125509.857195-2-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Mar 2026 18:25:07 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Replace explicit mutex_lock() and mutex_unlock() with the guard() macro
> for cleaner and safer mutex handling.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 54 ++++++++++--------------
>  1 file changed, 22 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 6c81c0385fb5..87a38002b218 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -2,6 +2,7 @@
>  /*
>   *  Copyright (C) 2014, Samsung Electronics Co. Ltd. All Rights Reserved.
>   */
> +#include <linux/cleanup.h>
>  
>  #include "ssp.h"
>  
> @@ -189,55 +190,49 @@ static int ssp_do_transfer(struct ssp_data *data, struct ssp_msg *msg,
>  
>  	msg->done = done;
>  
> -	mutex_lock(&data->comm_lock);
> +	guard(mutex)(&data->comm_lock);
>  
>  	status = ssp_check_lines(data, false);
> -	if (status < 0)
> -		goto _error_locked;
> +	if (status < 0) {
> +		data->timeout_cnt++;
> +		return status;
> +	}
>  
>  	status = spi_write(data->spi, msg->buffer, SSP_HEADER_SIZE);
>  	if (status < 0) {
>  		gpiod_set_value_cansleep(data->ap_mcu_gpiod, 1);
>  		dev_err(SSP_DEV, "%s spi_write fail\n", __func__);
> -		goto _error_locked;
> +		data->timeout_cnt++;
guard() isn't always the right answer.  The counter needing updating
here in every error path makes me thing maybe it isn't here.
Pity there is one error path at the top where that's not updated,
otherwise I'd suggest updating in a wrapper function.

> +		return status;
>  	}
>  
>  	if (!use_no_irq) {
> -		mutex_lock(&data->pending_lock);
> -		list_add_tail(&msg->list, &data->pending_list);
> -		mutex_unlock(&data->pending_lock);
> +		scoped_guard(mutex, &data->pending_lock)

The guard brings little here, but if you want to do it.
		guard(mutex)(&data->pending_lock);
is fine - no need for scoped_guard() and increased indent.
Make sure you understand why that is effectively the same in this cases.

> +			list_add_tail(&msg->list, &data->pending_list);
>  	}
>  
>  	status = ssp_check_lines(data, true);
>  	if (status < 0) {
>  		if (!use_no_irq) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> +			scoped_guard(mutex, &data->pending_lock)

As above.

> +				list_add_tail(&msg->list, &data->pending_list);
>  		}
> -		goto _error_locked;
> +		data->timeout_cnt++;
> +		return status;
>  	}
>  
> -	mutex_unlock(&data->comm_lock);
> -
>  	if (!use_no_irq && done)
>  		if (wait_for_completion_timeout(done,
>  						msecs_to_jiffies(timeout)) ==
>  		    0) {
> -			mutex_lock(&data->pending_lock);
> -			list_del(&msg->list);
> -			mutex_unlock(&data->pending_lock);
> +			scoped_guard(mutex, &data->pending_lock)
> +				list_add_tail(&msg->list, &data->pending_list);
Slightly trickier but holding the mutex over the timeout_cnt is fine, so
I'd use guard() here as well.

>  
>  			data->timeout_cnt++;
>  			return -ETIMEDOUT;
>  		}
>  
>  	return 0;
> -
> -_error_locked:
> -	mutex_unlock(&data->comm_lock);
> -	data->timeout_cnt++;
> -	return status;
>  }
>  
>  static inline int ssp_spi_sync_command(struct ssp_data *data,
> @@ -360,7 +355,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  		 * this is a small list, a few elements - the packets can be
>  		 * received with no order
>  		 */
> -		mutex_lock(&data->pending_lock);
> +		guard(mutex)(&data->pending_lock);

Check the scope definition.  Given where you remove the unlock below
I'm not sure the scope is what you think it is.
Switch statements are tricky wrt to scope!




>  		list_for_each_entry_safe(iter, n, &data->pending_list, list) {
>  			if (iter->options == msg_options) {
>  				list_del(&iter->list);
> @@ -376,10 +371,8 @@ int ssp_irq_msg(struct ssp_data *data)
>  			 * check but let's handle this
>  			 */
>  			buffer = kmalloc(length, GFP_KERNEL | GFP_DMA);
> -			if (!buffer) {
> -				ret = -ENOMEM;
> -				goto _unlock;
> -			}
> +			if (!buffer)
> +				return -ENOMEM;
>  
>  			/* got dead packet so it is always an error */
>  			ret = spi_read(data->spi, buffer, length);
> @@ -391,7 +384,7 @@ int ssp_irq_msg(struct ssp_data *data)
>  			dev_err(SSP_DEV, "No match error %x\n",
>  				msg_options);
>  
> -			goto _unlock;
> +			return ret;
>  		}
>  
>  		if (msg_type == SSP_AP2HUB_READ)
> @@ -409,15 +402,13 @@ int ssp_irq_msg(struct ssp_data *data)
>  				msg->length = 1;
>  
>  				list_add_tail(&msg->list, &data->pending_list);
> -				goto _unlock;
> +				return ret;
>  			}
>  		}
>  
>  		if (msg->done)
>  			if (!completion_done(msg->done))
>  				complete(msg->done);
> -_unlock:
> -		mutex_unlock(&data->pending_lock);
>  		break;
>  	case SSP_HUB2AP_WRITE:
>  		buffer = kzalloc(length, GFP_KERNEL | GFP_DMA);
> @@ -448,7 +439,7 @@ void ssp_clean_pending_list(struct ssp_data *data)
>  {
>  	struct ssp_msg *msg, *n;
>  
> -	mutex_lock(&data->pending_lock);
> +	guard(mutex)(&data->pending_lock);
>  	list_for_each_entry_safe(msg, n, &data->pending_list, list) {
>  		list_del(&msg->list);
>  
> @@ -456,7 +447,6 @@ void ssp_clean_pending_list(struct ssp_data *data)
>  			if (!completion_done(msg->done))
>  				complete(msg->done);
>  	}
> -	mutex_unlock(&data->pending_lock);
>  }
>  
>  int ssp_command(struct ssp_data *data, char command, int arg)

