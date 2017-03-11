Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:56632 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755659AbdCKOJL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Mar 2017 09:09:11 -0500
Subject: Re: [PATCH v2 07/11] iio: adc: sun4i-gpadc-iio: move code used in MFD
 probing to new function
To: icenowy@aosc.xyz,
        "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "maxime.ripard@free-electrons.com" <maxime.ripard@free-electrons.com>,
        "wens@csie.org" <wens@csie.org>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "stefan.mavrodiev@gmail.com" <stefan.mavrodiev@gmail.com>
References: <20170310103921.19469-1-quentin.schulz@free-electrons.com>
 <20170310103921.19469-8-quentin.schulz@free-electrons.com>
 <5850691489174592@web4o.yandex.ru>
Cc: "thomas.petazzoni@free-electrons.com"
        <thomas.petazzoni@free-electrons.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-sunxi@googlegroups.com" <linux-sunxi@googlegroups.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <92d5c8a7-6998-7fd0-6e42-0cea517e75ec@free-electrons.com>
Date: Sat, 11 Mar 2017 15:09:07 +0100
MIME-Version: 1.0
In-Reply-To: <5850691489174592@web4o.yandex.ru>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Icenowy,

On 10/03/2017 20:36, Icenowy Zheng wrote:
> 
> 
> 10.03.2017, 18:56, "Quentin Schulz" <quentin.schulz@free-electrons.com>:
>> This moves code used in MFD probing to a new sun4i_gpadc_probe_mfd
>> function.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>
>> added in v2
>>
>>  drivers/iio/adc/sun4i-gpadc-iio.c | 78 ++++++++++++++++++++++-----------------
> 
> I cannot find this source file even in linux-next.
> 

>From the cover letter:

This series of patch is based on this[1] series of patch.

[1] https://lkml.org/lkml/2016/12/13/298 : "[PATCH v9] add support for
Allwinner SoCs ADC"

