Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40083 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeJZKDr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 26 Oct 2018 06:03:47 -0400
Received: by mail-pl1-f193.google.com with SMTP id b9-v6so4370980pls.7
        for <linux-iio@vger.kernel.org>; Thu, 25 Oct 2018 18:28:49 -0700 (PDT)
Subject: Re: [PATCH] iio:st_magn: enable trigger before enabling sensor
To: Denis Ciocca <denis.ciocca@st.com>, linux-iio@vger.kernel.org,
        lars@metafoo.de, jic23@kernel.org, lorenzo.bianconi83@gmail.com,
        pmeerw@pmeerw.net, knaack.h@gmx.de
References: <20181025223226.10292-1-denis.ciocca@st.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <6dec1960-d6fd-9f37-7006-ef03dbba6c3c@martingkelly.com>
Date: Thu, 25 Oct 2018 18:28:47 -0700
MIME-Version: 1.0
In-Reply-To: <20181025223226.10292-1-denis.ciocca@st.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/25/18 3:32 PM, Denis Ciocca wrote:
>  From logical point of view driver should be ready to
> receive irqs before enabling the sensor itself.
> This patch is fixing also an issue related to
> sensors that generate interrupts unconditionally,
> (DRDY pads) when interrupt level is used.
> 
> Signed-off-by: Martin Kelly <martin@martingkelly.com>
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
>   drivers/iio/magnetometer/st_magn_buffer.c | 33 +++++++++++------------
>   1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/st_magn_buffer.c b/drivers/iio/magnetometer/st_magn_buffer.c
> index 0a9e8fadfa9d..097e6e88a464 100644
> --- a/drivers/iio/magnetometer/st_magn_buffer.c
> +++ b/drivers/iio/magnetometer/st_magn_buffer.c
> @@ -30,11 +30,6 @@ int st_magn_trig_set_state(struct iio_trigger *trig, bool state)
>   	return st_sensors_set_dataready_irq(indio_dev, state);
>   }
>   
> -static int st_magn_buffer_preenable(struct iio_dev *indio_dev)
> -{
> -	return st_sensors_set_enable(indio_dev, true);
> -}
> -
>   static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>   {
>   	int err;
> @@ -42,40 +37,44 @@ static int st_magn_buffer_postenable(struct iio_dev *indio_dev)
>   
>   	mdata->buffer_data = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
>   	if (mdata->buffer_data == NULL) {
> -		err = -ENOMEM;
> -		goto allocate_memory_error;
> +		return -ENOMEM;
>   	}
>   
>   	err = iio_triggered_buffer_postenable(indio_dev);
>   	if (err < 0)
> -		goto st_magn_buffer_postenable_error;
> +		goto st_magn_buffer_free_buffer_data;
> +
> +	err = st_sensors_set_enable(indio_dev, true);
> +	if (err < 0)
> +		goto st_magn_buffer_buffer_predisable;
>   
>   	return err;
>   
> -st_magn_buffer_postenable_error:
> +st_magn_buffer_buffer_predisable:
> +	iio_triggered_buffer_predisable(indio_dev);
> +st_magn_buffer_free_buffer_data:
>   	kfree(mdata->buffer_data);
> -allocate_memory_error:
>   	return err;
>   }
>   
>   static int st_magn_buffer_predisable(struct iio_dev *indio_dev)
>   {
> -	int err;
> +	int err = 0, err2;
>   	struct st_sensor_data *mdata = iio_priv(indio_dev);
>   
> -	err = iio_triggered_buffer_predisable(indio_dev);
> -	if (err < 0)
> -		goto st_magn_buffer_predisable_error;
> +	err2 = st_sensors_set_enable(indio_dev, false);
> +	if (err2 < 0)
> +		err = err2;
>   
> -	err = st_sensors_set_enable(indio_dev, false);
> +	err2 = iio_triggered_buffer_predisable(indio_dev);
> +	if (err2 < 0)
> +		err = err2;

I think it would be useful to log an error message when we fail, to help 
distinguish in the logs between the two different failure cases.

>   
> -st_magn_buffer_predisable_error:
>   	kfree(mdata->buffer_data);
>   	return err;
>   }
>   
>   static const struct iio_buffer_setup_ops st_magn_buffer_setup_ops = {
> -	.preenable = &st_magn_buffer_preenable,
>   	.postenable = &st_magn_buffer_postenable,
>   	.predisable = &st_magn_buffer_predisable,
>   };
> 
