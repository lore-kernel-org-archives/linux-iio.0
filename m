Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:54390 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752746Ab1CIKvo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 9 Mar 2011 05:51:44 -0500
Message-ID: <4D775BF3.5090900@cam.ac.uk>
Date: Wed, 09 Mar 2011 10:52:35 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: linux-iio@vger.kernel.org, drivers@analog.com,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] IIO:DAC: AD5624R: Update to IIO ABI
References: <1299593700-10724-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1299593700-10724-1-git-send-email-michael.hennerich@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/08/11 14:15, michael.hennerich@analog.com wrote:
> From: Michael Hennerich <michael.hennerich@analog.com>
> 
> This driver did not conform with the IIO ABI for such devices.
> Also the sysfs files that this driver adds were not complete and
> partially un-documented.
> 
> Update and document ABI
> Change License notice, stick to GPL-v2.
> Fix indention style
> Add option to specify external reference voltage via the regulator framework.
> Add mandatory name attribute
> Add mandatory out_scale attribute
> 
Hi Michael,

Another nice bit of cleaning up.

Couple of trivial bits and bobs inline. Only one I really care about is
that documentation of powerdown_mode should include descriptions of
all options that are used.  Do that or convince me otherwise before
sending on.

There are a few things in here in the utterly trivial category
(variable renames, use of access macros). I'd prefer to see these
in a separate patch simply because it cuts down on the amount of
code that needs a careful review.  Basically I like my patches
to be bitesized as then I can review them whilst waiting for
something else to finish :)

> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/Documentation/sysfs-bus-iio |   29 +++
>  drivers/staging/iio/dac/ad5624r.h               |   89 +++++++--
>  drivers/staging/iio/dac/ad5624r_spi.c           |  242 ++++++++++++++---------
>  3 files changed, 249 insertions(+), 111 deletions(-)
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio b/drivers/staging/iio/Documentation/sysfs-bus-iio
> index 8058fcb..f97fb99 100644
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio
> @@ -271,6 +271,35 @@ Description:
>  		where a single output sets the value for multiple channels
>  		simultaneously.
>  
> +What:		/sys/bus/iio/devices/deviceX/outY_powerdown_mode
> +What:		/sys/bus/iio/devices/deviceX/out_powerdown_mode
> +KernelVersion:	2.6.38
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specifies the output powerdown mode.
> +		(three_state, ...)
For this sort of parameter I'd like to see documentation of all of the options that exist.
Otherwise people will come up with alternative names for the same thing.
Best option is probably a list with explanation at the end of this comment... 
> +		For a list of available output power down options read
> +		outX_powerdown_mode_available. If Y is not present the
> +		mode is shared across all outputs.
> +
> +What:		/sys/bus/iio/devices/deviceX/outY_powerdown_mode_available
> +What:		/sys/bus/iio/devices/deviceX/out_powerdown_mode_available
> +KernelVersion:	2.6.38
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Lists all available output power down modes.
> +		If Y is not present the mode is shared across all outputs.
> +
> +What:		/sys/bus/iio/devices/deviceX/outY_powerdown
> +What:		/sys/bus/iio/devices/deviceX/out_powerdown
> +KernelVersion:	2.6.38
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Writing 1 causes output Y to enter the power down mode specified
> +		by the corresponding outY_powerdown_mode. Clearing returns to
> +		normal operation. Y may be suppressed if all outputs are
> +		controlled together.
I'm happy with the interface you've defined here, but do vaguely wonder if there
is anything similar in kernel already...  Can't immediately think where, but worth
keeping in mind.
> +
>  What:		/sys/bus/iio/devices/deviceX/deviceX:eventY
>  KernelVersion:	2.6.35
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/staging/iio/dac/ad5624r.h b/drivers/staging/iio/dac/ad5624r.h
> index ce518be..c16df4e 100644
> --- a/drivers/staging/iio/dac/ad5624r.h
> +++ b/drivers/staging/iio/dac/ad5624r.h
> @@ -1,21 +1,80 @@
> +/*
> + * AD5624R SPI DAC driver
> + *
> + * Copyright 2010-2011 Analog Devices Inc.
> + *
> + * Licensed under the GPL-2.
> + */
>  #ifndef SPI_AD5624R_H_
>  #define SPI_AD5624R_H_
>  
> -#define AD5624R_DAC_CHANNELS	4
> +#define AD5624R_DAC_CHANNELS			4
>  
> -#define AD5624R_ADDR_DAC0	0x0
> -#define AD5624R_ADDR_DAC1	0x1
> -#define AD5624R_ADDR_DAC2	0x2
> -#define AD5624R_ADDR_DAC3	0x3
> -#define AD5624R_ADDR_ALL_DAC	0x7
> +#define AD5624R_ADDR_DAC0			0x0
> +#define AD5624R_ADDR_DAC1			0x1
> +#define AD5624R_ADDR_DAC2			0x2
> +#define AD5624R_ADDR_DAC3			0x3
> +#define AD5624R_ADDR_ALL_DAC			0x7
>  
> -#define AD5624R_CMD_WRITE_INPUT_N             0x0
> -#define AD5624R_CMD_UPDATE_DAC_N              0x1
> -#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_ALL  0x2
> -#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_N    0x3
> -#define AD5624R_CMD_POWERDOWN_DAC             0x4
> -#define AD5624R_CMD_RESET                     0x5
> -#define AD5624R_CMD_LDAC_SETUP                0x6
> -#define AD5624R_CMD_INTERNAL_REFER_SETUP      0x7
> +#define AD5624R_CMD_WRITE_INPUT_N		0x0
> +#define AD5624R_CMD_UPDATE_DAC_N		0x1
> +#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_ALL	0x2
> +#define AD5624R_CMD_WRITE_INPUT_N_UPDATE_N	0x3
> +#define AD5624R_CMD_POWERDOWN_DAC		0x4
> +#define AD5624R_CMD_RESET			0x5
> +#define AD5624R_CMD_LDAC_SETUP			0x6
> +#define AD5624R_CMD_INTERNAL_REFER_SETUP	0x7
>  
> -#endif
> +#define AD5624R_LDAC_PWRDN_NONE			0x0
> +#define AD5624R_LDAC_PWRDN_1K			0x1
> +#define AD5624R_LDAC_PWRDN_100K			0x2
> +#define AD5624R_LDAC_PWRDN_3STATE		0x3
> +
> +/**
> + * struct ad5624r_chip_info - chip specific information
> + * @bits:		accuracy of the DAC in bits
> + * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> + */
> +
> +struct ad5624r_chip_info {
> +	u8				bits;
> +	u16				int_vref_mv;
> +};
> +

