Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:40682 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751734AbaGTPS1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 20 Jul 2014 11:18:27 -0400
Message-ID: <53CBDE4F.1040002@kernel.org>
Date: Sun, 20 Jul 2014 16:20:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: accel: kxcjk-1013: Use try_reenable to ack intr
References: <1405557754-19601-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1405557754-19601-2-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1405557754-19601-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/07/14 01:42, Srinivas Pandruvada wrote:
> This chip needs explicit interrupt ack, introducing try_reenable
> callback. Also removed separate function to ack interrupt as this
> doesn't add any value.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Definitely neater this way, though would have worked before as acked in the
trigger handler...  Patch description seems to suggest it wouldn't?

Applied to the togreg branch of iio.git

J
> ---
>   drivers/iio/accel/kxcjk-1013.c | 33 ++++++++++++++++-----------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
> index 4702aeb..bff5161 100644
> --- a/drivers/iio/accel/kxcjk-1013.c
> +++ b/drivers/iio/accel/kxcjk-1013.c
> @@ -138,19 +138,6 @@ static int kxcjk1013_set_mode(struct kxcjk1013_data *data,
>   	return 0;
>   }
>
> -static int kxcjk1013_chip_ack_intr(struct kxcjk1013_data *data)
> -{
> -	int ret;
> -
> -	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
> -	if (ret < 0) {
> -		dev_err(&data->client->dev, "Error writing reg_int_rel\n");
> -		return ret;
> -	}
> -
> -	return ret;
> -}
> -
>   static int kxcjk1013_chip_init(struct kxcjk1013_data *data)
>   {
>   	int ret;
> @@ -498,15 +485,11 @@ static irqreturn_t kxcjk1013_trigger_handler(int irq, void *p)
>   			 indio_dev->masklength) {
>   		ret = kxcjk1013_get_acc_reg(data, bit);
>   		if (ret < 0) {
> -			kxcjk1013_chip_ack_intr(data);
>   			mutex_unlock(&data->mutex);
>   			goto err;
>   		}
>   		data->buffer[i++] = ret;
>   	}
> -
> -	kxcjk1013_chip_ack_intr(data);
> -
>   	mutex_unlock(&data->mutex);
>
>   	iio_push_to_buffers_with_timestamp(indio_dev, data->buffer,
> @@ -517,6 +500,21 @@ err:
>   	return IRQ_HANDLED;
>   }
>
> +static int kxcjk1013_trig_try_reen(struct iio_trigger *trig)
> +{
> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> +	struct kxcjk1013_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = i2c_smbus_read_byte_data(data->client, KXCJK1013_REG_INT_REL);
> +	if (ret < 0) {
> +		dev_err(&data->client->dev, "Error reading reg_int_rel\n");
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
>   static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
>   						bool state)
>   {
> @@ -543,6 +541,7 @@ static int kxcjk1013_data_rdy_trigger_set_state(struct iio_trigger *trig,
>
>   static const struct iio_trigger_ops kxcjk1013_trigger_ops = {
>   	.set_trigger_state = kxcjk1013_data_rdy_trigger_set_state,
> +	.try_reenable = kxcjk1013_trig_try_reen,
>   	.owner = THIS_MODULE,
>   };
>
>

