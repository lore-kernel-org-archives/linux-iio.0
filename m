Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42494 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbbDZSmx (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:42:53 -0400
Message-ID: <553D31AB.7000004@kernel.org>
Date: Sun, 26 Apr 2015 19:42:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 04/17] iio: accel: mma9553: add enable channel for
 activity
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-5-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-5-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
Err, this first bit is not relevant to this patch so I've dropped it.
> Since we need to specifically power on the device if used
> in polling mode, we have an enable channel for each type
> (step count, distance, speed, calories, etc.).
> 
> Add also an enable channel for activity, so it can also
> be polled independently of events or other channels.
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Reported-by: Daniel Baluta <daniel.baluta@intel.com>
Applied to the fixes-togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/accel/mma9553.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 03120fb..365a109 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -972,7 +972,8 @@ static const struct iio_chan_spec_ext_info mma9553_ext_info[] = {
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

