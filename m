Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42778 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750968AbbFNKXk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2015 06:23:40 -0400
Message-ID: <557D562B.4010008@kernel.org>
Date: Sun, 14 Jun 2015 11:23:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Tiberiu Breana <tiberiu.a.breana@intel.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: accel: STK8BA50: replace scale table with a
 struct
References: <1433948850-29700-1-git-send-email-tiberiu.a.breana@intel.com>
In-Reply-To: <1433948850-29700-1-git-send-email-tiberiu.a.breana@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/06/15 16:07, Tiberiu Breana wrote:
> Replaced the stk8ba50_scale_table with an identically named
> struct in order to make the code a bit more readable.
> 
> Signed-off-by: Tiberiu Breana <tiberiu.a.breana@intel.com>
Sensible little rework.  Applied to the togreg branch of iio.git.
Initially pushed out as testing for the autobuilders to play.
Will be 4.3 material now...
> ---
> v2: addressed Daniel's comments
> ---
>  drivers/iio/accel/stk8ba50.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/stk8ba50.c b/drivers/iio/accel/stk8ba50.c
> index 30950c6..3302a3d 100644
> --- a/drivers/iio/accel/stk8ba50.c
> +++ b/drivers/iio/accel/stk8ba50.c
> @@ -50,7 +50,10 @@
>   *
>   * Locally, the range is stored as a table index.
>   */
> -static const int stk8ba50_scale_table[][2] = {
> +static const struct {
> +	u8 reg_val;
> +	u32 scale_val;
> +} stk8ba50_scale_table[] = {
>  	{3, 38400}, {5, 76700}, {8, 153400}, {12, 306900}
>  };
>  
> @@ -114,7 +117,7 @@ static int stk8ba50_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 0;
> -		*val2 = stk8ba50_scale_table[data->range][1];
> +		*val2 = stk8ba50_scale_table[data->range].scale_val;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	}
>  
> @@ -136,7 +139,7 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
>  			return -EINVAL;
>  
>  		for (i = 0; i < ARRAY_SIZE(stk8ba50_scale_table); i++)
> -			if (val2 == stk8ba50_scale_table[i][1]) {
> +			if (val2 == stk8ba50_scale_table[i].scale_val) {
>  				index = i;
>  				break;
>  			}
> @@ -145,7 +148,7 @@ static int stk8ba50_write_raw(struct iio_dev *indio_dev,
>  
>  		ret = i2c_smbus_write_byte_data(data->client,
>  				STK8BA50_REG_RANGE,
> -				stk8ba50_scale_table[index][0]);
> +				stk8ba50_scale_table[index].reg_val);
>  		if (ret < 0)
>  			dev_err(&data->client->dev,
>  					"failed to set measurement range\n");
> 

