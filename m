Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51732 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755518AbbDILwt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:52:49 -0400
Message-ID: <55266816.10907@kernel.org>
Date: Thu, 09 Apr 2015 12:52:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] iio: accel: mma9553: add enable channel for activity
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-9-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-9-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> Since we need to specifically power on the device if used
> in polling mode, we have an enable channel for each type
> (step count, distance, speed, calories, etc.).
> 
> Add also an enable channel for activity, so it can also
> be polled independenly of events or other channels.
> 
typo - independently

> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Daniel Baluta <daniel.baluta@intel.com>
For the ones that are bug fixes wants to be reported-by
to get correctly picked up in the gitdm stats etc.

Again, this looks to be a fix to me so up the top of the series
please.

J
> ---
>  drivers/iio/accel/mma9553.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 6991b01..1359985 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -942,7 +942,8 @@ static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
>  	.modified = 1,							\
>  	.channel2 = _chan2,						\
>  	.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBHEIGHT),	\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_CALIBHEIGHT) |	\
> +				    BIT(IIO_CHAN_INFO_ENABLE),		\
>  	.event_spec = mma9553_activity_events,				\
>  	.num_event_specs = ARRAY_SIZE(mma9553_activity_events),		\
>  	.ext_info = mma9553_ext_info,					\
> 

