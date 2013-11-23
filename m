Return-Path: <harald@ccbib.org>
From: Harald Geyer <harald@ccbib.org>
To: Jonathan Cameron <jic23@kernel.org>
cc: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>,
    Lars-Peter Clausen <lars@metafoo.de>,
    "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: Add new driver dht11-gpio
In-reply-to: <52909438.8000602@kernel.org>
References: <E1VYf74-0000gd-5Z@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222030570.23009@pmeerw.net> <E1VYiDp-0000pb-1i@stardust.g4.wien.funkfeuer.at> <alpine.DEB.2.01.1310222210230.23009@pmeerw.net> <E1VYjUo-0000uN-OY@stardust.g4.wien.funkfeuer.at> <5267E795.7030804@metafoo.de> <E1VZfrE-0000lZ-Ma@stardust.g4.wien.funkfeuer.at> <52909438.8000602@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sat, 23 Nov 2013 18:44:21 +0100
Message-Id: <E1VkHFl-00012T-4U@stardust.g4.wien.funkfeuer.at>
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron writes:
>On 10/25/13 12:47, Harald Geyer wrote:
>> This driver handles DHT11 and DHT22 sensors.
>>
>> Signed-off-by: Harald Geyer <harald@ccbib.org>
>
> Hi Harald,
>
> I'm afraid I completely missed your posting of this version 2.
>
> Do feel free to pester me if I fail to say anything about a patch
> for a couple of weeks.

Well, was going to do so in a few days ... :)

> Anyhow
>> ---
>> changes since v1 (tested on DHT11):
>> Add dependency on GPIOLIB
>> Prefix all local preprocessor macros with DHT11_
>> Rename STARTUP to START_TRANSMISSION
>> Remove leading zeros
>> Simplify channel disambiguation
>> Remove obvious comments
>> Make whitespace more consistent
>> Strip unnecessary output and simplify error handling
>> Fix spelling errors
>>
>> The v1 patch has been tested with DHT11 and DHT22 hardware.
> There are a few redundant bits below that want to be dropped.
>
> The only real issue I have otherwise is with the naming.
> I would expect *-gpio to be a driver providing gpios?

At least there are 'leds-gpio' and 'w1-gpio' already.
I was under the impression that drivers providing gpios
start with 'gpio' like 'gpio-mxs' ...

> Just go with dht11.  This applies to the bindings as well.

I'm happy to grab 'dht11' but am reluctant to do so because
somebody might write a DHT11 driver using some other IO hardware
then gpio. How would this be called then?

> Also note that policy is now to cc the device tree list for
> all patches changing or introducing bindings.
>
> I've cc'd them on this reply.

Thanks.

