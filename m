Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFED3DD535
	for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 22:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858773; cv=none; b=t1y+5E2XqTwXXIci0+QMrEkW08fsKxR/9Z9j7Hs3+O89tQJUeiI2KPm50Uz+248GKgNIZ6KxmOZ+uzXwj3Fq+BBV9VnnVqIdpxgBUY91UpQTf+5Nclu95qzQz4pEa39wziSgtuIBypYZUy+P5TIN6ygRfWyPhIYGVo1Bf2SNuTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858773; c=relaxed/simple;
	bh=2oYL1Edb/BgUmJbeIjVrBygMbSJf9ktj3+kWUpOJb+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QQrrTUqE3ALs4o37xCNaczHnYSJ0W2aL9+y4f5BuoQnYDL9DMyJWwwUDuo/jJjmZ0HIdj+dgsxujrR+U+DnnFgI0t6iEzzWs8Vx7cLTKK1YB+F0gALtYoiucJRdO5UMjTWTIyfiKEVMDxQMb4FxEKRBq/l8Doee2PpmrhtpKBMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=jMkpHsZV; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="jMkpHsZV"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4be94eeacso2655424a34.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Apr 2026 15:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1775858770; x=1776463570; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j9076am4mzfnqKCXO40uzm6bV16grH8URJAf1spBMMo=;
        b=jMkpHsZVNg4QoWioUoytLN6FfRpc0w3hEk5Dag8SzrMkq8/uT2aP7dgVF1hhnHtVV5
         BMUPHWWv5aXH79Twt7aawoa5eESmBxwLJ645TOrk5+DcNle6wowDJMUv5XVgQH6MCSUF
         xVBbtQz06XeA4BkzIr9aWZc2eFGCqdWsgF/Y50/lUa6o2Q3AKdEJJZXEWjHl4c1VIkj/
         Q9rF92o5yOi2SJ0tJXEcppjp/JfpLTo0Dc4kOUzVJUztRkzBztUZSBWCrJbcGi4LWt6B
         jYdI+lLUKLgk3JWcLIiRUPMaBX/4NPn4Z0ZjCOxkUED6/mkVqZlsKJoPveecY6LPVGVW
         G3zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775858770; x=1776463570;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j9076am4mzfnqKCXO40uzm6bV16grH8URJAf1spBMMo=;
        b=fMmJlpom29Uzm9HI7v7N6PibeBcmo3oezyLMnBVyZqjYdKivZUDh5Qbz28i2l2WkCx
         V6TMIHWDj+olDdkE4tjlmY7vnHbE9SU8W3axzQNC8roLxARHeNqunnSTjxV0WagYBzg2
         FizukwLILlQg8IUrB83Pq/BYy3sXKL4QSVN+78Hri0IWjcunTVw8XHaAsMSSSODpPhJ1
         Pu/gd/6V9HMupeZ2g43DWluTe00Ft5MVkbvnm8JssmOARf9iITzsSiyQa0kfmyYYnKvQ
         r7lb6fRw4GYtKJjMe2XKhWhzq0tUamRhiH5Tnof+fRNU5086uBRMxFu/qWpfjExmv3vf
         IWcg==
X-Forwarded-Encrypted: i=1; AJvYcCXbWW+FqOJp5Ny6B6FoKDPPuiSfyQqYPr4Hh4266l0MfIQ902Rlbd+KLq7qSMTSpvmEQaqjYiaBpBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjuCmqbhF4MlELMxkSqHNtMTBOlDdLQFrMyntD1MZxXaRTqOds
	bEq5gLevytiPHHWNFGXQ6q17f4BNR5MMiBfD5QqQtLRn9ejarZR7MSLGXodadlKZE0o=
X-Gm-Gg: AeBDieuj8BNvSDv7SxcO3wfOuQsPoHU0FKL4E/GLwpUfko3doilb/JD4HbHON/R4UDB
	UYcrZAN2l4TEvK9yJHUxt3hDJD+W7SjRfXuENz3D6xthQSFW25oegM8pTi7CFl8oxQXcXtN3nOi
	miTyn0j3CLHyoSm664n/EaQQgvpGbl792LWOeQKPGvIRJkxw0OGIytfqL9dhMbgfytp3FLnWyiH
	ltnS3j8haXvofB/rMFSWe5sNng7n1VMZjt5/N27EMAtB45qcLR+rKV8ZMEB+7GvF2+932hPO4Fr
	RTRH7t28mR0sP6DBTI9UWReebJS3W+Wx4fJbPVQFGj5W/MGMwWhGL2S9P4McsfgMQa9dvR2jw6B
	WXDJVtSEEnRweC1X8S9ZyZUt/iP8JoB8beEorGSk/Y7l71CKaFfCnBpDNP87dM+NyjqZ3m5zxzu
	nDF+D37ehCaDcEPWg9pJRLnSKv+0imSlFNcZdm5TvOcD/dCdHOzrgyz91GOA5COZi2vRD1sn7F6
	g==
