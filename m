Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-122.synserver.de ([212.40.185.122]:1539 "EHLO
	smtp-out-101.synserver.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751815Ab3BJKT2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 10 Feb 2013 05:19:28 -0500
Message-ID: <51177476.3010307@metafoo.de>
Date: Sun, 10 Feb 2013 11:20:38 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>,
	Laxman Dewangan <ldewangan@nvidia.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:magnetometer:ak8975 move out of staging
References: <1360428941-5130-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1360428941-5130-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 02/09/2013 05:55 PM, Jonathan Cameron wrote:
> This driver has been clean and correct for quite some time.
> It is simple and uses only straight forward standard
> interfaces.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>

Two comments, which don't necessarily need to be addressed before moving it
out of staging, but should probably should be fixed at some point.

> ---
>  drivers/iio/magnetometer/Kconfig          |  11 +
>  drivers/iio/magnetometer/Makefile         |   1 +
>  drivers/iio/magnetometer/ak8975.c         | 520 ++++++++++++++++++++++++++++++
>  drivers/staging/iio/magnetometer/Kconfig  |  11 -
>  drivers/staging/iio/magnetometer/Makefile |   1 -
>  drivers/staging/iio/magnetometer/ak8975.c | 520 ------------------------------
>  6 files changed, 532 insertions(+), 532 deletions(-)
> 
[...]
> +struct ak8975_data {
> +	struct i2c_client	*client;
> +	struct attribute_group	attrs;
> +	struct mutex		lock;
> +	u8			asa[3];
> +	long			raw_to_gauss[3];
> +	u8			reg_cache[AK8975_MAX_REGS];
> +	int			eoc_gpio;
> +	int			eoc_irq;

eoc_irq is never really used.

> +};
> +
> +static const int ak8975_index_to_reg[] = {
> +	AK8975_REG_HXL, AK8975_REG_HYL, AK8975_REG_HZL,
> +};
> +
> +/*
> + * Helper function to write to the I2C device's registers.
> + */
> +static int ak8975_write_data(struct i2c_client *client,
> +			     u8 reg, u8 val, u8 mask, u8 shift)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> +	struct ak8975_data *data = iio_priv(indio_dev);
> +	u8 regval;
> +	int ret;
> +
> +	regval = (data->reg_cache[reg] & ~mask) | (val << shift);
> +	ret = i2c_smbus_write_byte_data(client, reg, regval);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "Write to device fails status %x\n", ret);
> +		return ret;
> +	}
> +	data->reg_cache[reg] = regval;

The reg cache is written to here, but it is never read from again. It may
make sense to convert the driver to using regmap instead of open-coding the
register read/write functions.

> +
> +	return 0;
> +}
> +
[...]