> Thanks,
>
> Jonathan
>>
>> Thanks,
>> Harald
>>
>>  .../bindings/iio/humidity/dht11-gpio.txt           |   14 +
>>  drivers/iio/Kconfig                                |    1 +
>>  drivers/iio/Makefile                               |    1 +
>>  drivers/iio/humidity/Kconfig                       |   15 +
>>  drivers/iio/humidity/Makefile                      |    5 +
>>  drivers/iio/humidity/dht11-gpio.c                  |  325 ++++++++++++++++++++
>>  6 files changed, 361 insertions(+), 0 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt
>>  create mode 100644 drivers/iio/humidity/Kconfig
>>  create mode 100644 drivers/iio/humidity/Makefile
>>  create mode 100644 drivers/iio/humidity/dht11-gpio.c
>>
>> diff --git a/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt b/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt
>> new file mode 100644
>> index 0000000..ee8fa04
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/iio/humidity/dht11-gpio.txt
>> @@ -0,0 +1,14 @@
>> +* DHT11 humidity/temperature sensor (and compatibles like DHT22)
>> +
>> +Required properties:
>> +  - compatible: Should be "dht11-gpio"
>> +  - gpios: Should specify the GPIO connected to the sensor's data
>> +    line, see "gpios property" in
>> +    Documentation/devicetree/bindings/gpio/gpio.txt.
>> +
>> +Example:
>> +
>> +humidity_sensor {
>> +	compatible = "dht11-gpio";
>> +	gpios = <&gpio0 6 0>;
>> +}
>> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
>> index 90cf0cd..a5ed882 100644
>> --- a/drivers/iio/Kconfig
>> +++ b/drivers/iio/Kconfig
>> @@ -65,6 +65,7 @@ source "drivers/iio/common/Kconfig"
>>  source "drivers/iio/dac/Kconfig"
>>  source "drivers/iio/frequency/Kconfig"
>>  source "drivers/iio/gyro/Kconfig"
>> +source "drivers/iio/humidity/Kconfig"
>>  source "drivers/iio/imu/Kconfig"
>>  source "drivers/iio/light/Kconfig"
>>  source "drivers/iio/magnetometer/Kconfig"
>> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
>> index bcf7e9e..b3b5096 100644
>> --- a/drivers/iio/Makefile
>> +++ b/drivers/iio/Makefile
>> @@ -18,6 +18,7 @@ obj-y += common/
>>  obj-y += dac/
>>  obj-y += gyro/
>>  obj-y += frequency/
>> +obj-y += humidity/
>>  obj-y += imu/
>>  obj-y += light/
>>  obj-y += magnetometer/
>> diff --git a/drivers/iio/humidity/Kconfig b/drivers/iio/humidity/Kconfig
>> new file mode 100644
>> index 0000000..bbc44f2
>> --- /dev/null
>> +++ b/drivers/iio/humidity/Kconfig
>> @@ -0,0 +1,15 @@
>> +#
>> +# humidity sensor drivers
>> +#
>> +menu "Humidity sensors"
>> +
>> +config DHT11_GPIO
> The _GPIO to my mind would normally imply that this as a driver
> providing GPIOs rather than using them.

I will change this according to the result of the naming
discussion.

>> +	tristate "DHT11 (and compatible sensors) driver"
>> +	depends on GPIOLIB
>> +	help
>> +	  This driver supports reading data via a single interrupt
>> +	  generating GPIO line. Currently tested are DHT11 and DHT22.
>> +	  Other sensors should work as well as long as they speak the
>> +	  same protocol.
>> +
>> +endmenu
>> diff --git a/drivers/iio/humidity/Makefile b/drivers/iio/humidity/Makefile
>> new file mode 100644
>> index 0000000..5e8226f
>> --- /dev/null
>> +++ b/drivers/iio/humidity/Makefile
>> @@ -0,0 +1,5 @@
>> +#
>> +# Makefile for IIO humidity sensor drivers
>> +#
>> +
>> +obj-$(CONFIG_DHT11_GPIO) += dht11-gpio.o
>> diff --git a/drivers/iio/humidity/dht11-gpio.c b/drivers/iio/humidity/dht11-gpio.c
>> new file mode 100644
>> index 0000000..3bb4d81
>> --- /dev/null
>> +++ b/drivers/iio/humidity/dht11-gpio.c
>> @@ -0,0 +1,325 @@
> ...
> Don't bother with this comment.  If anyone wants it they can
> add support :)
>> +/* TODO?: Support systems without DT? */

Ok.

>> +
>> +struct dht11_gpio {
>> +	struct device			*dev;
>> +
>> +	int				gpio;
>> +	int				irq;
>> +
>> +	struct completion		completion;
>> +
>> +	s64				timestamp;
>> +	int				temperature;
>> +	int				humidity;
>> +
>> +	/* num_edges: -1 means "no transmission in progress" */
>> +	int				num_edges;
>> +	struct {s64 ts; int value; }	edges[DHT11_EDGES_PER_READ];
>> +};
>> +
> This isn't called anywhere and so should be removed from the driver.

I will do so, if you think it's more apropriate. I figured that
commenting it out is like removing but retaining a useful comment.
Maybe prefix the whole comment with asterix to make it more obvious
this actually is a comment?

