Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FB175D53;
	Sun, 12 Jul 2026 00:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783816986; cv=none; b=RHo6wuHMMK5JdHf/5CR2/i33hNcvseU8cmu3p9aYUNcUtBOyRNJNsqjyOu4N6QH2pfxR9WQ5zlkC9Oc2YoW0f49GGOZROUo6Q1x/WOy+GrEjL3/+d6qs/Kufxzgh+uuAansNvdyF2y9XeaW99t3/QzCqtdgPXtwJglGAze9gcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783816986; c=relaxed/simple;
	bh=5SH6Z5BXfsmKBicGUwX0xRiQXjJZ7UxcOK3QabrHwOc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUXicwFBHzkq7qPtjDadB6u0iuNvkyX9SuURFxUTgriBSpDng39fxk73kObz5HZ2+OpCSrx8hy4167SAYlyyCYkNvkEkJAUdswOYDIBBbgyg2gV1tNSO2YAabirsZAP6JcvkNhXZeI9ELNCiyNe4OfJJYKfStd6J1uVay/5ao6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOzZwGZH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOzZwGZH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AAA1F000E9;
	Sun, 12 Jul 2026 00:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783816984;
	bh=4Hq0UkhYBppQvey19v1sitbCzGbx5+0yNAXJlGJWqpA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gOzZwGZHFPCbWIe0PEQ9jZ5U0geDjcowzjwII7p1WRg9nR7LVHl9ProNVYGR03EHT
	 ldd8SNpQuw0/UE6g1Ls1xwHhUoSPo6jCNsZsxiXA2mprv9ksExBzqx2T3iPL6Srhij
	 B+8gPC1NEnZwj+aolaaYrM6qgH/G6RpLZVCYAmYT40/iqU9anXavyf/Yuv88algHsZ
	 /WZ6Arf5FzlG0NiYR32wAFeV7ZwVhNjXiQ8q2nSCtJ1Lo/32N6X7JNXuaK4aBYhKbM
	 LLFMRRdxo2xeYay33GBGiYYkaYPWrxFlH2jrmWPxZh8170Cduc6VFifRWjFoCo/dPK
	 o95/3uvdqRL5g==
Date: Sun, 12 Jul 2026 01:43:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: opt3001: split opt3001_get_processed()
 logic
Message-ID: <20260712014300.78b2bbd1@jic23-huawei>
In-Reply-To: <20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com>
References: <20260711-opt3001-unwind-cleanup-v2-1-47f617e00c65@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 11 Jul 2026 08:14:54 +0200
Joshua Crofts <joshua.crofts1@gmail.com> wrote:

> Split the logic inside the opt3001_get_processed() function, as the
> current flow is hard to read, mixing IRQ and non-IRQ code blocks.
> 
> Separate the IRQ code path into its own function, same for the
> non-IRQ path.
> 
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Hi Joshua

Thanks for doing.  The only thing I'll add to David's review
is to check if comments or code should be rewrapped after they
change indent.  Won't save many lines, but at least ensures the
code remains consistently formatted.

Jonathan

