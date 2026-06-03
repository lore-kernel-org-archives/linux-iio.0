Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016D22D592D;
	Wed,  3 Jun 2026 13:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780493465; cv=none; b=tqiQ0cpL94xTtZcsiDfvCuNU+UfNSENNrZgj+dCzunOdynpBuVBrp0TvtJnslXzWNsT5/yyFdAUuBSqnKwmvEGYSeF5wM+K7HW+xU6TeBIYZ/C+hFKgOEZklj27GlxRF2nEA8tEldnDIk0cd4LQGqcAKfNUlsiFQrHUm6TQtiHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780493465; c=relaxed/simple;
	bh=qsyTZ2hC7Rdhtni/l2TyeGzmiSIeKQN9bGas17AhzYo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crtjMukBwkJ1ID5J5bsJHPUBf6tu1SYd3VQZPpnOOUmZJ15+xuKNVn4my/fV7GplcIlExZxDGi/FX3if5t6D7TvYIlBU/eITqy8EfMtxVHYbnIto6GPohrVq71D4u7uIzbyoPqKlTdXvh3hapycTkpTf+4RZ9Pe4ZsdwOnWg5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APpfzN+m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APpfzN+m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E107A1F00893;
	Wed,  3 Jun 2026 13:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780493463;
	bh=a3z1DuYx348Z9Spf+zPmnsW3JiPXDTTqihKvmTNSgBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=APpfzN+mnSRXIpSCBsfvHHhfQJw9qwRVFwveokcy+OiFVcUrcCW54CzDIS+CrYt9r
	 DHTLaWbBLL0/eb94k1wTM8TzVYalh05k7WaQPNfqu/pE3AvNcI9lyZLfCSw2d0FALM
	 cLqXhyx8nBk4JOHSCFdQdx1MNPb5NhTwAMFxpzZAL+9CvN6sTZ+Fm1xO31/f4HFOVy
	 2x/nmHAzdFvRNOJcNh/5241BAL0vkGHaKLyOUeBdKQ9Q1BOru7O9ZihfrDrBOa998y
	 TS/DwShF9vHCaA0u7aYslLel13fTEM35cddcBGSXzCsFm4iGyD/k/I5/WVl7UhC16U
	 jrfezZLI21pRQ==
Date: Wed, 3 Jun 2026 14:30:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/5] iio: accel: mma8452: use pm_ptr() and direct
 runtime PM calls
Message-ID: <20260603143055.26126435@jic23-huawei>
In-Reply-To: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-3-26d6dff8fc55@gmail.com>
References: <20260602-15-apr-pm-iio-mma8452-v4-temp-v4-0-26d6dff8fc55@gmail.com>
	<20260602-15-apr-pm-iio-mma8452-v4-temp-v4-3-26d6dff8fc55@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 02 Jun 2026 18:59:24 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
> pointer is automatically handled when CONFIG_PM is enabled or disabled.
> 
> Switch to direct PM runtime calls and drop
> mma8452_set_runtime_pm_state() wrapper, which is no longer needed.
> 
> While at it, fix runtime PM handling in several paths to ensure proper
> balancing of pm_runtime_resume_and_get() and pm_runtime_put(), avoiding
> usage count leaks on error paths.

"While at it" comments cause alarm bells to ring, even more so when they
are fixes. This should be broken up and the fixes moved to the start
of the patch set followed only later by rework.

I'm fairly sure this introduces some bugs.. What testing can you do on this
one?  I'd be very nervous touching this without some form of verification
that the state is correct and the power remains on when events are in use
(right not it doesn't)

The final problem of disabling events on remove() also needs to be covered.
It is up to the driver to figure out what events are enabled and turn
them off.

> 
> This follows modern kernel power-management conventions.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> ---
> changes in v4:
> - fix runtime PM handling by balancing the refcount with input from Jonathan
> - v3 link -> https://lore.kernel.org/all/20260505174640.3998281-9-sanjayembedded@gmail.com/
> changes in v3:
> - Use direct PM runtime calls and drop redundant wrapper along with CONFIG_PM
> - v2 link -> https://lore.kernel.org/all/20260422165643.2148195-6-sanjayembedded@gmail.com/
> changes in v2:
> - Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0-day bot warning
> - v1 link -> https://lore.kernel.org/all/20260414192045.3598010-1-sanjayembedded@gmail.com/
> ---
>  drivers/iio/accel/mma8452.c | 110 ++++++++++++++++++++++++--------------------
>  1 file changed, 59 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 1d4ea614cb57..467e42c2c0dd 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c

> @@ -975,6 +953,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  				      bool state)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
>  	int val, ret;
>  	const struct mma8452_event_regs *ev_regs;
>  
> @@ -982,17 +961,22 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,

This one is fiddlier. In the case of turning an event on the aim
is to leave the pm counter raised, the decrement only comes when turning it off.

