Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from pandora.armlinux.org.uk ([78.32.30.218]:52035 "EHLO
	pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750819AbcHDJ50 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 05:57:26 -0400
Date: Thu, 4 Aug 2016 10:56:50 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
	thomas.petazzoni@free-electrons.com, linux-iio@vger.kernel.org,
	antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
Message-ID: <20160804095650.GN1041@n2100.armlinux.org.uk>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jul 26, 2016 at 09:43:47AM +0200, Quentin Schulz wrote:
> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
> +				int *val)
> +{
> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	pm_runtime_get_sync(indio_dev->dev.parent);
> +	mutex_lock(&info->mutex);
> +
> +	reinit_completion(&info->completion);
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
> +		     info->soc_specific->tp_mode_en |
> +		     info->soc_specific->tp_adc_select |
> +		     info->soc_specific->adc_chan_select(channel));
> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
> +	enable_irq(info->fifo_data_irq);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

> +
> +	if (!wait_for_completion_timeout(&info->completion,
> +					 msecs_to_jiffies(100))) {
> +		ret = -ETIMEDOUT;
> +		goto out;
> +	}
> +
> +	*val = info->adc_data;
> +
> +out:
> +	disable_irq(info->fifo_data_irq);
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

I spotted this while skipping over the patch - and also noticed the
below.

...
> +	irq = platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no TEMP_DATA_PENDING interrupt registered\n");
> +		ret = irq;
> +		goto err;
> +	}
> +
> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_temp_data_irq_handler, 0,
> +					   "temp_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	disable_irq(irq);
^^^^^^^^^^^^^^^^^^^^^^^^^^

> +	info->temp_data_irq = irq;
> +	atomic_set(&info->ignore_temp_data_irq, 0);
> +
> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
> +	if (irq < 0) {
> +		dev_err(&pdev->dev,
> +			"no FIFO_DATA_PENDING interrupt registered\n");
> +		ret = irq;
> +		goto err;
> +	}
> +
> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
> +					   sunxi_gpadc_fifo_data_irq_handler, 0,
> +					   "fifo_data", info);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev,
> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
> +			ret);
> +		goto err;
> +	}
> +
> +	disable_irq(irq);
> +	info->fifo_data_irq = irq;

Firstly, claiming and then immediately disabling an interrupt handler
looks very strange.  If you're disabling the interrupt because you're
concerned that you may receive an unexpected interrupt, this is no
good - consider what happens if the interrupt happens between you
claiming and disabling it.

Secondly, interrupts asserted while disabled are recorded and replayed
when you enable the interrupt, no matter when they happened (eg, they
could occur immediately after you disabled the interrupt.)

I think you need to comment each of the sites in the driver, explaining
why it's necessary to disable and enable the interrupt at the IRQ
controller like this, or get rid of these enable/disable_irq() calls.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
