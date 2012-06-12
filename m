Return-Path: <jic23@cam.ac.uk>
Message-ID: <4FD73C3B.6060906@cam.ac.uk>
Date: Tue, 12 Jun 2012 13:55:23 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH RESEND 1/4] iio: fix typos in iio.h
References: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339504946-16171-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 6/12/2012 1:42 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
One comemnt inline...
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
>
> ---
>   include/linux/iio/iio.h |    6 +++---
>   1 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 944c635..9d9b55a 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -131,7 +131,7 @@ struct iio_chan_spec_ext_info {
>
>   /**
>    * struct iio_enum - Enum channel info attribute
> - * items: A array of strings.
> + * items: An array of strings.
>    * num_items: Length of the item array.
>    * set: Set callback function, may be NULL.
>    * get: Get callback function, may be NULL.
> @@ -218,7 +218,7 @@ ssize_t iio_enum_write(struct iio_dev *indio_dev,
>    * @extend_name:	Allows labeling of channel attributes with an
>    *			informative name. Note this has no effect codes etc,
>    *			unlike modifiers.
> - * @datasheet_name:	A name used in in kernel mapping of channels. It should
in in-kernel would be preferable.
> + * @datasheet_name:	A name used in kernel mapping of channels. It should
>    *			correspond to the first name that the channel is referred
>    *			to by in the datasheet (e.g. IND), or the nearest
>    *			possible compound name (e.g. IND-INC).
> @@ -393,7 +393,7 @@ struct iio_buffer_setup_ops {
>    * @trig:		[INTERN] current device trigger (buffer modes)
>    * @pollfunc:		[DRIVER] function run on trigger being received
>    * @channels:		[DRIVER] channel specification structure table
> - * @num_channels:	[DRIVER] number of chanels specified in @channels.
> + * @num_channels:	[DRIVER] number of channels specified in @channels.
>    * @channel_attr_list:	[INTERN] keep track of automatically created channel
>    *			attributes
>    * @chan_attr_group:	[INTERN] group for all attrs in base directory