>  	if (ret)
>  		return ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
> -	if (ret)
> -		return ret;
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	switch (dir) {
>  	case IIO_EV_DIR_FALLING:
> -		return mma8452_set_freefall_mode(data, state);
> +		ret = mma8452_set_freefall_mode(data, state);
> +		goto pm_runtime_put;

see below for more discussion but break might be appropriate here.

>  	case IIO_EV_DIR_RISING:
>  		val = i2c_smbus_read_byte_data(data->client, ev_regs->ev_cfg);
> -		if (val < 0)
> -			return val;
> +		if (val < 0) {
> +			ret = val;
> +			goto pm_runtime_put;
> +		}
>  
>  		if (state) {
>  			if (mma8452_freefall_mode_enabled(data)) {
> @@ -1004,19 +988,31 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  			val |= BIT(chan->scan_index +
>  					ev_regs->ev_cfg_chan_shift);
>  		} else {
> -			if (mma8452_freefall_mode_enabled(data))
> -				return 0;
> -
> +			if (mma8452_freefall_mode_enabled(data)) {
> +				ret = 0;
I'm not 100% sure what intent is here. This is in a rising path
which has nothing directly to do with freefall yet the configuration
is not modified.

In this path state == false, and we aren't in an error case so maybe we just want
to do nothing other than decrementing the counter.



> +				goto pm_runtime_put;

> +			}
>  			val &= ~BIT(chan->scan_index +
>  					ev_regs->ev_cfg_chan_shift);
>  		}
>  
>  		val |= ev_regs->ev_cfg_ele;
>  
> -		return mma8452_change_config(data, ev_regs->ev_cfg, val);
> +		ret = mma8452_change_config(data, ev_regs->ev_cfg, val);
> +		goto pm_runtime_put;
> +
>  	default:
> -		return -EINVAL;
> +		ret = -EINVAL;
> +		goto pm_runtime_put;
>  	}
> +



> +pm_runtime_put:
> +	if (state)
> +		pm_runtime_put(dev);
> +	else
> +		pm_runtime_put_autosuspend(dev);
This is wrong as the counter is universally decremented
whether or not we were turning something on.

Anyhow, Split this an do an earlier return in good path.

Mind you there is a fun question of what the right thing to do on
a failure is.  Maybe we should assume a retry is on the way and
do a put_autosuspend.

If you do keep the combined, you can just break in the switch
rather than gotos.


> +
> +	return ret;
>  }
>  
>  static void mma8452_transient_interrupt(struct iio_dev *indio_dev)
> @@ -1453,22 +1449,39 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
>  	int reg, ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
> -	if (ret)
> -		return ret;
> +	if (state) {
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
>  	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
> -	if (reg < 0)
> -		return reg;
> +	if (reg < 0) {
> +		ret = reg;
> +		goto pm_runtime_put;
> +	}
>  
>  	if (state)
>  		reg |= MMA8452_INT_DRDY;
>  	else
>  		reg &= ~MMA8452_INT_DRDY;
>  
> -	return mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
> +	ret = mma8452_change_config(data, MMA8452_CTRL_REG4, reg);
> +	if (ret < 0)
> +		goto pm_runtime_put;
> +
> +	if (!state)
> +		return pm_runtime_put_autosuspend(dev);
> +
> +	return 0;
> +
> +pm_runtime_put:
> +	if (state)
> +		pm_runtime_put(dev);
> +	return ret;
After the cleanup there isn't a lot of shared code in here and the
flow is confusing I'd break it into two helpers along the lines of:

static int mma8452_data_rdy_trigger_enable(struct mma8452_data *data)
{
	struct device *dev = &data->client->dev;
	int ret;

	ret = pm_runtime_resume_and_get(dev);
	if (ret < 0)
		return ret;

	ret = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
	if (ret < 0)
		goto powerdown;

	ret = mma8452_change_config(data, MMA8452_CTRL_REG4, ret | MMA8452_INT_DRDY);
	if (ret < 0)
		goto powerdown;

	return 0;

powerdown:
	pm_runtime_put(dev);
	return ret;
}

static int mma8452_data_ready_trigger_disable(struct mma8452_data *data)
{
	struct device *dev = &data->client->dev;
	int reg, ret;

	ret = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
	if (ret < 0)
		return ret;
	
	ret = mma8452_change_config(data, MMA8452_CTRL_REG4, ret & ~MMA8452_INT_DRDY);
	if (ret < 0)
		return ret;

	pm_runtime_put_autosuspend(dev);

	return 0;
}

Then pick between them based on state.

While that is a fairly significant refactor I think that is fine as part of
the fix as it makes the code more readable.


>  }
>  
>  static const struct iio_trigger_ops mma8452_trigger_ops = {
> @@ -1737,7 +1750,6 @@ static void mma8452_remove(struct i2c_client *client)
>  	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
>  }
>  
> -#ifdef CONFIG_PM
Unrelated to the fixes.

>  static int mma8452_runtime_suspend(struct device *dev)
>  {
>  	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> @@ -1791,13 +1803,9 @@ static int mma8452_runtime_resume(struct device *dev)
>  
>  	return ret;
>  }
> -#endif
>  
> -static const struct dev_pm_ops mma8452_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
> -	SET_RUNTIME_PM_OPS(mma8452_runtime_suspend,
> -			   mma8452_runtime_resume, NULL)
> -};
> +static DEFINE_RUNTIME_DEV_PM_OPS(mma8452_pm_ops,
> +				 mma8452_runtime_suspend, mma8452_runtime_resume, NULL);

This is unrelated to the fix aspect above.


>  
>  static const struct i2c_device_id mma8452_id[] = {
>  	{ .name = "fxls8471", .driver_data = (kernel_ulong_t)&mma_chip_info_table[fxls8471] },
> @@ -1814,7 +1822,7 @@ static struct i2c_driver mma8452_driver = {
>  	.driver = {
>  		.name	= "mma8452",
>  		.of_match_table = mma8452_dt_ids,
> -		.pm	= &mma8452_pm_ops,
> +		.pm	= pm_ptr(&mma8452_pm_ops),
>  	},
>  	.probe = mma8452_probe,
>  	.remove = mma8452_remove,
> 

