Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43539 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752100AbaBOK2P (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Feb 2014 05:28:15 -0500
Message-ID: <52FF4160.8010909@kernel.org>
Date: Sat, 15 Feb 2014 10:28:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Fugang Duan <B38611@freescale.com>
CC: shawn.guo@linaro.org, sachin.kamat@linaro.org, pmeerw@pmeerw.net,
	lars@metafoo.de, mark.rutland@arm.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 2/3] iio:adc:imx: add Freescale Vybrid vf610 adc driver
References: <1390714773-23066-1-git-send-email-B38611@freescale.com> <1390714773-23066-3-git-send-email-B38611@freescale.com> <52FF3EEA.30606@kernel.org>
In-Reply-To: <52FF3EEA.30606@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/02/14 10:18, Jonathan Cameron wrote:
> On 26/01/14 05:39, Fugang Duan wrote:
>> Add Freescale Vybrid vf610 adc driver. The driver only support
>> ADC software trigger.
>>
>> VF610 ADC device documentation is available at below reference manual
>> (chapter 37):
>> http://cache.freescale.com/files/32bit/doc/ref_manual/VYBRIDRM.pdf?
>> fpsp=1&WT_TYPE=Reference%20Manuals&WT_VENDOR=FREESCALE&WT_FILE_FORMAT
>> =pdf&WT_ASSET=Documentation
>>
>> CC: Shawn Guo <shawn.guo@linaro.org>
>> CC: Jonathan Cameron <jic23@kernel.org>
>> CC: Mark Rutland <mark.rutland@arm.com>
>> CC: Otavio Salvador <otavio@ossystems.com.br>
>> CC: Peter Meerwald <pmeerw@pmeerw.net>
>> CC: Lars-Peter Clausen <lars@metafoo.de>
>> Signed-off-by: Fugang Duan <B38611@freescale.com>
>
> I very much like the simplified approach you have taken for this initial
> merge.  Much easier to start simple and build up to the more complex
> functionality.
>
> There was one missing mutex unlock in an error path (noted below). I have
> fixed that and applied to the togreg branch of iio.git.   This will initially
> go out as the testing branch for the autobuilders to play with it.
>
> Also devm_irq requests always make me nervous, but I think this one is fine
> so have left it alone
>
> Jonathan
As an update I also fixed up the build - see below.  One day I'll no send
out applied messages until after my local build tests have finished!

Note that it is this sort of thing that has led me to pushing out a testing
branch as that catches all the weird combinations that I don't.

