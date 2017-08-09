Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752432AbdHINfZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 9 Aug 2017 09:35:25 -0400
Date: Wed, 9 Aug 2017 14:35:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-iio@vger.kernel.org
Subject: Re: PATCH] iio: Fix some documentation warnings
Message-ID: <20170809143516.70912657@archlinux>
In-Reply-To: <20170730161442.0fc96691@lwn.net>
References: <20170730161442.0fc96691@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 30 Jul 2017 16:14:42 -0600
Jonathan Corbet <corbet@lwn.net> wrote:

> The kerneldoc description for the trig_readonly field of struct iio_dev
> lacked a colon, leading to this doc build warning:
> 
>   ./include/linux/iio/iio.h:603: warning: No description found for parameter 'trig_readonly'
> 
> A similar issue for iio_trigger_set_immutable() in trigger.h yielded:
> 
>   ./include/linux/iio/trigger.h:151: warning: No description found for parameter 'indio_dev'
>   ./include/linux/iio/trigger.h:151: warning: No description found for parameter 'trig'
> 
> Fix the formatting and silence the warnings.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> ---
>  include/linux/iio/iio.h     | 2 +-
>  include/linux/iio/trigger.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index d68bec297a45..c380daa40c0e 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -535,7 +535,7 @@ struct iio_buffer_setup_ops {
>   * @scan_timestamp:	[INTERN] set if any buffers have requested timestamp
>   * @scan_index_timestamp:[INTERN] cache of the index to the timestamp
>   * @trig:		[INTERN] current device trigger (buffer modes)
> - * @trig_readonly	[INTERN] mark the current trigger immutable
> + * @trig_readonly:	[INTERN] mark the current trigger immutable
>   * @pollfunc:		[DRIVER] function run on trigger being received
>   * @pollfunc_event:	[DRIVER] function run on events trigger being received
>   * @channels:		[DRIVER] channel specification structure table
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index ea08302f2d7b..7142d8d6e470 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -144,8 +144,8 @@ void devm_iio_trigger_unregister(struct device *dev,
>  /**
>   * iio_trigger_set_immutable() - set an immutable trigger on destination
>   *
> - * @indio_dev - IIO device structure containing the device
> - * @trig - trigger to assign to device
> + * @indio_dev: IIO device structure containing the device
> + * @trig: trigger to assign to device
>   *
>   **/
>  int iio_trigger_set_immutable(struct iio_dev *indio_dev, struct iio_trigger *trig);

