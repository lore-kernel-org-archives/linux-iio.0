Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:54061 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753318AbcJPNlw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 16 Oct 2016 09:41:52 -0400
Subject: Re: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: cleanup power
 management
To: Matt Ranostay <mranostay@gmail.com>, linux-iio@vger.kernel.org
References: <1476554677-1777-1-git-send-email-matt@ranostay.consulting>
Cc: Matt Ranostay <matt@ranostay.consulting>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <4e53b4e7-6529-f120-29aa-f0ab20d0a353@kernel.org>
Date: Sun, 16 Oct 2016 14:41:48 +0100
MIME-Version: 1.0
In-Reply-To: <1476554677-1777-1-git-send-email-matt@ranostay.consulting>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 15/10/16 19:04, Matt Ranostay wrote:
> Remove pm_runtime_mark_last_busy() call that wasn't need in the probe
> since the device should be put to sleep
> 
> Signed-off-by: Matt Ranostay <matt@ranostay.consulting>
Hi Matt,

I don't really follow what you are addressing here.
Is the point that without this call it will suspend immediately?
I could figure this out from the pm docs based on a quick skim
read.

Or is it simply that the pm_runtime_idle call following it
will suspend immediately whatever this value contains?


Jonathan
> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 3141c3c161bb..1fa9eefa0982 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -301,8 +301,6 @@ static int lidar_probe(struct i2c_client *client,
>  	if (ret)
>  		goto error_unreg_buffer;
>  	pm_runtime_enable(&client->dev);
> -
> -	pm_runtime_mark_last_busy(&client->dev);
>  	pm_runtime_idle(&client->dev);
>  
>  	return 0;
> 

