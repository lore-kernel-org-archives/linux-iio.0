Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53703 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964798AbcJVRTB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:19:01 -0400
Subject: Re: [PATCH 1/7] iio: light: tsl2583: return proper error code
To: Brian Masney <masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <58a42ca5-47d3-59b1-f01b-c6ed50f7c2f3@kernel.org>
Date: Sat, 22 Oct 2016 18:18:59 +0100
MIME-Version: 1.0
In-Reply-To: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 11:32, Brian Masney wrote:
> taos_gain_store() and taos_als_calibrate() both have a code path where
> -1 was returned. This patch changes the code so that a proper error code
> is returned to make the code consistent with the error paths that are
> present within those same functions.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---
>  drivers/staging/iio/light/tsl2583.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 08f1583..1e42a19 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -359,7 +359,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
> -		return -1;
> +		return -ENODATA;
Hmm. Not sure about this as the error value.  Perhaps a simple -EINVAL?

Also, this is still eating the possible error returned directly by
i2c_smbus_read_byte - would you mind fixing that whilst we are here?
>  	}
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> @@ -569,7 +569,7 @@ static ssize_t taos_gain_store(struct device *dev,
>  		break;
>  	default:
>  		dev_err(dev, "Invalid Gain Index (must be 1,8,16,111)\n");
> -		return -1;
> +		return -EINVAL;
>  	}
>  
>  	return len;
> 

