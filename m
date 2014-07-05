Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:56086 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754719AbaGEKIz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sat, 5 Jul 2014 06:08:55 -0400
Message-ID: <53B7CF39.2070209@kernel.org>
Date: Sat, 05 Jul 2014 11:11:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sachin Kamat <sachin.kamat@samsung.com>, linux-iio@vger.kernel.org
CC: spk.linux@gmail.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 6/7] iio: hid-sensor-prox: Fix return values
References: <1404369852-3255-1-git-send-email-sachin.kamat@samsung.com> <1404369852-3255-6-git-send-email-sachin.kamat@samsung.com>
In-Reply-To: <1404369852-3255-6-git-send-email-sachin.kamat@samsung.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/07/14 07:44, Sachin Kamat wrote:
> IIO_CHAN_INFO_SAMP_FREQ and IIO_CHAN_INFO_HYSTERESIS cases ignored
> the actual return values (which could be -EINVAL) and instead
> returned IIO_VAL_INT_PLUS_MICRO always. Return the actual value
> obtained from the functions. Both functions return IIO_VAL_INT_PLUS_MICRO
> upon success.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@samsung.com>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/light/hid-sensor-prox.c |    7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
> index d203ef4..412bae8 100644
> --- a/drivers/iio/light/hid-sensor-prox.c
> +++ b/drivers/iio/light/hid-sensor-prox.c
> @@ -74,7 +74,6 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>   	struct prox_state *prox_state = iio_priv(indio_dev);
>   	int report_id = -1;
>   	u32 address;
> -	int ret;
>   	int ret_type;
>   	s32 poll_value;
>
> @@ -125,14 +124,12 @@ static int prox_read_raw(struct iio_dev *indio_dev,
>   		ret_type = IIO_VAL_INT;
>   		break;
>   	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret = hid_sensor_read_samp_freq_value(
> +		ret_type = hid_sensor_read_samp_freq_value(
>   				&prox_state->common_attributes, val, val2);
> -		ret_type = IIO_VAL_INT_PLUS_MICRO;
>   		break;
>   	case IIO_CHAN_INFO_HYSTERESIS:
> -		ret = hid_sensor_read_raw_hyst_value(
> +		ret_type = hid_sensor_read_raw_hyst_value(
>   				&prox_state->common_attributes, val, val2);
> -		ret_type = IIO_VAL_INT_PLUS_MICRO;
>   		break;
>   	default:
>   		ret_type = -EINVAL;
>

