Return-Path: <jic23@hermes.cam.ac.uk>
Message-ID: <51AEFF42.2010002@jic23.retrosnub.co.uk>
Date: Wed, 05 Jun 2013 10:05:06 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
MIME-Version: 1.0
To: Denis CIOCCA <denis.ciocca@st.com>
CC: jic23@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio:common: Added check memory allocation failed
References: <1370416890-4659-1-git-send-email-denis.ciocca@st.com> <1370416890-4659-2-git-send-email-denis.ciocca@st.com>
In-Reply-To: <1370416890-4659-2-git-send-email-denis.ciocca@st.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: "J.I. Cameron" <jic23@hermes.cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

On 05/06/13 08:21, Denis CIOCCA wrote:
> Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
> ---
>   drivers/iio/common/st_sensors/st_sensors_buffer.c |    5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> index 7389785..71a2c5f 100644
> --- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
> +++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
> @@ -57,6 +57,11 @@ int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
>   			u8 *rx_array;
>   			rx_array = kmalloc(byte_for_channel * num_data_channels,
>   					   GFP_KERNEL);
> +			if (!rx_array) {
> +				len = -ENOMEM;
> +				goto st_sensors_free_memory;
> +			}
> +
>   			len = sdata->tf->read_multiple_byte(&sdata->tb,
>   				sdata->dev, addr[0],
>   				byte_for_channel * num_data_channels,
>
Dratt, I forgot about that.  Will merge with the original patch and push 
out a forced update to the tree.
