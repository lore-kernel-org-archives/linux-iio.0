Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43211 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280AbcF3TfD (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2016 15:35:03 -0400
Subject: Re: [PATCH 2/6 v3] iio: magn: ak8975: add Vid regulator
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1467202118-10386-1-git-send-email-linus.walleij@linaro.org>
 <1467202118-10386-3-git-send-email-linus.walleij@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <066aa5ca-b407-e00e-71d4-af75822c8dd2@kernel.org>
Date: Thu, 30 Jun 2016 20:35:01 +0100
MIME-Version: 1.0
In-Reply-To: <1467202118-10386-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 29/06/16 13:08, Linus Walleij wrote:
> The AK8975 has two power sources: Vdd (analog voltage supply)
> and Vid (digital voltage supply). Optionally also obtain the Vid
> supply regulator and enable it.
> 
> If an error occurs when enabling one of the regulators: bail out.
> 
> Cc: Gregor Boirie <gregor.boirie@parrot.com>
> Cc: Richard Leitner <dev@g0hl1n.net>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Applied. Thanks
> ---
> ChangeLog v2->v3:
> - No changes. Numbered v2 to be part of the patch set.
> - Rebase.
> ChangeLog v1->v2:
> - Just obtain the other regulator exactly like the first without
>   trying to be fancy.
> - Rebase and rewrite on top of the patch fixing up the regulator
>   usage.
> ---
>  drivers/iio/magnetometer/ak8975.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 7f51adba7bad..af3395a0fb16 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -379,6 +379,7 @@ struct ak8975_data {
>  	u8			cntl_cache;
>  	struct iio_mount_matrix orientation;
>  	struct regulator	*vdd;
> +	struct regulator	*vid;
>  };
>  
>  /* Enable attached power regulator if any. */
> @@ -399,6 +400,19 @@ static int ak8975_power_on(struct i2c_client *client)
>  			 "Failed to enable specified Vdd supply\n");
>  		return ret;
>  	}
> +
> +	data->vid = devm_regulator_get(&client->dev, "vid");
> +	if (IS_ERR(data->vid)) {
> +		ret = PTR_ERR(data->vid);
> +	} else {
> +		ret = regulator_enable(data->vid);
> +	}
> +	if (ret) {
> +		dev_warn(&client->dev,
> +			 "Failed to enable specified Vid supply\n");
> +		return ret;
> +	}
> +	return 0;
>  }
>  
>  /* Disable attached power regulator if any. */
> @@ -407,6 +421,7 @@ static void ak8975_power_off(const struct i2c_client *client)
>  	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	const struct ak8975_data *data = iio_priv(indio_dev);
>  
> +	regulator_disable(data->vid);
>  	regulator_disable(data->vdd);
>  }
>  
> 

