Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdI3UXP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:23:15 -0400
Date: Sat, 30 Sep 2017 21:23:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v3 2/4] iio: light: vl6180: Avoid readback of
 integration time register
Message-ID: <20170930212311.1c74dd5c@archlinux>
In-Reply-To: <1d9dd709-84d1-4778-becb-2cda99032763@rwthex-w2-a.rwth-ad.de>
References: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
        <1d9dd709-84d1-4778-becb-2cda99032763@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Sep 2017 23:59:18 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Instead of reading the value from the register on each query, store the
> set value.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan
> 
> ---
> 
> Changes in v3:
> - Use IIO_VAL_FRACTIONAL for integration time return value
> 
> Changes in v2: None
> 
>  drivers/iio/light/vl6180.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 3b6351b89ce7..9b056c83a90a 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -86,6 +86,7 @@
>  struct vl6180_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	unsigned int als_it_ms;
>  };
>  
>  enum { VL6180_ALS, VL6180_RANGE, VL6180_PROX };
> @@ -306,13 +307,11 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_INT_TIME:
> -		ret = vl6180_read_word(data->client, VL6180_ALS_IT);
> -		if (ret < 0)
> -			return ret;
> -		*val = 0; /* 1 count = 1ms (0 = 1ms) */
> -		*val2 = (ret + 1) * 1000; /* convert to seconds */
> +		*val = data->als_it_ms;
> +		*val2 = 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
>  
> -		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_LIGHT:
> @@ -401,6 +400,9 @@ static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  
>  	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
>  
> +	if (ret >= 0)
> +		data->als_it_ms = it_ms;
> +
>  fail:
>  	vl6180_hold(data, false);
>  	mutex_unlock(&data->lock);
> @@ -471,6 +473,7 @@ static int vl6180_init(struct vl6180_data *data)
>  		return ret;
>  
>  	/* ALS integration time: 100ms */
> +	data->als_it_ms = 100;
>  	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
>  	if (ret < 0)
>  		return ret;