>> +/*
>> + * dht11_edges_print: show the data as actually received by the
>> + *                    driver.
>> + * This is dead code, keeping it for now just in case somebody needs
>> + * it for porting the driver to new sensor HW, etc.
>> + *
>> +static void dht11_edges_print(struct dht11_gpio *dht11)
>> +{
>> +	int i;
>> +
>> +	for (i = 1; i < dht11->num_edges; ++i) {
>> +		pr_err("dht11-gpio: %d: %lld ns %s\n", i,
>> +			dht11->edges[i].ts - dht11->edges[i-1].ts,
>> +			dht11->edges[i-1].value ? "high" : "low");
>> +	}
>> +}
>> +*/
> ...



>> +static const struct of_device_id dht11_gpio_dt_ids[] = {
>> +	{ .compatible = "dht11-gpio", },
>> +	{ }
>> +};
>> +MODULE_DEVICE_TABLE(of, dht11_gpio_dt_ids);
>> +
>> +static int dht11_gpio_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct device_node *node = dev->of_node;
>> +	struct dht11_gpio *dht11;
>> +	struct iio_dev *iio;
>> +	int ret;
>> +
>> +	iio = devm_iio_device_alloc(dev, sizeof(*dht11));
>> +	if (!iio) {
>> +		dev_err(dev, "Failed to allocate IIO device\n");
>> +		return -ENOMEM;
>> +	}
>> +
>> +	dht11 = iio_priv(iio);
>> +	dht11->dev = dev;
>> +
>> +	dht11->gpio = ret = of_get_gpio(node, 0);
>> +	if (ret < 0)
>> +		return ret;
>> +	ret = devm_gpio_request_one(dev, dht11->gpio, GPIOF_IN, pdev->name);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dht11->irq = gpio_to_irq(dht11->gpio);
>> +	if (dht11->irq < 0) {
>> +		dev_err(dev, "GPIO %d has no interrupt\n", dht11->gpio);
>> +		return -EINVAL;
>> +	}
>> +	ret = devm_request_irq(dev, dht11->irq, dht11_gpio_handle_irq,
>> +				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
>> +				pdev->name, iio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	dht11->timestamp = iio_get_time_ns() - DHT11_DATA_VALID_TIME - 1;
>> +	dht11->num_edges = -1;
>> +
>> +	platform_set_drvdata(pdev, iio);
>> +
>> +	init_completion(&dht11->completion);
>> +	iio->name = pdev->name;
>> +	iio->dev.parent = &pdev->dev;
>> +	iio->info = &dht11_gpio_iio_info;
>> +	iio->modes = INDIO_DIRECT_MODE;
>> +	iio->channels = dht11_gpio_chan_spec;
>> +	iio->num_channels = ARRAY_SIZE(dht11_gpio_chan_spec);
>> +
>> +	return iio_device_register(iio);
>> +}
>> +
>
> Could use the new devm_iio_device_register() call and drop
> this boilerplate.

Yes, I'll send a v3 with this after the other issues are sorted
out.

Thanks,
Harald

>> +static int dht11_gpio_remove(struct platform_device *pdev)
>> +{
>> +	struct iio_dev *iio = platform_get_drvdata(pdev);
>> +
>> +	iio_device_unregister(iio);
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver dht11_gpio_driver = {
>> +	.driver = {
>> +		.name	= DRIVER_NAME,
>> +		.owner	= THIS_MODULE,
>> +		.of_match_table = dht11_gpio_dt_ids,
>> +	},
>> +	.probe  = dht11_gpio_probe,
>> +	.remove = dht11_gpio_remove,
>> +};
>> +
>> +module_platform_driver(dht11_gpio_driver);
>> +
>> +MODULE_AUTHOR("Harald Geyer <harald@ccbib.org>");
>> +MODULE_DESCRIPTION("DHT11 humidity/temperature sensor driver");
>> +MODULE_LICENSE("GPL v2");
>> +
>>
>--
>To unsubscribe from this list: send the line "unsubscribe linux-iio" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
