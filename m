Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C63CA49D;
	Mon, 19 Oct 2026 03:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792379368; cv=none; b=IAXhZHUQmAbo4xGZwbiCO22/moIEKgK2fq5i/RDwLPsorhHqOpT64OT4P+QGL4/x/yvcRQdppBGP3Cq4EuvwVVvcJsVODR6eytZOh9A0bCpZTlPCbXcuIrQF727I0260QZMhlL9oZ+Fa61RhpYqsCSpEwNNVLwhsSpxm0uKddyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792379368; c=relaxed/simple;
	bh=CzFcKQM33Cq5P8ORdmzit8Afzw2hh3huDqIDynegErY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CietfQLC9p0Im/z9vAnhQse9RiJEdB58dxWXmhLW2C8eBslsm8S93na6Mzh41DyjVsvI1JPBuJCmj2yK3IzewGO4NRgSnj4J1/8iMmNoPeMgXBNi5gB+Y3GP2C3A6U+tX6HKibJ7OMwFPWmiPIJEbpozW5WHky9TJf3kr46qWnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uu3YOUVg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uu3YOUVg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FBD1F000C4;
	Mon, 19 Oct 2026 03:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792379364;
	bh=6dNHJAmFPwSXAK4cpoPtlpkupCrYiUjrK1/Mm06OYLY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Uu3YOUVgiaPJCXGKS+iDpR/5WzD5L6gGBdZDiOqPI3wjUcCsiFKB1P+Fr+uEEGzsu
	 6duyM8qJ1HSrs9rHvu1hcQdcGFWTWLsFqj5vlh/5qjqDkFBi2/YHx5sanqhMobSTIe
	 4behsKOzDOKrTE/kX8QuPzfPyhKry1bffpEr6Ngdi4u+yk7kN70AShDZW/qDlAsOa1
	 nqqe9JZ63AgWPTmuEeOTBXlzAS85yz+HEJ7Qg9+CEX6GXFpyj2iKhfb1OUL+sC3kXK
	 OdrDf5VYByn/AXmsFBHTpLCZelZItZHVeVmQ9iT4r3T6cz9PhXCLTgUt0NoDzGlxZD
	 JR3EfY2WGW2Mw==
Date: Mon, 19 Oct 2026 04:09:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Cc: linux-iio@vger.kernel.org, nuno.sa@analog.com,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, andy@kernel.org,
 linux@analog.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: iio: adt7316: use kstrtobool() for sysfs
 boolean parsing
Message-ID: <20261019040919.0381d31f@jic23-hlaptop>
In-Reply-To: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
References: <20261018143108.14750-1-abdelnasserhussein11@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 18 Oct 2026 17:31:08 +0300
Abdelnasser Hussein <abdelnasserhussein11@gmail.com> wrote:

> Replace manual character checks (e.g., buf[0] == '1') with the standard
> kstrtobool() API in sysfs store functions.
> 
> Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Ah. No need to resend just to drop a tag.  I did that on v3.

Anyhow, all is well that ends well!

Thanks,

Jonathan

