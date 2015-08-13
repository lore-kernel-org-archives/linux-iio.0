Return-Path: <dmurphy@ti.com>
Message-ID: <55CD0611.5060606@ti.com>
Date: Thu, 13 Aug 2015 16:03:13 -0500
From: Dan Murphy <dmurphy@ti.com>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>,
        Jonathan Cameron
	<jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>
CC: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Krzysztof Kozlowski <k.kozlowski@samsung.com>,
        <linux-iio@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: Re: [patch] iio: tsl4531: fix error handling in tsl4531_check_id()
References: <20150813202027.GA4385@mwanda>
In-Reply-To: <20150813202027.GA4385@mwanda>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-iio@vger.kernel.org>

Dan

On 08/13/2015 03:21 PM, Dan Carpenter wrote:
> The caller expect us to return zero if the ID doesn't match.  Negative
> error codes are treated as success.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> diff --git a/drivers/iio/light/tsl4531.c b/drivers/iio/light/tsl4531.c
> index 2697918..730fd2b 100644
> --- a/drivers/iio/light/tsl4531.c
> +++ b/drivers/iio/light/tsl4531.c
> @@ -151,7 +151,7 @@ static int tsl4531_check_id(struct i2c_client *client)
>  {
>  	int ret = i2c_smbus_read_byte_data(client, TSL4531_ID);
>  	if (ret < 0)
> -		return ret;
> +		return 0;
>  
>  	switch (ret >> TSL4531_ID_SHIFT) {
>  	case TSL45311_ID:

Would this not be better to change the logic?

Zero return is generally true and non-zero is false.

Then this statement in the probe then can go from

    if (!tsl4531_check_id(client)) {
        dev_err(&client->dev, "no TSL4531 sensor\n");
        return -ENODEV;
    }

to

    if (tsl4531_check_id(client)) {
        dev_err(&client->dev, "no TSL4531 sensor\n");
        return -ENODEV;
    }

And if then return ret can be honored in probe.

Dan

-- 
------------------
Dan Murphy
