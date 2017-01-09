Return-Path: <SRS0=vDUN=YX=intel.com=rui.zhang@kernel.org>
Message-ID: <1483927934.2281.3.camel@intel.com>
Subject: Re: [PATCH v9 3/3] iio: adc: add support for Allwinner SoCs ADC
From: Zhang Rui <rui.zhang@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, Quentin Schulz
 <quentin.schulz@free-electrons.com>, linux@armlinux.org.uk,
 maxime.ripard@free-electrons.com, wens@csie.org, knaack.h@gmx.de,
 lars@metafoo.de,  pmeerw@pmeerw.net, lee.jones@linaro.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, antoine.tenart@free-electrons.com,
 thomas.petazzoni@free-electrons.com, "edubezval@gmail.com"
 <edubezval@gmail.com>
Date: Mon, 09 Jan 2017 10:12:14 +0800
In-Reply-To: <f8285a90-656f-0da4-ee81-47b79ce4cd2c@kernel.org>
References: <20161213143332.24988-1-quentin.schulz@free-electrons.com>
	 <20161213143332.24988-4-quentin.schulz@free-electrons.com>
	 <8132b799-6c6e-fc74-ebac-6959ac4c97a7@kernel.org>
	 <f8285a90-656f-0da4-ee81-47b79ce4cd2c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi,

