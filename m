Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f195.google.com ([209.85.213.195]:35937 "EHLO
	mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755494AbbIDMVW (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 4 Sep 2015 08:21:22 -0400
MIME-Version: 1.0
In-Reply-To: <1441144199-20231-3-git-send-email-cnphoon@altera.com>
References: <1441144199-20231-1-git-send-email-cnphoon@altera.com>
	<1441144199-20231-3-git-send-email-cnphoon@altera.com>
Date: Fri, 4 Sep 2015 17:51:21 +0530
Message-ID: <CAKfKVtH1_wb2MLEgw0uf61tcoC7P2Uz6hC_GmP8vRakLnArB=A@mail.gmail.com>
Subject: Re: [[PATCH v2] 2/2] Altera Modular ADC driver support
From: Shubhrajyoti Datta <shubhrajyoti.datta@gmail.com>
To: Chee Nouk Phoo <cnphoon@altera.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
	Michael.Hennerich@analog.com, cnphoon.linux@gmail.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> +static int alt_modular_adc_probe(struct platform_device *pdev)
> +{
> +       struct altera_adc *adc;
> +       struct device_node *np = pdev->dev.of_node;
> +       struct iio_dev *indio_dev;
> +       struct resource *mem;
> +       int ret;
> +
> +       if (!np)
> +               return -ENODEV;
> +
> +       indio_dev = iio_device_alloc(sizeof(struct altera_adc));
> +       if (!indio_dev) {
> +               dev_err(&pdev->dev, "failed allocating iio device\n");
> +               return -ENOMEM;
> +       }
> +
> +       adc = iio_priv(indio_dev);
> +
> +       mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +               "sequencer_csr");
> +       adc->seq_regs = devm_ioremap_resource(&pdev->dev, mem);
> +       if (IS_ERR(adc->seq_regs)) {
> +               ret = PTR_ERR(adc->seq_regs);
> +               goto err_iio;
> +       }
> +
> +       mem = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +               "sample_store_csr");
> +       adc->sample_regs = devm_ioremap_resource(&pdev->dev, mem);
> +       if (IS_ERR(adc->sample_regs)) {
> +               ret = PTR_ERR(adc->sample_regs);
> +               goto err_iio;
> +       }
> +
> +       ret = alt_modular_adc_parse_dt(indio_dev, &pdev->dev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed to parse device tree\n");
> +               goto err_iio;
> +       }
> +
> +       ret = alt_modular_adc_channel_init(indio_dev);
> +       if (ret < 0) {
> +               dev_err(&pdev->dev, "failed initialize ADC channels\n");
> +               goto err_iio;
> +       }
> +
> +       platform_set_drvdata(pdev, indio_dev);
> +
> +       indio_dev->name = dev_name(&pdev->dev);
> +       indio_dev->dev.parent = &pdev->dev;
> +       indio_dev->dev.of_node = pdev->dev.of_node;
> +       indio_dev->info = &adc_iio_info;
> +       indio_dev->modes = INDIO_DIRECT_MODE;
> +       indio_dev->num_channels = adc->slot_count;
> +
> +       ret = iio_device_register(indio_dev);
> +       if (ret)
> +               goto err_iio;
> +
> +       /* Disable Interrupt */
> +       writel_relaxed(0, (adc->sample_regs + ADC_IER_REG));

Why disable interrupts?

> +
> +       /* Start Continuous Sampling */
> +       writel_relaxed((ADC_RUN_MSK), (adc->seq_regs + ADC_CMD_REG));
> +
> +       return 0;
> +
> +
> +err_iio:
> +       iio_device_free(indio_dev);
> +       return ret;
> +}
> +
> +static int alt_modular_adc_remove(struct platform_device *pdev)
> +{
> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +       struct altera_adc *adc = iio_priv(indio_dev);
> +
> +       /* Stop ADC */
> +       writel((ADC_STOP_MSK), (adc->seq_regs + ADC_CMD_REG));
> +
> +       /* Unregister ADC */
> +       iio_device_unregister(indio_dev);
> +
> +       return 0;
> +}
> +
> +static struct platform_driver altr_modular_adc_driver = {
> +       .probe          = alt_modular_adc_probe,
> +       .remove         = alt_modular_adc_remove,
> +       .driver         = {
> +               .name   = "alt-modular-adc",
> +               .owner  = THIS_MODULE,
> +               .of_match_table = alt_modular_adc_match,
> +       },
> +};
> +
> +
> +module_platform_driver(altr_modular_adc_driver);
> +
> +MODULE_DESCRIPTION("Altera Modular ADC Driver");
> +MODULE_AUTHOR("Chee Nouk Phoon <cnphoon@altera.com>");
> +MODULE_LICENSE("GPL v2");
> --
> 1.7.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
