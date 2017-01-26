Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53490 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdAZNc1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 26 Jan 2017 08:32:27 -0500
Subject: Re: [PATCH 08/22] power: supply: add AC power supply driver for
 AXP20X and AXP22X PMICs
To: Sebastian Reichel <sre@kernel.org>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-9-quentin.schulz@free-electrons.com>
 <20170117030013.g5xhlmrxpthyfewa@earth>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, linux@armlinux.org.uk,
        maxime.ripard@free-electrons.com, lee.jones@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        thomas.petazzoni@free-electrons.com, icenowy@aosc.xyz,
        bonbons@linux-vserver.org
From: Quentin Schulz <quentin.schulz@free-electrons.com>
Message-ID: <6a3edb64-8ea9-cb14-b826-d6e8e2c4c4b7@free-electrons.com>
Date: Thu, 26 Jan 2017 14:32:21 +0100
MIME-Version: 1.0
In-Reply-To: <20170117030013.g5xhlmrxpthyfewa@earth>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Sebastian,

On 17/01/2017 04:00, Sebastian Reichel wrote:
> Hi Quentin,
> 
> The driver looks mostly fine. I do have a two comments, though.
> 
> On Mon, Jan 02, 2017 at 05:37:08PM +0100, Quentin Schulz wrote:
>> [...]
>>
>> +static int axp20x_ac_power_probe(struct platform_device *pdev)
>> +{
>> +	static const char * const axp20x_irq_names[] = { "ACIN_PLUGIN",
>> +		"ACIN_REMOVAL", NULL };
>>
>> +	static const char * const *irq_names;
>> +	const struct power_supply_desc *ac_power_desc;
>> +	int i, irq, ret;
>> +
>> +	if (!of_device_is_available(pdev->dev.of_node))
>> +		return -ENODEV;
>> +
>> +	if (!axp20x) {
>> +		dev_err(&pdev->dev, "Parent drvdata not set\n");
>> +		return -EINVAL;
>> +	}
> 
> axp20x will no longer be needed after implementing below
> comments.
> 
>> [...]
>> +	irq_names = axp20x_irq_names;
> 
> Just rename axp20x_irq_names into irq_names, since its only used
> here.
> 
>> [...]
>>
>> +	power->np = pdev->dev.of_node;
> 
> This can be dropped, it's not used at all.
> 
>> +	power->regmap = axp20x->regmap;
> 
> power->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> 

ACK on everything above.

>> [...]
>> +	/* Request irqs after registering, as irqs may trigger immediately */
>> +	for (i = 0; irq_names[i]; i++) {
>> +		irq = platform_get_irq_byname(pdev, irq_names[i]);
>> +		if (irq < 0) {
>> +			dev_warn(&pdev->dev, "No IRQ for %s: %d\n",
>> +				 irq_names[i], irq);
>> +			continue;
>> +		}
>> +		irq = regmap_irq_get_virq(axp20x->regmap_irqc, irq);
> 
> The mapping should actually happen in the mfd driver, so that
> the platform resource contains a valid irq.
> 

I've come with this solution:

------------------------------------------------------------------------
diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 012c064..117eacb 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -882,7 +882,7 @@ EXPORT_SYMBOL(axp20x_match_device);

 int axp20x_device_probe(struct axp20x_dev *axp20x)
 {
-	int ret;
+	int ret, irq_base;

 	ret = regmap_add_irq_chip(axp20x->regmap, axp20x->irq,
 				  IRQF_ONESHOT | IRQF_SHARED, -1,
@@ -893,8 +893,9 @@ int axp20x_device_probe(struct axp20x_dev *axp20x)
 		return ret;
 	}

+	irq_base = regmap_irq_chip_get_base(axp20x->regmap_irqc);
 	ret = mfd_add_devices(axp20x->dev, -1, axp20x->cells,
-			      axp20x->nr_cells, NULL, 0, NULL);
+			      axp20x->nr_cells, NULL, irq_base, NULL);

 	if (ret) {
 		dev_err(axp20x->dev, "failed to add MFD devices: %d\n", ret);
------------------------------------------------------------------------

However, this implies that all cells added by the mfd driver which are
requesting irqs will need to be changed in the same commit to remove the
regmap_irq_get_virq calls. If we don't modify the drivers, they will
purely fail to request the irqs.

The impacted drivers are the following:

 - drivers/extcon/extcon-axp288.c
 - drivers/input/misc/axp20x-pek.c
 - drivers/power/supply/axp20x_usb_power.c
 - drivers/power/supply/axp288_charger.c
 - drivers/power/supply/axp288_fuel_gauge.c

Is it really worth to do such a cleanup? I'm assuming that impacting
four different subsystems at the same time might require a bit of time
to make the patch into the kernel. I don't see also another way than
doing one single patch for all changes since the changes in the mfd
driver will break all aforementioned drivers.

Thanks,
Quentin

-- 
Quentin Schulz, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