> ---
> Changes in v4:
> - Removed Joshua's Reviewed-by tag.
> 
> Changes in v3:
> - Change _adt7316_store_enabled() parameter type from int to bool to match callers (Andy Shevchenko).
> - Update adt7316_disable() and adt7316_enable() to pass false/true instead of 0/1 (Andy Shevchenko).
> 
> Changes in v2:
> - Include <linux/kstrtox.h>.
> - Rename the boolean variable from 'req' to 'val' for clarity.
> - Add Reviewed-by tag from Joshua Crofts.
> 
>  drivers/staging/iio/addac/adt7316.c | 101 ++++++++++++++++++++++------
>  1 file changed, 81 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
> index 20f6052cc7fb..ec1c33ad5ace 100644
> --- a/drivers/staging/iio/addac/adt7316.c
> +++ b/drivers/staging/iio/addac/adt7316.c
> @@ -17,6 +17,7 @@
>  #include <linux/i2c.h>
>  #include <linux/rtc.h>
>  #include <linux/module.h>
> +#include <linux/kstrtox.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/events.h>
> @@ -220,7 +221,7 @@ static ssize_t adt7316_show_enabled(struct device *dev,
>  }
>  
>  static ssize_t _adt7316_store_enabled(struct adt7316_chip_info *chip,
> -				      int enable)
> +				      bool enable)
>  {
>  	u8 config1;
>  	int ret;
> @@ -246,12 +247,12 @@ static ssize_t adt7316_store_enabled(struct device *dev,
>  {
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
> -	int enable;
> +	bool enable;
> +	int ret;
>  
> -	if (buf[0] == '1')
> -		enable = 1;
> -	else
> -		enable = 0;
> +	ret = kstrtobool(buf, &enable);
> +	if (ret)
> +		return ret;
>  
>  	if (_adt7316_store_enabled(chip, enable) < 0)
>  		return -EIO;
> @@ -285,13 +286,18 @@ static ssize_t adt7316_store_select_ex_temp(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config1;
> +	bool val;
>  	int ret;
>  
>  	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
>  		return -EPERM;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config1 = chip->config1 & (~ADT7516_SEL_EX_TEMP);
> -	if (buf[0] == '1')
> +	if (val)
>  		config1 |= ADT7516_SEL_EX_TEMP;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> @@ -482,10 +488,15 @@ static ssize_t adt7316_store_disable_averaging(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config2;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config2 = chip->config2 & (~ADT7316_DISABLE_AVERAGING);
> -	if (buf[0] == '1')
> +	if (val)
>  		config2 |= ADT7316_DISABLE_AVERAGING;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> @@ -521,10 +532,15 @@ static ssize_t adt7316_store_enable_smbus_timeout(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config2;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config2 = chip->config2 & (~ADT7316_EN_SMBUS_TIMEOUT);
> -	if (buf[0] == '1')
> +	if (val)
>  		config2 |= ADT7316_EN_SMBUS_TIMEOUT;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG2, config2);
> @@ -559,10 +575,15 @@ static ssize_t adt7316_store_powerdown(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config1;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config1 = chip->config1 & (~ADT7316_PD);
> -	if (buf[0] == '1')
> +	if (val)
>  		config1 |= ADT7316_PD;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> @@ -597,10 +618,15 @@ static ssize_t adt7316_store_fast_ad_clock(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config3;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config3 = chip->config3 & (~ADT7316_ADCLK_22_5);
> -	if (buf[0] == '1')
> +	if (val)
>  		config3 |= ADT7316_ADCLK_22_5;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> @@ -640,13 +666,18 @@ static ssize_t adt7316_store_da_high_resolution(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config3;
> +	bool val;
>  	int ret;
>  
>  	if (chip->id == ID_ADT7318 || chip->id == ID_ADT7519)
>  		return -EPERM;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config3 = chip->config3 & (~ADT7316_DA_HIGH_RESOLUTION);
> -	if (buf[0] == '1')
> +	if (val)
>  		config3 |= ADT7316_DA_HIGH_RESOLUTION;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> @@ -685,12 +716,17 @@ static ssize_t adt7316_store_AIN_internal_Vref(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config3;
> +	bool val;
>  	int ret;
>  
>  	if ((chip->id & ID_FAMILY_MASK) != ID_ADT75XX)
>  		return -EPERM;
>  
> -	if (buf[0] != '1')
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (!val)
>  		config3 = chip->config3 & (~ADT7516_AIN_IN_VREF);
>  	else
>  		config3 = chip->config3 | ADT7516_AIN_IN_VREF;
> @@ -728,10 +764,15 @@ static ssize_t adt7316_store_enable_prop_DACA(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config3;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config3 = chip->config3 & (~ADT7316_EN_IN_TEMP_PROP_DACA);
> -	if (buf[0] == '1')
> +	if (val)
>  		config3 |= ADT7316_EN_IN_TEMP_PROP_DACA;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> @@ -767,10 +808,15 @@ static ssize_t adt7316_store_enable_prop_DACB(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config3;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config3 = chip->config3 & (~ADT7316_EN_EX_TEMP_PROP_DACB);
> -	if (buf[0] == '1')
> +	if (val)
>  		config3 |= ADT7316_EN_EX_TEMP_PROP_DACB;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG3, config3);
> @@ -967,10 +1013,15 @@ static ssize_t adt7316_store_DA_AB_Vref_bypass(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 dac_config;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_AB);
> -	if (buf[0] == '1')
> +	if (val)
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_AB;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> @@ -1006,10 +1057,15 @@ static ssize_t adt7316_store_DA_CD_Vref_bypass(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 dac_config;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	dac_config = chip->dac_config & (~ADT7316_VREF_BYPASS_DAC_CD);
> -	if (buf[0] == '1')
> +	if (val)
>  		dac_config |= ADT7316_VREF_BYPASS_DAC_CD;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_DAC_CONFIG, dac_config);
> @@ -1969,10 +2025,15 @@ static ssize_t adt7316_set_int_enabled(struct device *dev,
>  	struct iio_dev *dev_info = dev_to_iio_dev(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  	u8 config1;
> +	bool val;
>  	int ret;
>  
> +	ret = kstrtobool(buf, &val);
> +	if (ret)
> +		return ret;
> +
>  	config1 = chip->config1 & (~ADT7316_INT_EN);
> -	if (buf[0] == '1')
> +	if (val)
>  		config1 |= ADT7316_INT_EN;
>  
>  	ret = chip->bus.write(chip->bus.client, ADT7316_CONFIG1, config1);
> @@ -2084,7 +2145,7 @@ static int adt7316_disable(struct device *dev)
>  	struct iio_dev *dev_info = dev_get_drvdata(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return _adt7316_store_enabled(chip, 0);
> +	return _adt7316_store_enabled(chip, false);
>  }
>  
>  static int adt7316_enable(struct device *dev)
> @@ -2092,7 +2153,7 @@ static int adt7316_enable(struct device *dev)
>  	struct iio_dev *dev_info = dev_get_drvdata(dev);
>  	struct adt7316_chip_info *chip = iio_priv(dev_info);
>  
> -	return _adt7316_store_enabled(chip, 1);
> +	return _adt7316_store_enabled(chip, true);
>  }
>  
>  EXPORT_GPL_SIMPLE_DEV_PM_OPS(adt7316_pm_ops, adt7316_disable, adt7316_enable);

