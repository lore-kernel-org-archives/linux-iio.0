Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:33735 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab2FLNhk (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jun 2012 09:37:40 -0400
Message-ID: <4FD74620.9000205@kernel.org>
Date: Tue, 12 Jun 2012 14:37:36 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Peter Meerwald <pmeerw@pmeerw.net>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/4] iio: fix typos in iio.h
References: <1339507788-2931-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1339507788-2931-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 6/12/2012 2:29 PM, Peter Meerwald wrote:
> From: Peter Meerwald<p.meerwald@bct-electronic.com>
>
> v2:
> * "used in in-kernel" (Jonathan Cameron)
>
> Signed-off-by: Peter Meerwald<pmeerw@pmeerw.net>
Acked-by: Jonathan Cameron <jic23@kernel.org>
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
> + * @datasheet_name:	A name used in in-kernel mapping of channels. It should
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

