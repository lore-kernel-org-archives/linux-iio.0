Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55389 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbaFGKtR (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 7 Jun 2014 06:49:17 -0400
Message-ID: <5392EE9C.60901@kernel.org>
Date: Sat, 07 Jun 2014 11:51:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
CC: srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH] iio: Fix endianness issue in ak8975_read_axis()
References: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1401958410-21183-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/06/14 09:53, Peter Meerwald wrote:
> i2c_smbus_read_word_data() does host endian conversion already,
> no need for le16_to_cpu()
>
> Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks

> ---
>   drivers/iio/magnetometer/ak8975.c | 9 +--------
>   1 file changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/drivers/iio/magnetometer/ak8975.c b/drivers/iio/magnetometer/ak8975.c
> index 09ea5c4..ea08313 100644
> --- a/drivers/iio/magnetometer/ak8975.c
> +++ b/drivers/iio/magnetometer/ak8975.c
> @@ -373,8 +373,6 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>   {
>   	struct ak8975_data *data = iio_priv(indio_dev);
>   	struct i2c_client *client = data->client;
> -	u16 meas_reg;
> -	s16 raw;
>   	int ret;
>
>   	mutex_lock(&data->lock);
> @@ -422,16 +420,11 @@ static int ak8975_read_axis(struct iio_dev *indio_dev, int index, int *val)
>   		dev_err(&client->dev, "Read axis data fails\n");
>   		goto exit;
>   	}
> -	meas_reg = ret;
>
>   	mutex_unlock(&data->lock);
>
> -	/* Endian conversion of the measured values. */
> -	raw = (s16) (le16_to_cpu(meas_reg));
> -
>   	/* Clamp to valid range. */
> -	raw = clamp_t(s16, raw, -4096, 4095);
> -	*val = raw;
> +	*val = clamp_t(s16, ret, -4096, 4095);
>   	return IIO_VAL_INT;
>
>   exit:
>

