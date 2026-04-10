Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC828A3F8
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 22:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775859718; cv=none; b=JhIwSD3Ryt3U/8dP/Wz2EhF4G+EOYSLsd4qs9wdmMH3+ahzG6qLltGg0Wmfk/nLsMiHv3GAtv+zhwryXw5+lMm7tdJfmsrH2SBygfZpuuFzO1wv04KNft+Xr7tf+gclwcPMcO3CmWHv6qhxCs0bLUlXLpQHboWf2o7buBjFQ1kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775859718; c=relaxed/simple;
	bh=8JVRFGzQ5NNWLtUBBdZGD57hu8qR9ibTQts9tz3mecg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5TBaU/Q3hO2D14/Id7JudVQlRf4DOr+5IcBuenbn/1f7YZvR6KFQMvNj1nNXpRGsHXC1c9KxAo4Ozb1K0eKI8VJkYHO0VyXBLnfrjxdsPKUVb7XybURvAb6Hw0wDYkUeXCXLkE0G9hlLyUdy449W3oTomB3v189utuJLNVfzUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=JeD2FGj6; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="JeD2FGj6"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d9bba96f7dso1415750a34.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 15:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775859714; x=1776464514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SsVW3RunaT7CXICWyhIRNRbEGIyTnfeR0pi5Qn2NLII=;
        b=JeD2FGj6m6pjKMlXUgcCbh7uu1CsxuuC34wPA2K8STwhBc3iFjQbBkRjX7ZF4AXhW0
         XJ8TYS77VQbkCU/clr9ZXVws429inY4DMtknTeQB6bK9hTsk2yPQin3onq/M5aKigZA5
         qtOjV/2PEsGsp9UGYCnkdOjVD/egi5+Wmu5n+F+4xSg05fs2ZdW3udU8N1e2j/vQb05y
         ukvMdOQzgkhjaO+bvAbDz/C8/KnE3/NPEMe4sY3wi8SQ3ZwKmjbLaiLfINLPd07LvcUR
         ZNwwSmgaAxBVUZYKHKOdN77vR7k75J+GsFufEnARW938uxSu3NukTjhOTwWeAYwWEq2E
         2/JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775859714; x=1776464514;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SsVW3RunaT7CXICWyhIRNRbEGIyTnfeR0pi5Qn2NLII=;
        b=IombdoIirYZLz/sEDtB9XvNGw2IfMzGbkgL0mGQq0Pxi7yYokRMHrRHrfhzmg9TK+o
         QhbimQm1zhPps2tjj8hQrymcaVyhfq0mRnhVnBxUVKHPAAWQIB+Sot3adFeobG2whf+T
         91LeD8OOlj4OZCMfOhE6wAGfB53sszCNAFYM++SluVF0mTnLeoeJLPVeXYbL2IzyHTfd
         Q0NQf1+f+DfGB414KyXhpmaHV3VP558XaJZIHnui1lpEEbJUU5o5n45j3J/z1cP+PynC
         NReP7GB925B4OQk2sZKhr/soVGbPUYkwyXDl+jRnhUgGRXaXagFkTdBv/ENm6iHfyQh4
         GE9w==
X-Forwarded-Encrypted: i=1; AJvYcCWrIdq27BPNnIJfX1EdAvrbfjUZxZ5ESxp1gWrk/nhnNwNmxER8vd5YGDbsXQhOT0RCNhfzIxbEH0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8fgCiFZZ9nNhQRIysoEEfe6l2MbkjWgTBoSz5qPTHPTQbVsEM
	Vf9FHEizs8JkbnCFqMUBR8QuU7SIeALZMnHkoRwrmHLvBZtAKwsLIXTnMRw4taucPuY=