On Sun, 2017-01-08 at 11:17 +0000, Jonathan Cameron wrote:
> On 30/12/16 14:40, Jonathan Cameron wrote:
> > 
> > On 13/12/16 14:33, Quentin Schulz wrote:
> > > 
> > > The Allwinner SoCs all have an ADC that can also act as a
> > > touchscreen
> > > controller and a thermal sensor. This patch adds the ADC driver
> > > which is
> > > based on the MFD for the same SoCs ADC.
> > > 
> > > This also registers the thermal adc channel in the iio map array
> > > so
> > > iio_hwmon could use it without modifying the Device Tree. This
> > > registers
> > > the driver in the thermal framework.
> > > 
> > > The thermal sensor requires the IP to be in touchscreen mode to
> > > return
> > > correct values. Therefore, if the user is continuously reading
> > > the ADC
> > > channel(s), the thermal framework in which the thermal sensor is
> > > registered will switch the IP in touchscreen mode to get a
> > > temperature
> > > value and requires a delay of 100ms (because of the mode
> > > switching),
> > > then the ADC will switch back to ADC mode and requires also a
> > > delay of
> > > 100ms. If the ADC readings are critical to user and the SoC
> > > temperature
> > > is not, this driver is capable of not registering the thermal
> > > sensor in
> > > the thermal framework and thus, "quicken" the ADC readings.
> > > 
> > > This driver probes on three different platform_device_id to take
> > > into
> > > account slight differences (registers bit and temperature
> > > computation)
> > > between Allwinner SoCs ADCs.
> > > 
> > > Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
> > > Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > > Acked-by: Jonathan Cameron <jic23@kernel.org>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > One comment inline but not a blocker.
> > 
> > I would ideally like an ack from the thermal side.  The relevant
> > code
> > is small, but best to be sure and keep them in the loop as well.
> > 
> > It does feel a little convoluted to have both this directly
> > providing
> > a thermal zone and being able to create one indirectly through
> > hwmon as
> > well but this solution works for me I think...
> > 
> > Cc'd Zang and Eduardo.
> Nothing seems to have come through on that front.
> 
> I need to get a pull request out to Greg and rebase my tree before I
> have
> the precursor patch in place. Give me a bump if you haven't heard
> anything by
> the time next week.
> 
> Thanks,
> 
> Jonathan
> > 
> > 
> > 
> > > +
> > > +static int sun4i_gpadc_probe(struct platform_device *pdev)
> > > +{
> > > +	struct sun4i_gpadc_iio *info;
> > > +	struct iio_dev *indio_dev;
> > > +	int ret;
> > > +	struct sun4i_gpadc_dev *sun4i_gpadc_dev;
> > > +
> > > +	sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
> > > +
> > > +	indio_dev = devm_iio_device_alloc(&pdev->dev,
> > > sizeof(*info));
> > > +	if (!indio_dev)
> > > +		return -ENOMEM;
> > > +
> > > +	info = iio_priv(indio_dev);
> > > +	platform_set_drvdata(pdev, indio_dev);
> > > +
> > > +	mutex_init(&info->mutex);
> > > +	info->regmap = sun4i_gpadc_dev->regmap;
> > > +	info->indio_dev = indio_dev;
> > > +	init_completion(&info->completion);
> > > +	indio_dev->name = dev_name(&pdev->dev);
> > > +	indio_dev->dev.parent = &pdev->dev;
> > > +	indio_dev->dev.of_node = pdev->dev.of_node;
> > > +	indio_dev->info = &sun4i_gpadc_iio_info;
> > > +	indio_dev->modes = INDIO_DIRECT_MODE;
> > > +	indio_dev->num_channels =
> > > ARRAY_SIZE(sun4i_gpadc_channels);
> > > +	indio_dev->channels = sun4i_gpadc_channels;
> > > +
> > > +	info->data = (struct gpadc_data
> > > *)platform_get_device_id(pdev)->driver_data;
> > > +
> > > +	/*
> > > +	 * Since the controller needs to be in touchscreen mode
> > > for its thermal
> > > +	 * sensor to operate properly, and that switching
> > > between the two modes
> > > +	 * needs a delay, always registering in the thermal
> > > framework will
> > > +	 * significantly slow down the conversion rate of the
> > > ADCs.
> > > +	 *
> > > +	 * Therefore, instead of depending on THERMAL_OF in
> > > Kconfig, we only
> > > +	 * register the sensor if that option is enabled,
> > > eventually leaving
> > > +	 * that choice to the user.
> > > +	 */
> > > +
> > > +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> > > +		/*
> > > +		 * This driver is a child of an MFD which has a
> > > node in the DT
> > > +		 * but not its children, because of DT backward
> > > compatibility
> > > +		 * for A10, A13 and A31 SoCs. Therefore, the
> > > resulting devices
> > > +		 * of this driver do not have an of_node
> > > variable.
> > > +		 * However, its parent (the MFD driver) has an
> > > of_node variable
> > > +		 * and since
> > > devm_thermal_zone_of_sensor_register uses its first
> > > +		 * argument to match the phandle defined in the
> > > node of the
> > > +		 * thermal driver with the of_node of the device
> > > passed as first
> > > +		 * argument and the third argument to call ops
> > > from
> > > +		 * thermal_zone_of_device_ops, the solution is
> > > to use the parent
> > > +		 * device as first argument to match the phandle
> > > with its
> > > +		 * of_node, and the device from this driver as
> > > third argument to
> > > +		 * return the temperature.
> > > +		 */
I'd leave this for Eduardo.

thanks,
rui
> > > +		struct thermal_zone_device *tzd;
> > > +		tzd = devm_thermal_zone_of_sensor_register(pdev-
> > > >dev.parent, 0,
> > > +							   info,
> > > +							   &sun4
> > > i_ts_tz_ops);
> > > +		if (IS_ERR(tzd)) {
> > > +			dev_err(&pdev->dev,
> > > +				"could not register thermal
> > > sensor: %ld\n",
> > > +				PTR_ERR(tzd));
> > > +			ret = PTR_ERR(tzd);
> > > +			goto err;
> > > +		}
> > > +	} else {
> > > +		indio_dev->num_channels =
> > > +			ARRAY_SIZE(sun4i_gpadc_channels_no_temp)
> > > ;
> > > +		indio_dev->channels =
> > > sun4i_gpadc_channels_no_temp;
> > > +	}
> > > +
> > > +	pm_runtime_set_autosuspend_delay(&pdev->dev,
> > > +					 SUN4I_GPADC_AUTOSUSPEND
> > > _DELAY);
> > > +	pm_runtime_use_autosuspend(&pdev->dev);
> > > +	pm_runtime_set_suspended(&pdev->dev);
> > > +	pm_runtime_enable(&pdev->dev);
> > > +
> > > +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> > > +		ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
> > > +				     sun4i_gpadc_temp_data_irq_h
> > > andler,
> > > +				     "temp_data", &info-
> > > >temp_data_irq,
> > > +				     &info-
> > > >ignore_temp_data_irq);
> > > +		if (ret < 0)
> > > +			goto err;
> > > +	}
> > > +
> > > +	ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
> > > +			     sun4i_gpadc_fifo_data_irq_handler,
> > > "fifo_data",
> > > +			     &info->fifo_data_irq, &info-
> > > >ignore_fifo_data_irq);
> > > +	if (ret < 0)
> > > +		goto err;
> > > +
> > > +	if (IS_ENABLED(CONFIG_THERMAL_OF)) {
> > > +		ret = iio_map_array_register(indio_dev,
> > > sun4i_gpadc_hwmon_maps);
> > > +		if (ret < 0) {
> > > +			dev_err(&pdev->dev,
> > > +				"failed to register iio map
> > > array\n");
> > > +			goto err;
> > > +		}
> > > +	}
> > > +
> > > +	ret = devm_iio_device_register(&pdev->dev, indio_dev);
> > > +	if (ret < 0) {
> > > +		dev_err(&pdev->dev, "could not register the
> > > device\n");
> > > +		goto err_map;
> > > +	}
> > > +
> > > +	return 0;
> > > +
> > > +err_map:
> > > +	if (IS_ENABLED(CONFIG_THERMAL_OF))
> > > +		iio_map_array_unregister(indio_dev);
> > > +
> > > +err:
> > > +	pm_runtime_put(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static int sun4i_gpadc_remove(struct platform_device *pdev)
> > > +{
> > > +	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> > > +
> > > +	pm_runtime_put(&pdev->dev);
> > > +	pm_runtime_disable(&pdev->dev);
> > > +	if (IS_ENABLED(CONFIG_THERMAL_OF))
> > > +		iio_map_array_unregister(indio_dev);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static const struct platform_device_id sun4i_gpadc_id[] = {
> > > +	{ "sun4i-a10-gpadc-iio",
> > > (kernel_ulong_t)&sun4i_gpadc_data },
> > > +	{ "sun5i-a13-gpadc-iio",
> > > (kernel_ulong_t)&sun5i_gpadc_data },
> > > +	{ "sun6i-a31-gpadc-iio",
> > > (kernel_ulong_t)&sun6i_gpadc_data },
> > > +	{ /* sentinel */ },
> > > +};
> > > +
> > > +static struct platform_driver sun4i_gpadc_driver = {
> > > +	.driver = {
> > > +		.name = "sun4i-gpadc-iio",
> > > +		.pm = &sun4i_gpadc_pm_ops,
> > > +	},
> > > +	.id_table = sun4i_gpadc_id,
> > > +	.probe = sun4i_gpadc_probe,
> > > +	.remove = sun4i_gpadc_remove,
> > > +};
> > > +
> > > +module_platform_driver(sun4i_gpadc_driver);
> > > +
> > > +MODULE_DESCRIPTION("ADC driver for sunxi platforms");
> > > +MODULE_AUTHOR("Quentin Schulz <quentin.schulz@free-electrons.com
> > > >");
> > > +MODULE_LICENSE("GPL v2");
> > > diff --git a/include/linux/mfd/sun4i-gpadc.h
> > > b/include/linux/mfd/sun4i-gpadc.h
> > > index d7a29f2..509e736 100644
> > > --- a/include/linux/mfd/sun4i-gpadc.h
> > > +++ b/include/linux/mfd/sun4i-gpadc.h
> > > @@ -28,6 +28,7 @@
> > >  #define SUN4I_GPADC_CTRL1_TP_MODE_EN			BIT(
> > > 4)
> > >  #define SUN4I_GPADC_CTRL1_TP_ADC_SELECT			B
> > > IT(3)
> > >  #define SUN4I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GEN
> > > MASK(2, 0) & (x))
> > > +#define SUN4I_GPADC_CTRL1_ADC_CHAN_MASK			G
> > > ENMASK(2, 0)
> > >  
> > >  /* TP_CTRL1 bits for sun6i SOCs */
> > >  #define SUN6I_GPADC_CTRL1_TOUCH_PAN_CALI_EN		BIT(7
> > > )
> > > @@ -35,6 +36,7 @@
> > >  #define SUN6I_GPADC_CTRL1_TP_MODE_EN			BIT(
> > > 5)
> > >  #define SUN6I_GPADC_CTRL1_TP_ADC_SELECT			B
> > > IT(4)
> > >  #define SUN6I_GPADC_CTRL1_ADC_CHAN_SELECT(x)		(GEN
> > > MASK(3, 0) & BIT(x))
> > > +#define SUN6I_GPADC_CTRL1_ADC_CHAN_MASK			G
> > > ENMASK(3, 0)
> > >  
> > >  #define SUN4I_GPADC_CTRL2				0x08
> > >  
> > > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-
> > iio" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
