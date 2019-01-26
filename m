Return-Path: <SRS0=WfKE=QC=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A00D7C282C7
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 23:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540D1218CD
	for <linux-iio@archiver.kernel.org>; Sat, 26 Jan 2019 23:39:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=martingkelly-com.20150623.gappssmtp.com header.i=@martingkelly-com.20150623.gappssmtp.com header.b="yHR8wXSs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbfAZXjT (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sat, 26 Jan 2019 18:39:19 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33512 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbfAZXjT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Jan 2019 18:39:19 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so6147091plo.0
        for <linux-iio@vger.kernel.org>; Sat, 26 Jan 2019 15:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=martingkelly-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WR28k8cgXZW+QEHyIv/ms3YvzICjPM3jDpOZoBJgEuQ=;
        b=yHR8wXSsMQo8eEavkJ9G4IO1CcxUnJUGfITORkIBJli8f3TclyIvEXMZv4+DDO2Gjx
         4LjJl7QoC32VtoSdV4qUKH5xuajpQ91mI1WwdMO5wdsJcrnmFohp8Z/dyTcAiJF0YjsQ
         toBKM8+8MNh7HmWwFgcvaW88Lq3bqk9/V6/vqWN/PWGS2KPPFb0wdx2G1j6yPuezJtoJ
         LugDdLrDHSVYoaWoUY57DyjFlWlW9EWIG7PW4/64Bd8vMW1RwoksO1MGUt4DTF/aF3J3
         gZo2wopjSV2G2M/CideQzKi9vFPh/h+gc+9Rhp43q1ql/6fZ7/mxTAvDL4Qy6/iSIyJu
         qO0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WR28k8cgXZW+QEHyIv/ms3YvzICjPM3jDpOZoBJgEuQ=;
        b=Kwh7V0YBa63V6tS6KdI2wxogA178K2DpdPqCqJ+vYdTiKvF76/x/cB/HMdluIUkymK
         7ObWh0H1c4EgNGLMRJevUzxUT9eDw0S5uMpKBXctUshlfQT/Fm3G2h8rf06lAO0WBy8x
         VjuB5492a086Y6LYdGk8WHQhZ939xg2I7darV0uub2HxakY8qbQ3qpzf3idgsPmiItX5
         iM3D4GxowuKsJb4PK5r7Zf12/WRbvp6jfUrTkDmehwO+XKuOGAJNF8WLngpAMVNQy6L3
         cVVtzmniDLs8O/oRC+H9wBs5u/HwwGGiBYC6tA3V5tYTRKRGKgxsngGeTJxwy+L4GRTL
         IJKw==
X-Gm-Message-State: AJcUukc9szNx7dMx/HDBOLd5qJa7L9o+WnwRN5UibYgEEjcYfNYwvJHt
        qcwdTLyjsiy6CfYVIg60Fm/Slg==
X-Google-Smtp-Source: ALg8bN55aEtTMZuSKZEpVYM9tj/Ss8seZuwbmo4ZefToVMvtwEUsiPdllwJnt3bsylWU6nq+Gt5W+w==
X-Received: by 2002:a17:902:6113:: with SMTP id t19mr16049231plj.248.1548545958359;
        Sat, 26 Jan 2019 15:39:18 -0800 (PST)
Received: from [192.168.0.8] (174-21-177-9.tukw.qwest.net. [174.21.177.9])
        by smtp.gmail.com with ESMTPSA id y184sm54324450pgd.71.2019.01.26.15.39.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Jan 2019 15:39:17 -0800 (PST)
Subject: Re: [PATCH v2 2/6] iio:bmi160: add drdy interrupt support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Baluta <daniel.baluta@gmail.com>,
        devicetree@vger.kernel.org
References: <20190122020431.5338-1-martin@martingkelly.com>
 <20190122020431.5338-2-martin@martingkelly.com>
 <20190126201756.12faa7bb@archlinux>
