Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:52044 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932238AbaLDOXR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 4 Dec 2014 09:23:17 -0500
Received: by mail-wg0-f42.google.com with SMTP id z12so22786433wgg.1
        for <linux-iio@vger.kernel.org>; Thu, 04 Dec 2014 06:23:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417024517-7564-7-git-send-email-lars@metafoo.de>
References: <1417024517-7564-1-git-send-email-lars@metafoo.de>
	<1417024517-7564-7-git-send-email-lars@metafoo.de>
Date: Thu, 4 Dec 2014 16:23:16 +0200
Message-ID: <CAEnQRZBX9XAhaD=DXj5QhBGAtFgdpsa6h_YyPWurPAUfjyJ-5A@mail.gmail.com>
Subject: Re: [PATCH 06/11] iio: Move buffer registration to the core
From: Daniel Baluta <daniel.baluta@intel.com>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, Nov 26, 2014 at 7:55 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Originally device and buffer registration were kept as separate operations
> in IIO to allow to register two distinct sets of channels for buffered and
> non-buffered operations. This has since already been further restricted and
> the channel set registered for the buffer needs to be a subset of the
> channel set registered for the device. Additionally the possibility to not
> have a raw (or processed) attribute for a channel which was registered for
> the device was added a while ago. This means it is possible to not register
> any device level attributes for a channel even if it is registered for the
> device. Also if a channel's scan_index is set to -1 and the channel is
> registered for the buffer it is ignored.
>
> So in summery it means it is possible to register the same channel array for

s/summery/summary

> both the device and the buffer yet still end up with distinctive sets of
> channels for both of them. This makes the argument for having to have to
> manually register the channels for both the device and the buffer invalid.
> Considering that the vast majority of all drivers want to register the same
> set of channels for both the buffer and the device it makes sense to move
> the buffer registration into the core to avoid some boiler-plate code in the
> device driver setup path.
>
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---

<snip>

> diff --git a/drivers/iio/industrialio-triggered-buffer.c b/drivers/iio/industrialio-triggered-buffer.c
> index d6f54930..ac97685 100644
> --- a/drivers/iio/industrialio-triggered-buffer.c
> +++ b/drivers/iio/industrialio-triggered-buffer.c
> @@ -78,16 +78,8 @@ int iio_triggered_buffer_setup(struct iio_dev *indio_dev,

You should also update the comment for iio_triggered_buffer_setup. This function
doesn't register the buffer with IIO core anymore.


>         /* Flag that polled ring buffering is possible */
>         indio_dev->modes |= INDIO_BUFFER_TRIGGERED;
>
> -       ret = iio_buffer_register(indio_dev,
> -                                 indio_dev->channels,
> -                                 indio_dev->num_channels);
> -       if (ret)
> -               goto error_dealloc_pollfunc;
> -
>         return 0;

<snip>

thanks,
Daniel.