Quentin
>>  1 file changed, 45 insertions(+), 33 deletions(-)
>>
>> diff --git a/drivers/iio/adc/sun4i-gpadc-iio.c b/drivers/iio/adc/sun4i-gpadc-iio.c
>> index a8e134f..7cb997a 100644
>> --- a/drivers/iio/adc/sun4i-gpadc-iio.c
>> +++ b/drivers/iio/adc/sun4i-gpadc-iio.c
>> @@ -454,31 +454,16 @@ static int sun4i_irq_init(struct platform_device *pdev, const char *name,
>>          return 0;
>>  }
>>
>> -static int sun4i_gpadc_probe(struct platform_device *pdev)
>> +static int sun4i_gpadc_probe_mfd(struct platform_device *pdev,
>> + struct iio_dev *indio_dev)
>>  {
>> - struct sun4i_gpadc_iio *info;
>> - struct iio_dev *indio_dev;
>> + struct sun4i_gpadc_iio *info = iio_priv(indio_dev);
>> + struct sun4i_gpadc_dev *sun4i_gpadc_dev =
>> + dev_get_drvdata(pdev->dev.parent);
>>          int ret;
>> - struct sun4i_gpadc_dev *sun4i_gpadc_dev;
>> -
>> - sun4i_gpadc_dev = dev_get_drvdata(pdev->dev.parent);
>> -
>> - indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>> - if (!indio_dev)
>> - return -ENOMEM;
>>
>> - info = iio_priv(indio_dev);
>> - platform_set_drvdata(pdev, indio_dev);
>> -
>> - mutex_init(&info->mutex);
>>          info->regmap = sun4i_gpadc_dev->regmap;
>> - info->indio_dev = indio_dev;
>> - init_completion(&info->completion);
>> - indio_dev->name = dev_name(&pdev->dev);
>> - indio_dev->dev.parent = &pdev->dev;
>> - indio_dev->dev.of_node = pdev->dev.of_node;
>> - indio_dev->info = &sun4i_gpadc_iio_info;
>> - indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>>          indio_dev->num_channels = ARRAY_SIZE(sun4i_gpadc_channels);
>>          indio_dev->channels = sun4i_gpadc_channels;
>>
>> @@ -519,8 +504,7 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>>                          dev_err(&pdev->dev,
>>                                  "could not register thermal sensor: %ld\n",
>>                                  PTR_ERR(tzd));
>> - ret = PTR_ERR(tzd);
>> - goto err;
>> + return PTR_ERR(tzd);
>>                  }
>>          } else {
>>                  indio_dev->num_channels =
>> @@ -528,36 +512,65 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>>                  indio_dev->channels = sun4i_gpadc_channels_no_temp;
>>          }
>>
>> - pm_runtime_set_autosuspend_delay(&pdev->dev,
>> - SUN4I_GPADC_AUTOSUSPEND_DELAY);
>> - pm_runtime_use_autosuspend(&pdev->dev);
>> - pm_runtime_set_suspended(&pdev->dev);
>> - pm_runtime_enable(&pdev->dev);
>> -
>>          if (IS_ENABLED(CONFIG_THERMAL_OF)) {
>>                  ret = sun4i_irq_init(pdev, "TEMP_DATA_PENDING",
>>                                       sun4i_gpadc_temp_data_irq_handler,
>>                                       "temp_data", &info->temp_data_irq,
>>                                       &info->ignore_temp_data_irq);
>>                  if (ret < 0)
>> - goto err;
>> + return ret;
>>          }
>>
>>          ret = sun4i_irq_init(pdev, "FIFO_DATA_PENDING",
>>                               sun4i_gpadc_fifo_data_irq_handler, "fifo_data",
>>                               &info->fifo_data_irq, &info->ignore_fifo_data_irq);
>>          if (ret < 0)
>> - goto err;
>> + return ret;
>>
>>          if (IS_ENABLED(CONFIG_THERMAL_OF)) {
>>                  ret = iio_map_array_register(indio_dev, sun4i_gpadc_hwmon_maps);
>>                  if (ret < 0) {
>>                          dev_err(&pdev->dev,
>>                                  "failed to register iio map array\n");
>> - goto err;
>> + return ret;
>>                  }
>>          }
>>
>> + return 0;
>> +}
>> +
>> +static int sun4i_gpadc_probe(struct platform_device *pdev)
>> +{
>> + struct sun4i_gpadc_iio *info;
>> + struct iio_dev *indio_dev;
>> + int ret;
>> +
>> + indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
>> + if (!indio_dev)
>> + return -ENOMEM;
>> +
>> + info = iio_priv(indio_dev);
>> + platform_set_drvdata(pdev, indio_dev);
>> +
>> + mutex_init(&info->mutex);
>> + info->indio_dev = indio_dev;
>> + init_completion(&info->completion);
>> + indio_dev->name = dev_name(&pdev->dev);
>> + indio_dev->dev.parent = &pdev->dev;
>> + indio_dev->dev.of_node = pdev->dev.of_node;
>> + indio_dev->info = &sun4i_gpadc_iio_info;
>> + indio_dev->modes = INDIO_DIRECT_MODE;
>> +
>> + ret = sun4i_gpadc_probe_mfd(pdev, indio_dev);
>> + if (ret)
>> + return ret;
>> +
>> + pm_runtime_set_autosuspend_delay(&pdev->dev,
>> + SUN4I_GPADC_AUTOSUSPEND_DELAY);
>> + pm_runtime_use_autosuspend(&pdev->dev);
>> + pm_runtime_set_suspended(&pdev->dev);
>> + pm_runtime_enable(&pdev->dev);
>> +
>>          ret = devm_iio_device_register(&pdev->dev, indio_dev);
>>          if (ret < 0) {
>>                  dev_err(&pdev->dev, "could not register the device\n");
>> @@ -570,7 +583,6 @@ static int sun4i_gpadc_probe(struct platform_device *pdev)
>>          if (IS_ENABLED(CONFIG_THERMAL_OF))
>>                  iio_map_array_unregister(indio_dev);
>>
>> -err:
>>          pm_runtime_put(&pdev->dev);
>>          pm_runtime_disable(&pdev->dev);
>>
>> --
>> 2.9.3
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
