Return-Path: <srinivas.pandruvada@linux.intel.com>
Message-ID: <53C46095.9020002@linux.intel.com>
Date: Mon, 14 Jul 2014 15:58:29 -0700
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org, jic23@kernel.org
Subject: Re: [PATCH 1/3] iio:kxcjk-1013: Correct error messages
References: <1405370318-19699-1-git-send-email-pmeerw@pmeerw.net> <1405370318-19699-2-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1405370318-19699-2-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 07/14/2014 01:38 PM, Peter Meerwald wrote:
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>   drivers/iio/accel/kxcjk-1013.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 72a6dbb..a11588c 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -144,7 +144,7 @@ static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
>
>   	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
>   	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_rel\n");
> +		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
>   		return ret;
>   	}
>
> @@ -183,7 +183,7 @@ static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>   	ret = i2c_smbus_write_byte_data(data->client, KXCJK1013_REG_CTRL1,
>   					ret);
>   	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error reading reg_ctrl\n");
> +		dev_err(&data->client->dev, "Error writing reg_ctrl1\n");
>   		return ret;
>   	}
>
> @@ -337,7 +337,7 @@ static int kxcjk1013_get_acc_reg(struct kxcjk1013_data *data, int axis)
>   	ret = i2c_smbus_read_word_data(data->client, reg);
>   	if (ret < 0) {
>   		dev_err(&data->client->dev,
> -			"failed to read accel_%c registers\n", 'x' + axis);
> +			"failed to read accel_%c register\n", 'x' + axis);
>   		return ret;
>   	}
>
>
Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