Whilst I have no particular problem with having these structures defined
in the header, is there a particular reason for doing so?
> +/**
> + * struct ad5446_state - driver instance specific data
> + * @indio_dev:		the industrial I/O device
> + * @us:			spi_device
> + * @chip_info:		chip model specific constants, available modes etc
> + * @reg:		supply regulator
> + * @vref_mv:		actual reference voltage used
> + * @pwr_down_mask	power down mask
> + * @pwr_down_mode	current power down mode
> + */
> +
> +struct ad5624r_state {
> +	struct iio_dev			*indio_dev;
> +	struct spi_device		*us;
> +	const struct ad5624r_chip_info	*chip_info;
> +	struct regulator		*reg;
> +	unsigned short			vref_mv;
> +	unsigned			pwr_down_mask;
> +	unsigned			pwr_down_mode;
> +};
> +
> +/**
> + * ad5624r_supported_device_ids:
> + * The AD5624/44/64 parts are available in different
> + * fixed internal reference voltage options.
> + */
> +
> +enum ad5624r_supported_device_ids {
> +	ID_AD5624R3,
> +	ID_AD5644R3,
> +	ID_AD5664R3,
> +	ID_AD5624R5,
> +	ID_AD5644R5,
> +	ID_AD5664R5,
> +};
> +
> +#endif /* SPI_AD5624R_H_ */
> diff --git a/drivers/staging/iio/dac/ad5624r_spi.c b/drivers/staging/iio/dac/ad5624r_spi.c
> index 2b1c6dd..afb4501 100644
> --- a/drivers/staging/iio/dac/ad5624r_spi.c
> +++ b/drivers/staging/iio/dac/ad5624r_spi.c
> @@ -1,9 +1,9 @@
>  /*
>   * AD5624R, AD5644R, AD5664R Digital to analog convertors spi driver
>   *
> - * Copyright 2010 Analog Devices Inc.
> + * Copyright 2010-2011 Analog Devices Inc.
>   *
> - * Licensed under the GPL-2 or later.
> + * Licensed under the GPL-2.
>   */
>  
>  #include <linux/interrupt.h>
> @@ -14,25 +14,38 @@
>  #include <linux/spi/spi.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> -#include <linux/delay.h>
> +#include <linux/regulator/consumer.h>
>  
>  #include "../iio.h"
>  #include "../sysfs.h"
>  #include "dac.h"
>  #include "ad5624r.h"
>  
> -/**
> - * struct ad5624r_state - device related storage
> - * @indio_dev:	associated industrial IO device
> - * @us:		spi device
> - **/
> -struct ad5624r_state {
> -	struct iio_dev *indio_dev;
> -	struct spi_device *us;
> -	int data_len;
> -	int ldac_mode;
> -	int dac_power_mode[AD5624R_DAC_CHANNELS];
> -	int internal_ref;
> +static const struct ad5624r_chip_info ad5624r_chip_info_tbl[] = {
> +	[ID_AD5624R3] = {
> +		.bits = 12,
> +		.int_vref_mv = 1250,
> +	},
> +	[ID_AD5644R3] = {
> +		.bits = 14,
> +		.int_vref_mv = 1250,
> +	},
> +	[ID_AD5664R3] = {
> +		.bits = 16,
> +		.int_vref_mv = 1250,
> +	},
> +	[ID_AD5624R5] = {
> +		.bits = 12,
> +		.int_vref_mv = 2500,
> +	},
> +	[ID_AD5644R5] = {
> +		.bits = 14,
> +		.int_vref_mv = 2500,
> +	},
> +	[ID_AD5664R5] = {
> +		.bits = 16,
> +		.int_vref_mv = 2500,
> +	},
>  };
>  
>  static int ad5624r_spi_write(struct spi_device *spi,
> @@ -42,11 +55,12 @@ static int ad5624r_spi_write(struct spi_device *spi,
>  	u8 msg[3];
>  
>  	/*
> -	 * The input shift register is 24 bits wide. The first two bits are don't care bits.
> -	 * The next three are the command bits, C2 to C0, followed by the 3-bit DAC address,
> -	 * A2 to A0, and then the 16-, 14-, 12-bit data-word. The data-word comprises the 16-,
> -	 * 14-, 12-bit input code followed by 0, 2, or 4 don't care bits, for the AD5664R,
> -	 * AD5644R, and AD5624R, respectively.
> +	 * The input shift register is 24 bits wide. The first two bits are
> +	 * don't care bits. The next three are the command bits, C2 to C0,
> +	 * followed by the 3-bit DAC address, A2 to A0, and then the
> +	 * 16-, 14-, 12-bit data-word. The data-word comprises the 16-,
> +	 * 14-, 12-bit input code followed by 0, 2, or 4 don't care bits,
> +	 * for the AD5664R, AD5644R, and AD5624R, respectively.
>  	 */
>  	data = (0 << 22) | (cmd << 19) | (addr << 16) | (val << (16 - len));
>  	msg[0] = data >> 16;
> @@ -71,40 +85,43 @@ static ssize_t ad5624r_write_dac(struct device *dev,
>  		return ret;
>  
>  	ret = ad5624r_spi_write(st->us, AD5624R_CMD_WRITE_INPUT_N_UPDATE_N,
> -				this_attr->address, readin, st->data_len);
> +				this_attr->address, readin,
> +				st->chip_info->bits);
>  	return ret ? ret : len;
>  }
>  
> -static ssize_t ad5624r_read_ldac_mode(struct device *dev,
> +static ssize_t ad5624r_read_powerdown_mode(struct device *dev,
>  				      struct device_attribute *attr, char *buf)
>  {
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad5624r_state *st = indio_dev->dev_data;
>  
> -	return sprintf(buf, "%x\n", st->ldac_mode);
> +	char mode[][15] = {"", "1kohm_to_gnd", "100kohm_to_gnd", "three_state"};
> +
> +	return sprintf(buf, "%s\n", mode[st->pwr_down_mode]);
>  }
>  
> -static ssize_t ad5624r_write_ldac_mode(struct device *dev,
> +static ssize_t ad5624r_write_powerdown_mode(struct device *dev,
>  				       struct device_attribute *attr,
>  				       const char *buf, size_t len)
>  {
> -	long readin;
> -	int ret;
>  	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>  	struct ad5624r_state *st = indio_dev->dev_data;
> +	int ret;
>  
> -	ret = strict_strtol(buf, 16, &readin);
> -	if (ret)
> -		return ret;
> -
> -	ret = ad5624r_spi_write(st->us, AD5624R_CMD_LDAC_SETUP, 0,
> -				readin & 0xF, 16);
> -	st->ldac_mode = readin & 0xF;
> +	if (sysfs_streq(buf, "1kohm_to_gnd"))
> +		st->pwr_down_mode = AD5624R_LDAC_PWRDN_1K;
> +	else if (sysfs_streq(buf, "100kohm_to_gnd"))
> +		st->pwr_down_mode = AD5624R_LDAC_PWRDN_100K;
> +	else if (sysfs_streq(buf, "three_state"))
> +		st->pwr_down_mode = AD5624R_LDAC_PWRDN_3STATE;
> +	else
> +		ret = -EINVAL;
>  
>  	return ret ? ret : len;
>  }
>  
> -static ssize_t ad5624r_read_dac_power_mode(struct device *dev,
> +static ssize_t ad5624r_read_dac_powerdown(struct device *dev,
>  					   struct device_attribute *attr,
>  					   char *buf)
>  {
> @@ -112,10 +129,11 @@ static ssize_t ad5624r_read_dac_power_mode(struct device *dev,
>  	struct ad5624r_state *st = indio_dev->dev_data;
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>  
> -	return sprintf(buf, "%d\n", st->dac_power_mode[this_attr->address]);
> +	return sprintf(buf, "%d\n",
> +			!!(st->pwr_down_mask & (1 << this_attr->address)));
>  }
>  
> -static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
> +static ssize_t ad5624r_write_dac_powerdown(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
>  {
> @@ -129,80 +147,83 @@ static ssize_t ad5624r_write_dac_power_mode(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	ret = ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
> -				((readin & 0x3) << 4) |
> -				(1 << this_attr->address), 16);
> +	if (readin == 1)
> +		st->pwr_down_mask |= (1 << this_attr->address);
> +	else if (!readin)
> +		st->pwr_down_mask &= ~(1 << this_attr->address);
> +	else
> +		ret = -EINVAL;
>  
> -	st->dac_power_mode[this_attr->address] = readin & 0x3;
> +	ret = ad5624r_spi_write(st->us, AD5624R_CMD_POWERDOWN_DAC, 0,
> +				(st->pwr_down_mode << 4) |
> +				st->pwr_down_mask, 16);
>  
>  	return ret ? ret : len;
>  }
>  
> -static ssize_t ad5624r_read_internal_ref_mode(struct device *dev,
> -					      struct device_attribute *attr,
> -					      char *buf)
> +static ssize_t ad5624r_show_scale(struct device *dev,
> +				struct device_attribute *attr,
> +				char *buf)
>  {
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct ad5624r_state *st = indio_dev->dev_data;
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
As a general rule try and avoid subtle renames like this unless they
actually greatly improve things. 
> +	struct ad5624r_state *st = iio_dev_get_devdata(dev_info);
A good idea to use this macro, but there are other direct accesses
to that parameter in this driver that should be cleared up.  I'd
save that for a separate trivial patch as it wouldn't really need
review.
> +	/* Corresponds to Vref / 2^(bits) */
> +	unsigned int scale_uv = (st->vref_mv * 1000) >> st->chip_info->bits;
>  
> -	return sprintf(buf, "%d\n", st->internal_ref);
> +	return sprintf(buf, "%d.%03d\n", scale_uv / 1000, scale_uv % 1000);
>  }
> +static IIO_DEVICE_ATTR(out_scale, S_IRUGO, ad5624r_show_scale, NULL, 0);
>  
> -static ssize_t ad5624r_write_internal_ref_mode(struct device *dev,
> -					       struct device_attribute *attr,
> -					       const char *buf, size_t len)
> +static ssize_t ad5624r_show_name(struct device *dev,
> +				 struct device_attribute *attr,
> +				 char *buf)
>  {
> -	long readin;
> -	int ret;
> -	struct iio_dev *indio_dev = dev_get_drvdata(dev);
> -	struct ad5624r_state *st = indio_dev->dev_data;
> -
> -	ret = strict_strtol(buf, 10, &readin);
> -	if (ret)
> -		return ret;
> -
> -	ret = ad5624r_spi_write(st->us, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
> -				!!readin, 16);
> +	struct iio_dev *dev_info = dev_get_drvdata(dev);
> +	struct ad5624r_state *st = iio_dev_get_devdata(dev_info);
>  
> -	st->internal_ref = !!readin;
> -
> -	return ret ? ret : len;
> +	return sprintf(buf, "%s\n", spi_get_device_id(st->us)->name);
>  }
> +static IIO_DEVICE_ATTR(name, S_IRUGO, ad5624r_show_name, NULL, 0);
> +
Bonus blank line.
>  
>  static IIO_DEV_ATTR_OUT_RAW(0, ad5624r_write_dac, AD5624R_ADDR_DAC0);
>  static IIO_DEV_ATTR_OUT_RAW(1, ad5624r_write_dac, AD5624R_ADDR_DAC1);
>  static IIO_DEV_ATTR_OUT_RAW(2, ad5624r_write_dac, AD5624R_ADDR_DAC2);
>  static IIO_DEV_ATTR_OUT_RAW(3, ad5624r_write_dac, AD5624R_ADDR_DAC3);
>  
> -static IIO_DEVICE_ATTR(ldac_mode, S_IRUGO | S_IWUSR, ad5624r_read_ldac_mode,
> -		       ad5624r_write_ldac_mode, 0);
> -static IIO_DEVICE_ATTR(internal_ref, S_IRUGO | S_IWUSR,
> -		       ad5624r_read_internal_ref_mode,
> -		       ad5624r_write_internal_ref_mode, 0);
> +static IIO_DEVICE_ATTR(out_powerdown_mode, S_IRUGO |
> +			S_IWUSR, ad5624r_read_powerdown_mode,
> +			ad5624r_write_powerdown_mode, 0);
> +
> +static IIO_CONST_ATTR(out_powerdown_mode_available,
> +			"1kohm_to_gnd 100kohm_to_gnd three_state");
>  
> -#define IIO_DEV_ATTR_DAC_POWER_MODE(_num, _show, _store, _addr)			\
> -	IIO_DEVICE_ATTR(dac_power_mode_##_num, S_IRUGO | S_IWUSR, _show, _store, _addr)
> +#define IIO_DEV_ATTR_DAC_POWERDOWN(_num, _show, _store, _addr)		\
> +	IIO_DEVICE_ATTR(out##_num##_powerdown,				\
> +			S_IRUGO | S_IWUSR, _show, _store, _addr)
>  
> -static IIO_DEV_ATTR_DAC_POWER_MODE(0, ad5624r_read_dac_power_mode,
> -				   ad5624r_write_dac_power_mode, 0);
> -static IIO_DEV_ATTR_DAC_POWER_MODE(1, ad5624r_read_dac_power_mode,
> -				   ad5624r_write_dac_power_mode, 1);
> -static IIO_DEV_ATTR_DAC_POWER_MODE(2, ad5624r_read_dac_power_mode,
> -				   ad5624r_write_dac_power_mode, 2);
> -static IIO_DEV_ATTR_DAC_POWER_MODE(3, ad5624r_read_dac_power_mode,
> -				   ad5624r_write_dac_power_mode, 3);
> +static IIO_DEV_ATTR_DAC_POWERDOWN(0, ad5624r_read_dac_powerdown,
> +				   ad5624r_write_dac_powerdown, 0);
> +static IIO_DEV_ATTR_DAC_POWERDOWN(1, ad5624r_read_dac_powerdown,
> +				   ad5624r_write_dac_powerdown, 1);
> +static IIO_DEV_ATTR_DAC_POWERDOWN(2, ad5624r_read_dac_powerdown,
> +				   ad5624r_write_dac_powerdown, 2);
> +static IIO_DEV_ATTR_DAC_POWERDOWN(3, ad5624r_read_dac_powerdown,
> +				   ad5624r_write_dac_powerdown, 3);
>  
>  static struct attribute *ad5624r_attributes[] = {
>  	&iio_dev_attr_out0_raw.dev_attr.attr,
>  	&iio_dev_attr_out1_raw.dev_attr.attr,
>  	&iio_dev_attr_out2_raw.dev_attr.attr,
>  	&iio_dev_attr_out3_raw.dev_attr.attr,
> -	&iio_dev_attr_dac_power_mode_0.dev_attr.attr,
> -	&iio_dev_attr_dac_power_mode_1.dev_attr.attr,
> -	&iio_dev_attr_dac_power_mode_2.dev_attr.attr,
> -	&iio_dev_attr_dac_power_mode_3.dev_attr.attr,
> -	&iio_dev_attr_ldac_mode.dev_attr.attr,
> -	&iio_dev_attr_internal_ref.dev_attr.attr,
> +	&iio_dev_attr_out0_powerdown.dev_attr.attr,
> +	&iio_dev_attr_out1_powerdown.dev_attr.attr,
> +	&iio_dev_attr_out2_powerdown.dev_attr.attr,
> +	&iio_dev_attr_out3_powerdown.dev_attr.attr,
> +	&iio_dev_attr_out_powerdown_mode.dev_attr.attr,
> +	&iio_const_attr_out_powerdown_mode_available.dev_attr.attr,
> +	&iio_dev_attr_out_scale.dev_attr.attr,
> +	&iio_dev_attr_name.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -213,7 +234,7 @@ static const struct attribute_group ad5624r_attribute_group = {
>  static int __devinit ad5624r_probe(struct spi_device *spi)
>  {
>  	struct ad5624r_state *st;
> -	int ret = 0;
> +	int ret, voltage_uv = 0;
>  
>  	st = kzalloc(sizeof(*st), GFP_KERNEL);
>  	if (st == NULL) {
> @@ -222,18 +243,30 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
>  	}
>  	spi_set_drvdata(spi, st);
>  
> -	st->data_len = spi_get_device_id(spi)->driver_data;
> +	st->reg = regulator_get(&spi->dev, "vcc");
> +	if (!IS_ERR(st->reg)) {
> +		ret = regulator_enable(st->reg);
> +		if (ret)
> +			goto error_put_reg;
> +
> +		voltage_uv = regulator_get_voltage(st->reg);
> +	}
> +
> +	st->chip_info =
> +		&ad5624r_chip_info_tbl[spi_get_device_id(spi)->driver_data];
> +
> +	if (voltage_uv)
> +		st->vref_mv = voltage_uv / 1000;
> +	else
> +		st->vref_mv = st->chip_info->int_vref_mv;
>  
>  	st->us = spi;
>  	st->indio_dev = iio_allocate_device();
>  	if (st->indio_dev == NULL) {
>  		ret = -ENOMEM;
> -		goto error_free_st;
> +		goto error_disable_reg;
>  	}
>  	st->indio_dev->dev.parent = &spi->dev;
> -	st->indio_dev->num_interrupt_lines = 0;
> -	st->indio_dev->event_attrs = NULL;
> -
>  	st->indio_dev->attrs = &ad5624r_attribute_group;
>  	st->indio_dev->dev_data = (void *)(st);
>  	st->indio_dev->driver_module = THIS_MODULE;
> @@ -243,14 +276,22 @@ static int __devinit ad5624r_probe(struct spi_device *spi)
>  	if (ret)
>  		goto error_free_dev;
>  
> -	spi->mode = SPI_MODE_0;
> -	spi_setup(spi);
> +	ret = ad5624r_spi_write(spi, AD5624R_CMD_INTERNAL_REFER_SETUP, 0,
> +				!!voltage_uv, 16);
> +	if (ret)
> +		goto error_free_dev;
>  
>  	return 0;
>  
>  error_free_dev:
>  	iio_free_device(st->indio_dev);
> -error_free_st:
> +error_disable_reg:
> +	if (!IS_ERR(st->reg))
> +		regulator_disable(st->reg);
> +error_put_reg:
> +	if (!IS_ERR(st->reg))
> +		regulator_put(st->reg);
> +
>  	kfree(st);
>  error_ret:
>  	return ret;
> @@ -261,15 +302,24 @@ static int __devexit ad5624r_remove(struct spi_device *spi)
>  	struct ad5624r_state *st = spi_get_drvdata(spi);
>  
>  	iio_device_unregister(st->indio_dev);
> +
> +	if (!IS_ERR(st->reg)) {
> +		regulator_disable(st->reg);
> +		regulator_put(st->reg);
> +	}
> +
>  	kfree(st);
>  
>  	return 0;
>  }
>  
>  static const struct spi_device_id ad5624r_id[] = {
> -	{"ad5624r", 12},
> -	{"ad5644r", 14},
> -	{"ad5664r", 16},
> +	{"ad5624r3", ID_AD5624R3},
> +	{"ad5644r3", ID_AD5644R3},
> +	{"ad5664r3", ID_AD5664R3},
> +	{"ad5624r5", ID_AD5624R5},
> +	{"ad5644r5", ID_AD5644R5},
> +	{"ad5664r5", ID_AD5664R5},
>  	{}
>  };
>  

