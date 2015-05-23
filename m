Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50351 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439AbbEWL30 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 23 May 2015 07:29:26 -0400
Message-ID: <55606490.7010403@kernel.org>
Date: Sat, 23 May 2015 12:29:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Kevin Tsai <ktsai@capellamicro.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
	Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Roberta Dobrescu <roberta.dobrescu@gmail.com>,
	Kuppuswamy Sathyanarayanan
	<sathyanarayanan.kuppuswamy@linux.intel.com>
CC: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iio: light: Added Device Tree support for CM3232
 ambient light sensor driver.
References: <1432075419-2692-1-git-send-email-ktsai@capellamicro.com>
In-Reply-To: <1432075419-2692-1-git-send-email-ktsai@capellamicro.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/05/15 23:43, Kevin Tsai wrote:
> Added Device Tree Support.
> 
> Signed-off-by: Kevin Tsai <ktsai@capellamicro.com>
> ---
> Added Device Tree support.
> Updated company name.
> Renamed register name.
> 
>  .../devicetree/bindings/iio/light/cm3232.txt       | 22 +++++++
>  MAINTAINERS                                        | 12 ++--
>  drivers/iio/light/Kconfig                          |  4 +-
>  drivers/iio/light/cm3232.c                         | 71 ++++++++++++++--------
>  4 files changed, 76 insertions(+), 33 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/cm3232.txt
> 
> diff --git a/Documentation/devicetree/bindings/iio/light/cm3232.txt b/Documentation/devicetree/bindings/iio/light/cm3232.txt
> new file mode 100644
> index 0000000..00dde87
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/cm3232.txt
> @@ -0,0 +1,22 @@
> +* Vishay Capella CM3232 Ambient Light sensor
> +
> +Required properties:
> +- compatible: must be "capella,cm3232"
> +- reg: the I2C address of the device
> +
> +Optional properties:
I'd much rather we avoided the magic numbers and broke these up into the individual
elements that are stored in the registers.
> +- capella,reg_cmd: command register initialization.
> +- capella,calibscale: calibrated factor with 10^-5 notation.
> +- capella,hw_id: hardware device id.
I don't think hw_id has any place in here. Should be covered by the compatible list
to my mind.

