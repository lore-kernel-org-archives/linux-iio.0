Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52077 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750716AbaKPUUY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 16 Nov 2014 15:20:24 -0500
Message-ID: <54690706.4000609@kernel.org>
Date: Sun, 16 Nov 2014 20:20:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 2/4] iio: gyro: bmg160: Don't let interrupt mode to
 be open drain
References: <1412998408-31870-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1412998408-31870-3-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1412998408-31870-3-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 11/10/14 04:33, Srinivas Pandruvada wrote:
> Change the mode to push/pull type instead of open drain as some
> platforms fails to drive the GPIO pin with open drain.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Ultimately this might want to be configurable via device tree
or similar, but fair enough for now...

> ---
>  drivers/iio/gyro/bmg160.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/gyro/bmg160.c b/drivers/iio/gyro/bmg160.c
> index 22bf9db..fa2e376 100644
> --- a/drivers/iio/gyro/bmg160.c
> +++ b/drivers/iio/gyro/bmg160.c
> @@ -67,6 +67,9 @@
>  #define BMG160_REG_INT_EN_0		0x15
>  #define BMG160_DATA_ENABLE_INT		BIT(7)
>  
> +#define BMG160_REG_INT_EN_1		0x16
> +#define BMG160_INT1_BIT_OD		BIT(1)
> +
>  #define BMG160_REG_XOUT_L		0x02
>  #define BMG160_AXIS_TO_REG(axis)	(BMG160_REG_XOUT_L + (axis * 2))
>  
> @@ -222,6 +225,19 @@ static int bmg160_chip_init(struct bmg160_data *data)
>  	data->slope_thres = ret;
>  
>  	/* Set default interrupt mode */
> +	ret = i2c_smbus_read_byte_data(data->client, BMG160_REG_INT_EN_1);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_en_1\n");
> +		return ret;
> +	}
> +	ret &= ~BMG160_INT1_BIT_OD;
> +	ret = i2c_smbus_write_byte_data(data->client,
> +					BMG160_REG_INT_EN_1, ret);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error writing reg_int_en_1\n");
> +		return ret;
> +	}
> +
>  	ret = i2c_smbus_write_byte_data(data->client,
>  					BMG160_REG_INT_RST_LATCH,
>  					BMG160_INT_MODE_LATCH_INT |
> 

