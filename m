Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CF63BFE52;
	Thu, 22 Jan 2026 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769116901; cv=none; b=JN/A3Lyr2tO8LbxADJQjVWR5TygZX4x8hnyo1zuPCCC29hyQyiSL5npiEIS4ZUf0UCUjY6nagnR8nvn5RBxBfWjFf0o/1l8KweZ2vsxU/sI2q8oOwkwN8Y617RP4gak+t9E/UwmEPjLW2/9V0loVV0Qo64zdtxtvJlNz/6zK+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769116901; c=relaxed/simple;
	bh=b3Svz+uX1DZdCoK6b4viHzQ816miXTRzxvPYYEAI+OU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l2XKr7fwibJzdihPptLzLs6PyNHv4IsVlsNMPd/Xxq3MK1nw1VhDrFyg27kwkdhqP3rRMnsZ6KeQsGwyqjktUzQipGUs39cHOKSJjKS2nrOyzjxvD5nHicxzmvCJSScTzNLWi53AL/q09mb7w1hwIlEv1nBV9ZktXYSyFL5wze0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlaWzdhr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlaWzdhr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66860C116C6;
	Thu, 22 Jan 2026 21:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769116900;
	bh=b3Svz+uX1DZdCoK6b4viHzQ816miXTRzxvPYYEAI+OU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UlaWzdhrGMIL026labqqdAzooh7ibbcvXm5AzT5hNjHviNCMZ1Oa2b4hLeAmX1fpM
	 bYD2gDy06lpqVxVBjbw34t0NL1hMemO1gSsFEGqMAGB80rniBnxFp37OMvFGDnuF0o
	 sajlrGLWLWFBcYVVUBsp7Ulv2RCNKwW4/sRGfqFW+fNd+zYxoR3V1T0RJak1GWrTNn
	 NvHhSWwEnEVtR7g2tE5//NudFD+kgynPIVZUYf1GawvlFWknA7BOPBhuwefDw3u8W3
	 oR9yvHbAXUdgzw8jHL8Nf3Ee0MH6X7w+bxE1yPPhnSSQcijf9fsKP+w9+jsofXPW5a
	 G7fwk1UJDSblA==
Date: Thu, 22 Jan 2026 21:21:33 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Viktor Karamanis <viktor.karamanis@outlook.com>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/1] ti-ads131e08: Driver optimizations
Message-ID: <20260122212133.7d02ef67@jic23-huawei>
In-Reply-To: <PA1PR08MB11670AA593D765D9F96A0053C8E89A@PA1PR08MB11670.eurprd08.prod.outlook.com>
References: <PA1PR08MB11670AA593D765D9F96A0053C8E89A@PA1PR08MB11670.eurprd08.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 14:07:34 +0000
Viktor Karamanis <viktor.karamanis@outlook.com> wrote:

> This series optimizes the TI ADS131E08 ADC driver for better performance
> and reliability.
Hi Viktor and welcome to IIO.
> 
> Key improvements in the driver:
> - Switch from RDATA polling to RDATAC continuous mode in buffer operations
> for reduced SPI overhead during continuous data acquisition
> - Add proper timing delays between SPI register writes to meet device
> timing requirements
> - Consolidate channel configuration functions to minimize unnecessary
> SPI transactions
> - Add status checking and proper cleanup functions
> - Remove redundant code and improve overall code structure
> 
> Patch 1 contains the driver optimizations.
> 
> As a sidenote, I noticed that the driver is not present in MAINTAINERS file.
> 
> This is my first contribution to the Linux kernel,
> hopefully I did everything correctly.
> Please let me know if any changes are needed.

Unfortunately not.  Please review the documentation on submitting patches
before sending a v2. It should have been a cover letter then patches
as separate emails in reply to that cover letter.

I'm guessing outlook.com isn't going to play well. So I'd suggest you
look at the b4 tool and it's options to use a web gateway to send
patches to the kernel mailing lists.


Anyhow to save time, I'll paste in what should have been the second email
and give a quick review.

> From 37bf00dc880e4ccae8578f6824d462d193cc6778 Mon Sep 17 00:00:00 2001
> From: Viktor Karamanis <viktor.karamanis@outlook.com>
> Date: Tue, 20 Jan 2026 14:46:28 +0200
> Subject: [PATCH 1/1] iio: adc: ti-ads131e08: Optimize performance and fix
>  timing
> 
> Optimize the TI ADS131E08 ADC driver for better performance and
> reliability:
> 
> 1. Switch from RDATA polling to RDATAC continuous mode in buffer
>    trigger operations. This reduces SPI overhead during continuous
>    data acquisition by eliminating the need to send RDATA commands
>    for each sample.
> 
> 2. Add proper timing delays between SPI register writes. The ADS131E08
>    requires specific delays after certain commands and register writes,
>    which were not consistently implemented.
> 
> 3. Consolidate channel configuration functions. Previously, multiple
>    functions modified channel registers separately, causing unnecessary
>    SPI transactions. Now a single function handles all channel
>    configuration changes.
> 
> 4. Add ads131e08_check_status() function to check device status bits
>    for fault conditions, improving error detection.
> 
> 5. Add ads131e08_stop_read_data_continuous() function for proper
>    cleanup when stopping continuous mode.
> 
> 6. Replace ads131e08_trigger_ops with ads131e08_buffer_preenable() 
>    and ads131e08_buffer_postdisable() for better integration
>    with the IIO buffer framework.
> 
> 7. Minor code cleanup, formatting fixes, and lint improvements.

