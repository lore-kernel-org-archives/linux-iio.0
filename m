Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51286 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752161AbdCSWoH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 19 Mar 2017 18:44:07 -0400
Subject: Re: [PATCH v3 07/11] IIO: consumer: allow to set buffer sizes
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
References: <1489759704-30217-1-git-send-email-arnaud.pouliquen@st.com>
 <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, alsa-devel@alsa-project.org,
        kernel@stlinux.com, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        olivier moysan <olivier.moysan@st.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <951c19fa-d3b8-f4cd-cac1-64e3b8d1cf01@kernel.org>
Date: Sun, 19 Mar 2017 22:44:02 +0000
MIME-Version: 1.0
In-Reply-To: <1489759704-30217-8-git-send-email-arnaud.pouliquen@st.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/03/17 14:08, Arnaud Pouliquen wrote:
> Add iio consumer API to set buffer size and watermark according
> to sysfs API.
> 
> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Hmm. Not keen on the length one.  Setting a requested watermark
is fair enough.  There is no actually buffer in these cases though
so setting it's length is downright odd..

Guess this is part of the hacks we need to clean up by doing
the dma buffer consumer stuff right...

Jonathan
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