X-Gm-Gg: AeBDievnW17jNnAmimJH/hDC5IRSf/PiK/teDZa66O9es78v/bcRfXfE9YOTgwe11ij
	fazUqO7CTQhwkyLNSHTahF+L73cTQ+rRYyLzjtTBYJUGZJgsuJtiKXU8/zFhpPtQHr2rHd2ko8e
	2HDRxD5tnl++W57ZBZa1QAjjCErHvfoJVDdgMxVnuI8UcGoUqTbGc5rtV5hyfeWuwzYbQyZGYvs
	h6nMisoWNzyGhamkW81mX+A+ODhunVVzfOv5UOau9RiCAxqKbGJeUyBPWEOv97AK1p1+8PxSOn5
	v90T1EjOKv/NxuzHxqLRi/f/5zIHlZdr/p9CF2rTPG7HTHt9d5nM4l+MbjjDmFoaz+/8ENGgr6h
	yIJtffveGkuxSEHYoADil3fqEREPosYUypIiF0e7BSAZi1FoO+ZQSiijSWkPLbnL4c8lXVmIZNV
	MdTb474fkRzt1YS2xl89nehOXDygzVJ1YUSJUYRCNZKRHiCQvLvsirKNjME4+En4P2seeGRIKIt
	A==
X-Received: by 2002:a05:6830:4123:b0:7d7:4ee9:c39a with SMTP id 46e09a7af769-7dc27c59836mr3114877a34.4.1775859713715;
        Fri, 10 Apr 2026 15:21:53 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc2696532bsm2805612a34.21.2026.04.10.15.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:21:53 -0700 (PDT)
Message-ID: <a68ad9a0-858e-41a6-a265-b5c46193cd26@baylibre.com>
Date: Fri, 10 Apr 2026 17:21:52 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 3/9] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-4-macroalpha82@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260330195853.392877-4-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 2:58 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.

> Include runtime power management on each device.

Power management seems unrelated, so likey belongs in a separate patch.

> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>  drivers/iio/imu/inv_icm42607/inv_icm42607.h   |  14 ++
>  .../iio/imu/inv_icm42607/inv_icm42607_core.c  | 204 ++++++++++++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_i2c.c   |  93 ++++++++
>  .../iio/imu/inv_icm42607/inv_icm42607_spi.c   | 100 +++++++++
>  4 files changed, 411 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
>  create mode 100644 drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> 
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607.h b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> index 609188c40ffc..7d13091aa8df 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607.h
> @@ -11,6 +11,7 @@
>  #include <linux/regmap.h>
>  #include <linux/mutex.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pm.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/common/inv_sensors_timestamp.h>
>  
> @@ -21,6 +22,16 @@ enum inv_icm42607_chip {
>  	INV_CHIP_NB,
>  };
>  
> +/* serial bus slew rates */
> +enum inv_icm42607_slew_rate {
> +	INV_ICM42607_SLEW_RATE_20_60NS,
> +	INV_ICM42607_SLEW_RATE_12_36NS,
> +	INV_ICM42607_SLEW_RATE_6_18NS,
> +	INV_ICM42607_SLEW_RATE_4_12NS,
> +	INV_ICM42607_SLEW_RATE_2_6NS,
> +	INV_ICM42607_SLEW_RATE_INF_2NS,
> +};
> +
>  enum inv_icm42607_sensor_mode {
>  	INV_ICM42607_SENSOR_MODE_OFF,
>  	INV_ICM42607_SENSOR_MODE_STANDBY,
> @@ -413,6 +424,9 @@ struct inv_icm42607_sensor_state {
>  
>  typedef int (*inv_icm42607_bus_setup)(struct inv_icm42607_state *);
>  
> +extern const struct regmap_config inv_icm42607_regmap_config;
> +extern const struct dev_pm_ops inv_icm42607_pm_ops;
> +
>  u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr);
>  
>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 6b7078387568..da04c820dab2 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> @@ -12,12 +12,33 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/iio/iio.h>
>  
>  #include "inv_icm42607.h"
>  
> +static const struct regmap_range_cfg inv_icm42607_regmap_ranges[] = {
> +	{
> +		.name = "user bank",
> +		.range_min = 0x0000,
> +		.range_max = 0x00FF,
> +		.window_start = 0,
> +		.window_len = 0x0100,
> +	},
> +};
> +
> +const struct regmap_config inv_icm42607_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x00FF,
> +	.ranges = inv_icm42607_regmap_ranges,
> +	.num_ranges = ARRAY_SIZE(inv_icm42607_regmap_ranges),
> +	.cache_type = REGCACHE_NONE,
> +};
> +EXPORT_SYMBOL_NS_GPL(inv_icm42607_regmap_config, "IIO_ICM42607");

It would make more sense to include the regmap config in the first patch
since it is shared.

