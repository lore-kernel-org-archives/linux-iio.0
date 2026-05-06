Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5419247ECE2;
	Wed,  6 May 2026 18:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778090824; cv=none; b=c5kLx4qPr6LvR23EAOPAls5VSByPmMXrymUHpC2+d8MhNgiK7uCAypawRQIOEFqk4bbufq4R1aOo2Ae55e5Fo+/ayOVLzneFo3o0T1ukJV9uWtr+kTXsNDVw8A9LcQoPiITIo4PK1iiJp11LQiQvaZOcbZbt4C/BrAg//4ksW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778090824; c=relaxed/simple;
	bh=q9BdE1dGKLd7Xam+fSI573KVqd1oDw+/FxY7/cMi8b8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I2gYFce3kbU7Tz04P7u+rmstlhHROJigx8KGlI/iWyJcL3hDmRsVEz1C4ZJ7fusOhi1JjaqARttpvNQTVXB1Pjj5G7sqE11NmtIx5GyHJyb/cEYOwadomzI366g0ENijLQrUg4z5P5CMIktEKPePOcAVKI7cjcZKJ5Al7uyscZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u1vy+tqL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u1vy+tqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C63C2BCB0;
	Wed,  6 May 2026 18:06:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778090823;
	bh=q9BdE1dGKLd7Xam+fSI573KVqd1oDw+/FxY7/cMi8b8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=u1vy+tqLN916OtiCVTWUJmsTalom2782/A9YF0BG7IrTUYShfuyoD1y1ZZjYcApxS
	 ElDDWu9SPNdAkglSLeFaOcGGwDAm/jTeW580finb7yqXefaKLi7Ra7cQzZvXlUgkn0
	 Gr8QdQSbTLhW7x6j13HAAl9jCrjeRT6lXPZAmhCNwbkyIqBm3YDw6430+EKS5rGagy
	 3PZv4+QEEXYd11Ezococshtz+qZ1Fw+70C9WJAoUWiewCjH7cloXWVpnMmwOh+XgqH
	 BGza8PMV9uhNbF4TsYiGe7mhiycccUwjmLFrm/3dwDhCrVWgkLFVGNfbmkbh4QeX4N
	 KxbmJ5Ubbkqbg==
Date: Wed, 6 May 2026 19:06:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 sakari.ailus@linux.intel.com, christoph.muellner@theobroma-systems.com,
 martink@posteo.de, mfuzzey@parkeon.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] iio: accel: mma8452: use pm_ptr() and direct
 runtime PM calls
Message-ID: <20260506190654.598dca87@jic23-huawei>
In-Reply-To: <20260505174640.3998281-9-sanjayembedded@gmail.com>
References: <20260505174640.3998281-1-sanjayembedded@gmail.com>
	<20260505174640.3998281-9-sanjayembedded@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 23:16:38 +0530
Sanjay Chitroda <sanjayembeddedse@gmail.com> wrote:

> From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
> 
> Use pm_ptr() together with DEFINE_RUNTIME_DEV_PM_OPS() so the PM ops
> pointer is automatically handled when CONFIG_PM is enabled or disabled.
> 
> Switch to direct PM runtime calls and drop
> mma8452_set_runtime_pm_state() wrapper, which is no longer needed.
> This follows modern kernel power-management conventions.
> 
> Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Hi Sanjay,

The cleanup you have in here has made what i think are two nasty race
conditions much  more obvious. I think we need to fix those
(and that fix needs to go at the start of this series)

Thanks for you work on this driver - this problem has been
there a long time!

Jonathan

> ---
> Changes in v3:
> - Use direct PM runtime calls and drop redundant wrapper along with CONFIG_PM
> - Link to v2: https://lore.kernel.org/all/20260422165643.2148195-6-sanjayembedded@gmail.com/
> Changes in v2:
> - Use DEFINE_RUNTIME_DEV_PM_OPS to address review comment and resolve 0-day bot warning
> - Link to v1: https://lore.kernel.org/all/20260414192045.3598010-1-sanjayembedded@gmail.com/
> ---
>  drivers/iio/accel/mma8452.c | 55 +++++++++++++------------------------
>  1 file changed, 19 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index 2cd24b1543af..5ab981481599 100644


>  static ssize_t mma8452_show_int_plus_micros(char *buf, const int (*vals)[2],
> @@ -974,6 +953,7 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  				      bool state)
>  {
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
>  	int val, ret;
>  	const struct mma8452_event_regs *ev_regs;
>  
> @@ -981,8 +961,11 @@ static int mma8452_write_event_config(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);
This smells like the same bug as below. 
> -	if (ret)
> +	if (state)
> +		ret = pm_runtime_resume_and_get(dev);
> +	else
> +		ret = pm_runtime_put_autosuspend(dev);
> +	if (ret < 0)
>  		return ret;
>  
>  	switch (dir) {
> @@ -1452,10 +1435,15 @@ static int mma8452_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  {
>  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +
>  	int reg, ret;
>  
> -	ret = mma8452_set_runtime_pm_state(data->client, state);

This functions makes me very suspicious and I think has a nasty existing
race condition.  If the auto suspend were to suspend immediately
vddio would be powered down.  Unless they supplies have odd naming on this
device that means the bus would be down before the write that follows.

As such I think this needs s rewrite to makes sure we only call
pm_runtime_put_autosuspend() after the bus writes in this function are done.

I think that is safe to do without testing as all it will do is delay
when the power gets turned off a tiny bit.

> -	if (ret)
> +	if (state)
> +		ret = pm_runtime_resume_and_get(dev);
> +	else
> +		ret = pm_runtime_put_autosuspend(dev);
> +	if (ret < 0)
>  		return ret;
>  
>  	reg = i2c_smbus_read_byte_data(data->client, MMA8452_CTRL_REG4);
> @@ -1738,7 +1726,6 @@ static void mma8452_remove(struct i2c_client *client)
>  	regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
>  }

