Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:42743 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754851AbaFUKfg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 21 Jun 2014 06:35:36 -0400
Message-ID: <53A5606F.8000103@kernel.org>
Date: Sat, 21 Jun 2014 11:37:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Wei Yongjun <yongjun_wei@trendmicro.com.cn>,
	Sachin Kamat <sachin.kamat@linaro.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [patch] staging: iio/ad7291: fix error code in ad7291_probe()
References: <20140620192234.GD19824@mwanda>
In-Reply-To: <20140620192234.GD19824@mwanda>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 20/06/14 20:22, Dan Carpenter wrote:
> We should be returning a negative error code instead of success here.
>
> This would have been detected by GCC, except that the "ret" variable was
> initialized with a bogus value to disable GCC's uninitialized variable
> warnings.  I've cleaned that up, as well.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Applied to the fixes-togreg branch of iio.git and cc'd to stable.

Thanks,

Jonathan
>
> diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
> index 357cef2..7194bd1 100644
> --- a/drivers/staging/iio/adc/ad7291.c
> +++ b/drivers/staging/iio/adc/ad7291.c
> @@ -465,7 +465,7 @@ static int ad7291_probe(struct i2c_client *client,
>   	struct ad7291_platform_data *pdata = client->dev.platform_data;
>   	struct ad7291_chip_info *chip;
>   	struct iio_dev *indio_dev;
> -	int ret = 0;
> +	int ret;
>
>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
>   	if (!indio_dev)
> @@ -475,7 +475,7 @@ static int ad7291_probe(struct i2c_client *client,
>   	if (pdata && pdata->use_external_ref) {
>   		chip->reg = devm_regulator_get(&client->dev, "vref");
>   		if (IS_ERR(chip->reg))
> -			return ret;
> +			return PTR_ERR(chip->reg);
>
>   		ret = regulator_enable(chip->reg);
>   		if (ret)
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