From:   Martin Kelly <martin@martingkelly.com>
Message-ID: <afe5de11-54b7-dbcf-defc-cfa6e8f121db@martingkelly.com>
Date:   Sat, 26 Jan 2019 15:39:16 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190126201756.12faa7bb@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 1/26/19 12:17 PM, Jonathan Cameron wrote:
> On Mon, 21 Jan 2019 18:04:27 -0800
> Martin Kelly <martin@martingkelly.com> wrote:
> 
>> From: Martin Kelly <martin@martingkelly.com>
>>
>> Add interrupt support for the data ready signal on the BMI160, which fires
>> an interrupt whenever new accelerometer/gyroscope data is ready to read.
>>
>> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> 
> Various minor bits inline.  I would also, if possible like Daniel to
> take a glance at this series before we apply it. I don't know this hardware
> at all well!
> 
> Jonathan
> 
>> ---
>> v2:
>> - Drop "BOTH" interrupt setting.
>> - Change to "if (ret)" instead of "if (ret < 0)".
>> - Stylistic changes suggested by Jonathan Cameron.
>> - Fix bogus return check after iio_trigger_get.
>>
>>   arch/arm/boot/dts/Makefile           |   1 +
>>   drivers/iio/imu/bmi160/bmi160.h      |  13 +-
>>   drivers/iio/imu/bmi160/bmi160_core.c | 294 ++++++++++++++++++++++++++++++++++-
>>   drivers/iio/imu/bmi160/bmi160_i2c.c  |   3 +-
>>   drivers/iio/imu/bmi160/bmi160_spi.c  |   2 +-
>>   5 files changed, 303 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index b0e966d625b9..df68910fc2c1 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -701,6 +701,7 @@ dtb-$(CONFIG_SOC_AM33XX) += \
>>   	am335x-base0033.dtb \
>>   	am335x-bone.dtb \
>>   	am335x-boneblack.dtb \
>> +	am335x-boneblack-bmi160-i2c1.dtb \
> 
> Separate patch for this.
> 

Oops, this wasn't intended to be there at all; it's an accidental 
carry-over from my testing that should not be checked in. I'll remove it.

