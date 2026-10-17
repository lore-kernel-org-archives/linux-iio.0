Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4AE35F162;
	Sat, 17 Oct 2026 01:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792199180; cv=none; b=UtLg8ya31eCjRg8VHykd3bSk/C/1cB9MqPdsdfz7mRYEqRy0ZebppQ8aYyAD3PwYV6NitHzqurOhwzzd8RdT3p7TnhPp/GMJrlqCwtsFSXxHcYmD4vJ1PYVbirKwudcjPx2pvEsGHp5Evh9/jyaB4WQZF1zYKAnA1AwQghfLGkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792199180; c=relaxed/simple;
	bh=hQ1aB5eP6mNJ8HuDu1pHdEejdaF+oyYRR7rE8h7AQYk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tr8dPfmpmS1kzDLGfAtA5XbNfmVuQrLodZ2ot2OqgZuiSqJ73DGwQ2TV5u3RM9pqJoin4d+xKQJXmnhBEcgaXRmALpTZwZaiEREzsTKuJWR6nrp8LnV9seFfMRY97OKMecEFMF2j3eFE1sNSg9HmufWcUtzoVuaMYQnQ+bixOKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcU4I3wa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcU4I3wa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32ABC1F000C4;
	Sat, 17 Oct 2026 01:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792199179;
	bh=m6XszpuDtljDI26wJHSYdFKvUk/OFJg7/YCuSQq0f6I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ZcU4I3wa32RrMeks09h9t2NZEn7j8B+ohEsz220kJ+YexlMgKKcSreklFbZ54/t7V
	 iQqDOWH0f7IIfXcp71aiGdmVZf6jiIS39K0A6lwCX566+2J8gOLgcKqb4ECDmTPZqQ
	 65iQTAZEb4GInPF/c3KjEnoa1y+fD7Oc17l1yr17xtvaRlJRCwjERJ9nU8/PRSWVY3
	 rDwHPYYaEjB1I4LUl8ZT1d+gk+uCF5rU1Xhf+64OI8zDAYakQ8qmOlPINB9UY6nsgQ
	 2IxRAu1DLE55a0a+DS/dtqo4hn8Uk4JmJxDyCH0nqpn0/ocyA8u3uRgQKZusaZaN0f
	 IS+YU7wNITE0Q==
Date: Sat, 17 Oct 2026 02:06:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org>
Cc: radu.sabau@analog.com, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Alexandru Ardelean <alexandru.ardelean@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/6] iio: imu: adis: Add optional self_test callback
 and fix custom reset dispatch
Message-ID: <20261017020612.0e16583c@jic23-hlaptop>
In-Reply-To: <20261015-adis16607-v3-1-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
	<20261015-adis16607-v3-1-f972d4efee85@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Oct 2026 12:32:58 +0300
Radu Sabau via B4 Relay <devnull+radu.sabau.analog.com@kernel.org> wrote:

> From: Radu Sabau <radu.sabau@analog.com>
> 
> Add an optional self_test callback to struct adis_data, for devices
> whose self-test doesn't fit the generic mask-write/sleep/check-status
> sequence. Purely additive: defaults to NULL, no change for existing
> drivers.
> 
> Also fix __adis_initial_startup()'s no-reset-gpio path: it called

'Also' rings alarm bells.  Why not a separate patch for this?

> __adis_reset() directly instead of adis->ops->reset(), silently
> ignoring any driver's custom reset implementation. Invisible until now
> since adis_default_ops.reset is __adis_reset() itself. Dispatch
> through adis->ops->reset() instead, adding the settle-time sleep at
> the call site for custom ops (documented not to sleep internally)
> while skipping it for the default op (which already sleeps
> internally).

Why don't we stop __adis_reset() from having an internal sleep
and simplify the code?

There is a missing 'also'. The introduction of post_reset_setup().
That should be a third patch.

