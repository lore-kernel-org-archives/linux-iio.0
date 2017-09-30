Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbdI3UVi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:21:38 -0400
Date: Sat, 30 Sep 2017 21:21:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v3 1/4] iio: light: vl6180: Move range check to
 integration time setter, cleanup
Message-ID: <20170930212134.38c1b3af@archlinux>
In-Reply-To: <61978114-05a9-4557-806d-65bf7a4b0e2d@rwthex-w2-a.rwth-ad.de>
References: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
        <61978114-05a9-4557-806d-65bf7a4b0e2d@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Sep 2017 23:59:17 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> This improves code uniformity (range checks for als_gain are also done
> in the setter). Also unmangle rounding and calculation of register value.
> 
> The calculated integration time it_ms is required in the next patch of
> the series.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> 
> ---
> 
> Changes in v3:
> - Drop whitespace change
> 
> Changes in v2:
> - Removed redundant parenthesis
> 
>  drivers/iio/light/vl6180.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 6e25b724d941..3b6351b89ce7 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -386,16 +386,21 @@ static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
>  	return -EINVAL;
>  }
>  
> -static int vl6180_set_it(struct vl6180_data *data, int val2)
> +static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
>  {
> -	int ret;
> +	int ret, it_ms;
> +
> +	it_ms = (val2 + 500) / 1000; /* round to ms */
> +	if (val != 0 || it_ms < 1 || it_ms > 512)
> +		return -EINVAL;
>  
>  	mutex_lock(&data->lock);
>  	ret = vl6180_hold(data, true);
>  	if (ret < 0)
>  		goto fail;
> -	ret = vl6180_write_word(data->client, VL6180_ALS_IT,
> -		(val2 - 500) / 1000); /* write value in ms */
> +
> +	ret = vl6180_write_word(data->client, VL6180_ALS_IT, it_ms - 1);
> +
>  fail:
>  	vl6180_hold(data, false);
>  	mutex_unlock(&data->lock);
> @@ -411,10 +416,8 @@ static int vl6180_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_INT_TIME:
> -		if (val != 0 || val2 < 500 || val2 >= 512500)
> -			return -EINVAL;
> +		return vl6180_set_it(data, val, val2);
>  
> -		return vl6180_set_it(data, val2);
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
>  		if (chan->type != IIO_LIGHT)
>  			return -EINVAL;