>>   	am335x-boneblack-wireless.dtb \
>>   	am335x-boneblue.dtb \
>>   	am335x-bonegreen.dtb \
>> diff --git a/drivers/iio/imu/bmi160/bmi160.h b/drivers/iio/imu/bmi160/bmi160.h
>> index 2351049d930b..0c5e67e0d35b 100644
>> --- a/drivers/iio/imu/bmi160/bmi160.h
>> +++ b/drivers/iio/imu/bmi160/bmi160.h
>> @@ -2,9 +2,20 @@
>>   #ifndef BMI160_H_
>>   #define BMI160_H_
>>
>> +#include <linux/iio/iio.h>
>> +
>> +struct bmi160_data {
>> +	struct regmap *regmap;
>> +	struct iio_trigger *trig;
>> +};
>> +
>>   extern const struct regmap_config bmi160_regmap_config;
>>
>>   int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>> -		      const char *name, bool use_spi);
>> +		      const char *name, bool use_spi, int irq);
>> +
>> +int bmi160_enable_irq(struct regmap *regmap, bool enable);
>> +
>> +int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type);
>>
>>   #endif  /* BMI160_H_ */
>> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
>> index ce61026d84c3..c848fc1bce61 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_core.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
>> @@ -3,21 +3,25 @@
>>    * BMI160 - Bosch IMU (accel, gyro plus external magnetometer)
>>    *
>>    * Copyright (c) 2016, Intel Corporation.
>> + * Copyright (c) 2019, Martin Kelly.
>>    *
>>    * IIO core driver for BMI160, with support for I2C/SPI busses
>>    *
>> - * TODO: magnetometer, interrupts, hardware FIFO
>> + * TODO: magnetometer, hardware FIFO
>>    */
>>   #include <linux/module.h>
>>   #include <linux/regmap.h>
>>   #include <linux/acpi.h>
>>   #include <linux/delay.h>
>> +#include <linux/irq.h>
>> +#include <linux/of_irq.h>
>>
>>   #include <linux/iio/iio.h>
>>   #include <linux/iio/triggered_buffer.h>
>>   #include <linux/iio/trigger_consumer.h>
>>   #include <linux/iio/buffer.h>
>>   #include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>>
>>   #include "bmi160.h"
>>
>> @@ -61,8 +65,32 @@
>>   #define BMI160_CMD_GYRO_PM_FAST_STARTUP	0x17
>>   #define BMI160_CMD_SOFTRESET		0xB6
>>
>> +#define BMI160_REG_INT_EN		0x51
>> +#define BMI160_DRDY_INT_EN		BIT(4)
>> +
>> +#define BMI160_REG_INT_OUT_CTRL		0x53
>> +#define BMI160_INT_OUT_CTRL_MASK	0x0f
>> +#define BMI160_INT1_OUT_CTRL_SHIFT	0
>> +#define BMI160_INT2_OUT_CTRL_SHIFT	4
>> +#define BMI160_LEVEL_TRIGGERED		BIT(0)
>> +#define BMI160_ACTIVE_HIGH		BIT(1)
>> +#define BMI160_OPEN_DRAIN		BIT(2)
>> +#define BMI160_OUTPUT_EN		BIT(3)
>> +
>> +#define BMI160_REG_INT_LATCH		0x54
>> +#define BMI160_INT1_LATCH_MASK		BIT(4)
>> +#define BMI160_INT2_LATCH_MASK		BIT(5)
>> +
>> +/* INT1 and INT2 are in the opposite order as in INT_OUT_CTRL! */
>> +#define BMI160_REG_INT_MAP		0x56
>> +#define BMI160_INT1_MAP_DRDY_EN		0x80
>> +#define BMI160_INT2_MAP_DRDY_EN		0x08
>> +
>>   #define BMI160_REG_DUMMY		0x7F
>>
>> +#define BMI160_NORMAL_WRITE_USLEEP	2
>> +#define BMI160_SUSPENDED_WRITE_USLEEP	450
>> +
>>   #define BMI160_ACCEL_PMU_MIN_USLEEP	3800
>>   #define BMI160_GYRO_PMU_MIN_USLEEP	80000
>>   #define BMI160_SOFTRESET_USLEEP		1000
>> @@ -105,8 +133,9 @@ enum bmi160_sensor_type {
>>   	BMI160_NUM_SENSORS /* must be last */
>>   };
>>
>> -struct bmi160_data {
>> -	struct regmap *regmap;
>> +enum bmi160_int_pin {
>> +	BMI160_PIN_INT1,
>> +	BMI160_PIN_INT2
>>   };
>>
>>   const struct regmap_config bmi160_regmap_config = {
>> @@ -495,7 +524,209 @@ static const char *bmi160_match_acpi_device(struct device *dev)
>>   	return dev_name(dev);
>>   }
>>
>> -static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>> +static int bmi160_write_conf_reg(struct regmap *regmap, unsigned int reg,
>> +				 unsigned int mask, unsigned int bits,
>> +				 unsigned int write_usleep)
>> +{
>> +	int ret;
>> +	unsigned int val;
>> +
>> +	ret = regmap_read(regmap, reg, &val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	val = (val & ~mask) | bits;
>> +
>> +	ret = regmap_write(regmap, reg, val);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * We need to wait after writing before we can write again. See the
>> +	 * datasheet, page 93.
>> +	 */
>> +	usleep_range(write_usleep, write_usleep + 1000);
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi160_config_pin(struct regmap *regmap, enum bmi160_int_pin pin,
>> +				bool open_drain, u8 irq_mask,
>> +				unsigned long write_usleep)
>> +{
>> +	int ret;
>> +	u8 int_out_ctrl_shift;
>> +	u8 int_latch_mask;
>> +	u8 int_map_mask;
>> +	u8 int_out_ctrl_mask;
>> +	u8 int_out_ctrl_bits;
>> +
>> +	switch (pin) {
>> +	case BMI160_PIN_INT1:
>> +		int_out_ctrl_shift = BMI160_INT1_OUT_CTRL_SHIFT;
>> +		int_latch_mask = BMI160_INT1_LATCH_MASK;
>> +		int_map_mask = BMI160_INT1_MAP_DRDY_EN;
>> +		break;
>> +	case BMI160_PIN_INT2:
>> +		int_out_ctrl_shift = BMI160_INT2_OUT_CTRL_SHIFT;
>> +		int_latch_mask = BMI160_INT2_LATCH_MASK;
>> +		int_map_mask = BMI160_INT2_MAP_DRDY_EN;
>> +		break;
>> +	}
>> +	int_out_ctrl_mask = BMI160_INT_OUT_CTRL_MASK << int_out_ctrl_shift;
>> +
>> +	/*
>> +	 * Enable the requested pin with the right settings:
>> +	 * - Push-pull/open-drain
>> +	 * - Active low/high
>> +	 * - Edge/level triggered
>> +	 */
>> +	int_out_ctrl_bits = BMI160_OUTPUT_EN;
>> +	if (open_drain)
>> +		/* Default is push-pull. */
>> +		int_out_ctrl_bits |= BMI160_OPEN_DRAIN;
>> +	int_out_ctrl_bits |= irq_mask;
>> +	int_out_ctrl_bits <<= int_out_ctrl_shift;
>> +
>> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_OUT_CTRL,
>> +				    int_out_ctrl_mask, int_out_ctrl_bits,
>> +				    write_usleep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Set the pin to input mode with no latching. */
>> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_LATCH,
>> +				    int_latch_mask, int_latch_mask,
>> +				    write_usleep);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Map interrupts to the requested pin. */
>> +	ret = bmi160_write_conf_reg(regmap, BMI160_REG_INT_MAP,
>> +				    int_map_mask, int_map_mask,
>> +				    write_usleep);
>> +	if (ret)
>> +		return ret;
> return bmi160...
>> +
>> +	return 0;
>> +}
>> +
>> +int bmi160_enable_irq(struct regmap *regmap, bool enable)
>> +{
>> +	unsigned int enable_bit = 0;
>> +
>> +	if (enable)
>> +		enable_bit = BMI160_DRDY_INT_EN;
>> +
>> +	return bmi160_write_conf_reg(regmap, BMI160_REG_INT_EN,
>> +				     BMI160_DRDY_INT_EN, enable_bit,
>> +				     BMI160_NORMAL_WRITE_USLEEP);
>> +}
>> +EXPORT_SYMBOL(bmi160_enable_irq);
>> +
>> +static bool bmi160_parse_irqname(struct device_node *of_node, int irq,
>> +				 enum bmi160_int_pin *pin)
>> +{
>> +	int ret;
>> +
>> +	/* of_irq_get_byname returns the IRQ number if the entry is found. */
>> +	ret = of_irq_get_byname(of_node, "INT1");
>> +	if (ret == irq) {
>> +		*pin = BMI160_PIN_INT1;
>> +		return true;
>> +	}
> 
> Given both could be provided, and we are implying a preference,
> why not just get INT1 first by name and if it's not there try for
> INT2?  No need for this separate does the name match query.
> 

I actually didn't mean to imply a preference; I just figured that a 
given IRQ can have only one name, and therefore at most one of the names 
"INT1" and "INT2" will match the passed-in IRQ. Is this a bad assumption?

>> +
>> +	ret = of_irq_get_byname(of_node, "INT2");
>> +	if (ret == irq) {
>> +		*pin = BMI160_PIN_INT2;
>> +		return true;
>> +	}
>> +
>> +	return false;
>> +}
>> +
>> +static int bmi160_config_device_irq(struct iio_dev *indio_dev,
>> +				    int irq, int irq_type)
>> +{
>> +	int ret;
>> +	bool success;
>> +	enum bmi160_int_pin int_pin;
>> +	bool open_drain;
>> +	const char *pin_name;
>> +	u8 irq_mask;
>> +	struct bmi160_data *data = iio_priv(indio_dev);
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +
>> +	/* Edge-triggered, active-low is the default if we set all zeroes. */
>> +	if (irq_type == IRQF_TRIGGER_RISING)
>> +		irq_mask = BMI160_ACTIVE_HIGH | BMI160_LEVEL_TRIGGERED;
> 
> That seems unlikely.  Why on a rising trigger are we setting a flag
> that is named to imply it sets level triggering?
> 

I will double-check the datasheet, but I think this is a mistake and I 
should swap the RISING and HIGH cases.

>> +	else if (irq_type == IRQF_TRIGGER_FALLING)
>> +		irq_mask = BMI160_LEVEL_TRIGGERED;
>> +	else if (irq_type == IRQF_TRIGGER_HIGH)
>> +		irq_mask = BMI160_ACTIVE_HIGH;
>> +	else if (irq_type == IRQF_TRIGGER_LOW)
>> +		irq_mask = 0;
>> +	else {
>> +		dev_err(&indio_dev->dev,
>> +			"Invalid interrupt type 0x%x specified\n", irq_type);
>> +		return -EINVAL;
>> +	}
>> +
>> +	success = bmi160_parse_irqname(dev->of_node, irq, &int_pin);
>> +	if (!success) {
>> +		dev_err(&indio_dev->dev,
>> +			"interrupt-names for IRQ %d must be set to either \"INT1\" or \"INT2\"",
>> +			irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	open_drain = of_property_read_bool(dev->of_node, "bmi160,open-drain");
>> +
>> +	ret = bmi160_config_pin(data->regmap, int_pin, open_drain, irq_mask,
>> +				BMI160_NORMAL_WRITE_USLEEP);
>> +	if (ret) {
>> +		switch (int_pin) {
>> +		case BMI160_PIN_INT1:
>> +			pin_name = "INT1";
>> +			break;
>> +		case BMI160_PIN_INT2:
>> +			pin_name = "INT2";
>> +			break;
>> +		}
>> +		dev_err(&indio_dev->dev, "Failed to configure %s IRQ pin",
>> +			pin_name);
> 
> Why not do that within bmi160_config_pin?  Then we have
> return bmi160_config_pin..
> 

Yeah, I'll move this into bmi160_config_pin.

>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi160_setup_irq(struct iio_dev *indio_dev, int irq)
>> +{
>> +	struct irq_data *desc;
>> +	u32 irq_type;
>> +	int ret;
>> +
>> +	desc = irq_get_irq_data(irq);
>> +	if (!desc) {
>> +		dev_warn(&indio_dev->dev, "Could not find IRQ %d\n", irq);
>> +		return -EINVAL;
>> +	}
>> +
>> +	irq_type = irqd_get_trigger_type(desc);
>> +
>> +	ret = bmi160_config_device_irq(indio_dev, irq, irq_type);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = bmi160_probe_trigger(indio_dev, irq, irq_type);
>> +	if (ret)
>> +		return ret;
> 
> return bmi160_probe_trigger...  It's either zero or it's not.
> Either way this gives the same as you have here.
> 
>> +
>> +	return 0;
>> +}
>> +
>> +static int bmi160_chip_init(struct bmi160_data *data, bool use_spi, int irq)
>>   {
>>   	int ret;
>>   	unsigned int val;
>> @@ -518,7 +749,7 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>>   	}
>>
>>   	ret = regmap_read(data->regmap, BMI160_REG_CHIP_ID, &val);
>> -	if (ret < 0) {
>> +	if (ret) {
> 
> This should be a separate patch, not rolled in here.  It's
> a good cleanup but within this patch it's noise.
> 

Good catch, I tried to separate the cleanup changes but I missed this 
one. I will move it.

>>   		dev_err(dev, "Error reading chip id\n");
>>   		return ret;
>>   	}
>> @@ -539,6 +770,49 @@ static int bmi160_chip_init(struct bmi160_data *data, bool use_spi)
>>   	return 0;
>>   }
>>
>> +static int bmi160_data_rdy_trigger_set_state(struct iio_trigger *trig,
>> +					     bool enable)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct bmi160_data *data = iio_priv(indio_dev);
>> +
>> +	return bmi160_enable_irq(data->regmap, enable);
>> +}
>> +
>> +static const struct iio_trigger_ops bmi160_trigger_ops = {
>> +	.set_trigger_state = &bmi160_data_rdy_trigger_set_state,
>> +};
>> +
>> +int bmi160_probe_trigger(struct iio_dev *indio_dev, int irq, u32 irq_type)
>> +{
>> +	struct bmi160_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	data->trig = devm_iio_trigger_alloc(&indio_dev->dev, "%s-dev%d",
>> +					    indio_dev->name, indio_dev->id);
>> +
>> +	if (data->trig == NULL)
>> +		return -ENOMEM;
>> +
>> +	ret = devm_request_irq(&indio_dev->dev, irq,
>> +			       &iio_trigger_generic_data_rdy_poll,
>> +			       irq_type, "bmi160", data->trig);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	data->trig->dev.parent = regmap_get_device(data->regmap);
>> +	data->trig->ops = &bmi160_trigger_ops;
>> +	iio_trigger_set_drvdata(data->trig, indio_dev);
>> +
>> +	ret = devm_iio_trigger_register(&indio_dev->dev, data->trig);
>> +	if (ret)
>> +		return ret;
>> +
>> +	indio_dev->trig = iio_trigger_get(data->trig);
>> +
>> +	return 0;
>> +}
>> +
>>   static void bmi160_chip_uninit(void *data)
>>   {
>>   	struct bmi160_data *bmi_data = data;
>> @@ -548,7 +822,7 @@ static void bmi160_chip_uninit(void *data)
>>   }
>>
>>   int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>> -		      const char *name, bool use_spi)
>> +		      const char *name, bool use_spi, int irq)
>>   {
>>   	struct iio_dev *indio_dev;
>>   	struct bmi160_data *data;
>> @@ -562,7 +836,7 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>>   	dev_set_drvdata(dev, indio_dev);
>>   	data->regmap = regmap;
>>
>> -	ret = bmi160_chip_init(data, use_spi);
>> +	ret = bmi160_chip_init(data, use_spi, irq);
>>   	if (ret < 0)
>>   		return ret;
>>
>> @@ -585,6 +859,12 @@ int bmi160_core_probe(struct device *dev, struct regmap *regmap,
>>   	if (ret < 0)
>>   		return ret;
>>
>> +	if (irq) {
>> +		ret = bmi160_setup_irq(indio_dev, irq);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>>   	ret = devm_iio_device_register(dev, indio_dev);
>>   	if (ret < 0)
>>   		return ret;
>> diff --git a/drivers/iio/imu/bmi160/bmi160_i2c.c b/drivers/iio/imu/bmi160/bmi160_i2c.c
>> index e36f5e82d400..98467d73c887 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_i2c.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_i2c.c
>> @@ -32,7 +32,8 @@ static int bmi160_i2c_probe(struct i2c_client *client,
>>   	if (id)
>>   		name = id->name;
>>
>> -	return bmi160_core_probe(&client->dev, regmap, name, false);
>> +	return bmi160_core_probe(&client->dev, regmap,
>> +				 name, false, client->irq);
>>   }
>>
>>   static const struct i2c_device_id bmi160_i2c_id[] = {
>> diff --git a/drivers/iio/imu/bmi160/bmi160_spi.c b/drivers/iio/imu/bmi160/bmi160_spi.c
>> index c19e3df35559..23e323518873 100644
>> --- a/drivers/iio/imu/bmi160/bmi160_spi.c
>> +++ b/drivers/iio/imu/bmi160/bmi160_spi.c
>> @@ -24,7 +24,7 @@ static int bmi160_spi_probe(struct spi_device *spi)
>>   			(int)PTR_ERR(regmap));
>>   		return PTR_ERR(regmap);
>>   	}
>> -	return bmi160_core_probe(&spi->dev, regmap, id->name, true);
>> +	return bmi160_core_probe(&spi->dev, regmap, id->name, true, spi->irq);
>>   }
>>
>>   static const struct spi_device_id bmi160_spi_id[] = {
>> --
>> 2.11.0
>>
> 

