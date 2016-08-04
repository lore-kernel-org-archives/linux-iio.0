Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:44552 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752457AbcHDKlR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Aug 2016 06:41:17 -0400
Subject: Re: [PATCH v3 4/4] iio: adc: add support for Allwinner SoCs ADC
To: Russell King - ARM Linux <linux@armlinux.org.uk>
References: <1469519027-11387-1-git-send-email-quentin.schulz@free-electrons.com>
 <1469519027-11387-5-git-send-email-quentin.schulz@free-electrons.com>
 <20160804095650.GN1041@n2100.armlinux.org.uk>
Cc: jdelvare@suse.com, linux@roeck-us.net, jic23@kernel.org,
	knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	maxime.ripard@free-electrons.com, wens@csie.org,
	lee.jones@linaro.org, linux-hwmon@vger.kernel.org,
	thomas.petazzoni@free-electrons.com, linux-iio@vger.kernel.org,
	antoine.tenart@free-electrons.com, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <638d9788-7b15-99c4-699c-a2b1dc127dd7@free-electrons.com>
Date: Thu, 4 Aug 2016 12:27:33 +0200
MIME-Version: 1.0
In-Reply-To: <20160804095650.GN1041@n2100.armlinux.org.uk>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/08/2016 11:56, Russell King - ARM Linux wrote:
> On Tue, Jul 26, 2016 at 09:43:47AM +0200, Quentin Schulz wrote:
>> +static int sunxi_gpadc_adc_read(struct iio_dev *indio_dev, int channel,
>> +				int *val)
>> +{
>> +	struct sunxi_gpadc_dev *info = iio_priv(indio_dev);
>> +	int ret = 0;
>> +
>> +	pm_runtime_get_sync(indio_dev->dev.parent);
>> +	mutex_lock(&info->mutex);
>> +
>> +	reinit_completion(&info->completion);
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_CTRL1,
>> +		     info->soc_specific->tp_mode_en |
>> +		     info->soc_specific->tp_adc_select |
>> +		     info->soc_specific->adc_chan_select(channel));
>> +	regmap_write(info->regmap, SUNXI_GPADC_TP_INT_FIFOC,
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_TRIG_LEVEL(1) |
>> +		     SUNXI_GPADC_TP_INT_FIFOC_TP_FIFO_FLUSH);
>> +	enable_irq(info->fifo_data_irq);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>> +
>> +	if (!wait_for_completion_timeout(&info->completion,
>> +					 msecs_to_jiffies(100))) {
>> +		ret = -ETIMEDOUT;
>> +		goto out;
>> +	}
>> +
>> +	*val = info->adc_data;
>> +
>> +out:
>> +	disable_irq(info->fifo_data_irq);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I spotted this while skipping over the patch - and also noticed the
> below.
> 
> ...
>> +	irq = platform_get_irq_byname(pdev, "TEMP_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no TEMP_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_temp_data_irq_handler, 0,
>> +					   "temp_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request TEMP_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
>> +	info->temp_data_irq = irq;
>> +	atomic_set(&info->ignore_temp_data_irq, 0);
>> +
>> +	irq = platform_get_irq_byname(pdev, "FIFO_DATA_PENDING");
>> +	if (irq < 0) {
>> +		dev_err(&pdev->dev,
>> +			"no FIFO_DATA_PENDING interrupt registered\n");
>> +		ret = irq;
>> +		goto err;
>> +	}
>> +
>> +	irq = regmap_irq_get_virq(sunxi_gpadc_mfd_dev->regmap_irqc, irq);
>> +	ret = devm_request_any_context_irq(&pdev->dev, irq,
>> +					   sunxi_gpadc_fifo_data_irq_handler, 0,
>> +					   "fifo_data", info);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev,
>> +			"could not request FIFO_DATA_PENDING interrupt: %d\n",
>> +			ret);
>> +		goto err;
>> +	}
>> +
>> +	disable_irq(irq);
>> +	info->fifo_data_irq = irq;
> 
> Firstly, claiming and then immediately disabling an interrupt handler
> looks very strange.  If you're disabling the interrupt because you're
> concerned that you may receive an unexpected interrupt, this is no
> good - consider what happens if the interrupt happens between you
> claiming and disabling it.

Indeed. This has been detected in v2
(https://lkml.org/lkml/2016/7/19/246) but since I only set values in
structures by reading registers defined beforehand, it is not a race.
However, like anything in the kernel, the driver might evolve and use
undefined variables in the interrupt handler which will introduce a
race. This potential race will be handled in v4 with atomic flags around
interrupt initializations (before requesting and after disabling). If an
interrupt occurs between the two instructions, reading the flag will
state if we need to ignore the interrupt.

> Secondly, interrupts asserted while disabled are recorded and replayed
> when you enable the interrupt, no matter when they happened (eg, they
> could occur immediately after you disabled the interrupt.)
> 
> I think you need to comment each of the sites in the driver, explaining
> why it's necessary to disable and enable the interrupt at the IRQ
> controller like this, or get rid of these enable/disable_irq() calls.

Comments for this is planned in v4.

Thanks,

Quentin
