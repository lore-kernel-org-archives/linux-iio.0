Return-Path: <lars@metafoo.de>
Subject: Re: [PATCH] iio: ak8975: add Vid regulator, use optional API
To: Linus Walleij <linus.walleij@linaro.org>,
 Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
 Crestez Dan Leonard <leonard.crestez@intel.com>
References: <1466091349-10307-1-git-send-email-linus.walleij@linaro.org>
Cc: Gregor Boirie <gregor.boirie@parrot.com>, Richard Leitner
 <dev@g0hl1n.net>, Krzysztof Kozlowski <k.kozlowski@samsung.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <5762C925.70005@metafoo.de>
Date: Thu, 16 Jun 2016 17:43:33 +0200
MIME-Version: 1.0
In-Reply-To: <1466091349-10307-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 06/16/2016 05:35 PM, Linus Walleij wrote:
[...]
> +	data->vdd = devm_regulator_get_optional(&client->dev, "vdd");
> +	if (!IS_ERR(data->vdd)) {

This ignores all errors silently and among other things breaks probe
deferral for the regulators.

>  		ret = regulator_enable(data->vdd);
> +		if (ret) {
> +			dev_warn(&client->dev,
> +				 "Failed to enable specified Vdd supply\n");
> +			return ret;
> +		}
>  	}