> 
> Fixes: ecb010d44108 ("iio: imu: adis: Refactor adis_initial_startup")
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
>  drivers/iio/imu/adis.c       | 30 +++++++++++++++++++++++-------
>  include/linux/iio/imu/adis.h | 32 +++++++++++++++++++++++++++++++-
>  2 files changed, 54 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
> index a2bc1d14ed91..448046fd2ada 100644
> --- a/drivers/iio/imu/adis.c
> +++ b/drivers/iio/imu/adis.c
> @@ -355,11 +355,20 @@ int __adis_reset(struct adis *adis)
>  }
>  EXPORT_SYMBOL_NS_GPL(__adis_reset, "IIO_ADIS_LIB");
>  
> +static const struct adis_ops adis_default_ops = {
> +	.read = __adis_read_reg,
> +	.write = __adis_write_reg,
> +	.reset = __adis_reset,
> +};
> +
>  static int adis_self_test(struct adis *adis)
>  {
>  	int ret;
>  	const struct adis_timeout *timeouts = adis->data->timeouts;
>  
> +	if (adis->data->self_test)
> +		return adis->data->self_test(adis);
> +
>  	ret = __adis_write_reg_16(adis, adis->data->self_test_reg,
>  				  adis->data->self_test_mask);
>  	if (ret) {
> @@ -413,7 +422,20 @@ int __adis_initial_startup(struct adis *adis)
>  		gpiod_set_value_cansleep(gpio, 0);
>  		msleep(timeouts->reset_ms);
>  	} else {
> -		ret = __adis_reset(adis);
> +		ret = adis->ops->reset(adis);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * __adis_reset() already sleeps the settle time internally.
> +		 * Custom reset ops are documented (struct adis_ops::reset)
> +		 * not to, so sleep here for them.
> +		 */
> +		if (adis->ops->reset != __adis_reset)
> +			msleep(timeouts->sw_reset_ms);
> +	}
> +
> +	if (adis->data->post_reset_setup) {
> +		ret = adis->data->post_reset_setup(adis);
>  		if (ret)
>  			return ret;
>  	}
> @@ -491,12 +513,6 @@ int adis_single_conversion(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_NS_GPL(adis_single_conversion, "IIO_ADISLIB");
>  
> -static const struct adis_ops adis_default_ops = {
> -	.read = __adis_read_reg,
> -	.write = __adis_write_reg,
> -	.reset = __adis_reset,
> -};
> -
>  /**
>   * adis_init() - Initialize adis device structure
>   * @adis:	The adis device
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index bfb6df68e6c9..5d0baeded3c9 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -10,6 +10,7 @@
>  #define __IIO_ADIS_H__
>  
>  #include <linux/cleanup.h>
> +#include <linux/delay.h>
>  #include <linux/spi/spi.h>
>  #include <linux/interrupt.h>
>  #include <linux/iio/iio.h>
> @@ -51,6 +52,18 @@ struct adis_timeout {
>   * @self_test_mask: Bitmask of supported self-test operations
>   * @self_test_reg: Register address to request self test command
>   * @self_test_no_autoclear: True if device's self-test needs clear of ctrl reg
> + * @post_reset_setup: Optional device-specific hook called after reset,
> + *		before self-test. Not all ADIS devices need extra bring-up
> + *		between reset and self-test (SPI mode locking, status or
> + *		bootloader checks, pin or burst-mode configuration, etc.) -
> + *		only called when set. Must return 0 on success, a negative
> + *		error code otherwise.

This doesn't seem related to the rest.  Separate patch I think.

> + * @self_test: Optional device-specific self-test override. When set,
> + *		it is called instead of the generic mask-write/sleep/
> + *		check-status sequence. The callback owns its own pass/fail
> + *		determination entirely (it should call __adis_check_status()
> + *		itself if it wants status-register checks). Must return 0 on
> + *		success, a negative error code otherwise.
>   * @status_error_msgs: Array of error messages
>   * @status_error_mask: Bitmask of errors supported by the device
>   * @timeouts: Chip specific delays
> @@ -81,6 +94,8 @@ struct adis_data {
>  	unsigned int self_test_mask;
>  	unsigned int self_test_reg;
>  	bool self_test_no_autoclear;
> +	int (*post_reset_setup)(struct adis *adis);
> +	int (*self_test)(struct adis *adis);
>  	const struct adis_timeout *timeouts;
>  
>  	const char * const *status_error_msgs;
> @@ -171,8 +186,23 @@ int __adis_reset(struct adis *adis);
>   */
>  static inline int adis_reset(struct adis *adis)
>  {
> +	int ret;
> +
>  	guard(mutex)(&adis->state_lock);
> -	return __adis_reset(adis);
> +
> +	ret = adis->ops->reset(adis);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * __adis_reset() already sleeps the settle time internally. Custom
> +	 * reset ops are documented (struct adis_ops::reset) not to, so sleep
> +	 * here for them.
> +	 */
> +	if (adis->ops->reset != __adis_reset)
> +		msleep(adis->data->timeouts->sw_reset_ms);
> +
> +	return 0;
>  }
>  
>  int __adis_write_reg(struct adis *adis, unsigned int reg,
> 

