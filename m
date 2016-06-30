Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43194 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcF3Tds (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:33:48 -0400
Subject: Re: [PATCH 1/6 v3] iio: magn: ak8975: fix regulator usage
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
 <1467202118-10386-2-git-send-email-linus.walleij@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Mark Brown <broonie@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <18d7da47-1ff2-f147-4ba7-5a34b9074d0f@kernel.org>
Date: Thu, 30 Jun 2016 20:33:44 +0100
MIME-Version: 1.0
In-Reply-To: <1467202118-10386-2-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/16 13:08, Linus Walleij wrote:
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
Applied to the togreg branch of iio.git - initially pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan
> ---
> ChangeLog v2->v3:
> - Fix the unrelated chunk removing the Vid regulator that
>   the next patch adds. Was basing development on a bad tree
>   and not looking close enough.
> ChangeLog v1->v2:
> - No changes
> ---
>  drivers/iio/magnetometer/ak8975.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 57d3654d7caf..7f51adba7bad 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -389,17 +389,16 @@ static int ak8975_power_on(struct i2c_client *client)
>  	int ret;
>  
>  	data->vdd = devm_regulator_get(&client->dev, "vdd");
> -	if (IS_ERR_OR_NULL(data->vdd)) {
> +	if (IS_ERR(data->vdd)) {
>  		ret = PTR_ERR(data->vdd);
> -		if (ret == -ENODEV)
> -			ret = 0;
>  	} else {
>  		ret = regulator_enable(data->vdd);
>  	}
> -
> -	if (ret)
> -		dev_err(&client->dev, "failed to enable Vdd supply: %d\n", ret);
> -	return ret;
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Failed to enable specified Vdd supply\n");
> +		return ret;
> +	}
>  }
>  
>  /* Disable attached power regulator if any. */
> @@ -408,8 +407,7 @@ static void ak8975_power_off(const struct i2c_client *client)
>  	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	const struct ak8975_data *data = iio_priv(indio_dev);
>  
> -	if (!IS_ERR_OR_NULL(data->vdd))
> -		regulator_disable(data->vdd);
> +	regulator_disable(data->vdd);
>  }
>  
>  /*
> 