>> +
>> +static const struct iio_info vf610_adc_iio_info = {
>> +    .driver_module = THIS_MODULE,
>> +    .read_raw = &vf610_read_raw,
>> +    .write_raw = &vf610_write_raw,
>> +    .debugfs_reg_access = &vf610_adc_reg_access,
>> +    .attrs = &vf610_attribute_group,
>> +};
>> +
>> +static const struct of_device_id vf610_adc_match[] = {
>> +    { .compatible = "fsl,vf610-adc", },
>> +    { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, vf610_adc_dt_ids);
Your MODULE_DEVICE_TABLE needs to take a second variable that actually exists...
Also needs to depend in the KCONFIG on OF to avoid build issues on other platforms.

I've added both.

>> +
>> +static int vf610_adc_probe(struct platform_device *pdev)
>> +{
>> +    struct vf610_adc *info;
>> +    struct iio_dev *indio_dev;
>> +    struct resource *mem;
>> +    int irq;
>> +    int ret;
>> +
>> +    indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(struct vf610_adc));
>> +    if (!indio_dev) {
>> +        dev_err(&pdev->dev, "Failed allocating iio device\n");
>> +        return -ENOMEM;
>> +    }
>> +
>> +    info = iio_priv(indio_dev);
>> +    info->dev = &pdev->dev;
>> +
>> +    mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +    info->regs = devm_ioremap_resource(&pdev->dev, mem);
>> +    if (IS_ERR(info->regs))
>> +        return PTR_ERR(info->regs);
>> +
>> +    irq = platform_get_irq(pdev, 0);
>> +    if (irq <= 0) {
>> +        dev_err(&pdev->dev, "no irq resource?\n");
>> +        return -EINVAL;
>> +    }
>> +
> Hmm. Devm requests for irqs always make me nervous.  I 'think' this one
> is fine, but it is rather too easy to use something in the handler that
> is freed via a route other than managed resources...  Still if you are sure
> then leave it be.
>> +    ret = devm_request_irq(info->dev, irq,
>> +                vf610_adc_isr, 0,
>> +                dev_name(&pdev->dev), info);
>> +    if (ret < 0) {
>> +        dev_err(&pdev->dev, "failed requesting irq, irq = %d\n", irq);
>> +        return ret;
>> +    }
>> +
>> +    info->clk = devm_clk_get(&pdev->dev, "adc");
>> +    if (IS_ERR(info->clk)) {
>> +        dev_err(&pdev->dev, "failed getting clock, err = %ld\n",
>> +                        PTR_ERR(info->clk));
>> +        ret = PTR_ERR(info->clk);
>> +        return ret;
>> +    }
>> +
>> +    info->vref = devm_regulator_get(&pdev->dev, "vref");
>> +    if (IS_ERR(info->vref))
>> +        return PTR_ERR(info->vref);
>> +
>> +    ret = regulator_enable(info->vref);
>> +    if (ret)
>> +        return ret;
>> +
>> +    info->vref_uv = regulator_get_voltage(info->vref);
>> +
>> +    platform_set_drvdata(pdev, indio_dev);
>> +
>> +    init_completion(&info->completion);
>> +
>> +    indio_dev->name = dev_name(&pdev->dev);
>> +    indio_dev->dev.parent = &pdev->dev;
>> +    indio_dev->dev.of_node = pdev->dev.of_node;
>> +    indio_dev->info = &vf610_adc_iio_info;
>> +    indio_dev->modes = INDIO_DIRECT_MODE;
>> +    indio_dev->channels = vf610_adc_iio_channels;
>> +    indio_dev->num_channels = ARRAY_SIZE(vf610_adc_iio_channels);
>> +
>> +    ret = clk_prepare_enable(info->clk);
>> +    if (ret) {
>> +        dev_err(&pdev->dev,
>> +            "Could not prepare or enable the clock.\n");
>> +        goto error_adc_clk_enable;
>> +    }
>> +
>> +    vf610_adc_cfg_init(info);
>> +    vf610_adc_hw_init(info);
>> +
>> +    ret = iio_device_register(indio_dev);
>> +    if (ret) {
>> +        dev_err(&pdev->dev, "Couldn't register the device.\n");
>> +        goto error_iio_device_register;
>> +    }
>> +
>> +    return 0;
>> +
>> +
>> +error_iio_device_register:
>> +    clk_disable_unprepare(info->clk);
>> +error_adc_clk_enable:
>> +    regulator_disable(info->vref);
>> +
>> +    return ret;
>> +}
>> +
>> +static int vf610_adc_remove(struct platform_device *pdev)
>> +{
>> +    struct iio_dev *indio_dev = platform_get_drvdata(pdev);
>> +    struct vf610_adc *info = iio_priv(indio_dev);
>> +
>> +    iio_device_unregister(indio_dev);
>> +    regulator_disable(info->vref);
>> +    clk_disable_unprepare(info->clk);
>> +
>> +    return 0;
>> +}
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int vf610_adc_suspend(struct device *dev)
>> +{
>> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +    struct vf610_adc *info = iio_priv(indio_dev);
>> +    int hc_cfg;
>> +
>> +    /* ADC controller enters to stop mode */
>> +    hc_cfg = readl(info->regs + VF610_REG_ADC_HC0);
>> +    hc_cfg |= VF610_ADC_CONV_DISABLE;
>> +    writel(hc_cfg, info->regs + VF610_REG_ADC_HC0);
>> +
>> +    clk_disable_unprepare(info->clk);
>> +    regulator_disable(info->vref);
>> +
>> +    return 0;
>> +}
>> +
>> +static int vf610_adc_resume(struct device *dev)
>> +{
>> +    struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +    struct vf610_adc *info = iio_priv(indio_dev);
>> +    int ret;
>> +
>> +    ret = regulator_enable(info->vref);
>> +    if (ret)
>> +        return ret;
>> +
>> +    ret = clk_prepare_enable(info->clk);
>> +    if (ret)
>> +        return ret;
>> +
>> +    vf610_adc_hw_init(info);
>> +
>> +    return 0;
>> +}
>> +#endif
>> +
>> +static SIMPLE_DEV_PM_OPS(vf610_adc_pm_ops,
>> +            vf610_adc_suspend,
>> +            vf610_adc_resume);
>> +
>> +static struct platform_driver vf610_adc_driver = {
>> +    .probe          = vf610_adc_probe,
>> +    .remove         = vf610_adc_remove,
>> +    .driver         = {
>> +        .name   = DRIVER_NAME,
>> +        .owner  = THIS_MODULE,
>> +        .of_match_table = vf610_adc_match,
>> +        .pm     = &vf610_adc_pm_ops,
>> +    },
>> +};
>> +
>> +module_platform_driver(vf610_adc_driver);
>> +
>> +MODULE_AUTHOR("Fugang Duan <B38611@freescale.com>");
>> +MODULE_DESCRIPTION("Freescale VF610 ADC driver");
>> +MODULE_LICENSE("GPL v2");
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

