Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751568AbdLBLnm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Dec 2017 06:43:42 -0500
Date: Sat, 2 Dec 2017 11:43:38 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: dummy_evgen: modify the return value check for
 irq_sim_init()
Message-ID: <20171202114338.58c077dc@archlinux>
In-Reply-To: <20171127105449.27535-1-brgl@bgdev.pl>
References: <20171127105449.27535-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 27 Nov 2017 11:54:49 +0100
Bartosz Golaszewski <brgl@bgdev.pl> wrote:

> As discussed with Marc Zyngier: irq_sim_init() and its devres variant
> should return the base of the allocated interrupt range on success
> rather than 0. This will be modified later - first, change the way
> users handle the return value of these routines.
> 
> Signed-off-by: Bartosz Golaszewski <brgl@bgdev.pl>
I'm happy to take this but if it goes via my tree whilst the
other changes take a different path you are going to slow things
down considerably (a kernel cycle for this change to be in the
upstream of where the fix gets applied).  So I would bundle
it up in a single patch set with the more major changes.

If you still want me to take it let me know, but if it
might go via another route then

Acked-by: Jonathan Cameron <jonathan.cameron@huawei.com>

Thanks,

Jonathan
> ---
>  drivers/iio/dummy/iio_dummy_evgen.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dummy/iio_dummy_evgen.c b/drivers/iio/dummy/iio_dummy_evgen.c
> index fe8884543da0..efd0005f59b4 100644
> --- a/drivers/iio/dummy/iio_dummy_evgen.c
> +++ b/drivers/iio/dummy/iio_dummy_evgen.c
> @@ -56,7 +56,7 @@ static int iio_dummy_evgen_create(void)
>  		return -ENOMEM;
>  
>  	ret = irq_sim_init(&iio_evgen->irq_sim, IIO_EVENTGEN_NO);
> -	if (ret) {
> +	if (ret < 0) {
>  		kfree(iio_evgen);
>  		return ret;
>  	}

