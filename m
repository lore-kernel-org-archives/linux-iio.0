Return-Path: <jic23@cam.ac.uk>
Message-ID: <4E69D435.6040104@cam.ac.uk>
Date: Fri, 09 Sep 2011 09:54:13 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: greg@kroah.com, grundler@google.com, devel@linuxdriverproject.org,
 linux-iio@vger.kernel.org, bfreed@chromium.org, grundler@chromium.org
Subject: Re: [PATCH] [PATCH] staging:iio:light: V3 fix out of bounds reg_cache[]
 access
References: <20110906230533.GA5882@kroah.com> <1315558385-12879-1-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1315558385-12879-1-git-send-email-jic23@cam.ac.uk>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

Grant, please take a quick look at this and check I didn't mess anything up.
Looks like a trivial context change was the issue, but best to be sure!
> V3 is a straightforward forward port to teh current tree of V2.
> 
> Simple fix is to just not cache REG_TEST (offset 8).
> Cache doesn't help REG_TEST anyway since we write all 8 bits exactly once
> (at resume/init time).
> 
> Also fix an "off-by-one" allocation of reg_cache[] array size that
> was in the original code before I touched it.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
> Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/light/isl29018.c |   23 ++++++++++++++---------
>  1 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index f31e8c2..3e9a06c 100644
> --- a/drivers/staging/iio/light/isl29018.c
> +++ b/drivers/staging/iio/light/isl29018.c
> @@ -51,7 +51,7 @@
>  
>  #define ISL29018_REG_ADD_DATA_LSB	0x02
>  #define ISL29018_REG_ADD_DATA_MSB	0x03
> -#define ISL29018_MAX_REGS		ISL29018_REG_ADD_DATA_MSB
> +#define ISL29018_MAX_REGS		(ISL29018_REG_ADD_DATA_MSB+1)
>  
>  #define ISL29018_REG_TEST		0x08
>  #define ISL29018_TEST_SHIFT		0
> @@ -70,22 +70,27 @@ struct isl29018_chip {
>  static int isl29018_write_data(struct i2c_client *client, u8 reg,
>  			u8 val, u8 mask, u8 shift)
>  {
> -	u8 regval;
> -	int ret = 0;
> +	u8 regval = val;
> +	int ret;
>  	struct isl29018_chip *chip = iio_priv(i2c_get_clientdata(client));
>  
> -	regval = chip->reg_cache[reg];
> -	regval &= ~mask;
> -	regval |= val << shift;
> +	/* don't cache or mask REG_TEST */
> +	if (reg < ISL29018_MAX_REGS) {
> +		regval = chip->reg_cache[reg];
> +		regval &= ~mask;
> +		regval |= val << shift;
> +	}
>  
>  	ret = i2c_smbus_write_byte_data(client, reg, regval);
>  	if (ret) {
>  		dev_err(&client->dev, "Write to device fails status %x\n", ret);
> -		return ret;
> +	} else {
> +		/* don't update cache on err */
> +		if (reg < ISL29018_MAX_REGS)
> +			chip->reg_cache[reg] = regval;
>  	}
> -	chip->reg_cache[reg] = regval;
>  
> -	return 0;
> +	return ret;
>  }
>  
>  static int isl29018_set_range(struct i2c_client *client, unsigned long range,
