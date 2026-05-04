Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953693DFC75;
	Mon,  4 May 2026 15:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777907174; cv=none; b=BVK4oTJ+FnqRhW+fdmddhZExCM87dXGf8BQyizjpMdiNEvi9G5ui1yLIFSIAIqRp7WoCzD1Azkappbo/ce8QaW49fUdJPejMr7jxTnxsZsOfXue+b2yhLAzd+nYVWZXknhOxKdvZ2lG5HlRFRAVZRGpS05ioDBLzRpgvfeHLHYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777907174; c=relaxed/simple;
	bh=VGRg8Q/l5/7IklFbItHWa4BLQnJOOeYP7gWeXv6zdCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TzIX9JHqr4I/Ch++YD08d5xdNX68kg2FD4iG/0iMhUcYwOkMgmL6RtfvHbkzyrmu9qcrYAJisyVe8gIEvsAdaG7QLesi4X25zm7QkM9eKnKyT4WAUF+YILLPIslp3zMWIRg7agiUyX60mLxgjzAduuDHcqBVR4O8x6jpOe/ZYS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=guFRaS0k; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="guFRaS0k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D19C2BCB8;
	Mon,  4 May 2026 15:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777907174;
	bh=VGRg8Q/l5/7IklFbItHWa4BLQnJOOeYP7gWeXv6zdCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=guFRaS0kWaxDzS967TMQGvmzi0HbNvF/m+d5zuUg7j/fgibhCHU4ZMYhTA9X2NwPS
	 WiuCoMsJgPUeGdqH6fZ/QdGN/UsNlRGYuWWoHMvk5f2AppbTPRp/v0dAv56XwjfqLk
	 ZKjliczseYZhR7jTND36PMsJDAgq+T/S7yPccGu7NGW+YOeUvEsnnDwTOJde0pkZgB
	 GWxCwqS+oXK6NCgyGaRVM5zcVLT6m+sAug30i3rR9tAc7Id+vfPJDKxM9A57F/m1Z6
	 88yQOYJPuGNu4MTL5WBz1uzRyziH33zx4w0sjKeQgeG1gL6VMOKwRD/+h/2SPJuv+p
	 mTZ8623537tXg==
Date: Mon, 4 May 2026 16:06:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org>
Cc: joshua.crofts1@gmail.com, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v4 06/17] iio: magnetometer: ak8975: modernize polling
 loops with iopoll() macros
Message-ID: <20260504160606.07f87f10@jic23-huawei>
In-Reply-To: <20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
References: <20260504-magnetometer-fixes-v4-0-a291c2a7c71a@gmail.com>
	<20260504-magnetometer-fixes-v4-6-a291c2a7c71a@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 11:48:18 +0200
Joshua Crofts via B4 Relay <devnull+joshua.crofts1.gmail.com@kernel.org> wrote:

> From: Joshua Crofts <joshua.crofts1@gmail.com>
> 
> The driver currently uses while loops and msleep() for polling during
> conversion waits.
> 
> Replace the custom polling loops with readx_poll_timeout() and
> read_poll_timeout() macros from <linux/iopoll.h>. This reduces
> boilerplate, standardizes timeout handling and improves overall code
> readability, keeping the original timing and error behaviour. Add
> <linux/time.h> for USEC_PER_MSEC macro instead of using magic numbers.
> 
> Assisted-by: Gemini:3.1-Pro
> Co-developed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

One question inline on whether it is a good idea to be paranoid about
gpiod_get_value() potentially returning < 0 to indicate an error.
Right now that is treated as success.

> ---
>  drivers/iio/magnetometer/ak8975.c | 45 +++++++++++++++++----------------------
>  1 file changed, 19 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 57f50c09cca539c3733f516a1617375e9134c349..2e750c151435da57926969a63ba9fe996d774e7a 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -23,6 +23,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/time.h>
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  
> @@ -652,18 +653,15 @@ static int ak8975_setup(struct i2c_client *client)
>  static int wait_conversion_complete_gpio(struct ak8975_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
>  	int ret;
> +	int val;
>  
>  	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		if (gpiod_get_value(data->eoc_gpiod))
> -			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> -	}
> -	if (!timeout_ms)
> -		return -ETIMEDOUT;
> +	ret = readx_poll_timeout(gpiod_get_value, data->eoc_gpiod, val, val != 0,
> +				 AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> +				 AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC);
> +	if (ret)
> +		return ret;

Should we check val as well?   It might be negative if gpiod_get_value()
returned an error..  Obviously the original code didn't so this would be an
improvement rather than maintaining what that was doing.


>  
>  	ret = i2c_smbus_read_byte_data(client, data->def->ctrl_regs[ST1]);
>  	if (ret < 0)
> @@ -675,28 +673,23 @@ static int wait_conversion_complete_gpio(struct ak8975_data *data)
>  static int wait_conversion_complete_polled(struct ak8975_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -	u8 read_status;
> -	u32 timeout_ms = AK8975_MAX_CONVERSION_TIMEOUT;
>  	int ret;
> +	int val;
>  
>  	/* Wait for the conversion to complete. */
> -	while (timeout_ms) {
> -		msleep(AK8975_CONVERSION_DONE_POLL_TIME);
> -		ret = i2c_smbus_read_byte_data(client,
> -					       data->def->ctrl_regs[ST1]);
> -		if (ret < 0) {
> -			dev_err(&client->dev, "Error in reading ST1\n");
> -			return ret;
> -		}
> -		read_status = ret;
> -		if (read_status)
> -			break;
> -		timeout_ms -= AK8975_CONVERSION_DONE_POLL_TIME;
> +	ret = read_poll_timeout(i2c_smbus_read_byte_data, val, val != 0,
> +				AK8975_CONVERSION_DONE_POLL_TIME * USEC_PER_MSEC,
> +				AK8975_MAX_CONVERSION_TIMEOUT * USEC_PER_MSEC,
> +				true,
> +				client, data->def->ctrl_regs[ST1]);
> +	if (ret)
> +		return ret;
> +	if (val < 0) {
> +		dev_err(&client->dev, "Error in reading ST1\n");
> +		return val;
>  	}
> -	if (!timeout_ms)
> -		return -ETIMEDOUT;
>  
> -	return read_status;
> +	return val;
>  }
>  
>  /* Returns 0 if the end of conversion interrupt occurred or -ETIMEDOUT otherwise */
> 

