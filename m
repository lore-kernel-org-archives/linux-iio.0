Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:33041 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbeHHNHM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Aug 2018 09:07:12 -0400
Received: by mail-pl0-f68.google.com with SMTP id b90-v6so878776plb.0
        for <linux-iio@vger.kernel.org>; Wed, 08 Aug 2018 03:48:04 -0700 (PDT)
Date: Wed, 8 Aug 2018 16:17:57 +0530
From: Himanshu Jha <himanshujha199640@gmail.com>
To: David Frey <dpfrey@gmail.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: bme680: simplify oversampling handling
Message-ID: <20180808104757.GA1882@himanshu-Vostro-3559>
References: <20180807200721.22033-1-dpfrey@gmail.com>
 <20180807200721.22033-3-dpfrey@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180807200721.22033-3-dpfrey@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Aug 07, 2018 at 01:07:21PM -0700, David Frey wrote:
> Temperature, pressure and humidity all expose and oversampling setting
> that works in the same way.  Provide common handling for the
> oversampling sysfs attributes.
> 
> Signed-off-by: David Frey <dpfrey@gmail.com>
> ---
>  drivers/iio/chemical/bme680_core.c | 65 +++++++++++---------------------------
>  1 file changed, 19 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
> index 0e79d03ecc40..446cf1cbef23 100644
> --- a/drivers/iio/chemical/bme680_core.c
> +++ b/drivers/iio/chemical/bme680_core.c
> @@ -91,8 +91,6 @@ static const struct iio_chan_spec bme680_channels[] = {
>  	},
>  };
>  
> -static const int bme680_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> -
>  static int bme680_read_calib(struct bme680_data *data,
>  			     struct bme680_calib *calib)
>  {
> @@ -783,49 +781,14 @@ static int bme680_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int bme680_write_oversampling_ratio_temp(struct bme680_data *data,
> -						int val)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
> -		if (bme680_oversampling_avail[i] == val) {
> -			data->oversampling_temp = ilog2(val);
> -
> -			return bme680_chip_config(data);
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static int bme680_write_oversampling_ratio_press(struct bme680_data *data,
> -						 int val)
> -{
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
> -		if (bme680_oversampling_avail[i] == val) {
> -			data->oversampling_press = ilog2(val);
> -
> -			return bme680_chip_config(data);
> -		}
> -	}
> -
> -	return -EINVAL;
> -}
> -
> -static int bme680_write_oversampling_ratio_humid(struct bme680_data *data,
> -						 int val)
> +static int bme680_oversampling_value_to_setting(int value)
>  {
>  	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(bme680_oversampling_avail); i++) {
> -		if (bme680_oversampling_avail[i] == val) {
> -			data->oversampling_humid = ilog2(val);
> -
> -			return bme680_chip_config(data);
> -		}
> +	/* valid values are 2^n where n >=0 && n <= 4 */
> +	for (i = 0; i <= 4; i++) {
> +		u8 setting = (1 << i);
> +		if (setting == value)
> +			return setting;
>  	}

No, this is not correct!

Take example of:

osrs_h<2:0>		Humidity oversampling
011			oversampling * 4

And you will understand the ilog2() magic and also
look bme680_chip_config() how that value is written.

In your case, 

u8 osrs = FIELD_PREP(BME680_OSRS_HUMIDITY_MASK,
		     data->oversampling_humid + 1);

4 + 1 = 5(101) will be written instead of 4(101).

But I like the refactoring of using a generic oversampling
function. 

Just use:
while making a generic function bme680_write_oversampling_ratio()
and everything is fine as is using the ilog2 magic.
...
                switch (chan->type) {
                case IIO_TEMP:
                        return bme680_write_oversampling_ratio(data, val);
                case IIO_PRESSURE:
                        return bme680_write_oversampling_ratio(data, val);
                case IIO_HUMIDITYRELATIVE:
                        return bme680_write_oversampling_ratio(data, val);
                default:
                        return -EINVAL;
...


Thanks.
-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
