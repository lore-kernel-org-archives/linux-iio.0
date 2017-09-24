Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752244AbdIXPgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 24 Sep 2017 11:36:31 -0400
Date: Sun, 24 Sep 2017 16:36:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH 2/4] iio: light: vl6180: Avoid readback of integration
 time register
Message-ID: <20170924163627.040e887f@archlinux>
In-Reply-To: <20170919031144.4968-3-stefan.bruens@rwth-aachen.de>
References: <20170919031144.4968-1-stefan.bruens@rwth-aachen.de>
        <20170919031144.4968-3-stefan.bruens@rwth-aachen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Sep 2017 05:11:42 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Instead of reading the value from the register on each query, store the
> set value.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Fair enough, bit nitpick inline.

> ---
>  drivers/iio/light/vl6180.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 57577d5d18ac..ae768c832d66 100644
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
> +		*val = 0;
> +		*val2 = data->als_it_ms * 1000;
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
> +

Unrelated white space change.  You need a separate patch
covering these trivial things to avoid adding noise to a patch
making real changes.

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
> @@ -472,6 +474,7 @@ static int vl6180_init(struct vl6180_data *data)
>  		return ret;
>  
>  	/* ALS integration time: 100ms */
> +	data->als_it_ms = 100;
>  	ret = vl6180_write_word(client, VL6180_ALS_IT, VL6180_ALS_IT_100);
>  	if (ret < 0)
>  		return ret;

