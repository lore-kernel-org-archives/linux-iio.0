Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60719 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756152AbaCOQ0u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 15 Mar 2014 12:26:50 -0400
Message-ID: <53247F85.9020301@kernel.org>
Date: Sat, 15 Mar 2014 16:27:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: Lars-Peter Clausen <lars@metafoo.de>,
	Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] iio:core: Fix bug in length of event info_mask and catch
 unhandled bits set in masks.
References: <1393712687-8407-1-git-send-email-jic23@kernel.org>
In-Reply-To: <1393712687-8407-1-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/03/14 22:24, Jonathan Cameron wrote:
> The unhandled bits case was highlighted by smatch:
>    CHECK   drivers/iio/industrialio-core.c
> drivers/iio/industrialio-core.c:719 iio_device_add_info_mask_type() error: buffer overflow 'iio_chan_info_postfix' 17 <= 31
>    CC [M]  drivers/iio/industrialio-core.o
>    CHECK   drivers/iio/industrialio-event.c
> drivers/iio/industrialio-event.c:327 iio_device_add_event() error: buffer overflow 'iio_ev_info_text' 3 <= 3
>
> The incorrect limit for the for_each_set_bit loop was noticed whilst fixing
> this other case.  Note that as we only have 3 possible entries a the moment
> and the value was set to 4, the bug would not have any effect currently.
> It will bite fairly soon though, so best fix it now.
>
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
Executive descision time :) Applied to the togreg branch of iio.git
as clearly no one cares.
> ---
>   drivers/iio/industrialio-core.c  | 2 ++
>   drivers/iio/industrialio-event.c | 4 +++-
>   2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index ede16aec..e4961b1 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -716,6 +716,8 @@ static int iio_device_add_info_mask_type(struct iio_dev *indio_dev,
>   	int i, ret, attrcount = 0;
>
>   	for_each_set_bit(i, infomask, sizeof(infomask)*8) {
> +		if (i >= ARRAY_SIZE(iio_chan_info_postfix))
> +			return -EINVAL;
>   		ret = __iio_add_chan_devattr(iio_chan_info_postfix[i],
>   					     chan,
>   					     &iio_read_channel_info,
> diff --git a/drivers/iio/industrialio-event.c b/drivers/iio/industrialio-event.c
> index ea6e06b..dddfb0f 100644
> --- a/drivers/iio/industrialio-event.c
> +++ b/drivers/iio/industrialio-event.c
> @@ -321,7 +321,9 @@ static int iio_device_add_event(struct iio_dev *indio_dev,
>   	char *postfix;
>   	int ret;
>
> -	for_each_set_bit(i, mask, sizeof(*mask)) {
> +	for_each_set_bit(i, mask, sizeof(*mask)*8) {
> +		if (i >= ARRAY_SIZE(iio_ev_info_text))
> +			return -EINVAL;
>   		postfix = kasprintf(GFP_KERNEL, "%s_%s_%s",
>   				iio_ev_type_text[type], iio_ev_dir_text[dir],
>   				iio_ev_info_text[i]);
>