First general comment.  1 patch per thing.  So at very least this
is a 7 patch series. Not one mega patch.

The biggest feedback is don't make formatting changes in a patch
that does anyting functional. Also look at that sort of formatting
change very carefully and consider it if is a substantial improvement.
These sort of changes are sometimes fine, but there is cost to any code
modification (backporting fixes etc becomes harder).

Anyhow, there is clearly some more interesting code in here, so
I look forward to you sending a version that is easier to review.

thanks,

Jonathan


> 
> The drives has been tested on a RPI 3b+ with 25Mhz spi speed
> and sample rates up to 16kSPS without issues.
> At sample rates above 16kSPS occasional CRC errors were observed,
> which might be related to hardware limitations.
> 
> Signed-off-by: Viktor Karamanis <viktor.karamanis@outlook.com>
> ---
>  drivers/iio/adc/ti-ads131e08.c | 643 ++++++++++++++++++++-------------
>  1 file changed, 389 insertions(+), 254 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index 085f0d6fb39e..5124622cc586 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c

> -static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg)
> +static int ads131e08_read_reg(struct ads131e08_state *st, u8 reg, u8 *val)
>  {
>  	int ret;
> +	u8 cmd0 = ADS131E08_CMD_RREG(reg);
> +	u8 cmd1 = 0x00;
> +	u8 rx;
> +
>  	struct spi_transfer transfer[] = {
> -		{
> -			.tx_buf = &st->tx_buf,
> -			.len = 2,
> -			.delay = {
> -				.value = st->sdecode_delay_us,
> -				.unit = SPI_DELAY_UNIT_USECS,
> -			},
> -		}, {
> -			.rx_buf = &st->rx_buf,
> -			.len = 1,
> -		},
> +		{ .tx_buf = &cmd0,

This isn not the normal style for these structures. The orignal
code was the preferred style.  Note that this sort of
reformat makes it impossible to spot if anything functional
changed in here.

> +		  .len = 1,
> +		  .cs_change = 0,
> +		  .delay = { .value = st->sdecode_delay_us,
> +			     .unit = SPI_DELAY_UNIT_USECS } },
> +		{ .tx_buf = &cmd1,
> +		  .len = 1,
> +		  .cs_change = 0,
> +		  .delay = { .value = st->sdecode_delay_us,
> +			     .unit = SPI_DELAY_UNIT_USECS } },
> +		{ .rx_buf = &rx, .len = 1, .cs_change = 0 }
>  	};
...

>  static int ads131e08_write_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *channel, int value,
> -	int value2, long mask)
> +			       struct iio_chan_spec const *channel, int value,
> +			       int value2, long mask)
>  {
>  	struct ads131e08_state *st = iio_priv(indio_dev);
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		if (!iio_device_claim_direct(indio_dev))
> -			return -EBUSY;
> +		ret = iio_device_claim_direct_mode(indio_dev);

This shows you are submitting a driver that doesn't build against
the upstream kernel at that interface has being removed.
Please be careful to use the latest kernel release (or the -rc1
after it) as a base.


> +		if (ret)
> +			return ret;
>  
>  		ret = ads131e08_set_data_rate(st, value);
> -		iio_device_release_direct(indio_dev);
> +		iio_device_release_direct_mode(indio_dev);
>  		return ret;
>  
>  	default:
> @@ -565,8 +644,7 @@ static int ads131e08_write_raw(struct iio_dev *indio_dev,
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("1 2 4 8 16 32 64");
>  
>  static struct attribute *ads131e08_attributes[] = {
> -	&iio_const_attr_sampling_frequency_available.dev_attr.attr,
> -	NULL
> +	&iio_const_attr_sampling_frequency_available.dev_attr.attr, NULL
>  };

The formatting for these follows a standard pattern of one entry
per line so the NULL terminator is obvious, please leave itlike that.


>  
>  static const struct iio_info ads131e08_iio_info = {
> @@ -594,18 +684,52 @@ static const struct iio_info ads131e08_iio_info = {
>  	.debugfs_reg_access = &ads131e08_debugfs_reg_access,
>  };
>  
> -static int ads131e08_set_trigger_state(struct iio_trigger *trig, bool state)
> +static int ads131e08_buffer_preenable(struct iio_dev *indio_dev)
>  {
> -	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>  	struct ads131e08_state *st = iio_priv(indio_dev);
> -	u8 cmd = state ? ADS131E08_CMD_START : ADS131E08_CMD_STOP;
> +	int ret;
> +
> +	memset(&st->xfer, 0, sizeof(st->xfer));
	st->xfer = (spi_xfer) {
		rx_buf = st->rx_buf,
etc will zero rest of structure so no need for memset +
make the code a little easier to read.
	};
> +	st->xfer.rx_buf = st->rx_buf;
> +	st->xfer.len = st->readback_len;
> +	st->xfer.cs_change = 0;

That's the 'obvious' default and it's zeroed above.
So don't set cs_change.

> +	spi_message_init(&st->msg);
> +	spi_message_add_tail(&st->xfer, &st->msg);
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_RDATAC,
> +				 st->sdecode_delay_us);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads131e08_exec_cmd(st, ADS131E08_CMD_START, st->sdecode_delay_us);
> +	if (ret)
> +		return ret;
> +
> +	st->rdatac_enabled = true;
> +	return 0;
> +}

>  
>  static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
> @@ -615,8 +739,6 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
>  	struct ads131e08_state *st = iio_priv(indio_dev);
>  	unsigned int chn, i = 0;
>  	u8 *src, *dest;
> -	int ret;
> -
>  	/*
>  	 * The number of data bits per channel depends on the data rate.
>  	 * For 32 and 64 ksps data rates, number of data bits per channel
> @@ -625,19 +747,22 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
>  	 * 16 bits of data into the buffer.
>  	 */
>  	unsigned int num_bytes = ADS131E08_NUM_DATA_BYTES(st->data_rate);
> -	u8 tweek_offset = num_bytes == 2 ? 1 : 0;
> +	bool tweek_offset = (num_bytes == 2);
>  
> -	if (iio_trigger_using_own(indio_dev))
> -		ret = ads131e08_read_data(st, st->readback_len);
> -	else
> -		ret = ads131e08_pool_data(st);
> +	if (!st->rdatac_enabled)
> +		goto out;
>  
> -	if (ret)
> +	if (spi_sync(st->spi, &st->msg)) {
> +		dev_warn(&st->spi->dev, "SPI read in thread failed\n");

Sounds like an error so if we are going to report it dev_err() is 
appropriate.

> +		goto out;
> +	}
> +
> +	if (ads131e08_check_status(st))
>  		goto out;
>  
>  	iio_for_each_active_channel(indio_dev, chn) {
>  		src = st->rx_buf + ADS131E08_NUM_STATUS_BYTES + chn * num_bytes;
> -		dest = st->tmp_buf.data + i * ADS131E08_NUM_STORAGE_BYTES;
> +		dest = st->data + i * ADS131E08_NUM_STORAGE_BYTES;
>  
>  		/*
>  		 * Tweek offset is 0:
> @@ -664,12 +789,11 @@ static irqreturn_t ads131e08_trigger_handler(int irq, void *private)
>  		i++;
>  	}
>  
> -	iio_push_to_buffers_with_ts(indio_dev, &st->tmp_buf, sizeof(st->tmp_buf),
> -				    iio_get_time_ns(indio_dev));
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +					   iio_get_time_ns(indio_dev));

This switches to a deprecated interface with reduced error checking
which we should not do.


>  
>  out:
>  	iio_trigger_notify_done(indio_dev->trig);
> -

Please keep a blank line in places like this that are before simple returns.

>  	return IRQ_HANDLED;
>  }
>  
> @@ -678,8 +802,9 @@ static irqreturn_t ads131e08_interrupt(int irq, void *private)
>  	struct iio_dev *indio_dev = private;
>  	struct ads131e08_state *st = iio_priv(indio_dev);
>  
> -	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev))
> +	if (st->rdatac_enabled)
>  		iio_trigger_poll(st->trig);
> +

Why? This looks unnecessary to me. Makes sure to check for this sort
of white space change. They are easily introduced when working on a driver
but once we get to patch submission stage, they are just adding noise and
making the changes that matter harder to review.

>  	else
>  		complete(&st->completion);

>  static void ads131e08_regulator_disable(void *data)
> @@ -815,6 +941,7 @@ static int ads131e08_probe(struct spi_device *spi)
>  	st = iio_priv(indio_dev);
>  	st->info = info;
>  	st->spi = spi;
> +	st->rdatac_enabled = false;
>  
>  	ret = ads131e08_alloc_channels(indio_dev);
>  	if (ret)
> @@ -822,15 +949,14 @@ static int ads131e08_probe(struct spi_device *spi)
>  
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &ads131e08_iio_info;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

This change is a surprise. I'm not immediately seeing why it makes sense
given the extra flag is set internally in devm_iio_triggered_buffer_setup()
an no drivers should be setting it by hand.

> @@ -857,8 +983,9 @@ static int ads131e08_probe(struct spi_device *spi)
>  
>  	indio_dev->trig = iio_trigger_get(st->trig);
>  
> -	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> -		NULL, &ads131e08_trigger_handler, NULL);
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, NULL,
> +					      &ads131e08_trigger_handler,
> +					      &ads131e08_buffer_ops);

This is fine but wants to be in a patch that only does code formatting
changes.

>  	if (ret) {
>  		dev_err(&spi->dev, "failed to setup IIO buffer\n");
>  		return ret;
> @@ -873,7 +1000,8 @@ static int ads131e08_probe(struct spi_device *spi)
>  			return ret;
>  		}
>  
> -		ret = devm_add_action_or_reset(&spi->dev, ads131e08_regulator_disable, st);
> +		ret = devm_add_action_or_reset(&spi->dev,
> +					       ads131e08_regulator_disable, st);
Why? Arguably I'd have been fine with the shorter line length if the author
had chosen that, but we have some flexibility to go over 80 chars if it helps
readability. Changing it now seems like more trouble than it is worth.

>  		if (ret)
>  			return ret;
>  	} else {
> @@ -891,7 +1019,7 @@ static int ads131e08_probe(struct spi_device *spi)
>  	adc_clk_hz = clk_get_rate(st->adc_clk);
>  	if (!adc_clk_hz) {
>  		dev_err(&spi->dev, "failed to get the ADC clock rate\n");
> -		return  -EINVAL;
> +		return -EINVAL;

This is fine, but white space only changes belong in their own patch that
does nothing else.  Otherwise they add noise.

>  	}
>  
>  	adc_clk_ns = NSEC_PER_SEC / adc_clk_hz;
> @@ -910,13 +1038,19 @@ static int ads131e08_probe(struct spi_device *spi)
>  }
>  
>  static const struct of_device_id ads131e08_of_match[] = {
> -	{ .compatible = "ti,ads131e04",
> -	  .data = &ads131e08_info_tbl[ads131e04], },
> -	{ .compatible = "ti,ads131e06",
> -	  .data = &ads131e08_info_tbl[ads131e06], },
> -	{ .compatible = "ti,ads131e08",
> -	  .data = &ads131e08_info_tbl[ads131e08], },
> -	{ }
> +	{
> +		.compatible = "ti,ads131e04",
> +		.data = &ads131e08_info_tbl[ads131e04],
> +	},
> +	{
> +		.compatible = "ti,ads131e06",
> +		.data = &ads131e08_info_tbl[ads131e06],
> +	},
> +	{
> +		.compatible = "ti,ads131e08",
> +		.data = &ads131e08_info_tbl[ads131e08],
> +	},
Ok to reorganizing this.  However, if you are going to touch
these I would like to see that array ads131e08_info_tbl
go away. It would be more concise as separate structures with
names that make it clear what they are.

ads131e04_info, ads131e06_info etc.

> +	{}
As below.
>  };
>  MODULE_DEVICE_TABLE(of, ads131e08_of_match);
>  
> @@ -924,7 +1058,7 @@ static const struct spi_device_id ads131e08_ids[] = {
>  	{ "ads131e04", (kernel_ulong_t)&ads131e08_info_tbl[ads131e04] },
>  	{ "ads131e06", (kernel_ulong_t)&ads131e08_info_tbl[ads131e06] },
>  	{ "ads131e08", (kernel_ulong_t)&ads131e08_info_tbl[ads131e08] },
> -	{ }
> +	{}

What is benefit of this change?  It's actually breaking the preferred
style for IIO (which was randomly chosen to be { } for these).

>  };
>  MODULE_DEVICE_TABLE(spi, ads131e08_ids);
>  
> @@ -939,5 +1073,6 @@ static struct spi_driver ads131e08_driver = {
>  module_spi_driver(ads131e08_driver);
>  
>  MODULE_AUTHOR("Tomislav Denis <tomislav.denis@avl.com>");
> +MODULE_AUTHOR("Viktor Karamanis <viktor.karamanis@outlook.com>");
>  MODULE_DESCRIPTION("Driver for ADS131E0x ADC family");
>  MODULE_LICENSE("GPL v2");
> -- 
> 
> Viktor Karamanis (1):
> iio: adc: ti-ads131e08: Optimize performance and fix timing
> 
> drivers/iio/adc/ti-ads131e08.c | 643 ++++++++++++++++++++-------------
> 1 file changed, 389 insertions(+), 254 deletions(-)
> 
> --
> 2.43.0
> 
> 
> 

