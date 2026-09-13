Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25E4126BE1;
	Sun, 13 Sep 2026 23:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789341732; cv=none; b=u2ae+pGIvf183S6ryQ654oOvks6zmdmapSO3LX5mxR2uqj1C41yV0cKGs2eVmAly2fa6MZ4sXUTXlyBqOxZPnBnbS0ew71hPEroN6P4LiTEKpPZL+IsrpleE78AWE2r9cTFl4g07jLF+VaZ21gXVHGZeWJ2PJrV6YIefdvj4aAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789341732; c=relaxed/simple;
	bh=AftoZD/vUPRo4cPUlHkjUMVOlp1/CoUIyvyIPwcoEHE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hY+IdXCiieRwJ9Xvhx6svyavm/YUrZRWgtcryAkKYa2MIx+3woJrDgK+vB4B4+fIsSDtqPSuQG6PDGjB2sOWukBwMFCxPA0w5/klKwuhMasUPcV5lIIuLqsCL3LnuijCVYQ1XFlNd8+BcMrXpzlLuwCa2xqOcsn0wltNh3Oox/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cwxq5+2d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cwxq5+2d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220DF1F000FF;
	Sun, 13 Sep 2026 23:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789341730;
	bh=qiTTNHVxC4+yy4aeSB2+1Gh+FOEZOJeeTS3Hv5xo4Nc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cwxq5+2dqQV9YJN0sH6p1+HLHHO2eJSwqCEanq6hJS6kPm8rpWMdRdjJ4hubTeIpF
	 2+2mNEAMX6mMUJ6/uKhn1bT16En2QO7tJdfOty+72h3dGE1+NhER64UwX/3oQ+kkWc
	 KTHVs9P29y/tATQVI34mZVlnVzbFt1Jpp//AbRW8y3oL9dwgAL3iml6gHuErYOy8F0
	 uFLgAUlhrwcR1mlN6M6YAYIW1wwuc+pE3pJqHo0HgJiC5Rpo4FWrAOka9QbAVDDUfn
	 BziNv3gkxh1tGys5KvzfSEv0zJmcyJA9zSzfe0oc5yD2D01kg8TqOPOpAYP9SHOjZa
	 Y4QB++ZxPbshQ==
Date: Mon, 14 Sep 2026 00:22:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Esben Haabendal <esben@geanix.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Martin Kepplinger <martink@posteo.de>, Sean Nyekjaer
 <sean@geanix.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Martin Kepplinger <martin.kepplinger@theobroma-systems.com>, Christoph
 Muellner <christoph.muellner@theobroma-systems.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 9/9] iio: accel: mma8452: Support interrupt sharing
Message-ID: <20260914002203.5ca07dd0@jic23-hlaptop>
In-Reply-To: <20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
References: <20260907-mma8452-open-drain-v8-0-c17407e22118@geanix.com>
	<20260907-mma8452-open-drain-v8-9-c17407e22118@geanix.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Sep 2026 16:51:04 +0200
Esben Haabendal <esben@geanix.com> wrote:

> Adding support for sharing interrupt line with other device requires the
> interrupt handler to handle runtime PM suspension properly, ignoring the
> irq if the device is suspended (maybe even off). And while at it, we use
> the PM reference to ensure we do not get suspended while processing an irq.
> 
> In order to prevent the chip from raising irq while suspended (that is when
> using fixed regulator, where suspend just means setting the device in
> STANDBY mode), we disable all interrupt sources by clearing CTRL_REG4, and
> then restores the value again when resuming.
> 
> With that in place, it is safe to add the IRQF_SHARED flag.
> 
> Keep in mind that the device by default is using push-pull for the irq pin,
> which might require additional hardware design to allow interrupt sharing.
> 
> Signed-off-by: Esben Haabendal <esben@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 67 +++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 58 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index fda29df5d109..e521dca37f76 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -120,6 +120,7 @@
>   * @sleep_val:			time in ms to sleep while waiting for drdy
>   * @ctrl_reg1:			CTRL_REG1 register shadow value
>   * @data_cfg:			DATA_CFG register shadow value
> + * @ctrl_reg4:			CTRL_REG4 register value to restore on resume
>   * @open_drain:			true for irq pin in open-drain mode
>   */
>  struct mma8452_data {
> @@ -138,6 +139,7 @@ struct mma8452_data {
>  	int sleep_val;
>  	u8 ctrl_reg1;
>  	u8 data_cfg;
> +	u8 ctrl_reg4;
>  	bool open_drain;
>  };
>  
> @@ -1083,15 +1085,21 @@ static irqreturn_t mma8452_interrupt(int irq, void *p)
>  {
>  	struct iio_dev *indio_dev = p;
>  	struct mma8452_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
>  	irqreturn_t ret = IRQ_NONE;
> +	int pm_status;
>  	int src;
>  
> +	pm_status = pm_runtime_get_if_active(dev);

Sashiko raises the question of what happens if you actually get an error
return from this. You may be deliberately ignoring those, but if
so add a comment.  The fun race around tear down is worth considering
in particular (see sashiko comment).


> +	if (pm_status == 0)
> +		return IRQ_NONE; /* device is powered down */

> @@ -1784,29 +1796,62 @@ static void mma8452_remove(struct i2c_client *client)
>  #ifdef CONFIG_PM
>  static int mma8452_runtime_suspend(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret;
>  
> -	scoped_guard(mutex, &data->lock)
> -		ret = mma8452_standby(data);
> +	guard(mutex)(&data->lock);
Mixing guards... 
> +
> +	ret = i2c_smbus_read_byte_data(client, MMA8452_CTRL_REG4);
>  	if (ret < 0) {
> -		dev_err(dev, "powering off device failed\n");
> +		dev_warn(dev, "backing up CTRL_REG4 failed\n");
>  		return -EAGAIN;
> +	} else
> +		data->ctrl_reg4 = ret;
> +
> +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, 0);
> +	if (ret) {
> +		dev_warn(dev, "disabling interrupt sources (CTRL_REG4) failed\n");
> +		return -EAGAIN;
> +	}
> +
> +	ret = mma8452_standby(data);
> +	if (ret < 0) {
> +		dev_err(dev, "transition to STANDBY mode failed\n");
> +		ret = -EAGAIN;
> +		goto out_restore_ctrl_reg4;

and goto is explicitly advised against in the docs in cleanup.h
You need to restructure the code to avoid that, potentially via
a helper function.

>  	}
>  
> +	/*
> +	 * Interrupt line should be deasserted now, so we just need ensure any
> +	 * mid-flight irq is completed (will return IRQ_NONE due to
> +	 * pm_status==0).
> +	 */
> +	if (client->irq)
> +		synchronize_irq(client->irq);
> +
>  	ret = regulator_bulk_disable(ARRAY_SIZE(data->regs), data->regs);
>  	if (ret) {
>  		dev_err(dev, "failed to disable regulators\n");
> -		return ret;
> +		goto out_active;
>  	}
>  
>  	return 0;
> +
> +out_active:
> +	if (mma8452_active(data))
> +		dev_warn(dev, "failed to switch back to ACTIVE mode\n");
> +out_restore_ctrl_reg4:
> +	if (i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4))
> +		dev_warn(dev, "restoring CTRL_REG4 failed\n");
> +	return ret;
>  }
>  
>  static int mma8452_runtime_resume(struct device *dev)
>  {
> -	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	struct mma8452_data *data = iio_priv(indio_dev);
>  	int ret, sleep_val;
>  
> @@ -1820,6 +1865,10 @@ static int mma8452_runtime_resume(struct device *dev)
>  	if (ret)
>  		goto runtime_resume_failed;
>  
> +	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG4, data->ctrl_reg4);
> +	if (ret)
> +		goto runtime_resume_failed;
> +
>  	ret = mma8452_active(data);
>  	if (ret < 0)
>  		goto runtime_resume_failed;
> 

