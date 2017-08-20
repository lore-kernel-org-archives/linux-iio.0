Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbdHTK0F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 20 Aug 2017 06:26:05 -0400
Date: Sun, 20 Aug 2017 11:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/4] iio: magnetometer: ak8974: support AMI306 variant
Message-ID: <20170820111919.0715e934@archlinux>
In-Reply-To: <08c8d801038d021e3932c97823d6cbe420cee98e.1502977929.git.mirq-linux@rere.qmqm.pl>
References: <cover.1502977929.git.mirq-linux@rere.qmqm.pl>
        <08c8d801038d021e3932c97823d6cbe420cee98e.1502977929.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 17 Aug 2017 15:56:10 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Add support for AMI306 magnetometer - very similar to AMI305.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/magnetometer/Kconfig  |  4 +-
>  drivers/iio/magnetometer/ak8974.c | 90 ++++++++++++++++++++++++++++++---------
>  2 files changed, 72 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetometer/Kconfig
> index 421ad90a5fbe..ed9d776d01af 100644
> --- a/drivers/iio/magnetometer/Kconfig
> +++ b/drivers/iio/magnetometer/Kconfig
> @@ -13,8 +13,8 @@ config AK8974
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  Say yes here to build support for Asahi Kasei AK8974 or
> -	  AMI305 I2C-based 3-axis magnetometer chips.
> +	  Say yes here to build support for Asahi Kasei AK8974, AMI305 or
> +	  AMI306 I2C-based 3-axis magnetometer chips.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ak8974.
> diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
> index e13370dc9b1c..76091da20a0c 100644
> --- a/drivers/iio/magnetometer/ak8974.c
> +++ b/drivers/iio/magnetometer/ak8974.c
> @@ -36,7 +36,7 @@
>   * and MSB is at the next higher address.
>   */
>  
> -/* These registers are common for AK8974 and AMI305 */
> +/* These registers are common for AK8974 and AMI30x */
>  #define AK8974_SELFTEST		0x0C
>  #define AK8974_SELFTEST_IDLE	0x55
>  #define AK8974_SELFTEST_OK	0xAA
> @@ -44,6 +44,7 @@
>  #define AK8974_INFO		0x0D
>  
>  #define AK8974_WHOAMI		0x0F
> +#define AK8974_WHOAMI_VALUE_AMI306 0x46
>  #define AK8974_WHOAMI_VALUE_AMI305 0x47
>  #define AK8974_WHOAMI_VALUE_AK8974 0x48
>  
> @@ -73,6 +74,35 @@
>  #define AK8974_TEMP		0x31
>  #define AMI305_TEMP		0x60
>  
> +/* AMI306-specific control register */
> +#define AMI306_CTRL4		0x5C
> +
> +/* AMI306 factory calibration data */
> +
> +/* fine axis sensitivity */
> +#define AMI306_FINEOUTPUT_X	0x90
> +#define AMI306_FINEOUTPUT_Y	0x92
> +#define AMI306_FINEOUTPUT_Z	0x94
> +
> +/* axis sensitivity */
> +#define AMI306_SENS_X		0x96
> +#define AMI306_SENS_Y		0x98
> +#define AMI306_SENS_Z		0x9A
> +
> +/* axis cross-interference */
> +#define AMI306_GAIN_PARA_XZ	0x9C
> +#define AMI306_GAIN_PARA_XY	0x9D
> +#define AMI306_GAIN_PARA_YZ	0x9E
> +#define AMI306_GAIN_PARA_YX	0x9F
> +#define AMI306_GAIN_PARA_ZY	0xA0
> +#define AMI306_GAIN_PARA_ZX	0xA1
> +
> +/* offset at ZERO magnetic field */
> +#define AMI306_OFFZERO_X	0xF8
> +#define AMI306_OFFZERO_Y	0xFA
> +#define AMI306_OFFZERO_Z	0xFC
> +
> +
>  #define AK8974_INT_X_HIGH	BIT(7) /* Axis over +threshold  */
>  #define AK8974_INT_Y_HIGH	BIT(6)
>  #define AK8974_INT_Z_HIGH	BIT(5)
> @@ -158,6 +188,26 @@ struct ak8974 {
>  static const char ak8974_reg_avdd[] = "avdd";
>  static const char ak8974_reg_dvdd[] = "dvdd";
>  
> +static int ak8974_get_u16_val(struct ak8974 *ak8974, u8 reg, u16 *val)
> +{
> +	int ret;
> +	__le16 bulk;
> +
> +	ret = regmap_bulk_read(ak8974->map, reg, &bulk, 2);
> +	if (ret)
> +		return ret;
> +	*val = le16_to_cpu(bulk);
> +
> +	return 0;
> +}
> +
> +static int ak8974_set_u16_val(struct ak8974 *ak8974, u8 reg, u16 val)
> +{
> +	__le16 bulk = cpu_to_le16(val);
> +
> +	return regmap_bulk_write(ak8974->map, reg, &bulk, 2);
> +}
> +
>  static int ak8974_set_power(struct ak8974 *ak8974, bool mode)
>  {
>  	int ret;
> @@ -209,6 +259,12 @@ static int ak8974_configure(struct ak8974 *ak8974)
>  	ret = regmap_write(ak8974->map, AK8974_CTRL3, 0);
>  	if (ret)
>  		return ret;
> +	if (ak8974->variant == AK8974_WHOAMI_VALUE_AMI306) {
> +		/* magic from datasheet: set high-speed measurement mode */
> +		ret = ak8974_set_u16_val(ak8974, AMI306_CTRL4, 0xA07E);
> +		if (ret)
> +			return ret;
> +	}
>  	ret = regmap_write(ak8974->map, AK8974_INT_CTRL, AK8974_INT_CTRL_POL);
>  	if (ret)
>  		return ret;
> @@ -388,19 +444,6 @@ static int ak8974_selftest(struct ak8974 *ak8974)
>  	return 0;
>  }
>  
> -static int ak8974_get_u16_val(struct ak8974 *ak8974, u8 reg, u16 *val)
> -{
> -	int ret;
> -	__le16 bulk;
> -
> -	ret = regmap_bulk_read(ak8974->map, reg, &bulk, 2);
> -	if (ret)
> -		return ret;
> -	*val = le16_to_cpu(bulk);
> -
> -	return 0;
> -}
> -
>  static int ak8974_detect(struct ak8974 *ak8974)
>  {
>  	unsigned int whoami;
> @@ -413,9 +456,13 @@ static int ak8974_detect(struct ak8974 *ak8974)
>  	if (ret)
>  		return ret;
>  
> +	name = "ami305";
> +
>  	switch (whoami) {
> +	case AK8974_WHOAMI_VALUE_AMI306:
> +		name = "ami306";
> +		/* fall-through */
>  	case AK8974_WHOAMI_VALUE_AMI305:
> -		name = "ami305";
>  		ret = regmap_read(ak8974->map, AMI305_VER, &fw);
>  		if (ret)
>  			return ret;
> @@ -602,9 +649,11 @@ static bool ak8974_writeable_reg(struct device *dev, unsigned int reg)
>  	case AMI305_OFFSET_Y + 1:
>  	case AMI305_OFFSET_Z:
>  	case AMI305_OFFSET_Z + 1:
> -		if (ak8974->variant == AK8974_WHOAMI_VALUE_AMI305)
> -			return true;
> -		return false;
> +		return ak8974->variant == AK8974_WHOAMI_VALUE_AMI305 ||
> +		       ak8974->variant == AK8974_WHOAMI_VALUE_AMI306;
> +	case AMI306_CTRL4:
> +	case AMI306_CTRL4 + 1:
> +		return ak8974->variant == AK8974_WHOAMI_VALUE_AMI306;
>  	default:
>  		return false;
>  	}
> @@ -678,7 +727,7 @@ static int ak8974_probe(struct i2c_client *i2c,
>  
>  	ret = ak8974_detect(ak8974);
>  	if (ret) {
> -		dev_err(&i2c->dev, "neither AK8974 nor AMI305 found\n");
> +		dev_err(&i2c->dev, "neither AK8974 nor AMI30x found\n");
>  		goto power_off;
>  	}
>  
> @@ -827,6 +876,7 @@ static const struct dev_pm_ops ak8974_dev_pm_ops = {
>  
>  static const struct i2c_device_id ak8974_id[] = {
>  	{"ami305", 0 },
> +	{"ami306", 0 },
>  	{"ak8974", 0 },
>  	{}
>  };
> @@ -850,7 +900,7 @@ static struct i2c_driver ak8974_driver = {
>  };
>  module_i2c_driver(ak8974_driver);
>  
> -MODULE_DESCRIPTION("AK8974 and AMI305 3-axis magnetometer driver");
> +MODULE_DESCRIPTION("AK8974 and AMI30x 3-axis magnetometer driver");
>  MODULE_AUTHOR("Samu Onkalo");
>  MODULE_AUTHOR("Linus Walleij");
>  MODULE_LICENSE("GPL v2");

