Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:56454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdL2Re7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:34:59 -0500
Date: Fri, 29 Dec 2017 17:34:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Tobin C. Harding" <me@tobin.cc>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: fix SPHINX kernel-docs build warning
Message-ID: <20171229173454.0533ec34@archlinux>
In-Reply-To: <1513663175-25163-1-git-send-email-me@tobin.cc>
References: <1513663175-25163-1-git-send-email-me@tobin.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 19 Dec 2017 16:59:35 +1100
"Tobin C. Harding" <me@tobin.cc> wrote:

> When building kernel documentation sphinx emits the following warnings
> 
> No description found for parameter 'iio_dev'
> Excess function parameter 'indio_dev' description in 'iio_device_register'
> 
> These warnings are caused by a macro with a different argument identifier to the
> one listed in the kernel-docs.
> 
> Change macro argument to be the same as the docs.
> 
> Signed-off-by: Tobin C. Harding <me@tobin.cc>

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  include/linux/iio/iio.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 20b61347ea58..1234e5571d45 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -606,8 +606,8 @@ const struct iio_chan_spec
>   * iio_device_register() - register a device with the IIO subsystem
>   * @indio_dev:		Device structure filled by the device driver
>   **/
> -#define iio_device_register(iio_dev) \
> -	__iio_device_register((iio_dev), THIS_MODULE)
> +#define iio_device_register(indio_dev) \
> +	__iio_device_register((indio_dev), THIS_MODULE)
>  int __iio_device_register(struct iio_dev *indio_dev, struct module *this_mod);
>  void iio_device_unregister(struct iio_dev *indio_dev);
>  /**

