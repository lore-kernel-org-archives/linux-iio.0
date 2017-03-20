Return-Path: <SRS0=ef63=25=pmeerw.net=pmeerw@kernel.org>
Date: Mon, 20 Mar 2017 09:08:59 +0100 (CET)
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
cc: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
    linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 07/11] IIO: consumer: allow to set buffer sizes
In-Reply-To: <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
Message-ID: <alpine.DEB.2.20.1703200849010.7393@vps.pmeerw.net>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com> <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> Add iio consumer API to set buffer size and watermark according
> to sysfs API.

comments below
 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> ---
>  drivers/iio/buffer/industrialio-buffer-cb.c | 12 ++++++++++++
>  include/linux/iio/consumer.h                | 13 +++++++++++++
>  2 files changed, 25 insertions(+)
> 
> diff --git a/drivers/iio/buffer/industrialio-buffer-cb.c b/drivers/iio/buffer/industrialio-buffer-cb.c
> index b8f550e..43c066a 100644
> --- a/drivers/iio/buffer/industrialio-buffer-cb.c
> +++ b/drivers/iio/buffer/industrialio-buffer-cb.c
> @@ -103,6 +103,18 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(iio_channel_get_all_cb);
>  
> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buff,
> +				      size_t length, size_t watermark)
> +{
> +	if (!length || length < watermark)
> +		return -EINVAL;
> +	cb_buff->buffer.watermark = watermark;
> +	cb_buff->buffer.length = length;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(iio_channel_start_all_cb);
> +
>  int iio_channel_start_all_cb(struct iio_cb_buffer *cb_buff)
>  {
>  	return iio_update_buffers(cb_buff->indio_dev, &cb_buff->buffer,
> diff --git a/include/linux/iio/consumer.h b/include/linux/iio/consumer.h
> index cb44771..0f6e94d 100644
> --- a/include/linux/iio/consumer.h
> +++ b/include/linux/iio/consumer.h
> @@ -134,6 +134,19 @@ struct iio_cb_buffer *iio_channel_get_all_cb(struct device *dev,
>  						       void *private),
>  					     void *private);
>  /**
> + * iio_channel_cb_set_buffer_size() - set the buffer length.
> + * @cb_buffer:		The callback buffer from whom we want the channel
> + *			information.
> + * @length: buffer length in bytes
> + * @watermark: buffer watermark in bytes
> + *
> + * This function allows to configure the buffer length. The watermark if

if -> is

> + * forced to half of the buffer.
> + */
> +int iio_channel_cb_set_buffer_params(struct iio_cb_buffer *cb_buffer,
> +				     size_t length, size_t watermark);
> +
> +/**
>   * iio_channel_release_all_cb() - release and unregister the callback.
>   * @cb_buffer:		The callback buffer that was allocated.
>   */
> 

-- 

Peter Meerwald-Stadler
Mobile: +43 664 24 44 418
