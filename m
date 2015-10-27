Return-Path: <joe@perches.com>
Message-ID: <1445973507.2757.40.camel@perches.com>
Subject: Re: [PATCH 2/3] iio: light: lm3533-als: Print error message on
 invalid resistance
From: Joe Perches <joe@perches.com>
To: Bjorn Andersson <bjorn.andersson@sonymobile.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>, Johan Hovold <jhovold@gmail.com>,
 Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-arm-kernel@lists.infradead.org
Date: Tue, 27 Oct 2015 12:18:27 -0700
In-Reply-To: <1445796586-28683-2-git-send-email-bjorn.andersson@sonymobile.com>
References: 
	<1445796586-28683-1-git-send-email-bjorn.andersson@sonymobile.com>
	 <1445796586-28683-2-git-send-email-bjorn.andersson@sonymobile.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

On Sun, 2015-10-25 at 11:09 -0700, Bjorn Andersson wrote:
> Print an error message to indicate that invalid configuration data was
> provided in the platform_data, rather than just aborting initialization.

Perhaps it'd be nicer to show the 3 values.

> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
[]
> @@ -743,8 +743,10 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
>  {
>  	int ret;
>  
> -	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX)
> +	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
> +		dev_err(&als->pdev->dev, "invalid resistor value\n");
>  		return -EINVAL;
> +	};
>  
>  	ret = lm3533_write(als->lm3533, LM3533_REG_ALS_RESISTOR_SELECT, val);
>  	if (ret) {
