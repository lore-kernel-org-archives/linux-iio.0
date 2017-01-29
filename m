Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www381.your-server.de ([78.46.137.84]:36474 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdA2Lqh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Jan 2017 06:46:37 -0500
Subject: Re: [PATCH 2/2] iio: distance: add devantech us ranger srf04
To: Andreas Klinger <ak@it-klinger.de>, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        dledford@redhat.com, akpm@linux-foundation.org,
        shraddha.6596@gmail.com, w@1wt.eu, balbi@kernel.org,
        mtk.manpages@gmail.com, sjenning@redhat.com,
        ksenija.stanojevic@gmail.com, vilhelm.gray@gmail.com,
        robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com,
        ijc+devicetree@hellion.org.uk, galak@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20170128235839.GA4797@andreas>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <89d921d4-df01-133e-cb5d-ecdeb4890d61@metafoo.de>
Date: Sun, 29 Jan 2017 12:43:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170128235839.GA4797@andreas>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/29/2017 12:58 AM, Andreas Klinger wrote:
> This patch adds support for the ultrasonic ranger srf04 of devantech.

Thanks for the patch. Looks mostly good, a few small comments inline.

> diff --git a/drivers/iio/proximity/srf04.c b/drivers/iio/proximity/srf04.c
> new file mode 100644
> index 000000000000..f458c3d9084b
> --- /dev/null
> +++ b/drivers/iio/proximity/srf04.c
> @@ -0,0 +1,269 @@
[...]
> +#include <linux/err.h>
> +#include <linux/gpio.h>

Your driver is only a GPIO consumer, so the above include should not be
necessary.

> +#include <linux/gpio/consumer.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/bitops.h>

As far as I can see nothing from bitops.h is used in this driver.

> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/sched.h>
> +#include <linux/interrupt.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +
[...]	
> +static int srf04_read(struct srf04_data *data)
> +{
> +	int ret;
> +	ktime_t ktime_dt;
> +	u64 dt_ns;
> +	u32 time_ns;
> +	u32 distance_mm;
> +
> +	mutex_lock(&data->lock);

Maybe a stupid question, but what does the lock protect?

> +
> +	reinit_completion(&data->rising);
> +	reinit_completion(&data->falling);
> +
> +	gpiod_set_value(data->gpiod_trig, 1);
> +	udelay(10);
> +	gpiod_set_value(data->gpiod_trig, 0);
> +
> +	mutex_unlock(&data->lock);
> +
> +	/* it cannot take more than 20 ms */
> +	ret = wait_for_completion_killable_timeout(&data->rising, HZ/50);
> +	if (ret < 0)

In case of a timeout wait_for_... will return 0. In case of an interrupt
(kill event) a negative value. In the later case we should typically
propagate the error rather than replacing it.

> +		return -ETIMEDOUT;
> +
> +	ret = wait_for_completion_killable_timeout(&data->falling, HZ/50);
> +	if (ret < 0)
> +		return -ETIMEDOUT;
> +
> +	ktime_dt = ktime_sub(data->ts_falling, data->ts_rising);
> +
> +	dt_ns = ktime_to_ns(ktime_dt);
> +	/*
> +	 * measuring more than 3 meters is beyond the posibilities of
> +	 * the sensor
> +	 */
> +	if (dt_ns > 8750000) {
> +		return -EFAULT;

EFAULT means that "An invalid user space address was specified for an
argument". EIO is usually used to indicate that there was a communication
issue with the device.

> +	}
> +	time_ns = dt_ns;
> +
> +	/*
> +	 * the speed as function of the temperature is approximately:
> +	 * speed = 331,5 + 0,6 * Temp
> +	 *   with Temp in °C
> +	 *   and speed in m/s
> +	 *
> +	 * use 343 m/s as ultrasonic speed at 20 °C here in absence of the
> +	 * temperature
> +	 *
> +	 * therefore:
> +	 * distance = time / 10^6 * 343 / 2
> +	 *   with time in ns
> +	 *   and distance in mm (one way)
> +	 *
> +	 * because we limit to 3 meters the multiplication with 343 just
> +	 * fits into 32 bit
> +	 */
> +	distance_mm = time_ns * 343 / 2000000;
> +
> +	dev_info (data->dev, "ns: %llu, dist: %d\n", dt_ns, distance_mm);

dev_dbg probably.

> +
> +	return distance_mm;
> +}
> +
> +static int srf04_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *channel, int *val,
> +			    int *val2, long mask)

I know lots of drivers use the name 'mask' here, but that is a relict from a
long long time ago and the implementation was changed and the old name it is
not really appropriate anymore. The recommendation is to use 'info' for new
drivers.

> +{
[...]
> +static int srf04_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct srf04_data *data = NULL;

The NULL initialization is not really necessary. The variable is never used
until it is initialized again a few lines below. The compiler will just
remove this.

> +	struct iio_dev *indio_dev;
> +	int ret = 0;

Same here.

> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(struct srf04_data));
> +	if (!indio_dev) {
> +		dev_err(dev, "failed to allocate IIO device\n");
> +		return -ENOMEM;
> +	}
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = dev;
> +
> +	mutex_init(&data->lock);
> +	init_completion(&data->rising);
> +	init_completion(&data->falling);
> +
> +	data->gpiod_trig = devm_gpiod_get(dev, "trig", GPIOD_OUT_LOW);
> +	if (IS_ERR(data->gpiod_trig)) {
> +		dev_err(dev, "failed to get trig-gpiod: err=%ld\n",
> +					PTR_ERR(data->gpiod_trig));
> +		return PTR_ERR(data->gpiod_trig);
> +	}
> +
> +	data->gpiod_echo = devm_gpiod_get(dev, "echo", GPIOD_IN);
> +	if (IS_ERR(data->gpiod_echo)) {
> +		dev_err(dev, "failed to get echo-gpiod: err=%ld\n",
> +					PTR_ERR(data->gpiod_echo));
> +		return PTR_ERR(data->gpiod_echo);
> +	}
> +
> +	if (gpiod_cansleep(data->gpiod_echo)) {
> +		dev_err(data->dev, "cansleep-GPIOs not supported\n");
> +		return -ENODEV;
> +	}
> +
> +	data->irqnr = gpiod_to_irq(data->gpiod_echo);
> +	if (data->irqnr < 0) {
> +		dev_err(data->dev, "gpiod_to_irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = request_irq(data->irqnr, srf04_handle_irq,
> +			IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
> +			pdev->name, indio_dev);
> +	if (ret < 0) {
> +		dev_err(data->dev, "request_irq: %d\n", ret);
> +		return ret;
> +	}
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	indio_dev->name = "srf04";
> +	indio_dev->dev.parent = &pdev->dev;
> +	indio_dev->info = &srf04_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = srf04_chans_spec;
> +	indio_dev->num_channels = ARRAY_SIZE(srf04_chan_spec);
> +
> +	return devm_iio_device_register(dev, indio_dev);

If this returns an error the interrupt needs to be freed.

> +}
> +
> +static int srf04_remove(struct platform_device *pdev)
> +{
> +	struct srf04_data *data = NULL;
> +	struct iio_dev *indio_dev;
> +
> +	indio_dev = platform_get_drvdata(pdev);
> +	data = iio_priv(indio_dev);

I'd write this as


	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
	struct srf04_data *data = iio_priv(indio_dev)

Looks a bit cleaner in my opinion.

> +
> +	free_irq(data->irqnr, indio_dev);
> +
> +	return 0;
> +}
[...]

