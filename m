Return-Path: <sathyanarayanan.kuppuswamy@linux.intel.com>
Reply-To: sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH] iio: light: jsa1212: remove unneeded i2c check
 functionality test
References: <20160515183717.GA2674@d830.WORKGROUP>
To: Alison Schofield <amsfield22@gmail.com>, jic23@kernel.org
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net, mranostay@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: sathyanarayanan kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <573E07EA.8050007@linux.intel.com>
Date: Thu, 19 May 2016 11:37:30 -0700
MIME-Version: 1.0
In-Reply-To: <20160515183717.GA2674@d830.WORKGROUP>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Looks Good.

Reviewed-by:Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


On 05/15/2016 11:37 AM, Alison Schofield wrote:
> This driver does not call i2c_smbus_read|write_byte_data(),
> so remove the corresponding functionality test. It uses regmap
> to handle byte transfers transparently.
>
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
> Found & fixed by inspection based on same defect recently fixed
> in light/tpl0102 driver.
>
>
>   drivers/iio/light/jsa1212.c | 3 ---
>   1 file changed, 3 deletions(-)
>
> diff --git a/drivers/iio/light/jsa1212.c b/drivers/iio/light/jsa1212.c
> index 99a6281..e8a8931 100644
> --- a/drivers/iio/light/jsa1212.c
> +++ b/drivers/iio/light/jsa1212.c
> @@ -325,9 +325,6 @@ static int jsa1212_probe(struct i2c_client *client,
>   	struct regmap *regmap;
>   	int ret;
>   
> -	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_BYTE_DATA))
> -		return -EOPNOTSUPP;
> -
>   	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>   	if (!indio_dev)
>   		return -ENOMEM;

-- 
Sathyanarayanan Kuppuswamy
Android kernel developer