X-Received: by 2002:a05:6820:f03:b0:687:d51c:e637 with SMTP id 006d021491bc7-68be5873460mr2265750eaf.7.1775858770102;
        Fri, 10 Apr 2026 15:06:10 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:b75d:2440:dc10:808b? ([2600:8803:e7e4:500:b75d:2440:dc10:808b])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-423ddb20c0fsm2980846fac.11.2026.04.10.15.06.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2026 15:06:09 -0700 (PDT)
Message-ID: <631f3adb-550a-4902-b6f2-5614cd79ab75@baylibre.com>
Date: Fri, 10 Apr 2026 17:06:08 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 2/9] iio: imu: inv_icm42607: Add Core for inv_icm42607
 Driver
To: Chris Morgan <macroalpha82@gmail.com>, linux-iio@vger.kernel.org
Cc: andy@kernel.org, nuno.sa@analog.com, jic23@kernel.org,
 jean-baptiste.maneyrol@tdk.com, linux-rockchip@lists.infradead.org,
 devicetree@vger.kernel.org, heiko@sntech.de, conor+dt@kernel.org,
 krzk+dt@kernel.org, robh@kernel.org, andriy.shevchenko@intel.com,
 Chris Morgan <macromorgan@hotmail.com>
References: <20260330195853.392877-1-macroalpha82@gmail.com>
 <20260330195853.392877-3-macroalpha82@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260330195853.392877-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/30/26 2:58 PM, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add the core component of a new inv_icm42607 driver. This includes
> a few setup functions and the full register definition in the
> header file.
> 
> +#define INV_ICM42607_REG_PWR_MGMT0			0x1F
> +#define INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL		BIT(7)
> +#define INV_ICM42607_PWR_MGMT0_IDLE			BIT(4)
> +#define INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK		GENMASK(3, 2)
> +#define INV_ICM42607_PWR_MGMT0_GYRO(_mode)		\
> +	FIELD_PREP(INV_ICM42607_PWR_MGMT0_GYRO_MODE_MASK, (_mode))

We usually try to avoid macros that hide FIELD_PREP(). IMHO, it makes
the code harder to read because you have to jump back and forth to
definitions to see if it really is that.

> +#define INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK		GENMASK(1, 0)
> +#define INV_ICM42607_PWR_MGMT0_ACCEL(_mode)		\
> +	FIELD_PREP(INV_ICM42607_PWR_MGMT0_ACCEL_MODE_MASK, (_mode))
> +

...


> +u32 inv_icm42607_odr_to_period(enum inv_icm42607_odr odr)
> +{
> +	static u32 odr_periods[INV_ICM42607_ODR_NB] = {
> +		/* Reserved values */
> +		0, 0, 0, 0, 0,
> +		/* 1600Hz */
> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100 Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
> +	};

No range checking to avoid out-of-bouds access?

> +
> +	return odr_periods[odr];
> +}
> +
> +int inv_icm42607_debugfs_reg(struct iio_dev *indio_dev, unsigned int reg,
> +			     unsigned int writeval, unsigned int *readval)
> +{
> +	struct inv_icm42607_state *st = iio_device_get_drvdata(indio_dev);
> +
> +	guard(mutex)(&st->lock);
> +
> +	if (readval)
> +		return regmap_read(st->map, reg, readval);
> +
> +	return regmap_write(st->map, reg, writeval);
> +}
> +
> +static int inv_icm42607_set_conf(struct inv_icm42607_state *st,
> +				 const struct inv_icm42607_conf *conf)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	val = INV_ICM42607_PWR_MGMT0_GYRO(conf->gyro.mode) |
> +	INV_ICM42607_PWR_MGMT0_ACCEL(conf->accel.mode);

Indent wrapped lines one tab or line up with INV_ after `= `.

