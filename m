Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:50035 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbaJYTkf (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 25 Oct 2014 15:40:35 -0400
Message-ID: <544BFCB1.5020407@kernel.org>
Date: Sat, 25 Oct 2014 20:40:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Hartmut Knaack <knaack.h@gmx.de>, IIO <linux-iio@vger.kernel.org>
CC: David Barksdale <dbarksdale@uplogix.com>
Subject: Re: [PATCH]iio:humidity:si7020: fix pointer to i2c client
References: <544BE742.8030004@gmx.de>
In-Reply-To: <544BE742.8030004@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 25/10/14 19:09, Hartmut Knaack wrote:
> In si7020_read_raw() the pointer to the i2c client was obtained as second level
> pointer, although a simple pointer is appropriate.
> 
> Signed-off-by: Hartmut Knaack <knaack.h@gmx.de>
What I'd neglected (being a forgetful soul) is that we only just took this driver
anyway so the two patches will both end up in togreg whatever.

So applied to the togreg branch of iio.git - initially pushed out as testing
etc etc.

Jonathan
> ---
> diff --git a/drivers/iio/humidity/si7020.c b/drivers/iio/humidity/si7020.c
> index e336af7..62d74d3 100644
> --- a/drivers/iio/humidity/si7020.c
> +++ b/drivers/iio/humidity/si7020.c
> @@ -45,12 +45,12 @@ static int si7020_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan, int *val,
>  			   int *val2, long mask)
>  {
> -	struct i2c_client **client = iio_priv(indio_dev);
> +	struct i2c_client *client = iio_priv(indio_dev);
>  	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		ret = i2c_smbus_read_word_data(*client,
> +		ret = i2c_smbus_read_word_data(client,
>  					       chan->type == IIO_TEMP ?
>  					       SI7020CMD_TEMP_HOLD :
>  					       SI7020CMD_RH_HOLD);
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
