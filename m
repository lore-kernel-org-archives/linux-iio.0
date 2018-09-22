Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbeIVPVJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 22 Sep 2018 11:21:09 -0400
Date: Sat, 22 Sep 2018 10:28:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Song Qiang <songqiang1304521@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        shubhrajyoti@ti.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: magnetometer: hmc5843: Replace a return value.
Message-ID: <20180922102811.7ad29532@archlinux>
In-Reply-To: <20180920134219.8402-1-songqiang1304521@gmail.com>
References: <20180920134219.8402-1-songqiang1304521@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 20 Sep 2018 21:42:19 +0800
Song Qiang <songqiang1304521@gmail.com> wrote:

> This error apparently is caused by timed out event, so a -ETIMEDOUT
> should be used instead of a -EIO, and it also tells user what happened
> , so this dev_err may not be needed anymore.
> 
> Signed-off-by: Song Qiang <songqiang1304521@gmail.com>
> ---
> I used ./scripts/get_maintainer.pl to get maintainers about this file,
> I thought this script searches maintainers with looking up MAINTAINER,
> is that right?
> So I searched MAINTAINER and also found nothing related to hmc5843.
> In the declearation area I can see Shubhrajyoti Datta 
> <shubhrajyoti@ti.com> wroted this driver and several other people
> including Peter Meerwald have contributed. Is this driver now a orphan?
> Or if it is, I think we may also need to add it to the MAINTAINER file.
> I'm also familiar with this device, I think I can add interrupt support
> later.

Those drivers not covered by more explicit MAINTAINER entries are
picked up by the main IIO one.  Of course if you are working in a
significant way with the driver and want to adopt it, then post
a patch adding a MAINTAINERS entry and see if any of the previous
significant contributors mind (or potentially want to co-maintain it).

> 
>  drivers/iio/magnetometer/hmc5843_core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/hmc5843_core.c b/drivers/iio/magnetometer/hmc5843_core.c
> index ada142fb7aa3..4fb393c3854c 100644
> --- a/drivers/iio/magnetometer/hmc5843_core.c
> +++ b/drivers/iio/magnetometer/hmc5843_core.c
> @@ -170,8 +170,7 @@ static int hmc5843_wait_measurement(struct hmc5843_data *data)
>  	}
>  
>  	if (tries < 0) {
> -		dev_err(data->dev, "data not ready\n");
> -		return -EIO;
> +		return -ETIMEDOUT;

I'd say no on this one as I suspect such a timeout only indicates a
communication problem, not some delay in the hardware managing to
return an answer..

It's certainly not a clear enough reason to my mind to argue for changing
the error code (which it is just possible some less than ideal userspace
code is relying on).

Jonathan

>  	}
>  
>  	return 0;
