Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:26038 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751244AbcFVLuM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 22 Jun 2016 07:50:12 -0400
Message-ID: <576A7C28.70905@parrot.com>
Date: Wed, 22 Jun 2016 13:53:12 +0200
From: Gregor Boirie <gregor.boirie@parrot.com>
MIME-Version: 1.0
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	<linux-iio@vger.kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/5] iio: magn: ak8975: fix regulator usage
References: <1466547498-15484-1-git-send-email-linus.walleij@linaro.org> <1466547498-15484-2-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1466547498-15484-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



On 06/22/2016 12:18 AM, Linus Walleij wrote:
> IS_ERR_OR_NULL() should never be used with regulators because
> a NULL pointer may be a perfectly valid dummy regulator
>
> We should always succeed to fetch and enable a regulator, but
> it may be a dummy. That is fine, so bail out for any real
> errors or probe deferrals
>
> Include the error code in the warning print so we know what
> kind of problem we're dealing with (for example it is nice to
> see if it is a probe deferral).
>
> As we will bail out of probe if the regulator is erroneous,
> just issue regulator_disable() on the poweroff path: it will
> succeed.
>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Lars-Peter Clausen Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>   drivers/iio/magnetometer/ak8975.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 609a2c401b5d..bc0770205b2d 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -389,17 +389,17 @@ static int ak8975_power_on(struct i2c_client *client)
>   	int ret;
>   
>   	data->vdd = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR_OR_NULL(data->vdd)) {
> +	if (IS_ERR(data->vdd)) {
>   		ret = PTR_ERR(data->vdd);
> -		if (ret == -ENODEV)
> -			ret = 0;
what if dummy supplies are not allowed and regulator is not declared / 
found into device tree ?

I have no such regulator on some boards, just a main power supply that 
is not driven by soft.
How should this be handled in this case ?
>   	} else {
>   		ret = regulator_enable(data->vdd);
>   	}
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Failed to enable specified Vdd supply\n");
> +		return ret;
> +	}
>   
> -	if (ret)
> -		dev_err(&client->dev, "failed to enable Vdd supply: %d\n", ret);
> -	return ret;
>   }
>   
>   /* Disable attached power regulator if any. */
> @@ -408,8 +408,7 @@ static void ak8975_power_off(const struct i2c_client *client)
>   	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
>   	const struct ak8975_data *data = iio_priv(indio_dev);
>   
> -	if (!IS_ERR_OR_NULL(data->vdd))
> -		regulator_disable(data->vdd);
> +	regulator_disable(data->vdd);
>   }
>   
>   /*

