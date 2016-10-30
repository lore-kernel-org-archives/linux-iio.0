Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43326 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757172AbcJ3RtS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 13:49:18 -0400
Subject: Re: [PATCH 02/10] staging: iio: tsl2583: check for error code from
 i2c_smbus_read_byte()
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
 <1477648821-3786-3-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com,
        Jon Brenner <Jon.Brenner@ams.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <f8b404c3-9b2a-e3fc-64e1-cb3d2a1ce1e4@kernel.org>
Date: Sun, 30 Oct 2016 17:49:15 +0000
MIME-Version: 1.0
In-Reply-To: <1477648821-3786-3-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/16 11:00, Brian Masney wrote:
> taos_i2c_read() and taos_als_calibrate() does not check to see if the
> value returned by i2c_smbus_read_byte() was an error code. This patch
> adds the appropriate error handling.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as testing for the autobuilders
to play with it.

Also Cc'd Jon on basis he might want to run his eye of these.
> ---
>  drivers/staging/iio/light/tsl2583.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index fd4b6ef..35c1696 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -171,7 +171,14 @@ taos_i2c_read(struct i2c_client *client, u8 reg, u8 *val, unsigned int len)
>  			return ret;
>  		}
>  		/* read the data */
> -		*val = i2c_smbus_read_byte(client);
> +		ret = i2c_smbus_read_byte(client);
> +		if (ret < 0) {
> +			dev_err(&client->dev,
> +				"%s failed to read byte after writing to register %x\n",
> +				__func__, reg);
> +			return ret;
> +		}
> +		*val = ret;
>  		val++;
>  		reg++;
>  	}
> @@ -355,6 +362,13 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  	}
>  
>  	reg_val = i2c_smbus_read_byte(chip->client);
> +	if (reg_val < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s failed to read after writing to the CNTRL register\n",
> +			__func__);
> +		return ret;
> +	}
> +
>  	if ((reg_val & (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON))
>  			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
> @@ -371,6 +385,12 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  	reg_val = i2c_smbus_read_byte(chip->client);
> +	if (reg_val < 0) {
> +		dev_err(&chip->client->dev,
> +			"%s failed to read after writing to the STATUS register\n",
> +			__func__);
> +		return ret;
> +	}
>  
>  	if ((reg_val & TSL258X_STA_ADC_VALID) != TSL258X_STA_ADC_VALID) {
>  		dev_err(&chip->client->dev,
> 