> +- capella,mlux_per_bit: millilux per bit under the default IT.
Is this not closely related to the calibscale?
> +
> +Example:
> +
> +cm3232@10 {
> +	compatible = "capella,cm3232";
> +	reg = <0x10>;
> +	capella,reg_cmd = <0x04>;
> +	capella,calibscale = <100000>;
> +	capella,hw_id = <0x32>;
> +	capella,mlux_per_bit = <64>;
> +};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f8e0afb..ee6a8f6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2431,12 +2431,6 @@ F:	security/capability.c
>  F:	security/commoncap.c
>  F:	kernel/capability.c
>  
> -CAPELLA MICROSYSTEMS LIGHT SENSOR DRIVER
> -M:	Kevin Tsai <ktsai@capellamicro.com>
> -S:	Maintained
> -F:	drivers/iio/light/cm*
> -F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
> -
>  CC2520 IEEE-802.15.4 RADIO DRIVER
>  M:	Varka Bhadram <varkabhadram@gmail.com>
>  L:	linux-wpan@vger.kernel.org
> @@ -10610,6 +10604,12 @@ L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/ethernet/via/via-velocity.*
>  
> +VISHAY CAPELLA LIGHT SENSOR DRIVER
> +M:	Kevin Tsai <ktsai@capellamicro.com>
> +S:	Maintained
> +F:	drivers/iio/light/cm*
> +F:	Documentation/devicetree/bindings/i2c/trivial-devices.txt
> +
>  VIVID VIRTUAL VIDEO DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index a437bad..5e7e311 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -50,11 +50,11 @@ config CM32181
>  
>  config CM3232
>  	depends on I2C
> -	tristate "CM3232 ambient light sensor"
> +	tristate "Vishay Capella CM3232 ambient light sensor"
>  	help
>  	 Say Y here if you use cm3232.
>  	 This option enables ambient light sensor using
> -	 Capella Microsystems cm3232 device driver.
> +	 Vishay Capella cm3232 device driver.
>  
>  	 To compile this driver as a module, choose M here:
>  	 the module will be called cm3232.
> diff --git a/drivers/iio/light/cm3232.c b/drivers/iio/light/cm3232.c
> index 39c8d99..5354bfa 100644
> --- a/drivers/iio/light/cm3232.c
> +++ b/drivers/iio/light/cm3232.c
> @@ -1,8 +1,7 @@
>  /*
>   * CM3232 Ambient Light Sensor
>   *
> - * Copyright (C) 2014-2015 Capella Microsystems Inc.
> - * Author: Kevin Tsai <ktsai@capellamicro.com>
> + * Copyright (C) 2014-2015 Vishay Capella
>   *
>   * This program is free software; you can redistribute it and/or modify it
>   * under the terms of the GNU General Public License version 2, as published
> @@ -54,7 +53,7 @@ static const struct {
>  };
>  
>  struct cm3232_als_info {
> -	u8 regs_cmd_default;
> +	u8 reg_cmd;
>  	u8 hw_id;
>  	int calibscale;
>  	int mlux_per_bit;
> @@ -62,7 +61,7 @@ struct cm3232_als_info {
>  };
>  
I had clearly missed the use of a non const info structure in here.
Could you clean this up as well? 
(basically make a copy and work on that allowing this default version to
become const)
>  static struct cm3232_als_info cm3232_als_info_default = {
> -	.regs_cmd_default = CM3232_CMD_DEFAULT,
> +	.reg_cmd = CM3232_CMD_DEFAULT,
>  	.hw_id = CM3232_HW_ID,
>  	.calibscale = CM3232_CALIBSCALE_DEFAULT,
>  	.mlux_per_bit = CM3232_MLUX_PER_BIT_DEFAULT,
> @@ -72,10 +71,27 @@ static struct cm3232_als_info cm3232_als_info_default = {
>  struct cm3232_chip {
>  	struct i2c_client *client;
>  	struct cm3232_als_info *als_info;
> -	u8 regs_cmd;
> -	u16 regs_als;
> +	u8 reg_cmd;
> +	u16 reg_als;
>  };
>  
> +#ifdef CONFIG_OF
> +void cm3232_parse_dt(struct cm3232_chip *chip)
> +{
> +	struct device_node *dn = chip->client->dev.of_node;
> +	u32 temp_val;
> +
> +	if (!of_property_read_u32(dn, "capella,reg_cmd", &temp_val))
> +		chip->als_info->reg_cmd = (uint8_t)temp_val;
> +	if (!of_property_read_u32(dn, "capella,hw_id", &temp_val))
> +		chip->als_info->hw_id = (int)temp_val;
> +	if (!of_property_read_u32(dn, "capella,calibscale", &temp_val))
> +		chip->als_info->calibscale = (int)temp_val;
> +	if (!of_property_read_u32(dn, "capella,mlux_per_bit", &temp_val))
> +		chip->als_info->mlux_per_bit = (int)temp_val;
> +}
> +#endif
> +
>  /**
>   * cm3232_reg_init() - Initialize CM3232
>   * @chip:	pointer of struct cm3232_chip.
> @@ -90,6 +106,10 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  	s32 ret;
>  
>  	chip->als_info = &cm3232_als_info_default;
> +#ifdef CONFIG_OF
> +	if (client->dev.of_node)
> +		cm3232_parse_dt(chip);
> +#endif
>  
>  	/* Identify device */
>  	ret = i2c_smbus_read_word_data(client, CM3232_REG_ADDR_ID);
> @@ -102,20 +122,20 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  		return -ENODEV;
>  
>  	/* Disable and reset device */
> -	chip->regs_cmd = CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
> +	chip->reg_cmd = CM3232_CMD_ALS_DISABLE | CM3232_CMD_ALS_RESET;
>  	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -					chip->regs_cmd);
> +					chip->reg_cmd);
>  	if (ret < 0) {
>  		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
>  		return ret;
>  	}
>  
>  	/* Register default value */
> -	chip->regs_cmd = chip->als_info->regs_cmd_default;
> +	chip->reg_cmd = chip->als_info->reg_cmd;
>  
>  	/* Configure register */
>  	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -					chip->regs_cmd);
> +					chip->reg_cmd);
>  	if (ret < 0)
>  		dev_err(&chip->client->dev, "Error writing reg_cmd\n");
>  
> @@ -123,21 +143,21 @@ static int cm3232_reg_init(struct cm3232_chip *chip)
>  }
>  
>  /**
> - *  cm3232_read_als_it() - Get sensor integration time
> - *  @chip:	pointer of struct cm3232_chip
> - *  @val:	pointer of int to load the integration (sec).
> - *  @val2:	pointer of int to load the integration time (microsecond).
> + * cm3232_read_als_it() - Get sensor integration time
> + * @chip:	pointer of struct cm3232_chip
> + * @val:	pointer of int to load the integration (sec).
> + * @val2:	pointer of int to load the integration time (microsecond).
>   *
> - *  Report the current integration time.
> + * Report the current integration time.
>   *
> - *  Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
> + * Return: IIO_VAL_INT_PLUS_MICRO for success, otherwise -EINVAL.
>   */
>  static int cm3232_read_als_it(struct cm3232_chip *chip, int *val, int *val2)
>  {
>  	u16 als_it;
>  	int i;
>  
> -	als_it = chip->regs_cmd;
> +	als_it = chip->reg_cmd;
>  	als_it &= CM3232_CMD_ALS_IT_MASK;
>  	als_it >>= CM3232_CMD_ALS_IT_SHIFT;
>  	for (i = 0; i < ARRAY_SIZE(cm3232_als_it_scales); i++) {
> @@ -175,14 +195,14 @@ static int cm3232_write_als_it(struct cm3232_chip *chip, int val, int val2)
>  			als_it = cm3232_als_it_scales[i].it;
>  			als_it <<= CM3232_CMD_ALS_IT_SHIFT;
>  
> -			cmd = chip->regs_cmd & ~CM3232_CMD_ALS_IT_MASK;
> +			cmd = chip->reg_cmd & ~CM3232_CMD_ALS_IT_MASK;
>  			cmd |= als_it;
>  			ret = i2c_smbus_write_byte_data(client,
>  							CM3232_REG_ADDR_CMD,
>  							cmd);
>  			if (ret < 0)
>  				return ret;
> -			chip->regs_cmd = cmd;
> +			chip->reg_cmd = cmd;
>  			return 0;
>  		}
>  	}
> @@ -222,8 +242,8 @@ static int cm3232_get_lux(struct cm3232_chip *chip)
>  		return ret;
>  	}
>  
> -	chip->regs_als = (u16)ret;
> -	lux *= chip->regs_als;
> +	chip->reg_als = (u16)ret;
> +	lux *= chip->reg_als;
>  	lux *= als_info->calibscale;
>  	lux = div_u64(lux, CM3232_CALIBSCALE_RESOLUTION);
>  	lux = div_u64(lux, CM3232_MLUX_PER_LUX);
> @@ -340,6 +360,7 @@ static int cm3232_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	chip = iio_priv(indio_dev);
> +
>  	i2c_set_clientdata(client, indio_dev);
>  	chip->client = client;
>  
> @@ -386,9 +407,9 @@ static int cm3232_suspend(struct device *dev)
>  	struct i2c_client *client = chip->client;
>  	int ret;
>  
> -	chip->regs_cmd |= CM3232_CMD_ALS_DISABLE;
> +	chip->reg_cmd |= CM3232_CMD_ALS_DISABLE;
>  	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -					chip->regs_cmd);
> +					chip->reg_cmd);
>  
>  	return ret;
>  }
> @@ -400,9 +421,9 @@ static int cm3232_resume(struct device *dev)
>  	struct i2c_client *client = chip->client;
>  	int ret;
>  
> -	chip->regs_cmd &= ~CM3232_CMD_ALS_DISABLE;
> +	chip->reg_cmd &= ~CM3232_CMD_ALS_DISABLE;
>  	ret = i2c_smbus_write_byte_data(client, CM3232_REG_ADDR_CMD,
> -					chip->regs_cmd | CM3232_CMD_ALS_RESET);
> +					chip->reg_cmd | CM3232_CMD_ALS_RESET);
>  
>  	return ret;
>  }
> 

