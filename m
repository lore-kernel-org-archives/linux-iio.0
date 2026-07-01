Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231D839F174;
	Wed,  1 Jul 2026 21:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782940281; cv=none; b=R+pbT2UCipKpGoIfJHJh1ZAS/2dii7lhNMtMGrYMyfBVz2A3H9hH5z14v4sXYdbWHxz1QYkdoz5XBWRUKeYxrTt5qTq3rKtMr8ThZmNRcPQuRU4rr+4ts8Ngi6fgZWsAYk4QWbM/b+jYU0SWiNtNj75M4feOwZgG4Bn/Vb32vyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782940281; c=relaxed/simple;
	bh=ntsvmBEtaZjgixm8EW4xfEJhK5dLaUyLe3zRER9tmGc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qI0QkJiDYH/i9ZcqQKaYjffGsuQMlxnWriGiH9+T5zxMLcYcvLmdi+1bNALOzb4b0W4+iSb2VTeeTxIpxQrd73JIakEiUR0BnhLOhRtJkD25gAALboe4RyWJOxuGCC79/Myv4aV4jdMjhPuaCFSotEGKJqmSRH08SLboW7purzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVr16EHM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVr16EHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A8E61F00A3D;
	Wed,  1 Jul 2026 21:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782940279;
	bh=CtwYQrYYiW6hpQCNYyX45j7zmtq9O7BK7U1u+USXMvo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GVr16EHM6F29TG6rx8ee3/BJXvM3iFNK8XlRXFDlrCBPAyR1JOSQJcYN78AwU3h7V
	 Vp4DNtiJZqa4Dnp+T+JcDUoH5155CntFIqOFW7HgirKVue2GtWXELsmPZe9texo2OW
	 ioRXmmdl9g9Mr0oKl7GjzxTizdi2FKjvr9yabqhfuDcJI58SQjlbF23ApzUw9edJM6
	 ZkypS1p4hlG1qjv7pnTCAoQA6ACiJvyQqkJSzRjxdTkdk8KJyHPxEkuM0yMURh2+in
	 6mtbHjJVf+I82s9pBJInuFVALmj/lN74Q5Lf5PEGLOf9BM3ePX/mDxqzuA5YjhTUzF
	 YTRm4s/0ADLDQ==
Date: Wed, 1 Jul 2026 22:11:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chi-Wen Weng <cwweng.linux@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 cwweng@nuvoton.com
Subject: Re: [PATCH 2/2] iio: adc: Add Nuvoton MA35D1 EADC driver
Message-ID: <20260701221115.544e33fd@jic23-huawei>
In-Reply-To: <20260625110638.38438-3-cwweng.linux@gmail.com>
References: <20260625110638.38438-1-cwweng.linux@gmail.com>
	<20260625110638.38438-3-cwweng.linux@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 19:06:38 +0800
Chi-Wen Weng <cwweng.linux@gmail.com> wrote:

> From: Chi-Wen Weng <cwweng@nuvoton.com>
> 
> Add an IIO driver for the Nuvoton MA35D1 Enhanced ADC controller.
> 
> The driver supports direct raw reads and triggered buffered capture. The
> controller end-of-conversion interrupt is exposed as the device trigger
> and is used to push samples into the IIO buffer.
> 
> Channels are described by firmware child nodes and can be configured as
> single-ended or differential inputs. Since the differential enable bit is
> global, mixed single-ended and differential buffered scans are rejected.
> 
> DMA support is intentionally not included in this initial upstream driver;
> conversions are handled through the interrupt-driven path.
> 
> Signed-off-by: Chi-Wen Weng <cwweng@nuvoton.com>

A few minor additional comments in line. I've tried to avoid
duplication but there may be some there!

Jonathan
> diff --git a/drivers/iio/adc/ma35d1_eadc.c b/drivers/iio/adc/ma35d1_eadc.c
> new file mode 100644
> index 000000000000..0c075126e139
> --- /dev/null
> +++ b/drivers/iio/adc/ma35d1_eadc.c

...

> +}
> +
> +static int ma35d1_adc_read_raw(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       int *val, int *val2, long mask)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		mutex_lock(&adc->lock);

Look at the ACQUIRE() macros for claim direct stuff (in iio.h)
and then use guard() for this.  Be careful to add {} to define scope
to being this case block.  May not save much code but it will be easeir
to read than this currently is.

> +		ret = ma35d1_adc_read_conversion(indio_dev, chan, val);
> +		mutex_unlock(&adc->lock);
> +
> +		iio_device_release_direct(indio_dev);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int ma35d1_adc_parse_channels(struct iio_dev *indio_dev,
> +				     struct device *dev)
> +{
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	DECLARE_BITMAP(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +	struct fwnode_handle *child;
> +	struct iio_chan_spec *channels;
> +	int num_channels;
> +	int scan_index = 0;

Move assignment down to just above the loop.  Makes it easier for
reviewers to associate the initial value with what is going on.

> +	int ret;
> +
> +	bitmap_zero(used_channels, MA35D1_EADC_MAX_CHANNELS);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (!num_channels)
> +		return dev_err_probe(dev, -ENODATA,
> +				     "no ADC channels configured\n");
> +
> +	if (num_channels > MA35D1_EADC_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "too many ADC channels\n");
> +
> +	channels = devm_kcalloc(dev, num_channels + 1, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node(dev, child) {
...

> +
> +static int ma35d1_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iio_dev *indio_dev;
> +	struct ma35d1_adc *adc;
> +	int irq;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	adc = iio_priv(indio_dev);
> +	adc->dev = dev;
> +	mutex_init(&adc->lock);
For new code
	ret = devm_mutex_init(&adc->lock);
	if (ret)
		return ret;

The advantage this brings to debug is small but it's also very simple
so we are no doing it for all new code in IIO.

> +	init_completion(&adc->completion);
> +
> +	adc->regs = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(adc->regs))
> +		return dev_err_probe(dev, PTR_ERR(adc->regs),
> +				     "failed to map registers\n");
> +
> +	adc->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(adc->clk))
> +		return dev_err_probe(dev, PTR_ERR(adc->clk),
> +				     "failed to get and enable ADC clock\n");
> +
> +	indio_dev->name = "ma35d1-eadc";
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_TRIGGERED;

Second part of this is set by the triggered_buffer call later. So don't set it
here.

> +	indio_dev->info = &ma35d1_adc_info;
> +
> +	ret = ma35d1_adc_parse_channels(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	ma35d1_adc_hw_init(adc);
> +
> +	ret = devm_add_action_or_reset(dev, ma35d1_adc_hw_disable, adc);
> +	if (ret)
> +		return ret;
> +
> +	ret = ma35d1_adc_setup_trigger(indio_dev, dev);
> +	if (ret)
> +		return ret;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, ma35d1_adc_isr, 0, dev_name(dev),
> +			       indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to request IRQ %d\n", irq);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ma35d1_adc_trigger_handler,
> +					      &ma35d1_adc_buffer_ops);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup triggered buffer\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		return -EBUSY;

Failing suspend because a buffer is enabled is unlikely to be popular.
Can you not save necessary state and restore so buffered capture continues
on resume?

> +
> +	ma35d1_adc_hw_disable(adc);
> +	clk_disable_unprepare(adc->clk);
> +
> +	return 0;
> +}
> +
> +static int ma35d1_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> +	struct ma35d1_adc *adc = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = clk_prepare_enable(adc->clk);
> +	if (ret)
> +		return ret;
> +
> +	ma35d1_adc_hw_init(adc);
> +
> +	return 0;
> +}