> ---
> This patch fixes the absolutely horrible code flow in the
> opt3001_get_processed() function, where the original implementation
> used checks whether IRQ mode is enabled to execute blocks of code,
> making the function hard to read. Ideas on how to improve the functions
> are more than welcome.
> 
> Originally suggested by Jonathan Cameron.
> ---
> Changes in v2:
> - Remove ternary operator and add if/else
> - Remove timeout variable
> - Link to v1: https://lore.kernel.org/r/20260708-opt3001-unwind-cleanup-v1-1-900b2cfddb6a@gmail.com
> ---
>  drivers/iio/light/opt3001.c | 197 ++++++++++++++++++++++++++------------------
>  1 file changed, 118 insertions(+), 79 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index 2bce6cd5f4e4..d1a2426cd355 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -316,36 +316,33 @@ static const struct iio_chan_spec opt3002_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(1),
>  };
>  
> -static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
> +static int opt3001_get_processed_irq(struct opt3001 *opt, int *val, int *val2)
>  {
>  	struct i2c_client *client = opt->client;
>  	struct device *dev = &client->dev;
> -	int ret;
>  	u16 mantissa;
> -	u16 reg;
>  	u8 exponent;
>  	u16 value;
> -	long timeout;
> +	u16 reg;
> +	int ret;
>  
> -	if (opt->use_irq) {
> -		/*
> -		 * Enable the end-of-conversion interrupt mechanism. Note that
> -		 * doing so will overwrite the low-level limit value however we
> -		 * will restore this value later on.
> -		 */
> -		ret = i2c_smbus_write_word_swapped(client,
> -						   OPT3001_LOW_LIMIT,
> -						   OPT3001_LOW_LIMIT_EOC_ENABLE);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -			return ret;
> -		}
> -
> -		/* Allow IRQ to access the device despite lock being set */
> -		opt->ok_to_ignore_lock = true;
> +	/*
> +	 * Enable the end-of-conversion interrupt mechanism. Note that
> +	 * doing so will overwrite the low-level limit value however we
> +	 * will restore this value later on.

Wrap comments that have change indent.

> +	 */
> +	ret = i2c_smbus_write_word_swapped(client,
> +					   OPT3001_LOW_LIMIT,
> +					   OPT3001_LOW_LIMIT_EOC_ENABLE);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_LOW_LIMIT);
> +		return ret;
>  	}
>  
> +	/* Allow IRQ to access the device despite lock being set */
> +	opt->ok_to_ignore_lock = true;
> +
>  	/* Reset data-ready indicator flag */
>  	opt->result_ready = false;
>  
> @@ -367,70 +364,33 @@ static int opt3001_get_processed(struct opt3001 *opt, int *val, int *val2)
>  		goto err;
>  	}
>  
> -	if (opt->use_irq) {
> -		/* Wait for the IRQ to indicate the conversion is complete */
> -		ret = wait_event_timeout(opt->result_ready_queue,
> -					 opt->result_ready,
> -					 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> -		if (ret == 0) {
> -			ret = -ETIMEDOUT;
> -			goto err;
> -		}
> -	} else {
> -		/* Sleep for result ready time */
> -		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> -			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
> -		msleep(timeout);
> -
> -		/* Check result ready flag */
> -		ret = i2c_smbus_read_word_swapped(client, OPT3001_CONFIGURATION);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to read register %02x\n",
> -				OPT3001_CONFIGURATION);
> -			goto err;
> -		}
> -
> -		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
> -			ret = -ETIMEDOUT;
> -			goto err;
> -		}
> -
> -		/* Obtain value */
> -		ret = i2c_smbus_read_word_swapped(client, OPT3001_RESULT);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to read register %02x\n",
> -				OPT3001_RESULT);
> -			goto err;
> -		}
> -		opt->result = ret;
> -		opt->result_ready = true;
> -	}
> +	ret = wait_event_timeout(opt->result_ready_queue,
> +				 opt->result_ready,
> +				 msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> +	if (ret == 0)
> +		ret = -ETIMEDOUT;
>  
>  err:
> -	if (opt->use_irq)
> -		/* Disallow IRQ to access the device while lock is active */
> -		opt->ok_to_ignore_lock = false;
> +	opt->ok_to_ignore_lock = false;
>  
>  	if (ret < 0)
>  		return ret;
>  
> -	if (opt->use_irq) {
> -		/*
> -		 * Disable the end-of-conversion interrupt mechanism by
> -		 * restoring the low-level limit value (clearing
> -		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
> -		 * those enable bits would affect the actual limit value due to
> -		 * bit-overlap and therefore can't be done.
> -		 */
> -		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> -		ret = i2c_smbus_write_word_swapped(client,
> -						   OPT3001_LOW_LIMIT,
> -						   value);
> -		if (ret < 0) {
> -			dev_err(dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -			return ret;
> -		}
> +	/*
> +	 * Disable the end-of-conversion interrupt mechanism by
> +	 * restoring the low-level limit value (clearing
> +	 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
> +	 * those enable bits would affect the actual limit value due to
> +	 * bit-overlap and therefore can't be done.
And this one.
> +	 */
> +	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> +	ret = i2c_smbus_write_word_swapped(client,
> +					   OPT3001_LOW_LIMIT,
> +					   value);

I'd rewrap this as well probably. I'm fine with it one slightly long line.

> +	if (ret < 0) {
> +		dev_err(dev, "failed to write register %02x\n",
> +			OPT3001_LOW_LIMIT);
> +		return ret;
>  	}
>  
>  	exponent = OPT3001_REG_EXPONENT(opt->result);