> +
>  struct inv_icm42607_hw {
>  	uint8_t whoami;
>  	const char *name;
> @@ -86,6 +107,62 @@ u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
>  	return odr_periods[odr];
>  }
>  
> +static int inv_icm42607_set_pwr_mgmt0(struct inv_icm42607_state *st,
> +				      enum inv_icm42607_sensor_mode gyro,
> +				      enum inv_icm42607_sensor_mode accel,
> +				      bool temp, unsigned int *sleep_ms)
> +{
> +	enum inv_icm42607_sensor_mode oldgyro = st->conf.gyro.mode;
> +	enum inv_icm42607_sensor_mode oldaccel = st->conf.accel.mode;
> +	bool oldtemp = st->conf.temp_en;
> +	unsigned int sleepval;
> +	unsigned int val;
> +	int ret;
> +
> +	if (gyro == oldgyro && accel == oldaccel && temp == oldtemp)
> +		return 0;
> +
> +	val = INV_ICM42607_PWR_MGMT0_GYRO(gyro) |
> +	INV_ICM42607_PWR_MGMT0_ACCEL(accel);
> +	if (!temp)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf.gyro.mode = gyro;
> +	st->conf.accel.mode = accel;
> +	st->conf.temp_en = temp;
> +
> +	sleepval = 0;
> +	if (temp && !oldtemp) {
> +		if (sleepval < INV_ICM42607_TEMP_STARTUP_TIME_MS)
> +			sleepval = INV_ICM42607_TEMP_STARTUP_TIME_MS;
> +	}
> +	if (accel != oldaccel && oldaccel == INV_ICM42607_SENSOR_MODE_OFF) {
> +		usleep_range(200, 300);
> +		if (sleepval < INV_ICM42607_ACCEL_STARTUP_TIME_MS)
> +			sleepval = INV_ICM42607_ACCEL_STARTUP_TIME_MS;
> +	}
> +	if (gyro != oldgyro) {
> +		if (oldgyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			usleep_range(200, 300);
> +			if (sleepval < INV_ICM42607_GYRO_STARTUP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STARTUP_TIME_MS;
> +		} else if (gyro == INV_ICM42607_SENSOR_MODE_OFF) {
> +			if (sleepval < INV_ICM42607_GYRO_STOP_TIME_MS)
> +				sleepval = INV_ICM42607_GYRO_STOP_TIME_MS;
> +		}
> +	}
> +
> +	if (sleep_ms)
> +		*sleep_ms = sleepval;
> +	else if (sleepval)
> +		msleep(sleepval);
> +
> +	return 0;
> +}
> +
>  int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
>  			     unsigned int writeval, unsigned int *readval)
>  {
> @@ -219,6 +296,10 @@ static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
>  static void inv_icm42607_disable_vddio_reg(void *_data)
>  {
>  	struct inv_icm42607_state *st = _data;
> +	struct device *dev = regmap_get_device(st->map);
> +
> +	if (pm_runtime_status_suspended(dev))
> +		return;
>  
>  	regulator_disable(st->vddio_supply);
>  }
> @@ -289,11 +370,134 @@ int inv_icm42607_core_probe(struct regmap *regmap, int chip,
>  
>  	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */
>  	ret = inv_icm42607_setup(st, bus_setup);
> +	if (ret)
> +		return ret; /* Return error from setup (e.g., WHOAMI fail) */
> +
> +	/* Setup runtime power management */

Would add a blank line here if this is meant to apply to more than the
following line. Otherwise it doesn't add much.

> +	ret = devm_pm_runtime_set_active_enabled(dev);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_set_autosuspend_delay(dev, INV_ICM42607_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(dev);
>  
>  	return ret;
>  }
>  EXPORT_SYMBOL_NS_GPL(inv_icm42607_core_probe, "IIO_ICM42607");
>  

...

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> new file mode 100644
> index 000000000000..eb72973debc5
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/i2c.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_i2c_bus_setup(struct inv_icm42607_state *st)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
> +				 INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN, 0);

regmap_clear_bits()

> +	if (ret)
> +		return ret;
> +
> +	mask = INV_ICM42607_DRIVE_CONFIG2_I2C_MASK;

Local mask variable isn't helping much.

> +	val = INV_ICM42607_DRIVE_CONFIG2_I2C(INV_ICM42607_SLEW_RATE_12_36NS);
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG2,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
> +}
> +
> +static int inv_icm42607_probe(struct i2c_client *client)
> +{
> +	const void *match;
> +	enum inv_icm42607_chip chip;
> +	struct regmap *regmap;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_I2C_BLOCK))
> +		return -EOPNOTSUPP;
> +
> +	match = device_get_match_data(&client->dev);

