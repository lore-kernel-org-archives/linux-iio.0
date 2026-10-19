Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47577EECB;
	Mon, 19 Oct 2026 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792374568; cv=none; b=C9qQjGJOqjKaDqpSjxTgnI6Z2Bu+2063yYbUhDpRcqIPoQa5//fe/N3FYJW+lkwcfK1Y1Wo5mjFVSxeho3YWnaadelRctxBa42jTZu4966xCeIhT5291h+OQ+Mxk5fDz1WW96TKlbW2kvpNkSS09nZqjJoNLkJ0OwhiCQc5gV2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792374568; c=relaxed/simple;
	bh=qzwdBmKmMsI7S3SaqbH9Py+FAeT/uFmTUJWDuxmgHk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kpeh/MWLe4ow947t7LfV5we8KxsX7p9GCg2dGcx8XmFh3dpYlIvXxU6VsXqDu6VNbn5sr/GNto1A8be/U3SXnSWWsSIrumlN7uGVmCOddscPMWcWC2txAOEJ1uskBsvLeVup+5r5EW52KRXQDwhuxcaZ6JYgM+kZJelVHWn0FBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXvyzh79; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXvyzh79"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 064251F000C4;
	Mon, 19 Oct 2026 01:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792374566;
	bh=U7d/2rNc1I6J6mJrgk5gP7VI5wOeBvYCN+BwNFcPfVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RXvyzh79T2cbxs/k4b64YuT1kyGcyKBnL5s7WjyFKCw7K2o9alhmKZDNPtHLp7Je+
	 UUFsqkWxLWe+OF0SCZT8v86sHiMEZKt8d1oarTqZkP1V9xPDZjSklgQz+5WPITlHF+
	 qGoe/GoR+tILWEh67HxSvsiUo1GjliFh34w/pl1KbqjGdhHnKWV1kVq+1icEYC4NKB
	 cQBNPFYcU+hUxWmfJ7DP/ZK9j6nTatPxMS+JJhzOkiWnSnSN/vvHXMz8PWXA5JPPiX
	 NbCvegLWAQw5EZBbtGOc6uXhnEojCpoT5uZygKmA/VySK8BbMrzOU2vj/qWrpEPWd/
	 sLsA8aeQBQeEg==
Date: Mon, 19 Oct 2026 02:49:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Archit Anant <architanant5@gmail.com>
Cc: dlechner@baylibre.com, andy@kernel.org, nuno.sa@analog.com,
 u.kleine-koenig@baylibre.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH v5 06/10] iio: adc: ti-ads1015: drop unneeded < 0 error
 checks
Message-ID: <20261019024920.27a11ab8@jic23-hlaptop>
In-Reply-To: <20260930171204.12863-7-architanant5@gmail.com>
References: <20260930171204.12863-1-architanant5@gmail.com>
	<20260930171204.12863-7-architanant5@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 22:42:00 +0530
Archit Anant <architanant5@gmail.com> wrote:

> Several functions in the driver only return 0 on success
> or a negative error code on failure.
> 
> Change the error checking to align with standard kernel
> coding style.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Archit Anant <architanant5@gmail.com>
Hi Archit,

A patch I reviewed early today touched this same code, so
I'll give some related feedback!

> ---
>  drivers/iio/adc/ti-ads1015.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
> index 34d3d31b5ddd..6637c42e0506 100644
> --- a/drivers/iio/adc/ti-ads1015.c
> +++ b/drivers/iio/adc/ti-ads1015.c
> @@ -539,7 +539,7 @@ static int __ads1015_read_info_raw(struct ads1015_data *data,
>  		return -EBUSY;
>  
>  	ret = ads1015_set_power_state(data, true);

Can we get rid of this _set_power_state helper?  It's entirely pointless now
the runtime pm code is a lot simpler than it was a few years back.

It is included in a series removing the return from the put that is on list
and I asked for that there as well.  Note that once you do that
it will be easy to use the ACQUIRE_ magic for handling this so maybe jump
directly to that instead of having this change.

> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ret = ads1015_get_adc_result(data, chan->address, val);
> @@ -727,7 +727,7 @@ static int ads1015_enable_event_config(struct ads1015_data *data,
>  		return ret;
>  
>  	ret = ads1015_set_power_state(data, true);
> -	if (ret < 0)
> +	if (ret)
>  		return ret;
>  
>  	ads1015_event_channel_enable(data, chan->address, comp_mode);
> @@ -994,7 +994,7 @@ static int ads1015_probe(struct i2c_client *client)
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
>  					      ads1015_trigger_handler,
>  					      &ads1015_buffer_setup_ops);
> -	if (ret < 0)
> +	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "iio triggered buffer setup failed\n");
>  