> +	/*
> +	 * No temperature enable reg in datasheet, but BSP driver
> +	 * selected RC oscillator clock in LP mode when temperature
> +	 * was disabled.
> +	 */
> +	if (!conf->temp_en)
> +		val |= INV_ICM42607_PWR_MGMT0_ACCEL_LP_CLK_SEL;
> +	ret = regmap_write(st->map, INV_ICM42607_REG_PWR_MGMT0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_GYRO_CONFIG0_FS_SEL(conf->gyro.fs) |
> +	INV_ICM42607_GYRO_CONFIG0_ODR(conf->gyro.odr);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_ACCEL_CONFIG0_FS_SEL(conf->accel.fs) |
> +	INV_ICM42607_ACCEL_CONFIG0_ODR(conf->accel.odr);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_GYRO_CONFIG1_FILTER(conf->gyro.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_GYRO_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	val = INV_ICM42607_ACCEL_CONFIG1_FILTER(conf->accel.filter);
> +	ret = regmap_write(st->map, INV_ICM42607_REG_ACCEL_CONFIG1, val);
> +	if (ret)
> +		return ret;
> +
> +	st->conf = *conf;
> +
> +	return 0;
> +}
> +
> +/**
> + *  inv_icm42607_setup() - check and setup chip
> + *  @st:	driver internal state
> + *  @bus_setup:	callback for setting up bus specific registers
> + *
> + *  Returns 0 on success, a negative error code otherwise.
> + */
> +static int inv_icm42607_setup(struct inv_icm42607_state *st,
> +			      inv_icm42607_bus_setup bus_setup)
> +{
> +	const struct inv_icm42607_hw *hw = &inv_icm42607_hw[st->chip];
> +	const struct device *dev = regmap_get_device(st->map);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_WHOAMI, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val != hw->whoami)
> +		dev_warn_probe(dev, -ENODEV,
> +			       "invalid whoami %#02x expected %#02x (%s)\n",
> +			       val, hw->whoami, hw->name);
> +
> +	st->name = hw->name;
> +
> +	ret = regmap_write(st->map, INV_ICM42607_REG_SIGNAL_PATH_RESET,
> +			   INV_ICM42607_SIGNAL_PATH_RESET_SOFT_RESET);
> +	if (ret)
> +		return ret;

nit: Add blank line here.

> +	msleep(INV_ICM42607_RESET_TIME_MS);
> +
> +	ret = regmap_read(st->map, INV_ICM42607_REG_INT_STATUS, &val);
> +	if (ret)
> +		return ret;
> +	if (!(val & INV_ICM42607_INT_STATUS_RESET_DONE))
> +		return dev_err_probe(dev, -ENODEV,
> +				     "reset error, reset done bit not set\n");

Could also replace this and msleep with regmap_read_poll_timeout().

> +
> +	ret = bus_setup(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				 INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN,
> +				 INV_ICM42607_INTF_CONFIG0_SENSOR_DATA_ENDIAN);

Simplify with regmap_set_bits().

> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_MASK,
> +				 INV_ICM42607_INTF_CONFIG1_CLKSEL_PLL);
> +	if (ret)
> +		return ret;
> +
> +	return inv_icm42607_set_conf(st, hw->conf);
> +}
> +
> +static int inv_icm42607_enable_vddio_reg(struct inv_icm42607_state *st)
> +{
> +	int ret;
> +
> +	ret = regulator_enable(st->vddio_supply);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(3000, 4000);

Use fsleep() and add a comment to explain why the duration
was chosen.

> +
> +	return 0;
> +}
> +
> +static void inv_icm42607_disable_vddio_reg(void *_data)
> +{
> +	struct inv_icm42607_state *st = _data;
> +
> +	regulator_disable(st->vddio_supply);
> +}
> +
> +int inv_icm42607_core_probe(struct regmap *regmap, int chip,
> +			    inv_icm42607_bus_setup bus_setup)
> +{
> +	struct device *dev = regmap_get_device(regmap);
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct inv_icm42607_state *st;
> +	int irq, irq_type;
> +	bool open_drain;
> +	int ret;
> +
> +	if (chip < INV_CHIP_INVALID || chip >= INV_CHIP_NB)

Only two chips are defined in regmap_read_poll_timeout, so this range
checking seems wrong.

> +		dev_warn_probe(dev, -ENODEV,
> +			       "Invalid chip = %d\n", chip);
> +
> +	/* get INT1 only supported interrupt or fallback to first interrupt */
> +	irq = fwnode_irq_get_byname(fwnode, "INT1");
> +	if (irq < 0 && irq != -EPROBE_DEFER) {
> +		dev_info(dev, "no INT1 interrupt defined, fallback to first interrupt\n");
> +		irq = fwnode_irq_get(fwnode, 0);
> +	}
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "error missing INT1 interrupt\n");
> +
> +	irq_type = irq_get_trigger_type(irq);
> +	if (!irq_type)
> +		irq_type = IRQF_TRIGGER_FALLING;
> +
> +	open_drain = device_property_read_bool(dev, "drive-open-drain");
> +
> +	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
> +	if (!st)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, st);
> +	mutex_init(&st->lock);
> +	st->chip = chip;
> +	st->map = regmap;
> +	st->irq = irq;
> +
> +	ret = iio_read_mount_matrix(dev, &st->orientation);
> +	if (ret) {
> +		dev_err(dev, "failed to retrieve mounting matrix %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
> +
> +	msleep(INV_ICM42607_POWER_UP_TIME_MS);
> +
> +	st->vddio_supply = devm_regulator_get(dev, "vddio");

If we aren't implementing power managament, we can just use
devm_regulator_get_enabled() and avoid the devm_add_action_or_reset().

> +	if (IS_ERR(st->vddio_supply))
> +		return PTR_ERR(st->vddio_supply);
> +
> +	ret = inv_icm42607_enable_vddio_reg(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, inv_icm42607_disable_vddio_reg, st);
> +	if (ret)
> +		return ret;
> +
> +	/* Setup chip registers (includes WHOAMI check, reset check, bus setup) */

This comment would be better as part of the function doc comment.

> +	ret = inv_icm42607_setup(st, bus_setup);
> +
> +	return ret;
> +}
