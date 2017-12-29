Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:57128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751246AbdL2Rgp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:36:45 -0500
Date: Fri, 29 Dec 2017 17:36:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: add kernel-doc '@owner'
Message-ID: <20171229173640.5fd6e649@archlinux>
In-Reply-To: <1513664270-29523-1-git-send-email-me@tobin.cc>
References: <1513664270-29523-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Dec 2017 17:17:50 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> When building kernel documentation sphinx emits the following warning
> 
> 	warning: No description found for parameter 'owner'
> 
> Add description for struct member 'owner'.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>
> ---
> 
> I couldn't work out what DRIVER/INTERN were for so I took a guess.
Try the other one ;)

They refer to whether the driver should be directly accessing the
field or not.  In the case of owner they shouldn't be so it is INTERN.

Were I writing the subsystem from scratch again I'd probably make the
separation of the two cleaner, but there we are.

Jonathan

> 
>  include/linux/iio/trigger.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/iio/trigger.h b/include/linux/iio/trigger.h
> index 7d5e44518379..d884b5099cd0 100644
> --- a/include/linux/iio/trigger.h
> +++ b/include/linux/iio/trigger.h
> @@ -43,6 +43,7 @@ struct iio_trigger_ops {
>  /**
>   * struct iio_trigger - industrial I/O trigger device
>   * @ops:		[DRIVER] operations structure
> + * @owner:		[DRIVER] owner of this driver module
>   * @id:			[INTERN] unique id number
>   * @name:		[DRIVER] unique name
>   * @dev:		[DRIVER] associated device (if relevant)

