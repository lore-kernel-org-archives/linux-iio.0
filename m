Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:58596 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755601Ab1HaNdB (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 31 Aug 2011 09:33:01 -0400
Message-ID: <4E5E39F7.8040203@cam.ac.uk>
Date: Wed, 31 Aug 2011 14:41:11 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Grant Grundler <grundler@google.com>
CC: Greg Kroah-Hartman <greg@kroah.com>, devel@linuxdriverproject.org,
	linux-iio@vger.kernel.org, bfreed@chromium.org,
	grundler@chromium.org
Subject: Re: [PATCH] STAGING:iio:light: V2 fix out of bounds reg_cache[] access
References: <20110830235546.3135B208185@grundler.mtv.corp.google.com>
In-Reply-To: <20110830235546.3135B208185@grundler.mtv.corp.google.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/31/11 00:55, Grant Grundler wrote:
> V2 Fix out-of-bounds reference to reg_cache[]
> 
> Simple fix is to just not cache REG_TEST (offset 8).
> Cache doesn't help REG_TEST anyway since we write all 8 bits exactly once
> (at resume/init time).
> 
> Also fix an "off-by-one" allocation of reg_cache[] array size that
> was in the original code before I touched it.
> 
Looks good to me. Thanks.
> Reported-by: Dan Carpenter <error27@gmail.com>
> Signed-off-by: Grant Grundler <grundler@chromium.org>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> 
> ----
> Thanks again to Dan Carpenter for spotting the out-of-bounds array reference.
> V2 preserves "don't touch reg_cache[] on error" behavior.
> 
> diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
> index 0f97734..b24d28c 100644
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
> @@ -71,22 +71,27 @@ struct isl29018_chip {
>  static int isl29018_write_data(struct i2c_client *client, u8 reg,
>  			u8 val, u8 mask, u8 shift)
>  {
> -	u8 regval;
> -	int ret = 0;
> +	u8 regval = val;
> +	int ret;
>  	struct isl29018_chip *chip = i2c_get_clientdata(client);
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
> -	if (ret) {
> +	if (ret)
>  		dev_err(&client->dev, "Write to device fails status %x\n", ret);
> -		return ret;
> +	else {
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

