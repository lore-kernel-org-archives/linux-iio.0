Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbdI3T6Z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 30 Sep 2017 15:58:25 -0400
Date: Sat, 30 Sep 2017 20:58:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        linux-iio@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Subject: Re: [PATCH v3 1/8] iio: accel: kxcjk1003: refactor ODR setting
Message-ID: <20170930205821.5d22639b@archlinux>
In-Reply-To: <1197446fea3145f5baaeec43de38ea143867b952.1505660069.git.mirq-linux@rere.qmqm.pl>
References: <cover.1505660069.git.mirq-linux@rere.qmqm.pl>
        <1197446fea3145f5baaeec43de38ea143867b952.1505660069.git.mirq-linux@rere.qmqm.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Sep 2017 17:01:01 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> Refactor ODR/WUF setting code in preparation of KXTF9 support.
> 
> Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
Applied to the togreg branch of iio.git and pushed out as testing.
Thanks,

Jonathan
> ---
>  drivers/iio/accel/kxcjk-1013.c | 102 ++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 3f968c46e667..33e4b98f39fc 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -128,15 +128,27 @@ enum kxcjk1013_range {
>  	KXCJK1013_RANGE_8G,
>  };
>  
> -static const struct {
> +struct kx_odr_map {
>  	int val;
>  	int val2;
>  	int odr_bits;
> -} samp_freq_table[] = { {0, 781000, 0x08}, {1, 563000, 0x09},
> -			{3, 125000, 0x0A}, {6, 250000, 0x0B}, {12, 500000, 0},
> -			{25, 0, 0x01}, {50, 0, 0x02}, {100, 0, 0x03},
> -			{200, 0, 0x04}, {400, 0, 0x05}, {800, 0, 0x06},
> -			{1600, 0, 0x07} };
> +	int wuf_bits;
> +};
> +
> +static const struct kx_odr_map samp_freq_table[] = {
> +	{ 0, 781000, 0x08, 0x00 },
> +	{ 1, 563000, 0x09, 0x01 },
> +	{ 3, 125000, 0x0A, 0x02 },
> +	{ 6, 250000, 0x0B, 0x03 },
> +	{ 12, 500000, 0x00, 0x04 },
> +	{ 25, 0, 0x01, 0x05 },
> +	{ 50, 0, 0x02, 0x06 },
> +	{ 100, 0, 0x03, 0x06 },
> +	{ 200, 0, 0x04, 0x06 },
> +	{ 400, 0, 0x05, 0x06 },
> +	{ 800, 0, 0x06, 0x06 },
> +	{ 1600, 0, 0x07, 0x06 },
> +};
>  
>  /* Refer to section 4 of the specification */
>  static const struct {
> @@ -198,23 +210,6 @@ static const struct {
>  			      {19163, 1, 0},
>  			      {38326, 0, 1} };
>  
> -static const struct {
> -	int val;
> -	int val2;
> -	int odr_bits;
> -} wake_odr_data_rate_table[] = { {0, 781000, 0x00},
> -				 {1, 563000, 0x01},
> -				 {3, 125000, 0x02},
> -				 {6, 250000, 0x03},
> -				 {12, 500000, 0x04},
> -				 {25, 0, 0x05},
> -				 {50, 0, 0x06},
> -				 {100, 0, 0x06},
> -				 {200, 0, 0x06},
> -				 {400, 0, 0x06},
> -				 {800, 0, 0x06},
> -				 {1600, 0, 0x06} };
> -
>  static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>  			      enum kxcjk1013_mode mode)
>  {
> @@ -547,28 +542,30 @@ static int kxcjk1013_setup_new_data_interrupt(struct kxcjk1013_data *data,
>  	return 0;
>  }
>  
> -static int kxcjk1013_convert_freq_to_bit(int val, int val2)
> +static const struct kx_odr_map *kxcjk1013_find_odr_value(
> +	const struct kx_odr_map *map, size_t map_size, int val, int val2)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(samp_freq_table); ++i) {
> -		if (samp_freq_table[i].val == val &&
> -			samp_freq_table[i].val2 == val2) {
> -			return samp_freq_table[i].odr_bits;
> -		}
> +	for (i = 0; i < map_size; ++i) {
> +		if (map[i].val == val && map[i].val2 == val2)
> +			return &map[i];
>  	}
>  
> -	return -EINVAL;
> +	return ERR_PTR(-EINVAL);
>  }
>  
> -static int kxcjk1013_convert_wake_odr_to_bit(int val, int val2)
> +static int kxcjk1013_convert_odr_value(const struct kx_odr_map *map,
> +				       size_t map_size, int odr_bits,
> +				       int *val, int *val2)
>  {
>  	int i;
>  
> -	for (i = 0; i < ARRAY_SIZE(wake_odr_data_rate_table); ++i) {
> -		if (wake_odr_data_rate_table[i].val == val &&
> -			wake_odr_data_rate_table[i].val2 == val2) {
> -			return wake_odr_data_rate_table[i].odr_bits;
> +	for (i = 0; i < map_size; ++i) {
> +		if (map[i].odr_bits == odr_bits) {
> +			*val = map[i].val;
> +			*val2 = map[i].val2;
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		}
>  	}
>  
> @@ -578,16 +575,19 @@ static int kxcjk1013_convert_wake_odr_to_bit(int val, int val2)
>  static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  {
>  	int ret;
> -	int odr_bits;
>  	enum kxcjk1013_mode store_mode;
> +	const struct kx_odr_map *odr_setting;
>  
>  	ret = kxcjk1013_get_mode(data, &store_mode);
>  	if (ret < 0)
>  		return ret;
>  
> -	odr_bits = kxcjk1013_convert_freq_to_bit(val, val2);
> -	if (odr_bits < 0)
> -		return odr_bits;
> +	odr_setting = kxcjk1013_find_odr_value(samp_freq_table,
> +					       ARRAY_SIZE(samp_freq_table),
> +					       val, val2);
> +
> +	if (IS_ERR(odr_setting))
> +		return PTR_ERR(odr_setting);
>  
>  	/* To change ODR, the chip must be set to STANDBY as per spec */
>  	ret = kxcjk1013_set_mode(data, STANDBY);
> @@ -595,20 +595,16 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  		return ret;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_DATA_CTRL,
> -					odr_bits);
> +					odr_setting->odr_bits);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing data_ctrl\n");
>  		return ret;
>  	}
>  
> -	data->odr_bits = odr_bits;
> -
> -	odr_bits = kxcjk1013_convert_wake_odr_to_bit(val, val2);
> -	if (odr_bits < 0)
> -		return odr_bits;
> +	data->odr_bits = odr_setting->odr_bits;
>  
>  	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL2,
> -					odr_bits);
> +					odr_setting->wuf_bits);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev, "Error writing reg_ctrl2\n");
>  		return ret;
> @@ -625,17 +621,9 @@ static int kxcjk1013_set_odr(struct kxcjk1013_data *data, int val, int val2)
>  
>  static int kxcjk1013_get_odr(struct kxcjk1013_data *data, int *val, int *val2)
>  {
> -	int i;
> -
> -	for (i = 0; i < ARRAY_SIZE(samp_freq_table); ++i) {
> -		if (samp_freq_table[i].odr_bits == data->odr_bits) {
> -			*val = samp_freq_table[i].val;
> -			*val2 = samp_freq_table[i].val2;
> -			return IIO_VAL_INT_PLUS_MICRO;
> -		}
> -	}
> -
> -	return -EINVAL;
> +	return kxcjk1013_convert_odr_value(samp_freq_table,
> +					   ARRAY_SIZE(samp_freq_table),
> +					   data->odr_bits, val, val2);
>  }
>  
>  static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)

