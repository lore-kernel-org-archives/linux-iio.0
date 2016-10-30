Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43333 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756869AbcJ3RuH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Oct 2016 13:50:07 -0400
Subject: Re: [PATCH 03/10] staging: iio: tsl2583: return proper error code
 instead of -1
To: Brian Masney <masneyb@onstation.org>, linux-iio@vger.kernel.org
References: <1477648821-3786-1-git-send-email-masneyb@onstation.org>
 <1477648821-3786-4-git-send-email-masneyb@onstation.org>
Cc: devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        lars@metafoo.de, pmeerw@pmeerw.net, knaack.h@gmx.de,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, Mark.Rutland@arm.com
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5c1b8527-91e9-e5df-8c0a-2e39d405fb15@kernel.org>
Date: Sun, 30 Oct 2016 17:50:05 +0000
MIME-Version: 1.0
In-Reply-To: <1477648821-3786-4-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/10/16 11:00, Brian Masney wrote:
> taos_als_calibrate() has a code path where -1 is returned. This patch
> changes the code so that a proper error code is returned.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied to the togreg branch of iio.git and pushed out as
testing for the autobuilders to play with it.
(I'm going to begin to get lazy on this message ;)
> ---
>  drivers/staging/iio/light/tsl2583.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 35c1696..47fd373 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -373,7 +373,7 @@ static int taos_als_calibrate(struct iio_dev *indio_dev)
>  			!= (TSL258X_CNTL_ADC_ENBL | TSL258X_CNTL_PWR_ON)) {
>  		dev_err(&chip->client->dev,
>  			"taos_als_calibrate failed: device not powered on with ADC enabled\n");
> -		return -1;
> +		return -EINVAL;
>  	}
>  
>  	ret = i2c_smbus_write_byte(chip->client,
> 

