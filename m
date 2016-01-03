Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57679 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751117AbcACR5r (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 3 Jan 2016 12:57:47 -0500
Subject: Re: [PATCH] iio: chemical: vz89x: correct xfer return value
To: Matt Ranostay <mranostay@gmail.com>
References: <1451193090-3625-1-git-send-email-mranostay@gmail.com>
Cc: linux-iio@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <5689611A.1000409@kernel.org>
Date: Sun, 3 Jan 2016 17:57:46 +0000
MIME-Version: 1.0
In-Reply-To: <1451193090-3625-1-git-send-email-mranostay@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/12/15 05:11, Matt Ranostay wrote:
> vz89x_i2c_xfer() function was never returning a non-positive value on
> error, and this patch corrects that with a -EIO return code.
> 
> Also the error condition was incorrect since it was against measurement
> size and not the i2c messages send/received count.
> 
> Signed-off-by: Matt Ranostay <mranostay@gmail.com>
This doesn't apply to the current tree as we already have
an 'incorrect' fix in place for the value being compared against below.

J
> ---
>  drivers/iio/chemical/vz89x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/chemical/vz89x.c b/drivers/iio/chemical/vz89x.c
> index c3367aa..0666919 100644
> --- a/drivers/iio/chemical/vz89x.c
> +++ b/drivers/iio/chemical/vz89x.c
> @@ -120,7 +120,7 @@ static int vz89x_i2c_xfer(struct vz89x_data *data, u8 cmd)
>  
>  	ret = i2c_transfer(client->adapter, msg, 2);
>  
> -	return (ret == VZ89X_REG_MEASUREMENT_SIZE) ? 0 : ret;
> +	return (ret == 2) ? 0 : -EIO;
>  }
>  
>  static int vz89x_smbus_xfer(struct vz89x_data *data, u8 cmd)
> 

