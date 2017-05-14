Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34207 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbdENKrZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 May 2017 06:47:25 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so11471128wrb.1
        for <linux-iio@vger.kernel.org>; Sun, 14 May 2017 03:47:24 -0700 (PDT)
Subject: Re: [PATCH v3 5/5] iio: adc: New driver for Cirrus Logic EP93xx ADC
To: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, Ryan Mallon <rmallon@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20170514092954.12790-1-alexander.sverdlin@gmail.com>
 <20170514092954.12790-6-alexander.sverdlin@gmail.com>
 <alpine.DEB.2.20.1705141156350.1876@vps.pmeerw.net>
From: Alexander Sverdlin <alexander.sverdlin@gmail.com>
Message-ID: <5b92c3d8-452a-6cc8-315d-28d6163b69bd@gmail.com>
Date: Sun, 14 May 2017 12:47:19 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1705141156350.1876@vps.pmeerw.net>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Peter,

On 14/05/17 12:07, Peter Meerwald-Stadler wrote:
>> +			/*
>> +			 * Settling delay depends on module clock and could be
>> +			 * 2ms or 500us
>> +			 */
>> +			ep93xx_adc_delay(2000, 2000);
> min == max? here and below

Yes. I'm not allowed to lower this and increasing this lowers the conversion rate,
which makes no sense. In practice, this 200MHz SoC survives couple of thousands
interrupts per second perfectly. It takes some single percent of CPU time on back
to back conversions.

> what about the 500us?

See below, it's just a hint if someone ever would like to implement the second
conversion rate option.

>> +		}
>> +		/* Start the conversion, eventually discarding old result */
>> +		readl_relaxed(priv->base + EP93XX_ADC_RESULT);
>> +		/* Ensure maximun conversion rate is not exceeded */
> maximum
> 
>> +		ep93xx_adc_delay(DIV_ROUND_UP(1000000, 925),
>> +				 DIV_ROUND_UP(1000000, 925));
>> +		/* At this point conversion must be completed, but anyway... */
>> +		ret = IIO_VAL_INT;
>> +		timeout = jiffies + msecs_to_jiffies(1) + 1;
>> +		while (1) {
>> +			u32 t;
>> +
>> +			t = readl_relaxed(priv->base + EP93XX_ADC_RESULT);
>> +			if (t & EP93XX_ADC_SDR) {
>> +				/* Sign extend lower 16 bits */
>> +				*value = (s16)t;
> could use sign_extend32() and drop the comment

OK :)

>> +				break;
>> +			}
>> +
>> +			if (time_after(jiffies, timeout)) {
>> +				dev_err(&iiodev->dev, "Conversion timeout\n");
>> +				ret = -ETIMEDOUT;
>> +				break;
>> +			}
>> +
>> +			cpu_relax();
>> +		}
>> +		mutex_unlock(&priv->lock);
>> +		return ret;
>> +
>> +	case IIO_CHAN_INFO_OFFSET:
>> +		/* According to datasheet, range is -25000..25000 */
> so signed values (-25000..25000) are mapped to unsigned values (0..50000)?

Yes, strange HW design with 2.5v reference out of 5v supply.

>> +		*value = 25000;
>> +		return IIO_VAL_INT;
>> +
>> +	case IIO_CHAN_INFO_SCALE:
>> +		/* Typical supply voltage is 3.3v */
>> +		*value = (1ULL << 32) * 3300 / 50000;
>> +		*shift = 32;
>> +		return IIO_VAL_FRACTIONAL_LOG2;
>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static const struct iio_info ep93xx_adc_info = {
>> +	.driver_module = THIS_MODULE,
>> +	.read_raw = ep93xx_read_raw,
>> +};
>> +
>> +static int ep93xx_adc_probe(struct platform_device *pdev)
>> +{
>> +	int ret;
>> +	struct iio_dev *iiodev;
>> +	struct ep93xx_adc_priv *priv;
>> +	struct clk *pclk;
>> +	struct resource *res;
>> +
>> +	iiodev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
>> +	if (!iiodev)
>> +		return -ENOMEM;
>> +	priv = iio_priv(iiodev);
>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
>> +		dev_err(&pdev->dev, "Cannot obtain memory resource\n");
>> +		return -ENXIO;
>> +	}
>> +	priv->base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(priv->base)) {
>> +		dev_err(&pdev->dev, "Cannot map memory resource\n");
>> +		return PTR_ERR(priv->base);
>> +	}
>> +
>> +	iiodev->dev.parent = &pdev->dev;
>> +	iiodev->name = dev_name(&pdev->dev);
>> +	iiodev->modes = INDIO_DIRECT_MODE;
>> +	iiodev->info = &ep93xx_adc_info;
>> +	iiodev->num_channels = ARRAY_SIZE(ep93xx_adc_channels);
>> +	iiodev->channels = ep93xx_adc_channels;
>> +
>> +	priv->lastch = -1;
>> +	mutex_init(&priv->lock);
>> +
>> +	platform_set_drvdata(pdev, iiodev);
>> +
>> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(priv->clk)) {
>> +		dev_err(&pdev->dev, "Cannot obtain clock\n");
>> +		return PTR_ERR(priv->clk);
>> +	}
>> +
>> +	pclk = clk_get_parent(priv->clk);
>> +	if (!pclk) {
>> +		dev_warn(&pdev->dev, "Cannot obtain parent clock\n");
>> +	} else {
>> +		/*
>> +		 * This is actually a place for improvement:
>> +		 * EP93xx ADC supports two clock divisors -- 4 and 16,
>> +		 * resulting in conversion rates 3750 and 925 samples per second
>> +		 * respectively with 500uS or 2ms settling time respectively.
> 2x respectively
> uS -> us
> 
> the delay in _read() is fixed to 2ms

Yes, it's a hint/todo if someone would need faster conversion rate.

>> +		 * One might find this interesting enough to be configurable.
>> +		 */

Thanks for your comments!
Alexander.