Should be i2c_get_match_data(). And we recently decided to standardize
on not checking for NULL return.

> +	if (!match)
> +		return -EINVAL;
> +	chip = (uintptr_t)match;
> +
> +	regmap = devm_regmap_init_i2c(client, &inv_icm42607_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return inv_icm42607_core_probe(regmap, chip, inv_icm42607_i2c_bus_setup);
> +}
> +
> +static const struct i2c_device_id inv_icm42607_id[] = {
> +	{ "icm42607", INV_CHIP_ICM42607 },
> +	{ "icm42607p", INV_CHIP_ICM42607P },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, inv_icm42607_id);
> +
> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = (void *)INV_CHIP_ICM42607,
> +	}, {
> +		.compatible = "invensense,icm42607p",
> +		.data = (void *)INV_CHIP_ICM42607P,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static struct i2c_driver inv_icm42607_driver = {
> +	.driver = {
> +		.name = "inv-icm42607-i2c",
> +		.of_match_table = inv_icm42607_of_matches,
> +		.pm = pm_ptr(&inv_icm42607_pm_ops),
> +	},
> +	.id_table = inv_icm42607_id,
> +	.probe = inv_icm42607_probe,
> +};
> +module_i2c_driver(inv_icm42607_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x I2C driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM42607");
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> new file mode 100644
> index 000000000000..51ce3deeb706
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/property.h>
> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
> +				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE,
> +				 INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);

regmap_set_bits()

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
> +				 INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN, 0);

regmap_clear_bits()

> +	if (ret)
> +		return ret;
> +
> +	mask = INV_ICM42607_DRIVE_CONFIG3_SPI_MASK;
> +	val = INV_ICM42607_DRIVE_CONFIG3_SPI(INV_ICM42607_SLEW_RATE_INF_2NS);
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
> +				 mask, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
> +}
> +
> +static int inv_icm42607_probe(struct spi_device *spi)
> +{
> +	const void *match;
> +	enum inv_icm42607_chip chip;
> +	struct regmap *regmap;
> +
> +	match = device_get_match_data(&spi->dev);
> +	if (!match)
> +		return -EINVAL;

Should be spi_get_device_match_data(). And we recently decided to standardize
on not checking for NULL return.

> +	chip = (uintptr_t)match;

uintptr_t is frowned upon in the kernel. Stick with kernel_ulong_t.

> +
> +	regmap = devm_regmap_init_spi(spi, &inv_icm42607_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to register spi regmap %ld\n",
> +				     PTR_ERR(regmap));
> +
> +	return inv_icm42607_core_probe(regmap, chip,
> +				       inv_icm42607_spi_bus_setup);
> +}
> +
> +static const struct of_device_id inv_icm42607_of_matches[] = {
> +	{
> +		.compatible = "invensense,icm42607",
> +		.data = (void *)INV_CHIP_ICM42607,
> +	},
> +	{
> +		.compatible = "invensense,icm42607p",
> +		.data = (void *)INV_CHIP_ICM42607P,
> +	},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, inv_icm42607_of_matches);
> +
> +static const struct spi_device_id inv_icm42607_spi_id_table[] = {
> +	{ "icm42607", INV_CHIP_ICM42607 },
> +	{ "icm42607p", INV_CHIP_ICM42607P },
> +	{ },

No trailing comma.

> +};
> +MODULE_DEVICE_TABLE(spi, inv_icm42607_spi_id_table);
> +
> +static struct spi_driver inv_icm42607_driver = {
> +	.driver = {
> +		.name = "inv-icm42607-spi",
> +		.of_match_table = inv_icm42607_of_matches,
> +		.pm = &inv_icm42607_pm_ops,
> +	},
> +	.id_table = inv_icm42607_spi_id_table,
> +	.probe = inv_icm42607_probe,
> +};
> +module_spi_driver(inv_icm42607_driver);
> +
> +MODULE_AUTHOR("InvenSense, Inc.");
> +MODULE_DESCRIPTION("InvenSense ICM-42607x SPI driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_ICM42607");

