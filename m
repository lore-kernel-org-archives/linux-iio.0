Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43559 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab3BBKIt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 2 Feb 2013 05:08:49 -0500
Message-ID: <510CE5B0.3050207@kernel.org>
Date: Sat, 02 Feb 2013 10:08:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
CC: linux-iio@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	Naveen Krishna Chatradhi <ch.naveen@samsung.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Doug Anderson <dianders@chromium.org>,
	Tomasz Figa <tomasz.figa@gmail.com>,
	Grant Likely <grant.likely@secretlab.ca>,
	Rob Herring <rob.herring@calxeda.com>
Subject: Re: [PATCH 07/11] iio/adc: (max1363) Fix data conversion problems
References: <1359668588-13678-1-git-send-email-linux@roeck-us.net> <1359668588-13678-8-git-send-email-linux@roeck-us.net>
In-Reply-To: <1359668588-13678-8-git-send-email-linux@roeck-us.net>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/31/2013 09:43 PM, Guenter Roeck wrote:
> For chips with more than 8 bit ADC resolution, received data was always
> masked against 0xfff, ie with a 12 bit mask. This can result in bad data
> for chips with 10 bit resolution if those chips have higher bits set
> (seen with MAX1139).
> 
> The receive buffer was defined as char array. This could result in
> unintentional sign extensions if the upper bit in a received byte
> was set. Since the chip is configured for unipolar mode, we never
> have to handle negative values, and sign extensions are never needed.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Applied to togreg branch of iio.git
> ---
>  drivers/iio/adc/max1363.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 2c773b4..fdc8be9 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -334,7 +334,7 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  {
>  	int ret = 0;
>  	s32 data;
> -	char rxbuf[2];
> +	u8 rxbuf[2];
>  	struct max1363_state *st = iio_priv(indio_dev);
>  	struct i2c_client *client = st->client;
>  
> @@ -366,7 +366,8 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
>  			ret = data;
>  			goto error_ret;
>  		}
> -		data = (s32)(rxbuf[1]) | ((s32)(rxbuf[0] & 0x0F)) << 8;
> +		data = (rxbuf[1] | rxbuf[0] << 8) &
> +		  ((1 << st->chip_info->bits) - 1);
>  	} else {
>  		/* Get reading */
>  		data = i2c_master_recv(client, rxbuf, 1);
> 
