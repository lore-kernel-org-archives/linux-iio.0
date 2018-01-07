Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753897AbeAGQNb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 7 Jan 2018 11:13:31 -0500
Date: Sun, 7 Jan 2018 16:13:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: add kernel-doc for field @owner
Message-ID: <20180107161327.241e6eec@archlinux>
In-Reply-To: <1515275766-31302-2-git-send-email-me@tobin.cc>
References: <1515275766-31302-1-git-send-email-me@tobin.cc>
        <1515275766-31302-2-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun,  7 Jan 2018 08:56:05 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> When building kernel documentation sphinx emits the following warning
> 
> 	warning: No description found for parameter 'owner'
> 
> Add description for struct member 'owner'.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  include/linux/iio/trigger.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 7d5e44518379..390789d43369 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -43,6 +43,7 @@ struct iio_trigger_ops {
>  /**
>   * struct iio_trigger - industrial I/O trigger device
>   * @ops:		[DRIVER] operations structure
> + * @owner:		[INTERN] owner of this driver module
>   * @id:			[INTERN] unique id number
>   * @name:		[DRIVER] unique name
>   * @dev:		[DRIVER] associated device (if relevant)

