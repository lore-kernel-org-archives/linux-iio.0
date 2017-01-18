Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from userp1040.oracle.com ([156.151.31.81]:45387 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751336AbdARJ5T (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 18 Jan 2017 04:57:19 -0500
Date: Wed, 18 Jan 2017 12:56:29 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Alison Schofield <amsfield22@gmail.com>
Cc: jic23@kernel.org, devel@driverdev.osuosl.org, lars@metafoo.de,
        Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        pmeerw@pmeerw.net, knaack.h@gmx.de
Subject: Re: [PATCH] iio: trigger: free trigger resource correctly
Message-ID: <20170118095629.GA4454@mwanda>
References: <20170118030016.GA23724@d830.WORKGROUP>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170118030016.GA23724@d830.WORKGROUP>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, Jan 17, 2017 at 07:00:28PM -0800, Alison Schofield wrote:
> Using iio_trigger_put() to free a trigger leads to release of
> a resource we never held.  Replace with iio_trigger_free().

They're basically the same except iio_trigger_put() puts the module and
the device and free only puts the device.

I've looked at this briefly, but I can't figure out how iio_trigger_get/
iio_trigger_put is supposed to be used.  There isn't any documentation.
I'm trying to review this code, but I can't figure out where we *are*
supposed to be doing the put.

For example, iio_device_unregister_trigger_consumer() takes a put, but
iio_device_register_trigger_consumer() doesn't do a get...  It's all
very confusing.

You seem like you know what's going on.  Can we get some documentation?

> 
> Signed-off-by: Alison Schofield <amsfield22@gmail.com>
> ---
> Patches to use devm_* funcs are ready to follow this for
> the interrupt & bfin-timer triggers.
> 
>  drivers/iio/trigger/iio-trig-interrupt.c          | 4 ++--
>  drivers/iio/trigger/iio-trig-sysfs.c              | 2 +-
>  drivers/staging/iio/trigger/iio-trig-bfin-timer.c | 4 ++--
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/trigger/iio-trig-interrupt.c b/drivers/iio/trigger/iio-trig-interrupt.c
> index 572bc6f..b18e50d 100644
> --- a/drivers/iio/trigger/iio-trig-interrupt.c
> +++ b/drivers/iio/trigger/iio-trig-interrupt.c
> @@ -84,7 +84,7 @@ static int iio_interrupt_trigger_probe(struct platform_device *pdev)
>  error_free_trig_info:
>  	kfree(trig_info);
>  error_put_trigger:
> -	iio_trigger_put(trig);
> +	iio_trigger_free(trig);


We could rename this label.

regards,
dan carpenter

