Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbdI3U3o (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 16:29:44 -0400
Date: Sat, 30 Sep 2017 21:29:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Stefan =?UTF-8?B?QnLDvG5z?= <stefan.bruens@rwth-aachen.de>
Cc: <linux-iio@vger.kernel.org>, Rob Herring <robh@kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        <linux-kernel@vger.kernel.org>,
        Manivannan Sadhasivam <manivannanece23@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>
Subject: Re: [PATCH v3 3/4] iio: light: vl6180: Cleanup als_gain lookup,
 avoid register readback
Message-ID: <20170930212939.02383bd2@archlinux>
In-Reply-To: <d65aa875-6922-4cb4-800c-caed28067099@rwthex-w2-a.rwth-ad.de>
References: <20170924215920.7465-1-stefan.bruens@rwth-aachen.de>
        <d65aa875-6922-4cb4-800c-caed28067099@rwthex-w2-a.rwth-ad.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 24 Sep 2017 23:59:19 +0200
Stefan Brüns <stefan.bruens@rwth-aachen.de> wrote:

> Instead of manually iterating the array of allowed gain values, use
> find_closest. Storing the current gain setting avoids accessing the
> hardware on each query.
> 
> Signed-off-by: Stefan Brüns <stefan.bruens@rwth-aachen.de>
> 

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
> 
> Changes in v3: None
> Changes in v2:
> - Add missing spaces
> 
>  drivers/iio/light/vl6180.c | 85 ++++++++++++++++++++++++----------------------
>  1 file changed, 44 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/light/vl6180.c b/drivers/iio/light/vl6180.c
> index 9b056c83a90a..49e9f92cd116 100644
> --- a/drivers/iio/light/vl6180.c
> +++ b/drivers/iio/light/vl6180.c
> @@ -24,6 +24,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/delay.h>
> +#include <linux/util_macros.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -86,6 +87,7 @@
>  struct vl6180_data {
>  	struct i2c_client *client;
>  	struct mutex lock;
> +	unsigned int als_gain_milli;
>  	unsigned int als_it_ms;
>  };
>  
> @@ -276,19 +278,17 @@ static const struct iio_chan_spec vl6180_channels[] = {
>  };
>  
>  /*
> - * Columns 3 & 4 represent the same value in decimal and hex notations.
> - * Kept in order to avoid the datatype conversion while reading the
> - * hardware_gain.
> + * Available Ambient Light Sensor gain settings, 1/1000th, and
> + * corresponding setting for the VL6180_ALS_GAIN register
>   */
> -static const int vl6180_als_gain[8][4] = {
> -	{ 1,	0,	70,	VL6180_ALS_GAIN_1 },
> -	{ 1,    250000, 69,	VL6180_ALS_GAIN_1_25 },
> -	{ 1,    670000, 68,	VL6180_ALS_GAIN_1_67 },
> -	{ 2,    500000, 67,	VL6180_ALS_GAIN_2_5 },
> -	{ 5,    0,      66,	VL6180_ALS_GAIN_5 },
> -	{ 10,   0,      65,	VL6180_ALS_GAIN_10 },
> -	{ 20,   0,      64,	VL6180_ALS_GAIN_20 },
> -	{ 40,   0,      71,	VL6180_ALS_GAIN_40 }
> +static const int vl6180_als_gain_tab[8] = {
> +	1000, 1250, 1670, 2500, 5000, 10000, 20000, 40000
> +};
> +static const u8 vl6180_als_gain_tab_bits[8] = {
> +	VL6180_ALS_GAIN_1,    VL6180_ALS_GAIN_1_25,
> +	VL6180_ALS_GAIN_1_67, VL6180_ALS_GAIN_2_5,
> +	VL6180_ALS_GAIN_5,    VL6180_ALS_GAIN_10,
> +	VL6180_ALS_GAIN_20,   VL6180_ALS_GAIN_40
>  };
>  
>  static int vl6180_read_raw(struct iio_dev *indio_dev,
> @@ -296,7 +296,7 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct vl6180_data *data = iio_priv(indio_dev);
> -	int ret, i;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -328,17 +328,11 @@ static int vl6180_read_raw(struct iio_dev *indio_dev,
>  
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	case IIO_CHAN_INFO_HARDWAREGAIN:
> -		ret = vl6180_read_byte(data->client, VL6180_ALS_GAIN);
> -		if (ret < 0)
> -			return -EINVAL;
> -		for (i = 0; i < ARRAY_SIZE(vl6180_als_gain); i++) {
> -			if (ret == vl6180_als_gain[i][2]) {
> -				*val = vl6180_als_gain[i][0];
> -				*val2 = vl6180_als_gain[i][1];
> -			}
> -		}
> +		*val = data->als_gain_milli;
> +		*val2 = 1000;
> +
> +		return IIO_VAL_FRACTIONAL;
>  
> -		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
>  	}
> @@ -364,25 +358,33 @@ static int vl6180_hold(struct vl6180_data *data, bool hold)
>  
>  static int vl6180_set_als_gain(struct vl6180_data *data, int val, int val2)
>  {
> -	int i, ret;
> -
> -	for (i = 0; i < ARRAY_SIZE(vl6180_als_gain); i++) {
> -		if (val == vl6180_als_gain[i][0] &&
> -			val2 == vl6180_als_gain[i][1]) {
> -			mutex_lock(&data->lock);
> -			ret = vl6180_hold(data, true);
> -			if (ret < 0)
> -				goto fail;
> -			ret = vl6180_write_byte(data->client, VL6180_ALS_GAIN,
> -				vl6180_als_gain[i][3]);
> -fail:
> -			vl6180_hold(data, false);
> -			mutex_unlock(&data->lock);
> -			return ret;
> -		}
> -	}
> +	int i, ret, gain;
> +
> +	if (val < 1 || val > 40)
> +		return -EINVAL;
>  
> -	return -EINVAL;
> +	gain = (val * 1000000 + val2) / 1000;
> +	if (gain < 1 || gain > 40000)
> +		return -EINVAL;
> +
> +	i = find_closest(gain, vl6180_als_gain_tab,
> +			 ARRAY_SIZE(vl6180_als_gain_tab));
> +
> +	mutex_lock(&data->lock);
> +	ret = vl6180_hold(data, true);
> +	if (ret < 0)
> +		goto fail;
> +
> +	ret = vl6180_write_byte(data->client, VL6180_ALS_GAIN,
> +				vl6180_als_gain_tab_bits[i]);
> +
> +	if (ret >= 0)
> +		data->als_gain_milli = vl6180_als_gain_tab[i];
> +
> +fail:
> +	vl6180_hold(data, false);
> +	mutex_unlock(&data->lock);
> +	return ret;
>  }
>  
>  static int vl6180_set_it(struct vl6180_data *data, int val, int val2)
> @@ -479,6 +481,7 @@ static int vl6180_init(struct vl6180_data *data)
>  		return ret;
>  
>  	/* ALS gain: 1 */
> +	data->als_gain_milli = 1000;
>  	ret = vl6180_write_byte(client, VL6180_ALS_GAIN, VL6180_ALS_GAIN_1);
>  	if (ret < 0)
>  		return ret;

