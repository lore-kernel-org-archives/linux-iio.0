Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42824 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937197AbdAHJng (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 04:43:36 -0500
Subject: Re: [PATCH 04/19] staging: iio: isl29028: add power management
 support
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1480817983-32359-1-git-send-email-masneyb@onstation.org>
 <1480817983-32359-5-git-send-email-masneyb@onstation.org>
Cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-kernel@vger.kernel.org, ldewangan@nvidia.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <299bdab4-0cbb-3581-014f-9bb10fd86e81@kernel.org>
Date: Sun, 4 Dec 2016 11:37:59 +0000
MIME-Version: 1.0
In-Reply-To: <1480817983-32359-5-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/12/16 02:19, Brian Masney wrote:
> This patch adds power management support to the isl29028 driver.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Hmm. I'm not sure why we need the suspended boolean.

I 'think' it's impossible to have a sysfs read in progress during suspend or resume.
At least I hope it is as a lot of drivers will be broken otherwise :(

Looks like this particular corner is only really present in light sensor drivers...

Jonathan

> ---
>  drivers/staging/iio/light/isl29028.c | 59 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/staging/iio/light/isl29028.c b/drivers/staging/iio/light/isl29028.c
> index 4f819a8..e96a8cb 100644
> --- a/drivers/staging/iio/light/isl29028.c
> +++ b/drivers/staging/iio/light/isl29028.c
> @@ -75,6 +75,7 @@ struct isl29028_chip {
>  
>  	int			lux_scale;
>  	enum isl29028_als_ir_mode	als_ir_mode;
> +	bool				suspended;
>  };
>  
>  static int isl29028_set_proxim_sampling(struct isl29028_chip *chip,
> @@ -274,6 +275,12 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  	int ret = -EINVAL;
>  
>  	mutex_lock(&chip->lock);
> +
> +	if (chip->suspended) {
> +		ret = -EBUSY;
> +		goto write_done;
> +	}
> +
>  	switch (chan->type) {
>  	case IIO_PROXIMITY:
>  		if (mask != IIO_CHAN_INFO_SAMP_FREQ) {
> @@ -322,6 +329,8 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
>  		dev_err(dev, "Unsupported channel type\n");
>  		break;
>  	}
> +
> +write_done:
>  	mutex_unlock(&chip->lock);
>  	return ret;
>  }
> @@ -335,6 +344,12 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  	int ret = -EINVAL;
>  
>  	mutex_lock(&chip->lock);
> +
> +	if (chip->suspended) {
> +		ret = -EBUSY;
> +		goto read_done;
> +	}
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  	case IIO_CHAN_INFO_PROCESSED:
> @@ -374,6 +389,8 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
>  		dev_err(dev, "mask value 0x%08lx not supported\n", mask);
>  		break;
>  	}
> +
> +read_done:
>  	mutex_unlock(&chip->lock);
>  	return ret;
>  }
> @@ -437,6 +454,9 @@ static int isl29028_chip_init_and_power_on(struct isl29028_chip *chip)
>  	ret = isl29028_set_als_scale(chip, chip->lux_scale);
>  	if (ret < 0)
>  		dev_err(dev, "setting als scale failed, err = %d\n", ret);
> +
> +	chip->suspended = false;
> +
>  	return ret;
>  }
>  
> @@ -479,6 +499,7 @@ static int isl29028_probe(struct i2c_client *client,
>  
>  	i2c_set_clientdata(client, indio_dev);
>  	mutex_init(&chip->lock);
> +	chip->suspended = true;
>  
>  	chip->regmap = devm_regmap_init_i2c(client, &isl29028_regmap_config);
>  	if (IS_ERR(chip->regmap)) {
> @@ -530,6 +551,43 @@ static int isl29028_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> +static int __maybe_unused isl29028_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct isl29028_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = regmap_write(chip->regmap, ISL29028_REG_CONFIGURE, 0x0);
> +	if (ret < 0)
> +		dev_err(dev, "%s(): Error %d turning off chip\n", __func__,
> +			ret);
> +
> +	chip->suspended = true;
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static int __maybe_unused isl29028_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct isl29028_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +
> +	mutex_lock(&chip->lock);
> +
> +	ret = isl29028_chip_init_and_power_on(chip);
> +
> +	mutex_unlock(&chip->lock);
> +
> +	return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(isl29028_pm_ops, isl29028_suspend, isl29028_resume);
> +
>  static const struct i2c_device_id isl29028_id[] = {
>  	{"isl29028", 0},
>  	{}
> @@ -546,6 +604,7 @@ MODULE_DEVICE_TABLE(of, isl29028_of_match);
>  static struct i2c_driver isl29028_driver = {
>  	.driver  = {
>  		.name = "isl29028",
> +		.pm = &isl29028_pm_ops,
>  		.of_match_table = isl29028_of_match,
>  	},
>  	.probe	 = isl29028_probe,
> 

