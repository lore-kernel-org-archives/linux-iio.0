Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57649 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcACRvt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 12:51:49 -0500
Subject: Re: [PATCH] iio: proximity: lidar: correct return value
To: Matt Ranostay <mranostay@gmail.com>
References: <1451192190-2624-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56895FB2.5040302@kernel.org>
Date: Sun, 3 Jan 2016 17:51:46 +0000
MIME-Version: 1.0
In-Reply-To: <1451192190-2624-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/12/15 04:56, Matt Ranostay wrote:
> lidar_i2c_xfer() function was never a non-positive value on error,
> and this correct that with a -EIO return code.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>

Hmm. Awkward timing on this one.  I'll create a temporary fix
branch for post the merge window closing and send it on to
Greg when appropriate.

This patch could have done with a fixes tag to avoid me having
to look up when this problem was introduced i.e.
Fixes: 366e65633cf4 ("iio: proximity: lidar: optimize i2c transactions")

> ---
>  drivers/iio/proximity/pulsedlight-lidar-lite-v2.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> index 93e29fb..db35e04 100644
> --- a/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> +++ b/drivers/iio/proximity/pulsedlight-lidar-lite-v2.c
> @@ -87,7 +87,7 @@ static int lidar_i2c_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
>  
>  	ret = i2c_transfer(client->adapter, msg, 2);
>  
> -	return (ret == 2) ? 0 : ret;
> +	return (ret == 2) ? 0 : -EIO;
>  }
>  
>  static int lidar_smbus_xfer(struct lidar_data *data, u8 reg, u8 *val, int len)
> 

