Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47081 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752023AbcFZOJJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Jun 2016 10:09:09 -0400
Subject: Re: [PATCH 2/6 v2] iio: magn: ak8975: add Vid regulator
To: Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org
References: <1466759516-20586-1-git-send-email-linus.walleij@linaro.org>
 <1466759516-20586-3-git-send-email-linus.walleij@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Gregor Boirie <gregor.boirie@parrot.com>,
	Richard Leitner <dev@g0hl1n.net>,
	Krzysztof Kozlowski <k.kozlowski@samsung.com>,
	Gwendal Grignou <gwendal@chromium.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7d634578-e816-6528-e5e8-92b46a79d234@kernel.org>
Date: Sun, 26 Jun 2016 15:09:07 +0100
MIME-Version: 1.0
In-Reply-To: <1466759516-20586-3-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/06/16 10:11, Linus Walleij wrote:
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
This didn't go on cleanly but the fix is simple.

Somewhere along the way the text in one of the messages changed...

If you could check this out in the testing branch of iio.git that
would be great.

Might need a followup patch to cleanup that message.

What fun ;)

Jonathan
> ---
> ChangeLog v2->v3:
> - No changes. Numbered v2 to be part of the patch set.
> ChangeLog v1->v2:
> - Just obtain the other regulator exactly like the first without
>   trying to be fancy.
> - Rebase and rewrite on top of the patch fixing up the regulator
>   usage.
> ---
>  drivers/iio/magnetometer/ak8975.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 05e9d5041e7a..62f73d9d38b4 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -400,6 +400,19 @@ static int ak8975_power_on(struct i2c_client *client)
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
> @@ -408,6 +421,7 @@ static void ak8975_power_off(const struct i2c_client *client)
>  	const struct iio_dev *indio_dev = i2c_get_clientdata(client);
>  	const struct ak8975_data *data = iio_priv(indio_dev);
>  
> +	regulator_disable(data->vid);
>  	regulator_disable(data->vdd);
>  }
>  
> 

