Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:53775 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964850AbcJVRcL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Oct 2016 13:32:11 -0400
Subject: Re: [PATCH 7/7] iio: light: tsl2583: fix concurrency issue in
 taos_get_lux()
To: Brian Masney <masneyb@onstation.org>
References: <1476873130-24926-1-git-send-email-masneyb@onstation.org>
 <1476873130-24926-7-git-send-email-masneyb@onstation.org>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <90d80d86-7e1b-ea97-6801-174a6cf438e8@kernel.org>
Date: Sat, 22 Oct 2016 18:32:09 +0100
MIME-Version: 1.0
In-Reply-To: <1476873130-24926-7-git-send-email-masneyb@onstation.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 19/10/16 11:32, Brian Masney wrote:
> taos_get_lux() calls mutex_trylock(). If the lock could not be acquired,
> then chip->als_cur_info.lux is returned. The issue is that this value
> is updated while the mutex is held and could cause a half written value
> to be returned to the caller. This patch changes the call to
> mutex_trylock() with mutex_lock().
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
I'd go with the simple approach you have here.

If someone cares enough they can figure out the complex solution.  Probably
should be pushed off to userspace.  It's not unusual for devices to take
'a little while' to respond to sysfs reads.

Jonathan
> ---
> This is the most controversial change in my patch set. There are two
> other possible solutions that I could envision to work around this
> issue:
> 
> 1) Return -EBUSY and make the caller responsible for backing off
> 2) Change this driver to use RCU instead of a mutex
> 
>  drivers/staging/iio/light/tsl2583.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2583.c b/drivers/staging/iio/light/tsl2583.c
> index 47656ae..c4d2e3a 100644
> --- a/drivers/staging/iio/light/tsl2583.c
> +++ b/drivers/staging/iio/light/tsl2583.c
> @@ -206,10 +206,7 @@ static int taos_get_lux(struct iio_dev *indio_dev)
>  	u32 ch0lux = 0;
>  	u32 ch1lux = 0;
>  
> -	if (mutex_trylock(&chip->als_mutex) == 0) {
> -		dev_info(&chip->client->dev, "taos_get_lux device is busy\n");
> -		return chip->als_cur_info.lux; /* busy, so return LAST VALUE */
> -	}
> +	mutex_lock(&chip->als_mutex);
>  
>  	if (chip->taos_chip_status != TSL258X_CHIP_WORKING) {
>  		/* device is not enabled */
> 

