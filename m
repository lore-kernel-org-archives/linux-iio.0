Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743E12DB7AE;
	Tue, 28 Apr 2026 16:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393342; cv=none; b=TsPGEE8Ysn846VJ2L2YQqtrIofQyim/M6HWsFtvENGqriCOjtYYstrtB8axr2hVD1pCVstQhsKJsjgKhWsYy3Nq83RuTQOy/cHlXaJtQwZGWjD2t3Ryo5IDw1fv1a5Aj5eBaO9X+dOX03JUnAqLrKGXUWT6qk5WL9VXnEk83+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393342; c=relaxed/simple;
	bh=g3TKcDcUHx2YppLRlAbc96K15CZrW507xnVtNQUFvv0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCcRUedYUuLXVojWGK0ng6NA0jmarYcNR+qLxYCG9n3a5VQea/gcrhVBjJW4EcINpqoR+4VAW8Bz+6A9X1iFqeoLmnv0mB15ekaXZnY0WY0Ul81qyjoVeihqhldrLanQ4uW0Q9hvqaWWwhQw1hmFxdt9ORj8IwQHhstcQM/Bbaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdpPd9Lk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdpPd9Lk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19404C2BCAF;
	Tue, 28 Apr 2026 16:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393342;
	bh=g3TKcDcUHx2YppLRlAbc96K15CZrW507xnVtNQUFvv0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RdpPd9Lk6PqKVVoz2ECgl7QyGt2uUoApK3cY2jCaENBmR9VXe2E2PXiDCTW3Zp2Ol
	 xM4VXLQJrYsdIVxQO5tlncIqvprMUe6pQPOkI2Su8votLAFjIxQijlPJwDKYKxmJKg
	 fsp1+Yy0+UsbzsRcczKS1+sQbfvfgXOonJIuJhwfFE43SbW/jHMI8Tu7FQVRi9wd9x
	 0RIFnU35Vi6Nfiu0GmtRXqmmHNe1JjsM+2Pk4qP37oomKKxuF/YoSdR2tvTJovstpb
	 I1jF+enyysYrRxXcscBX/fj/qbOZOcPCMPKj3JhX/KTHjLJueIlgmiDwyZUxDnDz4o
	 AQkv3HMr/OZGQ==
Date: Tue, 28 Apr 2026 17:22:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: Re: [PATCH v0 04/14] iio: magnetometer: ak8975: Inline timeout
 constants
Message-ID: <20260428172212.1e1bacd9@jic23-huawei>
In-Reply-To: <20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
References: <20260427201412.3067235-1-andriy.shevchenko@linux.intel.com>
	<20260427201412.3067235-5-andriy.shevchenko@linux.intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 22:09:49 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Since we have switched to using macros from iopoll.h it's better to read
> when the timeout values are explicitly provided in the parameters of the
> respective helpers.
> 
> Besides that, fix the home grown and obviously wrong in some cases the
> jiffy-based timeout.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

One comment inline on pulling the actual numbers for the 1st two
close to each other in the driver (or use local constants for them
if you prefer).
> ---
>  drivers/iio/magnetometer/ak8975.c | 16 ++++------------
>  1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 4cc92a15e937..53987f3b13d2 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -16,6 +16,7 @@
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
>  #include <linux/iopoll.h>
> +#include <linux/jiffies.h>
>  #include <linux/minmax.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> @@ -133,13 +134,6 @@
>  
>  #define AK09912_MAX_REGS		AK09912_REG_ASAZ
>  
> -/*
> - * Miscellaneous values.
> - */
> -#define AK8975_MAX_CONVERSION_TIMEOUT	500
> -#define AK8975_CONVERSION_DONE_POLL_TIME 10
> -#define AK8975_DATA_READY_TIMEOUT	((100*HZ)/1000)
> -
>  /*
>   * Precalculate scale factor (in Gauss units) for each axis and
>   * store in the device data.
> @@ -658,8 +652,7 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
>  
>  	/* Wait for the conversion to complete. */
>  	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> -				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> -				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> +				 10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC);
>  	if (ret)
>  		return ret;
>  
> @@ -678,8 +671,7 @@ static int wait_conversion_complete_polled(struct ak8975_data *data)
>  
>  	/* Wait for the conversion to complete. */
>  	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> -				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> -				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> +				10 * USEC_PER_MSEC, 500 * USEC_PER_MSEC,

I'm not that keen on these being repeated in two places given they take the same values.
Perhaps we should push them up to the caller?  That is, add them as
parameters of wait_completion_complete_gpio() and wait_completion_polled()

I don't mind if we have them hard coded into those two calls as they are right next
to each other so it should be obvious they values are the same.

Ideally I'd like to see a comment on why these numbers next to those calls.

Fine to pass them in msecs and do the scaling here.  Just name the variables to
make that clear.  poll_msecs timeout_msecs maybe?

>  				true,
>  				client, data->def->ctrl_regs[ST1]);
>  	if (ret)
> @@ -699,7 +691,7 @@ static int wait_conversion_complete_interrupt(struct ak8975_data *data)
>  
>  	ret = wait_event_timeout(data->data_ready_queue,
>  				 test_bit(0, &data->flags),
> -				 AK8975_DATA_READY_TIMEOUT);
> +				 msecs_to_jiffies(100));
>  	clear_bit(0, &data->flags);
>  
>  	return ret > 0 ? 0 : -ETIMEDOUT;

