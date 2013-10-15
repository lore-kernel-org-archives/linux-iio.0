Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:50515 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752866Ab3JOFiY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 15 Oct 2013 01:38:24 -0400
Message-ID: <525CD501.9020701@metafoo.de>
Date: Tue, 15 Oct 2013 07:39:13 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 02/10] staging:iio:hmc5843: Always read all channels
 values otherwise no updates
References: <1381786498-25954-1-git-send-email-pmeerw@pmeerw.net> <1381786498-25954-3-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1381786498-25954-3-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/14/2013 11:34 PM, Peter Meerwald wrote:
> +/* Return the measurement value from the specified channel */
> +static int hmc5843_read_measurement(struct hmc5843_data *data,
> +				    int idx, int *val)
> +{
> +	s32 result;
> +	s16 values[3];

I'm currently trying to make iio pass `make C=2 CF=-D__CHECK_ENDIAN__`.
This should be __be16

> +
> +	mutex_lock(&data->lock);
> +	result = hmc5843_wait_measurement(data);
> +	if (result < 0) {
> +		mutex_unlock(&data->lock);
> +		return result;
> +	}
> +	result = i2c_smbus_read_i2c_block_data(data->client,
> +		HMC5843_DATA_OUT_MSB_REGS, sizeof(values), (u8 *) values);
>   	mutex_unlock(&data->lock);
>   	if (result < 0)
>   		return -EINVAL;
>
> -	*val = sign_extend32(result, 15);
> +	*val = sign_extend32(be16_to_cpu(values[idx]), 15);
>   	return IIO_VAL_INT;
>   }
>
[...]
